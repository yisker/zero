----------------------------------------------
-- 模块属性
-- from simc 20181017
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
    L[rotation_name] = "法师-冰霜";
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
rotation.interval = 0.01;
-- 定义模块专用宏命令，下面的例子会定义出：/zeus test [argument]。如果不需要宏控制，则删除下面一行。
rotation.macro = "bingfa";
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

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local callpet_setting = jc_category:create_setting("callpet"); -- 指定变量的名字为test1，用于在脚本中进行引用
    callpet_setting.display_name = L["自动召唤水元素"]; -- 变量在界面上显示的名字
    callpet_setting.description = "自动召唤水元素"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    callpet_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    callpet_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    callpet_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    callpet_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    callpet_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    callpet_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    callpet_setting.value_width = 120; -- 值显示宽度像素（默认为100）

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

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local jslq_setting = hps_category:create_setting("jslq"); -- 指定变量的名字为test1，用于在脚本中进行引用
    jslq_setting.display_name = L["急速冷却"]; -- 变量在界面上显示的名字
    jslq_setting.description = "自动急速冷却"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    jslq_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    jslq_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    jslq_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    jslq_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    jslq_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    jslq_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    jslq_setting.value_width = 120; -- 值显示宽度像素（默认为100）


    local hbpz_setting = hps_category:create_setting("hbpz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    hbpz_setting.display_name = L["寒冰屏障"];
    hbpz_setting.description = "寒冰屏障"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    hbpz_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    hbpz_setting.default_value = 20; -- 变量默认值
    hbpz_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    hbpz_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    hbpz_setting.is_enabled_by_default = true; -- 是否默认启用
    hbpz_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    hbpz_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local hbht_setting = hps_category:create_setting("hbht"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    hbht_setting.display_name = L["寒冰护体"];
    hbht_setting.description = "寒冰护体"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    hbht_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    hbht_setting.default_value = 70; -- 变量默认值
    hbht_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    hbht_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    hbht_setting.is_enabled_by_default = true; -- 是否默认启用
    hbht_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    hbht_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local lgpz_setting = hps_category:create_setting("lgpz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    lgpz_setting.display_name = L["棱光屏障"];
    lgpz_setting.description = "棱光屏障"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    lgpz_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    lgpz_setting.default_value = 30; -- 变量默认值
    lgpz_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    lgpz_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    lgpz_setting.is_enabled_by_default = true; -- 是否默认启用
    lgpz_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    lgpz_setting.value_width = 100; -- 值显示宽度像素（默认为100）


    -----------------------------------------------------------



    -- -- 添加一个自定义类别test_category。
    local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    dps_category.display_name = L["|cff00FFFF输出设置"]; -- 类别在界面上显示的名字

    local aoetg_setting = dps_category:create_setting("aoetg"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoetg_setting.display_name = L["aoetg"];
    aoetg_setting.description = "用来确定暴风雪技能目标释放位置，智能表示放在人群最密集的地方"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoetg_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    aoetg_setting.default_value = "智能"; -- 变量默认值
    aoetg_setting.optional_values = {"智能", "自己", "小队T", "焦点", "鼠标", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    aoetg_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    aoetg_setting.is_enabled_by_default = true; -- 是否默认启用
    aoetg_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    aoetg_setting.value_width = 130; -- 值显示宽度像素（默认为100）


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

    local hxfb_setting = dps_category:create_setting("hxfb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    hxfb_setting.display_name = L["AOE彗星风暴人数"];
    hxfb_setting.description = "AOE情况下超过设定人数，打彗星风暴"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    hxfb_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    hxfb_setting.default_value = 3; -- 变量默认值
    hxfb_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    hxfb_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    hxfb_setting.is_enabled_by_default = true; -- 是否默认启用
    hxfb_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0) then
            return true;
        else
            return false, "The number is too small.";
        end
    end;
    hxfb_setting.value_width = 100; -- 值显示宽度像素（默认为100）



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
    Touch_of_Death_setting.display_name = L["爆发Ctrl+"];
    Touch_of_Death_setting.description = "按下这个键和Ctrl键切换爆发状态！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local orb_setting = hps_category:create_setting("orb"); -- 指定变量的名字为test1，用于在脚本中进行引用
    orb_setting.display_name = L["溜溜球"]; -- 变量在界面上显示的名字
    orb_setting.description = "自动溜溜球"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    orb_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    orb_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    orb_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    orb_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    orb_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    orb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    orb_setting.value_width = 120; -- 值显示宽度像素（默认为100）


    
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
    hbht = self.settings.hbht --寒冰屏障
    if hbht.is_enabled and getHP(zj) <= hbht.value and canCast(11426) and not UnitBuffID("player",11426) and not isBused("player") then
        if castSpell(zj,11426) then
        end
    end
    local callpet = self.settings.callpet --坐骑
    --水元素
    local isbus = self.settings.isbus --坐骑  
    if isbus.is_enabled and not isBused("player") then 
        
        if _t1==nil then _t1=GetTime(); end
        if callpet.is_enabled and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then            
            if not UnitExists("pet") or not isAlive("pet") then
                castSpell(zj,31687)
            end
        end    
        _t1=GetTime()+ 5
         
    end    
    
    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
    if IsControlKeyDown() and isKeyDown(bf) and GetTime() - tt > 1 then
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
	if not UnitBuffID("player",1459) then
	castSpell("player",1459)
	end
    self:rest();
end

function rotation:aoe()    
    -- actions.aoe=frozen_orb
    if orb.is_enabled and canCast(frozen_orb) and castSpell(tg,frozen_orb) then
        if ydebug.is_enabled then
            print(101)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/blizzard    
    if aoe_blizzard.is_enabled and canCast(blizzard) then
        if aoe_blizzard.value == "智能" then
            local tg1 = getBiggestUnitCluster(30,10,filler_unit)
            if not UnitExists(tg1) then tg1 = "player";end
            castSpell(tg1,blizzard)
        elseif aoe_blizzard.value == "自己" then
            local tg1 = "player"
            castSpell(tg1,blizzard)
        elseif aoe_blizzard.value == "小队T" then
            local tg1 = getMT()
            if not UnitExists(tg1) then tg1 = "player";end
            castSpell(tg1,blizzard)
        elseif aoe_blizzard.value == "焦点" then
            local tg1 = "focus"
            if not UnitExists(tg1) then tg1 = "player";end
            castSpell(tg1,blizzard)
        elseif aoe_blizzard.value == "鼠标" then
            local tg1 = "mouseover"
            if not UnitExists(tg1) then tg1 = "player";end
            castSpell(tg1,blizzard)
        elseif aoe_blizzard.value == "当前目标" then
            local tg1 = "target"
            if not UnitExists(tg1) then tg1 = "player";end
            castSpell(tg1,blizzard)
        end
    end
    self:rest()
    -- actions.aoe+=/comet_storm --此处增加彗星风暴的使用条件
    if canCast(comet_storm) and hxfb.is_enabled and active_enemies >= hxfb.value and ( (getTalent(3,1) and getBuffStacks("player",116267) >= 4) or (not getTalent(3,1)) ) and castSpell(tg,comet_storm) then
        if ydebug.is_enabled then
            print(102)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/ice_nova
    if canCast(ice_nova) and castSpell(tg,ice_nova) then
        if ydebug.is_enabled then
            print(103)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/flurry,if=prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.frostbolt&(buff.icicles.stack<4|!talent.glacial_spike.enabled)|prev_gcd.1.glacial_spike)
    if lastSpellCast == ebonbolt or UnitBuffID("player",brain_freeze) and ( lastSpellCast == frostbolt and ( getBuffStacks("player",icicles) < 4 or not getTalent(7,3) ) or lastSpellCast == glacial_spike ) then
        if canCast(flurry) and castSpell(tg,flurry) then
            if ydebug.is_enabled then
                print(104)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/ice_lance,if=buff.fingers_of_frost.react
    if  UnitBuffID("player",fingers_of_frost) then
        if canCast(ice_lance) and castSpell(tg,ice_lance) then
            if ydebug.is_enabled then
                print(105)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/ray_of_frost
    if canCast(ray_of_frost) and castSpell(tg,ray_of_frost) then
        if ydebug.is_enabled then
            print(106)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/ebonbolt
    if canCast(ebonbolt) and castSpell(tg,ebonbolt) then
        if ydebug.is_enabled then
            print(108)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/glacial_spike
    if canCast(glacial_spike) and castSpell(tg,glacial_spike) then
        if ydebug.is_enabled then
            print(109)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/cone_of_cold
    if canCast(cone_of_cold) and castSpell(tg,cone_of_cold) then
        if ydebug.is_enabled then
            print(120)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/frostbolt
    if canCast(frostbolt) and castSpell(tg,frostbolt) then
        if ydebug.is_enabled then
            print(121)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/call_action_list,name=movement
    if isMoving("player") then
        self:movement()        
        return 0
    end
    self:rest()
    -- actions.aoe+=/ice_lance
    if canCast(ice_lance) and castSpell(tg,ice_lance) then
        if ydebug.is_enabled then
            print(123)
            return 0
        else
            return 0
        end
    end
    self:rest()
    return 0
end

function rotation:cooldowns()    
    -- actions.cooldowns=icy_veins
    if baofa and canCast(icy_veins) and castSpell(zj,icy_veins) then
        if ydebug.is_enabled then
            print(201)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.cooldowns+=/mirror_image
    if baofa and canCast(mirror_image) and castSpell(zj,mirror_image) then
        if ydebug.is_enabled then
            print(202)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.cooldowns+=/rune_of_power,if=prev_gcd.1.frozen_orb|time_to_die>10+cast_time&time_to_die<20
    if getLastSpell() == frozen_orb or getTimeToDie(tg) > 10 + getCastTime(rune_of_power) and getTimeToDie(tg) < 20 then
        if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
            if ydebug.is_enabled then
                print(203)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.cooldowns+=/call_action_list,name=talent_rop,if=talent.rune_of_power.enabled&active_enemies=1&cooldown.rune_of_power.full_recharge_time<cooldown.frozen_orb.remains    
    if getTalent(3,3) and active_enemies == 1 and full_recharge_time(rune_of_power) < getSpellCD(frozen_orb) then
        self:talent_rop()
    end
    self:rest()    
    -- actions.cooldowns+=/potion,if=prev_gcd.1.icy_veins|target.time_to_die<70
    -- actions.cooldowns+=/use_items
    if baofa and canUse(13) and useItem(13) then
        if ydebug.is_enabled then
            print(207)
            return 0
        else
            return 0
        end
    end
    self:rest()
    if baofa and canUse(14) and useItem(14) then
        if ydebug.is_enabled then
            print(208)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.cooldowns+=/blood_fury
    if baofa and canCast(blood_fury) and castSpell(zj,blood_fury) then
        if ydebug.is_enabled then
            print(209)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.cooldowns+=/berserking
    if baofa and canCast(berserking) and castSpell(zj,berserking) then
        if ydebug.is_enabled then
            print(210)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.cooldowns+=/lights_judgment
    -- actions.cooldowns+=/fireblood
    -- actions.cooldowns+=/ancestral_call
    return 0
end

function rotation:movement()
    -- actions.movement=blink,if=movement.distance>10
    -- actions.movement+=/ice_floes,if=buff.ice_floes.down
    if not UnitBuffID("player",ice_floes) then
        if canCast(ice_floes) and castSpell(zj,ice_floes) then
            if ydebug.is_enabled then
                print(401)
                return 0
            else
                return 0
            end
        end
    end
    return 0
end

function rotation:single()
    -- actions.single=ice_nova,if=cooldown.ice_nova.ready&debuff.winters_chill.up
    if getSpellCD(ice_nova) <= 0 and UnitExists(tg) and UnitDebuffID(tg,winters_chill) then
        if canCast(ice_nova) and castSpell(tg,ice_nova) then
            if ydebug.is_enabled then
                print(301)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.single+=/flurry,if=talent.ebonbolt.enabled&prev_gcd.1.ebonbolt&(!talent.glacial_spike.enabled|buff.icicles.stack<4|buff.brain_freeze.react)
    if getTalent(4,3) and getLastSpell() == ebonbolt and ( not getTalent(7,3) or getBuffStacks("player",icicles) < 4 or UnitBuffID("player",brain_freeze) ) then
        if canCast(flurry) and castSpell(tg,flurry) then
            if ydebug.is_enabled then
                print(3021)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.single+=/flurry,if=talent.glacial_spike.enabled&prev_gcd.1.glacial_spike&buff.brain_freeze.react
    if getTalent(7,3) and lastSpellCast == glacial_spike and UnitBuffID("player",brain_freeze) then
        if canCast(flurry) and castSpell(tg,flurry) then
            if ydebug.is_enabled then
                print(3022)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.single+=/flurry,if=prev_gcd.1.frostbolt&buff.brain_freeze.react&(!talent.glacial_spike.enabled|buff.icicles.stack<4)
    if lastSpellCast == frostbolt and UnitBuffID("player",brain_freeze) and ( not getTalent(7,3) or getBuffStacks("player",icicles) < 4 ) then
        if canCast(flurry) and castSpell(tg,flurry) then
            if ydebug.is_enabled then
                print(3023)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()





    -- actions.single+=/flurry,if=!talent.glacial_spike.enabled&(prev_gcd.1.ebonbolt|buff.brain_freeze.react&prev_gcd.1.frostbolt)
    -- if not getTalent(7,3) and (lastSpellCast == ebonbolt or UnitBuffID("player",brain_freeze) and lastSpellCast== frostbolt) then
    --     if canCast(flurry) and castSpell(tg,flurry) then
    --         if ydebug.is_enabled then
    --             print(302)
    --             return 0
    --         else
    --             return 0
    --         end
    --     end
    -- end
    -- self:rest()
    -- actions.single+=/flurry,if=talent.glacial_spike.enabled&buff.brain_freeze.react&(prev_gcd.1.frostbolt&buff.icicles.stack<4|prev_gcd.1.glacial_spike|prev_gcd.1.ebonbolt)
    -- if getTalent(7,3) and UnitBuffID("player",brain_freeze) and (lastSpellCast == frostbolt and getBuffStacks("player",icicles) < 4 or lastSpellCast == glacial_spike or lastSpellCast == ebonbolt) then
    --     if canCast(flurry) and castSpell(tg,flurry) then
    --         if ydebug.is_enabled then
    --             print(303)
    --             return 0
    --         else
    --             return 0
    --         end
    --     end
    -- end
    -- self:rest()
    -- actions.single+=/frozen_orb
    if orb.is_enabled and canCast(frozen_orb) and castSpell(tg,frozen_orb) then
        if ydebug.is_enabled then
            print(304)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.single+=/blizzard,if=active_enemies>2|active_enemies>1&cast_time=0&buff.fingers_of_frost.react<2
    if aoe_blizzard.is_enabled and  ( active_enemies > 2 or active_enemies > 1 and getCastTime(blizzard) <= 0 and getBuffRemain("player",fingers_of_frost) < 2 ) then
        if canCast(blizzard) and castSpell(tg,blizzard) then
            if ydebug.is_enabled then
                print(305)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.single+=/ice_lance,if=buff.fingers_of_frost.react
    if  UnitBuffID("player",fingers_of_frost) then
        if canCast(ice_lance) and castSpell(tg,ice_lance) then
            if ydebug.is_enabled then
                print(306)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()    
    -- actions.single+=/comet_storm
    if canCast(comet_storm) and hxfb.is_enabled and ( (getTalent(3,1) and getBuffStacks("player",116267) >= 4) or (not getTalent(3,1)) )  and castSpell(tg,comet_storm) then
        if ydebug.is_enabled then
            print(308)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.single+=/ebonbolt
    if canCast(ebonbolt) and castSpell(tg,ebonbolt) then
        if ydebug.is_enabled then
            print(3091)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.single+=/ebonbolt,if=!talent.glacial_spike.enabled|buff.icicles.stack=5&!buff.brain_freeze.react
    -- if not getTalent(7,3) or getBuffStacks("player",icicles) == 5 and not UnitBuffID("player",brain_freeze) then
    --     if canCast(ebonbolt) and castSpell(tg,ebonbolt) then
    --         if ydebug.is_enabled then
    --             print(309)
    --             return 0
    --         else
    --             return 0
    --         end
    --     end
    -- end
    -- self:rest()
    -- actions.single+=/ray_of_frost,if=!action.frozen_orb.in_flight&ground_aoe.frozen_orb.remains=0
    if getOneMyMissile() ~= frozen_orb and active_enemies < 2 then
        if canCast(ray_of_frost) and castSpell(tg,ray_of_frost) then
            if ydebug.is_enabled then
                print(307)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.single+=/blizzard,if=cast_time=0|active_enemies>1    
    if aoe_blizzard.is_enabled and getCastTime(blizzard) == 0 or active_enemies > 1 then
        if canCast(blizzard) and castSpell(tg,blizzard) then
            if ydebug.is_enabled then
                print(311)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.single+=/glacial_spike,if=buff.brain_freeze.react|prev_gcd.1.ebonbolt|active_enemies>1&talent.splitting_ice.enabled
    if UnitBuffID("player",brain_freeze) or lastSpellCast == ebonbolt or active_enemies > 1 and getTalent(6,2) then
        if canCast(glacial_spike) and castSpell(tg,glacial_spike) then
            if ydebug.is_enabled then
                print(310)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()    
    -- actions.single+=/ice_nova
    if canCast(ice_nova) and castSpell(tg,ice_nova) then
        if ydebug.is_enabled then
            print(312)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.single+=/flurry,if=azerite.winters_reach.enabled&!buff.brain_freeze.react&buff.winters_reach.react
    
    -- actions.single+=/frostbolt
    if canCast(frostbolt) and castSpell(tg,frostbolt) then
        if ydebug.is_enabled then
            print(313)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.single+=/call_action_list,name=movement
    --這裏判斷也有問題
    if isMoving("player") then
        self:movement()
    end
    self:rest()
    -- actions.single+=/ice_lance
    if canCast(ice_lance) and castSpell(tg,ice_lance) then
        if ydebug.is_enabled then
            print(315)
            return 0
        else
            return 0
        end
    end
    self:rest()
    return 0     

end

function rotation:talent_rop( ... )
    -- body
    -- actions.talent_rop=rune_of_power,if=talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time)
    if getTalent(7,3) and getBuffStacks("player",icicles) == 5 and ( UnitBuffID("player",brain_freeze) or getTalent(4,3) and getSpellCD(ebonbolt) < getCastTime(rune_of_power) ) then
        if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
            if ydebug.is_enabled then
                print(401)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.talent_rop+=/rune_of_power,if=!talent.glacial_spike.enabled&(talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time|talent.comet_storm.enabled&cooldown.comet_storm.remains<cast_time|talent.ray_of_frost.enabled&cooldown.ray_of_frost.remains<cast_time|charges_fractional>1.9)
    if not getTalent(7,3) and ( getTalent(4,3) and getSpellCD(ebonbolt) < getCastTime(rune_of_power) or getTalent(6,3) and getSpellCD(comet_storm) < getCastTime(rune_of_power) or getTalent(7,2) and getSpellCD(ray_of_frost) < getCastTime(rune_of_power) or charges_fractional(rune_of_power) > 1.9 ) then
        if canCast(rune_of_power) and castSpell(zj,rune_of_power) then
            if ydebug.is_enabled then
                print(402)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
end

function rotation:default_action()

    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发    
    if IsControlKeyDown() and isKeyDown(bf) and GetTime() - tt > 1 then
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
    if UnitCastingInfo("player") or UnitChannelInfo("player") and getSpellCD(61304) > 0.01 then return; end;

    --获得变量
    aoe_blizzard = self.settings.aoetg --暴风雪
    aoe_num = self.settings.aoenum --aoe人数
    tgtype = self.settings.targets --目标选择
    ydebug = self.settings.ydebug --调试信息
    isbus = self.settings.isbus --坐骑
    callpet = self.settings.callpet --坐骑
    jslq = self.settings.jslq --急速冷却
    zlsyz = self.settings.zlsyz --治疗石
    hbpz = self.settings.hbpz --寒冰屏障
    hbht = self.settings.hbht --寒冰护体
    lgpz = self.settings.lgpz --棱光屏障
    daduan = self.settings.daduan --打断
    orb = self.settings.orb --溜溜球
    hxfb = self.settings.hxfb --彗星风暴
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
    
    blizzard = 190356 --暴风雪
    -- local frost_bomb = 112948 --寒冰炸弹
    counterspell = 2139 --法术反制
    comet_storm = 153595 --彗星风暴
    zannesu_journey = 206397 --扎奈苏的旅程
    -- local frozen_mass = 242253 --寒冰质量
    cone_of_cold = 120 --冰锥术
    mirror_image = 55342 --镜像
    blood_fury = 20572 --血性狂怒
    berserking = 26297 --狂暴
    arcane_torrent = 28730 --奥术洪流
    lights_judgment = 255647
    ice_floes = 108839 --浮冰
    ice_lance = 30455 --冰枪术
    fingers_of_frost = 44544 --寒冰指
    flurry = 44614 --冰风暴
    ice_nova = 157997 --寒冰新星
    winters_chill = 228358 --深冬之寒
    -- local water_jet = 135029 --水流喷射
    frostbolt = 116 --寒冰箭
    brain_freeze = 190446 --冰冷智慧
    icy_veins = 12472 --冰冷血脉
    ray_of_frost = 205021 --冰霜射线
    rune_of_power = 116011 --能量符文
    rune_of_power_buff = 116014 --能量符文
    ebonbolt = 257537 --黑冰箭
    glacial_spike = 199786 --冰川尖刺
    icicles = 205473 --冰刺
    frozen_orb = 84714 --寒冰寶珠
    
    
    
    -- local tier20_2pc = false  
    
    charges_fractional = getChargesFrac
    castSpell = csi

    --确保5层冰刺用黑冰箭之后跟大冰川
    if getBuffStacks("player",icicles) == 5 and getLastSpell() == ebonbolt then
        if canCast(glacial_spike) and castSpell(tg,glacial_spike) then
            return
        end
    end

    --确保黑冰剑和大冰刺之后接冰风暴
    if  ( getLastSpell() == glacial_spike or  (getLastSpell() == ebonbolt and getBuffStacks("player",icicles) ~= 5)) and UnitBuffID("player",brain_freeze) then
        if canCast(flurry) and castSpell(tg,flurry) then
            return 0
        end
    end

    --确保冰风暴后接冰枪
    if getLastSpell() == flurry then
        if canCast(ice_lance) and castSpell(tg,ice_lance) then
            return 0
        end
    end


    --水元素
    -- if callpet.is_enabled then
    --     if not UnitExists("pet") or not isAlive("pet") then
    --         castSpell(zj,31687)
    --     end
    -- end

    if _t1==nil then _t1=GetTime(); end
    if callpet.is_enabled and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then            
        if not UnitExists("pet") or not isAlive("pet") then
            castSpell(zj,31687)
        end
    end    
    _t1=GetTime()+ 5

    -- 石头
    if getHP(zj) <= zlsyz.value and canUse(5512) then
        useItem(5512)
    end

    -- 当你身上没有低温41425DEBUFF，且你的寒冰屏障CD时，且你的血量低于50%，则释放急速冷却235219（做开关）
    if jslq.is_enabled and not UnitDebuffID("player",41425) and getSpellCD(45438) > 0 and getHP("player") < 50 then
        if canCast(235219) and castSpell(zj,235219) then
        end
    end

    -- 当自己的血低于多少时，则释放寒冰屏障45438（做阈值，默认20）
    if hbpz.is_enabled and getHP(zj) <= hbpz.value and canCast(45438) then
        if castSpell(zj,45438) then
        end
    end

    -- 当自己的血低于多少时，则释放寒冰护体11426（做阈值，默认70）
    if hbht.is_enabled and getHP(zj) <= hbht.value and canCast(11426) and not UnitBuffID("player",11426) then
        if castSpell(zj,11426) then
        end
    end

    -- 当自己的血低于多少时，则释放棱光屏障235450（做阈值，默认30）
    if lgpz.is_enabled and getHP(zj) <= lgpz.value and canCast(235450) then
        if castSpell(zj,235450) then
        end
    end

    -- 移动时寒冰箭
    if isMoving("player") then
        if castSpell(tg,ice_lance) then
            return
        end
    end


    -- # Executed every time the actor is available.
    -- actions=counterspell
    if daduan.is_enabled and canCast(counterspell) and amac(tg,1,daduan.value) then
        if castSpell(tg,counterspell) then
            if ydebug.is_enabled then
                print(1)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()

    --进攻驱散
    local pdlist = getEnemy(30)
    self:rest()
    for i = 1,#pdlist do
        local p1 = pdlist[i] 
        if tqmf == true and canPD(p1,true) and isInCombat(p1) then
            if csi(p1,30449)  then
                GH_Print("已偷取敌方魔法！！！")
                self:rest()
            end
        end
    end
    --去除诅咒
    local fd = getFriend(30)
    self:rest()
    for i = 1,#fd do
        local p1 = fd[i] 
        if qczz == true and UnitExists(p1) and isAlive(p1) and isInCombat(p1) then

            if csi(p1,475)  then
                GH_Print("已驱散诅咒！！！")
                self:rest()
            end
        end
    end

    -- -- # If the mage has FoF after casting instant Flurry, we can delay the Ice Lance and use other high priority action, if available.
    -- actions+=/ice_lance,if=prev_gcd.1.flurry&brain_freeze_active&!buff.fingers_of_frost.react
    -- actions+=/ice_lance,if=prev_gcd.1.flurry&!buff.fingers_of_frost.react
    if lastSpellCast == flurry and not UnitBuffID("player",fingers_of_frost) then
        if castSpell(tg,ice_lance) then
            if ydebug.is_enabled then
                print(1)
                return 0
            else
                return 0
            end
        end
    end    
    self:rest()
    -- # Time Warp is used right at the start. If the actor has Shard of the Exodar, try to synchronize the second Time Warp with Icy Veins. If the target is about to die, use Time Warp regardless.
    -- actions+=/time_warp,if=buff.bloodlust.down&(buff.exhaustion.down|equipped.shard_of_the_exodar)&(prev_gcd.1.icy_veins|target.time_to_die<50)
    -- actions+=/call_action_list,name=cooldowns
    if true then 
        self:cooldowns()     
    end
    self:rest()
    -- # The target threshold isn't exact. Between 3-5 targets, the differences between the ST and AoE action lists are rather small. However, Freezing Rain prefers using AoE action list sooner as it benefits greatly from the high priority Blizzard action.
    -- actions+=/call_action_list,name=aoe,if=active_enemies>3&talent.freezing_rain.enabled|active_enemies>4
    if active_enemies >= aoe_num.value - 1 and getTalent(6,2) or active_enemies > aoe_num.value then        
        self:aoe()
    end
    self:rest()
    -- actions+=/call_action_list,name=single
    self:single()
    -- GH_Print(1)
    self:rest();

    -- debugprofilestop()

    -- print(debugprofilestop())


end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);