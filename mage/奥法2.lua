if variable == nil then variable = {};end
if variable.burntime == nil then variable.burntime = GetTime();end
if variable.average_burn_length == nil or variable.average_burn_length >= 60 then variable.average_burn_length = 10;end

gcd = getGCD()

arcane_power                = 12042
evocation                   = 12051
charged_up                  = 205032
mirror_image                = 55342
nether_tempest              = 114923
rune_of_power_buff          = 116014
rune_of_power               = 116011
rule_of_threes              = 264774
arcane_blast                = 30451
lights_judgment             = 247427
presence_of_mind            = 205025
arcane_orb                  = 153626
arcane_barrage              = 44425
arcane_explosion            = 1449
clearcasting                = 263725
arcane_pummeling            = 270669
arcane_missiles             = 5143
supernova                   = 157980

function AzeriteRanks(ids)
    -- body
    local ranks = 0
    local azeritetable = getMyAzeriteTraits()
    return azeritetable[ids]
end

local function full_recharge_time(spellID)
    local charges,maxCharges,chargeStart,chargeDuration = GetSpellCharges(spellID)
    if charges then
        if charges < maxCharges and maxCharges - charges < 1 then
            chargeEnd = chargeStart + chargeDuration
            return chargeEnd - GetTime()
        end
        if maxCharges - charges > 1 then
            chargeEnd = chargeStart + chargeDuration
            return chargeEnd - GetTime() + chargeDuration
        end
        return 0
    end
end


-- talents=2032021

-- # Default consumables
-- potion=battle_potion_of_intellect
-- flask=endless_fathoms
-- food=bountiful_captains_feast
-- augmentation=battle_scarred

-- # This default action priority list is automatically created based on your character.
-- # It is a attempt to provide you with a action list that is both simple and practicable,
-- # while resulting in a meaningful and good simulation. It may not result in the absolutely highest possible dps.
-- # Feel free to edit, adapt and improve it to your own needs.
-- # SimulationCraft is always looking for updates and improvements to the default action lists.

-- # Executed before combat begins. Accepts non-harmful actions only.
-- actions.precombat=flask
-- actions.precombat+=/food
-- actions.precombat+=/augmentation
-- actions.precombat+=/arcane_intellect
-- actions.precombat+=/arcane_familiar
-- # conserve_mana is the mana percentage we want to go down to during conserve. It needs to leave enough room to worst case scenario spam AB only during AP.
-- actions.precombat+=/variable,name=
variable.conserve_mana = 60
-- actions.precombat+=/snapshot_stats
-- actions.precombat+=/mirror_image
-- actions.precombat+=/potion
-- actions.precombat+=/arcane_blast
burn_phase = getSpellCD(arcane_power) == 0 and getSpellCD(evocation) <= variable.average_burn_length and ( UnitPower("player",16) == UnitPowerMax("player",16) or ( getTalent(4,2) and getSpellCD(charged_up) == 0 ))

-- actions+=/call_action_list,name=movement
if isMoving("player") then
    self:movement()
end
-- # Executed every time the actor is available.
-- # Interrupt the boss when possible.
-- actions=counterspell,if=target.debuff.casting.react
-- # Go to Burn Phase when already burning, or when boss will die soon.
-- actions+=/call_action_list,name=burn,if=burn_phase|target.time_to_die<variable.average_burn_length
if burn_phase --[[ or getTimeToDie(tg) < variable.average_burn_length ]] then
    if variable.burntime == 0 then
        variable.burntime = GetTime()
    end
    self:burn()
end
-- # Start Burn Phase when Arcane Power is ready and Evocation will be ready (on average) before the burn phase is over. Also make sure we got 4 Arcane Charges, or can get 4 Arcane Charges with Charged Up.
-- actions+=/call_action_list,name=burn,if=(cooldown.arcane_power.remains=0&cooldown.evocation.remains<=variable.average_burn_length&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|(talent.charged_up.enabled&cooldown.charged_up.remains=0&buff.arcane_charge.stack<=1)))
if ( getSpellCD(arcane_power) == 0 and getSpellCD(evocation) <= variable.average_burn_length and ( UnitPower("player",16) ==  UnitPowerMax("player",16) or ( getTalent(4,2) and getSpellCD(charged_up) == 0 and UnitPower("player",16) <=1 ))) then
    if variable.burntime == 0 then
        variable.burntime = GetTime()
    end
    self:burn()
end
-- actions+=/call_action_list,name=conserve,if=!burn_phase
if  not burn_phase then
    if variable.burntime ~= 0 or variable.average_burn_length == 10 then
        -- body
        if count == nil then count = 0;end        
        variable.average_burn_length = (variable.average_burn_length*count + GetTime() - variable.burntime)/(count+1)
        count = count+1
    end    
    variable.burntime = 0
    self:conserve()
end


function rotation:burn(args)
    -- # Increment our burn phase counter. Whenever we enter the `burn` actions without being in a burn phase, it means that we are about to start one.
    -- actions.burn=variable,name=total_burns,op=add,value=1,if=!burn_phase
    if not variable.total_burns then variable.total_burns = 0;end
    if not burn_phase then
        variable.total_burns = variable.total_burns + 1
    end
    -- actions.burn+=/start_burn_phase,if=!burn_phase
    if  not burn_phase then
        start_burn_phase = true
        stop_burn_phase = false
    end
    -- # End the burn phase when we just evocated.
    -- actions.burn+=/stop_burn_phase,if=burn_phase&prev_gcd.1.evocation&target.time_to_die>variable.average_burn_length&burn_phase_duration>0
    if burn_phase and getLastSpell() == evocation and getTimeToDie(tg) > variable.average_burn_length and burn_phase_duration > 0 then
        stop_burn_phase = true
        start_burn_phase = false
    end

    -- # Less than 1 instead of equals to 0, because of pre-cast Arcane Blast
    -- actions.burn+=/charged_up,if=buff.arcane_charge.stack<=1 
    if UnitPower("player",16) <= 1 then
        if canCast(charged_up) and castSpell("player",charged_up) then
            if ydebug.is_enabled then
                print(201)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/mirror_image
    if canCast(mirror_image) and castSpell("player",mirror_image) then
        if ydebug.is_enabled then
            print(202)
            return 0
        else
            return 0
        end
    end
    -- actions.burn+=/nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down
    if ( getDebuffRemain(tg,nether_tempest) <= 3 ) and UnitPower("player",16) ==  UnitPowerMax("player",16) and getBuffRemain("player",rune_of_power_buff) <= 0 and  getBuffRemain("player",arcane_power) <= 0 then
        if canCast(nether_tempest) and castSpell(tg,nether_tempest) then
            if ydebug.is_enabled then
                print(203)
                return 0
            else
                return 0
            end
        end
    end
    -- # When running Overpowered, and we got a Rule of Threes proc (AKA we got our 4th Arcane Charge via Charged Up), use it before using RoP+AP, because the mana reduction is otherwise largely wasted since the AB was free anyway.
    -- actions.burn+=/arcane_blast,if=buff.rule_of_threes.up&talent.overpowered.enabled&active_enemies<3
    if getBuffRemain("player", rule_of_threes) > 0 and getTalent(7,1) and active_enemies < 3 then
        if canCast(arcane_blast) and castSpell(tg,arcane_blast) then
            if ydebug.is_enabled then
                print(204)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/lights_judgment,if=buff.arcane_power.down
    -- actions.burn+=/rune_of_power,if=!buff.arcane_power.up&(mana.pct>=50|cooldown.arcane_power.remains=0)&(buff.arcane_charge.stack=buff.arcane_charge.max_stack)
    if not (getBuffRemain("player",arcane_power) > 0) and ( getMana("player") >= 50 or getSpellCD(arcane_power) == 0 ) and ( UnitPower("player",16) == UnitPowerMax("player",16) ) then
        if getCharges(rune_of_power) >= 1 and not UnitBuffID("player",rune_of_power_buff) and castSpell("player",rune_of_power) then
            if ydebug.is_enabled then
                print(205)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/berserking
    -- actions.burn+=/arcane_power
    -- actions.burn+=/use_items,if=buff.arcane_power.up|target.time_to_die<cooldown.arcane_power.remains
    -- actions.burn+=/blood_fury
    -- actions.burn+=/fireblood
    -- actions.burn+=/ancestral_call
    -- actions.burn+=/presence_of_mind,if=buff.rune_of_power.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time|buff.arcane_power.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time
    if getBuffRemain("player",rune_of_power_buff) <= 2*getCastTime(arcane_blast) or getBuffRemain("player",arcane_power) <= 2*getCastTime(arcane_blast) then
        if canCast(presence_of_mind) and castSpell("player",presence_of_mind) then
            if ydebug.is_enabled then
                print(206)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/potion,if=buff.arcane_power.up&(buff.berserking.up|buff.blood_fury.up|!(race.troll|race.orc))

    -- actions.burn+=/arcane_orb,if=buff.arcane_charge.stack=0|(active_enemies<3|(active_enemies<2&talent.resonance.enabled))
    if UnitPower("player",16) == 0 or ( active_enemies < 3 or ( active_enemies < 2 and getTalent(4,1) )) then
        if canCast(arcane_orb) and castSpell(tg,arcane_orb) then
            if ydebug.is_enabled then
                print(207)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/arcane_barrage,if=active_enemies>=3&(buff.arcane_charge.stack=buff.arcane_charge.max_stack)
    if active_enemies >= 3 and ( UnitPower("player",16) ==  UnitPowerMax("player",16) ) then
        if canCast(arcane_barrage) and castSpell(tg,arcane_barrage) then
            if ydebug.is_enabled then
                print(208)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/arcane_explosion,if=active_enemies>=3
    if active_enemies >= 3 then
        if canCast(arcane_explosion) and castSpell(tg,arcane_explosion) then
            if ydebug.is_enabled then
                print(209)
                return 0
            else
                return 0
            end
        end
    end
    -- # Ignore Arcane Missiles during Arcane Power, aside from some very specific exceptions, like not having Overpowered talented & running 3x Arcane Pummeling.
    -- actions.burn+=/arcane_missiles,if=buff.clearcasting.react&active_enemies<3&(talent.amplification.enabled|(!talent.overpowered.enabled&azerite.arcane_pummeling.rank>=2)|buff.arcane_power.down),chain=1 
    if getBuffRemain("player",clearcasting) > 0 and active_enemies < 3 and ( getTalent(1,1) or ( not  getTalent(7,1) and AzeriteRanks(arcane_pummeling) >= 2 ) or getBuffRemain("player",arcane_power) <= 0) then
        if canCast(arcane_missiles) and castSpell(tg,arcane_missiles) then
            if ydebug.is_enabled then
                print(210)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.burn+=/arcane_blast,if=active_enemies<3
    if active_enemies<3 then
        if canCast(arcane_blast) and castSpell(tg,arcane_blast) then
            if ydebug.is_enabled then
                print(211)
                return 0
            else
                return 0
            end
        end
    end
    -- # Now that we're done burning, we can update the average_burn_length with the length of this burn.
    -- actions.burn+=/variable,name=average_burn_length,op=set,value=(variable.average_burn_length*variable.total_burns-variable.average_burn_length+(burn_phase_duration))%variable.total_burns
    
    -- actions.burn+=/evocation,interrupt_if=mana.pct>=85,interrupt_immediate=1
    -- # For the rare occasion where we go oom before evocation is back up. (Usually because we get very bad rng so the burn is cut very short)
    -- actions.burn+=/arcane_barrage
    if canCast(arcane_barrage) and castSpell(tg,arcane_barrage) then
        if ydebug.is_enabled then
            print(212)
            return 0
        else
            return 0
        end
    end

    if getMana("player") <= 10 then
        if canCast(evocation) and castSpell("player",evocation) then
            if ydebug.is_enabled then
                print(213)
                return 0
            else
                return 0
            end
        end
    end
    return 0
end


function rotation:conserve(args)
    -- actions.conserve=mirror_image
    if canCast(mirror_image) and castSpell("player",mirror_image) then
        if ydebug.is_enabled then
            print(301)
            return 0
        else
            return 0
        end
    end
    -- actions.conserve+=/charged_up,if=buff.arcane_charge.stack=0
    if UnitPower("player",16) == 0 then
        if canCast(charged_up) and castSpell("player",charged_up) then
            if ydebug.is_enabled then
                print(302)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.conserve+=/nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down
    if ( getDebuffRemain(tg,nether_tempest) <= 3) and UnitPower("player",16) == UnitPowerMax("player",16) and getBuffRemain("player",rune_of_power) <= 0 and getBuffRemain("player",arcane_power) <= 0 then
        if canCast(nether_tempest) and castSpell(tg,nether_tempest) then
            if ydebug.is_enabled then
                print(303)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.conserve+=/arcane_orb,if=buff.arcane_charge.stack<=2&(cooldown.arcane_power.remains>10|active_enemies<=2)
    if UnitPower("player",16) <= 2 and ( getSpellCD(arcane_power) > 10 or active_enemies <= 2 ) then
        if canCast(arcane_orb) and castSpell(tg,arcane_orb) then
            if ydebug.is_enabled then
                print(304)
                return 0
            else
                return 0
            end
        end
    end
    -- # Arcane Blast shifts up in priority when running rule of threes.
    -- actions.conserve+=/arcane_blast,if=buff.rule_of_threes.up&buff.arcane_charge.stack>3
    if getBuffRemain("player",rule_of_threes) > 0 and UnitPower("player",16) > 3 then
        if canCast(arcane_blast) and castSpell(tg,arcane_blast) then
            if ydebug.is_enabled then
                print(305)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.conserve+=/rune_of_power,if=buff.arcane_charge.stack=buff.arcane_charge.max_stack&(full_recharge_time<=execute_time|full_recharge_time<=cooldown.arcane_power.remains|target.time_to_die<=cooldown.arcane_power.remains)
    if UnitPower("player",16) == UnitPowerMax("player",16) and ( full_recharge_time(rune_of_power) <= getCastTime(rune_of_power) or full_recharge_time(rune_of_power) <= getSpellCD(arcane_power) or getTimeToDie(tg) <= getSpellCD(arcane_power) ) then
        if getCharges(rune_of_power) >= 1 and not UnitBuffID("player",rune_of_power_buff) and castSpell("player",rune_of_power) then
            if ydebug.is_enabled then
                print(306)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.conserve+=/arcane_missiles,if=mana.pct<=95&buff.clearcasting.react&active_enemies<3,chain=1
    if getMana("player") <= 95 and getBuffRemain("player",clearcasting) > 0 and active_enemies < 3 then
        if canCast(arcane_missiles) and castSpell(tg,arcane_missiles) then
            if ydebug.is_enabled then
                print(307)
                return 0
            else
                return 0
            end
        end
    end
    -- # During conserve, we still just want to continue not dropping charges as long as possible.So keep 'burning' as long as possible (aka conserve_mana threshhold) and then swap to a 4x AB->Abarr conserve rotation. If we do not have 4 AC, we can dip slightly lower to get a 4th AC. We also sustain at a higher mana percentage when we plan to use a Rune of Power during conserve phase, so we can burn during the Rune of Power.
    -- actions.conserve+=/arcane_barrage,if=((buff.arcane_charge.stack=buff.arcane_charge.max_stack)&((mana.pct<=variable.conserve_mana)|(cooldown.arcane_power.remains>cooldown.rune_of_power.full_recharge_time&mana.pct<=variable.conserve_mana+25))|(talent.arcane_orb.enabled&cooldown.arcane_orb.remains<=gcd&cooldown.arcane_power.remains>10))|mana.pct<=(variable.conserve_mana-10)
    if (( UnitPower("player",16) == UnitPowerMax("player",16) ) and (( getMana("player") <= variable.conserve_mana ) or ( getSpellCD(arcane_power) > full_recharge_time(rune_of_power) and getMana("player") <= variable.conserve_mana + 25 )) or ( getTalent(7,3) and getSpellCD(arcane_orb) <= gcd and getSpellCD(arcane_power) > 10 )) or  getMana("player") <= ( variable.conserve_mana - 10 ) then
        if canCast(arcane_barrage) and castSpell(tg,arcane_barrage) then
            if ydebug.is_enabled then
                print(308)
                return 0
            else
                return 0
            end
        end
    end
    -- # Supernova is barely worth casting, which is why it is so far down, only just above AB. 
    -- actions.conserve+=/supernova,if=mana.pct<=95 
    if  getMana("player") <=95 then
        if canCast(supernova) and castSpell(tg,supernova) then
            if ydebug.is_enabled then
                print(309)
                return 0
            else
                return 0
            end
        end
    end
    -- # Keep 'burning' in aoe situations until conserve_mana pct. After that only cast AE with 3 Arcane charges, since it's almost equal mana cost to a 3 stack AB anyway. At that point AoE rotation will be AB x3->AE->Abarr
    -- actions.conserve+=/arcane_explosion,if=active_enemies>=3&(mana.pct>=variable.conserve_mana|buff.arcane_charge.stack=3)
    if active_enemies >= 3 and ( getMana("player") >= variable.conserve_mana or UnitPower("player",16) == 3 ) then
        if canCast(arcane_explosion) and castSpell(tg,arcane_explosion) then
            if ydebug.is_enabled then
                print(310)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.conserve+=/arcane_blast
    if canCast(arcane_blast) and castSpell(tg,arcane_blast) then
        if ydebug.is_enabled then
            print(311)
            return 0
        else
            return 0
        end
    end
    -- actions.conserve+=/arcane_barrage
    if canCast(arcane_barrage) and castSpell(tg,arcane_barrage) then
        if ydebug.is_enabled then
            print(312)
            return 0
        else
            return 0
        end
    end
    return 0
end


function rotation:movement(args)
    -- actions.movement=shimmer,if=movement.distance>=10
    -- actions.movement+=/blink,if=movement.distance>=10
    -- actions.movement+=/presence_of_mind
    if canCast(presence_of_mind) and castSpell("player",presence_of_mind) then
        if ydebug.is_enabled then
            print(401)
            return 0
        else
            return 0
        end
    end
    -- actions.movement+=/arcane_missiles
    if canCast(arcane_missiles) and castSpell(tg,arcane_missiles) then
        if ydebug.is_enabled then
            print(402)
            return 0
        else
            return 0
        end
    end
    -- actions.movement+=/arcane_orb
    if canCast(arcane_orb) and castSpell(tg,arcane_orb) then
        if ydebug.is_enabled then
            print(403)
            return 0
        else
            return 0
        end
    end
    -- actions.movement+=/supernova
    if canCast(supernova) and castSpell(tg,supernova) then
        if ydebug.is_enabled then
            print(404)
            return 0
        else
            return 0
        end
    end
    return 0
end

