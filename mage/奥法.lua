-- 注册全局事件

----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "e780beda-6966-4ae1-b61a-8e02e45f3fad";
-- 定义循环的英文名称。
local rotation_name = "aoao_fa";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name]                        = "法师-奥术";
    L["Welcome to use test module."]        = "欢迎使用法师-奥术模块！";
    L["isbus"]                              = "有坐骑不打怪";
    L["heshui"]                             = "喝水不打怪";
    L["shifafa"]                            = "没进战斗不自动施法";
    L["aoshuzhihuizidong"]                  = "自动奥术智慧";
    L["fashuxiquu"]                         = "自动法术吸取";
    L["nengliangfw"]                        = "自动能量符文";
    L["hbpz"]                               = "寒冰屏障";
    L["huanxinzid"]                         = "自动唤醒"; 
    L["qidingshengxian"]                    = "气定神闲"; 
    L["danmufazhi"]                         = "奥术弹幕阈值";   
    L["fenkxielan"]                         = "泄蓝单体"; 
    L["aoetg"]                              = "AOE模式";
    L["aoenum"]                             = "进入AOE循环人数";
    L["targets"]                            = "目标选择";
    L["fashuxiqu"]                          = "自动法术吸取";
    L["zhidongdaduan"]                      = "自动打断";
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
rotation.macro = "aoaofa";
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
    jc_category.display_name = L[" or cff00FFFF基础设置"]; -- 类别在界面上显示的名字

    --坐骑 -- 给默认类别添加一个配置变量test1，并配置相关属性。
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

    --喝水 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local heshui_setting = jc_category:create_setting("heshui"); -- 指定变量的名字为test1，用于在脚本中进行引用
    heshui_setting.display_name = L["喝水不打怪"]; -- 变量在界面上显示的名字
    heshui_setting.description = "喝水不打怪"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    heshui_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    heshui_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    heshui_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    heshui_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    heshui_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    heshui_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    heshui_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    --没进战斗不自动施法 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local shifafa_setting = jc_category:create_setting("shifafa"); -- 指定变量的名字为test1，用于在脚本中进行引用
    shifafa_setting.display_name = L["没进战斗不自动施法"]; -- 变量在界面上显示的名字
    shifafa_setting.description = "没进战斗不自动施法"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    shifafa_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    shifafa_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    shifafa_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    shifafa_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    shifafa_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    shifafa_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    shifafa_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    --自动奥术智慧 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local aoshuzhihuizidong_setting = jc_category:create_setting("aoshuzhihuizidong"); -- 指定变量的名字为test1，用于在脚本中进行引用
    aoshuzhihuizidong_setting.display_name = L["自动奥术智慧"]; -- 变量在界面上显示的名字
    aoshuzhihuizidong_setting.description = "自动奥术智慧"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoshuzhihuizidong_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    aoshuzhihuizidong_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    aoshuzhihuizidong_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    aoshuzhihuizidong_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    aoshuzhihuizidong_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    aoshuzhihuizidong_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    aoshuzhihuizidong_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    --自动法术吸取 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local fashuxiquu_setting = jc_category:create_setting("fashuxiquu"); -- 指定变量的名字为test1，用于在脚本中进行引用
    fashuxiquu_setting.display_name = L["自动法术吸取"]; -- 变量在界面上显示的名字
    fashuxiquu_setting.description = "自动法术吸取"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    fashuxiquu_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    fashuxiquu_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    fashuxiquu_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    fashuxiquu_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    fashuxiquu_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    fashuxiquu_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    fashuxiquu_setting.value_width = 120; -- 值显示宽度像素（默认为100）

    --自动能量符文 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local nengliangfw_setting = jc_category:create_setting("nengliangfw"); -- 指定变量的名字为test1，用于在脚本中进行引用
    nengliangfw_setting.display_name = L["自动能量符文"]; -- 变量在界面上显示的名字
    nengliangfw_setting.description = "自动能量符文"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    nengliangfw_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    nengliangfw_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    nengliangfw_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    nengliangfw_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    nengliangfw_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    nengliangfw_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    nengliangfw_setting.value_width = 120; -- 值显示宽度像素（默认为100）fenkxielan

    --自动打断 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local zhidongdaduan_setting = jc_category:create_setting("zhidongdaduan"); -- 指定变量的名字为test1，用于在脚本中进行引用
    zhidongdaduan_setting.display_name = L["自动打断"]; -- 变量在界面上显示的名字
    zhidongdaduan_setting.description = "自动打断"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    zhidongdaduan_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    zhidongdaduan_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    zhidongdaduan_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    zhidongdaduan_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    zhidongdaduan_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    zhidongdaduan_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    zhidongdaduan_setting.value_width = 120; -- 值显示宽度像素（默认为100）fenkxielan
    
    --泄蓝单体 -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local fenkxielan_setting = jc_category:create_setting("fenkxielan"); -- 指定变量的名字为test1，用于在脚本中进行引用
    fenkxielan_setting.display_name = L["泄蓝单体"]; -- 变量在界面上显示的名字
    fenkxielan_setting.description = "泄蓝单体"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    fenkxielan_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    fenkxielan_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    fenkxielan_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    fenkxielan_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    fenkxielan_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    fenkxielan_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    fenkxielan_setting.value_width = 120; -- 值显示宽度像素（默认为100）fenkxielan

-----------------------------------------------------------


    -- -- 添加一个自定义类别test_category。
    local hps_category = rotation:create_setting_category("hps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    hps_category.display_name = L[" or cff00FFFF治疗设置"]; -- 类别在界面上显示的名字

----治疗石
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

-----寒冰屏障
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

------时光护盾
    local hbht_setting = hps_category:create_setting("hbht"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    hbht_setting.display_name = L["时光护盾"];
    hbht_setting.description = "时光护盾"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

----棱光屏障235450
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
----回蓝
    local huanxinzid_setting = hps_category:create_setting("huanxinzid"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    huanxinzid_setting.display_name = L["自动唤醒"];
    huanxinzid_setting.description = "自动唤醒"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    huanxinzid_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    huanxinzid_setting.default_value = 15; -- 变量默认值
    huanxinzid_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    huanxinzid_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    huanxinzid_setting.is_enabled_by_default = true; -- 是否默认启用
    huanxinzid_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 or value <= 100) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    huanxinzid_setting.value_width = 100; -- 值显示宽度像素（默认为100）
----奥术弹幕阈值
    local danmufazhi_setting = hps_category:create_setting("danmufazhi"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    danmufazhi_setting.display_name = L["奥术弹幕阈值"];
    danmufazhi_setting.description = "奥术弹幕阈值"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    danmufazhi_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    danmufazhi_setting.default_value = 4; -- 变量默认值
    danmufazhi_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    danmufazhi_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    danmufazhi_setting.is_enabled_by_default = true; -- 是否默认启用
    danmufazhi_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 0 and value <= 4) then
            return true;
        else
            return false, "The number is not right.";
        end
    end;
    danmufazhi_setting.value_width = 100; -- 值显示宽度像素（默认为100）

-----------------------------------------------------------


    -- -- 添加一个自定义类别test_category。
    local dps_category = rotation:create_setting_category("dps_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    dps_category.display_name = L[" or cff00FFFF输出设置"]; -- 类别在界面上显示的名字
-----气定神闲
    local qidingshengxian_setting = dps_category:create_setting("qidingshengxian"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    qidingshengxian_setting.display_name = L["qidingshengxian"];
    qidingshengxian_setting.description = "气定神闲"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    qidingshengxian_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    qidingshengxian_setting.default_value = "智能"; -- 变量默认值
    qidingshengxian_setting.optional_values = {"智能", "常规", "手动"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    qidingshengxian_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    qidingshengxian_setting.is_enabled_by_default = false; -- 是否默认启用
    qidingshengxian_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    qidingshengxian_setting.value_width = 130; -- 值显示宽度像素（默认为100）
----AOE模式
    local aoetg_setting = dps_category:create_setting("aoetg"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    aoetg_setting.display_name = L["aoetg"];
    aoetg_setting.description = "aoe模式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    aoetg_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    aoetg_setting.default_value = "智能"; -- 变量默认值
    aoetg_setting.optional_values = {"智能", "手动", "强制"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    aoetg_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    aoetg_setting.is_enabled_by_default = false; -- 是否默认启用
    aoetg_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    aoetg_setting.value_width = 130; -- 值显示宽度像素（默认为100）


    local aoenum_setting = dps_category:create_setting("aoenum"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
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

    local Touch_of_Death_setting = dps_category:create_setting("Touch_of_Death"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    Touch_of_Death_setting.display_name = L["爆发快捷键"];
    Touch_of_Death_setting.description = "按下这个键切换爆发状态！因为暴雪本身的bug，只支持1-0，A-Z"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    Touch_of_Death_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    Touch_of_Death_setting.default_value = "e"; -- 变量默认值
    Touch_of_Death_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    Touch_of_Death_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    Touch_of_Death_setting.is_enabled_by_default = true; -- 是否默认启用
    -- Touch_of_Death_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    --     if (#value == 1 ) then
    --         return true;
    --     else
    --         return false, "没有这个按键";
    --     end
    -- end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
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
-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    if (not argument or argument == "") then
        -- print("使用宏/zkm aoaofa baofa控制爆发");
    else
        print("收到宏命令参数：", argument);
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
    print("start now not ");
end
function rotation:prepause_action()
    -- 编写模块暂停前脚本。
    print("pause now not ");
end
function rotation:prestop_action()
    -- 编写模块停止前脚本。
    print("stop now not ");
end
function rotation:precombat_action()

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




function rotation:default_action()
    
    -- 不打断施法
  --  if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(12051) > 0.1 or getSpellCD(5143) > 0.1 then return; end;

    --获得变量
    local qidingshengxian          = self.settings.qidingshengxian --气定神闲
    local aoe_blizzard             = self.settings.aoetg --aoe模式
    local aoe_num                  = self.settings.aoenum --aoe人数
    local tgtype                   = self.settings.targets --目标选择
    local isbus                    = self.settings.isbus --坐骑
    local heshui                   = self.settings.heshui --喝水
    local shifafa                  = self.settings.shifafa --没进战斗不自动施法
    local aoshuzhihuizidong        = self.settings.aoshuzhihuizidong --自动奥术智慧
    local fashuxiquu               = self.settings.fashuxiquu --自动法术吸取  
    local nengliangfw              = self.settings.nengliangfw --自动能量符文
    local zhidongdaduan            = self.settings.zhidongdaduan --自动打断
    local fenkxielan               = self.settings.fenkxielan --泄蓝单体
    local zlsyz                    = self.settings.zlsyz --治疗石
    local hbpz                     = self.settings.hbpz --寒冰屏障
    local hbht                     = self.settings.hbht --时光护盾
    local lgpz                     = self.settings.lgpz --棱光屏障
    local huanxinzid               = self.settings.huanxinzid --自动唤醒
    local danmufazhi               = self.settings.danmufazhi --奥术弹幕阈值
    local Touch_of_Death           = self.settings.Touch_of_Death.value --爆發


    ---坐骑
    if isbus.is_enabled  and isBused("player") then return; end 
    ---喝水  
    if heshui.is_enabled and not isInCombat("player") and UnitBuffID("player",167152) then return; end
    ---没进战斗 不自动攻击
    if shifafa.is_enabled and not isInCombat("player")  then return; end



    -- 本地化
   --- local lastSpellCast = Y.lastspell_cast
    -- GH_Print(lastSpellCast)

    
    
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
    local active_enemies = getNumEnemies(zj,10)    
    
    
    
    local aoshuzhihui = 1459 --奥术智慧
    local aoshumocong = 210126 --奥术魔宠
    

    
    local charges_fractional = getChargesFrac
    local castSpell = csi


    --奥术智慧
    if not UnitBuffID("player",aoshuzhihui) and aoshuzhihuizidong.is_enabled and isAlive("player") then  castSpell(zj,1459)    end
    --法术吸取 
    if fashuxiquu.is_enabled and canPD(tg) then   castSpell(tg,30449)  end
    ----奥术魔宠
    if not UnitBuffID("player",aoshumocong) and isAlive("player") then  castSpell(zj,205022)    end
    --能量符文
    if canCast(116011) and nengliangfw.is_enabled and isInCombat("player") then  castSpell(zj,116011)    end

----保命
    -- 石头
    if getHP(zj) <= zlsyz.value and canUse(5512) then
        useItem(5512)
    end

    -- 当自己的血低于多少时，则释放寒冰屏障45438（做阈值，默认20）
    if hbpz.is_enabled and getHP(zj) <= hbpz.value and canCast(45438) then
        if castSpell(zj,45438) then
        end
    end

    --当自己的血低于多少时，则释放时光护盾198111（做阈值，默认70）
    if hbht.is_enabled and getHP(zj) <= hbht.value and canCast(198111) then
        if castSpell(zj,198111) then
        end
    end

    -- 当自己的血低于多少时，则释放棱光屏障235450（做阈值，默认30）
    if lgpz.is_enabled and getHP(zj) <= lgpz.value and canCast(235450) then
        if castSpell(zj,235450) then
        end
    end
---打断法术反制
   ---if canCast(2013) then castInterrupt(2013,1,tg) end 
   if UnitExists("target") and amac("target", 1, 1)  and canCast(2013) and  zhidongdaduan.is_enabled
     then  castSpell(tg, 2013)   end

---自动唤醒
   if getMana("player")<= huanxinzid.value and getRealCD(147362) == 0 then castSpell(zj,12051) end 
---爆发
        -----释放气定神闲205025
        if canCast(205025) then
            if qidingshengxian.value == "智能" and UnitBuffID("player",12042) then
                castSpell(zj,205025)
            elseif qidingshengxian.value == "常规" then
                castSpell(zj,205025)
            elseif qidingshengxian.value == "手动" then
            end
        end
       
    
    local function aoe( ... )

        if canCast(1449) and amac("player",0.1) ~= "奥术飞弹" and amac("player",0.1) ~= "唤醒" then
            if aoe_blizzard.value == "智能" then
             if not UnitDebuffID(tg,114923) and  canCast(114923) then        castSpell(tg,114923)             end
            if   canCast(153626) then              castSpell(tg,153626)             end
            if getArcanePower()==danmufazhi.value and not getTalent(6,3)  and canCast(44425)  then   castSpell(tg,44425)            end
            if   canCast(157980) then              castSpell(tg,157980)             end
            if   canCast(1449) then              castSpell(tg,1449)             end
            elseif aoe_blizzard.value == "手动" then
  
            elseif aoe_blizzard.value == "强制" then
             if not UnitDebuffID(tg,114923) and  canCast(114923) then        castSpell(tg,114923)             end
            if   canCast(153626) then              castSpell(tg,153626)             end
            if getArcanePower()==danmufazhi.value and not getTalent(6,3)  and canCast(44425)  then   castSpell(tg,44425)            end
            if   canCast(157980) then              castSpell(tg,157980)             end
            if   canCast(1449) then              castSpell(tg,1449)             end
            end
        end


       
    end
    
    
    local function cooldowns( ... )
        -- body
        -- 释放镜像55342（做开关）
        if  canCast(55342) and castSpell(zj,55342) then

        end
        -- 当自己的能量等于0时，释放精力充沛（做开关）
        if canCast(205032) and  getArcanePower()<1 then castSpell(zj,205032)
 
        end
        -- 释放奥术强化12042（做开关）
        if  canCast(12042)  then castSpell(zj,12042)
 
        end

        if canUse(13) and useItem(13) then

        end
        if canUse(14) and useItem(14) then

        end

        
    end
    
    
    
    local function movement( ... )
        -- body
        -- actions.movement=blink, if movement.distance>10
        -- actions.movement+=/ice_floes, if  getBuffRemain("player", ) ice_floes.down
        if UnitBuffID("player",263725) and getTalent(2,3) then
            if canCast(5143) and castSpell(tg,5143) then

            end
        end
        if canCast(44425) and castSpell(tg,44425) then
        end
    
    end
    
    
    
    local function single( ... )

        ----奥术宝珠
        if  getArcanePower()<=4 and amac("player",0.1) ~= "奥术飞弹" and amac("player",0.1) ~= "唤醒" and canCast(153626)  then
            castSpell(tg,153626)
        end
        ---奥术飞弹
        if UnitBuffID("player",263725) and amac("player",0.1) ~= "唤醒"  then
            if canCast(5143) and castSpell(tg,5143) then

            end
        end 
        if fenkxielan.is_enabled and getMana("player")> huanxinzid.value and canCast(30451)  and amac("player",0.1) ~= "奥术飞弹" and amac("player",0.1) ~= "唤醒" then
            castSpell(tg,30451)
            end
        ---当自己的能量为多少时，则释放奥术弹幕44425（设置阈值，默认4）
        if getArcanePower()==danmufazhi.value and canCast(44425) and amac("player",0.1) ~= "奥术飞弹" and amac("player",0.1) ~= "唤醒" then
            castSpell(tg,44425) 
            end
        if canCast(30451)  and amac("player",0.1) ~= "奥术飞弹" and amac("player",0.1) ~= "唤醒" then
            castSpell(tg,30451)
            end
        -- actions.single+=/call_action_list,name=movement
        --這裏判斷也有問題
        if isMoving("player") and movement() then
    
        end
    end
     --   if true then 
       -- cooldowns() 
        -- return true
    ---end
    if isKeyDown(Touch_of_Death) and cooldowns() then
        
    end
    -- actions+=/call_action_list,name=aoe, if active_enemies>3 and talent.freezing_rain.enabled or active_enemies>4
    if active_enemies >= aoe_num.value then
        
     aoe() 

    end
    
    -- actions+=/call_action_list,name=single
    single()
    -- GH_Print(1)
    self:rest();


    ---------------------------------------------------------------------------------------------
    if variable == nil then
        variable = {}
    end

    burn_phase = getSpellCD(charged_up) == 0 and getArcanePower() >= 4 and ((getTalent(3,3) and getCharges(116011) >= 1) or not getTalent(3,3)) and (getMana("player") >= 50 or (getTalent(7,1) and getMana("player") >= 30))

    charged_up = 205032 --精力充沛
    arcane_power = 12042 --奥数强化
    evocation = 12051 --唤醒
    mirror_image = 55342 --镜像
    presence_of_mind = 205025 --气定神闲
    nether_tempest = 114923 --虚空风暴
    rune_of_power = 116011 --法阵
    rune_of_power_buff = 116014

    tier20_2pc = false

    -- actions.precombat+=/variable,name=conserve_mana,op=set,value=60
    variable.conserve_mana = 60
    -- actions=counterspell, if target.de getBuffRemain("player", ) casting.react
    -- actions+=/time_warp, if time=0 and  getBuffRemain("player", ) bloodlust.down

    -- actions+=/call_action_list,name=burn, 
    if burn_phase or getTimeToDie(tg) < variable.average_burn_length or ( getSpellCD(arcane_power) <= 0 and  getSpellCD(evocation) <= variable.average_burn_length and ( getBuffStacks("player", arcane_charge) == 4 or ( getTalent(4,2) and getSpellCD(charged_up) == 0))) then
        self:burn()
    end
    -- actions+=/call_action_list,name=conserve, 
    if  not burn_phase then
        self:conserve()
    end
    -- actions+=/call_action_list,name=movement
    self:movement()

    function rotation:burn( ... )
        -- body
        -- actions.burn=variable,name=total_burns,op=add,value=1,
        if not total_burns then
            variable.total_burns = 1
        else
            variable.total_burns = 0
        end
        -- actions.burn+=/start_burn_phase, 
        if  not burn_phase then
            variable.start_burn_phase = 1
        else
            variable.start_burn_phase = 0
        end
        -- # End the burn phase when we just evocated.
        -- actions.burn+=/stop_burn_phase, 
        if burn_phase and  getLastSpell() ==  evocation and  getTimeToDie(tg) > variable.average_burn_length and burn_phase_duration > 0 then
            stop_burn_phase = true
        else
            stop_burn_phase = false
        end
        -- actions.burn+=/mirror_image
        if getTalent(3,2) and canCast(mirror_image) and castSpell("player",mirror_image) then
            if ydebug.is_enabled then
                print(201)
                return 0
            else
                return 0
            end
        end
        -- actions.burn+=/charged_up, 
        if getArcanePower() <= 1 and ( not tier20_2pc or getSpellCD(presence_of_mind) > 5) then
            if getTalent(4,2) and canCast(charged_up) and castSpell("player",charged_up) then
                if ydebug.is_enabled then
                    print(202)
                    return 0
                else
                    return 0
                end
            end
        end
        -- actions.burn+=/nether_tempest, 
        if ( getDebuffRemain(tg,nether_tempest) <= 3 or  not UnitDebuffID(tg,nether_tempest)) and   getArcanePower()  == 4 and  getBuffRemain("player", rune_of_power_buff) <= 0 and  getBuffRemain("player", arcane_power) <= 0 then
            if canCast(nether_tempest) and castSpell(tg,nether_tempest) then
                if ydebug.is_enabled then
                    print(203)
                    return 0
                else
                    return 0
                end
            end
        end
        -- actions.burn+=/lights_judgment, if  getBuffRemain("player", ) arcane_power.down
        -- actions.burn+=/rune_of_power, 
        if  not  UnitBuffID("player", arcane_power)  and ( getMana("player") >= 50 or  getSpellCD(arcane_power) ==0) and (  getArcanePower()  == 4)
        -- actions.burn+=/arcane_power
        -- actions.burn+=/use_items, if  getBuffRemain("player", ) arcane_power.up or  getTimeToDie(tg) < getSpellCD() arcane_power.remains
        -- actions.burn+=/blood_fury
        -- actions.burn+=/berserking
        -- actions.burn+=/fireblood
        -- actions.burn+=/ancestral_call
        -- actions.burn+=/presence_of_mind, if  getBuffRemain("player", ) rune_of_power.remains<= getBuffRemain("player", ) presence_of_mind.max_stack*action.arcane_blast.execute_time or  getBuffRemain("player", ) arcane_power.remains<= getBuffRemain("player", ) presence_of_mind.max_stack*action.arcane_blast.execute_time
        -- actions.burn+=/potion, if  getBuffRemain("player", ) arcane_power.up and ( getBuffRemain("player", ) berserking.up or  getBuffRemain("player", ) blood_fury.up or  not (race.troll or race.orc))
        -- actions.burn+=/arcane_orb, if   getArcanePower()  =0 or (active_enemies<3 or (active_enemies<2 and talent.resonance.enabled))
        -- actions.burn+=/arcane_barrage, if (active_enemies>=3 or (active_enemies>=2 and talent.resonance.enabled)) and (  getArcanePower()  = getBuffRemain("player", ) arcane_charge.max_stack)
        -- actions.burn+=/arcane_explosion, if active_enemies>=3 or (active_enemies>=2 and talent.resonance.enabled)
        -- # Ignore Arcane Missiles during Arcane Power, aside from some very specific exceptions, like not having Overpowered talented  and  running 3x Arcane Pummeling.
        -- actions.burn+=/arcane_missiles, if  getBuffRemain("player", ) clearcasting.react and active_enemies<3 and (talent.amplification.enabled or ( not talent.overpowered.enabled and azerite.arcane_pummeling.rank>=2) or  getBuffRemain("player", ) arcane_power.down),chain=1
        -- actions.burn+=/arcane_blast
        -- # Now that we're done burning, we can update the average_burn_length with the length of this burn.
        -- actions.burn+=/variable,name=average_burn_length,op=set,value=(variable.average_burn_length*variable.total_burns-variable.average_burn_length+(burn_phase_duration))%variable.total_burns
        -- actions.burn+=/evocation,interrupt_ if  getMana("player") >=85,interrupt_immediate=1
        -- # For the rare occasion where we go oom before evocation is back up. (Usually because we get very bad rng so the burn is cut very short)
        -- actions.burn+=/arcane_barrage
    end
    

    -- actions.conserve=mirror_image
    -- actions.conserve+=/charged_up, if   getArcanePower()  =0
    -- actions.conserve+=/presence_of_mind, if set_bonus.tier20_2pc and   getArcanePower()  =0
    -- actions.conserve+=/nether_tempest, if (refreshable or  not ticking) and   getArcanePower()  = getBuffRemain("player", ) arcane_charge.max_stack and  getBuffRemain("player", ) rune_of_power.down and  getBuffRemain("player", ) arcane_power.down
    -- actions.conserve+=/arcane_orb, if   getArcanePower()  <=2 and ( getSpellCD() arcane_power.remains>10 or active_enemies<=2)
    -- # Arcane Blast shifts up in priority when running rule of threes.
    -- actions.conserve+=/arcane_blast, if  getBuffRemain("player", ) rule_of_threes.up and   getArcanePower()  >3
    -- actions.conserve+=/rune_of_power, if   getArcanePower()  = getBuffRemain("player", ) arcane_charge.max_stack and (full_recharge_time<=execute_time or recharge_time<= getSpellCD() arcane_power.remains or  getTimeToDie(tg) <= getSpellCD() arcane_power.remains)
    -- actions.conserve+=/arcane_missiles, if  getMana("player") <=95 and  getBuffRemain("player", ) clearcasting.react,chain=1
    -- # During conserve, we still just want to continue not dropping charges as long as possible.So keep 'burning' as long as possible (aka conserve_mana threshhold) and then swap to a 4x AB->Abarr conserve rotation. This is mana neutral for RoT, mana negative with arcane familiar. If we do not have 4 AC, we can dip slightly lower to get a 4th AC.
    -- actions.conserve+=/arcane_barrage, if ((  getArcanePower()  = getBuffRemain("player", ) arcane_charge.max_stack) and  getMana("player") <=variable.conserve_mana or (talent.arcane_orb.enabled and  getSpellCD() arcane_orb.remains<=gcd and  getSpellCD() arcane_power.remains>10)) or  getMana("player") <=(variable.conserve_mana-10)
    -- # Supernova is barely worth casting, which is why it is so far down, only just above AB. 
    -- actions.conserve+=/supernova, if  getMana("player") <=95
    -- # Keep 'burning' in aoe situations until conserve_mana pct. After that only cast AE with 3 Arcane charges, since it's almost equal mana cost to a 3 stack AB anyway. At that point AoE rotation will be AB x3 -> AE -> Abarr
    -- actions.conserve+=/arcane_explosion, if active_enemies>=3 and ( getMana("player") >=variable.conserve_mana or   getArcanePower()  =3)
    -- actions.conserve+=/arcane_blast
    -- actions.conserve+=/arcane_barrage

    -- actions.movement=shimmer, if movement.distance>=10
    -- actions.movement+=/blink, if movement.distance>=10
    -- actions.movement+=/presence_of_mind
    -- actions.movement+=/arcane_missiles
    -- actions.movement+=/arcane_orb
    -- actions.movement+=/supernova





end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);