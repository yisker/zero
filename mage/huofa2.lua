print("test dev")
----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "10363ceb-08b6-49c3-8812-1fdba04f8ffd";
-- 定义循环的英文名称。
local rotation_name = "dev";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "自助";
    L["Welcome to use test module."] = "欢迎使用自助测试模块！";
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
rotation.macro = "dev";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
-- do
--     -- -- 添加一个自定义类别test_category。
--     local jc_category = rotation:create_setting_category("jc_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
--     jc_category.display_name = L["|cff00FFFF基础设置"]; -- 类别在界面上显示的名字

--     -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
--     local ydebug_setting = jc_category:create_setting("ydebug"); -- 指定变量的名字为test1，用于在脚本中进行引用
--     ydebug_setting.display_name = L["ydebug"]; -- 变量在界面上显示的名字
--     ydebug_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
--     ydebug_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
--     ydebug_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
--     ydebug_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
--     ydebug_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
--     ydebug_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
--     ydebug_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
--     ydebug_setting.value_width = 120; -- 值显示宽度像素（默认为100）
    

--     -----------------------------------------------------------


--     -- -- 添加一个自定义类别test_category。
--     local hps_category = rotation:create_setting_category("hps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
--     hps_category.display_name = L["|cff00FFFF治疗设置"]; -- 类别在界面上显示的名字

--     local zlsyz_setting = hps_category:create_setting("zlsyz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
--     zlsyz_setting.display_name = L["治疗石"];
--     zlsyz_setting.description = "低于阈值且治疗石可用，使用治疗石疗伤"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
--     zlsyz_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
--     zlsyz_setting.default_value = 20; -- 变量默认值
--     zlsyz_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
--     zlsyz_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
--     zlsyz_setting.is_enabled_by_default = false; -- 是否默认启用
--     zlsyz_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
--         if (value > 0 or value <= 100) then
--             return true;
--         else
--             return false, "The number is not right.";
--         end
--     end;
--     zlsyz_setting.value_width = 100; -- 值显示宽度像素（默认为100）   
 

--     -----------------------------------------------------------



--     -- -- 添加一个自定义类别test_category。
--     local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
--     dps_category.display_name = L["|cff00FFFF输出设置"]; -- 类别在界面上显示的名字

    

--     -- 在类别test_category下添加配置变量test5
--     local targets_setting = dps_category:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
--     targets_setting.display_name = L["targets"];
--     targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
--     targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
--     targets_setting.default_value = "智能"; -- 变量默认值
--     targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
--     targets_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
--     targets_setting.is_enabled_by_default = false; -- 是否默认启用
--     targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
--     targets_setting.value_width = 130; -- 值显示宽度像素（默认为100）
 
--     local raidus_setting = dps_category:create_setting("raidus"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
--     raidus_setting.display_name = L["目标距离"];
--     raidus_setting.description = "确定目标的选取距离"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
--     raidus_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
--     raidus_setting.default_value = "40"; -- 变量默认值
--     raidus_setting.optional_values = {"40", "35", "30", "25", "20", "15", "10", "8", "5"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
--     raidus_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
--     raidus_setting.is_enabled_by_default = false; -- 是否默认启用
--     raidus_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
--     raidus_setting.value_width = 130; -- 值显示宽度像素（默认为100）

--     local pettarget_setting = dps_category:create_setting("pettarget"); -- 指定变量的名字为test1，用于在脚本中进行引用
--     pettarget_setting.display_name = L["宠物援护"]; -- 变量在界面上显示的名字
--     pettarget_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
--     pettarget_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
--     pettarget_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
--     pettarget_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
--     pettarget_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
--     pettarget_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
--     pettarget_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
--     pettarget_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    


    
-- end

do
    -- -- 添加一个自定义类别test_category。
    local jc_category = rotation:create_setting_category("jc_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    jc_category.display_name = L["|cff00FFFF基础设置"]; -- 类别在界面上显示的名字

    -- -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local ydebug_setting = jc_category:create_setting("ydebug"); -- 指定变量的名字为test1，用于在脚本中进行引用
    ydebug_setting.display_name = L["ydebug"]; -- 变量在界面上显示的名字
    ydebug_setting.description = "调试信息"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

    local aszh_setting = jc_category:create_setting("aszh"); -- 指定变量的名字为test1，用于在脚本中进行引用
    aszh_setting.display_name = L["自动补奥术智慧Buff"]; -- 变量在界面上显示的名字
    aszh_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aszh_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    aszh_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    aszh_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    aszh_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    aszh_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    aszh_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    aszh_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    local preheat_setting = jc_category:create_setting("preheat"); -- 指定变量的名字为test1，用于在脚本中进行引用
    preheat_setting.display_name = L["是否点出273331特质"]; -- 变量在界面上显示的名字
    preheat_setting.description = "是否点出273331特质"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    preheat_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    preheat_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    preheat_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    preheat_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    preheat_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    preheat_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    preheat_setting.value_width = 120; -- 值显示宽度像素（默认为100）

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
    hbht_setting.display_name = L["烈焰护体"];
    hbht_setting.description = "烈焰护体"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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


     -- -- 添加一个自定义类别test_category。
     local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
     dps_category.display_name = L["|cff00FFFF输出设置"]; -- 类别在界面上显示的名字


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

    local daduan_setting = dps_category:create_setting("daduan"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    daduan_setting.display_name = L["打断"];
    daduan_setting.description = "打断"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    daduan_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    daduan_setting.default_value = 0.4; -- 变量默认值
    daduan_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    daduan_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    daduan_setting.is_enabled_by_default = false; -- 是否默认启用
    daduan_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 1) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    daduan_setting.value_width = 100; -- 值显示宽度像素（默认为100）

end
-----------------------------------------------------------
-- 注册事件
-----------------------------------------------------------
--注册事件
do
    if Y                        == nil then Y                       = {};   end; --初始化总空间
    if Y.lastspell_failed       == nil then Y.lastspell_failed      = {};   end; --初始化最近一次失败法术的记录空间    
    if Y.lastspell_success      == nil then Y.lastspell_success     = {};   end; --初始化最近一次成功法术的记录空间
    if Y.spell_cast_return      == nil then Y.spell_cast_return     = 0;    end; --初始化最近一次成功法术返回的值    
    if Y.lastspell_failed.spellname == nil then Y.lastspell_failed.spellname = 0; end
    if Y.lastspell_failed.spelltarget == nil then Y.lastspell_failed.spelltarget = "player";end
    if Y.lastspell_failed.spelltime == nil then Y.lastspell_failed.spelltime = GetTime();end
    if Y.lastspell_success.spellName == nil then Y.lastspell_success.spellName = 0; end
    if Y.lastspell_success.spelltarget == nil then Y.lastspell_success.spelltarget = "player";end
    if Y.lastspell_success.spelltime == nil then Y.lastspell_success.spelltime = GetTime();end
    

    
    if Y.data == nil then Y.data = {}; end;
    if Y.nNove == nil then Y.nNove = {}; end;
    if Y.nTank == nil then Y.nTank = {}; end;

    
    if Y.debug == nil then Y.debug = false;  end;
    if Y.baofa == nil then Y.baofa = false;  end;

    function SetupTables()        
        table.wipe(Y.nNove)
        table.wipe(Y.nTank)
        local group =  IsInRaid() and "raid" or "party" 
        local groupSize = IsInRaid() and GetNumGroupMembers() or 
        GetNumGroupMembers() - 1

        for i=1, groupSize do
          local groupUnit = group..i      
          if UnitExists(groupUnit) then table.insert(Y.nNove, groupUnit); end -- Inserting a newly created Unit into the Main Frame
          if UnitExists(groupUnit) and UnitGroupRolesAssigned(groupUnit) == "TANK" then table.insert(Y.nTank, groupUnit); end
        end

        table.insert(Y.nNove, "player")
        
    end

    local guid = UnitGUID("player")
    local frame = CreateFrame('Frame')
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    -------------------------------------------------------------------------------------------------------------------
    -- 记录进入战斗后自己释放成功和失败的技能队列，

    -- 通过访问Y.spelllist_failed.spellname获得上一次失败的技能ID，
    -- 通过访问Y.spelllist_failed.spelltarget获得上一次失败的技能目标，
    -- 通过访问Y.spelllist_failed.spelltime获得上一次失败的时间，    
    -- Y.spelllist_failed[id]为最近一次释放同ID技能失败的列表，键值是name，target，stime

    -- 通过访问Y.lastspell_success.spellname获得上一次成功的技能ID，
    -- 通过访问Y.lastspell_success.spelltarget获得上一次成功的技能目标，
    -- 通过访问Y.lastspell_success.spelltime获得上一次成功的时间，
    -- Y.spelllist_success[id]为最近一次释放同ID技能成功的列表，键值是name，target，stime

    -- Y.spell_cast_return用来返回当前施法的技能id，配合castspell来返回是否施法成功
    -------------------------------------------------------------------------------------------------------------------
    local function reader(self,event,...)
        local timeStamp, param, hideCaster, source, sourceName, sourceFlags, 
        sourceRaidFlags, destination,
        destName, destFlags, destRaidFlags, spell, spellName, _, spellType = CombatLogGetCurrentEventInfo()

        if source == guid then
            --施法失败的处理
            if param == "SPELL_CAST_FAILED" then
                if sourceName ~= nil then
                    if isInCombat("player") and UnitIsUnit(sourceName,"player") and spell ~= 48018 and spell ~= 48020 then
                        Y.lastspell_failed.spellname = spell
                        Y.lastspell_failed.spelltarget = destination
                        Y.lastspell_failed.spelltime = GetTime()
                        --对本次失败的ID进行初始化
                        if Y.spelllist_failed[spell] == nil then 
                            Y.spelllist_failed[spell] = {};
                        end
                        table.insert(Y.spelllist_failed[spell],{name = spell, target = destination, stime = Y.spelllist_failed.spelltime})
                        if source == guid and Y.debug == true then
                            GH_Print(spellName.." 失败原因: "..spellType)
                        end
                        --如果施法失败，就要把开始施法的数据重置
                        if spell == Y.lastspell_start then
                            Y.lastspell_start = 0
                        end
                    end
                end
            end
            --针对castspell的返回值处理
            if param == "SPELL_CAST_START" or param == "SPELL_CAST_SUCCESS" then
                if isInCombat("player") and UnitIsUnit(sourceName,"player") then
                    if Y.lastspell_start == nil then Y.lastspell_start = {}; end;
                    Y.lastspell_start.spellName   = spell --记录ID
                    Y.lastspell_start.spelltime   = GetTime() --记录时间
                    Y.spell_cast_return = spell
                end
            end
            
            if param == "SPELL_CAST_SUCCESS" then
                if sourceName ~= nil then
                    if isInCombat("player") and UnitIsUnit(sourceName,"player") then
                        Y.lastspell_success.spellName = spell
                        Y.lastspell_success.spelltarget = destination
                        Y.lastspell_success.spelltime = GetTime()
                        if Y.spelllist_success[spell] == nil then 
                            Y.spelllist_success[spell] = {};
                        end
                        table.insert(Y.spelllist_success[spell],{name = spell, target = destination, stime = Y.lastspell_success.spelltime})
                        if destination then
                            if Y.debug == true then             
                                GH_Print("成功对 "..destName.." ".."施放了 "..spellName)
                            end                        
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
    -- 离开战斗或者玩家死亡，清除所有的Y
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
        SetupTables()
        end
        if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_DEAD"  then
            Y.data["Combat Started"] = 0
            -- Y.lastspell_failed = {};
            -- Y.lastspell_success = {};
            Y.spell_cast_return = 0;       
        
        end
    end
    Frame:SetScript("OnEvent",EnteringCombat)
    
    --   -------------------------------------------------------------------------------------------------------------------
    --   -- 创建队友列表，通过团队时间驱动刷新
    --   -- 通过访问Y.nNove获得队友列表，
    --   -- 通过访问Y.nTank获得坦克列表
    --   -------------------------------------------------------------------------------------------------------------------
    local updateHealingTable = CreateFrame("frame", nil)
    updateHealingTable:RegisterEvent("GROUP_ROSTER_UPDATE")
    updateHealingTable:SetScript("OnEvent", function()
        table.wipe(Y.nNove)
        table.wipe(Y.nTank)  
        SetupTables()
    end)

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


-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- -- 编写执行模块宏对应的处理脚本。
    -- if (not argument or argument == "") then
    --     print("使用宏/"..ADDON_SLASH_COMMAND.." dev ");
    -- else
    --     print("收到宏命令参数：", argument);
    -- end    
    -- 编写执行模块宏对应的处理脚本。
    if (not argument or argument == "") then
        GH_Print("使用宏/"..ADDON_SLASH_COMMAND.." huofa baofa控制爆发");
    else
        GH_Print("收到宏命令参数：", argument);
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
    -- local current_specialization = GetSpecializationInfo(GetSpecialization())
    -- local speci = 62 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
    -- return current_specialization == speci;
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 63 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
    return current_specialization == speci;
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
    
    
    
    self:rest();
end
function castanying( ... )
    -- body
    if castSpell("target",686) then
        print("补充")
    end
end
function rotation:default_action()  
    
    

    
    
    -- 不打断施法
    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.01 then return; end;

    --获得变量
    
    
    tgtype = self.settings.targets --目标选择
    ydebug = self.settings.ydebug --调试信息    
    zlsyz = self.settings.zlsyz --治疗石    
    -- pettarget = self.settings.pettarget --宠物
    raidus = tonumber(self.settings.raidus.value) --距离

    if GetSpecializationInfo(GetSpecialization()) == 266 and not (UnitCastingInfo("player") or UnitChannelInfo("player")) and getSpellCD(61304) <= 0 and UnitExists("target") and isAlive("target") and UnitCanAttack("player","target") and (Y.lastspell_success.spelltime ~= nil and GetTime() - Y.lastspell_success.spelltime > 1) then
        castanying()
    end;

    if not UnitBuffID("player",5697) and castSpell("player",5697) then
    end
    
    
    --获得第一个符合条件的目标
    if tgtype.is_enabled and tgtype.value == "智能" then
              
        --如果有当前目标，并且当前目标可以攻击，则对当前目标攻击
        if UnitExists("target") and isAlive("target") and UnitCanAttack("player","target") then
            tg = "target"
            return 0            
        end

        if not UnitExists("target") or not isAlive("target") or not UnitCanAttack("player","target") then
            tg = getOneEnemy(raidus,filler_unit)  
            TargetUnit(tg)
            return 0
        end
    end 
    
    
    
    -----------------------------------------------------------
    --保命
    --治疗石
    if zlsyz.is_enabled and getHP("player") <= zlsyz.value and canUse(5512) then
        useItem(5512)
    end  

    

end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);