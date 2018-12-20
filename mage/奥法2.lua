----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "0c02decd-b730-4509-b5bf-259d28ca3c28";
-- 定义循环的英文名称。
local rotation_name = "bing_fa";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "法师-奥术";
    L["Welcome to use test module."] = "欢迎使用奥法测试模块！";
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
rotation.macro = "aofa";
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
    ydebug_setting.display_name = L["ydebug"]; -- 变量在界面上显示的名字
    ydebug_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

    


    local aoenum_setting = dps_category:create_setting("aoenum"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoenum_setting.display_name = L["aoenum"];
    aoenum_setting.description = "超过设定人数，进入AOE循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    aoenum_setting.default_value = 4; -- 变量默认值
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

    local xlms_setting = dps_category:create_setting("xlms"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    xlms_setting.display_name = L["泄蓝模式"];
    xlms_setting.description = "确定泄蓝方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    xlms_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    xlms_setting.default_value = "仅BOSS"; -- 变量默认值
    xlms_setting.optional_values = {"卡CD", "仅BOSS"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    xlms_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    xlms_setting.is_enabled_by_default = false; -- 是否默认启用
    xlms_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    xlms_setting.value_width = 130; -- 值显示宽度像素（默认为100）

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
    Touch_of_Death_setting.display_name = L["强制泄蓝"];
    Touch_of_Death_setting.description = "按下这个键切换强制泄蓝状态！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

    


    
end
-----------------------------------------------------------
--过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
local function filler_unit(Unit)
    if (UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) then
        return true
    else
        return false
    end
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
if Y == nil then Y = {};end
if Y.baofa == nil then Y.baofa = false; end
if baofa == nil then baofa = false;end
if tt == nil then tt = 0;end
if variable == nil then variable = {};end


local function AzeriteRanks(ids)
    -- body
    local ranks = 0
    local azeritetable = getMyAzeriteTraits()
    return azeritetable[ids]
end
-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    if (not argument or argument == "") then
        print("使用宏/"..ADDON_SLASH_COMMAND.." bingfa baofa控制爆发");
    else
        print("收到宏命令参数：", argument);
    end
    if argument == "baofa" then
        baofa = not baofa
    end
    if baofa == true then
        lk = 0
        GH_Print("强制泄蓝开启")
        OverlayR("强制泄蓝开启")
    else
        GH_Print("强制泄蓝关闭")
        OverlayR("强制泄蓝关闭")
    end

end
function rotation:condition_action()
    -- 编写判断模块是否可用的脚本。
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 62 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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


    
    
    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
    if isKeyDown(bf) and GetTime() - tt > 1 then
        baofa = not baofa
        tt = GetTime()
        if baofa then
            lk = 0
            GH_Print("强制泄蓝开启")
            OverlayY("强制泄蓝开启")
        else
            GH_Print("强制泄蓝关闭")
            OverlayY("强制泄蓝关闭")
        end
    end
	if not UnitBuffID("player",1459) then
	    castSpell("player",1459)
    end
    if lk == 0 and UnitExists(tg) and UnitCanAttack("player",tg) and isCastingSpell("player",evocation) then
        self:burn()
    end
    -- if lk == 1 and UnitExists(tg) and UnitCanAttack("player",tg)  then
    --     self:conserve()
    -- end
    self:rest();
end

function rotation:burn(args)
    lk = 0
    
    
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
    if canCast(arcane_power) and castSpell("player",arcane_power) then
        if ydebug.is_enabled then
            print(225)
            return 0
        else
            return 0
        end
    end
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
    if getMana("player") <= variable.lk_mana and canCast(evocation) and castSpell("player",evocation) then
        -- lk = 0
        if ydebug.is_enabled then
            print(213)
            return 0
        else
            return 0
        end
    end  
    -- # For the rare occasion where we go oom before evocation is back up. (Usually because we get very bad rng so the burn is cut very short)
    -- actions.burn+=/arcane_barrage
    if UnitPower("player",16) == 4 and canCast(arcane_barrage) and castSpell(tg,arcane_barrage) then
        print("离开MP："..getMana("player"))
        variable.lk_mana = getMana("player") + 5        
        lk = 1
        if ydebug.is_enabled then
            print(212)
            return 0
        else
            return 0
        end
    end  
    
    
    
    return 0
end


function rotation:conserve(args)
    -- print(variable.average_burn_length)
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
    if ( UnitExists(tg) and getDebuffRemain(tg,nether_tempest) <= 3) and UnitPower("player",16) == UnitPowerMax("player",16) and getBuffRemain("player",rune_of_power) <= 0 and getBuffRemain("player",arcane_power) <= 0 then
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



function rotation:default_action()

    if variable.burntime == nil then variable.burntime = GetTime();end
    if variable.average_burn_length == nil or variable.average_burn_length >= 30 then variable.average_burn_length = 10;end
    if variable.lk_mana == nil or variable.average_burn_length >= 30 then variable.lk_mana = 20;end
    if lk == nil then lk = 0;end
    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
    if isKeyDown(bf) and GetTime() - tt > 1 then
        baofa = not baofa
        tt = GetTime()
        if baofa then
            lk = 0
            GH_Print("强制泄蓝开启")
            OverlayY("强制泄蓝开启")
        else
            GH_Print("强制泄蓝关闭")
            OverlayY("强制泄蓝关闭")
        end
    end  
    
    if isCastingSpell("player",evocation) and getMana("player") >= 85 then
        SpellStopCasting()
    end
    
    -- 不打断施法
    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.01 then return; end;

    --获得变量
    -- aoe_blizzard = self.settings.aoetg --暴风雪
    aoe_num = self.settings.aoenum --aoe人数
    tgtype = self.settings.targets --目标选择
    ydebug = self.settings.ydebug --调试信息
    isbus = self.settings.isbus --坐骑
    -- callpet = self.settings.callpet --坐骑
    -- jslq = self.settings.jslq --急速冷却
    zlsyz = self.settings.zlsyz --治疗石
    xlms = self.settings.xlms --治疗石
    -- hbpz = self.settings.hbpz --寒冰屏障
    -- hbht = self.settings.hbht --寒冰护体
    -- lgpz = self.settings.lgpz --棱光屏障
    -- daduan = self.settings.daduan --打断
    -- orb = self.settings.orb --溜溜球
    -- baofa = Y.baofa --爆發

    if isbus.is_enabled and isBused("player") then return; end

    -- 本地化
    lastSpellCast = getLastSpell()
    
    
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
    zj = "player"
    --获得目标周围8码的敌人数量
    if UnitExists(tg) then
        active_enemies = getNumEnemies(tg,8)
    else
        active_enemies = 0
    end    
    
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
    
    
    
    -- local tier20_2pc = false  
    
    charges_fractional = getChargesFrac
    castSpell = csi

    -- talents=2032021
    local t1 = 2.25
    if getCastTime(arcane_blast) ~= 0 then t1 = getCastTime(arcane_blast);end
    variable.average_burn_length = math.floor( 110000/13500 ) * t1 
    
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
    variable.conserve_mana = 70
    -- actions.precombat+=/snapshot_stats
    -- actions.precombat+=/mirror_image
    -- actions.precombat+=/potion
    -- actions.precombat+=/arcane_blast
    burn_phase = getSpellCD(arcane_power) == 0 and getSpellCD(evocation) <= variable.average_burn_length and ( UnitPower("player",16) == UnitPowerMax("player",16) or ( getTalent(4,2) and getSpellCD(charged_up) == 0 ))

    
    print("LK:"..lk)
    -- actions+=/call_action_list,name=movement
    if isMoving("player") then
        self:movement()
    end
    -- # Executed every time the actor is available.
    -- # Interrupt the boss when possible.
    -- actions=counterspell,if=target.debuff.casting.react
    -- # Go to Burn Phase when already burning, or when boss will die soon.
    -- actions+=/call_action_list,name=burn,if=burn_phase|target.time_to_die<variable.average_burn_length
    if burn_phase then
        lk = 0
    end
    if (burn_phase --[[ or getTimeToDie(tg) < variable.average_burn_length ]] or lk==0) and ( (xlms.value == "仅BOSS" and isBoss(tg)) or xlms.value == "卡CD" ) then        
        self:burn()
        -- return
    end
    -- # Start Burn Phase when Arcane Power is ready and Evocation will be ready (on average) before the burn phase is over. Also make sure we got 4 Arcane Charges, or can get 4 Arcane Charges with Charged Up.
    -- actions+=/call_action_list,name=burn,if=(cooldown.arcane_power.remains=0&cooldown.evocation.remains<=variable.average_burn_length&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|(talent.charged_up.enabled&cooldown.charged_up.remains=0&buff.arcane_charge.stack<=1)))
    if (( getSpellCD(arcane_power) == 0 and getSpellCD(evocation) <= variable.average_burn_length and ( UnitPower("player",16) ==  UnitPowerMax("player",16) or ( getTalent(4,2) and getSpellCD(charged_up) == 0 and UnitPower("player",16) <=1 ))) or lk == 0) and ( (xlms.value == "仅BOSS" and isBoss(tg)) or xlms.value == "卡CD" ) then        
        self:burn()
        -- return
    end
    print(burn_phase)
    -- actions+=/call_action_list,name=conserve,if=!burn_phase
    if not burn_phase or lk == 1 then     
        self:conserve()
        -- return
    end


end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);