local wind_shear = 57994

-- actions=wind_shear
if canCast(wind_shear) and castSpell("target",wind_shear) then
	print(101)
end
-- actions+=/variable,name=hailstormCheck,value=((talent.hailstorm.enabled&!buff.frostbrand.up)|!talent.hailstorm.enabled)
-- actions+=/variable,name=furyCheck80,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&((maelstrom>35&cooldown.lightning_bolt.remains>=3*gcd)|maelstrom>80)))
-- actions+=/variable,name=furyCheck70,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>70))
-- actions+=/variable,name=furyCheck45,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>45))
-- actions+=/variable,name=furyCheck35,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>35))
-- actions+=/variable,name=furyCheck25,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>25))
-- actions+=/variable,name=OCPool70,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&maelstrom>70))
-- actions+=/variable,name=OCPool60,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&maelstrom>60))
-- actions+=/auto_attack
-- actions+=/use_items
-- actions+=/call_action_list,name=opener
-- actions+=/call_action_list,name=asc,if=buff.ascendance.up
-- actions+=/call_action_list,name=buffs
-- actions+=/call_action_list,name=cds
-- actions+=/call_action_list,name=core
-- actions+=/call_action_list,name=filler

-- actions.asc=earthen_spike
-- actions.asc+=/crash_lightning,if=!buff.crash_lightning.up&active_enemies>=2
-- actions.asc+=/rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
-- actions.asc+=/windstrike

-- actions.buffs=rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
-- actions.buffs+=/fury_of_air,if=!ticking&maelstrom>22
-- actions.buffs+=/flametongue,if=!buff.flametongue.up
-- actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck45
-- actions.buffs+=/flametongue,if=buff.flametongue.remains<6+gcd
-- actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<6+gcd
-- actions.buffs+=/totem_mastery,if=buff.resonance_totem.remains<2

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