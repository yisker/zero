----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "c7cba9a6-34e9-458a-a77d-bba64d6310ac";
-- 定义循环的英文名称。
local rotation_name = "tafeng";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "踏风测试";
    L["Welcome to use test module."] = "欢迎使用踏风测试模块！";
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
    L["ydebug"] = "调试信息";
    L["zlsyz"] = "治疗石阈值"
    L["lgsh"] = "灵龟守护阈值"
    L["ddyz"] = "打断阈值"
    L["pethp"] = "宠物治疗"
    L["spsolt"] = "使用饰品"
    L["wd"] = "误导"
    L["Touch_of_Death"] = "爆发"
end
-- L = _Locale("zhTW");
-- if L then
--     -- 繁体中文系列。
--     L[rotation_name] = "測試";
--     L["Welcome to use test module."] = "歡迎使用測試模組！";
--     L["Test 1"] = "測試1號";
--     L["Test 2"] = "測試2號";
--     L["At least 2 values must be entered."] = "至少要输入2个值";
--     L["Test Category"] = "測試類別";
--     L["Test 3"] = "測試3號";
--     L["Test 4"] = "測試4號";
--     L["Test 5"] = "測試5號";
-- end
L = _Locale;
local rotation = zeus.rotation(rotation_id, L[rotation_name]);
-- 定义循环加载并可用时的消息，填入"N/A"则不显示。
rotation.condition_yes_message = L["Welcome to use test module."];
-- 定义循环加载并不可用时的消息，填入"N/A"则不显示。
rotation.condition_no_message = "N/A";
-- 定义循环的执行间隔（秒），如果不设默认是0.1。
rotation.interval = 0.1;
-- 定义模块专用宏命令，下面的例子会定义出：/zeus test [argument]。如果不需要宏控制，则删除下面一行。
rotation.macro = "tafeng";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------

do
    -- local aoetg_setting = rotation.default_setting_category:create_setting("aoetg"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    -- aoetg_setting.display_name = L["aoetg"];
    -- aoetg_setting.description = "用来确定暴风雪技能目标释放位置，智能表示放在人群最密集的地方"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    -- aoetg_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    -- aoetg_setting.default_value = "智能"; -- 变量默认值
    -- aoetg_setting.optional_values = {"智能", "自己", "小队T", "焦点", "鼠标", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    -- aoetg_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    -- aoetg_setting.is_enabled_by_default = false; -- 是否默认启用
    -- aoetg_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    -- aoetg_setting.value_width = 130; -- 值显示宽度像素（默认为100）


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

    if UnitName("player") == "Ylx" then
    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local ydebug_setting = rotation.default_setting_category:create_setting("ydebug"); -- 指定变量的名字为test1，用于在脚本中进行引用
    ydebug_setting.display_name = L["ydebug"]; -- 变量在界面上显示的名字
    ydebug_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ydebug_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    ydebug_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    ydebug_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    ydebug_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ydebug_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    ydebug_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    ydebug_setting.value_width = 120; -- 值显示宽度像素（默认为100）
    end

    local zlsyz_setting = rotation.default_setting_category:create_setting("zlsyz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zlsyz_setting.display_name = L["zlsyz"];
    zlsyz_setting.description = "低于阈值且治疗石可用，使用治疗石疗伤"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zlsyz_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    zlsyz_setting.default_value = 20; -- 变量默认值
    zlsyz_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    zlsyz_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zlsyz_setting.is_enabled_by_default = false; -- 是否默认启用
    zlsyz_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    zlsyz_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    -- local lgsh_setting = rotation.default_setting_category:create_setting("lgsh"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    -- lgsh_setting.display_name = L["lgsh"];
    -- lgsh_setting.description = "低于阈值且灵龟守护可用，使用灵龟守护疗伤"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    -- lgsh_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    -- lgsh_setting.default_value = 30; -- 变量默认值
    -- lgsh_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    -- lgsh_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    -- lgsh_setting.is_enabled_by_default = true; -- 是否默认启用
    -- lgsh_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    --     if (value > 0 or value <= 100) then
    --         return true;
    --     else
    --         return false, "The number is not right.";
    --     end
    -- end;
    -- lgsh_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local ddyz_setting = rotation.default_setting_category:create_setting("ddyz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    ddyz_setting.display_name = L["ddyz"];
    ddyz_setting.description = "设置是否启用打断"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ddyz_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    ddyz_setting.default_value = 0.4; -- 变量默认值
    ddyz_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    ddyz_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ddyz_setting.is_enabled_by_default = false; -- 是否默认启用
    ddyz_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 1) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    ddyz_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    -- local pethp_setting = rotation.default_setting_category:create_setting("pethp"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    -- pethp_setting.display_name = L["pethp"];
    -- pethp_setting.description = "设置是否启用打断"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    -- pethp_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    -- pethp_setting.default_value = 70; -- 变量默认值
    -- pethp_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    -- pethp_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    -- pethp_setting.is_enabled_by_default = false; -- 是否默认启用
    -- pethp_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    --     if (value > 0 or value <= 100) then
    --         return true;
    --     else
    --         return false, "The number is not right.";
    --     end
    -- end;
    -- pethp_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    -- 在类别test_category下添加配置变量test5
    local spsolt_setting = rotation.default_setting_category:create_setting("spsolt"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    spsolt_setting.display_name = L["spsolt"];
    spsolt_setting.description = "确定是否使用主动饰品，使用哪一个栏位的饰品"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    spsolt_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    spsolt_setting.default_value = "全部"; -- 变量默认值
    spsolt_setting.optional_values = {"全部", "第一栏位", "第二栏位"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    spsolt_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    spsolt_setting.is_enabled_by_default = true; -- 是否默认启用
    spsolt_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    spsolt_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    -- local wd_setting = rotation.default_setting_category:create_setting("wd"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    -- wd_setting.display_name = L["wd"];
    -- wd_setting.description = "确定是否使用误导，误导谁"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    -- wd_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    -- wd_setting.default_value = "宠物"; -- 变量默认值
    -- wd_setting.optional_values = {"宠物", "当前T"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    -- wd_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    -- wd_setting.is_enabled_by_default = true; -- 是否默认启用
    -- wd_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    -- wd_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local Touch_of_Death_setting = rotation.default_setting_category:create_setting("Touch_of_Death"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    Touch_of_Death_setting.display_name = L["Touch_of_Death"];
    Touch_of_Death_setting.description = "按住这个键开启爆发！"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    Touch_of_Death_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    Touch_of_Death_setting.default_value = "q"; -- 变量默认值
    Touch_of_Death_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    Touch_of_Death_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    Touch_of_Death_setting.is_enabled_by_default = true; -- 是否默认启用
    Touch_of_Death_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (#value == 1 ) then
            return true;
        else
            return false, "没有这个按键";
        end
    end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    Touch_of_Death_setting.value_width = 130; -- 值显示宽度像素（默认为100）

end
-----------------------------------------------------------
--注册事件
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

    if tt == nil then
        tt = 0
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
    
    --  -- if Y.nNove == nil then
    --      -- SetupTables()
    --  -- end
    
    --   function SetupTables()    
        
    --  table.wipe(Y.nNove)
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
    local speci = 269 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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

    local bf = self.settings.Touch_of_Death.value --爆发

    

    if isKeyDown(bf) and GetTime() - tt > 1 then
        baofa = not baofa
        tt = GetTime()
        if baofa then
            GH_Print("爆发开启")
            OverlayY("爆发开启")
        else
            GH_Print("爆发关闭")
            OverlayY("爆发关闭")
        end
    end

end

function rotation:default_action()

    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;
    
    self:rest();
    
    local spell_haste = GetHaste("player")/100
    local time = (GetTime() - Y.data["Combat Started"]) or 0
    local gcd = getGCD()
    local charges_fractional = getChargesFrac
    -- local regen = select(2,GetPowerRegen("player"))
	-- local focus = getRealMana("player")
    local castSpell = csi


    local tgtype = self.settings.targets --目标选择
    local zlsyz = self.settings.zlsyz --治疗石
    -- local lgsh = self.settings.lgsh --灵龟守护
    local ddyz = self.settings.ddyz --打断
    -- local pethp = self.settings.pethp --宠物治疗
    local spsolt = self.settings.spsolt --饰品
    local aoenum = self.settings.aoenum --饰品
    -- local wd = self.settings.wd --误导
    local bf = self.settings.Touch_of_Death.value --爆发

    if isKeyDown(bf) and GetTime() - tt > 1 then
        baofa = not baofa
        tt = GetTime()
        if baofa then
            GH_Print("爆发开启")
            OverlayY("爆发开启")
        else
            GH_Print("爆发关闭")
            OverlayY("爆发关闭")
        end
    end
    
    

    --过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
    local function filler_unit(Unit)
        if (UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) then
            return true
        else
            return false
        end
    end
    --获得第一个符合条件的目标
    if tgtype.value == "智能" then
        tg = getOneEnemy(8,filler_unit)
        
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
    if tg then
        TargetUnit(tg)
    end
    local active_enemies = getNumEnemies(tg,8)
    local spell_targets = active_enemies

    if time < 2 then
        AttackTarget()
    end

    if baofa and canCast(115080) and castSpell(tg,115080) then
        print(11)
    end

    if baofa and  canCast(138130) and castSpell(tg,138130) then
        print(22)
    end

    if baofa and  canCast(123904) and castSpell(tg,123904) then
        print(33)
    end


    if active_enemies <= aoenum.value then

        -- Use Fists of Fury Icon Fists of Fury.
        if canCast(113656) and castSpell(tg,113656) then
            print(101)
        end
        -- Use Fist of the White Tiger Icon Fist of the White Tiger.
        if canCast(261947) and castSpell(tg,261947) then
            print(102)
        end
        -- Use Rising Sun Kick Icon Rising Sun Kick if Whirling Dragon Punch Icon Whirling Dragon Punch is coming off cooldown.
        if getSpellCD(152175) <= gcd and canCast(107428) and castSpell(tg,107428) then
            print(103)
        end
        -- Use Whirling Dragon Punch Icon Whirling Dragon Punch.
        if canCast(152175) and castSpell(tg,152175) then
            print(104)
        end
        -- Use Blackout Kick Icon Blackout Kick.
        if canCast(100784) and castSpell(tg,100784) then
            print(104)
        end
        -- Use Tiger Palm Icon Tiger Palm if you have 3 or less Chi.
        if getChi("player") <= 3 and canCast(100780) and castSpell(tg,100780) then
            print(105)
        end
        -- Use Rising Sun Kick Icon Rising Sun Kick if you are close to capping Chi.
        if getChi("player") >= 5 and canCast(107428) and castSpell(tg,107428) then
            print(106)
        end
        -- Keep in mind that Tiger Palm Icon Tiger Palm has a chance to cause the next Blackout Kick Icon Blackout Kick not to cost any Chi.
        -- Use Tiger Palm Icon Tiger Palm.
        if canCast(100780) and castSpell(tg,100780) then
            print(107)
        end

    end


    if active_enemies > aoenum.value then  
        -- Use Whirling Dragon Punch Icon Whirling Dragon Punch. 
        if canCast(152175) and castSpell(tg,152175) then
            print(201)
        end
        -- Use Fists of Fury Icon Fists of Fury.
        if canCast(113656) and castSpell(tg,113656) then
            print(202)
        end
        -- Use Fist of the White Tiger Icon Fist of the White Tiger.
        if canCast(261947) and castSpell(tg,261947) then
            print(203)
        end
        -- Use Spinning Crane Kick Icon Spinning Crane Kick on 3 or more targets.
        if canCast(107270) and castSpell(tg,107270) then
            print(203)
        end
        -- Use Blackout Kick Icon Blackout Kick.
        if canCast(100784) and castSpell(tg,100784) then
            print(204)
        end
        -- Use Tiger Palm Icon Tiger Palm.
        if canCast(100780) and castSpell(tg,100780) then
            print(205)
        end

    end

end

-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);