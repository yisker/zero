----------------------------------------------
-- 模块属性
-- from simc 20181005
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
    L[rotation_name] = "武僧-踏风";
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

    local smg_setting = rotation.default_setting_category:create_setting("smg"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    smg_setting.display_name = L["散魔功"];
    smg_setting.description = "低于阈值且散魔功可用，使用散魔功疗伤"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    smg_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    smg_setting.default_value = 50; -- 变量默认值
    smg_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    smg_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    smg_setting.is_enabled_by_default = false; -- 是否默认启用
    smg_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    smg_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local qbh_setting = rotation.default_setting_category:create_setting("qbh"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    qbh_setting.display_name = L["躯不坏"];
    qbh_setting.description = "低于阈值且躯不坏可用，使用躯不坏疗伤"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    qbh_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    qbh_setting.default_value = 50; -- 变量默认值
    qbh_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    qbh_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    qbh_setting.is_enabled_by_default = false; -- 是否默认启用
    qbh_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    qbh_setting.value_width = 100; -- 值显示宽度像素（默认为100）


    local zdj_setting = rotation.default_setting_category:create_setting("zdj"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zdj_setting.display_name = L["壮胆酒"];
    zdj_setting.description = "低于阈值且壮胆酒可用，使用壮胆酒疗伤"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zdj_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    zdj_setting.default_value = 50; -- 变量默认值
    zdj_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    zdj_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zdj_setting.is_enabled_by_default = false; -- 是否默认启用
    zdj_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    zdj_setting.value_width = 100; -- 值显示宽度像素（默认为100）

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

    local ybzc_setting = rotation.default_setting_category:create_setting("ybzc"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    ybzc_setting.display_name = L["业报之触"];
    ybzc_setting.description = "设置是否启用业报之触作为保命技能"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ybzc_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    ybzc_setting.default_value = 40; -- 变量默认值
    ybzc_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    ybzc_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ybzc_setting.is_enabled_by_default = false; -- 是否默认启用
    ybzc_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    ybzc_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local lhzc_setting = rotation.default_setting_category:create_setting("lhzc"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    lhzc_setting.display_name = L["轮回之触"];
    lhzc_setting.description = "设置是否启用轮回之触"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    lhzc_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    lhzc_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    lhzc_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    lhzc_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    lhzc_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    lhzc_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    lhzc_setting.value_width = 120; -- 值显示宽度像素（默认为100）


    local zqb_setting = rotation.default_setting_category:create_setting("zqb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zqb_setting.display_name = L["真气波"];
    zqb_setting.description = "设置是否启用轮回之触"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zqb_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    zqb_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    zqb_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    zqb_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zqb_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    zqb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    zqb_setting.value_width = 120; -- 值显示宽度像素（默认为100）


    local bhq_setting = rotation.default_setting_category:create_setting("bhq"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    bhq_setting.display_name = L["白虎拳"];
    bhq_setting.description = "设置是否启用轮回之触"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    bhq_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    bhq_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    bhq_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    bhq_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    bhq_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    bhq_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    bhq_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    local hnj_setting = rotation.default_setting_category:create_setting("hnj"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    hnj_setting.display_name = L["豪能酒"];
    hnj_setting.description = "在开启爆发的前提下，是否启用豪能酒，低于阈值释放"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    hnj_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    hnj_setting.default_value = 40; -- 变量默认值
    hnj_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    hnj_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    hnj_setting.is_enabled_by_default = false; -- 是否默认启用
    hnj_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    hnj_setting.value_width = 100; -- 值显示宽度像素（默认为100）


    local hyj_setting = rotation.default_setting_category:create_setting("hyj"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    hyj_setting.display_name = L["虎眼酒"];
    hyj_setting.description = "是否启用豪能酒，高于阈值释放"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    hyj_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    hyj_setting.default_value = 10; -- 变量默认值
    hyj_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    hyj_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    hyj_setting.is_enabled_by_default = false; -- 是否默认启用
    hyj_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 10) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    hyj_setting.value_width = 100; -- 值显示宽度像素（默认为100）


    local bhxf_setting = rotation.default_setting_category:create_setting("bhxf"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    bhxf_setting.display_name = L["白虎下凡"];
    bhxf_setting.description = "在开启爆发的前提下，确定白虎下凡的释放方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    bhxf_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    bhxf_setting.default_value = "BOSS及AOE"; -- 变量默认值
    bhxf_setting.optional_values = {"卡CD", "BOSS及AOE"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    bhxf_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    bhxf_setting.is_enabled_by_default = false; -- 是否默认启用
    bhxf_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    bhxf_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local slb_setting = rotation.default_setting_category:create_setting("slb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    slb_setting.display_name = L["升龙霸"];
    slb_setting.description = "在开启爆发的前提下，确定升龙霸的释放方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    slb_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    slb_setting.default_value = "卡CD"; -- 变量默认值
    slb_setting.optional_values = {"卡CD", "BOSS及AOE"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    slb_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    slb_setting.is_enabled_by_default = false; -- 是否默认启用
    slb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    slb_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local bqns_setting = rotation.default_setting_category:create_setting("bqns"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    bqns_setting.display_name = L["屏气凝神"];
    bqns_setting.description = "在开启爆发的前提下，确定屏气凝神的释放方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    bqns_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    bqns_setting.default_value = "BOSS及AOE"; -- 变量默认值
    bqns_setting.optional_values = {"卡CD", "BOSS及AOE"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    bqns_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    bqns_setting.is_enabled_by_default = false; -- 是否默认启用
    bqns_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    bqns_setting.value_width = 130; -- 值显示宽度像素（默认为100）



    -- local swift_roundhouse_setting = rotation.default_setting_category:create_setting("swift_roundhouse"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    -- swift_roundhouse_setting.display_name = L["277669"];
    -- swift_roundhouse_setting.description = "设置是否启用277669"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    -- swift_roundhouse_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    -- swift_roundhouse_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    -- swift_roundhouse_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    -- swift_roundhouse_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    -- swift_roundhouse_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    -- swift_roundhouse_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    -- swift_roundhouse_setting.value_width = 120; -- 值显示宽度像素（默认为100）

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
    Touch_of_Death_setting.description = "按下这个键和左ctrl键切换爆发状态！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    Touch_of_Death_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    Touch_of_Death_setting.default_value = "Q"; -- 变量默认值
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
--全局函数
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
--过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
local function filler_unit(Unit)
    if (UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) then
        return true
    else
        return false
    end
end
-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    -- if (not argument or argument == "") then
    --     print("使用宏/"..ADDON_SLASH_COMMAND.." tafeng baofa控制爆发");
    -- else
    --     print("收到宏命令参数：", argument);
    -- end
    -- if argument == "baofa" then
    --     baofa = not baofa
    -- end
    -- if baofa == true then
    --     GH_Print("爆发开启")
    --     OverlayR("爆发开启")
    -- else
    --     GH_Print("爆发关闭")
    --     OverlayR("爆发关闭")
    -- end
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
    print("start now not ");
end
function rotation:prepause_action()
    -- 编写模块暂停前脚本。
    print("pause now not ");
end
function rotation:prezkmp_action()
    -- 编写模块停止前脚本。
    print("zkmp now not ");
end
function rotation:precombat_action()

    local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发 
    
    -- print(ADDON_SLASH_COMMAND)
    -- print(bf)
    -- print(isKeyDown(bf))
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
function rotation:serenity( ... )
    -- body
    -- actions.serenity=rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies<3|prev_gcd.1.spinning_crane_kick
    if active_enemies < 3 or (getLastSpell() == spinning_crane_kick) then
        if UnitExists(tg4) and castSpell(tg4,rising_sun_kick) then
            if tiaoshi.is_enabled then
                print(5051)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()    
    -- actions.serenity+=/fists_of_fury,if=(buff.bloodlust.up&prev_gcd.1.rising_sun_kick)|buff.serenity.remains<1|(active_enemies>1&active_enemies<5)
    if ( getBuffRemain("player",bloodlust) > 0 and getLastSpell() == rising_sun_kick ) or getBuffRemain("player",serenity) < 1 or ( active_enemies > 1 and active_enemies < 5 ) then
        if canCast(fists_of_fury) and (UnitBuffID("player",serenity) or getChi() >= 3) and castSpell(tg,fists_of_fury) then
            if tiaoshi.is_enabled then
                print(5061)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.serenity+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(active_enemies>=3|(active_enemies=2&prev_gcd.1.blackout_kick))
    if not (getLastSpell() == spinning_crane_kick) and ( active_enemies >= 3 or ( active_enemies == 2 and getLastSpell() == blackout_kick)) then
        if canCast(spinning_crane_kick) and (UnitBuffID("player",serenity) or getChi() >= 2) and castSpell(tg,spinning_crane_kick) then
            if tiaoshi.is_enabled then
                print(5071)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains
    if UnitExists(tg4) and canCast(blackout_kick) and (UnitBuffID("player",serenity) or getChi() >= 1) then
        if castSpell(tg4,blackout_kick) then
            if tiaoshi.is_enabled then
                print(5071)
                return 0
            else
                return 0
            end
        end
    end
    return 0
end
function rotation:cd( ... )
    -- body
    -- actions.cd=invoke_xuen_the_white_tiger
    if bhxf.is_enabled and bhxf.value == "卡CD" then
        if  canCast(invoke_xuen_the_white_tiger) and castSpell(tg,invoke_xuen_the_white_tiger) then
            if tiaoshi.is_enabled then
                print(3011)
                return 0
            else
                return 0
            end
        end
    elseif  bhxf.is_enabled and bhxf.value == "BOSS及AOE" and (isBoss(tg) or active_enemies >= aoenum.value) then
        if  canCast(invoke_xuen_the_white_tiger) and castSpell(tg,invoke_xuen_the_white_tiger) then
            if tiaoshi.is_enabled then
                print(3011)
                return 0
            else
                return 0
            end
        end    
    end
    
    self:rest()
    -- actions.cd+=/use_item,name=lustrous_golden_plumage
    if canUse(159617) and useItem(159617) then
    end
    self:rest()
    -- actions.cd+=/blood_fury
    -- actions.cd+=/berserking    
    -- actions.cd+=/arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
    if UnitPowerMax("player",12) - getChi() >= 1 and getTimeToMax("player") >= 0.5 then
        if canCast(arcane_torrent) and castSpell(zj,arcane_torrent) then
            if tiaoshi.is_enabled then
                print(3021)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.cd+=/lights_judgment
    -- actions.cd+=/fireblood
    -- actions.cd+=/ancestral_call  
    -- actions.cd+=/touch_of_death,if=target.time_to_die>9
    if getTimeToDie(tg) > 9 then
          if lhzc.is_enabled and canCast(touch_of_death) and castSpell(tg,touch_of_death) then
            if tiaoshi.is_enabled then
                print(3031)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.cd+=/storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|(cooldown.fists_of_fury.remains<=6&chi>=3&cooldown.rising_sun_kick.remains<=1)|target.time_to_die<=15
    if getCharges(storm_earth_and_fire) == 2 or ( getSpellCD(fists_of_fury) <= 6 and getChi() >= 3 and getSpellCD(rising_sun_kick) <= 1 ) or getTimeToDie(tg) <= 15 then
        if not getTalent(7,3) and canCast(storm_earth_and_fire) and getCharges(storm_earth_and_fire) >= 1 and castSpell(tg,storm_earth_and_fire) then
            if tiaoshi.is_enabled then
                print(6021)
                return 0
            else
                return 0
            end
        end
    end   
    self:rest()
    -- actions.cd+=/serenity,if=cooldown.rising_sun_kick.remains<=2|target.time_to_die<=12
    if getSpellCD(rising_sun_kick) <= 2 or getTimeToDie(tg) <= 12 then
        if bqns.is_enabled and (active_enemies >= aoenum.value or isBoss(tg)) and canCast(serenity) and castSpell(zj,serenity) then
            if tiaoshi.is_enabled then
                print(5041)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()    
    return 0
end
function rotation:aoe()
    -- actions.aoe=rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.whirling_dragon_punch.remains<5)&cooldown.fists_of_fury.remains>3    
    if ( getTalent(7,2) and getSpellCD(whirling_dragon_punch) < 5 ) and getSpellCD(fists_of_fury) > 3 then
        if UnitExists(tg1) and canCast(rising_sun_kick) and getChi() >= 2 and castSpell(tg1,rising_sun_kick) then
            if tiaoshi.is_enabled then
                print(2061)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()

    -- actions.aoe=whirling_dragon_punch
    if slb.is_enabled and (active_enemies >= aoenum.value or isBoss(tg)) and canCast(whirling_dragon_punch) and getSpellCD(fists_of_fury) > 0 and getSpellCD(rising_sun_kick) > 0 then
        if castSpell(tg,whirling_dragon_punch) then
            if tiaoshi.is_enabled then
                print(2051)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/energizing_elixir,if=!prev_gcd.1.tiger_palm&chi<=1&energy<50
    if not (getLastSpell() == tiger_palm) and getRealMana("player") < 50 then
        if hnj.is_enabled and getRealMana("player") <= hnj.value and canCast(energizing_elixir) and castSpell("player",energizing_elixir) then
            if tiaoshi.is_enabled then
                print(2011)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/fists_of_fury,if=energy.time_to_max>3
    if getTimeToMax("player") > 3 then
        if canCast(fists_of_fury) and getChi() >= 3 and castSpell(tg,fists_of_fury) then
            if tiaoshi.is_enabled then
                print(2031)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&energy.time_to_max>1
    if getBuffRemain("player",rushing_jade_wind) <= 0 then
        if canCast(rushing_jade_wind) and castSpell(tg,rushing_jade_wind) then
            if tiaoshi.is_enabled then
                print(6031)
                return 0
            else
                return 0
            end
        end
    end
    self:rest() 
    
    -- actions.aoe+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2))|energy.time_to_max<=3)
    if not (getLastSpell() ==  spinning_crane_kick) and ((( getChi() > 3 or getSpellCD(fists_of_fury) > 6 ) and ( getChi() >= 5 or getSpellCD(fists_of_fury) > 2 )) or getTimeToMax("player") <=3 ) then
        if canCast(spinning_crane_kick) and getChi() >= 2 and castSpell(tg,spinning_crane_kick) then
            if tiaoshi.is_enabled then
                print(2091)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/chi_burst,if=chi<=3
    if getChi() <= 3 then
        if canCast(chi_burst) and castSpell(zj,chi_burst) then
            if tiaoshi.is_enabled then
                print(2071)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.aoe+=/fist_of_the_white_tiger,if=chi.max-chi>=3&(energy>46|buff.rushing_jade_wind.down)
    if UnitPowerMax("player",12) - getChi() >= 3 and ( getRealMana("player") > 46 or getBuffRemain("player",rushing_jade_wind) <= 0 ) then
        if bhq.is_enabled and canCast(fist_of_the_white_tiger) and getRealMana("player") >= 40 and castSpell(tg,fist_of_the_white_tiger) then
            if tiaoshi.is_enabled then
                print(6071)
                return 0
            else
                return 0
            end
        end
    end 
    self:rest()      
    -- actions.aoe+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|!prev_gcd.1.tiger_palm)
    if UnitPowerMax("player",12) - getChi() >= 2 and ( not getTalent(6,1) or not (getLastSpell() == tiger_palm) ) then
        if UnitExists(tg1) and canCast(tiger_palm) and getRealMana("player") >= 50 and castSpell(tg1,tiger_palm) then
            if tiaoshi.is_enabled then
                print(2161)
                return 0
            else
                return 0
            end
        end
    end  
    self:rest() 
    -- actions.aoe+=/chi_wave
    if zqb.is_enabled and canCast(chi_wave) and castSpell(tg,chi_wave) then
        if tiaoshi.is_enabled then
            print(218)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.aoe+=/flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
    -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(buff.bok_proc.up|(talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi<4))
    if not (getLastSpell() == blackout_kick) and ( getBuffRemain("player",bok_proc) > 0 or ( getTalent(6,1) and (getLastSpell() == tiger_palm) and getChi() < 4 )) then
        if UnitExists(tg1) and canCast(blackout_kick) and getChi() >= 1 and castSpell(tg1,blackout_kick) then
            if tiaoshi.is_enabled then
                print(2111)
                return 0
            else
                return 0
            end
        end
    end   
    self:rest()
    return 0
end
function rotation:st( ... )
    -- body
    -- actions.st=whirling_dragon_punch    
    if slb.is_enabled and (active_enemies >= aoenum.value or isBoss(tg)) and canCast(whirling_dragon_punch) and getSpellCD(fists_of_fury) > 0 and getSpellCD(rising_sun_kick) > 0 then
        if castSpell(tg,whirling_dragon_punch) then
            if tiaoshi.is_enabled then
                print(6081)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- -- actions.st=cancel_buff,name=rushing_jade_wind,if=active_enemies=1&(!talent.serenity.enabled|cooldown.serenity.remains>3)
    -- if active_enemies == 1 and ( not getTalent(7,3) or getSpellCD(serenity) > 3 ) then
    --     if UnitBuffID("player",rushing_jade_wind) then
    --         cancelBuff(rushing_jade_wind)
    --     end
    -- end
    
    -- actions.st+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi>=5
    if getChi() >= 5 then
        if UnitExists(tg5) and canCast(rising_sun_kick) and (UnitBuffID("player",serenity) or getChi() >= 2) then
            if castSpell(tg5,rising_sun_kick) then
                if tiaoshi.is_enabled then
                    print(6101)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    self:rest()
    -- actions.st+=/fists_of_fury,if=energy.time_to_max>3
    if getTimeToMax("player") > 3 then
        if canCast(fists_of_fury) and (UnitBuffID("player",serenity) or getChi() >= 3) and castSpell(tg,fists_of_fury) then
            if tiaoshi.is_enabled then
                print(609)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.st+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
    if UnitExists(tg5) and canCast(rising_sun_kick) and (UnitBuffID("player",serenity) or getChi() >= 2) then
        if castSpell(tg5,rising_sun_kick) then
            if tiaoshi.is_enabled then
                print(6101)
                return 0
            else
                return 0
            end
        end
    end    
    self:rest()
    -- actions.st+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1    
    if getBuffRemain("player",rushing_jade_wind) <= 0 and  active_enemies > 1 then
        if canCast(rushing_jade_wind) and castSpell(tg,rushing_jade_wind) then
            if tiaoshi.is_enabled then
                print(6031)
                return 0
            else
                return 0
            end
        end
    end
    self:rest() 
    -- actions.st+=/fist_of_the_white_tiger,if=chi<=2&(buff.rushing_jade_wind.down|energy>46)
    if getChi() <= 2 and ( getBuffRemain("player",rushing_jade_wind) <= 0 or getRealMana("player") > 46 ) then
        if bhq.is_enabled and canCast(fist_of_the_white_tiger) and getRealMana("player") >= 40 and castSpell(tg,fist_of_the_white_tiger) then
            if tiaoshi.is_enabled then
                print(6071)
                return 0
            else
                return 0
            end
        end
    end 
    self:rest()  
    -- actions.st+=/energizing_elixir,if=chi<=3&energy<50
    if getChi() <= 3 and getRealMana("player") < 50 then
        if hnj.is_enabled and getRealMana("player") <= hnj.value and canCast(energizing_elixir) and castSpell("player",energizing_elixir) then
            if tiaoshi.is_enabled then
                print(6041)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.st+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(cooldown.rising_sun_kick.remains>3|chi>=3)&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm))&buff.swift_roundhouse.stack<2
    if not (getLastSpell() ==  blackout_kick) and ( getSpellCD(rising_sun_kick) > 3 or getChi() >= 3 ) and ( getSpellCD(fists_of_fury) > 4 or getChi()>= 4 or ( getChi() == 2 and getLastSpell() ==  tiger_palm)) and getBuffStacks("player",277669) < 2 then
        if UnitExists(tg1) and canCast(blackout_kick) and getChi() >= 1 and castSpell(tg1,blackout_kick) then
            if tiaoshi.is_enabled then
                print(21111)
                return 0
            else
                return 0
            end
        end
    end   
    self:rest()
    -- actions.st+=/chi_wave
    if zqb.is_enabled and canCast(chi_wave) and castSpell(tg,chi_wave) then
        if tiaoshi.is_enabled then
            print(615)
            return 0
        else
            return 0
        end
    end
    self:rest()
    -- actions.st+=/chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
    if UnitPowerMax("player",12) - getChi() >= 1 and active_enemies == 1 or UnitPowerMax("player",12) - getChi() >= 2 then
        if canCast(chi_burst) and castSpell(zj,chi_burst) then
            if tiaoshi.is_enabled then
                print(6161)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions.st+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.tiger_palm&chi.max-chi>=2&(buff.rushing_jade_wind.down|energy>56)
    if not (getLastSpell() == tiger_palm) and UnitPowerMax("player",12) - getChi() >= 2  then
        if UnitExists(tg5) and canCast(tiger_palm) and getRealMana("player") >= 50 and castSpell(tg5,tiger_palm) then
            if tiaoshi.is_enabled then
                print(6061)
                return 0
            else
                return 0
            end
        end
    end 
    self:rest()
    -- actions.st+=/flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3&buff.swift_roundhouse.stack<2,interrupt=1    
    return 0
end
function rotation:default_action()

    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;
    --------------------------------------------------------------
    self:rest();    
    -- spell_haste = GetHaste("player")/100
    time = (GetTime() - Y.data["Combat Started"]) or 0
    gcd = getGCD()
    charges_fractional = getChargesFrac
    -- local regen = select(2,GetPowerRegen("player"))
	-- local focus = getRealMana("player")
    castSpell = csi
    --------------------------------------------------------------
    tgtype = self.settings.targets --目标选择
    zlsyz = self.settings.zlsyz --治疗石
    -- local lgsh = self.settings.lgsh --灵龟守护
    ddyz = self.settings.ddyz --打断
    -- local pethp = self.settings.pethp --宠物治疗
    spsolt = self.settings.spsolt --饰品
    aoenum = self.settings.aoenum --饰品
    -- local wd = self.settings.wd --误导
    bf = self.settings.Touch_of_Death.value --爆发
    tiaoshi = self.settings.ydebug --调试信息
    ybzc = self.settings.ybzc--业报之触
    lhzc = self.settings.lhzc--业报之触
    -- swift_roundhouse = self.settings.swift_roundhouse--277669
    zqb = self.settings.zqb--真气波
    bhq = self.settings.bhq--白虎拳
    hnj = self.settings.hnj--豪能酒
    bhxf = self.settings.bhxf--白虎下凡
    smg = self.settings.smg--散魔功
    qbh = self.settings.qbh--躯不坏
    slb = self.settings.slb--升龙霸
    bqns = self.settings.bqns--屏气凝神
    zdj = self.settings.zdj--壮胆酒
    hyj = self.settings.hyj--虎眼酒

    --------------------------------------------------------------
    if IsLeftControlKeyDown() and isKeyDown(bf) and GetTime() - tt > 1 then
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
    --------------------------------------------------------------   
    --获得第一个符合条件的目标
    if tgtype.value == "智能" then
        tg = getOneEnemy(5,filler_unit)        
        --如果有当前目标，并且当前目标可以攻击，则对当前目标攻击
        if UnitExists("target") and isAlive("target") and UnitCanAttack("player","target") then
            tg = "target"
            -- --print(tg)
        end
    end
    -- --print(tg)
    if tgtype.value ~= "智能" then
        tg = "target"
    end
    if tg then
        TargetUnit(tg)
    end    
    --------------------------------------------------------------
    active_enemies = getNumEnemies("player",8)
    spell_targets = active_enemies
    zj = "player"
    tb = getEnemy(5,filler_unit)
    tier21_4pc = false
    tier19_2pc = false
    --------------------------------------------------------------
    function getDebuffRemainMin(tb,debuffid)
        -- body
        if tb ~= nil and UnitExists(tb[1]) then 
            local tgg = tb[1]
            if #tb == 1 then
                return tb[1]
            end
            for i=1,#tb do
                if tb[i] and UnitExists(tb[i]) and isAlive(tb[i]) and not UnitDebuffID(tb[i],debuffid) then
                    return tb[i]                
                elseif tb[i] and UnitExists(tb[i]) and isAlive(tb[i]) and getDebuffRemain(tgg,debuffid) > getDebuffRemain(tb[i],debuffid) then
                    tgg = tb[i]
                    self:rest()
                end
            end
            return tgg
        end
        return "target"
    end 
    tg5 = getDebuffRemainMin(tb,mark_of_the_crane)
    tg1 = tg5
    tg4 = tg5 
    --------------------------------------------------------------    
    spear_hand_strike = 116705--切喉手
    touch_of_karma = 122470--业报之触
    touch_of_death = 115080--轮回之触
    serenity = 152173--屏气凝神
    if not baofa then
        serenity = 1
    end
    storm_earth_and_fire = 137639--风火雷电
    if not baofa then
        storm_earth_and_fire = 1
    end
    drinking_horn_cover = 209256--脚被盖子
    fists_of_fury = 113656--怒雷破
    rising_sun_kick = 107428--旭日
    tiger_palm = 100780--猛虎掌
    fist_of_the_white_tiger = 261947--白虎拳
    energizing_elixir = 115288--豪能酒
    if not baofa then
        energizing_elixir = 1
    end
    arcane_torrent = 129597
    whirling_dragon_punch = 152175--升龙霸
    chi_burst = 123986--真气爆裂
    bok_proc = 116768--免费幻灭
    spinning_crane_kick = 101546--神鹤
    mark_of_the_crane = 228287--神鹤dbuff
    blackout_kick = 100784 --幻灭踢
    crackling_jade_lightning = 117952--碎玉闪电
    the_emperors_capacitor = 235053
    chi_wave = 115098--真气波
    invoke_xuen_the_white_tiger = 123904--白虎下凡
    if not baofa then
        invoke_xuen_the_white_tiger = 1
    end
    hidden_masters_forbidden_touch = 213112
    bloodlust = 2825--嗜血
    rushing_jade_wind = 261715--碧玉疾风
    --------------------------------------------------------------
    if not UnitExists(tg) then
        return 
    end
    --------------------------------------------------------------  
    
    if smg.is_enabled and getHP("player") <= smg.value then
        if canCast(122783) and castSpell("player",122783) then
        end
    end

    if zdj.is_enabled and getHP("player") <= zdj.value then
        if canCast(201318) and castSpell("player",201318) then
        end
    end

    if qbh.is_enabled and getHP("player") <= qbh.value then
        if canCast(122278) and castSpell("player",122278) then
        end
    end

    if zlsyz.is_enabled and getHP("player") <= zlsyz.value then
        if canUse(5512) and useItem(5512) then
        end
    end

    if hyj.is_enabled and getBuffStacks("player",247483) >= hyj.value and canCast(247383) then
        if castSpell("player",247483) then
        end
    end

    
    -- actions=auto_attack
    if time < 5 and UnitExists(tg) then
        StartAttack(tg)
    end
    -- actions+=/spear_hand_strike,if=target.debuff.casting.react
    if ddyz.is_enabled and canCast(spear_hand_strike) and amac(tg,1,ddyz.value) then
        if castSpell(tg,spear_hand_strike) then
            if tiaoshi.is_enabled then
                print(101)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/rushing_jade_wind,if=talent.serenity.enabled&cooldown.serenity.remains<3&energy.time_to_max>1&buff.rushing_jade_wind.down
    if getTalent(7,3) and getSpellCD(serenity) < 3 and getTimeToMax("player") > 1 and not UnitBuffID("player",rushing_jade_wind) then
        if canCast(rushing_jade_wind) and castSpell(tg,rushing_jade_wind) then
            if tiaoshi.is_enabled then
                print(1011)
                return 0
            else
                return 0
            end
        end
    end 
    self:rest()
    -- actions+=/touch_of_karma,interval=90,pct_health=0.5,if=!talent.Good_Karma.enabled,interval=90,pct_health=0.5
    -- actions+=/touch_of_karma,interval=90,pct_health=1,if=talent.good_karma.enabled,interval=90,pct_health=1
    -- actions+=/touch_of_karma,interval=90,pct_health=1.0
    -- actions+=/touch_of_karma,interval=90,pct_health=0.5
    if ybzc.is_enabled and canCast(touch_of_karma) and getHP("player") <= ybzc.value then
        if castSpell(tg,touch_of_karma) then
            if tiaoshi.is_enabled then
                print(102)
                return 0
            else
                return 0
            end
        end
    elseif not ybzc.is_enabled and canCast(touch_of_karma) and getHP(tg) >= 50 then
        if castSpell(tg,touch_of_karma) then
            if tiaoshi.is_enabled then
                print(103)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/potion,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
    -- actions+=/call_action_list,name=serenity,if=buff.serenity.up
    if UnitBuffID("player",serenity) then
        self:serenity()
    end
    self:rest()
    -- actions+=/fist_of_the_white_tiger,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=3
    if ( getTimeToMax("player") < 1 or ( getTalent(7,3) and getSpellCD(serenity) < 2 ) ) and UnitPowerMax("player",12) - getChi() >= 3 then
        if bhq.is_enabled and canCast(fist_of_the_white_tiger) and getRealMana("player") >= 40 and castSpell(tg,fist_of_the_white_tiger) then
            if tiaoshi.is_enabled then
                print(1031)
                return 0
            else
                return 0
            end
        end
    end
    self:rest()
    -- actions+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=2&!prev_gcd.1.tiger_palm
    if ( getTimeToMax("player") < 1 or ( getTalent(7,3) and getSpellCD(serenity) < 2 ) ) and UnitPowerMax("player",12) - getChi() >= 2 and not (getLastSpell() ==  energizing_elixir) then
        if UnitExists(tg5) and canCast(tiger_palm) and getRealMana("player") >= 50 and castSpell(tg5,tiger_palm) then
            if tiaoshi.is_enabled then
                print(617)
                return 0
            else
                return 0
            end
        end
    end 
    self:rest() 
    -- actions+=/call_action_list,name=cd
    self:cd()
    self:rest() 
    -- actions+=/call_action_list,name=st,if=active_enemies<3
    if active_enemies < aoenum.value then
        self:st()
    end 
    self:rest()
    -- actions+=/call_action_list,name=aoe,if=active_enemies>=3
    if active_enemies >= aoenum.value then
        self:aoe()
    end
    self:rest()	
    if Y.lastspell_cast == tiger_palm and GetTime() - Y.lastspell_time > gcd*2 then
        if castSpell(tg,tiger_palm) then
		    GH_Print("记录一下，看一局能打出多少提示")
	    end
    end
    self:rest()
end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);