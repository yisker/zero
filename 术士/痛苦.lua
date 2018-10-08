----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "f09afc3f-44a4-43ad-9551-b24001b4b660";
-- 定义循环的英文名称。
local rotation_name = "warlock_affliction";
Scorpio("zeus." .. rotation_name)("");
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then 
   -- 简体中文系列。
   L[rotation_name] = "术士-痛苦";
   L["Welcome to use warlock_affliction module."] = "欢迎使用痛苦术士模块！";
    
end
local rotation = zeus.rotation(rotation_id, L[rotation_name]);
-- 定义循环加载并可用时的消息,填入"N/A"则不显示。rm("/targetenemy [help][dead][noexists]")
rotation.condition_yes_message = L["Welcome to use warlock_affliction module."];
-- 定义循环加载并不可用时的消息,填入"N/A"则不显示。
rotation.condition_no_message = "N/A";
-- 定义循环的执行间隔（秒）,如果不设默认是0.1。
rotation.interval = 0.05;
rotation.macro = "tongku";
-----------------------------------------------------------
--UI
do

    -- -- 添加一个自定义类别test_category。
    local jc_category = rotation:create_setting_category("jc_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    jc_category.display_name = L["|cff00FFFF基础设置"]; -- 类别在界面上显示的名字

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local ydebug_setting = jc_category:create_setting("ydebug"); -- 指定变量的名字为test1，用于在脚本中进行引用
    ydebug_setting.display_name = L["调试信息"]; -- 变量在界面上显示的名字
    ydebug_setting.description = "打开屏幕打印。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ydebug_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    ydebug_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    ydebug_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    ydebug_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ydebug_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    ydebug_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    ydebug_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local isbus_setting = jc_category:create_setting("isbus"); -- 指定变量的名字为test1，用于在脚本中进行引用
    isbus_setting.display_name = L["有坐骑不打怪"]; -- 变量在界面上显示的名字
    isbus_setting.description = "有坐骑不打怪"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    isbus_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    isbus_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    isbus_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    isbus_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    isbus_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    isbus_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    isbus_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    -- -- 添加一个自定义类别test_category。
    local hps_category = rotation:create_setting_category("hps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    hps_category.display_name = L["|cff00FFFF治疗设置"]; -- 类别在界面上显示的名字

    local zls_setting = hps_category:create_setting("zls"); 
    zls_setting.display_name = L["治疗石阀值"];
    zls_setting.description = "治疗石阀值";
    zls_setting.value_type = rotation_setting_type.number; 
    zls_setting.default_value = 35; 
    zls_setting.optional_values = nil; 
    zls_setting.can_enable_disable = false; 
    zls_setting.is_enabled_by_default = false; 
    zls_setting.validator = function(self, value) 
    if (value >= 0 and value < 100) then
        return true;
    else
        return false, "The number is too small.";
    end
    end;
    zls_setting.value_width = 120;

    --不灭决心阀值
    local bumie_setting = hps_category:create_setting("bumie"); 
    bumie_setting.display_name = L["不灭决心阀值"];
    bumie_setting.description = "不灭决心阀值";
    bumie_setting.value_type = rotation_setting_type.number; 
    bumie_setting.default_value = 20; 
    bumie_setting.optional_values = nil; 
    bumie_setting.can_enable_disable = false; 
    bumie_setting.is_enabled_by_default = false; 
    bumie_setting.validator = function(self, value) 
    if (value >= 0 and value < 100) then
        return true;
    else
        return false, "The number is too small.";
    end
    end;
    bumie_setting.value_width = 80;

    -- 黑暗契约阀值 
    local qiyue_setting = hps_category:create_setting("qiyue"); 
    qiyue_setting.display_name = L["黑暗契约阀值"];
    qiyue_setting.description = "黑暗契约阀值";
    qiyue_setting.value_type = rotation_setting_type.number; 
    qiyue_setting.default_value = 0; 
    qiyue_setting.optional_values = nil; 
    qiyue_setting.can_enable_disable = false; 
    qiyue_setting.is_enabled_by_default = false; 
    qiyue_setting.validator = function(self, value) 
    if (value >= 0 and value < 100) then
        return true;
    else
        return false, "The number is too small.";
    end
    end;
    qiyue_setting.value_width = 80;




    -- -- 添加一个自定义类别test_category。
    local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    dps_category.display_name = L["|cff00FFFF输出设置"]; -- 类别在界面上显示的名字

    -- 在类别test_category下添加配置变量test5
    local targets_setting = dps_category:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    targets_setting.display_name = L["目标选择"];
    targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    targets_setting.default_value = "智能"; -- 变量默认值
    targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    targets_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    targets_setting.is_enabled_by_default = false; -- 是否默认启用
    targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    targets_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local cascading_calamity_setting = dps_category:create_setting("cascading_calamity"); -- 指定变量的名字为test1，用于在脚本中进行引用
    cascading_calamity_setting.display_name = L["是否点出275376特质"]; -- 变量在界面上显示的名字
    cascading_calamity_setting.description = "是否点出cascading_calamity"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    cascading_calamity_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    cascading_calamity_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    cascading_calamity_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    cascading_calamity_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    cascading_calamity_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    cascading_calamity_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    cascading_calamity_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    -- 自动招宝宝
    local ZDzhaobb_setting = dps_category:create_setting("ZDzhaobb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    ZDzhaobb_setting.display_name = L["自动招宝宝"];
    ZDzhaobb_setting.description = "自动招宝宝"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ZDzhaobb_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
    ZDzhaobb_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
    ZDzhaobb_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
    ZDzhaobb_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
    ZDzhaobb_setting.is_enabled_by_default = true; -- 是否默认启用
    ZDzhaobb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
    ZDzhaobb_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

    --选择宝宝类型
    local BB_setting = dps_category:create_setting("BB"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    BB_setting.display_name = L["选择宝宝类型"];
    BB_setting.description = "选择宝宝类型"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    BB_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    BB_setting.default_value = "小鬼"; -- 变量默认值
    BB_setting.optional_values = {"小鬼","虚空行者","地狱猎犬","魅魔"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    BB_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    BB_setting.is_enabled_by_default = false; -- 是否默认启用
    BB_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    BB_setting.value_width = 80; -- 值显示宽度像素（默认为100）

    local Touch_of_Death_setting = dps_category:create_setting("Touch_of_Death"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    Touch_of_Death_setting.display_name = L["爆发"];
    Touch_of_Death_setting.description = "按下这个键切换爆发状态！由于暴雪本身限制，只能支持大写A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    Touch_of_Death_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    Touch_of_Death_setting.default_value = "E"; -- 变量默认值
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

    local sudden_onset_setting = dps_category:create_setting("sudden_onset"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    sudden_onset_setting.display_name = L["是否点出钻心剧痛"];
    sudden_onset_setting.description = "填写是否点出钻心剧痛特质"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    sudden_onset_setting.value_type = rotation_setting_type.plain; -- 变量值类型（text类型）
    sudden_onset_setting.default_value = 0; -- 变量默认值
    sudden_onset_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    sudden_onset_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    sudden_onset_setting.is_enabled_by_default = true; -- 是否默认启用
    sudden_onset_setting.validator = nil -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    sudden_onset_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    -- -- 添加一个自定义类别test_category。
    local text1_category = rotation:create_setting_category("text1"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    text1_category.display_name = L["|cff00FFFFAOE情况下手动开黑魂有惊喜"]; -- 类别在界面上显示的名字
    local text2_category = rotation:create_setting_category("text2"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    text2_category.display_name = L["|cff00FFFF不支持打木桩，请进本测试"]; -- 类别在界面上显示的名字

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

    if Y.spelllist == nil then
        Y.spelllist = {}
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
                        table.insert( Y.spelllist, spell )
                        if destination then
                            Y.lastspell_target = destination
                            -- if self.settings.ydebug.is_enabled then             
                            --     GH_Print("成功对 "..destName.." ".."施放了 "..spellName)
                            -- end
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
        -- if ydebug.is_enabled then
        --     GH_Print(" or cffFF0000进入战斗，开始计时")
        -- end
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
            Y.spelllist = {};
            -- Y.data["GCD"] = getGCD();
            -- SetupTables()
            -- if self.settings.ydebug.is_enabled then
            --     GH_Print(" or cffFF0000离开战斗，重置参数")
            -- end
        
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
--过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
function filler_unit(Unit)
    if --[[(UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and]] getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) and isAlive(Unit) and UnitCanAttack("player",Unit) then
        return true
    else
        return false
    end
end
--排序
function sortdebuff_shadow_embrace(a,b)
    -- body
    if a == nil then
        return false
    end
    if b == nil then
        return true
    end
    return getDebuffRemain(a,32390,"player") < getDebuffRemain(b,32390,"player")
end
function sortdebuff_agony(a,b)
    -- body
    if a == nil then
        return false
    end
    if b == nil then
        return true
    end
    return getDebuffRemain(a,980,"player") < getDebuffRemain(b,980,"player")
end
function contagion( Unit )
    -- body   
    local y = {}
    if getDebuffRemain(Unit,233490,"player") > 0 then
        local z = getDebuffRemain(Unit,233490,"player")
        table.insert( y, z )
    end
    if getDebuffRemain(Unit,233496,"player") > 0 then
        local z = getDebuffRemain(Unit,233490,"player")
        table.insert( y, z )
    end  
    if getDebuffRemain(Unit,233497,"player") > 0 then
        local z = getDebuffRemain(Unit,233490,"player")
        table.insert( y, z )
    end  
    if getDebuffRemain(Unit,233498,"player") > 0 then
        local z = getDebuffRemain(Unit,233490,"player")
        table.insert( y, z )
    end  
    if getDebuffRemain(Unit,233499,"player") > 0 then
        local z = getDebuffRemain(Unit,233490,"player")
        table.insert( y, z )
    end     
    table.sort( y )
    local x = y[1] or 0         
    return x
end
function debuffcount(Unit)
    -- body
    local num = 0
    if UnitExists(Unit) then
        for i=1,40 do
            local name,_,_,_,_,_,buffCaster,_,_,buffSpellID = UnitDebuff(Unit,i)
            if buffSpellID ~= nil then                
                if (buffCaster == "player") then
                    num = num + 1;
                end                            
            end
        end
    end
    return num
end

function getDistance( Unit1,Unit2 )
    -- body
    if not UnitExists(Unit1) then
        GH_Print(Unit1)
        GH_Print("不存在")
        return false
    end
    if not UnitExists(Unit2) then
        GH_Print(Unit2)
        GH_Print("不存在")
        return false
    end
    return GetDistanceBetweenObjects (Unit1, Unit2) - UnitBoundingRadius (Unit1) - UnitBoundingRadius (Unit2)
end



-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    if argument == "baofa" and baofa ~= true then
        -- ActionStatus_DisplayMessage("爆发开启",true)
        baofa = true
        OverlayR("爆发开启")
        return 0;
    end
    if argument == "baofa" and baofa == true then
        -- ActionStatus_DisplayMessage("爆发关闭",true)    
        baofa = false
        OverlayG("爆发关闭")
        return 0;
    end 
end
function rotation:condition_action()
    -- 编写判断模块是否可用的脚本。
	if select(3, UnitClass("player")) == 9 and GetSpecialization() == 1 then
		return true
	else
		return false
	end
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
    bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
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
    ZDzhaobb = self.settings.ZDzhaobb.is_enabled  -- 自动自动招宝宝    
    BB = self.settings.BB.value
    if _t1==nil then _t1=GetTime(); end
    if ZDzhaobb == true and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then
        if BB == "小鬼" and getPetNum()~=1 then rm("/cast 召唤小鬼") end
        if BB == "虚空行者" and getPetNum()~=2 then rm("/cast 召唤虚空行者") end
        if BB == "地狱猎犬" and getPetNum()~=3 then rm("/cast 召唤地狱猎犬") end
        if BB == "魅魔" and getPetNum()~=4 then rm("/cast 召唤魅魔") end
        _t1=GetTime()+ 5
    end      

end

function rotation:fillers( ... )
    -- body  
    -- actions.fillers=agony,if=talent.deathbolt.enabled&cooldown.summon_darkglare.remains>=30+gcd&cooldown.deathbolt.remains<=gcd&!prev_gcd.1.summon_darkglare&!prev_gcd.1.agony&talent.writhe_in_agony.enabled&azerite.sudden_onset.enabled&remains<duration*0.5
    if getTalent(1,3) and getSpellCD(summon_darkglare) >= 30 + gcd and getSpellCD(deathbolt) <= gcd and not( getLastSpell() == summon_darkglare ) and not ( getLastSpell() == agony ) and getTalent(2,1) and sudden_onset.is_enabled and getDebuffRemain(tg,agony,"player") < 13 * 0.5 then
        if canCast(agony) and castSpell(tg,agony) then
            if ydebug.is_enabled then
                print(200)
                return 0
            else
                return 0
            end
        end
    end
    -- if getDebuffRemain(tg,agony,"player") < 18 and getSpellCD(summon_darkglare) >= 30 + gcd and getSpellCD(deathbolt) <= gcd and not ( getLastSpell() == summon_darkglare ) and not ( getLastSpell() == agony ) and ( sudden_onset.value > 1 or sudden_onset.value == 1 and not getTalent(2,3) ) then
    --     if canCast(agony) and castSpell(tg,agony) then
    --         if ydebug.is_enabled then
    --             print(200)
    --             return 0
    --         else
    --             return 0
    --         end
    --     end
    -- end
    self:rest()
    -- actions.fillers+=/deathbolt,if=cooldown.summon_darkglare.remains>=30+gcd|cooldown.summon_darkglare.remains>140
    if getSpellCD(summon_darkglare) >= 30 + gcd or getSpellCD(summon_darkglare) > 140 then
        if getTalent(1,3) and canCast(deathbolt) and castSpell(tg,deathbolt) then
            if ydebug.is_enabled then
                print(201)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/shadow_bolt,if=buff.movement.up&buff.nightfall.remains
    if  isMoving("player") and getBuffRemain("player",264571) > 0 then
        if canCast(shadow_bolt) and castSpell(tg,shadow_bolt) then
            if ydebug.is_enabled then
                print(202)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/agony,if=buff.movement.up&!(talent.siphon_life.enabled&(prev_gcd.1.agony&prev_gcd.2.agony&prev_gcd.3.agony)|prev_gcd.1.agony) 
    if isMoving("player") and not ( getTalent(2,3) and ( getLastSpell() == agony and spelllist[-2] == agony and spelllist[-3] == agony) or getLastSpell() == agony ) then
        if canCast(agony) and castSpell(tg,agony) then
            if ydebug.is_enabled then
                print(203)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/siphon_life,if=buff.movement.up&!(prev_gcd.1.siphon_life&prev_gcd.2.siphon_life&prev_gcd.3.siphon_life)
    if isMoving("player") and not ( getLastSpell() == siphon_life and spelllist[-2] == siphon_life and spelllist[-3] == siphon_life ) then
        if canCast(siphon_life) and castSpell(tg,siphon_life) then
            if ydebug.is_enabled then
                print(204)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/corruption,if=buff.movement.up&!prev_gcd.1.corruption&!talent.absolute_corruption.enabled 
    if isMoving("player") and not getLastSpell() == corruption and not getTalent(2,2) then
        if canCast(corruption) and castSpell(tg,corruption) then
            if ydebug.is_enabled then
                print(205)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/drain_life,if=(buff.inevitable_demise.stack>=90&(cooldown.deathbolt.remains>execute_time|!talent.deathbolt.enabled)&(cooldown.phantom_singularity.remains>execute_time|!talent.phantom_singularity.enabled)&(cooldown.dark_soul.remains>execute_time|!talent.dark_soul_misery.enabled)&(cooldown.vile_taint.remains>execute_time|!talent.vile_taint.enabled)&cooldown.summon_darkglare.remains>execute_time+10|buff.inevitable_demise.stack>30&target.time_to_die<=10)
    if ( getBuffStacks("player",inevitable_demise) >= 90 and ( getSpellCD(deathbolt) > getCastTime(drain_life) or not getTalent(1,3) ) and ( getSpellCD(phantom_singularity) > getCastTime(drain_life) or not getTalent(4,2) ) and ( getSpellCD(dark_soul) > getCastTime(drain_life) or not getTalent(7,3) ) and ( getSpellCD(vile_taint) > getCastTime(drain_life) or not getTalent(4,3) ) and getSpellCD(summon_darkglare) > getCastTime(drain_life) + 10 or getBuffStacks("player",inevitable_demise) > 30 and getTimeToDie(tg) <= 10 ) then
        if canCast(drain_life) and castSpell(tg,drain_life) then
            if ydebug.is_enabled then
                print(206)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd
    -- actions.fillers+=/drain_soul,interrupt_global=1,chain=1,interrupt=1,cycle_targets=1,if=target.time_to_die<=gcd
    if getTalent(1,2) then
        for i=1,#pd do
            if getTimeToDie(pd[i]) <= gcd  then
                if canCast(drain_soul) and castSpell(pd[i],drain_soul) then
                    self:rest()
                    if ydebug.is_enabled then
                        print(207)
                        -- return 
                    else
                        -- return 
                    end
                end
            end
        end
    end
    self:rest()
    -- actions.fillers+=/drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&active_enemies=2&!debuff.shadow_embrace.remains
    -- actions.fillers+=/drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&active_enemies=2
    -- actions.fillers+=/drain_soul,interrupt_global=1,chain=1,interrupt=1
    -- actions.fillers+=/drain_soul,interrupt_global=1,chain=1
    if canCast(drain_soul) and castSpell(tg,drain_soul) then
        self:rest()
        if ydebug.is_enabled then
            print(208)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.fillers+=/shadow_bolt,cycle_targets=1,if=talent.shadow_embrace.enabled&talent.absolute_corruption.enabled&active_enemies=2&!debuff.shadow_embrace.remains&!action.shadow_bolt.in_flight
    if  getTalent(6,1) and getTalent(2,2) and #pd==2 then 
        for i=1,#pd do
            if  UnitDebuffID(pd[i],shadow_embrace_debuff,"player") and not ( getOneMyMissile() == shadow_bolt) then
                if canCast(shadow_bolt) and castSpell(pd[i],shadow_bolt) then
                    self:rest()
                    if ydebug.is_enabled then
                        print(209)
                    else
                    end
                end
            end
        end
    end
    self:rest()
    -- actions.fillers+=/shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&talent.absolute_corruption.enabled&active_enemies=2
    if  getTalent(6,1)  and  getTalent(2,2)  and #pd==2 then
        table.sort( pd, sortdebuff_shadow_embrace )
        if  canCast(shadow_bolt) and castSpell(pd[1],shadow_bolt) then
            if ydebug.is_enabled then
                print(210)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.fillers+=/shadow_bolt
    if  canCast(shadow_bolt) and castSpell(tg,shadow_bolt) then
        if ydebug.is_enabled then
            print(211)
            return 0
        else
            return 0
        end
    end
    self:rest()
end

function rotation:default_action()

    

    cascading_calamity = self.settings.cascading_calamity
    tgtype = self.settings.targets --目标选择
    ydebug = self.settings.ydebug --调试信息
    isbus = self.settings.isbus --坐骑
    sudden_onset = self.settings.sudden_onset --专心剧痛
    spelllist = Y.spelllist
    zls = self.settings.zls.value            --治疗石
    bumie = self.settings.bumie.value    --不灭决心阀值
    qiyue = self.settings.qiyue.value   --黑暗契约阀值 
    ZDzhaobb = self.settings.ZDzhaobb.is_enabled  -- 自动自动招宝宝    
    BB = self.settings.BB.value               --选择宝宝类型
    
    bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
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
	
    if isbus.is_enabled and isBused("player") then return; end

	

    shadow_bolt = 232670
    drain_soul = 198590 --吸取灵魂
    deathbolt = 264106
    haunt = 48181 --鬼影缠身
    agony = 980 --痛楚
    corruption = 172
    corruption_debuff = 146739
    phantom_singularity = 205179 --诡异魅影
    summon_darkglare = 205180 --召唤黑眼
    active_uas = 0
    shadow_embrace = 32388
    absolute_corruption = 196103
    shadow_embrace_debuff = 32390
    vile_taint = 278350 --邪恶污染
    seed_of_corruption = 27243
    siphon_life = 63106 --生命虹吸
    unstable_affliction = 30108 --痛苦无常
    -- contagion = 196105
    inevitable_demise = 273525
    drain_life = 234153
    dark_soul = 113860   

    


    gcd = getGCD()
    if pd == nil or GetTime() - sorttime > gcd then
        -- makeZMTable(40)
        pd = getEnemy(40,filler_unit)
        self:rest()
        -- local tg2,emnum1 = getBiggestUnitCluster(40,10,isInCombat) --
        
        -- self:rest()
        for i=1,#pd do
            if UnitDebuffID(pd[i],233490,"player") then
                for j=1,40 do
                    local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId  = UnitDebuff(pd[i],j)
                    if spellId then
                        if name == "痛苦无常"  then
                            if  (unitCaster == "player") then
                                active_uas = active_uas + 1
                                -- print("active_uas:"..active_uas)
                                self:rest()
                            end
                        end                    
                    end
                end                
            end
        end
        self:rest()
        sorttime = GetTime()
        -- for i,v in ipairs(pd) do
        --     print(i,v)
        -- end
    end
    time_to_shard = 1.5
    castSpell = csi



    

    --治疗石
    if getHP("player")<zls and hasItem(5512) then
        if useItem(5512) then
            return 0;
        end
    end
    --[[ --星界治疗
    if getHP("player")<zls and not hasItem(5512) and hasItem(5512) then
        useItem(5512)
    end ]]

    --不灭决心104773
    if getHP("player")<=bumie and canCast(104773) then 
        if csi("player",104773) then
            return 0;
        end
    end

    --黑暗契约
    if getHP("player")<=qiyue and getTalent(3,3) and canCast(108416) then
        if csi("player",108416) then
            return 0;
        end
    end

    if _t1==nil then _t1=GetTime(); end
    if ZDzhaobb == true and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then
        if BB == "小鬼" and getPetNum()~=1 then rm("/cast 召唤小鬼") end
        if BB == "虚空行者" and getPetNum()~=2 then rm("/cast 召唤虚空行者") end
        if BB == "地狱猎犬" and getPetNum()~=3 then rm("/cast 召唤地狱猎犬") end
        if BB == "魅魔" and getPetNum()~=4 then rm("/cast 召唤魅魔") end
        _t1=GetTime()+ 5
    end      


    -- actions+=/drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd&soul_shard<5
    if getTalent(1,2) and canCast(drain_soul) and not isCastingSpell("player", drain_soul) then
        for i=1,#pd do
            if getTimeToDie(pd[i]) <= gcd and getSoulShards() < 5 then
                SpellStopCasting()
                if canCast(drain_soul) and castSpell(pd[i],drain_soul) then
                    self:rest()
                    if ydebug.is_enabled then
                        print(101)
                        -- return 
                    else
                        -- return 
                    end
                end
            end
        end
    end
    self:rest()
    -- actions.fillers+=/drain_soul,interrupt_global=1,chain=1,interrupt=1
    -- actions+=/drain_soul,target_if=min:debuff.shadow_embrace.remains,interrupt_immediate=1,interrupt_if=ticks_remain<5,if=talent.shadow_embrace.enabled&active_enemies<=2&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=gcd*2
    if getTalent(1,2) and not isCastingSpell("player", drain_soul) then
        table.sort( pd, sortdebuff_shadow_embrace )
        self:rest()
        if getTalent(6,1) and #pd <= 2 and UnitDebuffID(pd[1],shadow_embrace_debuff,"player") and getDebuffRemain(pd[1],shadow_embrace_debuff,"player") <= gcd*2 then
            SpellStopCasting()
            if canCast(drain_soul) and castSpell(pd[1],drain_soul) then
                self:rest()
                if ydebug.is_enabled then
                    print(101)
                    -- return 
                else
                    -- return 
                end
            end
        end    
    end
    -- actions.fillers+=/drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&active_enemies=2&!debuff.shadow_embrace.remains
    if getTalent(1,2) and isCastingSpell("player", drain_soul) and getCastTimeRemain("player") < 2 and getTalent(6,1) and #pd == 2 and not UnitDebuffID(pd[1],shadow_embrace_debuff,"player") then
        SpellStopCasting()
        if canCast(drain_soul) and castSpell(pd[1],drain_soul) then
            self:rest()
            if ydebug.is_enabled then
                print(101)
                -- return 
            else
                -- return 
            end
        end
    end
    -- actions.fillers+=/drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&active_enemies=2
    

    -- 不打断施法
    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;

    --获得第一个符合条件的目标
    if tgtype.value == "智能" then

        if pd then
            for i=1,#pd do
                if UnitExists(pd[i]) and isAlive(pd[i]) then
                    tg = pd[i]
                    break
                end
            end
        else
            tg = "target"
        end
        -- tg = getOneEnemy(40,filler_unit)
        
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
    local tg2,emnum1
    if tg2 == nil then tg2 = tg;end
    if emnum1 == nil then emnum1 = getNumEnemies(tg,10);end

    
    
    -- actions=variable,name=spammable_seed,value=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>=3|talent.siphon_life.enabled&spell_targets.seed_of_corruption>=5|spell_targets.seed_of_corruption>=8
    spammable_seed = getTalent(4,1) and emnum1 >= 3 or getTalent(2,3) and emnum1 >= 5 or emnum1 >= 8

    -- actions+=/variable,name=padding,op=set,value=action.shadow_bolt.execute_time*azerite.cascading_calamity.enabled
    azerite_cascading_calamity_enabled = 0
    if cascading_calamity.is_enabled then azerite_cascading_calamity_enabled = 1;end
    padding = getCastTime(shadow_bolt) * azerite_cascading_calamity_enabled

    -- actions+=/variable,name=padding,op=reset,value=gcd,if=azerite.cascading_calamity.enabled&(talent.drain_soul.enabled|talent.deathbolt.enabled&cooldown.deathbolt.remains<=gcd)
    if cascading_calamity.is_enabled and ( getTalent(1,2) or getTalent(1,3) and getSpellCD(deathbolt) <= gcd ) then
        padding = gcd
    end
    
    -- actions+=/potion,if=(talent.dark_soul_misery.enabled&cooldown.summon_darkglare.up&cooldown.dark_soul.up)|cooldown.summon_darkglare.up|target.time_to_die<30
    -- actions+=/use_items,if=!cooldown.summon_darkglare.up
    if baofa and canUse(13) and getSpellCD(summon_darkglare) > 0 then
        useItem(13)
    end
    if baofa and canUse(14) and getSpellCD(summon_darkglare) > 0 then
        useItem(14)
    end
    -- actions+=/fireblood,if=!cooldown.summon_darkglare.up
    -- actions+=/blood_fury,if=!cooldown.summon_darkglare.up
    -- actions+=/drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd&soul_shard<5
    -- actions+=/haunt
    if getTalent(6,2) and canCast(48181) and not isMoving("player") then
        if castSpell(tg,48181,false,false) then
            if ydebug.is_enabled then
                print(102)
                return 0
            else
                return 0
            end
        end
    end  
    self:rest()
    -- actions+=/summon_darkglare,if=dot.agony.ticking&dot.corruption.ticking&(buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains) 
    if UnitDebuffID(tg,agony,"player") and UnitDebuffID(tg,146739,"player") and ( active_uas == 5 or getSoulShards() == 0 ) and ( not getTalent(4,2) or getSpellCD(phantom_singularity) > 0 ) then
        if baofa and canCast(summon_darkglare) and castSpell(tg,summon_darkglare) then
            if ydebug.is_enabled then
                print(103)
                return 0
            else
                return 0
            end
        end
    end 
    self:rest()
    -- actions+=/agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time
    table.sort( pd, sortdebuff_agony )
    self:rest()
    if UnitExists(tg) and getDebuffRemain(tg,agony,"player") <= gcd + getCastTime(shadow_bolt) then
        pd[1] = tg
    end
    -- for i=1,#pd do
    if UnitExists(pd[1]) and getDebuffRemain(pd[1],agony,"player") <= gcd + getCastTime(shadow_bolt) then
        if castSpell(pd[1],agony) then
            self:rest()
            if ydebug.is_enabled then
                print(104)
                -- return 0
            else
                -- return 0
            end
        end
    end
    -- end
    self:rest()
    -- actions+=/drain_soul,target_if=min:debuff.shadow_embrace.remains,interrupt_immediate=1,interrupt_if=ticks_remain<5,if=talent.shadow_embrace.enabled&active_enemies<=2&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=gcd*2
    
    
    -- actions+=/shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&talent.absolute_corruption.enabled&active_enemies=2&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight 
    -- actions+=/shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&talent.absolute_corruption.enabled&active_enemies<=2&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight   
    table.sort( pd, sortdebuff_shadow_embrace )
    self:rest()
    if getTalent(6,1) and getTalent(2,2) and #pd <= 2 and getDebuffRemain(pd[1],shadow_embrace_debuff,"player") > 0 and getDebuffRemain(pd[1],shadow_embrace_debuff,"player") <= getCastTime(shadow_bolt)*2 + 1.5 and not ( getOneMyMissile() == shadow_bolt ) then
        if canCast(shadow_bolt) and castSpell(pd[1],shadow_bolt) then
            if ydebug.is_enabled then
                print(105)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/phantom_singularity,if=time>40&(cooldown.summon_darkglare.remains>=45|cooldown.summon_darkglare.remains<8)
    if getCombatTime() > 40 and ( getSpellCD(summon_darkglare) >= 45 or getSpellCD(summon_darkglare) <8 ) then
        if getTalent(4,2) and canCast(phantom_singularity) and castSpell(tg,phantom_singularity) then
            if ydebug.is_enabled then
                print(106)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/vile_taint,if=time>20
    if getCombatTime() > 20 then
        if getTalent(4,3) and canCast(vile_taint) and getSoulShards() >= 1 and castSpell(tg,vile_taint) then
            if ydebug.is_enabled then
                print(107)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/seed_of_corruption,if=dot.corruption.remains<=action.seed_of_corruption.cast_time+time_to_shard+4.2*(1-talent.creeping_death.enabled*0.15)&spell_targets.seed_of_corruption_aoe>=3+talent.writhe_in_agony.enabled&!dot.seed_of_corruption.remains&!action.seed_of_corruption.in_flight
    local x1 = 0
    if getTalent(7,2) then x1 = 1; end;
    local x2 = 0
    if getTalent(2,1) then x2 = 1; end;
    if not getTalent(2,2) and getDebuffRemain(tg2,146739,"player") <= getCastTime(seed_of_corruption) + time_to_shard + 4.2*(1 - x1*0.15) and emnum1 >= 3 + x2 and not UnitDebuffID(tg2,seed_of_corruption,"player") and not ( getOneMyMissile() == seed_of_corruption ) then
        if canCast(seed_of_corruption) and castSpell(tg2,seed_of_corruption) then
            if ydebug.is_enabled then
                print(108)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/agony,cycle_targets=1,max_cycle_targets=6,if=talent.creeping_death.enabled&target.time_to_die>10&refreshable
    local count = 1
    for i=1,#pd do
        if count < 7 and UnitExists(pd[i]) and getTalent(7,2) and getTimeToDie(pd[i]) > 10 and getDebuffRemain(pd[i],agony,"player") <= 5 then
            if canCast(agony) and castSpell(pd[i],agony) then
                count = count + 1
                self:rest()
                if ydebug.is_enabled then
                    print(109)
                    -- return 
                else
                    -- return 
                end
            end
        end
    end
    self:rest()
    -- actions+=/agony,cycle_targets=1,max_cycle_targets=8,if=(!talent.creeping_death.enabled)&target.time_to_die>10&refreshable
    local count1 = 1
    for i=1,#pd do
        if count1 < 9 and UnitExists(pd[i]) and ( not getTalent(7,2) ) and getTimeToDie(pd[i]) > 10 and getDebuffRemain(pd[i],agony,"player") <= 5 then
            if canCast(agony) and castSpell(pd[i],agony) then
                count1 = count1 + 1
                self:rest()
                if ydebug.is_enabled then
                    print(110)
                    -- return 
                else
                    -- return 
                end
            end
        end
    end
    self:rest()
    -- actions+=/siphon_life,cycle_targets=1,max_cycle_targets=1,if=refreshable&target.time_to_die>10&((!(cooldown.summon_darkglare.remains<=soul_shard*action.unstable_affliction.execute_time)&active_enemies>=8)|active_enemies=1)
    if getTalent(2,3) then        
        for i=1,#pd do
            if getDebuffRemain(pd[i],siphon_life,"player") <= 5 and getTimeToDie(pd[i]) > 10 and (( not ( getSpellCD(summon_darkglare) <= getSoulShards()*getCastTime(unstable_affliction) ) and #pd >= 8 ) or #pd == 1 ) then
                if canCast(siphon_life) and castSpell(pd[i],siphon_life) then
                    break
                end
            end
        end
        -- actions+=/siphon_life,cycle_targets=1,max_cycle_targets=2,if=refreshable&target.time_to_die>10&((!(cooldown.summon_darkglare.remains<=soul_shard*action.unstable_affliction.execute_time)&active_enemies=7)|active_enemies=2)
        local count2 = 1
        for i=1,#pd do
            if count2 < 3 and getDebuffRemain(pd[i],siphon_life,"player") <= 5 and getTimeToDie(pd[i]) > 10 and (( not ( getSpellCD(summon_darkglare) <= getSoulShards()*getCastTime(unstable_affliction) ) and #pd == 7 ) or getNumEnemies(pd[i],10) == 2) then
                if canCast(siphon_life) and castSpell(pd[i],siphon_life) then
                    count2 = count2 + 1
                    self:rest()
                    -- return
                end
            end 
        end
        -- actions+=/siphon_life,cycle_targets=1,max_cycle_targets=3,if=refreshable&target.time_to_die>10&((!(cooldown.summon_darkglare.remains<=soul_shard*action.unstable_affliction.execute_time)&active_enemies=6)|active_enemies=3)    
        local count3 = 1
        for i=1,#pd do
            if count3 < 4 and getDebuffRemain(pd[i],siphon_life,"player") <= 5 and  getTimeToDie(pd[i]) > 10 and (( not ( getSpellCD(summon_darkglare) <= getSoulShards()*getCastTime(unstable_affliction) ) and getNumEnemies(pd[i],10) == 6 ) or getNumEnemies(pd[i],10) == 3) then
                if canCast(siphon_life) and castSpell(pd[i],siphon_life) then
                    count3 = count3 + 1
                    self:rest()
                    -- return
                end
            end 
        end
        -- actions+=/siphon_life,cycle_targets=1,max_cycle_targets=4,if=refreshable&target.time_to_die>10&((!(cooldown.summon_darkglare.remains<=soul_shard*action.unstable_affliction.execute_time)&active_enemies=5)|active_enemies=4)
        local count4 = 1
        for i=1,#pd do
            if count4 < 5 and getDebuffRemain(pd[i],siphon_life,"player") <= 5 and  getTimeToDie(pd[i]) > 10 and (( not ( getSpellCD(summon_darkglare) <= getSoulShards()*getCastTime(unstable_affliction) ) and getNumEnemies(pd[i],10) == 5) or getNumEnemies(pd[i],10) == 4) then
                if canCast(siphon_life) and castSpell(pd[i],siphon_life) then
                    count4 = count4 + 1
                    self:rest()
                    -- return
                end
            end 
        end    
    end
    self:rest()
    -- actions+=/corruption,cycle_targets=1,if=active_enemies<3+talent.writhe_in_agony.enabled&refreshable&target.time_to_die>10
    local x3 = 0
    if getTalent(2,1) then x3 =1;end
    if #pd < 3 + x3  then
        for i=1,#pd do
            if ( ( not getTalent(2,2) and getDebuffRemain(pd[i],146739,"player") < 5) or ( getTalent(2,2) and not UnitDebuffID(pd[i],146739,"player") ) ) and  ( getTimeToDie(pd[i]) > 10 or getHP(pd[i]) >= 20 ) then
                if canCast(corruption) and castSpell(pd[i],corruption) then
                    self:rest()
                    if ydebug.is_enabled then
                        print(111)
                        -- return 
                    else
                        -- return 
                    end
                end
            end
        end
    end
    self:rest()
    -- actions+=/phantom_singularity,if=time<=40
    if getCombatTime() <= 40 then
        if getTalent(4,2) and canCast(phantom_singularity) and castSpell(tg,phantom_singularity) then
            if ydebug.is_enabled then
                print(112)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/vile_taint
    if getTalent(4,3) and canCast(vile_taint) and getSoulShards() >= 1 and castSpell(tg,vile_taint) then
        if ydebug.is_enabled then
            print(113)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions+=/dark_soul
    if baofa and canCast(dark_soul) and castSpell("player",dark_soul) then
        if ydebug.is_enabled then
            print(114)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions+=/berserking

    -- actions+=/unstable_affliction,if=soul_shard>=5    
    if getSoulShards() >= 5 then
        if canCast(unstable_affliction) and castSpell(tg,unstable_affliction) then
            if ydebug.is_enabled then
                print(115)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/unstable_affliction,if=cooldown.summon_darkglare.remains<=soul_shard*execute_time 
    if getSpellCD(summon_darkglare) <= getSoulShards()*getCastTime(unstable_affliction) then 
        
        if getSoulShards() >= 1 and canCast(unstable_affliction) then
            for i=1,#pd do
                if getTimeToDie(pd[i]) >= 10 and debuffcount(pd[i]) >= 3 and not ( UnitDebuff(pd[i],233490) or UnitDebuff(pd[i],233496) or UnitDebuff(pd[i],233497) or UnitDebuff(pd[i],233498) or UnitDebuff(pd[i],233499) ) and castSpell(pd[i],unstable_affliction) then
                    self:rest()
                    if ydebug.is_enabled then
                        print(116)
                        -- return 0
                    else
                        -- return 0
                    end  
                end
            end
            if castSpell(tg,unstable_affliction) then
                if ydebug.is_enabled then
                    print(116)
                    return 0
                else
                    return 0
                end        
    
            end
        end

    end
    self:rest()
    -- actions+=/call_action_list,name=fillers,if=(cooldown.summon_darkglare.remains<time_to_shard*(5-soul_shard)|cooldown.summon_darkglare.up)&time_to_die>cooldown.summon_darkglare.remains
    if ( getSpellCD(summon_darkglare) < time_to_shard*(5 - getSoulShards() ) or getSpellCD(summon_darkglare) <= 0 ) and getTimeToDie(tg) > getSpellCD(summon_darkglare) then
        self:fillers()
    end
    self:rest()
    -- actions+=/seed_of_corruption,if=variable.spammable_seed
    if spammable_seed then
        if canCast(seed_of_corruption) and castSpell(tg2,seed_of_corruption) then
            if ydebug.is_enabled then
                print(117)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/unstable_affliction,if=!prev_gcd.1.summon_darkglare&!variable.spammable_seed&(talent.deathbolt.enabled&cooldown.deathbolt.remains<=execute_time&!azerite.cascading_calamity.enabled|soul_shard>=2&target.time_to_die>4+execute_time&active_enemies=1|target.time_to_die<=8+execute_time*soul_shard)
    if not ( getLastSpell() == summon_darkglare ) and not spammable_seed and ( getTalent(1,3) and getSpellCD(deathbolt) <= getCastTime(unstable_affliction) and not cascading_calamity.is_enabled or getSoulShards() >= 2 and getTimeToDie(tg) > 4 + getCastTime(unstable_affliction) and #pd == 1 or getTimeToDie(tg) <= 8 + getCastTime(unstable_affliction)*getSoulShards() ) then
        if canCast(unstable_affliction) and castSpell(tg,unstable_affliction) then
            if ydebug.is_enabled then
                print(118)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/unstable_affliction,if=!variable.spammable_seed&contagion<=cast_time+variable.padding
    if not spammable_seed and contagion(tg) <= getCastTime(unstable_affliction) + padding then
        if canCast(unstable_affliction) and castSpell(tg,unstable_affliction) then
            if ydebug.is_enabled then
                print(119)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()    
    -- actions+=/unstable_affliction,cycle_targets=1,if=!variable.spammable_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
    for i=1,#pd do
        if not spammable_seed and ( not getTalent(1,3) or getSpellCD(deathbolt) > time_to_shard or getSoulShards() > 1 ) and contagion(pd[i]) <= getCastTime(unstable_affliction) + padding and ( not cascading_calamity.is_enabled or getBuffRemain("player",275376) > time_to_shard ) then        
            if debuffcount(pd[i]) >=2 and canCast(unstable_affliction) and castSpell(pd[i],unstable_affliction) then
                -- print("warring")
                if ydebug.is_enabled then
                    print(120)
                    -- return 0
                else
                    -- return 0
                end
            end
        end
    end
    -- actions+=/call_action_list,name=fillers
    self:fillers()


end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);
