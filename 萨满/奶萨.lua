----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "aa710ab4-13b8-4aef-af39-9a676e21113a";
-- 定义循环的英文名称。
local rotation_name = "naisha";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "萨满-恢复";
    L["Welcome to use test module."] = "欢迎使用奶萨测试模块！";    
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
rotation.macro = "naisha";
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
    ydebug_setting.display_name = L["调试信息"]; -- 变量在界面上显示的名字
    ydebug_setting.description = "打开以后显示调试信息"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ydebug_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    ydebug_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    ydebug_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    ydebug_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ydebug_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    ydebug_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    ydebug_setting.value_width = 120; -- 值显示宽度像素（默认为100）


    -- 在类别test_category下添加配置变量test5
    local targets_setting = jc_category:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    targets_setting.display_name = L["治疗目标选择"];
    targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    targets_setting.default_value = "智能"; -- 变量默认值
    targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    targets_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    targets_setting.is_enabled_by_default = false; -- 是否默认启用
    targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    targets_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local jxsl_setting = jc_category:create_setting("jxsl"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    jxsl_setting.display_name = L["极限省蓝"];
    jxsl_setting.description = "打开以后低于设置蓝量，就进入极限省蓝模式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    jxsl_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    jxsl_setting.default_value = 30; -- 变量默认值
    jxsl_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    jxsl_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    jxsl_setting.is_enabled_by_default = false; -- 是否默认启用
    jxsl_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0) then
            return true;
        else
            return false, "The number is too small.";
        end
    end;
    jxsl_setting.value_width = 100; -- 值显示宽度像素（默认为100）



-----------------------------------------------------------

    -- -- 添加一个自定义类别test_category。
    local hps_category = rotation:create_setting_category("hps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    hps_category.display_name = L["|cff00FFFF治疗设置"]; -- 类别在界面上显示的名字

    local aoenum_setting = hps_category:create_setting("aoenum1"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoenum_setting.display_name = L["小队团刷人数"];
    aoenum_setting.description = "低于指定血量超过设定人数，进入团刷循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

    local aoenum_setting = hps_category:create_setting("aoehp1"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoenum_setting.display_name = L["小队团刷血量"];
    aoenum_setting.description = "低于指定血量超过设定人数，进入团刷循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    aoenum_setting.default_value = 70; -- 变量默认值
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

    local aoenum_setting = hps_category:create_setting("aoenum2"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoenum_setting.display_name = L["团队团刷人数"];
    aoenum_setting.description = "低于指定血量超过设定人数，进入团刷循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    aoenum_setting.default_value = 5; -- 变量默认值
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

    local aoenum_setting = hps_category:create_setting("aoehp2"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoenum_setting.display_name = L["团队团刷血量"];
    aoenum_setting.description = "低于指定血量超过设定人数，进入团刷循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    aoenum_setting.default_value = 80; -- 变量默认值
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

    local byzlrs_setting = hps_category:create_setting("byzlrs"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    byzlrs_setting.display_name = L["奔涌之流人数"];
    byzlrs_setting.description = "奔涌之流人数"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    byzlrs_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    byzlrs_setting.default_value = 3; -- 变量默认值
    byzlrs_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    byzlrs_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    byzlrs_setting.is_enabled_by_default = true; -- 是否默认启用
    byzlrs_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    byzlrs_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local byzlhp_setting = hps_category:create_setting("byzlhp"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    byzlhp_setting.display_name = L["奔涌之流血量"];
    byzlhp_setting.description = "奔涌之流血量"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    byzlhp_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    byzlhp_setting.default_value = 70; -- 变量默认值
    byzlhp_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    byzlhp_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    byzlhp_setting.is_enabled_by_default = true; -- 是否默认启用
    byzlhp_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    byzlhp_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local zlzymb_setting = hps_category:create_setting("zlzymb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zlzymb_setting.display_name = L["治疗之雨目标"];
    zlzymb_setting.description = "治疗之雨目标"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zlzymb_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    zlzymb_setting.default_value = "人群"; -- 变量默认值
    zlzymb_setting.optional_values = {"MT1", "自己", "人群", "鼠标位置"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    zlzymb_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zlzymb_setting.is_enabled_by_default = true; -- 是否默认启用
    zlzymb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    zlzymb_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local qpdymb_setting = hps_category:create_setting("qpdymb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    qpdymb_setting.display_name = L["倾盆大雨目标"];
    qpdymb_setting.description = "倾盆大雨目标"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    qpdymb_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    qpdymb_setting.default_value = "人群"; -- 变量默认值
    qpdymb_setting.optional_values = {"MT1", "自己", "人群", "鼠标位置"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    qpdymb_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    qpdymb_setting.is_enabled_by_default = true; -- 是否默认启用
    qpdymb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    qpdymb_setting.value_width = 130; -- 值显示宽度像素（默认为100）

    local zll1_setting = hps_category:create_setting("zll1"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zll1_setting.display_name = L["治疗链基本蓝量"];
    zll1_setting.description = "低于此值不主动放治疗链"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zll1_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    zll1_setting.default_value = 85; -- 变量默认值
    zll1_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    zll1_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zll1_setting.is_enabled_by_default = true; -- 是否默认启用
    zll1_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    zll1_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local zll2_setting = hps_category:create_setting("zll2"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zll2_setting.display_name = L["治疗链最低蓝量"];
    zll2_setting.description = "低于此值不放治疗链"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zll2_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    zll2_setting.default_value = 30; -- 变量默认值
    zll2_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    zll2_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zll2_setting.is_enabled_by_default = true; -- 是否默认启用
    zll2_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    zll2_setting.value_width = 100; -- 值显示宽度像素（默认为100）


    local bytt_setting = hps_category:create_setting("bytt"); -- 指定变量的名字为test1，用于在脚本中进行引用
    bytt_setting.display_name = L["暴雨图腾"]; -- 变量在界面上显示的名字
    bytt_setting.description = "是否卡CD使用暴雨图腾"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    bytt_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    bytt_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    bytt_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    bytt_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    bytt_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    bytt_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    bytt_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    local xzhytt_setting = hps_category:create_setting("xzhytt"); -- 指定变量的名字为test1，用于在脚本中进行引用
    xzhytt_setting.display_name = L["先祖护佑图腾"]; -- 变量在界面上显示的名字
    xzhytt_setting.description = "是否卡CD使用先祖护佑图腾"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    xzhytt_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    xzhytt_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    xzhytt_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    xzhytt_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    xzhytt_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    xzhytt_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    xzhytt_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    local ddzqtt_setting = hps_category:create_setting("ddzqtt"); -- 指定变量的名字为test1，用于在脚本中进行引用
    ddzqtt_setting.display_name = L["大地之墙图腾"]; -- 变量在界面上显示的名字
    ddzqtt_setting.description = "是否卡CD使用大地之墙图腾"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ddzqtt_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    ddzqtt_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    ddzqtt_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    ddzqtt_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ddzqtt_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    ddzqtt_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    ddzqtt_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    local smsf_setting = hps_category:create_setting("smsf"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    smsf_setting.display_name = L["生命释放"];
    smsf_setting.description = "生命释放"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    smsf_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    smsf_setting.default_value = 85; -- 变量默认值
    smsf_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    smsf_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    smsf_setting.is_enabled_by_default = false; -- 是否默认启用
    smsf_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    smsf_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local jlyz_setting = hps_category:create_setting("jlyz"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    jlyz_setting.display_name = L["激流"];
    jlyz_setting.description = "激流"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    jlyz_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    jlyz_setting.default_value = 85; -- 变量默认值
    jlyz_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    jlyz_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    jlyz_setting.is_enabled_by_default = false; -- 是否默认启用
    jlyz_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    jlyz_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local zlzy_setting = hps_category:create_setting("zlzy"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    zlzy_setting.display_name = L["治疗之涌"];
    zlzy_setting.description = "治疗之涌"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zlzy_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    zlzy_setting.default_value = 40; -- 变量默认值
    zlzy_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    zlzy_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zlzy_setting.is_enabled_by_default = false; -- 是否默认启用
    zlzy_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    zlzy_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local shuchu_setting = hps_category:create_setting("shuchu"); -- 指定变量的名字为test1，用于在脚本中进行引用
    shuchu_setting.display_name = L["输出"]; -- 变量在界面上显示的名字
    shuchu_setting.description = "输出"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    shuchu_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    shuchu_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    shuchu_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    shuchu_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    shuchu_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    shuchu_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    shuchu_setting.value_width = 120; -- 值显示宽度像素（默认为100）













-----------------------------------------------------------

    -- -- 添加一个自定义类别test_category。
    local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    dps_category.display_name = L["|cff00FFFF输出设置"]; -- 类别在界面上显示的名字

    -- 在类别test_category下添加配置变量test5
    local targetsem_setting = dps_category:create_setting("targetsem"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    targetsem_setting.display_name = L["DPS目标选择"];
    targetsem_setting.description = "确定是否加入输出循环，以及目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    targetsem_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    targetsem_setting.default_value = "智能"; -- 变量默认值
    targetsem_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    targetsem_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    targetsem_setting.is_enabled_by_default = false; -- 是否默认启用
    targetsem_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    targetsem_setting.value_width = 130; -- 值显示宽度像素（默认为100）



 end


 -----------------------------------------------------------

-----------------------------------------------------------

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
    local speci = 264 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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
function rotation:prezkmp_action()
    -- 编写模块停止前脚本。
    print("zkmp now!");
end
function rotation:precombat_action() 


    -- local bf = tonumber(string.byte(string.upper(self.settings.Touch_of_Death.value))) --爆发     
    
    -- if isKeyDown(bf) and GetTime() - tt > 1 then
    --     baofa = not baofa
    --     tt = GetTime()
    --     if baofa then
    --         GH_Print("爆发开启")
    --         OverlayY("爆发开启")
    --     else
    --         GH_Print("爆发关闭")
    --         OverlayY("爆发关闭")
    --     end
    -- end

    if Nova == nil then
        Nova = getFriend(40,filterfunction2,true)
    end

    -- for i,v in ipairs(Nova) do
    --     print(i,v)
    -- end
    -- for i=1,#Nova do
    --     print(Nova[i])        
    -- end

end
-----------------------------------------------------------
--全局函数
local function sorttable(a,b)
    -- body
    return getHP(a) < getHP(b)
end
local function filterb(Unit)
    -- body
    if UnitIsUnit(Unit,"player") or UnitGroupRolesAssigned(Unit) == "TANK" then
        return true
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
local function filterfunction2(unit)
    return UnitExists(unit) and not UnitIsDeadOrGhost(unit) and UnitIsVisible(unit) and getLineOfSight("player",unit) and UnitCanAssist("player",unit) and (UnitInParty(unit) or UnitInRaid(unit))
end



if sorttime == nil then
    sorttime = 0
end

function rotation:tuanshua()
    local tgtype = self.settings.targets --治疗目标选择
    local tgtypeem = self.settings.targetsem --输出目标选择
    local zlsyz = self.settings.zlsyz --治疗石    
    local ydebug = self.settings.ydebug--调试信息
    local aoenum1 = self.settings.aoenum1--小队人数
    local aoehp1 = self.settings.aoehp1--小队血量    
    local aoenum2 = self.settings.aoenum2--团队人数
    local aoehp2 = self.settings.aoehp2--团队血量
    local byzlrs = self.settings.byzlrs--奔涌之流人数
    local byzlhp = self.settings.byzlhp--奔涌之流人数
    local zlzymb = self.settings.zlzymb--治疗之雨
    local qpdymb = self.settings.qpdymb--倾盆大雨
    local zll1 = self.settings.zll1--治疗链高蓝
    local zll2 = self.settings.zll2--治疗链低蓝
    local bytt = self.settings.bytt--暴雨图腾
    local xzhytt = self.settings.xzhytt--先祖护佑图腾
    local ddzqtt = self.settings.ddzqtt--释放大地之墙图腾198838（做开关，默认关）图腾
    local smsf = self.settings.smsf--生命释放
    local jlyz = self.settings.jlyz--激流
    local zlzy = self.settings.zlzy--治疗之涌
    local jxsl = self.settings.jxsl--极限省蓝
    local shuchu = self.settings.shuchu--输出
    local jxslbz = false
    if jxsl.is_enabled and getMana("player") <= jxsl.value then
        jxslbz = true
    end
    -- 释放奔涌之流197995（只计算前方20码，弧形区域）（做开关，默认开）
    if byzlrs.is_enabled and byzlhp.is_enabled then
        if canCast(197995) and getNumFriendInFront(20,45,byzlhp.value) >= byzlrs.value then
            if csi("player",197995) then
                if ydebug.is_enabled then
                    print(100)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    self:rest();
    -- 释放治疗之雨73920（设置选项，T，自己，人群，鼠标位置，默认人群)
    if canCast(73920) and zlzymb.is_enabled then
        if zlzymb.value == "MT1" then
            local mt1 = getLowestTank(30)
            if UnitExists(mt1) and castSpell(mt1,73920) then
                if ydebug.is_enabled then
                    print(101)
                    return 0
                else
                    return 0
                end
            end
        end
        if zlzymb.value == "自己" then
            if castSpell("player",73920) then
                if ydebug.is_enabled then
                    print(101)
                    return 0
                else
                    return 0
                end
            end
        end
        if zlzymb.value == "人群" then
            local tg1 = getBiggestFriendCluster(30,10)
            if UnitExists(tg1) and castSpell(tg1,73920) then
                if ydebug.is_enabled then
                    print(101)
                    return 0
                else
                    return 0
                end
            end
        end
        if zlzymb.value == "鼠标位置" then
            if castSpell("mouseover",73920) then
                if ydebug.is_enabled then
                    print(101)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    self:rest();
    -- 释放倾盆大雨207778（设置选项，T，自己，人群，鼠标位置，默认人群）
    if canCast(207778) and qpdymb.is_enabled then
        if qpdymb.value == "MT1" then
            local mt1 = getLowestTank(30)
            if UnitExists(mt1) and castSpell(mt1,207778) then
                if ydebug.is_enabled then
                    print(102)
                    return 0
                else
                    return 0
                end
            end
        end
        if qpdymb.value == "自己" then
            if castSpell("player",207778) then
                if ydebug.is_enabled then
                    print(102)
                    return 0
                else
                    return 0
                end
            end
        end
        if qpdymb.value == "人群" then
            local tg2 = getBiggestFriendCluster(30,10)
            if UnitExists(tg2) and castSpell(tg2,207778) then
                if ydebug.is_enabled then
                    print(102)
                    return 0
                else
                    return 0
                end
            end
        end
        if qpdymb.value == "鼠标位置" then
            if castSpell("mouseover",207778) then
                if ydebug.is_enabled then
                    print(102)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    self:rest();
    -- 当自己身上有潮汐奔涌53390BUFF，或者自己蓝高于多少时，则释放治疗链77472（设置阈值，默认85），但蓝在多少时以下则不释放（设置阈值，默认30）
    if canCast(77472) and getMana("player") >= zll2.value then
        if UnitBuffID("player",53390) and UnitExists(Nova[1]) and castSpell(Nova[1],77472) then
            if ydebug.is_enabled then
                print(103)
                return 0
            else
                return 0
            end
        end
    end
    self:rest();
    if canCast(77472) and getMana("player") >= zll1.value and getMana("player") >= zll2.value then
        if UnitExists(Nova[1]) and castSpell(Nova[1],77472) then
            if ydebug.is_enabled then
                print(103)
                return 0
            else
                return 0
            end
        end
    end
    self:rest();
    -- 释放暴雨图腾157153（做开关，默认开）
    if bytt.is_enabled and canCast(157153) and csi("player",157153) then
        if ydebug.is_enabled then
            print(104)
            return 0
        else
            return 0
        end
    end
    self:rest();
    -- 释放治疗之泉图腾5394
    if canCast(5394) and csi("player",5394) then
        if ydebug.is_enabled then
            print(105)
            return 0
        else
            return 0
        end
    end
    self:rest();
    -- 释放先祖护佑图腾207399（做开关，默认关）
    if xzhytt.is_enabled and canCast(207399) and csi("player",207399) then
        if ydebug.is_enabled then
            print(106)
            return 0
        else
            return 0
        end
    end
    self:rest();
    -- 释放大地之墙图腾198838（做开关，默认关）
    if ddzqtt.is_enabled and canCast(198838) and csi("player",198838) then
        if ydebug.is_enabled then
            print(106)
            return 0
        else
            return 0
        end
    end
    self:rest();


end

function rotation:danshua()

    GH_Print(Nova[1])

    local tgtype = self.settings.targets --治疗目标选择
    local tgtypeem = self.settings.targetsem --输出目标选择
    local zlsyz = self.settings.zlsyz --治疗石    
    local ydebug = self.settings.ydebug--调试信息
    local aoenum1 = self.settings.aoenum1--小队人数
    local aoehp1 = self.settings.aoehp1--小队血量    
    local aoenum2 = self.settings.aoenum2--团队人数
    local aoehp2 = self.settings.aoehp2--团队血量
    local byzlrs = self.settings.byzlrs--奔涌之流人数
    local byzlhp = self.settings.byzlhp--奔涌之流人数
    local zlzymb = self.settings.zlzymb--治疗之雨
    local qpdymb = self.settings.qpdymb--倾盆大雨
    local zll1 = self.settings.zll1--治疗链高蓝
    local zll2 = self.settings.zll2--治疗链低蓝
    local bytt = self.settings.bytt--暴雨图腾
    local xzhytt = self.settings.xzhytt--先祖护佑图腾
    local ddzqtt = self.settings.ddzqtt--释放大地之墙图腾198838（做开关，默认关）图腾
    local smsf = self.settings.smsf--生命释放
    local jlyz = self.settings.jlyz--激流
    local zlzy = self.settings.zlzy--治疗之涌
    local jxsl = self.settings.jxsl--极限省蓝
    local shuchu = self.settings.shuchu--输出
    local jxslbz = false
    if jxsl.is_enabled and getMana("player") <= jxsl.value then
        jxslbz = true
    end

    local ht = Nova[1]
    if not jxslbz then
        local ht = Nova[1]
    else
        local ht = Nova[1]
    end
    print(ht)
    self:rest();
    if UnitExists(ht) then
        -- 当队友的血低于多少时，则打算当前施法，除非是治疗之涌的读条，释放治疗之涌8004（设置阈值，默认40）
        if getHP(ht) <= zlzy.value and canCast(61295) and csi(ht,61295) then
            if ydebug.is_enabled then
                print(202)
                return 0
            else
                return 0
            end
        end
        self:rest();
        -- 当队友的血低于多少时，则释放生命释放73685（设置阈值，默认85）
        if getHP(ht) <= smsf.value and canCast(73685) and csi(ht,73685) then
            if ydebug.is_enabled then
                print(200)
                return 0
            else
                return 0
            end
        end
        self:rest();
        -- 当队友的血低于多少时，则释放激流61295（设置阈值，默认85）
        if getHP(ht) <= jlyz.value and canCast(61295) and csi(ht,61295) then
            if ydebug.is_enabled then
                print(201)
                return 0
            else
                return 0
            end
        end
        self:rest();
        
        -- 当自己身上有潮汐奔涌53390BUFF时，同时当队友的血低于多少时，则释放治疗波77472
        -- 或者当队友的血低于90时，则释放治疗波77472
        if getHP(ht) <= 90 and canCast(77472) and csi(ht,77472) then
            if ydebug.is_enabled then
                print(203)
                return 0
            else
                return 0
            end
        end
        self:rest();

    end
    self:rest();

    

end

function rotation:shuchu()

    local tgtype = self.settings.targets --治疗目标选择
    local tgtypeem = self.settings.targetsem --输出目标选择
    local zlsyz = self.settings.zlsyz --治疗石    
    local ydebug = self.settings.ydebug--调试信息
    local aoenum1 = self.settings.aoenum1--小队人数
    local aoehp1 = self.settings.aoehp1--小队血量    
    local aoenum2 = self.settings.aoenum2--团队人数
    local aoehp2 = self.settings.aoehp2--团队血量
    local byzlrs = self.settings.byzlrs--奔涌之流人数
    local byzlhp = self.settings.byzlhp--奔涌之流人数
    local zlzymb = self.settings.zlzymb--治疗之雨
    local qpdymb = self.settings.qpdymb--倾盆大雨
    local zll1 = self.settings.zll1--治疗链高蓝
    local zll2 = self.settings.zll2--治疗链低蓝
    local bytt = self.settings.bytt--暴雨图腾
    local xzhytt = self.settings.xzhytt--先祖护佑图腾
    local ddzqtt = self.settings.ddzqtt--释放大地之墙图腾198838（做开关，默认关）图腾
    local smsf = self.settings.smsf--生命释放
    local jlyz = self.settings.jlyz--激流
    local zlzy = self.settings.zlzy--治疗之涌
    local jxsl = self.settings.jxsl--极限省蓝
    local shuchu = self.settings.shuchu--输出
    local jxslbz = false
    if jxsl.is_enabled and getMana("player") <= jxsl.value then
        jxslbz = true
    end

    --获得第一个符合条件的目标
    if tgtypeem.value == "智能" then
        tg = getOneEnemy(35,filler_unit)
        
        --如果有当前目标，并且当前目标可以攻击，则对当前目标攻击
        if UnitExists("target") and isAlive("target") and UnitCanAttack("player","target") then
            tg = "target"
            -- print(tg)
        end
    end
    self:rest();
    -- print(tg)
    if tgtypeem.value ~= "智能" then
        tg = "target"
    end
    self:rest();
    -- if tg then
    --     TargetUnit(tg)
    -- end
    -- 当目标有烈焰震击DEBUFF时，则释放熔岩爆裂51505
    if UnitExists(tg) and UnitDebuffID(tg,188838) and canCast(51505) and castSpell(tg,51505) then
        if ydebug.is_enabled then
            print(300)
            return 0
        else
            return 0
        end
    end
    self:rest();
    -- 当目标没有烈焰震击DEBUFF时，则释放烈焰震击188838
    if UnitExists(tg) and not UnitDebuffID(tg,188838) and canCast(188838) and csi(tg,188838) then
        if ydebug.is_enabled then
            print(301)
            return 0
        else
            return 0
        end
    end
    self:rest();
    -- 释放闪电箭403
    if UnitExists(tg) and canCast(403) and castSpell(tg,403) then
        if ydebug.is_enabled then
            print(302)
            return 0
        else
            return 0
        end
    end
    self:rest();



end
function rotation:default_action()      

    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;

    if Nova == nil or GetTime() - sorttime > 1.5 then
        Nova = getFriend(40,filterfunction2,true)
        sorttime = GetTime()
    end

    local tgtype = self.settings.targets --治疗目标选择
    local tgtypeem = self.settings.targetsem --输出目标选择
    local zlsyz = self.settings.zlsyz --治疗石    
    local ydebug = self.settings.ydebug--调试信息
    local aoenum1 = self.settings.aoenum1--小队人数
    local aoehp1 = self.settings.aoehp1--小队血量    
    local aoenum2 = self.settings.aoenum2--团队人数
    local aoehp2 = self.settings.aoehp2--团队血量
    local byzlrs = self.settings.byzlrs--奔涌之流人数
    local byzlhp = self.settings.byzlhp--奔涌之流人数
    local zlzymb = self.settings.zlzymb--治疗之雨
    local qpdymb = self.settings.qpdymb--倾盆大雨
    local zll1 = self.settings.zll1--治疗链高蓝
    local zll2 = self.settings.zll2--治疗链低蓝
    local bytt = self.settings.bytt--暴雨图腾
    local xzhytt = self.settings.xzhytt--先祖护佑图腾
    local ddzqtt = self.settings.ddzqtt--释放大地之墙图腾198838（做开关，默认关）图腾
    local smsf = self.settings.smsf--生命释放
    local jlyz = self.settings.jlyz--激流
    local zlzy = self.settings.zlzy--治疗之涌
    local jxsl = self.settings.jxsl--极限省蓝
    local shuchu = self.settings.shuchu--输出
    local jxslbz = false
    if jxsl.is_enabled and getMana("player") <= jxsl.value then
        jxslbz = true
    end
    
    self:rest();    

    --团队类型
    local type = getGroupType()

    self:rest();
    
    -- print(Nova[1])  
    self:rest();
    -- 小队多少人血量低于多少时（设置阈值，默认3人，血量默认70）
    -- 团长多少人血量低于多少时（设置阈值，默认5人，血量默认80）
    if ( type == "party" and UnitExists(Nova[aoenum1.value]) and getHP(Nova[aoenum1.value]) <= aoehp1.value ) or ( type == "raid" and UnitExists(Nova[aoenum2.value]) and getHP(Nova[aoenum2.value]) <= aoehp1.value ) and not jxslbz then
        -- 团刷
        self:tuanshua()
        self:rest();       
    end
    -- print(501)
    self:danshua()
    self:rest();
    -- print(502)
    if tgtypeem.is_enabled then
        self:shuchu()
    end



end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);