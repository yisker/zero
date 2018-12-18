
-- from simc 181104

zj = "player"
wind_shear = 57994 --风剪
totem_mastery = 210643 --图腾掌握
resonance_totem = 202192 --共鸣图腾
storm_elemental = 192249 --风暴元素
fire_elemental = 198067 --火元素
earth_elemental = 198103 --土元素
chain_lightning = 188443 --闪电链
lava_beam = 114074 --熔岩弹射
stormkeeper = 191634 --风暴守护者
ascendance = 114050 --升腾
liquid_magma_totem = 192222 --岩浆图腾
flame_shock = 188389 --烈焰震击
earthquake = 61882 --地震术
lava_surge = 77756 --熔岩奔腾
lava_burst = 51505 --熔岩爆裂
elemental_blast = 117014 --元素冲击
bloodlust = 2825 --嗜血


gcd = getGCD()
time = GetTime() - Y.data["Combat Started"]


-- # Executed every time the actor is available.
-- # Cast Bloodlust manually if the Azerite Trait Ancestral Resonance is present.
-- actions=bloodlust, if azerite.ancestral_resonance.enabled
-- # In-combat potion is preferentially linked to your Elemental, unless combat will end shortly
-- actions+=/potion
-- # Interrupt of casts.
-- actions+=/wind_shear
if ddyz.is_enabled and canCast(wind_shear) and canInterrupt(tg,1,ddyz.value) then
    if castSpell(tg,wind_shear) then
        if ydebug.is_enabled then
            print(100)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/totem_mastery, 
if  getTalent(2,3)  and   getBuffRemain(zj, resonance_totem) < 2 then
    if canCast(totem_mastery) and castSpell(zj,totem_mastery) then
        if ydebug.is_enabled then
            print(101)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/fire_elemental, 
if  not  getTalent(4,2)  then
    if canCast(fire_elemental) and castSpell(tg,fire_elemental) then
        if ydebug.is_enabled then
            print(102)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/storm_elemental, 
if  getTalent(4,2) then
     if canCast(storm_elemental) and castSpell(tg,storm_elemental) then
        if ydebug.is_enabled then
            print(103)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/earth_elemental, 
if  getSpellCD(fire_elemental) < 120 and  not  getTalent(4,2) or  getSpellCD(storm_elemental) < 120 and  getTalent(4,2) then
    if canCast(earth_elemental) and castSpell(zj,earth_elemental) then
        if ydebug.is_enabled then
            print(104)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/use_items
if canUse(13) then
    useItem(13)
end
if canUse(14) then
    useItem(14)
end
-- actions+=/blood_fury, if  not  getTalent(7,3)   or   getBuffRemain(zj, )    ascendance.up or  getSpellCD() .ascendance.remains>50
-- actions+=/berserking, if  not  getTalent(7,3)   or   getBuffRemain(zj, )    ascendance.up
-- actions+=/fireblood, if  not  getTalent(7,3)   or   getBuffRemain(zj, )    ascendance.up or  getSpellCD() .ascendance.remains>50
-- actions+=/ancestral_call, if  not  getTalent(7,3)   or   getBuffRemain(zj, )    ascendance.up or  getSpellCD() .ascendance.remains>50
-- actions+=/run_action_list,name=aoe, 
if active_enemies > 2 then
    self:aoe()
end
-- actions+=/run_action_list,name=single_target
self:single_target()


function rotation:aoe()
    -- actions.aoe+=/lava_burst,moving=1, 
    if  getTalent(7,3) and isMoving(zj) then
        if canCast(lava_burst) and castSpell(tg,lava_burst) then
            if ydebug.is_enabled then
                print(210)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/flame_shock,moving=1,target_ if refreshable
    if isMoving(zj) and canCast(flame_shock) and getDebuffRemain(tg,flame_shock) <= 3 and castSpell(tg,flame_shock) then
        if ydebug.is_enabled then
            print(211)
            return 0
        else
            return 0
        end
    end
    -- actions.aoe+=/frost_shock,moving=1
    if isMoving(zj) and canCast(frost_shock) and castSpell(tg,frost_shock) then
        if ydebug.is_enabled then
            print(212)
            return 0
        else
            return 0
        end
    end


    -- # Multi target action priority list
    -- actions.aoe=stormkeeper, 
    if  getTalent(7,2) then
        if canCast(stormkeeper) and castSpell(zj,stormkeeper) then
            if ydebug.is_enabled then
                print(201)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/ascendance, 
    if  getTalent(7,3) and ( getTalent(4,2)   and  getSpellCD(storm_elemental) < 120 and  getSpellCD(storm_elemental) > 15 or  not  getTalent(4,2)  ) then
        if canCast(ascendance) and castSpell(zj,ascendance) then
            if ydebug.is_enabled then
                print(202)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/liquid_magma_totem, 
    if  getTalent(4,3) then
        if canCast(liquid_magma_totem) and castSpell(tg,liquid_magma_totem) then
            if ydebug.is_enabled then
                print(203)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/flame_shock, 
    if active_enemies < 4 and getDebuffRemain(tg,flame_shock) <= 3 then
        if canCast(flame_shock) and castSpell(tg,flame_shock) then
            if ydebug.is_enabled then
                print(204)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/earthquake
    if canCast(earthquake) and castSpell(tg,earthquake) then
        if ydebug.is_enabled then
            print(205)
            return 0
        else
            return 0
        end
    end
    -- # Only cast Lava Burst on three targets if it is an instant.
    -- actions.aoe+=/lava_burst, 
    if (  getBuffRemain(zj, lava_surge)  > 0 or   getBuffRemain(zj, ascendance)> 0 ) and active_enemies < 4 then
        if canCast(lava_burst) and castSpell(tg,lava_burst) then
            if ydebug.is_enabled then
                print(206)
                return 0
            else
                return 0
            end
        end
    end

    -- actions.aoe+=/elemental_blast, 
    if  getTalent(1,3)   and  active_enemies < 4 then
        if canCast(elemental_blast) and castSpell(zj,elemental_blast) then
            if ydebug.is_enabled then
                print(207)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/lava_beam, 
    if  getTalent(7,3)  then
        if canCast(lava_beam) and castSpell(tg,lava_beam) then
            if ydebug.is_enabled then
                print(208)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.aoe+=/chain_lightning
    if canCast(chain_lightning) and castSpell(tg,chain_lightning) then
        if ydebug.is_enabled then
            print(209)
            return 0
        else
            return 0
        end
    end
    
end

function rotation:single_target()
    -- # Single Target Action Priority List
    -- actions.single_target=flame_shock, 
    if  not UnitDebuffID(tg,flame_shock) or getDebuffRemain(tg,flame_shock) <= gcd or  getTalent(7,3) and getDebuffRemain(tg,flame_shock) < ( getSpellCD(ascendance) +  15) and  getSpellCD(ascendance) < 4 and ( not  getTalent(4,2)   or  getTalent(4,2)   and  getSpellCD(storm_elemental) < 120) then
        if canCast(flame_shock) and castSpell(tg,flame_shock) then
            if ydebug.is_enabled then
                print(301)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.single_target+=/ascendance, 
    if  getTalent(7,3)  and ( time >= 60 or   getBuffRemain(zj, bloodlust)  > 0) and  getSpellCD() .lava_burst.remains>0 and  not  getTalent(4,2)  
    -- actions.single_target+=/ascendance, if  getTalent(7,3)   and (time>=60 or   getBuffRemain(zj, )    bloodlust.up) and  getSpellCD() .lava_burst.remains>0 and  getSpellCD() .storm_elemental.remains<=120
    -- # Don't use Elemental Blast if you could cast a Master of the Elements empowered Earth Shock instead.
    -- actions.single_target+=/elemental_blast, if  getTalent(1,3)   and (talent.master_of_the_elements.enabled and   getBuffRemain(zj, )    master_of_the_elements.up and maelstrom<60 or  not talent.master_of_the_elements.enabled)
    -- # Keep SK for large or soon add waves.
    -- actions.single_target+=/stormkeeper, if  getTalent(7,2)   and (raid_event.adds.count<3 or raid_event.adds.in>50)
    -- actions.single_target+=/liquid_magma_totem, if  getTalent(4,3)   and (raid_event.adds.count<3 or raid_event.adds.in>50)
    -- actions.single_target+=/earthquake, if active_enemies>1 and  active_enemies  >1 and  not talent.exposed_elements.enabled
    -- # Use the  getDebuffRemain(tg, )   before casting Earth Shock again.
    -- actions.single_target+=/lightning_bolt, if talent.exposed_elements.enabled and  getDebuffRemain(tg, )  .exposed_elements.up and maelstrom>=60 and  not   getBuffRemain(zj, )    ascendance.up
    -- # If possible, use Earth Shock with Master of the Elements.
    -- actions.single_target+=/earth_shock, if talent.master_of_the_elements.enabled and (  getBuffRemain(zj, )    master_of_the_elements.up or maelstrom>=92) or  not talent.master_of_the_elements.enabled
    -- # Once you have enough Wind Gust stacks, don't hardcast Lava Burst anymore (keep casting Lava Burst with Lava Surge procs).
    -- actions.single_target+=/lightning_bolt, if   getBuffRemain(zj, )    wind_gust.stack>=14 and  not   getBuffRemain(zj, )    lava_surge.up
    -- actions.single_target+=/lava_burst, if  getSpellCD() _react or   getBuffRemain(zj, )    ascendance.up
    -- actions.single_target+=/flame_shock,target_ if refreshable
    -- actions.single_target+=/totem_mastery, if  getTalent(2,3)  and (  getBuffRemain(zj, )    resonance_totem.remains<6 or (  getBuffRemain(zj, )    resonance_totem.remains<(  getBuffRemain(zj, )    ascendance.duration+ getSpellCD() .ascendance.remains) and  getSpellCD() .ascendance.remains<15))
    -- actions.single_target+=/frost_shock, if talent.icefury.enabled and   getBuffRemain(zj, )    icefury.up
    -- actions.single_target+=/icefury, if talent.icefury.enabled
    -- actions.single_target+=/lava_beam, if  getTalent(7,3)   and active_enemies>1 and spell_targets.lava_beam>1
    -- actions.single_target+=/chain_lightning, if active_enemies>1 and  active_enemies  >1
    -- actions.single_target+=/lightning_bolt
    -- actions.single_target+=/flame_shock,moving=1,target_ if refreshable
    -- actions.single_target+=/flame_shock,moving=1, if movement.distance>6
    -- # Frost Shock is our movement filler.
    -- actions.single_target+=/frost_shock,moving=1
end
