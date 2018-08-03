-----------------------------------------------------------
--全局函数
function getGCD()
    local start, duration, enabled, modRate = GetSpellCooldown(61304)
    if GCD == nil then
      GCD = 1.5 / ((UnitSpellHaste("player")/100)+1);
    end
    if duration ~= 0 then
      GCD = duration
    end
    return GCD
end
-----------------------------------------------------------


local maelstrom = getRealMana("player")
local gcd = getGCD()

local wind_shear = 57994 --风剪
local frostbrand = 196834 --冰封打击
local lightning_bolt = 187837 --闪电箭
local ascendance = 114051 --升腾
local earthen_spike = 188089 --大地之刺
local crash_lightning = 187874 --毁灭闪电
local rockbiter = 193786 --石化
local landslide = 202004 --山崩buff
local windstrike = 115356 --风切

-- actions=wind_shear
if canCast(wind_shear) and castSpell("target",wind_shear) then
	print(101)
end
-- actions+=/variable,name=hailstormCheck,value=((talent.hailstorm.enabled&!buff.frostbrand.up)|!talent.hailstorm.enabled)
local hailstormCheck = ((getTalent(4,2) and not UnitBuffID("player",frostbrand)) or not getTalent(4,2))
-- actions+=/variable,name=furyCheck80,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&((maelstrom>35&cooldown.lightning_bolt.remains>=3*gcd)|maelstrom>80)))
local furyCheck80 = (not getTalent(6,2) or (getTalent(6,2) and ((maelstrom > 35 and getSpellCD(lightning_bolt) >= 3 * gcd) or maelstrom > 80)))
-- actions+=/variable,name=furyCheck70,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>70))
local furyCheck70 = (not getTalent(6,2) or (getTalent(6,2) and maelstrom > 70))
-- actions+=/variable,name=furyCheck45,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>45))
local furyCheck45 = (not getTalent(6,2) or (getTalent(6,2) and maelstrom > 45))
-- actions+=/variable,name=furyCheck35,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>35))
local furyCheck35 = (not getTalent(6,2) or (getTalent(6,2) and maelstrom > 35))
-- actions+=/variable,name=furyCheck25,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>25))
local furyCheck25 = (not getTalent(6,2) or (getTalent(6,2) and maelstrom > 25))
-- actions+=/variable,name=OCPool70,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&maelstrom>70))
local OCPool70 = (not getTalent(4,3) or (getTalent(4,3) and maelstrom > 70))
-- actions+=/variable,name=OCPool60,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&maelstrom>60))
local OCPool70 = (not getTalent(4,3) or (getTalent(4,3) and maelstrom > 60))
-- actions+=/auto_attack
-- actions+=/use_items
-- actions+=/call_action_list,name=opener
if opener() then
end
-- actions+=/call_action_list,name=asc,if=buff.ascendance.up
if UnitBuffID("player",ascendance) then
	asc()
end
-- actions+=/call_action_list,name=buffs
if buffs() then
end
-- actions+=/call_action_list,name=cds
if cds() then
end
-- actions+=/call_action_list,name=core
if core() then
end
-- actions+=/call_action_list,name=filler
if filler() then
end


local function asc( ... )
	-- body
	-- actions.asc=earthen_spike
	if canCast(earthen_spike) and castSpell(tg,earthen_spike) then
		print(201)
		return true
	end
	-- actions.asc+=/crash_lightning,if=!buff.crash_lightning.up&active_enemies>=2
	if canCast(crash_lightning) and not UnitBuffID("player",crash_lightning) and active_enemies >= 2 then
		if castSpell("player",crash_lightning) then
			print(202)
			return true
		end
	end
	-- actions.asc+=/rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
	if getTalent(2,1) and not UnitBuffID("player",landslide) and charges_fractional(rockbiter) > 1.7 then
		if canCast(rockbiter) and castSpell(tg,rockbiter) then
			print(203)
			return true
		end
	end
	-- actions.asc+=/windstrike
	if canCast(windstrike) and castSpell(tg,windstrike) then
		print(204)
		return true
	end
end


local function buffs( ... )
	-- body
	-- actions.buffs=rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
	if getTalent(2,1) and not UnitBuffID("player",landslide) and charges_fractional(rockbiter) > 1.7 then
		if canCast(rockbiter) and castSpell(tg,rockbiter) then
			print(301)
			return true
		end
	end
	-- actions.buffs+=/fury_of_air,if=!ticking&maelstrom>22
	-- actions.buffs+=/flametongue,if=!buff.flametongue.up
	-- actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck45
	-- actions.buffs+=/flametongue,if=buff.flametongue.remains<6+gcd
	-- actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<6+gcd
	-- actions.buffs+=/totem_mastery,if=buff.resonance_totem.remains<2
end


-- # Bloodlust casting behavior mirrors the simulator settings for proxy bloodlust. See options 'bloodlust_percent', and 'bloodlust_time'. 
-- actions.cds=bloodlust,if=target.health.pct<25|time>0.500
-- actions.cds+=/berserking,if=buff.ascendance.up|(feral_spirit.remains>5)|level<100
-- actions.cds+=/blood_fury,if=buff.ascendance.up|(feral_spirit.remains>5)|level<100
-- actions.cds+=/potion,if=buff.ascendance.up|!talent.ascendance.enabled&feral_spirit.remains>5|target.time_to_die<=60
-- actions.cds+=/feral_spirit
-- actions.cds+=/ascendance,if=(cooldown.strike.remains>0)&buff.ascendance.down
-- actions.cds+=/earth_elemental

-- actions.core=earthen_spike,if=variable.furyCheck25
-- actions.core+=/crash_lightning,if=!buff.crash_lightning.up&active_enemies>=2
-- actions.core+=/crash_lightning,if=active_enemies>=8|(active_enemies>=6&talent.crashing_storm.enabled)
-- actions.core+=/stormstrike,if=buff.stormbringer.up
-- actions.core+=/crash_lightning,if=active_enemies>=4|(active_enemies>=2&talent.crashing_storm.enabled)
-- actions.core+=/lightning_bolt,if=talent.overcharge.enabled&variable.furyCheck45&maelstrom>=40
-- actions.core+=/stormstrike,if=(!talent.overcharge.enabled&variable.furyCheck35)|(talent.overcharge.enabled&variable.furyCheck80)
-- actions.core+=/sundering
-- actions.core+=/flametongue,if=talent.searing_assault.enabled
-- actions.core+=/lava_lash,if=buff.hot_hand.react
-- actions.core+=/crash_lightning,if=active_enemies>=3

-- actions.filler=rockbiter,if=maelstrom<70
-- actions.filler+=/flametongue,if=talent.searing_assault.enabled|buff.flametongue.remains<4.8
-- actions.filler+=/crash_lightning,if=(talent.crashing_storm.enabled|active_enemies>=2)&debuff.earthen_spike.up&maelstrom>=40&variable.OCPool60
-- actions.filler+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8&maelstrom>40
-- actions.filler+=/lava_lash,if=maelstrom>=50&variable.OCPool70&variable.furyCheck80
-- actions.filler+=/rockbiter
-- actions.filler+=/crash_lightning,if=(maelstrom>=65|talent.crashing_storm.enabled|active_enemies>=2)&variable.OCPool60&variable.furyCheck45
-- actions.filler+=/flametongue

-- actions.opener=rockbiter,if=maelstrom<15&time<gcd