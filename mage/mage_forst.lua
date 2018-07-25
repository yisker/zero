-- 注册全局事件
do
    local guid = UnitGUID("player")
    local frame = CreateFrame('Frame')
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

    if Y == nil then
        Y = {}
    end

    if Y.lastspell_failed == nil then
        Y.lastspell_failed = 0;
    end
    if Y.lastspell_failedtime == nil then
        Y.lastspell_failedtime = 0;
    end
    if Y.lastspell_time == nil then
        Y.lastspell_time = 0;
    end
    if Y.lastspell_cast == nil then
        Y.lastspell_cast = 0;
    end
    if Y.spelllist_failed == nil then 
        Y.spelllist_failed = {};
    end
    if Y.spelllist_success == nil then 
        Y.spelllist_success = {};
    end
    if Y.data == nil then 
        Y.data = {};
    end
    if Y.nNove == nil then 
        Y.nNove = {};
    end
    if Y.nTank == nil then 
        Y.nTank = {};
    end

    -------------------------------------------------------------------------------------------------------------------
    -- 记录进入战斗后自己释放成功和失败的技能队列，

    -- 通过访问Y.lastspell_failed获得上一次失败的技能ID，
    -- Y.lastspell_failedtime获得上一次失败的技能时间，
    -- Y.spelllist_failed记录失败的施法队列，
    -- Y.spelllist_failed[id]为最近一次释放同ID技能失败的列表，键值是name，target，stime

    -- 通过访问Y.lastspell_time获得上一次成功的技能ID，
    -- Y.lastspell_time获得上一次成功的技能时间，
    -- Y.lastspell_cast记录成功的施法队列，
    -- Y.spelllist_success[id]为最近一次释放同ID技能成功的列表，键值是name，target，stime
    -------------------------------------------------------------------------------------------------------------------
    local function reader(self,event,...)
        local timeStamp, param, hideCaster, source, sourceName, sourceFlags, 
        sourceRaidFlags, destination,
        destName, destFlags, destRaidFlags, spell, spellName, _, spellType = CombatLogGetCurrentEventInfo()

        if source == guid then
            if param == "SPELL_CAST_FAILED" then
                if sourceName ~= nil then
                    if isInCombat("player") and UnitIsUnit(sourceName,"player") and spell ~= 48018 and spell ~= 48020 then
                        Y.lastspell_failed = spell 
                        Y.lastspell_failedtime = GetTime()
                        if Y.spelllist_failed[spell] == nil then 
                            Y.spelllist_failed[spell] = {};
                        end
                        table.insert(Y.spelllist_failed[spell],{name = spellName, target = destination, stime = Y.lastspell_failedtime})
                        -- if source == guid then
                            --print(spellName.." 失败原因: "..spellType)
                        -- end
                        if spell == Y.lastspell_start then
                            Y.lastspell_start = 0
                        end
                    end
                end
            end
            
            if param == "SPELL_CAST_START" then
                Y.lastspell_start = spell
            end
            
            if param == "SPELL_CAST_SUCCESS" then
                if sourceName ~= nil then
                    if isInCombat("player") and UnitIsUnit(sourceName,"player") then
                        Y.lastspell_time = GetTime()
                        Y.lastspell_cast = spell
                        if Y.spelllist_success[spell] == nil then 
                            Y.spelllist_success[spell] = {};
                        end
                        table.insert(Y.spelllist_success[spell],{name = spellName, target = destination, stime = Y.lastspell_time})
                        if destination then
                            Y.lastspell_target = destination
                            if self.settings.ydebug.is_enabled then             
                                GH_Print("成功对 "..destName.." ".."施放了 "..spellName)
                            end
                        else
                            Y.lastspell_target = none
                        end
                    end
                end
            end
        end

    end
    frame:SetScript("OnEvent", reader)


    -------------------------------------------------------------------------------------------------------------------
    -- 记录进入战斗的时间
    -- 通过访问Y.data["Combat Started"]获得战斗开始时间，
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
        Y.data["Combat Started"] = GetTime();
        -- Y.data["GCD"] = getGCD();
        if ydebug.is_enabled then
            GH_Print("|cffFF0000进入战斗，开始计时")
        end
        -- SetupTables()
        end
        if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_DEAD"  then
        
            Y.data["Combat Started"] = 0
            Y.lastspell_failed = 0;
            Y.lastspell_failedtime = 0;
            Y.lastspell_cast = 0;
            Y.lastspell_time = 0;
            Y.spelllist_failed = {};
            Y.spelllist_success = {};
            -- Y.data["GCD"] = getGCD();
            -- SetupTables()
            if self.settings.ydebug.is_enabled then
                GH_Print("|cffFF0000离开战斗，重置参数")
            end
        
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
    --     table.wipe(Y.nNove)
    --     table.wipe(Y.nTank)  
    --     SetupTables()
    --   end)
    
    -- 	-- if Y.nNove == nil then
    -- 		-- SetupTables()
    -- 	-- end
    
    --   function SetupTables()    
        
    -- 	table.wipe(Y.nNove)
    --     table.wipe(Y.nTank)
    --     local group =  IsInRaid() and "raid" or "party" 
    --     local groupSize = IsInRaid() and GetNumGroupMembers() or 
    --     GetNumGroupMembers() - 1

    --     for i=1, groupSize do 
    --       local groupUnit = group..i      
    --       if UnitExists(groupUnit) then table.insert(Y.nNove, groupUnit); end -- Inserting a newly created Unit into the Main Frame
    --       if UnitExists(groupUnit) and UnitGroupRolesAssigned(groupUnit) == "TANK" then table.insert(Y.nTank, groupUnit); end
    --     end

    --     table.insert(Y.nNove, "player")
        
    --   end
end




----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "0c02decd-b730-4509-b5bf-259d28ca3c28";
-- 定义循环的英文名称。
local rotation_name = "test";
Scorpio(rotation_name)("");
import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "冰法测试";
    L["Welcome to use test module."] = "欢迎使用冰法测试模块！";
    L["Test 1"] = "测试1号";
    L["Test 2"] = "测试2号";
    L["At least 2 values must be entered."] = "至少要输入2个值";
    L["Test Category"] = "测试类别";
    L["Test 3"] = "测试3号";
    L["Test 4"] = "测试4号";
    L["Test 5"] = "测试5号";
    L["aoetg"] = "暴风雪技能目标";
    L["aoenum"] = "进入AOE循环人数";
    L["targets"] = "目标选择";
end
L = _Locale("zhTW");
if L then
    -- 繁体中文系列。
    L[rotation_name] = "測試";
    L["Welcome to use test module."] = "歡迎使用測試模組！";
    L["Test 1"] = "測試1號";
    L["Test 2"] = "測試2號";
    L["At least 2 values must be entered."] = "至少要输入2个值";
    L["Test Category"] = "測試類別";
    L["Test 3"] = "測試3號";
    L["Test 4"] = "測試4號";
    L["Test 5"] = "測試5號";
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
rotation.macro = "tt";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------

local aoetg_setting = rotation.default_setting_category:create_setting("aoetg"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
aoetg_setting.display_name = L["aoetg"];
aoetg_setting.description = "用来确定暴风雪技能目标释放位置，智能表示放在人群最密集的地方"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
aoetg_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
aoetg_setting.default_value = "智能"; -- 变量默认值
aoetg_setting.optional_values = {"智能", "自己", "小队T", "焦点", "鼠标", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
aoetg_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
aoetg_setting.is_enabled_by_default = false; -- 是否默认启用
aoetg_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
aoetg_setting.value_width = 130; -- 值显示宽度像素（默认为100）


local aoenum_setting = rotation.default_setting_category:create_setting("aoenum"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
aoenum_setting.display_name = L["aoenum"];
aoenum_setting.description = "超过设定人数，进入AOE循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
aoenum_setting.default_value = 3; -- 变量默认值
aoenum_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
aoenum_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
aoenum_setting.is_enabled_by_default = false; -- 是否默认启用
aoenum_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    if (value > 0) then
        return true;
    else
        return false, "The number is too small.";
    end
end;
aoenum_setting.value_width = 100; -- 值显示宽度像素（默认为100）


-- 在类别test_category下添加配置变量test5
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


-- -- 给默认类别添加一个配置变量test1，并配置相关属性。
local ydebug_setting = rotation.default_setting_category:create_setting("ydebug"); -- 指定变量的名字为test1，用于在脚本中进行引用
ydebug_setting.display_name = L["Test 1"]; -- 变量在界面上显示的名字
ydebug_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
ydebug_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
ydebug_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
ydebug_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
ydebug_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
ydebug_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
ydebug_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
ydebug_setting.value_width = 120; -- 值显示宽度像素（默认为100）
-- -- 给默认类别添加一个配置变量test2，并配置相关属性。
-- local test2_setting = rotation.default_setting_category:create_setting("test2"); -- 指定变量的名字为test2，用于在脚本中进行引用（名字不能与test1重复）
-- test2_setting.display_name = L["Test 2"]; -- 变量在界面上显示的名字
-- test2_setting.description = "这是text数组类型的变量，其值为string数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
-- test2_setting.value_type = rotation_setting_type.texts; -- 变量值类型（text数组类型）
-- test2_setting.default_value = {"Hello", "World"}; -- 变量默认值（可以留空则为{}）
-- test2_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框，需用户手动输入多个值，用英文逗号分隔）
-- test2_setting.can_enable_disable = false; -- 是否支持启用停用（不支持则在界面上不显示勾选框）
-- test2_setting.is_enabled_by_default = false; -- 是否默认启用
-- test2_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
--     if (#value > 1) then
--         return true;
--     else
--         return false, L["At least 2 values must be entered."];
--     end
-- end;
-- test2_setting.value_width = 90; -- 值显示宽度像素（默认为100）
-- -- 添加一个自定义类别test_category。
-- local test_category = rotation:create_setting_category("test_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
-- test_category.display_name = L["Test Category"]; -- 类别在界面上显示的名字
-- -- 在类别test_category下添加配置变量test3
-- local test3_setting = test_category:create_setting("test3"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
-- test3_setting.display_name = L["Test 3"];
-- test3_setting.description = "这是plain类型的变量，它没有值。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
-- test3_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
-- test3_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
-- test3_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
-- test3_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
-- test3_setting.is_enabled_by_default = false; -- 是否默认启用
-- test3_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
-- test3_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）
-- -- 在类别test_category下添加配置变量test4
-- local test4_setting = test_category:create_setting("test4"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
-- test4_setting.display_name = L["Test 4"];
-- test4_setting.description = "这是number类型的变量，它只能接受number。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
-- test4_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
-- test4_setting.default_value = 500; -- 变量默认值
-- test4_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
-- test4_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
-- test4_setting.is_enabled_by_default = false; -- 是否默认启用
-- test4_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
--     if (value > 100) then
--         return true;
--     else
--         return false, "The number is too small.";
--     end
-- end;
-- test4_setting.value_width = 80; -- 值显示宽度像素（默认为100）
-- -- 在类别test_category下添加配置变量test5
-- local test5_setting = test_category:create_setting("test5"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
-- test5_setting.display_name = L["Test 5"];
-- test5_setting.description = "这是number类型的变量，它只能接受string。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
-- test5_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
-- test5_setting.default_value = "Hello"; -- 变量默认值
-- test5_setting.optional_values = {"Hello", "World", "Hello, World"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
-- test5_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
-- test5_setting.is_enabled_by_default = false; -- 是否默认启用
-- test5_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
-- test5_setting.value_width = 130; -- 值显示宽度像素（默认为100）
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
    if argument == "baofa" then
        Y.baofa = not Y.baofa
    end
    if Y.baofa == true then
        GH_Print("爆发开启")
        OverlayR("爆发开启")
    else
        GH_Print("爆发关闭")
        OverlayR("爆发关闭")
    end

end
function rotation:condition_action()
    -- 编写判断模块是否可用的脚本。
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 64 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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
function rotation:precombat_action()
    -- 编写在非战斗中循环执行的脚本。
    -- local test1 = self.settings.test1; -- 返回指定配置变量是否启用+当前值。
    -- local test5 = self.settings.test5; -- 返回指定配置变量是否启用+当前值。
    -- print("Precombat", test1.is_enabled, #test1.value, test5.is_enabled, test5.value); -- 这里会打印配置变量的启用状态和值。
    -- local tg = getOneEnemy(40)
    -- if tg then
    --     print(UnitName(tg))
    -- end
    -- castSpell(tg,116)
    self:rest();
end
function rotation:default_action()
    --获得变量
    local aoe_blizzard = self.settings.aoetg --暴风雪
    local aoe_num = self.settings.aoenum --aoe人数
    local tgtype = self.settings.targets --目标选择
    -- print(aoe_blizzard.value)
    -- print(aoe_num.value)
    -- print(tgtype.value == "智能")


    -- 本地化
    local lastSpellCast = Y.lastspell_cast
    -- GH_Print(lastSpellCast)
    -- 不打断施法
    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;

    
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
    -- GH_Print((tg))
    --本地化自己
    local zj = "player"
    --获得目标周围8码的敌人数量
    local active_enemies = getNumEnemies(tg,8) 
    
    -- print(tg)
    -- print(active_enemies)
    -- for i,v in ipairs(et) do
    --     print(i,v)
    -- end
    
    
    local blizzard = 190356 --暴风雪
    -- local frost_bomb = 112948 --寒冰炸弹
    local counterspell = 2139 --法术反制
    local comet_storm = 153595 --彗星风暴
    local zannesu_journey = 206397 --扎奈苏的旅程
    -- local frozen_mass = 242253 --寒冰质量
    local cone_of_cold = 120 --冰锥术
    local mirror_image = 55342 --镜像
    local blood_fury = 20572 --血性狂怒
    local berserking = 26297 --狂暴
    local arcane_torrent = 28730 --奥术洪流
    local lights_judgment = 255647
    local ice_floes = 108839 --浮冰
    local ice_lance = 30455 --冰枪术
    local fingers_of_frost = 44544 --寒冰指
    local flurry = 44614 --冰风暴
    local ice_nova = 157997 --寒冰新星
    local winters_chill = 228358 --深冬之寒
    -- local water_jet = 135029 --水流喷射
    local frostbolt = 116 --寒冰箭
    local brain_freeze = 190446 --冰冷智慧
    local icy_veins = 12472 --冰冷血脉
    local ray_of_frost = 205021 --冰霜射线
    local rune_of_power = 116011 --能量符文
    local rune_of_power_buff = 116014 --能量符文
    local ebonbolt = 257537 --黑冰箭
    local glacial_spike = 199786 --冰川尖刺
    local icicles = 205473 --冰刺
    local frozen_orb = 84714 --寒冰寶珠
    
    
    
    -- local tier20_2pc = false  
    
    local charges_fractional = getChargesFrac
    
    -- local function charges_fractional(Name)
    --     -- body
    --     -- ChargesRemaining(spellName) + ((SpellCooldownSec(spellName) - ChargeSecRemaining(spellName)) / SpellCooldownSec(spellName))
    --     local function SpellCooldownSec(Name)
    --         -- body
    --         return select(2,GetSpellCharges(Name)) * select(4,GetSpellCharges(Name))
    --     end

    --     return getCharges(Name) + (( SpellCooldownSec(Name) - getChargesCD(Name) ) / SpellCooldownSec(Name) )
    -- end


    
    
    -- # Executed every time the actor is available.
    -- actions=counterspell
    -- # Free Ice Lance after Flurry. This action has rather high priority to ensure that we don't cast Rune of Power, Ray of Frost, etc. after Flurry and break up the combo. If FoF was already active, we do not lose anything by delaying the Ice Lance.
    -- actions+=/ice_lance, if  not   UnitBuffID("player",) fingers_of_frost.react and  lastSpellCast .1.flurry
    -- # Time Warp is used right at the start. If the actor has Shard of the Exodar, try to synchronize the second Time Warp with Icy Veins. If the target is about to die, use Time Warp regardless.
    -- actions+=/time_warp, if  UnitBuffID("player",) bloodlust.down and ( UnitBuffID("player",) exhaustion.down or equipped.shard_of_the_exodar) and ( getSpellCD() .icy_veins.remains<1 or  getTimeToDie(tg) <50)
    -- actions+=/call_action_list,name= getSpellCD() s
    -- actions+=/call_action_list,name=aoe, if active_enemies>=3
    -- actions+=/call_action_list,name=single
    
    
    local function aoe( ... )
        -- body
        -- actions.aoe+=/frozen_orb
        if canCast(frozen_orb) and castSpell(tg,frozen_orb) then
            print(101)
            return true
        end
        -- actions.aoe+=/blizzard
        -- if canCast(blizzard) and castSpell(tg,blizzard) then
        --     print(102)
        --     return true
        -- end
        if canCast(blizzard) then
            if aoe_blizzard.value == "智能" then
                local tg1 = getBiggestUnitCluster(30,10,filler_unit)
                if tg1 == nil then tg1 = "target";end
                castSpell(tg1,blizzard)
            elseif aoe_blizzard.value == "自己" then
                local tg1 = "player"
                castSpell(tg1,blizzard)
            elseif aoe_blizzard.value == "小队T" then
                local tg1 = getMT()
                castSpell(tg1,blizzard)
            elseif aoe_blizzard.value == "焦点" then
                castSpell("focus",blizzard)
            elseif aoe_blizzard.value == "鼠标" then
                castSpell("mouseover",blizzard)
            elseif aoe_blizzard.value == "当前目标" then
                castSpell("target",blizzard)
            end
        end
        -- actions.aoe+=/comet_storm
        if canCast(comet_storm) and castSpell(tg,comet_storm) then
            print(103)
            return true
        end
        -- actions.aoe+=/ice_nova
        if canCast(ice_nova) and castSpell(tg,ice_nova) then
            print(104)
            return true
        end
        -- actions.aoe+=/flurry,if=prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.frostbolt&(buff.icicles.stack<4|!talent.glacial_spike.enabled)|prev_gcd.1.glacial_spike)
        if lastSpellCast == ebonbolt or UnitBuffID("player",brain_freeze) and ( lastSpellCast == frostbolt and ( getBuffStacks("player",icicles) < 4 or not getTalent(7,3) ) or lastSpellCast == glacial_spike ) then
            if canCast(flurry) and castSpell(tg,flurry) then
                print(105)
                return true
            end
        end
        -- actions.aoe+=/ice_lance,if=buff.fingers_of_frost.react
        if  UnitBuffID("player",fingers_of_frost) then
            if canCast(ice_lance) and castSpell(tg,ice_lance) then
                print(106)
                return true
            end
        end
        -- actions.aoe+=/ray_of_frost
        if canCast(ray_of_frost) and castSpell(tg,ray_of_frost) then
            print(107)
            return true
        end
        -- actions.aoe+=/ebonbolt
        if canCast(ebonbolt) and castSpell(tg,ebonbolt) then
            print(108)
            return true
        end
        -- actions.aoe+=/glacial_spike
        if canCast(glacial_spike) and castSpell(tg,glacial_spike) then
            print(109)
            return true
        end
        -- actions.aoe+=/cone_of_cold
        if canCast(cone_of_cold) and castSpell(tg,cone_of_cold) then
            print(110)
            return true
        end
        -- actions.aoe+=/frostbolt
        if canCast(frostbolt) and castSpell(tg,frostbolt) then
            print(111)
            return true
        end
        -- actions.aoe+=/call_action_list,name=movement
        -- if isMoving("player") and movement() then
        --     print(112)
        --     return true
        -- end
        -- actions.aoe+=/ice_lance
        if canCast(ice_lance) and castSpell(tg,ice_lance) then
            print(113)
            return true
        end        
    end
    
    
    local function cooldowns( ... )
        -- body
        -- actions.cooldowns=icy_veins
        if canCast(icy_veins) and castSpell(zj,icy_veins) then
            print(201)
            return true
        end
        -- actions.cooldowns+=/mirror_image
        if canCast(mirror_image) and castSpell(zj,mirror_image) then
            print(202)
            return true
        end
        -- actions.cooldowns+=/rune_of_power,if=time_to_die>10+cast_time&time_to_die<25
        if getTimeToDie(tg) > 10 + getCastTime(rune_of_power) and getTimeToDie(tg) < 25 then
            if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
                print(203)
                return true
            end
        end
        -- actions.cooldowns+=/rune_of_power,if=active_enemies=1&talent.glacial_spike.enabled&buff.icicles.stack=5&(!talent.ebonbolt.enabled&buff.brain_freeze.react|talent.ebonbolt.enabled&(full_recharge_time<=cooldown.ebonbolt.remains&buff.brain_freeze.react|cooldown.ebonbolt.remains<cast_time&!buff.brain_freeze.react))
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
        if active_enemies == 1 and getTalent(7,3) and getBuffStacks("player",icicles) == 5 and (not getTalent(4,3) and UnitBuffID("player",brain_freeze) or getTalent(4,3) and ( full_recharge_time(rune_of_power) <= getSpellCD(ebonbolt) and UnitBuffID("player",brain_freeze) or getSpellCD(ebonbolt) < getCastTime(rune_of_power) and not UnitBuffID("player",brain_freeze) )) then
            if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
                print(204)
                return true
            end
        end
        -- actions.cooldowns+=/rune_of_power,if=active_enemies=1&!talent.glacial_spike.enabled&(prev_gcd.1.frozen_orb|talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time|talent.comet_storm.enabled&cooldown.comet_storm.remains<cast_time|talent.ray_of_frost.enabled&cooldown.ray_of_frost.remains<cast_time|charges_fractional>1.9)
        if active_enemies == 1 and not getTalent(7,3) and (lastSpellCast == frozen_orb or getTalent(4,3) and getSpellCD(ebonbolt) < getCastTime(rune_of_power) or getTalent(6,3) and getSpellCD(comet_storm) < getCastTime(rune_of_power) or getTalent(7,2) and getSpellCD(ray_of_frost) < getCastTime(rune_of_power) or charges_fractional(rune_of_power) > 1.9) then
            if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
                print(205)
                return true
            end
        end
        -- actions.cooldowns+=/rune_of_power,if=active_enemies>1&prev_gcd.1.frozen_orb
        if active_enemies > 1 and lastSpellCast == frozen_orb then
            if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
                print(206)
                return true
            end
        end
        -- actions.cooldowns+=/potion,if=prev_gcd.1.icy_veins|target.time_to_die<70
        -- actions.cooldowns+=/use_items
        if canUse(13) and useItem(13) then
            print(207)
            return true
        end
        if canUse(14) and useItem(14) then
            print(208)
            return true
        end
        -- actions.cooldowns+=/blood_fury
        if canCast(blood_fury) and castSpell(zj,blood_fury) then
            print(209)
            return true
        end
        -- actions.cooldowns+=/berserking
        if canCast(berserking) and castSpell(zj,berserking) then
            print(210)
            return true
        end
        -- actions.cooldowns+=/lights_judgment
        
    end
    
    
    
    local function movement( ... )
        -- body
        -- actions.movement=blink,if=movement.distance>10
        -- actions.movement+=/ice_floes,if=buff.ice_floes.down
        if not UnitBuffID("player",ice_floes) then
            if canCast(ice_floes) and castSpell(zj,ice_floes) then
                print(401)
                return true
            end
        end
    
    end
    
    
    
    local function single( ... )
        -- body
        -- actions.single=ice_nova,if=cooldown.ice_nova.ready&debuff.winters_chill.up
        if getSpellCD(ice_nova) == 0 and UnitDebuffID(tg,winters_chill) then
            if canCast(ice_nova) and castSpell(tg,ice_nova) then
                print(301)
                return true
            end
        end
        -- actions.single+=/flurry,if=!talent.glacial_spike.enabled&(prev_gcd.1.ebonbolt|buff.brain_freeze.react&prev_gcd.1.frostbolt)
        if not getTalent(7,3) and (lastSpellCast == ebonbolt or UnitBuffID("player",brain_freeze) and lastSpellCast== frostbolt) then
            if canCast(flurry) and castSpell(tg,flurry) then
                print(302)
                return true
            end
        end
        -- actions.single+=/flurry,if=talent.glacial_spike.enabled&buff.brain_freeze.react&(prev_gcd.1.frostbolt&buff.icicles.stack<4|prev_gcd.1.glacial_spike|prev_gcd.1.ebonbolt)
        if getTalent(7,3) and UnitBuffID("player",brain_freeze) and (lastSpellCast == frostbolt and getBuffStacks("player",icicles) < 4 or lastSpellCast == glacial_spike or lastSpellCast == ebonbolt) then
            if canCast(flurry) and castSpell(tg,flurry) then
                print(303)
                return true
            end
        end
        -- actions.single+=/frozen_orb
        if canCast(frozen_orb) and castSpell(tg,frozen_orb) then
            print(304)
            return true
        end
        -- actions.single+=/blizzard,if=active_enemies>2|active_enemies>1&cast_time=0&buff.fingers_of_frost.react<2
        if active_enemies > 2 or active_enemies > 1 and getCastTime(blizzard) == 0 and getBuffRemain("player",fingers_of_frost) < 2 then
            if canCast(blizzard) and castSpell(tg,blizzard) then
                print(305)
                return true
            end
        end
        -- actions.single+=/ice_lance,if=buff.fingers_of_frost.react
        if  UnitBuffID("player",fingers_of_frost) then
            if canCast(ice_lance) and castSpell(tg,ice_lance) then
                print(306)
                return true
            end
        end
        -- actions.single+=/ray_of_frost,if=!action.frozen_orb.in_flight&ground_aoe.frozen_orb.remains=0
        if --[[not action.frozen_orb.in_flight and ]]active_enemies < 2 then
            if canCast(ray_of_frost) and castSpell(tg,ray_of_frost) then
                print(307)
                return true
            end
        end
        -- actions.single+=/comet_storm
        if canCast(comet_storm) and castSpell(tg,comet_storm) then
            print(308)
            return true
        end
        -- actions.single+=/ebonbolt,if=!talent.glacial_spike.enabled|buff.icicles.stack=5&!buff.brain_freeze.react
        if not getTalent(7,3) or getBuffStacks("player",icicles) == 5 and not UnitBuffID("player",brain_freeze) then
            if canCast(ebonbolt) and castSpell(tg,ebonbolt) then
                print(309)
                return true
            end
        end
        -- actions.single+=/glacial_spike,if=buff.brain_freeze.react|prev_gcd.1.ebonbolt|active_enemies>1&talent.splitting_ice.enabled
        if UnitBuffID("player",brain_freeze) or lastSpellCast == ebonbolt or active_enemies > 1 and getTalent(6,2) then
            if canCast(glacial_spike) and castSpell(tg,glacial_spike) then
                print(310)
                return true
            end
        end
        -- actions.single+=/blizzard,if=cast_time=0|active_enemies>1|buff.zannesu_journey.stack=5&buff.zannesu_journey.remains>cast_time
        if getCastTime(blizzard) == 0 or active_enemies > 1 or getBuffStacks("player",zannesu_journey) == 5 and getBuffRemain("player",zannesu_journey) > getCastTime(blizzard) then
            if canCast(blizzard) and castSpell(tg,blizzard) then
                print(311)
                return true
            end
        end
        -- actions.single+=/ice_nova
        if canCast(ice_nova) and castSpell(tg,ice_nova) then
            print(312)
            return true
        end
        -- actions.single+=/frostbolt
        if canCast(frostbolt) and castSpell(tg,frostbolt) then
            print(313)
            return true
        end
        -- actions.single+=/call_action_list,name=movement
        --這裏判斷也有問題
        if isMoving("player") and movement() then
            print(314)
            return true
        end
        -- actions.single+=/ice_lance
        if canCast(ice_lance) and castSpell(tg,ice_lance) then
            print(315)
            return true
        end        
    
    end

    -- # Executed every time the actor is available.
    -- actions=counterspell
    -- # Free Ice Lance after Flurry. This action has rather high priority to ensure that we don't cast Rune of Power, Ray of Frost, etc. after Flurry and break up the combo. If FoF was already active, we do not lose anything by delaying the Ice Lance.
    -- actions+=/ice_lance,if=prev_gcd.1.flurry&!buff.fingers_of_frost.react
    if lastSpellCast == flurry and not UnitBuffID("player",fingers_of_frost) then
        if castSpell("target",ice_lance) then
            print(1)
            return true
        end
    end
    -- # Time Warp is used right at the start. If the actor has Shard of the Exodar, try to synchronize the second Time Warp with Icy Veins. If the target is about to die, use Time Warp regardless.
    -- actions+=/time_warp,if=buff.bloodlust.down&(buff.exhaustion.down|equipped.shard_of_the_exodar)&(prev_gcd.1.icy_veins|target.time_to_die<50)
    -- actions+=/call_action_list,name=cooldowns
    if isKeyDown("1") or Y.baofa == true then 
        cooldowns() 
        -- return true
    end
    -- actions+=/call_action_list,name=aoe,if=active_enemies>3&talent.freezing_rain.enabled|active_enemies>4
    if active_enemies >= aoe_num.value - 1 and getTalent(6,2) or active_enemies > aoe_num.value then
        print(2)
        if aoe() then
            return true
        end
    end
    
    -- actions+=/call_action_list,name=single
    single()
    -- GH_Print(1)
    self:rest();


end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);