local lively_spirit_setting = hps_category:create_setting("lively_spirit"); -- 指定变量的名字为test1，用于在脚本中进行引用
lively_spirit_setting.display_name = L["是否点出活跃精神"]; -- 变量在界面上显示的名字
lively_spirit_setting.description = "是否点出活跃精神特质，是则打勾"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
lively_spirit_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
lively_spirit_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
lively_spirit_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
lively_spirit_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
lively_spirit_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
lively_spirit_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
lively_spirit_setting.value_width = 120; -- 值显示宽度像素（默认为100）



moonkin_form = 24858
warrior_of_elune = 202425
innervate = 29166
incarnation = 102560
celestial_alignment = 194223
lively_spirit = 279642--活跃精神
streaking_stars = 272871--飞驰流星
fury_of_elune = 202770
force_of_nature = 205636
sunfire = 93402
sunfire_debuff = 164815
moonfire = 8921
moonfire_debuff = 164812
stellar_flare = 202347
lunar_empowerment = 164547
solar_empowerment = 164545
lunar_strike = 194153
sunblaze = 1
solar_wrath = 190984
starlord = 279709
starsurge = 78674
starfall = 191034
new_moon = 274281
half_moon = 274282
full_moon = 274283
dawning_sun = 276152--破晓之阳
sunblaze = 274397
power_of_the_moon = 273367




spell_targets = getNumEnemies(tg,8)
active_enemies = spell_targets


-- # Azerite variables
-- # Streaking Stars:
-- # Cast sw after every non-sw spell unless capping, sw sf sw if forced
-- actions.precombat+=/variable,name=
az_streak = azerite.streaking_stars.rank
-- actions.precombat+=/variable,name=
az_ds = azerite.dawning_sun.rank
-- actions.precombat+=/variable,name=
az_sb = azerite.sunblaze.rank
-- # Power of the Moon:
-- # 2T: 3x noemp, 2x emp, 1x normal
-- # 3T: 3x lsemp, 2x normal, 1x normal
-- # 4T: 3x lsemp, 2x normal, 1x normal
-- actions.precombat+=/variable,name=
if  getTalent(6,2) then
    az_potm = azerite.power_of_the_moon.rank
end
-- actions.precombat+=/moonkin_form
if not UnitBuffID("player",moonkin_form) then
    if castSpell("player",moonkin_form) then
        if ydebug.is_enabled then
            print(1)
            return 0
        else
            return 0
        end
    end
end
-- # Snapshot raid buffed stats before combat begins and pre-potting is done.
-- actions.precombat+=/snapshot_stats
-- actions.precombat+=/potion
-- actions.precombat+=/solar_wrath

-- # Executed every time the actor is available.
-- actions=potion, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/blood_fury, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/berserking, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/arcane_torrent, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/lights_judgment, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/fireblood, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/ancestral_call, if  getBuffRemain("player", ) celestial_alignment.up or  getBuffRemain("player", ) incarnation.up
-- actions+=/use_items
-- # CDs
-- actions+=/warrior_of_elune
if getTalent(1,2) and canCast(warrior_of_elune) and castSpell("player",warrior_of_elune) then
    if ydebug.is_enabled then
        print(2)
        return 0
    else
        return 0
    end
end
-- actions+=/innervate, 
if lively_spirit_setting.is_enabled and ( getSpellCD(incarnation) <= 0 or  getSpellCD(celestial_alignment) < 12) and (((raid_event.adds.duration%15)*(4)<(raid_event.adds.in%180)) or (raid_event.adds.up)) then
    if canCast(innervate) and castSpell("player",innervate) then
        if ydebug.is_enabled then
            print(3)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/incarnation, 
if  getRealMana("player") >=40 and (((raid_event.adds.duration%30)*(4)<(raid_event.adds.in%180)) or (raid_event.adds.up)) then
    if canCast(incarnation) and castSpell("player",incarnation) then
        if ydebug.is_enabled then
            print(4)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/celestial_alignment, 
if  getRealMana("player") >=40 and ( not  lively_spirit_setting.is_enabled  or  getBuffRemain("player", lively_spirit) > 0) and (((raid_event.adds.duration%15)*(4)<(raid_event.adds.in%180)) or (raid_event.adds.up)) then
    if canCast(celestial_alignment) and castSpell("player",celestial_alignment) then
        if ydebug.is_enabled then
            print(5)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/fury_of_elune, 
if (((raid_event.adds.duration%8)*(4)<(raid_event.adds.in%60)) or (raid_event.adds.up)) and (( getBuffRemain("player", celestial_alignment) > 0 or  getBuffRemain("player", incarnation) > 0 ) or ( getSpellCD(celestial_alignment) >30 or  getSpellCD(incarnation) >30)) then
    if canCast(fury_of_elune) and castSpell(tg,fury_of_elune) then
        if ydebug.is_enabled then
            print(6)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/force_of_nature, 
if ( getBuffRemain("player", celestial_alignment) > 0 or  getBuffRemain("player", incarnation) > 0) or ( getSpellCD(celestial_alignment) >30 or  getSpellCD(incarnation) >30) then
    if canCast(force_of_nature) and castSpell("player",force_of_nature) then
        if ydebug.is_enabled then
            print(7)
            return 0
        else
            return 0
        end
    end
end
-- # DoTs
-- actions+=/sunfire,target_ if refreshable, 
if UnitPowerMax("player") - getRealMana("player") >= 7 and  getTimeToDie(tg) > 5.4 and ( not  UnitBuffID("player", celestial_alignment) and  not  UnitBuffID("player", incarnation)  or  not az_streak or  not  getLastSpell() == sunfire) and ( isMoving("player") or getDebuffRemain(tg,sunfire_debuff) <= gcd*2) then
    if canCast(sunfire) and castSpell(tg,sunfire) then
        if ydebug.is_enabled then
            print(8)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/moonfire,target_ if refreshable, 
if  UnitPowerMax("player") - getRealMana("player")>=7 and  getTimeToDie(tg) >6.6 and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or  not az_streak or  not  getLastSpell() == moonfire) and (isMoving("player") or getDebuffRemain(tg,moonfire_debuff)<=gcd*2) then
    if canCast(moonfire) and castSpell(tg,moonfire) then
        if ydebug.is_enabled then
            print(9)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/stellar_flare,target_ if refreshable, 
if  UnitPowerMax("player") - getRealMana("player")>=12 and  getTimeToDie(tg) >7.2 and ( not  UnitBuffID("player", celestial_alignment) and  not  UnitBuffID("player", incarnation) or  not az_streak or  not  getLastSpell() == stellar_flare) then
    if canCast(stellar_flare) and castSpell(tg,stellar_flare) then
        if ydebug.is_enabled then
            print(10)
            return 0
        else
            return 0
        end
    end
end
-- # Empowerment cap check
-- actions+=/lunar_strike, 
if  UnitPowerMax("player") - getRealMana("player")>=16 and ( getBuffStacks("player", lunar_empowerment) ==3 or (spell_targets<3 and  getRealMana("player") >=40 and ( getBuffStacks("player", lunar_empowerment) ==2 and  getBuffStacks("player", solar_empowerment) ==2))) and  not (spell_targets>=2 and az_potm==3 and active_enemies==2) then
    if canCast(lunar_strike) and castSpell(tg,lunar_strike) then
        if ydebug.is_enabled then
            print(11)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/solar_wrath, 
if  UnitPowerMax("player") - getRealMana("player")>=12 and ( getBuffStacks("player", solar_empowerment) ==3 or (az_sb>1 and spell_targets<3 and  getRealMana("player") >=32 and  not  UnitBuffID("player", sunblaze) )) and  not (spell_targets>=2 and active_enemies<=4 and az_potm==3) or (az_streak and ( UnitBuffID("player", celestial_alignment)  or  getBuffRemain("player", incarnation) >0) and  not  getLastSpell()== solar_wrath and  UnitPowerMax("player") - getRealMana("player")>=12) then
    if canCast(solar_wrath) and castSpell(tg,solar_wrath) then
        if ydebug.is_enabled then
            print(12)
            return 0
        else
            return 0
        end
    end
end
-- # Rotation
-- actions+=/starsurge, 
if (spell_targets<3 and ( not  getBuffRemain("player", starlord) >0 or  getBuffRemain("player", starlord) >=4) or getCastTime(starsurge)*( getRealMana("player") %40)> getTimeToDie(tg) ) and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or az_streak<2 or  not  (getLastSpell() == starsurge)) and (raid_event.movement.in>( getBuffStacks("player", lunar_empowerment)*getCastTime(lunar_strike)+ getBuffStacks("player", solar_empowerment) *getCastTime(solar_wrath)) or ( getRealMana("player") + getBuffStacks("player", lunar_empowerment)*12+ getBuffStacks("player", solar_empowerment)*8)>=96) then
    if canCast(starsurge) and castSpell(tg,starsurge) then
        if ydebug.is_enabled then
            print(13)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/starfall, 
if spell_targets >=3 and ( not  UnitBuffID("player", starlord)  or  getBuffRemain("player", starlord) >=4) then
    if canCast(starfall) and castSpell(tg,starfall) then
        if ydebug.is_enabled then
            print(14)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/new_moon, 
if  UnitPowerMax("player") - getRealMana("player")>10+getCastTime(new_moon)%1.5 then
    if canCast(new_moon) and castSpell(tg,new_moon) then
        if ydebug.is_enabled then
            print(15)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/half_moon, 
if  UnitPowerMax("player") - getRealMana("player")>20+getCastTime(half_moon)%1.5 then
    if canCast(half_moon) and castSpell(tg,half_moon) then
        if ydebug.is_enabled then
            print(16)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/full_moon, 
if  UnitPowerMax("player") - getRealMana("player")>40+getCastTime(full_moon)%1.5 then
    if canCast(full_moon) and castSpell(tg,full_moon) then
        if ydebug.is_enabled then
            print(17)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/lunar_strike, 
if (( getBuffRemain("player", warrior_of_elune) >0 or  getBuffRemain("player", lunar_empowerment) >0 or spell_targets>=3 and  not  UnitBuffID("player", solar_empowerment) ) and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or az_streak<2 or  not  (getLastSpell()== lunar_strike)) or (az_ds and  not  UnitBuffID("player", dawning_sun) )) and  not (spell_targets>=2 and active_enemies<=4 and (az_potm=3 or az_potm=2 and active_enemies=2)) then
    if canCast(lunar_strike) and castSpell(tg,lunar_strike) then
        if ydebug.is_enabled then
            print(18)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/solar_wrath, 
if ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or az_streak<2 or  not  (getLastSpell() ==solar_wrath)) and  not (spell_targets>=2 and active_enemies<=4 and (az_potm=3 or az_potm=2 and active_enemies=2)) then
    if canCast(solar_wrath) and castSpell(tg,solar_wrath) then
        if ydebug.is_enabled then
            print(19)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/sunfire, 
if ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or  not az_streak or  not  (getLastSpell()== sunfire)) and  not (az_potm>=2 and spell_targets>=2) then
    if canCast(sunfire) and castSpell(tg,sunfire) then
        if ydebug.is_enabled then
            print(20)
            return 0
        else
            return 0
        end
    end
end
-- actions+=/moonfire
if canCast(moonfire) and castSpell(tg,moonfire) then
    if ydebug.is_enabled then
        print(21)
        return 0
    else
        return 0
    end
end