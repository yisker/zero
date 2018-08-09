----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "0c02decd-b730-4509-b5bf-269d28ca3c28";
-- 定义循环的英文名称。
local rotation_name = "huofa";
Scorpio("zeus." .. rotation_name)("");
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "火法测试";
    L["Welcome to use test module."] = "欢迎使用火法测试模块！";    
    L["targets"] = "目标选择";
end
L = _Locale("zhTW");
if L then
    -- 繁体中文系列。
    L[rotation_name] = "測試";
    L["Welcome to use test module."] = "歡迎使用測試模組！";
    L["targets"] = "目标选择";
end
L = _Locale;
local rotation = zeus.rotation(rotation_id, L[rotation_name]);
-- 定义循环加载并可用时的消息，填入"N/A"则不显示。
rotation.condition_yes_message = L["Welcome to use test module."];
-- 定义循环加载并不可用时的消息，填入"N/A"则不显示。
rotation.condition_no_message = "N/A";
-- 定义循环的执行间隔（秒），如果不设默认是0.1。
rotation.interval = 0.1;
-- 定义模块专用宏命令，下面的例子会定义出：/zeus test [argument]。如果不需要宏控制，则删除下面一行。
rotation.macro = "abc";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------

local targets_setting = rotation.default_setting_category:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
targets_setting.display_name = L["targets"];
targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
targets_setting.default_value = "智能"; -- 变量默认值
targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
targets_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
targets_setting.is_enabled_by_default = false; -- 是否默认启用
targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
targets_setting.value_width = 130; -- 值显示宽度像素（默认为100）



-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    if (not argument or argument == "") then
        print("这里应该显示参数说明。");
    else
        print("收到宏命令参数：", argument);
    end
end
function rotation:condition_action()
    -- 编写判断模块是否可用的脚本。
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 63 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
    return current_specialization == speci;
    -- return true
end
function rotation:prestart_action()
    -- 编写模块启动前脚本。
    print("start now!");
end
function rotation:prepause_action()
    -- 编写模块暂停前脚本。
    print("pause now!");
end
function rotation:prestop_action()
    -- 编写模块停止前脚本。
    print("stop now!");
end
-------------------------------------------------------------------------------------------------------------------
-- 记录进入战斗后自己释放成功和失败的技能队列，

-- 通过访问_G.lastspell_failed获得上一次失败的技能ID，
-- _G.lastspell_failedtime获得上一次失败的技能时间，
-- _G.spelllist_failed记录失败的施法队列，
-- _G.spelllist_failed[id]为最近一次释放同ID技能失败的列表，键值是name，target，stime

-- 通过访问_G.lastspell_time获得上一次成功的技能ID，
-- _G.lastspell_time获得上一次失败的技能时间，
-- _G.lastspell_cast记录失败的施法队列，
-- _G.spelllist_success[id]为最近一次释放同ID技能成功的列表，键值是name，target，stime
-------------------------------------------------------------------------------------------------------------------
local function reader(self,event,...)
    local timeStamp, param, hideCaster, source, sourceName, sourceFlags, 
    sourceRaidFlags, destination,
    destName, destFlags, destRaidFlags, spell, spellName, _, spellType = CombatLogGetCurrentEventInfo()

    if source == guid then
        if param == "SPELL_CAST_FAILED" then
            if sourceName ~= nil then
                if isInCombat("player") and UnitIsUnit(sourceName,"player") 
                and spell ~= 48018 and spell ~= 48020 then
                    _G.lastspell_failed = spell
                    _G.lastspell_failedtime = GetTime()
                    if _G.spelllist_failed[spell] == nil then 
                        _G.spelllist_failed[spell] = {};
                    end
                    table.insert(_G.spelllist_failed[spell],
                    {name = spellName, target = destination, 
                    stime = _G.lastspell_failedtime})
                    if source == guid then
                        --print(spellName.." 失败原因: "..spellType)
                    end
                    if spell == _G.lastspell_start then
                        _G.lastspell_start = nil
                    end
                end
            end
        end
        
        if param == "SPELL_CAST_START" then
            _G.lastspell_start = spell
        end
        
        if param == "SPELL_CAST_SUCCESS" then
            if sourceName ~= nil then
                if isInCombat("player") and UnitIsUnit(sourceName,"player") 
                then
                    _G.lastspell_time = GetTime()
                    _G.lastspell_cast = spell
                    if _G.spelllist_success[spell] == nil then 
                        _G.spelllist_success[spell] = {};
                    end
                    table.insert(_G.spelllist_success[spell],
                    {name = spellName, target = destination, 
                    stime = _G.lastspell_time})
                    if destination then
                        _G.lastspell_target = destination               
                        GH_Print("成功对 "..destName.." ".."施放了 "..spellName)
                    else
                        _G.lastspell_target = none
                    end
                end
            end
        end
    end
end
frame:SetScript("OnEvent", reader)


-------------------------------------------------------------------------------------------------------------------
-- 记录进入战斗的时间
-- 通过访问_G.data["Combat Started"]获得战斗开始时间，
-- 离开战斗或者玩家死亡，清除所有的_G
-------------------------------------------------------------------------------------------------------------------
local Frame = CreateFrame('Frame')
Frame:RegisterEvent("PLAYER_REGEN_DISABLED")
Frame:RegisterEvent("PLAYER_REGEN_ENABLED")
Frame:RegisterEvent("PLAYER_DEAD")
local function EnteringCombat(self,event,...)
    if event == "PLAYER_REGEN_DISABLED" then
        -- here we should manage stats snapshots
        --AgiSnap = getAgility()
        _G.data["Combat Started"] = GetTime();
        -- _G.data["GCD"] = getGCD();
        --ChatOverlay("|cffFF0000Entering Combat")
        -- SetupTables()
    end
    if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_DEAD"  then
        
        _G.data["Combat Started"] = 0
        _G.lastspell_failed = 0;
        _G.lastspell_failedtime = 0;
        _G.lastspell_cast = 0;
        _G.lastspell_time = 0;
        _G.spelllist_failed = {};
        _G.spelllist_success = {};
        -- _G.data["GCD"] = getGCD();
        -- SetupTables()
        
    end
end
Frame:SetScript("OnEvent",EnteringCombat)
  
--   -------------------------------------------------------------------------------------------------------------------
--   -- 创建队友列表，通过团队时间驱动刷新
--   -- 通过访问_nNova获得列表，
--   -- 
--   -------------------------------------------------------------------------------------------------------------------
--   local updateHealingTable = CreateFrame("frame", nil)
--   updateHealingTable:RegisterEvent("GROUP_ROSTER_UPDATE")
--   updateHealingTable:SetScript("OnEvent", function()
--     table.wipe(_G.nNove)
--     table.wipe(_G.nTank)  
--     SetupTables()
--   end)
  
-- 	-- if _G.nNove == nil then
-- 		-- SetupTables()
-- 	-- end
  
--   function SetupTables()    
    
-- 	table.wipe(_G.nNove)
--     table.wipe(_G.nTank)
--     local group =  IsInRaid() and "raid" or "party" 
--     local groupSize = IsInRaid() and GetNumGroupMembers() or 
--     GetNumGroupMembers() - 1

--     for i=1, groupSize do 
--       local groupUnit = group..i      
--       if UnitExists(groupUnit) then table.insert(_G.nNove, groupUnit); end -- Inserting a newly created Unit into the Main Frame
--       if UnitExists(groupUnit) and UnitGroupRolesAssigned(groupUnit) == "TANK" then table.insert(_G.nTank, groupUnit); end
--     end

--     table.insert(_G.nNove, "player")
	
--   end


local function getGCD()
    local start, duration, enabled, modRate = GetSpellCooldown(61304)
    if GCD == nil then
      GCD = 1.5 / ((UnitSpellHaste("player")/100)+1);
    end
    if duration ~= 0 then
      GCD = duration
    end
    return GCD
end

function rotation:precombat_action()      
    self:rest();
end

function rotation:default_action()
    -- if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;
    
    local spell_haste = GetHaste("player")/100
    local time = (GetTime() - _G.data["Combat Started"]) or 0
    local gcd = getGCD()
    local charges_fractional = getChargesFrac
    local tgtype = self.settings.targets --目标选择
    local counterspell                      = 2139 --法术反制
    local combustion                        = 190319 --燃烧
    local rune_of_power                     = 116011 --法阵
    local rune_of_power_buff                = 116014 --法阵buff
    local kaelthas_ultimate_ability         = 209455 --凯尔萨斯的绝招
    local erupting_infernal_core            = 248147 --爆发的地狱火核心
    local erupting_infernal_core_buff       = 248146 --爆发的地狱火核心
    local fire_blast                        = 108853 --火焰冲击
    local phoenixs_flames                   = 257541 --凤凰烈焰(不死鸟烈焰)
    local blast_wave                        = 157981 --冲击波
    local meteor                            = 153561 --流星
    -- local cinderstorm                       = 198929 --燃烬风暴
    local alexstraszas_fury                 = 235870 --阿莱克斯塔萨之怒
    local hot_streak                        = 48108 --炽热连击
    local heating_up                        = 48107 --热力迸发
    local dragons_breath                    = 31661 --龙息术
    local living_bomb                       = 44457 --活动炸弹
    local lights_judgment                   = 247427 --圣光裁决者
    local flamestrike                       = 2120 --烈焰风暴
    local pyroblast                         = 11366 --炎爆术
    local scorch                            = 2948 --灼烧
    local incanters_flow                    = 116267 --咒术洪流
    local mirror_image                      = 55342 --镜像
    local fireball                          = 133 --火球术
    local pyroclasm                         = 269650 --火焰冲撞

    --过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
    local function filler_unit(Unit)
        if UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3 and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) then
            return true
        else
            return false
        end
    end
    --获得第一个符合条件的目标
    if tgtype.value == "智能" then
        tg = getOneEnemy(40,filler_unit)
        
        --如果有当前目标，并且当前目标可以攻击，则对当前目标攻击
        if UnitExists("target") and isAlive("target") and UnitCanAttack("player","target") then
            tg = "target"
            -- print(tg)
        end
    end
    -- print(tg)
    if tgtype.value ~= "智能" then
        tg = "target"
    end

    local active_enemies = getNumEnemies(tg,8)



    local function active_talents( ... )
        -- actions.active_talents=blast_wave,if=(buff.combustion.down)|(buff.combustion.up&action.fire_blast.charges<1)
        if ( getBuffRemain("player",combustion) <= 0 ) or ( getBuffRemain("player",combustion) > 0 and getCharges(fire_blast) < 1 ) then
            if getTalent(2,3) and getDistance(tg,"player") <= 8 and getSpellCD(blast_wave) <= 0 and castSpell(tg,blast_wave) then
                print(101)
                return true
            end
        end
        -- print(30)
        -- actions.active_talents+=/meteor,if=cooldown.combustion.remains>40|(cooldown.combustion.remains>target.time_to_die)|buff.rune_of_power.up|firestarter.active
        if getSpellCD(combustion) > 40 or ( getSpellCD(combustion) > getTimeToDie(target) ) or  UnitAuraID("player",rune_of_power_buff) or (getTalent(1,1) and getHP("target") >= 90) then
            if getTalent(7,3) and getSpellCD(meteor) <= 0 and castSpell(tg,meteor) then
                print(102)           
                return true
            end
        end
        -- print(31)
        -- actions.active_talents+=/
        -- if  getSpellCD(combustion) < getCastTime(cinderstorm) and ( UnitBuffID("player",rune_of_power_buff) or not  getTalent(3,2) ) or  getSpellCD(combustion) > 10 * spell_haste and  not  (getBuffRemain("player",combustion) > 0) then
        --     if getTalent(7,2) and getSpellCD(cinderstorm) <= 0 and castSpell("player",cinderstorm) then
        --         print(103)
        --         return true
        --     end
        -- end
        -- print(32)
        -- actions.active_talents+=/dragons_breath,if=equipped.132863|(talent.alexstraszas_fury.enabled&!buff.hot_streak.react)
        if  hasEquiped(132863) or ( getTalent(4,2)  and  not  UnitBuffID("player",hot_streak) ) then
            if canCast(dragons_breath) and getDistance(tg,"player") <= 12 and isFacing("player",tg) and castSpell("player",dragons_breath) then
                print(103)
                return true
            end
        end
        -- print(33)
        -- actions.active_talents+=/living_bomb,if=active_enemies>1&buff.combustion.down
        if active_enemies > 1 and getBuffRemain("player",combustion) <= 0 then
            if getTalent(6,3) and getSpellCD(living_bomb) <= 0 and castSpell(tg,living_bomb) then
                print(104)
                return true
            end
        end
        -- print(34)
    end

    local function combustion_phase( ... )
        -- actions.combustion_phase=lights_judgment,if=buff.combustion.down
        if  getBuffRemain("player",combustion) <= 0 then
            if canCast(lights_judgment) and castSpell(tg,lights_judgment) then
                print(201)
                -- return true
            end
        end
        -- actions.combustion_phase+=/rune_of_power,if=buff.combustion.down
        if  getBuffRemain("player",combustion) <= 0 then
            if not UnitBuffID("player",rune_of_power_buff) and getTalent(3,3) and getCharges(rune_of_power) >= 1 and castSpell("player",rune_of_power) then
                print(202)
                -- return true
            end
        end
        -- print(11)
        -- actions.combustion_phase+=/call_action_list,name=active_talents
        if active_talents() then
            print(203)
            -- return true
        end
        -- actions.combustion_phase+=/combustion
        if --[[baofa == true and]] canCast(combustion) and castSpell("player",combustion) then
            print(204)
            -- return true
        end
        -- print(12)
        -- actions.combustion_phase+=/potion
        -- actions.combustion_phase+=/blood_fury
        -- actions.combustion_phase+=/berserking
        -- actions.combustion_phase+=/arcane_torrent
        -- actions.combustion_phase+=/use_items
        -- actions.combustion_phase+=/flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react
        if ( ( getTalent(6,1)  and active_enemies > 2) or active_enemies > 6) and UnitBuffID("player",hot_streak) then
            if getSpellCD(flamestrike) <= 0 and castSpell(tg,flamestrike) then
                print(205)
                -- rm("/cast [@cursor]烈焰风暴")
                return true
            end
        end
        -- print(13)
        -- actions.combustion_phase+=/pyroblast,if=(buff.kaelthas_ultimate_ability.react|buff.pyroclasm.react)&buff.combustion.remains>execute_time
        if ( UnitAuraID("player",kaelthas_ultimate_ability) or UnitAuraID("player",pyroclasm)) and getBuffRemain("player",combustion) > getCastTime(pyroblast) then
            if castSpell(tg,pyroblast,false,false) then
                print(206)
                return true
            end
        end
        -- print(14)
        -- actions.combustion_phase+=/pyroblast,if=buff.hot_streak.react
        if UnitAuraID("player",hot_streak) then
            if castSpell(tg,pyroblast,false,false) then
                print(207)
                return true
            end
        end
        -- print(15)
        -- actions.combustion_phase+=/fire_blast,if=buff.heating_up.react
        if  UnitAuraID("player",heating_up) then
            if getCharges(fire_blast) >= 1 and castSpell(tg,fire_blast,false,false) then
                print(208)
                return true
            end
        end
        -- print(16)
        -- actions.combustion_phase+=/phoenixs_flames
        if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
            print(209)
            return true
        end
        -- print(17)
        -- actions.combustion_phase+=/scorch,if=buff.combustion.remains>cast_time
        if  getBuffRemain("player",combustion) > getCastTime(scorch) then
            if castSpell(tg,scorch,false,false) then
                print(210)
                return true
            end
        end
        -- print(18)
        -- actions.combustion_phase+=/dragons_breath,if=!buff.hot_streak.react&action.fire_blast.charges<1
        if not UnitAuraID("player",hot_streak) and getCharges(fire_blast) < 1 then
            if getDistance(tg,"player") <= 12 and isFacing("player",tg) and canCast(dragons_breath) and castSpell("player",dragons_breath,false,false) then
                print(211)
                return true
            end
        end
        -- print(19)
        -- actions.combustion_phase+=/scorch,if=target.health.pct<=30&(equipped.132454|talent.searing_touch.enabled)
        if  getHP("target") <= 30 and  (hasEquiped(132454) or getTalent(1,3)) then
            if castSpell(tg,scorch,false,false) then
                print(212)
                return true
            end
        end

        -- if hasEquiped(132454) then
        --   for i=1,40 do
        --     if UnitExists(nNove[i]) and UnitExists(nNove[i].."target") and UnitCanAttack("player",nNove[i].."target") and getHP(nNove[i].."target") <= 30 then
        --       if castSpell(tg,scorch,false,false) then
        --         return true
        --       end
        --     end
        --   end
        -- end

    end

    local function rop_phase( ... )
        -- actions.rop_phase=rune_of_power
        if not UnitBuffID("player",rune_of_power_buff) and getTalent(3,3) and getCharges(rune_of_power) >= 1 and castSpell("player",rune_of_power,false,false) then
            print(301)
            -- return true
        end
        -- actions.rop_phase+=/flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|active_enemies>4)&buff.hot_streak.react
        if (( getTalent(6,1)  and active_enemies > 1) or active_enemies > 4) and  UnitAuraID("player",hot_streak) then
            if castSpell(tg,flamestrike) then
            -- rm("/cast [@cursor]烈焰风暴")
                print(302)
                return true
            end
        end
        -- actions.rop_phase+=/pyroblast,if=buff.hot_streak.react
        if UnitAuraID("player",hot_streak) then
            if castSpell(tg,pyroblast,false,false) then
                print(303)
                return true
            end
        end
        -- actions.rop_phase+=/call_action_list,name=active_talents
        if active_talents() then
            print(304)
            return true
        end
        -- actions.rop_phase+=/pyroblast,if=buff.kaelthas_ultimate_ability.react&execute_time<buff.kaelthas_ultimate_ability.remains&buff.rune_of_power.remains>cast_time
        if  UnitAuraID("player",kaelthas_ultimate_ability) and getCastTime(pyroblast) < getBuffRemain("player",kaelthas_ultimate_ability) and getBuffRemain("player",rune_of_power_buff) > getCastTime(pyroblast) then
            if castSpell(tg,pyroblast,false,false) then
                print(305)
                return true
            end
        end
        -- actions.rop_phase+=/pyroblast,if=buff.pyroclasm.react&execute_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time
        if UnitAuraID("player",pyroclasm) and getCastTime(pyroblast) < getBuffRemain("player",pyroclasm) and getBuffRemain("player",rune_of_power_buff) > getCastTime(pyroblast) then
            if castSpell(tg,pyroblast,false,false) then
                print(306)
                return true
            end
        end


        -- actions.rop_phase+=/fire_blast,if=!prev_off_gcd.fire_blast&buff.heating_up.react&firestarter.active&charges_fractional>1.7
        if  not _G.lastspell_cast == fire_blast and  UnitAuraID("player",heating_up) and (getTalent(1,1) and getHP("target") >= 90) and  charges_fractional(fire_blast) > 1.7 then
            if getCharges(fire_blast) >= 1 and castSpell(tg,fire_blast,false,false) then
                print(307)
                return true
            end
        end
        -- actions.rop_phase+=/phoenix_flames,if=!prev_gcd.1.phoenix_flames&charges_fractional>2.7&firestarter.active
        if not _G.lastspell_cast == phoenixs_flames and  charges_fractional(phoenixs_flames) > 2.7 and   (getTalent(1,1) and getHP("target") >= 90) then
            if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
                print(308)
                return true
            end
        end
        -- actions.rop_phase+=/fire_blast,if=!prev_off_gcd.fire_blast&!firestarter.active
        if  not  _G.lastspell_cast == fire_blast and not (getTalent(1,1) and getHP("target") >= 90) then
            if getCharges(fire_blast) >= 1 and castSpell(tg,fire_blast,false,false) then
                print(309)
                return true
            end
        end
        -- actions.rop_phase+=/phoenix_flames,if=!prev_gcd.1.phoenix_flames
        if  not _G.lastspell_cast == phoenixs_flames then
            if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
                print(310)
                return true
            end
        end
        -- actions.rop_phase+=/scorch,if=target.health.pct<=30&(equipped.132454|talent.searing_touch.enabled)
        if  getHP("target") <= 30 and  (hasEquiped(132454) or getTalent(1,3)) then
            if castSpell(tg,scorch,false,false) then
                print(311)
                return true
            end
        end
        -- if hasEquiped(132454) then
        --   for i=1,40 do
        --     if UnitExists(nNove[i]) and UnitExists(nNove[i].."target") and UnitCanAttack("player",nNove[i].."target") and getHP(nNove[i].."target") <= 30 then
        --       if castSpell(tg,scorch,false,false) then
        --         return true
        --       end
        --     end
        --   end
        -- end
        -- actions.rop_phase+=/dragons_breath,if=active_enemies>2
        if active_enemies > 2 then
            if getDistance("player",tg) <= 12 and canCast(dragons_breath) and castSpell("player",dragons_breath,false,false) then
                print(312)
                return true
            end
        end
        -- actions.rop_phase+=/flamestrike,if=(talent.flame_patch.enabled&active_enemies>2)|active_enemies>5
        if ( getTalent(6,1)  and active_enemies > 2) or active_enemies > 5 then
            if castSpell(tg,flamestrike) then
                print(313)
            -- rm("/cast [@cursor]烈焰风暴")
                return true
            end
        end
        -- actions.rop_phase+=/fireball
        if castSpell(tg,fireball,false,false) then
            print(314)
            return true
        end

    end

    local function standard_rotation( ... )
        -- actions.standard_rotation=flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|active_enemies>4)&buff.hot_streak.react
        if (( getTalent(6,1)  and active_enemies > 1) or active_enemies > 4) and  UnitAuraID("player",hot_streak) then
            if castSpell(tg,flamestrike) then
                -- rm("/cast [@cursor]烈焰风暴")
                print(401)
                return true
            end
        end
        -- print(20)
        -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
        if  UnitAuraID("player",hot_streak)  and  getBuffRemain("player",hot_streak) < getCastTime(fireball) then
            if castSpell(tg,pyroblast,false,false) then
                print(402)
                return true
            end
        end
        -- print(21)
        -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&firestarter.active&!talent.rune_of_power.enabled
        if  UnitAuraID("player",hot_streak) and  (getTalent(1,1) and getHP("target") >= 90)   and  not  getTalent(3,3) then
            if castSpell(tg,pyroblast,false,false) then
                print(403)
                return true
            end
        end
        -- print(22)
        -- actions.standard_rotation+=/phoenix_flames,if=charges_fractional>2.7&active_enemies>2
        if   charges_fractional(phoenixs_flames) >2.7 and active_enemies > 2 then
            if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
                print(404)
                return true
            end
        end
        -- print(23)
        -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&(!prev_gcd.1.pyroblast|action.pyroblast.in_flight)
        if UnitAuraID("player",hot_streak) and (not _G.lastspell_cast == pyroblast --[[or action.pyroblast.in_flight]]) then
            if castSpell(tg,pyroblast,false,false) then
                print(405)
                return true
            end
        end
        -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&target.health.pct<=30&equipped.132454
        if  UnitAuraID("player",hot_streak) and  getHP("target") <= 30 and  hasEquiped(132454) then
            if castSpell(tg,pyroblast,false,false) then
                print(406)
                return true
            end
        end
        -- actions.standard_rotation+=/pyroblast,if=buff.kaelthas_ultimate_ability.react&execute_time<buff.kaelthas_ultimate_ability.remains
        if  UnitAuraID("player",kaelthas_ultimate_ability) and getCastTime(pyroblast) < getBuffRemain("player",kaelthas_ultimate_ability) then
            if castSpell(tg,pyroblast,false,false) then
                print(407)
                return true
            end
        end
        -- actions.standard_rotation+=/pyroblast,if=buff.pyroclasm.react&execute_time<buff.pyroclasm.remains
        if  UnitAuraID("player",pyroclasm) and getCastTime(pyroblast) < getBuffRemain("player",pyroclasm) then
            if castSpell(tg,pyroblast,false,false) then
                print(408)
                return true
            end
        end
        -- print(24)
        
        -- print(25)
        
        -- print(26)
        -- actions.standard_rotation+=/call_action_list,name=active_talents
        if active_talents() then
            print(409)
            return true
        end
        -- print(27)
        -- actions.standard_rotation+=/fire_blast,if=!talent.kindling.enabled&buff.heating_up.react&(!talent.rune_of_power.enabled|charges_fractional>1.4|cooldown.combustion.remains<40)&(3-charges_fractional)*(12*spell_haste)<cooldown.combustion.remains+3|target.time_to_die<4
        if  not  getTalent(7,1)  and  UnitAuraID("player",heating_up) and ( not  getTalent(3,3)  or   charges_fractional(fire_blast) > 1.4 or  getSpellCD(combustion) < 40) and (3 -  charges_fractional(fire_blast) )*(12*spell_haste) < getSpellCD(combustion) + 3 or getTimeToDie(tg) < 4 then
            if getCharges(fire_blast) >= 1 and castSpell(tg,fire_blast,false,false) then
                print(410)
                return true
            end
        end
        -- print(28)
        -- actions.standard_rotation+=/fire_blast,if=talent.kindling.enabled&buff.heating_up.react&(!talent.rune_of_power.enabled|charges_fractional>1.5|cooldown.combustion.remains<40)&(3-charges_fractional)*(18*spell_haste)<cooldown.combustion.remains+3|target.time_to_die<4
        if  getTalent(7,1)  and  UnitAuraID("player",heating_up) and ( not  getTalent(3,3)  or   charges_fractional(fire_blast) >1.5 or  getSpellCD(combustion) <40) and (3-  charges_fractional(fire_blast) )*(18*spell_haste)< getSpellCD(combustion) +3 or getTimeToDie(tg) <4 then
            if getCharges(fire_blast) >= 1 and castSpell(tg,fire_blast,false,false) then
                print(411)
                return true
            end
        end
        -- print(29)
        -- actions.standard_rotation+=/phoenix_flames,if=(buff.combustion.up|buff.rune_of_power.up|buff.incanters_flow.stack>3|talent.mirror_image.enabled)&(4-charges_fractional)*13<cooldown.combustion.remains+5|target.time_to_die<10
        if ( UnitAuraID("player",combustion)  or  UnitAuraID("player",rune_of_power_buff)  or  getBuffStacks("player",incanters_flow) > 3 or  getTalent(3,2) ) and  (4-  charges_fractional(phoenixs_flames) )*13< getSpellCD(combustion) +5 or getTimeToDie(tg) <10 then
            if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
                print(412)
                return true
            end
        end
        -- print(29.1)
        -- actions.standard_rotation+=/phoenix_flames,if=(buff.combustion.up|buff.rune_of_power.up)&(4-charges_fractional)*30<cooldown.combustion.remains+5
        if ( UnitAuraID("player",combustion) or  UnitAuraID("player",rune_of_power_buff)) and (4-  charges_fractional(phoenixs_flames) )*30< getSpellCD(combustion) + 5 then
            if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
                print(413)
                return true
            end
        end
        -- print(29.2)
        -- actions.standard_rotation+=/phoenix_flames,if=charges_fractional>2.5&cooldown.combustion.remains>23
        if   charges_fractional(phoenixs_flames) > 2.5 and  getSpellCD(combustion) > 23 then
            if getCharges(phoenixs_flames) >= 1 and castSpell(tg,phoenixs_flames,false,false) then
                print(414)
                return true
            end
        end
        -- print(29.3)
        -- actions.standard_rotation+=/scorch,if=target.health.pct<=30&(equipped.132454|talent.searing_touch.enabled)
        if getHP(tg) <= 30 and ( hasEquiped(132454) or getTalent(1,3) ) then
            if castSpell(tg,scorch,false,false) then
                print(415)
                return true
            end
        end
        -- actions.standard_rotation+=/flamestrike,
        -- if ( getTalent(6,3)  and active_enemies>3) or active_enemies>5 then
        --     rm("/cast [@cursor]烈焰风暴")
        --     return true
        -- end
        -- print(29.4)
        -- actions.standard_rotation+=/scorch,
        -- if  getHP("target") <=30 and  hasEquiped(132454) then
        --     if castSpell(tg,scorch,false,false) then
        --         return true
        --     end
        -- end
        -- print(29.5)
        -- if isMoving("player") then
        --     if castSpell(tg,scorch,false,false) then
        --         return true
        --     end
        -- end
        -- actions.standard_rotation+=/fireball
        if castSpell(tg,fireball,false,false) then
            print(416)
            return true
        end
        -- print(29.6)
        -- actions.standard_rotation+=/scorch
        if castSpell(tg,scorch,false,false) then
            print(417)
            return true
        end
        -- print(29.7)
    end

    -- # Executed every time the actor is available.
    -- actions=counterspell,if=target.debuff.casting.react
    if daduan_enable and canCast(counterspell) and canInterrupt("target",daduan_value) then
    castInterrupt(counterspell,daduan_value,"target")
    end
    -- print(5)
    -- actions+=/time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410&(cooldown.combustion.remains<1|target.time_to_die<50))
    -- actions+=/mirror_image,if=buff.combustion.down
    if getBuffRemain("player",combustion) <= 0 and canCast(mirror_image) then
        castSpell("player",mirror_image)
    end
    -- print(4)
    -- # Standard Talent RoP Logic.
    -- actions+=/rune_of_power,if=firestarter.active&action.rune_of_power.charges=2|cooldown.combustion.remains>40&buff.combustion.down&!talent.kindling.enabled|target.time_to_die<11|talent.kindling.enabled&(charges_fractional>1.8|time<40)&cooldown.combustion.remains>40
    if (getTalent(1,1) and getHP("target") >= 90)  and getCharges(rune_of_power) >= 2 or getSpellCD(combustion) > 40 and getBuffRemain("player",combustion) <= 0 and not getTalent(7,1) or getTimeToDie(tg) < 11 or getTalent(7,1) and ( charges_fractional(rune_of_power) > 1.8 or time < 40 ) and  getSpellCD(combustion) > 40 then
        castSpell("player",rune_of_power)
    end
    -- print(3)
    -- # RoP use while using Legendary Items.
    -- actions+=/rune_of_power,if=((buff.kaelthas_ultimate_ability.react|buff.pyroclasm.react)&(cooldown.combustion.remains>40|action.rune_of_power.charges>1))|(buff.erupting_infernal_core.up&(cooldown.combustion.remains>40|action.rune_of_power.charges>1))
    if (( UnitAuraID("player",kaelthas_ultimate_ability) or UnitAuraID("player",pyroclasm)) and ( getSpellCD(combustion) > 40 or getCharges(rune_of_power) >1)) or ( UnitAuraID("player",erupting_infernal_core_buff) and ( getSpellCD(combustion) > 40 or getCharges(rune_of_power) >1)) then
        castSpell("player",rune_of_power)
    end
    -- print(1)
    -- actions+=/call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)&(!talent.firestarter.enabled|!firestarter.active|active_enemies>=4|active_enemies>=2&talent.flame_patch.enabled)|buff.combustion.up
    local x1 = 0;
    if not getTalent(7,1) then
        x1 = 1;
    end
    if  getSpellCD(combustion) <= getCastTime(rune_of_power) + ( x1 * gcd) and ( not getTalent(1,1) or not (getTalent(1,1) and getHP("target") >= 90) or active_enemies >= 4 or active_enemies>=2 and getTalent(6,1) ) or  UnitBuffID("player",combustion) then
        if combustion_phase() then
            return
        end
    end
    -- print(0)
    -- actions+=/call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
    if  UnitBuffID("player",rune_of_power_buff)  and  getBuffRemain("player",combustion) <= 0 then
        if rop_phase() then
            return
        end
    end
    -- print(6)
    -- actions+=/call_action_list,name=standard_rotation
    if standard_rotation() then
        return
    end

end

-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);