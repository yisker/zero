----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "a182c733-19de-47b2-b165-a86d29bd3f98";
-- 定义循环的英文名称。
local rotation_name = "pingheng";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "德鲁伊-平衡";
    L["Welcome to use test module."] = "欢迎使用德鲁伊-平衡测试模块！";
    
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
rotation.macro = "niaode";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
do
    -- -- 添加一个自定义类别test_category。
    local jc_category = rotation:create_setting_category("jc_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    jc_category.display_name = L["|cff00FFFF基础设置"]; -- 类别在界面上显示的名字

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local ydebug_setting = jc_category:create_setting("ydebug"); -- 指定变量的名字为test1，用于在脚本中进行引用
    ydebug_setting.display_name = L["调试模式"]; -- 变量在界面上显示的名字
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

    -----------------------------------------------------------

    -- -- 添加一个自定义类别test_category。
    local hps_category = rotation:create_setting_category("hps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    hps_category.display_name = L["|cff00FFFF治疗设置"]; -- 类别在界面上显示的名字

    local zlsyz_setting = hps_category:create_setting("zlsyz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zlsyz_setting.display_name = L["治疗石"];
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


    -----------------------------------------------------------



    -- -- 添加一个自定义类别test_category。
    local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    dps_category.display_name = L["|cff00FFFF输出设置"]; -- 类别在界面上显示的名字

    

    -- 在类别test_category下添加配置变量test5
    local targets_setting = dps_category:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    targets_setting.display_name = L["targets"];
    targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    targets_setting.default_value = "智能"; -- 变量默认值
    targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    targets_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    targets_setting.is_enabled_by_default = false; -- 是否默认启用
    targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    targets_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local daduan_setting = dps_category:create_setting("daduan"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    daduan_setting.display_name = L["打断目标"];
    daduan_setting.description = "按下这个键打断当前目标"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    daduan_setting.value_type = rotation_setting_type.number; -- 变量值类型（text类型）
    daduan_setting.default_value = 0.4; -- 变量默认值
    daduan_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    daduan_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    daduan_setting.is_enabled_by_default = true; -- 是否默认启用
    daduan_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 ) then
            return true;
        else
            return false, "不能填负数";
        end
    end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    daduan_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local Touch_of_Death_setting = dps_category:create_setting("Touch_of_Death"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    Touch_of_Death_setting.display_name = L["爆发"];
    Touch_of_Death_setting.description = "按下这个键切换爆发状态！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

    local lively_spirit_setting = dps_category:create_setting("lively_spirit"); -- 指定变量的名字为test1，用于在脚本中进行引用
    lively_spirit_setting.display_name = L["是否点出活跃精神"]; -- 变量在界面上显示的名字
    lively_spirit_setting.description = "是否点出活跃精神特质，是则打勾"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    lively_spirit_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    lively_spirit_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    lively_spirit_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    lively_spirit_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    lively_spirit_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    lively_spirit_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    lively_spirit_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    local text1_category = rotation:create_setting_category("text1_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    text1_category.display_name = L["推荐天赋3000231"]; -- 类别在界面上显示的名字
    local text2_category = rotation:create_setting_category("text2_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    text2_category.display_name = L["手动开启化身/超凡"]; -- 类别在界面上显示的名字


    
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
            az_streak = 0
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
--过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
function filler_unit(Unit)
    if (UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) and not isLongTimeCCed(Unit) then
        return true
    else
        return false
    end
end
-----------------------------------------------------------
-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    if (not argument or argument == "") then
        print("使用宏/"..ADDON_SLASH_COMMAND.." niaode baofa控制爆发");
    else
        print("收到宏命令参数：", argument);
    end
    if argument == "baofa" then
        baofa = not baofa
    end
    if baofa == true then
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
    local speci = 102 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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
    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
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

    tgtype = self.settings.targets --目标选择
    ydebug = self.settings.ydebug --调试信息
    lively_spirit_setting = self.settings.lively_spirit --调试信息
    isbus = self.settings.isbus --坐骑
    if isbus.is_enabled and isBused("player") then return; end
    zlsyz = self.settings.zlsyz --治疗石
    daduan = self.settings.daduan --打断

    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
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
    -- 不打断施法
    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;

    -- 石头
    if getHP("player") <= zlsyz.value and canUse(5512) then
        useItem(5512)
    end

    moonkin_form = 24858
    warrior_of_elune = 202425
    innervate = 29166
    incarnation = 102560 --化身：艾露恩之眷
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
    solar_wrath = 190984--阳炎之怒
    starlord = 279709
    starsurge = 78674
    starfall = 191034
    new_moon = 274281
    half_moon = 274282
    full_moon = 274283
    dawning_sun = 276152--破晓之阳
    sunblaze = 274397
    power_of_the_moon = 273367

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


    spell_targets = getNumEnemies(tg,8)
    active_enemies = spell_targets
    tb = getEnemy(35,filler_unit)
    castSpell = csi

    -- # Azerite variables
    -- # Streaking Stars:
    -- # Cast sw after every non-sw spell unless capping, sw sf sw if forced
    -- actions.precombat+=/variable,name=az_streak,value=azerite.streaking_stars.rank
    if az_streak == nil then az_streak = 0; end
    if UnitBuffID("player",102560) or UnitBuffID("player",194223) then
        if (Y.spelllist[-1] and Y.spelllist[-2]) then
            if Y.spelllist[-2] ~= Y.spelllist[-1] then
                az_streak = az_streak + 1
            end
        elseif not Y.spelllist[-2] then
            az_streak = 1
        end
    end
    if not (UnitBuffID("player",102560) or UnitBuffID("player",194223)) then
        az_streak = 0
    end
    if az_streak ~= 0 then
        az_streak_bool = true
    else
        az_streak_bool = false
    end
    
    -- actions.precombat+=/variable,name=az_ds,value=azerite.dawning_sun.rank
    az_ds = false--getBuffStacks("player",dawning_sun)
    -- actions.precombat+=/variable,name=az_sb,value=azerite.sunblaze.rank
    az_sb = 0--getBuffStacks("player",sunblaze)
    -- # Power of the Moon:
    -- # 2T: 3x noemp, 2x emp, 1x normal
    -- # 3T: 3x lsemp, 2x normal, 1x normal
    -- # 4T: 3x lsemp, 2x normal, 1x normal
    -- actions.precombat+=/variable,name=az_potm,value=azerite.power_of_the_moon.rank,if=talent.twin_moons.enabled
    if  getTalent(6,2) then
        az_potm = getBuffStacks("player",164547)
    else
        az_potm = 0
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


    if daduan.is_enabled and canCast(78675) and amac(tg,1,daduan.value) then
        if castSpell(tg,78675) then
            if ydebug.is_enabled then
                print(0)
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
    -- actions=potion,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/blood_fury,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/berserking,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/arcane_torrent,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/lights_judgment,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/fireblood,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/ancestral_call,if=buff.celestial_alignment.up|buff.incarnation.up
    -- actions+=/use_item,name=azurethos_singed_plumage,if=equipped.161377&(cooldown.incarnation.remains>30|cooldown.celestial_alignment.remains>30)
    if baofa and hasEquiped(161377) and ( getSpellCD(incarnation) > 30 or getSpellCD(celestial_alignment) > 30 ) then
        if canUse(161377) and useItem(161377) then
        end
    end
    -- actions+=/use_item,name=dread_gladiators_badge,if=equipped.161902&(cooldown.incarnation.remains>30|cooldown.celestial_alignment.remains>30)
    if baofa and hasEquiped(161902) and ( getSpellCD(incarnation) > 30 or getSpellCD(celestial_alignment) > 30 ) then
        if canUse(161902) and useItem(161902) then
        end
    end
    -- actions+=/use_items
    if baofa then
        if canUse(13) and useItem(13) then
        end
        if canUse(14) and useItem(14) then
        end
    end
    -- # CDs
    if baofa then
        -- actions+=/warrior_of_elune
        if getTalent(1,2) and canCast(warrior_of_elune) and castSpell("player",warrior_of_elune) then
            if ydebug.is_enabled then
                print(2)
                return 0
            else
                return 0
            end
        end        
        -- actions+=/innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.up|cooldown.celestial_alignment.remains<12)&(((raid_event.adds.duration%15)*(4)<(raid_event.adds.in%180))|(raid_event.adds.up))
        if lively_spirit_setting.is_enabled and ( (getTalent(5,3) and getSpellCD(incarnation) <= 0) or (not getTalent(5,3) and getSpellCD(celestial_alignment) < 12) ) and active_enemies > 5 then
            if canCast(innervate) and castSpell("player",innervate) then
                if ydebug.is_enabled then
                    print(3)
                    return 0
                else
                    return 0
                end
            end
        end
        -- actions+=/incarnation,if=astral_power>=40&(((raid_event.adds.duration%30)*(4)<(raid_event.adds.in%180))|(raid_event.adds.up))
        if getRealMana("player") >= 40 and active_enemies > 5 then
            if canCast(incarnation) and castSpell("player",incarnation) then
                if ydebug.is_enabled then
                    print(4)
                    return 0
                else
                    return 0
                end
            end
        end
        -- actions+=/celestial_alignment,if=astral_power>=40&(!azerite.lively_spirit.enabled|buff.lively_spirit.up)&(((raid_event.adds.duration%15)*(4)<(raid_event.adds.in%180))|(raid_event.adds.up))
        if getRealMana("player") >=40 and ( not lively_spirit_setting.is_enabled or getBuffRemain("player", lively_spirit) > 0) and active_enemies > 5 then
            if canCast(celestial_alignment) and castSpell("player",celestial_alignment) then
                if ydebug.is_enabled then
                    print(5)
                    return 0
                else
                    return 0
                end
            end
        end
        -- actions+=/fury_of_elune,if=(((raid_event.adds.duration%8)*(4)<(raid_event.adds.in%60))|(raid_event.adds.up))&((buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30))
        if active_enemies > 5 and (( getBuffRemain("player", celestial_alignment) > 0 or getBuffRemain("player", incarnation) > 0 ) or ( getSpellCD(celestial_alignment) > 30 or  getSpellCD(incarnation) > 30) ) then
            if canCast(fury_of_elune) and castSpell(tg,fury_of_elune) then
                if ydebug.is_enabled then
                    print(6)
                    return 0
                else
                    return 0
                end
            end
        end
        -- actions+=/force_of_nature,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)
        if ( getBuffRemain("player", celestial_alignment) > 0 or getBuffRemain("player", incarnation) > 0 ) or ( getSpellCD(celestial_alignment) > 30 or  getSpellCD(incarnation) > 30 ) then
            if canCast(force_of_nature) and castSpell("player",force_of_nature) then
                if ydebug.is_enabled then
                    print(7)
                    return 0
                else
                    return 0
                end
            end
        end
    end

    -- # DoTs
    -- actions+=/sunfire,target_if=refreshable,if=astral_power.deficit>=7&target.time_to_die>5.4&(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.sunfire)&(movement.distance>0|raid_event.movement.in>remains|remains<=execute_time*2)
    if tb and UnitExists(tb[1]) then
        for i=1,#tb do
            if UnitExists(tb[i]) and getDebuffRemain(tb[i],sunfire_debuff) <= 5 then
                if UnitPowerMax("player") - getRealMana("player") >= 7 and  getTimeToDie(tb[i]) > 5.4 and ( not  UnitBuffID("player", celestial_alignment) and  not  UnitBuffID("player", incarnation)  or  not az_streak_bool or  not  (getLastSpell() == sunfire) ) and (  getDebuffRemain(tb[i],sunfire_debuff) <= getGCD()*2) then
                    if canCast(sunfire) and castSpell(tb[i],sunfire) then
                        self:rest()
                        if ydebug.is_enabled then
                            print(8)
                            return 0
                        else
                            return 0
                        end
                    end
                end
            end
        end
    else
        if UnitExists(tg) and getDebuffRemain(tg,sunfire_debuff) <= 5 then
            if UnitPowerMax("player") - getRealMana("player") >= 7 and getTimeToDie(tg) > 5.4 and ( not UnitBuffID("player", celestial_alignment) and not  UnitBuffID("player", incarnation) or not az_streak_bool or not (getLastSpell() == sunfire) ) and (  getDebuffRemain(tg,sunfire_debuff) <= getGCD()*2) then
                if canCast(sunfire) and castSpell(tg,sunfire) then
                    if ydebug.is_enabled then
                        print(8)
                        return 0
                    else
                        return 0
                    end
                end
            end
        end
    end
    -- actions+=/moonfire,target_if=refreshable,if=astral_power.deficit>=7&target.time_to_die>6.6&(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.moonfire)&(movement.distance>0|raid_event.movement.in>remains|remains<=execute_time*2)
    if tb and UnitExists(tb[1]) then
        for i=1,#tb do
            if UnitExists(tb[i]) and getDebuffRemain(tb[i],moonfire_debuff) <= 5 then
                if  UnitPowerMax("player") - getRealMana("player")>=7 and  getTimeToDie(tb[i]) >6.6 and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or  not az_streak_bool or  not  (getLastSpell() == moonfire) ) and ( getDebuffRemain(tb[i],moonfire_debuff)<=getGCD()*2) then
                    if canCast(moonfire) and castSpell(tb[i],moonfire) then
                        self:rest()
                        if ydebug.is_enabled then
                            print(9)
                            return 0
                        else
                            return 0
                        end
                    end
                end
            end
        end
    else
        if UnitExists(tg) and getDebuffRemain(tg,moonfire_debuff) <= 5 then
            if  UnitPowerMax("player") - getRealMana("player")>=7 and  getTimeToDie(tg) >6.6 and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or  not az_streak_bool or  not  (getLastSpell() == moonfire) ) and ( getDebuffRemain(tg,moonfire_debuff)<=getGCD()*2) then
                if canCast(moonfire) and castSpell(tg,moonfire) then
                    if ydebug.is_enabled then
                        print(9)
                        return 0
                    else
                        return 0
                    end
                end
            end
        end
    end
    -- actions+=/stellar_flare,target_if=refreshable,if=astral_power.deficit>=12&target.time_to_die>7.2&(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.stellar_flare)
    if tb and UnitExists(tb[1]) then
        for i=1,#tb do
            if UnitExists(tb[i]) and getDebuffRemain(tb[i],stellar_flare) <= 5 and getLastSpell() ~= stellar_flare then
                if  UnitPowerMax("player") - getRealMana("player")>=12 and  getTimeToDie(tb[i]) >7.2 and ( not  UnitBuffID("player", celestial_alignment) and  not  UnitBuffID("player", incarnation) or  not az_streak_bool or  not  getLastSpell() == stellar_flare) then
                    if canCast(stellar_flare) and castSpell(tb[i],stellar_flare) then
                        if ydebug.is_enabled then
                            print(10)
                            return 0
                        else
                            return 0
                        end
                    end
                end
            end
        end
    else
        if UnitExists(tg) and getDebuffRemain(tg,stellar_flare) <= 5 and getLastSpell() ~= stellar_flare then
            if  UnitPowerMax("player") - getRealMana("player")>=12 and  getTimeToDie(tg) >7.2 and ( not  UnitBuffID("player", celestial_alignment) and  not  UnitBuffID("player", incarnation) or  not az_streak_bool or  not  getLastSpell() == stellar_flare) then
                if canCast(stellar_flare) and castSpell(tg,stellar_flare) then
                    if ydebug.is_enabled then
                        print(10)
                        return 0
                    else
                        return 0
                    end
                end
            end
        end
    end
    -- # Empowerment cap check
    -- actions+=/lunar_strike,if=astral_power.deficit>=16&(buff.lunar_empowerment.stack=3|(spell_targets<3&astral_power>=40&(buff.lunar_empowerment.stack=2&buff.solar_empowerment.stack=2)))&!(spell_targets.moonfire>=2&variable.az_potm=3&active_enemies=2)
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
    -- actions+=/solar_wrath,if=astral_power.deficit>=12&(buff.solar_empowerment.stack=3|(variable.az_sb>1&spell_targets.starfall<3&astral_power>=32&!buff.sunblaze.up))&!(spell_targets.moonfire>=2&active_enemies<=4&variable.az_potm=3)|(variable.az_streak&(buff.celestial_alignment.up|buff.incarnation.up)&!prev_gcd.1.solar_wrath&astral_power.deficit>=12)
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
    -- actions+=/starsurge,if=(spell_targets.starfall<3&(!buff.starlord.up|buff.starlord.remains>=4)|execute_time*(astral_power%40)>target.time_to_die)&(!buff.celestial_alignment.up&!buff.incarnation.up|variable.az_streak<2|!prev_gcd.1.starsurge)&(raid_event.movement.in>(buff.lunar_empowerment.stack*action.lunar_strike.execute_time+buff.solar_empowerment.stack*action.solar_wrath.execute_time)|(astral_power+buff.lunar_empowerment.stack*12+buff.solar_empowerment.stack*8)>=96)

    if (spell_targets<3 and ( not  UnitBuffID("player", starlord)  or  getBuffRemain("player", starlord) >=4) or getGCD()*( getRealMana("player") %40)> getTimeToDie(tg) ) and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or az_streak<2 or  not  (getLastSpell() == starsurge)) and  ( getRealMana("player") + getBuffStacks("player", lunar_empowerment)*12+ getBuffStacks("player", solar_empowerment)*8)>=96 then
        if canCast(starsurge) and castSpell(tg,starsurge) then
            if ydebug.is_enabled then
                print(13)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/starfall,if=spell_targets.starfall>=3&(!buff.starlord.up|buff.starlord.remains>=4)

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
    -- actions+=/new_moon,if=astral_power.deficit>10+execute_time%1.5

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
    -- actions+=/half_moon,if=astral_power.deficit>20+execute_time%1.5

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
    -- actions+=/full_moon,if=astral_power.deficit>40+execute_time%1.5

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
    -- actions+=/lunar_strike,if=((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=3&!buff.solar_empowerment.up)&(!buff.celestial_alignment.up&!buff.incarnation.up|variable.az_streak<2|!prev_gcd.1.lunar_strike)|(variable.az_ds&!buff.dawning_sun.up))&!(spell_targets.moonfire>=2&active_enemies<=4&(variable.az_potm=3|variable.az_potm=2&active_enemies=2))

    if (( getBuffRemain("player", warrior_of_elune) >0 or  getBuffRemain("player", lunar_empowerment) >0 or spell_targets>=3 and  not  UnitBuffID("player", solar_empowerment) ) and ( not  UnitBuffID("player", celestial_alignment)  and  not  UnitBuffID("player", incarnation)  or az_streak<2 or  not  (getLastSpell()== lunar_strike)) or (az_ds and  not  UnitBuffID("player", dawning_sun) )) and  not (spell_targets>=2 and active_enemies<=4 and (az_potm==3 or az_potm==2 and active_enemies==2)) then
        if canCast(lunar_strike) and castSpell(tg,lunar_strike) then
            if ydebug.is_enabled then
                print(18)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/solar_wrath,if=(!buff.celestial_alignment.up&!buff.incarnation.up|variable.az_streak<2|!prev_gcd.1.solar_wrath)&!(spell_targets.moonfire>=2&active_enemies<=4&(variable.az_potm=3|variable.az_potm=2&active_enemies=2))

    if ( not UnitBuffID("player", celestial_alignment) and not UnitBuffID("player", incarnation) or az_streak < 2 or not (getLastSpell() ==solar_wrath)) and not (spell_targets>=2 and active_enemies<=4 and (az_potm==3 or az_potm==2 and active_enemies==2)) then
        if canCast(solar_wrath) and castSpell(tg,solar_wrath) then
            if ydebug.is_enabled then
                print(19)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/sunfire,if=(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.sunfire)&!(variable.az_potm>=2&spell_targets.moonfire>=2)

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
end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);