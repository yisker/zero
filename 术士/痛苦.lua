----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "e2742fbe-ab84-45ee-b4c0-0411be12fd4e";
-- 定义循环的英文名称。
local rotation_name = "demon_warlock";
Scorpio("zeus." .. rotation_name)("");
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then 
    -- 简体中文系列。
    L[rotation_name] = "术士-恶魔";
    L["Welcome to use warlock_Destruction module."] = "欢迎使用恶魔术士模块！";
    L["ydebug"] = "调试信息xxx";
    L["mzmsname"] = "自动AOE";
    L["zdxmbname"] = "自动选目标";
    L["zdfocusname"] = "自动设焦点";   
    L["zdfwname"] = "自动光铸符文";
    L["ZDlhsname"] = "自动给自己绑石头";  
    L["zdqxxpname"] = "自动取消爆燃冲刺"; 
    L["zdkqxpname"] = "自动开启爆燃冲刺"; 
    L["zdxpfzname"] = "爆燃冲刺阈值";  
    L["ZDzhaobbname"] = "自动招宝宝";
    L["BBname"] = "选择宝宝类型";
    L["BFname"] = "选择爆发模式";     
    L["zlsname"]    = "治疗石阈值"; 
    L["bumiename"]  = "不灭决心阈值";      
    L["qiyuename"] = "黑暗契约阈值";
    L["autopause"] = "绿圈技能暂停";
    L["pvp Category"] = "|cff00ffffPVP设置";
    L["xjre"] = "补献祭最大剩余时间";
    L["aoenum"] = "AOE目标数量";
    L["Insert Category"] = "|cff00ffff插入技能";
    L["lifedrain"] = "吸取生命"
    L["inferstun"] = "地狱火";
    L["shadowfury"] = "暗影之怒";
    L["aoename"]  = "|cffdbdbdb一键爆发宏：/"..ADDON_SLASH_COMMAND.." em baofa";
    L["aoe1name"] = "|cffdbdbdb按住左Shift鼠标指向战复";
    L["aoe2name"] = "|cffdbdbdb按住左CTRL鼠标指向放逐";
    L["aoe3name"] = "|cffdbdbdb有恶魔流星特质推荐天赋11XXX1X";
 end
L = _Locale("zhTW");
if L then
    -- 繁体中文系列。
    L[rotation_name] = "惡魔術士";
    L["Welcome to use test module."] = "歡迎使用惡魔術士模組！";
    L["At least 2 values must be entered."] = "至少要輸入2個值";
    L["Test Category"] = "设置选项";
    L["autopause"] = "手動AOE自動暫停";
    L["aoenum"] = "AOE目標數量";
    L["shadowfury"] = "暗影之怒";
    L["Insert Category"] = "插入技能";
    L["lifedrain"] = "吸取生命"
end
L = _Locale;
local rotation = zeus.rotation(rotation_id, L[rotation_name]);
-- 定义循环加载并可用时的消息，填入"N/A"则不显示。
rotation.condition_yes_message = L["Welcome to use test module."];
-- 定义循环加载并不可用时的消息，填入"N/A"则不显示。
rotation.condition_no_message = "N/A";
-- 定义循环的执行间隔（秒），如果不设默认是0.1。
rotation.interval = 0.05;
-- 定义模块专用宏命令，下面的例子会定义出：/zeus test [argument]。如果不需要宏控制，则删除下面一行。
rotation.macro = "em";

-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
local advice_category = rotation:create_setting_category("advice_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
advice_category.display_name = "|cffdbdbdb全天赋支持！" -- 类别在界面上显示的名字
--advice_category.display_name = "|cffdbdbdb建议天赋： 11x2x21" -- 类别在界面上显示的名字

-- -- 添加一个自定义类别test_category。
local jc_category = rotation:create_setting_category("jc_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
jc_category.display_name = L["|cff00ffff基础设置"]; -- 类别在界面上显示的名字

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
    ydebug_setting.value_width = 100; -- 值显示宽度像素（默认为100）
    local ydebug2_setting = jc_category:create_setting("ydebug2"); -- 指定变量的名字为test1，用于在脚本中进行引用
    ydebug2_setting.display_name = L["调试模式2"]; -- 变量在界面上显示的名字
    ydebug2_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ydebug2_setting.value_type = rotation_setting_type.plain; -- 变量值类型（number数组类型）
    ydebug2_setting.default_value = nil; -- 变量默认值（删除此行不设，则为{}）
    ydebug2_setting.optional_values = nil; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    ydebug2_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ydebug2_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
    ydebug2_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    ydebug2_setting.value_width = 100; -- 值显示宽度像素（默认为100）

-- -- 在类别test_category下添加配置变量test3
local autopause_setting = jc_category:create_setting("autopause"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
autopause_setting.display_name = L["autopause"];
autopause_setting.description = "自动等待插入的绿圈技能，如果存在悬浮的aoe绿圈，\n脚本会自动暂停，等aoe技能释放完成或者取消施法继续运行。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
autopause_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
autopause_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
autopause_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
autopause_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
autopause_setting.is_enabled_by_default = true; -- 是否默认启用
autopause_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
autopause_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）


-- 自动选目标
local zdxmb_setting = jc_category:create_setting("zdxmb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdxmb_setting.display_name = L["zdxmbname"];
zdxmb_setting.description = "是否启用自动选目标，启动后优先打易爆球。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdxmb_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdxmb_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
zdxmb_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
zdxmb_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdxmb_setting.is_enabled_by_default = false; -- 是否默认启用
zdxmb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
zdxmb_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

--[[ -- 自动设焦点
local zdfocus_setting = rotation.default_setting_category:create_setting("zdfocus"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdfocus_setting.display_name = L["zdfocusname"];
zdfocus_setting.description = "是否启用自动设焦点。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdfocus_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdfocus_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
zdfocus_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
zdfocus_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdfocus_setting.is_enabled_by_default = false; -- 是否默认启用
zdfocus_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
zdfocus_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧） ]]

--[[自动开启爆燃冲刺
local zdkqxp_setting = jc_category:create_setting("zdkqxp"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdkqxp_setting.display_name = L["zdkqxpname"];
zdkqxp_setting.description = "自动开启爆燃冲刺。自动开启的血量阀值在下面设置"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdkqxp_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdkqxp_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
zdkqxp_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
zdkqxp_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdkqxp_setting.is_enabled_by_default = false; -- 是否默认启用
zdkqxp_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
zdkqxp_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

--开启爆燃冲刺阀值
local zdxpfz_setting = jc_category:create_setting("zdxpfz"); 
zdxpfz_setting.display_name = L["zdxpfzname"];
zdxpfz_setting.description = "自动开启爆燃冲刺血量限定";
zdxpfz_setting.value_type = rotation_setting_type.number; 
zdxpfz_setting.default_value = 3; 
zdxpfz_setting.optional_values = nil; 
zdxpfz_setting.can_enable_disable = false; 
zdxpfz_setting.is_enabled_by_default = false; 
zdxpfz_setting.validator = function(self, value) 
   if (value >= 0 and value <=100) then
      return true;
   else
      return false, "The number is too small.";
   end
end;
zdxpfz_setting.value_width = 80;]]

-- 自动招宝宝
local ZDzhaobb_setting = jc_category:create_setting("ZDzhaobb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
ZDzhaobb_setting.display_name = L["ZDzhaobbname"];
ZDzhaobb_setting.description = "自动招宝宝"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
ZDzhaobb_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
ZDzhaobb_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
ZDzhaobb_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
ZDzhaobb_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
ZDzhaobb_setting.is_enabled_by_default = false; -- 是否默认启用
ZDzhaobb_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
ZDzhaobb_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

--选择宝宝类型
local BB_setting = jc_category:create_setting("BB"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
BB_setting.display_name = L["BBname"];
BB_setting.description = "选择宝宝类型"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
BB_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
BB_setting.default_value = "恶魔卫士"; -- 变量默认值
BB_setting.optional_values = {"恶魔卫士","小鬼","虚空行者","地狱猎犬","魅魔"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
BB_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
BB_setting.is_enabled_by_default = false; -- 是否默认启用
BB_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
BB_setting.value_width = 80; -- 值显示宽度像素（默认为100）

-- -- 添加一个自定义类别test_category。
local bm_category = rotation:create_setting_category("bm_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
bm_category.display_name = L["|cff00ffff保命设置"]; -- 类别在界面上显示的名字

-- 自动给自己绑灵魂石
local ZDlhs_setting = bm_category:create_setting("ZDlhs"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
ZDlhs_setting.display_name = L["ZDlhsname"];
ZDlhs_setting.description = "自动给自己绑灵魂石。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
ZDlhs_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
ZDlhs_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
ZDlhs_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
ZDlhs_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
ZDlhs_setting.is_enabled_by_default = false; -- 是否默认启用
ZDlhs_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
ZDlhs_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

--治疗石zls
local zls_setting = bm_category:create_setting("zls"); 
zls_setting.display_name = L["zlsname"];
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
zls_setting.value_width = 80;

--不灭决心阀值
local bumie_setting = bm_category:create_setting("bumie"); 
bumie_setting.display_name = L["bumiename"];
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
local qiyue_setting = bm_category:create_setting("qiyue"); 
qiyue_setting.display_name = L["qiyuename"];
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
dps_category.display_name = L["|cff00ffff输出设置"]; -- 类别在界面上显示的名字

--选择爆发类型
local BF_setting = dps_category:create_setting("BF"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
BF_setting.display_name = L["BFname"];
BF_setting.description = "选择爆发模式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
BF_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
BF_setting.default_value = "只对BOSS"; -- 变量默认值
BF_setting.optional_values = {"只对BOSS","自动无脑","手动"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
BF_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
BF_setting.is_enabled_by_default = false; -- 是否默认启用
BF_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
BF_setting.value_width = 80; -- 值显示宽度像素（默认为100）

--aoe数目
local aoenum_setting = dps_category:create_setting("aoenum"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
aoenum_setting.display_name = L["aoenum"];
aoenum_setting.description = "这是最小的aoe数量，多于这个数量的目标才AOE"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
aoenum_setting.default_value = 2; -- 变量默认值
aoenum_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
aoenum_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
aoenum_setting.is_enabled_by_default = true; -- 是否默认启用
aoenum_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    if (value < 100 and value >= 2) then
        return true;
    else
        return false, "The number is too small.";
    end
end;
aoenum_setting.value_width = 80; -- 值显示宽度像素（默认为100）

local emll_setting = dps_category:create_setting("emll"); -- 指定变量的名字为test1，用于在脚本中进行引用
emll_setting.display_name = L["恶魔力量"]; -- 变量在界面上显示的名字
emll_setting.description = "恶魔力量使用模式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
emll_setting.value_type = rotation_setting_type.text; -- 变量值类型（number数组类型）
emll_setting.default_value = "单体及AOE"; -- 变量默认值（删除此行不设，则为{}）
emll_setting.optional_values ={"单体及AOE", "仅AOE"}; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
emll_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
emll_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
emll_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
emll_setting.value_width = 100; -- 值显示宽度像素（默认为100）

local zyhz_setting = dps_category:create_setting("zyhz"); -- 指定变量的名字为test1，用于在脚本中进行引用
zyhz_setting.display_name = L["灾怨轰炸"]; -- 变量在界面上显示的名字
zyhz_setting.description = "灾怨轰炸使用模式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zyhz_setting.value_type = rotation_setting_type.text; -- 变量值类型（number数组类型）
zyhz_setting.default_value = "单体及AOE"; -- 变量默认值（删除此行不设，则为{}）
zyhz_setting.optional_values ={"单体及AOE", "仅AOE"}; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
zyhz_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
zyhz_setting.is_enabled_by_default = false; -- 是否默认启用（勾选框默认选中）
zyhz_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
zyhz_setting.value_width = 100; -- 值显示宽度像素（默认为100）

local insert_category = rotation:create_setting_category("insert_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
insert_category.display_name = L["Insert Category"]; -- 类别在界面上显示的名字


local shadowfury_setting = insert_category:create_setting("shadowfury"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
shadowfury_setting.display_name = L["shadowfury"];
shadowfury_setting.description = "按住这个键对目标丢暗影之怒！"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
shadowfury_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
shadowfury_setting.default_value = "G"; -- 变量默认值
shadowfury_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
shadowfury_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
shadowfury_setting.is_enabled_by_default = true; -- 是否默认启用
shadowfury_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    if (#value == 1 ) then
        return true;
    else
        return false, "没有这个按键";
    end
end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
shadowfury_setting.value_width = 80;

--吸取生命
local xqsm1_setting = insert_category:create_setting("xqsm1"); 
xqsm1_setting.display_name = L["吸取生命快捷键"];
xqsm1_setting.description = "按下按键吸取生命";
xqsm1_setting.value_type = rotation_setting_type.text; 
xqsm1_setting.default_value = "X"; 
xqsm1_setting.optional_values = nil; 
xqsm1_setting.can_enable_disable = true; 
xqsm1_setting.is_enabled_by_default = true; 
xqsm1_setting.validator = function(self, value) 
   if (value == 1) then
      return true;
   else
      return false, "你输入的值不符合条件";
   end
end;
xqsm1_setting.value_width = 80;


local aoe2_category = rotation:create_setting_category("aoe"); 
aoe2_category.display_name = L["aoename"];
local aoe2_category = rotation:create_setting_category("aoe1"); 
aoe2_category.display_name = L["aoe1name"];
local aoe2_category = rotation:create_setting_category("aoe2"); 
aoe2_category.display_name = L["aoe2name"];
local aoe2_category = rotation:create_setting_category("aoe3"); 
aoe2_category.display_name = L["aoe3name"];
--[[local aoe2_category = rotation:create_setting_category("aoe4"); 
aoe2_category.display_name = L["aoe4name"];
local aoe2_category = rotation:create_setting_category("aoe5"); 
aoe2_category.display_name = L["aoe5name"];
 local aoe2_category = rotation:create_setting_category("aoe6"); 
aoe2_category.display_name = L["aoe6name"];
local aoe2_category = rotation:create_setting_category("aoe7"); 
aoe2_category.display_name = L["aoe7name"];]]

-----------------------------------------------------------
-- 注册事件
-----------------------------------------------------------
--注册事件
do
    
    if Y                        == nil then Y                       = {};   end; --初始化总空间
    if Y.spelllist_failed       == nil then 
        Y.spelllist_failed      = {};                 
    end; --初始化最近一次失败法术的记录空间    
    if Y.spelllist_success       == nil then 
        Y.spelllist_success      = {};                 
    end; --初始化最近一次失败法术的记录空间    
    if Y.spelllist_failed.spellName       == nil then 
        Y.spelllist_failed.spellName      = 0                
    end; --初始化最近一次失败法术的记录空间    
    if Y.spelllist_failed.spelltarget       == nil then 
        Y.spelllist_failed.spelltarget      = "player"                 
    end; --初始化最近一次失败法术的记录空间    
    if Y.spelllist_failed.spelltime       == nil then 
        Y.spelllist_failed.spelltime      = 0                
    end; --初始化最近一次失败法术的记录空间 
    
          
    if Y.lastspell_success      == nil then 
        Y.lastspell_success     = {};
           
    end; --初始化最近一次成功法术的记录空间
    if Y.lastspell_success.spellName      == nil then 
        Y.lastspell_success.spellName     = 0
           
    end; --初始化最近一次成功法术的记录空间
    if Y.lastspell_success.spelltarget      == nil then 
        Y.lastspell_success.spelltarget = "player"
           
    end; --初始化最近一次成功法术的记录空间
    if Y.lastspell_success.spelltime      == nil then 
        Y.lastspell_success.spelltime = 0    
           
    end; --初始化最近一次成功法术的记录空间
    if Y.spell_cast_return      == nil then Y.spell_cast_return     = 0;    end; --初始化最近一次成功法术返回的值 
    if Y.spelllist_success.list == nil then 
        Y.spelllist_success.list = {};
    end   
    
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
                        Y.spelllist_failed.spellName = spell
                        Y.spelllist_failed.spelltarget = destination
                        Y.spelllist_failed.spelltime = GetTime()
                        if Y.spell_cast_return == spell then Y.spell_cast_return = 0;end
                        --对本次失败的ID进行初始化
                        if Y.spelllist_failed[spell] == nil then 
                            Y.spelllist_failed[spell] = {};
                        end
                        table.insert(Y.spelllist_failed[spell],{name = spell, target = destination, stime = Y.spelllist_failed.spelltime})
                        if source == guid and Y.debug == true then
                            print(spellName.." 失败原因: "..spellType)
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
                if --[[ isInCombat("player") and ]] UnitIsUnit(sourceName,"player") then
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
                        if Y.spelllist_success.list == nil then 
                            Y.spelllist_success.list = {};
                        end
                        table.insert(Y.spelllist_success.list,spell)
                        if destination then
                            if Y.debug == true then             
                                print("成功对 "..destName.." ".."施放了 "..spellName)
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
            Y.spell_cast_return = 0; 
            Y.spelllist_failed={}
            Y.lastspell_success={}
            Y.spelllist_failed.spellName = 0
            Y.spelllist_failed.spelltarget = "player"
            Y.spelllist_failed.spelltime = 0 
            Y.lastspell_success.spellName = 0
            Y.lastspell_success.spelltarget = "player"
            Y.lastspell_success.spelltime = 0     
        
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
-- 全局函数
-----------------------------------------------------------
--过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
local function filler_unit(Unit)
    if (UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) then
        return true
    else
        return false
    end
end
--过滤函数，针对doom,留下敌对目标，并且进入了战斗，并且自己面对方向的
local function filler_unit_doom(Unit)
    if (UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3) and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) and isInCombat(Unit) and not UnitDebuffID(Unit,603) then
        return true
    else
        return false
    end
end
--获得恐惧猎犬的数量
local function getMyDreadstalkersCount()
    local ctt = getCT()
    local re = 0
    for i = 1 ,#ctt do
        local im1 = ctt[i]
        if UnitName(im1) == "恐惧猎犬" then
            re = re + 1
        end
    end
    return re
end

-- local Spells = {
--     ["厄运"] = 265412,
--     ["虚空传送门"] = 267217,
--     ["恶魔之箭"] = 264178,
--     ["灵魂打击"] = 264057,
--     ["暗影箭"] = 686,
--     ["召唤邪犬"] = 264119,
--     ["召唤恐惧猎犬"] = 104316,
--     ["灾怨轰炸"] = 267211,
--     ["恶魔力量"] = 267171,
--     ["古尔丹之手"] = 105174,

--     ["内爆"] = 196277,
--     ["能量虹吸"] = 264130, -- 2-2
--     ["召唤恶魔暴君"] = 265187, --
--     ["蛮力猛击"] = 5211, -- 4-1
--     ["群体缠绕"] = 102359, -- 4-2
--     ["台风"] = 132469, -- 4-3
--     ["化身：生命之树"] = 102560, -- 5-3
--     ["繁盛"] = 202770, -- 7-3

--     ["影遁"] = 58984,
-- }

-- local Buff = {
--     ["嗜血"] = 1,
--     ["英勇"] = 2,
--     ["时光扭曲"] = 3,
--     ["高山战鼓"] = 4,
--     ["恶魔之核"] = 264173,
--     ["虚空传送门"] = 267218,
--     ["恶魔之力"] = 265273, --召唤DH后自己有的buff
--     ["魔性征召"] = 205146, 

-- }

-- local Debuff = {
--     ["阳炎术"] = 164815,
--     ["蛮力猛击"] = 5211,
--     ["纠缠根须"] = 339,

-- }

-- local Items = {
--     ["治疗石"] = 5512,
-- }

-- local zj, tg, mouseover, focus = "player", "target", "mouseover", "focus"

-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
    if (not argument or argument == "") then
        GH_Print("使用宏/"..ADDON_SLASH_COMMAND.." em baofa控制爆发");
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
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 266 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
    return current_specialization == speci;
end

function rotation:prestart_action()
    -- 编写模块启动前脚本。
    print("载入oop")
    function getPower(Unit, index)
        local value = value
        if select(3, UnitClass("player")) == 11 or select(3, UnitClass("player")) == 4 then
            if UnitBuffID("player", 106951) or UnitBuffID("player", 102543) then
                value = UnitPower(Unit, index) * 2
            else
                value = UnitPower(Unit, index)
            end
        else
            value = UnitPower(Unit, index) -- 100 * UnitPower(Unit) / UnitPowerMax(Unit)
        end
        return UnitPower(Unit, index)
    end
    function getPowerMax(Unit, index)
        local value = value
        if select(3, UnitClass("player")) == 11 or select(3, UnitClass("player")) == 4 then
            if UnitBuffID("player", 106951) or UnitBuffID("player", 102543) then
                value = UnitPowerMax(Unit, index) * 2
            else
                value = UnitPowerMax(Unit, index)
            end
        else
            value = UnitPowerMax(Unit, index) -- 100 * UnitPower(Unit) / UnitPowerMax(Unit)
        end
        return UnitPowerMax(Unit, index)
    end
    
    function getRacial()
        local race = select(2,UnitRace("player"))
        local BloodElfRacial
        local DraeneiRacial
        local OrcRacial
    
        if race == "BloodElf" then
            BloodElfRacial = select(7, GetSpellInfo(GetSpellInfo(69179)))
        end
        if race == "Draenei" then
            DraeneiRacial = select(7, GetSpellInfo(GetSpellInfo(28880)))
        end
        if race == "Orc" then
            OrcRacial = select(7, GetSpellInfo(GetSpellInfo(33702)))
        end
        local racialSpells = {
            -- Alliance
            Dwarf    = 20594, -- Stoneform
            Gnome    = 20589, -- Escape Artist
            Draenei  = DraeneiRacial, -- Gift of the Naaru
            Human    = 59752, -- Every Man for Himself
            NightElf = 58984, -- Shadowmeld
            Worgen   = 68992, -- Darkflight
            -- Horde
            BloodElf = BloodElfRacial, -- Arcane Torrent
            Goblin   = 69041, -- Rocket Barrage
            Orc      = OrcRacial, -- Blood Fury
            Tauren   = 20549, -- War Stomp
            Troll    = 26297, -- Berserking
            Scourge  = 7744,  -- Will of the Forsaken
            -- Both
            Pandaren = 107079, -- Quaking Palm
            -- Allied Races
            HighmountainTauren = 255654, -- Bull Rush
            LightforgedDraenei = 255647, -- Light's Judgment
            Nightborne = 260364, -- Arcane Pulse
            VoidElf = 256948, -- Spatial Rift
            DarkIronDwarf = 265221, -- Fireblood
            MagharOrc = 274738, -- Ancestral Call
        }
        local trueRace = nil
        local forTheAlliance = UnitBuffID("player",193863) or false
        local forTheHorde = UnitBuffID("player", 193864) or false
        if not forTheAlliance or not forTheHorde then trueRace = racialSpells[race] end
        if trueRace ~= nil then
            return trueRace
        else
            return racialSpells[race]
        end
        -- return racialSpells[race]
    end
    function getHeirloomNeck()
        local necks = {
            eternalAmuletOfTheRedeemed  = 122663,
            eternalEmberfuryTalisman    = 122667,
            eternalHorizonChoker        = 122664,
            eternalTalismanOfEvasion    = 122662,
            eternalWillOfTheMartyr      = 122668,
            eternalWovenIvyNecklace     = 122666,
            manariTrainingAmulet        = 153130,
        }
        for i = 1, #necks do
            local thisNeck = necks[i]
            if hasEquiped(thisNeck,2) then return thisNeck end
        end
        return 0
    end

    Item = {};
    ItemMixin = {};

    do
        local ItemEventListener;

        --[[static]] function Item:CreateFromItemLocation(itemLocation)
            if type(itemLocation) ~= "table" or type(itemLocation.HasAnyLocation) ~= "function" or not itemLocation:HasAnyLocation() then
                error("Usage: Item:CreateFromItemLocation(notEmptyItemLocation)", 2);
            end
            local item = CreateFromMixins(ItemMixin);
            item:SetItemLocation(itemLocation);
            return item;
        end

        --[[static]] function Item:CreateFromBagAndSlot(bagID, slotIndex)
            if type(bagID) ~= "number" or type(slotIndex) ~= "number" then
                error("Usage: Item:CreateFromBagAndSlot(bagID, slotIndex)", 2);
            end
            local item = CreateFromMixins(ItemMixin);
            item:SetItemLocation(ItemLocation:CreateFromBagAndSlot(bagID, slotIndex));
            return item;
        end

        --[[static]] function Item:CreateFromEquipmentSlot(equipmentSlotIndex)
            if type(equipmentSlotIndex) ~= "number" then
                error("Usage: Item:CreateFromEquipmentSlot(equipmentSlotIndex)", 2);
            end
            local item = CreateFromMixins(ItemMixin);
            item:SetItemLocation(ItemLocation:CreateFromEquipmentSlot(equipmentSlotIndex));
            return item;
        end

        --[[static]] function Item:CreateFromItemLink(itemLink)
            if type(itemLink) ~= "string" then
                error("Usage: Item:CreateFromItemLink(itemLinkString)", 2);
            end
            local item = CreateFromMixins(ItemMixin);
            item:SetItemLink(itemLink);
            return item;
        end

        --[[static]] function Item:CreateFromItemID(itemID)
            if type(itemID) ~= "number" then
                error("Usage: Item:CreateFromItemID(itemID)", 2);
            end
            local item = CreateFromMixins(ItemMixin);
            item:SetItemID(itemID);
            return item;
        end

        function ItemMixin:SetItemLocation(itemLocation)
            self:Clear();
            self.itemLocation = itemLocation;
        end

        function ItemMixin:SetItemLink(itemLink)
            self:Clear();
            self.itemLink = itemLink;
        end

        function ItemMixin:SetItemID(itemID)
            self:Clear();
            self.itemID = itemID;
        end

        function ItemMixin:GetItemLocation()
            return self.itemLocation;
        end

        function ItemMixin:HasItemLocation()
            return self.itemLocation ~= nil;
        end

        function ItemMixin:Clear()
            self.itemLocation = nil;
            self.itemLink = nil;
            self.itemID = nil;
        end

        function ItemMixin:IsItemEmpty()
            if self:GetStaticBackingItem() then
                return not C_Item.DoesItemExistByID(self:GetStaticBackingItem());
            end

            return not self:IsItemInPlayersControl();
        end

        function ItemMixin:GetStaticBackingItem()
            return self.itemLink or self.itemID;
        end

        function ItemMixin:IsItemInPlayersControl()
            local itemLocation = self:GetItemLocation();
            return itemLocation and C_Item.DoesItemExist(itemLocation); 
        end

        -- Item API
        function ItemMixin:GetItemID()
            if self:GetStaticBackingItem() then
                return (GetItemInfoInstant(self:GetStaticBackingItem()));
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemID(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:IsItemLocked()
            return self:IsItemInPlayersControl() and C_Item.IsLocked(self:GetItemLocation());
        end

        function ItemMixin:LockItem()
            if self:IsItemInPlayersControl() then
                C_Item.LockItem(self:GetItemLocation());
            end
        end

        function ItemMixin:UnlockItem()
            if self:IsItemInPlayersControl() then
                C_Item.UnlockItem(self:GetItemLocation());
            end
        end

        function ItemMixin:GetItemIcon() -- requires item data to be loaded
            if self:GetStaticBackingItem() then
                return C_Item.GetItemIconByID(self:GetStaticBackingItem());
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemIcon(self:GetItemLocation());
            end
        end

        function ItemMixin:GetItemName() -- requires item data to be loaded
            if self:GetStaticBackingItem() then
                return C_Item.GetItemNameByID(self:GetStaticBackingItem());
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemName(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:GetItemLink() -- requires item data to be loaded
            if self.itemLink then
                return self.itemLink;
            end

            if self.itemID then
                return (select(2, GetItemInfo(self.itemID)));
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemLink(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:GetItemQuality() -- requires item data to be loaded
            if self:GetStaticBackingItem() then
                return C_Item.GetItemQualityByID(self:GetStaticBackingItem());
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemQuality(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:GetCurrentItemLevel() -- requires item data to be loaded
            if self:GetStaticBackingItem() then
                return (GetDetailedItemLevelInfo(self:GetStaticBackingItem()));
            end

            if not self:IsItemEmpty() then
                return C_Item.GetCurrentItemLevel(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:GetItemQualityColor() -- requires item data to be loaded
            local itemQuality = self:GetItemQuality();
            return ITEM_QUALITY_COLORS[itemQuality]; -- may be nil if item data isn't loaded
        end

        function ItemMixin:GetInventoryType()
            if self:GetStaticBackingItem() then
                return C_Item.GetItemInventoryTypeByID(self:GetStaticBackingItem());
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemInventoryType(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:GetItemGUID()
            if self:GetStaticBackingItem() then
                return nil;
            end

            if not self:IsItemEmpty() then
                return C_Item.GetItemGUID(self:GetItemLocation());
            end
            return nil;
        end

        function ItemMixin:GetInventoryTypeName()
            if not self:IsItemEmpty() then
                return select(4, GetItemInfoInstant(self:GetItemID()));
            end
        end

        function ItemMixin:IsItemDataCached()
            if self:GetStaticBackingItem() then
                return C_Item.IsItemDataCachedByID(self:GetStaticBackingItem());
            end

            if not self:IsItemEmpty() then
                return C_Item.IsItemDataCached(self:GetItemLocation());
            end
            return true; 
        end

        function ItemMixin:IsDataEvictable()
            -- Item data could be evicted from the cache
            return true;
        end

        -- Add a callback to be executed when item data is loaded, if the item data is already loaded then execute it immediately
        function ItemMixin:ContinueOnItemLoad(callbackFunction)
            if type(callbackFunction) ~= "function" or self:IsItemEmpty() then
                error("Usage: NonEmptyItem:ContinueOnLoad(callbackFunction)", 2);
            end

            ItemEventListener:AddCallback(self:GetItemID(), callbackFunction);
        end

        -- Same as ContinueOnItemLoad, except it returns a function that when called will cancel the continue
        function ItemMixin:ContinueWithCancelOnItemLoad(callbackFunction)
            if type(callbackFunction) ~= "function" or self:IsItemEmpty() then
                error("Usage: NonEmptyItem:ContinueWithCancelOnItemLoad(callbackFunction)", 2);
            end

            return ItemEventListener:AddCancelableCallback(self:GetItemID(), callbackFunction);
        end

        --[ Item Event Listener ]

        ItemEventListener = CreateFrame("Frame");
        ItemEventListener.callbacks = {};

        ItemEventListener:SetScript("OnEvent", 
            function(self, event, ...)
                if event == "ITEM_DATA_LOAD_RESULT" then
                    local itemID, success = ...;
                    if success then
                        self:FireCallbacks(itemID);
                    else
                        self:ClearCallbacks(itemID);
                    end
                end
            end
        );
        ItemEventListener:RegisterEvent("ITEM_DATA_LOAD_RESULT");

        local CANCELED_SENTINEL = -1;

        function ItemEventListener:AddCallback(itemID, callbackFunction)
            local callbacks = self:GetOrCreateCallbacks(itemID);
            table.insert(callbacks, callbackFunction);
            C_Item.RequestLoadItemDataByID(itemID);
        end

        function ItemEventListener:AddCancelableCallback(itemID, callbackFunction)
            local callbacks = self:GetOrCreateCallbacks(itemID);
            table.insert(callbacks, callbackFunction);
            C_Item.RequestLoadItemDataByID(itemID);

            local index = #callbacks;
            return function()
                if #callbacks > 0 and callbacks[index] ~= CANCELED_SENTINEL then
                    callbacks[index] = CANCELED_SENTINEL;
                    return true;
                end
                return false;
            end;
        end

        function ItemEventListener:FireCallbacks(itemID)
            local callbacks = self:GetCallbacks(itemID);
            if callbacks then
                self:ClearCallbacks(itemID);
                for i, callback in ipairs(callbacks) do
                    if callback ~= CANCELED_SENTINEL then
                        xpcall(callback, CallErrorHandler);
                    end
                end

                for i = #callbacks, 1, -1 do
                    callbacks[i] = nil;
                end
            end
        end

        function ItemEventListener:ClearCallbacks(itemID)
            self.callbacks[itemID] = nil;
        end

        function ItemEventListener:GetCallbacks(itemID)
            return self.callbacks[itemID];
        end

        function ItemEventListener:GetOrCreateCallbacks(itemID)
            local callbacks = self.callbacks[itemID];
            if not callbacks then
                callbacks = {};
                self.callbacks[itemID] = callbacks;
            end
            return callbacks;
        end
    end             

    cUnit = {}
    cPlayer = {}
    --构造技能，buff，debuff，特质表
    if lists == nil then lists = {}; end
    if lists.spells == nil then lists.spells = {}; end
    lists.spells = {
        DEATHKNIGHT = {
            -- Blood
            [250] = {
                abilities                       = {
                    asphyxiate                  = 221562,
                    bloodBoil                   = 50842,
                    bloodMirror                 = 206977,
                    bloodTap                    = 221699,
                    blooddrinker                = 206931,
                    bonestorm                   = 194844,
                    consumption                 = 205223,
                    dancingRuneWeapon           = 49028,
                    deathAndDecay               = 43265,
                    deathsCaress                = 195292,
                    gorefiendsGrasp             = 108199,
                    heartStrike                 = 206930,
                    markOfBlood                 = 206940,
                    marrowrend                  = 195182,
                    runeTap                     = 194679,
                    soulgorge                   = 212744,
                    tighteningGrasp             = 206970,
                    tombstone                   = 219809,
                    vampiricBlood               = 55233,
                    iceboundFortitude           = 48792,
                },
                artifacts                       = {
                    allConsumingRot             = 192464,
                    bloodFeast                  = 192548,
                    bonebreaker                 = 192538,
                    coagulopathy                = 192460,
                    consumption                 = 205223,
                    danceOfDarkness             = 192514,
                    grimPerseverance            = 192447,
                    ironHeart                   = 192450,
                    meatShield                  = 192453,
                    mouthOfHell                 = 192570,
                    rattlingBones               = 192557,
                    sanguinaryAffinity          = 221775,
                    skeletalShattering          = 192558,
                    theHungeringMaw             = 214903,
                    umbilicusEternus            = 193213,
                    unendingThirst              = 192567,
                    veinrender                  = 192457,
                },
                buffs                           = {
                    boneShield                  = 195181,
                    bloodShield                 = 77535,
                    crimsonScourge              = 81136,
                    dancingRuneWeapon           = 81256,
                    runeTap                     = 194679,
                    hemostasis                  = 273947,
                    tombstone                   = 219809,
                    vampiricBlood               = 55233,
                },
                debuffs                         = {
                    asphyxiate                  = 221562,
                    blooddrinker                = 206931,
                    heartStrike                 = 206930,
                    markOfBlood                 = 206940,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    antimagicBarrier            = 205727,
                    blooddrinker                = 206931,
                    bloodworms                  = 195679,
                    bonestorm                   = 194844,
                    consumption                 = 274156,
                    foulBulwark                 = 206974,
                    markOfBlood                 = 206940,
                    ossuary                     = 219786,
                    purgatory                   = 114556,
                    rapidDecomposition          = 194662,
                    redThirst                   = 205723,
                    runeTap                     = 194679,
                    runeStrike                  = 210764,
                    tighteningGrasp             = 206970,
                    tombstone                   = 219809,
                    voracious                   = 273953,
                    wraithWalk                  = 212552,
                    willOfTheNecropolis         = 206967,
                },
            },
            -- Frost
            [251] = {
                abilities                       = {
                    chainsOfIce                 = 45524,
                    empowerRuneWeapon           = 47568,
                    frostStrike                 = 49143,
                    howlingBlast                = 49184,
                    obliterate                  = 49020,
                    pillarOfFrost               = 51271,
                    remorselessWinter           = 196770,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    breathOfSindragosa          = 155166,
                    coldHeart                   = 281210,
                    darkSuccor                  = 101568,
                    empowerRuneWeapon           = 47568,
                    frozenPulse                 = 195750,
                    icyCitadel                  = 272723,
                    icyTalons                   = 194879,
                    killingMachine              = 51124,
                    pillarOfFrost               = 51271,
                    remorselessWinter           = 196770,
                    rime                        = 59052,
                },
                debuffs                         = {
                    breathOfSindragosa          = 155166,
                    chainsOfIce                 = 45524,
                    remorselessWinter           = 196771,
                },
                glyphs                          = {
    
                },
                items                           = {
                    consortsColdCore            = 144293,
                    koltirasNewfoundWill        = 132366,
                    perseveranceOfTheEbonMartyr = 132459,
                },
                talents                         = {
                    asphyxiate                  = 108194,
                    avalanche                   = 207142,
                    blindingSleet               = 207167,
                    breathOfSindragosa          = 152279,
                    coldHeart                   = 152279,
                    deathPact                   = 48743,
                    deathsReach                 = 276079,
                    frostscythe                 = 207230,
                    frostwyrmsFury              = 279302,
                    frozenPulse                 = 194909,
                    gatheringStorm              = 194912,
                    glacialAdvance              = 194913,
                    hornOfWinter                = 57330,
                    icecap                      = 207126,
                    icyTalons                   = 194878,
                    inexorableAssault           = 253593,
                    murderousEffeciency         = 207061,
                    obliteration                = 281238,
                    permafrost                  = 207200,
                    runicAttenuation            = 207104,
                },
                traits                          = {
                    icyCitadel                  = 272718,
                }
            },
            -- Unholy
            [252] = {
                abilities                       = {
                    apocalypse                  = 275699,
                    armyOfTheDead               = 42650,
                    chainsOfIce                 = 45524,
                    darkTransformation          = 63560,
                    deathAndDecay               = 43265,
                    deathCoil                   = 47541,
                    festeringStrike             = 85948,
                    outbreak                    = 77575,
                    raiseDead                   = 46584,
                    scourgeStrike               = 55090,
                    -- Pet Abilities
                    claw                        = 47468,
                    gnaw                        = 47481,
                    huddle                      = 47484,
                    hook                        = 212468,
                    leap                        = 47482,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    corpseShield                = 207319,
                    darkSuccor                  = 101568,
                    darkTransformation          = 63560,
                    deathAndDecay               = 188290,
                    huddle                      = 91838,
                    necrosis                    = 207346,
                    soulReaper                  = 215711,
                    suddenDoom                  = 49530,
                    unholyFrenzy                = 207289,
                },
                debuffs                         = {
                    chainsOfIce                 = 45524,
                    festeringWound              = 194310,
                    -- necroticStrike              = 223829,
                    -- outbreak                    = 77575,
                    -- scourgeOfWorlds             = 191748,
                    soulReaper                  = 130736,
                    virulentPlague              = 191587,
                },
                glyphs                          = {
    
                },
                pets                            = {
                    activePet                   = activePet,
                    gargoyle                    = 27829,
                    risenSkulker                = 99541,
                },
                talents                         = {
                    allWillServe                = 194916,
                    armyOfTheDead               = 276837,
                    asphyxiate                  = 108194,
                    burstingSores               = 207264,
                    clawingShadows              = 207311,
                    deathPact                   = 48743,
                    deathsReach                 = 276079,
                    defile                      = 152280,
                    ebonFever                   = 207269,
                    epidemic                    = 207317,
                    gripOfTheDead               = 273952,
                    harbingerOfDoom             = 276023,
                    infectedClaws               = 207272,
                    pestilence                  = 277234,
                    pestilentPustules           = 194917,
                    soulReaper                  = 130736,
                    spellEater                  = 207321,
                    summonGargoyle              = 49206,
                    unholyBlight                = 115989,
                    unholyFrenzy                = 207289,
                },
                traits                          = {
    
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    antiMagicShell              = 48707,
                    controlUndead               = 111673,
                    corpseExploder              = 127344,
                    darkCommand                 = 56222,
                    deathGate                   = 50977,
                    deathGrip                   = 49576,
                    deathStrike                 = 49998,
                    deathsAdvance               = 48265,
                    iceboundFortitude           = 48792,
                    mindFreeze                  = 47528,
                    pathOfFrost                 = 3714,
                    raiseAlly                   = 61999,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    coldHeartItem               = 235599,
                    iceboundFortitude           = 48792,
                    pathOfFrost                 = 3714,
                    unholyStrength              = 53365,
                    wraithWalk                  = 212552,
                },
                debuffs                         = {
                    bloodPlague                 = 55078,
                    controlUndead               = 111673,
                    darkCommand                 = 56222,
                    frostBreath                 = 190780,
                    frostFever                  = 55095,
                    razorice                    = 51714,
                },
                glyphs                          = {
    
                },
                items                           = {
                    coldHeart                   = 151796,
                },
                talents                         = {
                    wraithWalk                  = 212552,
                },
            },
        },
        DEMONHUNTER = {
            -- Havoc
            [577] = {
                abilities                       = {
                    annihilation                = 201427,
                    bladeDance                  = 188499,
                    blur                        = 198589,
                    chaosNova                   = 179057,
                    chaosStrike                 = 162794,
                    darkness                    = 196718,
                    deathSweep                  = 210152,
                    demonsBite                  = 162243,
                    eyeBeam                     = 198013,
                    felRush                     = 195072,
                    metamorphosis               = 191427,
                    netherwalk                  = 196555,
                    torment                     = 281854,
                    throwGlaive                 = 185123,
                    vengefulRetreat             = 198793,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    immolationAura              = 258920,
                    metamorphosis               = 162264,
                    momentum                    = 208628,
                    prepared                    = 203650,
                },
                debuffs                         = {
                    darkSlash                   = 258860,
                    nemesis                     = 206491,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    blindFury                   = 203550,
                    cycleOfHatred               = 258887,
                    darkSlash                   = 258860,
                    demonBlades                 = 203555,
                    demonic                     = 213410,
                    demonicAppetite             = 206478,
                    desperateInstincts          = 205411,
                    felBarrage                  = 258925,
                    felEruption                 = 211881,
                    felMastery                  = 192939,
                    firstBlood                  = 206416,
                    immolationAura              = 258920,
                    insatiableHunger            = 258876,
                    masterOfTheGlaive           = 203556,
                    momentum                    = 206476,
                    nemesis                     = 206491,
                    netherwalk                  = 196555,
                    soulRending                 = 204909,
                    trailOfRuin                 = 258881,
                    unleashedPower              = 206477,
                },
                traits                          = {
                    chaoticTransformation       = 288754,
                    revolvingBlades             = 279581,
                    unboundChaos                = 275144,
                },
            },
            -- Vengeance
            [581] = {
                abilities                       = {
                    demonSpikes                 = 203720,
                    fieryBrand                  = 204021,
                    immolationAura              = 178740,
                    infernalStrike              = 189110,
                    metamorphosis               = 187827,
                    shear                       = 203782,
                    sigilOfFlame                = 204596,
                    sigilOfMisery               = 207684,
                    sigilOfSilence              = 202137,
                    soulCleave                  = 228477,
                    throwGlaive                 = 204157,
                    torment                     = 185245,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    bladeTurning                = 247254,
                    demonSpikes                 = 203819,
                    empowerWards                = 218256,
                    feastofSouls                = 207693,
                    immolationAura              = 178740,
                    metamorphosis               = 187827,
                    soulFragments               = 203981,
                    siphonedPower               = 218561,
                },
                debuffs                         = {
                    fieryBrand                  = 207744,
                    frailty                     = 247456,
                    sigilOfFlame                = 204598,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    abyssalStrike               = 207550,
                    agonizingFlames             = 207548,
                    burningAlive                = 207739,
                    charredFlesh                = 264002,
                    concentratedSigils          = 207666,
                    fallout                     = 227174,
                    feastofSouls                = 207697,
                    feedTheDemon                = 218612,
                    felDevastation              = 212084,
                    flameCrash                  = 227322,
                    fracture                    = 263642,
                    gluttony                    = 264004,
                    lastResort                  = 209258,
                    quickenedSigils             = 209281,
                    razorSpikes                 = 209400,
                    sigilOfChains               = 202138,
                    soulBarrier                 = 263648,
                    soulRending                 = 217996,
                    spiritBomb                  = 247454,
                    voidReaver                  = 268175,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    consumeMagic                = 278326,
                    disrupt                     = 183752,
                    glide                       = 131347,
                    imprison                    = 217832,
                    spectralSight               = 188501,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    gazeOfTheLegion             = 193456,
                    glide                       = 131347,
                    vigorEngaged                = 287916,
                },
                debuffs                         = {
    
                },
                glyphs                          = {
                    glyphOfCracklingFlames      = 219831,
                    glyphOfFallowWings          = 220083,
                    glyphOfFearsomeMetamorphosis= 220831,
                    glyphOfFelTouchedSouls      = 219713,
                    glyphOfFelWings             = 220228,
                    glyphOfFelEnemies           = 220240,
                    glyphOfManaTouchedSouls     = 219744,
                    glyphOfShadowEnemies        = 220244,
                    glyphOfTatteredWings        = 220226,
                },
                items                           = {
                    inquisitorsMenacingEye      = 129192,
                    soulOfTheSlayer             = 151639,
                },
                talents                         = {
                    felblade                    = 232893,
                },
            },
        },
        DRUID = {
            -- Balance
            [102] = {
                abilities                       = {
                    barkskin                    = 22812,
                    celestialAlignment          = 194223,
                    fullMoon                    = 274283,
                    furyOfElune                 = 202770,
                    halfMoon                    = 274282,
                    innervate                   = 29166,
                    lunarStrike                 = 194153,
                    newMoon                     = 274281,
                    removeCorruption            = 2782,
                    solarBeam                   = 78675,
                    solarWrath                  = 190984,
                    starfall                    = 191034,
                    starsurge                   = 78674,
                    sunfire                     = 93402,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    blessingOfElune             = 202737,
                    blessingOfAnshe             = 202739,
                    incarnationChoseOfElune     = 102560,
                    celestialAlignment          = 194223,
                    onethsOverconfidence        = 209407,
                    onethsIntuition             = 209406,
                    solarEmpowerment            = 164545,
                    lunarEmpowerment            = 164547,
                    warriorOfElune              = 202425,
                    balanceForm                 = 24858,
                    stellarDrift                = 202461,
                    emeraldDreamcatcher         = 208190,
                    barkskin                    = 22812,
                    owlkinFrenzy                = 157228,
                    powerOfEluneTheMoonGoddness = 208284,
                    sephuzSecret                = 208052,
                    astralAcceleration          = 242232,
                    newMoonController           = -2027671,
                    starlord                    = 279709,
                },
                debuffs                         = {
                    stellarFlare                = 202347,
                    moonfire                    = 164812,
                    sunfire                     = 164815,
                    stellarEmpowerment          = 197637,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    feralAffinity               = 202157,
                    forceOfNature               = 205636,
                    furyOfElune                 = 202770,
                    guardianAffinity            = 197491,
                    incarnationChoseOfElune     = 102560,
                    naturesBalance              = 202430,
                    newMoon                     = 274281,
                    renewal                     = 108238,
                    restorationAffinity         = 197492,
                    shootingStars               = 202342,
                    soulOfTheForest             = 114107,
                    starlord                    = 202345,
                    stellarDrift                = 202354,
                    stellarFlare                = 202347,
                    twinMoons                   = 279620,
                    warriorOfElune              = 202425,
                },
                traits                          = {
                    arcanicPulsar               = 287773,
                    dawningSun                  = 276152,
                    highNoon                    = 278505,
                    livelySpirit                = 279642,
                    lunarShrapnel               = 278507,
                    powerOfTheMoon              = 273367,
                    streakingStars              = 272871,
                    sunblaze                    = 274397,
                }
            },
            -- Feral
            [103] = {
                abilities                       = {
                    berserk                     = 106951,
                    maim                        = 22570,
                    moonfireFeral               = 155625,
                    removeCorruption            = 2782,
                    skullBash                   = 106839,
                    stampedingRoar              = 106898,
                    survivalInstincts           = 61336,
                    tigersFury                  = 5217,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    apexPredator                = 255984,
                    berserk                     = 106951,
                    bloodtalons                 = 145152,
                    clearcasting                = 135700,
                    elunesGuidance              = 202060,
                    fieryRedMaimers             = 236757,
                    incarnationKingOfTheJungle  = 102543,
                    ironJaws                    = 276021,
                    jungleStalker               = 252071,
                    predatorySwiftness          = 69369,
                    savageRoar                  = 52610,
                    scentOfBlood                = 285646,
                    stampedingRoar              = 77764,
                    survivalInstincts           = 61336,
                    tigersFury                  = 5217,
                },
                debuffs                         = {
                    feralFrenzy                 = 274838,
                    moonfireFeral               = 155625,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    balanceAffinity             = 197488,
                    bloodtalons                 = 155672,
                    brutalSlash                 = 202028,
                    feralFrenzy                 = 274837,
                    guardianAffinity            = 217615,
                    incarnationKingOfTheJungle  = 102543,
                    lunarInspiration            = 155580,
                    momentOfClarity             = 236068,
                    predator                    = 202021,
                    primalWrath                 = 285381,
                    renewal                     = 108238,
                    restorationAffinity         = 197492,
                    sabertooth                  = 202031,
                    savageRoar                  = 52610,
                    scentOfBlood                = 285564,
                    soulOfTheForest             = 158476,
                },
                traits                          = {
                    ironJaws                    = 276021,
                    twistedClaws                = 275906,
                    wildFleshrending            = 279527,
                }
            },
            -- Guardian
            [104] = {
                abilities                       = {
                    barkskin                    = 22812,
                    incapacitatingRoar          = 99,
                    incarnationGuardianOfUrsoc  = 102558,
                    maul                        = 6807,
                    removeCorruption            = 2782,
                    skullBash                   = 106839,
                    stampedingRoar              = 106898,
                    survivalInstincts           = 61336,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    galacticGuardian            = 213708,
                    goryFur                     = 201671,
                    incarnationGuardianOfUrsoc  = 102558,
                    pulverize                   = 158792,
                    survivalInstincts           = 61336,
                },
                debuffs                         = {
                    moonfireGuardian            = 164812,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    balanceAffinity             = 197488,
                    bloodFrenzy                 = 203962,
                    brambles                    = 203953,
                    bristlingFur                = 155835,
                    earthwarden                 = 203974,
                    feralAffinity               = 202155,
                    galacticGuardian            = 203964,
                    guardianOfElune             = 155578,
                    incarnationGuardianOfUrsoc  = 102558,
                    lunarBeam                   = 204066,
                    pulverize                   = 80313,
                    rendAndTear                 = 204053,
                    restorationAffinity         = 197492,
                    soulOfTheForest             = 158477,
                    survivalOfTheFittest        = 203965,
                },
                traits                          = {
                    layeredMane                 = 279552,
                    twistedClaws                = 275906,
                },
            },
            -- Restoration
            [105] = {
                abilities                       = {
                    barkskin                    = 22812,
                    efflorescence               = 145205,
                    innervate                   = 29166,
                    ironbark                    = 102342,
                    lifebloom                   = 33763,
                    naturesCure                 = 88423,
                    revitalize                  = 212040,
                    solarWrath                  = 5176,
                    sunfire                     = 93402,
                    tranquility                 = 740,
                    yserasGift                  = 145108,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    abundance                   = 207640,
                    cenarionWard                = 102352,
                    clearcasting                = 16870,
                    incarnationTreeOfLife       = 33891,
                    innervate                   = 29166,
                    rejuvenationGermination     = 155777,
                    lifebloom                   = 33763,
                    lunarEmpowerment            = 164547,
                    regrowth                    = 8936,
                    solarEmpowerment            = 164545,
                    soulOfTheForest             = 114108,
                    cultivat                    = 200389,
                    tranquility                 = 157982,
                    springblossom               = 207386,
                    fullbloom                   = 290213,
                },
                debuffs                         = {
                    moonfire                    = 164812,
                    sunfire                     = 164815,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    abundance                   = 207383,
                    balanceAffinity             = 197632,
                    cenarionWard                = 102351,
                    cultivation                 = 200390,
                    feralAffinity               = 197490,
                    flourish                    = 197721,
                    germination                 = 155675,
                    guardianAffinity            = 197491,
                    incarnationTreeOfLife       = 33891,
                    innerPeace                  = 197073,
                    photosynthesis              = 274902,
                    prosperity                  = 200383,
                    renewal                     = 108238,
                    soulOfTheForest             = 158478,
                    springBlossoms              = 207385,
                    stonebark                   = 197061,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    bearForm                    = 5487,
                    catForm                     = 768,
                    dash                        = 1850,
                    dreamwalk                   = 193753,
                    entanglingRoots             = 339,
                    ferociousBite               = 22568,
                    frenziedRegeneration        = 22842,
                    growl                       = 6795,
                    hibernate                   = 2637,
                    ironfur                     = 192081,
                    lunarStrike                 = 197628,
                    mangle                      = 33917,
                    moonfire                    = 8921,
                    moonkinForm                 = 197625,
                    prowl                       = 5215,
                    rake                        = 1822,
                    rebirth                     = 20484,
                    regrowth                    = 8936,
                    rejuvenation                = 774,
                    revive                      = 50769,
                    rip                         = 1079,
                    shadowmeld                  = 58984,
                    shred                       = 5221,
                    solarWrathMoonkin           = 197629,
                    soothe                      = 2908,
                    starsurge                   = 197626,
                    sunfireMoonkin              = 197630,
                    swiftmend                   = 18562,
                    swipeBear                   = 213771,
                    swipeCat                    = 106785,
                    thrashBear                  = 77758,
                    thrashCat                   = 106830,
                    travelForm                  = 783,
                    wildGrowth                  = 48438,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    bearForm                    = 5487,
                    burningEssence              = 138927,
                    catForm                     = 768,
                    dash                        = 1850,
                    flightForm                  = 165962,
                    frenziedRegeneration        = 22842,
                    ironfur                     = 192081,
                    moonkinForm                 = 197625,
                    prowl                       = 5215,
                    rejuvenation                = 774,
                    shadowmeld                  = 58984,
                    stagForm                    = 210053,
                    travelForm                  = 783,
                    wildGrowth                  = 48438,
                },
                debuffs                         = {
                    entanglingRoots             = 339,
                    growl                       = 6795,
                    hibernate                   = 2637,
                    moonfire                    = 8921,
                    rake                        = 155722,
                    rip                         = 1079,
                    thrashBear                  = 192090,
                    thrashCat                   = 106830,
                },
                glyphs                          = {
                    glyphOfTheCheetah           = 131113,
                    glyphOfTheDoe               = 224122,
                    glyphOfTheFeralChameleon    = 210333,
                    glyphOfTheOrca              = 114333,
                    glyphOfTheSentinel          = 219062,
                    glyphOfTheUrsolChameleon    = 107059,
                },
                items                           = {
                    ailuroPouncers              = 137024,
                    burningSeeds                = 94604,
                    chatoyantSignet             = 137040,
                    fandralsSeedPouch           = 122304,
                    luffaWrappings              = 137056,
                    theWildshapersClutch        = 137094,
                },
                talents                         = {
                    massEntanglement            = 102359,
                    mightyBash                  = 5211,
                    tigerDash                   = 252216,
                    typhoon                     = 132469,
                    wildCharge                  = 102401,
                },
            },
        },
        HUNTER = {
            -- BeastMastery
            [253] = {
                abilities                       = {
                    aMurderOfCrows              = 131894,
                    aspectOfTheWild             = 193530,
                    barbedShot                  = 217200,
                    barrage                     = 120360,
                    bestialWrath                = 19574,
                    bindingShot                 = 109248,
                    chimaeraShot                = 53209,
                    cobraShot                   = 193455,
                    concussiveShot              = 5116,
                    counterShot                 = 147362,
                    direBeast                   = 120679,
                    disengage                   = 781,
                    intimidation                = 19577,
                    killCommand                 = 34026,
                    misdirection                = 34477,
                    multiShot                   = 2643,
                    spittingCobra               = 194407,
                    stampede                    = 201430,
                    titansThunder               = 207068,
                    volley                      = 194386
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    aspectOfTheWild             = 193530,
                    beastCleave                 = 118455,
                    bestialWrath                = 19574,
                    direBeast                   = 120694,
                    frenzy                      = 272790,
                    parselsTongue               = 248084,
                    spittingCobra               = 194407,
                    volley                      = 194386
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    aMurderOfCrows              = 131894,
                    aspectOfTheBeast            = 191384,
                    barrage                     = 120360,
                    chimaeraShot                = 53209,
                    direBeast                   = 120679,
                    spittingCobra               = 194407,
                },
                traits                          = {
                    primalInstincts             = 279806,
                },
            },
            -- Marksmanship
            [254] = {
                abilities                       = {
                    aimedShot                   = 19434,
                    arcaneShot                  = 185358,
                    burstingShot                = 186387,
                    concussiveShot              = 5116,
                    counterShot                 = 147362,
                    multiShot                   = 257620,
                    rapidFire                   = 257044,
                    serpentSting                = 271788,
                    steadyShot                  = 56641,
                    trueshot                    = 193526,
                },
                artifacts                       = {
                },
                buffs                           = {
                    doubleTap                   = 260402,
                    feignDeath                  = 5384,
                    lethalShots                 = 260395,
                    lockAndLoad                 = 194594,
                    masterMarksman              = 269576,
                    preciseShots                = 260242,
                    steadyFocus                 = 193534,
                    trickShots                  = 257622,
                    trueshot                    = 288613,
                    unerringVision              = 274447,
    
                },
                debuffs                         = {
                    aMurderOfCrows              = 131894,
                    huntersMark                 = 257284,
                    serpentSting                = 271788,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    barrage                     = 120360,
                    callingTheShots             = 260404,
                    carefulAim                  = 260228,
                    doubleTap                   = 260402,
                    explosiveShot               = 212431,
                    huntersMark                 = 257284,
                    lethalShots                 = 260393,
                    lockAndLoad                 = 194595,
                    masterMarksman              = 260309,
                    piercingShot                = 198670,
                    serpentSting                = 271788,
                    steadyFocus                 = 193533,
                    streamline                  = 260367,
                    volley                      = 260243,
                },
                traits                          = {
                    focusedFire                 = 278531,
                    inTheRhythm                 = 264198,
                    rapidReload                 = 278530,
                    steadyAim                   = 277651,
                    surgingShots                = 287707,
                    unerringVision              = 274444,
                },
            },
            -- Survival
            [255] = {
                abilities                       = {
                    aspectOfTheEagle            = 186289,
                    butchery                    = 212436,
                    carve                       = 187708,
                    chakrams                    = 259391,
                    coordinatedAssault          = 266779,
                    flankingStrike              = 269751,
                    harpoon                     = 190925,
                    killCommand                 = 259489,
                    mongooseBite                = 259387,
                    muzzle                      = 187707,
                    pheromoneBomb               = 270323,
                    raptorStrike                = 186270,
                    serpentSting                = 259491,
                    shrapnelBomb                = 270335,
                    steelTrap                   = 162488,
                    volatileBomb                = 271045,
                    wildfireBomb                = 259495,
                    wingClip                    = 195645,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    aspectOfTheEagle            = 186289,
                    blurOfTalons                = 277969,
                    coordinatedAssault          = 266779,
                    exposedFlank                = 252094, -- Tier 21
                    mongooseFury                = 259388,
                    tipOfTheSpear               = 260286,
                    vipersVenom                 = 268552,
                },
                debuffs                         = {
                    bloodseeker                 = 259277,
                    internalBleeding            = 270343,
                    latentPoison                = 273286,
                    serpentSting                = 259491,
                    shrapnelBomb                = 270339,
                    wildfireBomb                = 269747,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    alphaPredator               = 269737,
                    birdsOfPrey                 = 260331,
                    bloodseeker                 = 260248,
                    butchery                    = 212436,
                    chakrams                    = 259391,
                    flankingStrike              = 269751,
                    guerrillaTactics            = 264332,
                    hydrasBite                  = 260241,
                    mongooseBite                = 259387,
                    steelTrap                   = 162488,
                    termsOfEngagement           = 265895,
                    tipOfTheSpear               = 260285,
                    vipersVenom                 = 268501,
                    wildfireInfusion            = 271014,
                },
                traits                          = {
                    blurOfTalons                = 277653,
                    latentPoison                = 273283,
                    primevalIntuition           = 288570,
                    upCloseAndPersonal          = 278533,
                    venomousFangs               = 274590,
                    wildernessSurvival          = 279589,
                }
            },
            -- All
            Shared = {
                abilities                       = {
                    aMurderOfCrows              = 131894,
                    aspectOfTheCheetah          = 186257,
                    aspectOfTheTurtle           = 186265,
                    bindingShot                 = 109248,
                    bite                        = 17253,
                    callPet1                    = 883,
                    callPet2                    = 83242,
                    callPet3                    = 83243,
                    callPet4                    = 83244,
                    callPet5                    = 83245,
                    --pet Purges
                    spiritShock                 = 264265,
                    chiJiTranq                  = 264028,
                    naturesGrace                = 264266,
                    netherShock                 = 264264,
                    sonicBlast                  = 264263,
                    soothingWater               = 254262,
                    sporeCloud                  = 254056,
    
                    camouflage                  = 199483,
                    catlikeReflexes             = 263892,
                    claw                        = 16827,
                    dash                        = 61684,
                    disengage                   = 781,
                    dismissPet                  = 2641,
                    eagleEye                    = 6197,
                    exhilaration                = 109304,
                    feignDeath                  = 5384,
                    flare                       = 1543,
                    freezingTrap                = 187650,
                    growl                       = 2649,
                    heartOfThePhoenix           = 55709,
                    intimidation                = 19577,
                    mendPet                     = 136,
                    misdirection                = 34477,
                    playDead                    = 209997,
                    prowl                       = 24450,
                    revivePet                   = 982,
                    smack                       = 49966,
                    spiritmend                  = 90361,
                    tarTrap                     = 187698,
                    wakeUp                      = 210000,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    aspectOfTheTurtle           = 186265,
                    feignDeath                  = 5384,
                    mendPet                     = 136,
                    playDead                    = 209997,
                    prowl                       = 24450,
                },
                debuffs                         = {
                    bestialFerocity             = 191413,
                },
                glyphs                          = {
    
                },
                pets                            = {
                    activePet                   = activePet,
                },
                talents                         = {
                    aMurderOfCrows              = 131894,
                    bindingShot                 = 109248,
                    bornToBeWild                = 266921,
                    camouflage                  = 199483,
                    naturalMending              = 270581,
                    posthaste                   = 109215,
                    trailblazer                 = 199921,
                },
            },
        },
        MAGE = {
            -- Arcane
            [62] = {
                abilities                       = {
                    arcaneBarrage               = 44425,
                    arcaneBlast                 = 30451,
                    arcaneExplosion             = 1449,
                    arcaneFamiliar              = 205022,
                    arcaneMissiles              = 5143,
                    arcaneOrb                   = 153626,
                    arcanePower                 = 12042,
                    chargedUp                   = 205032,
                    displacement                = 212801,
                    erosion                     = 205039,
                    evocation                   = 12051,
                    greaterInvisibility         = 110959,
                    markOfAluneth               = 224968,
                    netherTempest               = 114923,
                    presenceOfMind              = 205025,
                    prismaticBarrier            = 235450,
                    slow                        = 31589,
                    supernova                   = 157980,
                },
                artifacts                       = {
                    aegwynnsAscendance          = 187680,
                    aegwynnsFury                = 187287,
                    aegwynnsInperative          = 187264,
                    aegwynnsIntensity           = 238054,
                    aegwynnsWrath               = 187321,
                    alunethsAvarice             = 238090,
                    ancientPower                = 214917,
                    arcanePurification          = 187313,
                    arcaneRebound               = 188006,
                    blastingRod                 = 187258,
                    cracklingEnergy             = 187310,
                    etherealSensitivity         = 187276,
                    everywhereAtOnce            = 187301,
                    forceBarrier                = 210716,
                    intensityOfTheTirisgarde    = 241121,
                    markOfAluneth               = 224968,
                    mightOfTheGuardians         = 187318,
                    ruleOfThrees                = 215463,
                    sloooowDown                 = 210730,
                    timeAndSpace                = 238126,
                    torrentialBarrage           = 187304,
                    touchOfTheMagi              = 210725,
                },
                buffs                           = {
                  arcaneFamiliar                = 210126,
                  arcanePower                   = 12042,
                  -- arcaneCharge                  = 36032,
                  arcaneMissles                 = 79683,
                  presenceOfMind                = 205025,
                  rhoninsAssaultingArmwraps     = 208081,
                  ruleOfThrees                  = 264774,
                  brainStorm                    = 273330,
                  clearcasting                  = 263725,
                },
                debuffs                         = {
                  arcaneCharge                  = 36032,
                  netherTempest                 = 114923,
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    amplification               = 236628,
                    arcaneFamiliar              = 205022,
                    arcaneOrb                   = 153626,
                    chargedUp                   = 205032,
                    chronoShift                 = 235711,
                    --erosion                     = 205039,
                    manaShield                  = 235463,
                    netherTempest               = 114923,
                    overpowered                 = 155147,
                    resonance                   = 205028,
                    slipstream                  = 236457,
                    supernova                   = 157980,
                    --temporalFlux                = 234302,
                    --wordsOfPower                = 205035,
                },
                traits                         = {
                    anomalousImpact             = 279867,
                    arcanePressure              = 274594,
                    arcanePummeling             = 270669,
                    brainStorm                  = 273326,
                    explosiveEcho               = 278537,
                    galvanizingSpark            = 278536,
                },
            },
            -- Fire
            [63] = {
                abilities                       = {
                    blazingBarrier              = 235313,
                    blastWave                   = 157981,
                    cinderstorm                 = 198929,
                    combustion                  = 190319,
                    dragonsBreath               = 31661,
                    fireball                    = 133,
                    fireBlast                   = 108853,
                    flameOn                     = 205029,
                    flamestrike                 = 2120,
                    livingBomb                  = 44457,
                    meteor                      = 153561,
                    phoenixsFlames              = 257541,
                    pyroblast                   = 11366,
                    scorch                      = 2948,
                },
                artifacts                       = {
                    aftershocks                 = 194431,
                    phoenixReborn               = 215773,
                },
                buffs                           = {
                    blazingBarrier              = 235313,
                    combustion                  = 190319,
                    heatingUp                   = 48107,
                    hotStreak                   = 48108,
                    iceFloes                    = 108839,
                    kaelthasUltimateAbility     = 209455,
                    preheat                     = 273333,
                    pyroclasm                   = 269651,
                },
                debuffs                         = {
                    meteorBurn                  = 155158,
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    alexstraszasFury            = 235870,
                    blastWave                   = 157981,
                    --cinderstorm                 = 198929,
                    conflagration               = 205023,
                    --controlledBurn              = 205033,
                    firestarter                 = 205026,
                    flameOn                     = 205029,
                    flamePatch                  = 205037,
                    kindling                    = 155148,
                    livingBomb                  = 44457,
                    meteor                      = 153561,
                    mirrorImage                 = 55342,
                    phoenixsFlames              = 257541,
                    pyromaniac                  = 205020,
                    pyroclasm                   = 269650,
                    searingTouch                = 269644,
                },
                traits                          = {
                    preheat                     = 273332,
                    blasterMaster               = 274596,
                }
            },
            -- Frost
            [64] = {
                abilities                       = {
                    blizzard                    = 190356,
                    coldSnap                    = 235219,
                    coneOfCold                  = 120,
                    fireBlast                   = 108853,
                    flurry                      = 44614,
                    freeze                      = 231596,
                    frostbolt                   = 116,
                    frozenTouch                 = 205030,
                    frostBomb                   = 112948,
                    frozenOrb                   = 84714,
                    iceLance                    = 30455,
                    icyVeins                    = 12472,
                    summonWaterElemental        = 31687,
                    rayOfFrost                  = 205021,
                    iceBarrier                  = 11426,
                },
                artifacts                       = {
                   -- icyHand                     = 220817,
                },
                buffs                           = {
                    brainFreeze                 = 190446,
                    freezingRain                = 270232,
                    frostBomb                   = 112948,
                    fingersOfFrost              = 44544,
                    icyVeins                    = 12472,
                    chainReaction               = 195418,
                    zannesuJourney              = 226852,
                    timeWarp                    = 80353,
                    iceFloes                    = 108839,
                    iceBarrier                  = 11426,
                    icicles                     = 205473,
                    frozenMass                  = 242253,
                },
                debuffs                         = {
                    frostBomb                   = 112948,
                    wintersChill                = 228358,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    --articGale                   = 205038,
                    boneChilling                = 205027,
                    cometStorm                  = 153595,
                    ebonbolt                    = 257537,
                    --frostBomb                   = 112948,
                    frozenTouch                 = 205030,
                    glacialSpike                = 199786,
                    iceNova                     = 157997,
                    iceFloes                    = 108839,
                    lonelyWinter                = 205024,
                    rayOfFrost                  = 205021,
                    splittingIce                = 56377,
                    thermalVoid                 = 155149,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    arcaneIntellect             = 1459,
                    blink                       = 1953,
                    counterspell                = 2139,
                    frostNova                   = 122,
                    iceBlock                    = 45438,
                    invisibility                = 66,
                    mirrorImage                 = 55342,
                    rungOfFrost                 = 113724,
                    runeOfPower                 = 116011,
                    shimmer                     = 212653,
                    slowFall                    = 130,
                    spellsteal                  = 30449,
                    timeWarp                    = 80353,
                    waterJet                    = 135029,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    arcaneIntellect             = 1459,
                    incantersFlow               = 1463,
                    runeOfPower                 = 116014,
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    incantersFlow               = 1463,
                    iceWard                     = 205036,
                    mirrorImage                 = 55342,
                    ringOfFrost                 = 113724,
                    runeOfPower                 = 116011,
                    shimmer                     = 212653,
                    --unstableMagic               = 157976,
                },
            },
        },
        MONK = {
            -- Brewmaster
            [268] = {
                abilities                       = {
                    blackoxBrew                 = 115399,
                    blackOxStatue               = 115315,
                    blackoutStrike              = 205523,
                    breathOfFire                = 115181,
                    chiBurst                    = 123986,
                    chiWave                     = 115098,
                    detox                       = 218164,
                    effuse                      = 116694,
                    expelHarm                   = 115072,
                    explodingKeg                = 214326,
                    fortifyingBrew              = 115203,
                    guard                       = 115295,
                    healingElixir               = 122281,
                    ironskinBrew                = 115308,
                    kegSmash                    = 121253,
                    purifyingBrew               = 119582,
                    rushingJadeWind             = 116847,
                    spearHandStrike             = 116705,
                    provoke                     = 115546,
                    invokeNiuzao                = 132578,
                    zenMeditation               = 115176,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    ironskinBrew                = 215479,
                    blackoutCombo               = 228563,
                    rushingJadeWind             = 116847,
                    zenMeditation               = 115176,
                },
                debuffs                         = {
                    breathOfFire                = 146222,
                    moderateStagger             = 124274,
                    heavyStagger                = 124273,
                    kegSmash                    = 121253,
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    blackoutCombo               = 196736,
                    blackoxBrew                 = 115399,
                    guard                       = 115295,
                    rushingJadeWind             = 116847,
                },
            },
            -- Mistweaver
            [270] = {
                abilities                       = {
                    blackoutKick                = 100784,
                    chiBurst                    = 123986,
                    zenPulse                    = 124081,
                    mistwalk                    = 197945,
                    chiTorpedo                  = 115008,
                    tigersLust                  = 116841,
                    cracklingJadeLightning      = 117952,
                    detox                       = 115450,
                    effuse                      = 116694,
                    envelopingMist              = 124682,
                    essenceFont                 = 191837,
                    healingElixir               = 122281,
                    diffuseMagic                = 122783,
                    dampenHarm                  = 122278,
                    invokeChiJi                 = 198664,
                    refreshingJadeWind          = 196725,
                    summonJadeSerpentStatue     = 115313,
                    legSweep                    = 119381,
                    ringOfPeace                 = 116844,
                    songOfChiJi                 = 198898,
                    lifeCocoon                  = 116849,
                    paralysis                   = 115078,
                    provoke                     = 115546,
                    reawaken                    = 212051,
                    renewingMist                = 115151,
                    resuscitate                 = 115178,
                    revival                     = 115310,
                    risingSunKick               = 107428,
                    roll                        = 109132,
                    sheilunsGift                = 205406,
                    spinningCraneKick           = 101546,
                    thunderFocusTea             = 116680,
                    tigerPalm                   = 100780,
                    manaTea                     = 197908,
                    transcendence               = 101643,
                    transcendenceTransfer       = 119996,
                    soothingMist                = 115175,
                    chiWave                     = 115098,
                    fortifyingBrew              = 243435,
                    surgingMist                 = 227344,
                },
                artifacts                       = {
                },
                buffs                           = {
                    soothingMist                = 115175,
                    renewingMist                = 119611,
                    envelopingMist              = 124682,
                    thunderFocusTea             = 116680,
                    lifeCyclesEnvelopingMist    = 197919,
                    lifeCyclesVivify            = 197916,
                    surgeOfMist                 = 246328,
                    danceOfMist                 = 247891,
                    upliftTrance                = 197206,
                    refreshingJadeWind          = 196725,
                    lifeCocoon                  = 116849,
                    transcendence               = 101643,
                    tigersLust                  = 116841,
                    teachingsOfTheMonastery     = 202090,
                    diffuseMagic                = 122783,
                    dempenHarm                  = 122278,
                    innervate                   = 29166,
                    symbolOfHope                = 64901,
                    essenceFont                 = 191837,
                    manaTea                     = 197908,
                    wayOfTheCrane               = 216113,
                },
                debuffs                         = {
                },
                glyphs                          = {
                },
                talents                         = {
                    chiBurst                    = 123986,
                    chiWave                     = 115098,
                    chiTorpedo                  = 115008,
                    tigersLust                  = 116841,
                    mistWrap                    = 197900,
                    spiritOfTheCrane            = 210802,
                    ringOfPeace                 = 116844,
                    songOfChiJi                 = 198898,
                    healingElixir               = 122281,
                    diffuseMagic                = 122783,
                    dampenHarm                  = 122278,
                    refreshingJadeWind          = 196725,
                    invokeChiJiTheRedCrane      = 198664,
                    summonJadeSerpentStatue     = 115313,
                    manaTea                     = 197908,
                    diffuseMagic                = 122783,
                    upwelling                   = 274963,
                    lifecycles                  = 197915,
                },
            },
            -- Windwalker
            [269] = {
                abilities                       = {
                    chiWave                     = 115098,
                    detox                       = 218164,
                    disable                     = 116095,
                    fistsOfFury                 = 113656,
                    flyingSerpentKick           = 101545,
                    flyingSerpentKickEnd        = 115057,
                    risingSunKick               = 107428,
                    spearHandStrike             = 116705,
                    spinningCraneKick           = 101546,
                    stormEarthAndFire           = 137639,
                    stormEarthAndFireFixate     = 221771,
                    touchOfDeath                = 115080,
                    touchOfKarma                = 122470,
                    transcendence               = 101643,
                    transcendenceTransfer       = 119996,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    hitCombo                    = 196741,
                    pressurePoint               = 247255,
                    rushingJadeWind             = 116847,
                    serenity                    = 152173,
                    stormEarthAndFire           = 137639,
                    swiftRoundhouse             = 278710,
                    theEmperorsCapacitor        = 235054,
                    touchOfKarma                = 122470,
                    transcendence               = 101643,
                    transferThePower            = 195321,
                },
                debuffs                         = {
                    markOfTheCrane              = 228287,
                    risingFist                  = 242259,
                    touchOfDeath                = 115080,
                },
                glyphs                          = {
                    glyphOfRisingTigerKick      = 125151,
                },
                talents                         = {
                    ascension                   = 115396,
                    diffuseMagic                = 122783,
                    energizingElixir            = 115288,
                    eyeOfTheTiger               = 196607,
                    fistOfTheWhiteTiger         = 261947,
                    goodKarma                   = 280195,
                    hitCombo                    = 196740,
                    innerStrength               = 261767,
                    invokeXuenTheWhiteTiger     = 123904,
                    rushingJadeWind             = 116847,
                    serenity                    = 152173,
                    spiritualFocus              = 280197,
                    whirlingDragonPunch         = 152175,
                },
                traits                          = {
                    swiftRoundhouse             = 277669,
                }
            },
            -- All
            Shared = {
                abilities                       = {
                    blackoutKick                = 100784,
                    chiBurst                    = 123986,
                    chiTorpedo                  = 115008,
                    cracklingJadeLightning      = 117952,
                    dampenHarm                  = 122278,
                    diffuseMagic                = 122783,
                    legSweep                    = 119381,
                    paralysis                   = 115078,
                    provoke                     = 115546,
                    resuscitate                 = 115178,
                    ringOfPeace                 = 116844,
                    roll                        = 109132,
                    tigersLust                  = 116841,
                    tigerPalm                   = 100780,
                    vivify                      = 116670,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    blackoutKick                = 116768,
                    danceOfChiJi                = 286587,
                    dampenHarm                  = 122278,
                    diffuseMagic                = 122783,
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                items                           = {
                    drinkingHornCover           = 137097,
                    hiddenMastersForbiddenTouch = 137057,
                    theEmperorsCapacitor        = 144239,
                },
                talents                         = {
                    celerity                    = 115173,
                    chiBurst                    = 123986,
                    chiTorpedo                  = 115008,
                    chiWave                     = 115098,
                    dampenHarm                  = 122278,
                    ringOfPeace                 = 116844,
                    tigerTailSweep              = 264348,
                    tigersLust                  = 116841,
                },
            },
        },
        PALADIN = {
            -- Holy
            [65] = {
                abilities                       = {
                    absolution                  = 212056,
                    auraMastery                 = 31821,
                    beaconOfLight               = 53563,
                    blessingOfSacrifice         = 6940,
                    cleanse                     = 4987,
                    consecration                = 26573,
                    divineProtection            = 498,
                    holyLight                   = 82326,
                    holyShock                   = 20473,
                    judgment                    = 275773,
                    lightOfDawn                 = 85222,
                    lightOfTheMartyr            = 183998,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    auraOfMercy                 = 183415,
                    auraMastery                 = 31821,
                    avengingWrath               = 31884,
                    beaconOfLight               = 53563,
                    beaconOfFaith               = 156910,
                    blessingOfSacrifice         = 6940,
                    beaconOfVirtue              = 200025,
                    bestowFaith                 = 223306,
                    divineProtection            = 498,
                    divinePurpose               = 216411,
                    ferventMartyr               = 223316,
                    infusionOfLight             = 54149,
                    holyAvenger                 = 105809,
                    ruleOfLaw                   = 214202,
                    theLightSaves               = 200423,
                    vindicator                  = 200376,
                    avengingCrusader            = 216331,
                },
                debuffs                         = {
                    judgement                   = 214222,
                    judgmentoflight             = 196941,
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    auraOfMercy                 = 183415,
                    auraOfSacrifice             = 183416,
                    avengingCrusader            = 216331,
                    awakening                   = 248033,
                    beaconOfFaith               = 156910,
                    beaconOfVirtue              = 200025,
                    bestowFaith                 = 223306,
                    crusadersMight              = 196926,
                    devotionAura                = 183425,
                    divinePurpose               = 197646,
                    fistOfJustice               = 198054,
                    holyAvenger                 = 105809,
                    holyPrism                   = 114165,
                    judgmentOfLight             = 183778,
                    lightsHammer                = 114158,
                    ruleOfLaw                   = 214202,
                    sanctifiedWrath             = 53376,
                },
                traits                          = {
                    breakingDawn                = 278594,
                    graceoftheJusticar          = 278593,
                },
            },
            -- Protection
            [66] = {
                abilities                       = {
                    ardentDefender              = 31850,
                    avengersShield              = 31935,
                    blessingOfSacrifice         = 6940,
                    cleanseToxins               = 213644,
                    consecration                = 26573,
                    divineProtection            = 498,
                    guardianOfAncientKings      = 86659,
                    hammerOfTheRighteous        = 53595,
                    judgment                    = 275779,
                    lightOfTheProtector         = 184092,
                    rebuke                      = 96231,
                    righteousFury               = 25780,
                    shieldOfTheRighteous        = 53600,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    ardentDefender              = 31850,
                    avengingWrath               = 31884,
                    bulwarkOfOrder              = 209388,
                    consecration                = 188370,
                    guardianOfAncientKings      = 86659,
                    seraphim                    = 152262,
                    shieldOfTheRighteous        = 132403,
                    avengersValor               = 197561,
                },
                debuffs                         = {
                    blessedHammer               = 204301,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    aegisOfLight                = 204150,
                    bastionOfLight              = 204035,
                    blessedHammer               = 204019,
                    blessingOfSpellwarding      = 204018,
                    consecratedGround           = 204054,
                    crusadersJudgment           = 204023,
                    finalStand                  = 204077,
                    firstAvenger                = 203776,
                    fistOfJustice               = 198054,
                    handOfTheProtector          = 213652,
                    holyShield                  = 152261,
                    judgmentOfLight             = 183778,
                    lastDefender                = 203791,
                    redoubt                     = 280373,
                    retributionAura             = 203797,
                    righteousProtector          = 204074,
                    seraphim                    = 152262,
                },
            },
            -- Retribution
            [70] = {
                abilities                       = {
                    bladeOfJustice              = 184575,
                    cleanseToxins               = 213644,
                    divineStorm                 = 53385,
                    greaterBlessingOfKings      = 203538,
                    greaterBlessingOfWisdom     = 203539,
                    handOfHinderance            = 183218,
                    judgment                    = 20271,
                    rebuke                      = 96231,
                    shieldOfVengeance           = 184662,
                    templarsVerdict             = 85256,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    avengingWrath               = 31884,
                    crusade                     = 231895,
                    divinePurpose               = 223819,
                    divineRight                 = 278523,
                    divineSteed                 = 221886,
                    empyreanPower               = 286393,
                    greaterBlessingOfKings      = 203538,
                    greaterBlessingOfWisdom     = 203539,
                    inquisition                 = 84963,
                    selflessHealer              = 114250,
                    theFiresOfJustice           = 209785,
                },
                debuffs                         = {
                    executionSentence           = 267798,
                    judgment                    = 197277,
                },
                glyphs                          = {
                    glyphOfWingedVengeance      = 57979,
                },
                talents                         = {
                    bladeOfWrath                = 231832,
                    consecration                = 205228,
                    crusade                     = 231895,
                    divineJudgment              = 271580,
                    divinePurpose               = 223817,
                    executionSentence           = 267798,
                    eyeForAnEye                 = 205191,
                    firesOfJustice              = 203316,
                    fistOfJustice               = 234299,
                    hammerOfWrath               = 24275,
                    inquisition                 = 84963,
                    justicarsVengeance          = 215661,
                    righteousVerdict            = 267610,
                    selflessHealer              = 85804,
                    wakeOfAshes                 = 255937,
                    wordOfGlory                 = 210191,
                    zeal                        = 269569,
                },
                traits                          = {
                    divineRight                 = 278523,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    avengingWrath               = 31884,
                    blessingOfFreedom           = 1044,
                    blessingOfProtection        = 1022,
                    contemplation               = 121183,
                    crusaderStrike              = 35395,
                    divineShield                = 642,
                    divineSteed                 = 190784,
                    flashOfLight                = 19750,
                    hammerOfJustice             = 853,
                    handOfReckoning             = 62124,
                    layOnHands                  = 633,
                    redemption                  = 7328,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    divineShield                = 642,
                    divineSteed                 = 190784,
                    blessingOfProtection        = 1022,
                },
                debuffs                         = {
                    forbearance                 = 25771,
                },
                glyphs                          = {
                    glyphOfFireFromHeavens      = 57954,
                    glyphOfPillarOfLight        = 146959,
                    glyphOfTheLuminousCharger   = 89401,
                    glyphOfTheQueen             = 212642,
                },
                talents                         = {
                    blindingLight               = 115750,
                    cavalier                    = 230332,
                    repentance                  = 20066,
                    unbreakableSpirit           = 114154,
                },
            },
        },
        PRIEST = {
            -- Discipline
            [256] = {
                abilities                       = {
                    angelicFeather              = 121536,
                  --clarityOfWill               = 152118,
                    divineStar                  = 110744,
                    desperatePrayer             = 19236,
                    evangelism                  = 246287,
                    halo                        = 120517,
                    leapOfFaith                 = 73325,
                    luminousBarrier             = 271466,
                    mindbender                  = 123040,
                    mindControl                 = 205364,
                    mindVision                  = 2096,
                    painSuppression             = 33206,
                    penance                     = 47540,
                  --plea                        = 200829,
                  --powerInfusion               = 10060,
                    powerWordBarrier            = 62618,
                    powerWordRadiance           = 194509,
                    powerWordShield             = 17,
                    powerWordSolace             = 129250,
                    psychicScream               = 8122,
                    purgeTheWicked              = 204197,
                    purify                      = 527,
                    rapture                     = 47536,
                    schism                      = 214621,
                    shadowCovenant              = 204065,
                    shadowfiend                 = 34433,
                    shadowMend                  = 186263,
                    shadowWordPain              = 589,
                    shiningForce                = 204263,
                    sinsOfTheMany               = 198076,
                    smite                       = 585,
                },
                artifacts                       = {
                  --sinsOfTheMany               = 198074,
                },
                buffs                           = {
                    angelicFeather              = 121557,
                    atonement                   = 194384,
                    bodyAndSoul                 = 65081,
                    borrowedTime                = 197763,
                  --clarityOfWill               = 152118,
                    innervate                   = 29166,
                    overloadedWithLight         = 223166,
                    penitent                    = 246519,
                  --powerInfusion               = 10060,
                    powerOfTheDarkSide          = 198069,
                    powerWordShield             = 17,
                    rapture                     = 47536,
                    speedOfThePious             = 197767,
                    symbolOfHope                = 64901,
                },
                debuffs                         = {
                    purgeTheWicked              = 204213,
                    schism                      = 214621,
                    shadowWordPain              = 589,
                    smite                       = 585,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    angelicFeather              = 121536,
                    bodyAndSoul                 = 64129,
                    castigation                 = 193134,
                  --clarityOfWill               = 152118,
                    contrition                  = 197419,
                    divineStar                  = 110744,
                    dominantMind                = 205367,
                    evangelism                  = 246287,
                  --grace                       = 200309,
                    halo                        = 120517,
                    masochism                   = 193063,
                    mindbender                  = 123040,
                    luminousBarrier             = 271466,
                    --powerInfusion               = 10060,
                    powerWordSolace             = 129250,
                    purgeTheWicked              = 204197,
                    psychicVoice                = 196704,
                    schism                      = 214621,
                    shadowCovenant              = 204065,
                    shieldDiscipline            = 197045,
                    sinsOfTheMany               = 280391,
                    shiningForce                = 204263,
                  --thePenitent                 = 200347,
                    twistOfFate                 = 265259,
                },
                traits                          = {
                    giftOfForgiveness           = 277680,
                },
            },
            -- Holy
            [257] = {
                abilities                       = {
                    angelicFeather              = 121536,
                    bodyAndMind                 = 214121,
                    desperatePrayer             = 19236,
                    divineHymn                  = 64843,
                    divineStar                  = 110744,
                    flashHeal                   = 2061,
                    guardianSpirit              = 47788,
                    holyFire                    = 14914,
                    holyNova                    = 132157,
                    holyWordChastise            = 88625,
                    holyWordSanctify            = 34861,
                    holyWordSerenity            = 2050,
                    holyWordSalvation           = 265202,
                    heal                        = 2060,
                    leapOfFaith                 = 73325,
                    lightOfTuure                = 33076,
                    prayerOfHealing             = 596,
                    prayerOfMending             = 33076,
                    purify                      = 527,
                    renew                       = 139,
                    smite                       = 585,
                    symbolOfHope                = 64901,
                },
                artifacts                       = {
        --                lightOfTuure                = 208065,
                },
                buffs                           = {
                    angelicFeather              = 121557,
                    blessingOfTuure             = 196578,
                    divinity                    = 197031,
                    echoOfLight                 = 77489,
                    powerOfTheNaaru             = 196489,
                    prayerOfMending             = 41635,
                    renew                       = 139,
                    surgeOfLight                = 109186,
                    spiritOfRedemption          = 27827,
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    angelicFeather              = 121536,
                    apotheosis                  = 200183,
                    bindingHeal                 = 32546,
                    --bodyAndMind                 = 214121,
                    circleOfHealing             = 204883,
                    divineStar                  = 110744,
                    --divinity                    = 197031,
                    halo                        = 120517,
                    --piety                       = 197034,
                    shiningForce                = 204263,
                    surgeOfLight                = 109186,
                    --symbolOfHope                = 64901,
                },
            },
            -- Shadow
            [258] = {
                abilities                       = {
                    darkAscension               = 280711,
                    dispersion                  = 47585,
                    mindBlast                   = 8092,
                    mindBomb                    = 205369,
                    mindbender                  = 200174,
                    mindFlay                    = 15407,
                    mindSear                    = 48045,
                    mindVision                  = 2096,
                    powerInfusion               = 10060,
                    powerWordShield             = 17,
                    psychicHorror               = 64044,
                    psychicScream               = 8122,
                    purifyDisease               = 213634,
                    shadowCrash                 = 205385,
                    shadowMend                  = 186263,
                    shadowWordDeath             = 32379,
                    shadowWordPain              = 589,
                    shadowWordVoid              = 205351,
                    shadowfiend                 = 34433,
                    shadowform                  = 232698,
                    silence                     = 15487,
                    surrenderToMadness          = 193223,
                    vampiricEmbrace             = 15286,
                    vampiricTouch               = 34914,
                    voidBolt                    = 205448,
                    voidEruption                = 228260,
                    voidForm                    = 228264,
                },
                artifacts                       = {
                    lashOfInsanity              = 238137,
                    massHysteria                = 194378,
                    sphereOfInsanity            = 194179,
                    toThePain                   = 193644,
                    touchOfDarkness             = 194007,
                    unleashTheShadows           = 194093,
                    voidCorruption              = 194016,
                    voidTorrent                 = 205065,
                },
                buffs                           = {
                    dispersion                  = 47585,
                    harvestedThoughts           = 288343,
                    powerWordShield             = 17,
                    powerInfusion               = 10060,
                    shadowyInsight              = 124430,
                    shadowform                  = 232698,
                    surrenderedSoul             = 212570,
                    surrenderToMadness          = 193223,
                    thoughtsHarvester           = 288340,
                    void                        = 211657,
                    voidForm                    = 194249,
                    voidTorrent                 = 205065,
                    zeksExterminatus            = 236546, -- Legendary Cloak proc
                },
                debuffs                         = {
                    mindFlay                    = 15407,
                    shadowWordPain              = 589,
                    vampiricTouch               = 34914,
                    weakenedSoul                = 6788,
    
                },
                glyphs                          = {
    
                },
                talents                         = {
                    auspiciousSpirits           = 155271,
                    bodyAndSoul                 = 64129,
                    darkVoid                    = 263346,
                    darkAscension               = 280711,
                    --dominantMind                = 205367,
                    fortressOfTheMind           = 193195,
                    legacyOfTheVoid             = 193225,
                    lingeringInsanty            = 199849,
                    --mania                       = 193173,
                    --masochism                   = 193063,
                    mindBomb                    = 205369,
                    mindbender                  = 200174,
                    misery                      = 238558,
                    --powerInfusion               = 10060,
                    psychicHorror               = 64044,
                    --psychicVoice                = 196704,
                    --reaperOfSouls               = 199853,
                    sanlayn                     = 199855,
                    shadowCrash                 = 205385,
                    shadowWordDeath             = 32379,
                    shadowWordVoid              = 205351,
                    shadowyInsight              = 162452,
                    surrenderToMadness          = 193223,
                    twistOfFate                 = 109142,
                    --voidRay                     = 205371,
                    voidTorrent                 = 263165,
                },
                traits                          = {
                    chorusOfInsanity            = 278661,
                    deathThroes                 = 278659,
                    searingDialogue             = 272788,
                    spitefulApparitions         = 277682,
                    thoughtHarvester            = 288340,
                    whispersOfTheDamned         = 275722,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    dispelMagic                 = 528,
                    fade                        = 586,
                    levitate                    = 1706,
                    massDispel                  = 32375,
                    massResurrection            = 212036,
                    mindControl                 = 605,
                    powerWordFortitude          = 21562,
                    resurrection                = 2006,
                    shackleUndead               = 9484,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    classHallSpeed              = 224098,
                    powerWordFortitude          = 21562,
                    
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
    
                },
            },
        },
        ROGUE = {
            -- Assassination
            [259] = {
                abilities                       = {
                    blindside                   = 111240,
                    crimsonTempest              = 121411,
                    cripplingPoison             = 3408,
                    deadlyPoison                = 2823,
                    envenom                     = 32645,
                    evasion                     = 5277,
                    eviscerate                  = 196819,
                    exsanguinate                = 200806,
                    fanOfKnives                 = 51723,
                    garrote                     = 703,
                    kidneyShot                  = 408,
                    mutilate                    = 1329,
                    poisonedKnife               = 185565,
                    rupture                     = 1943,
                    shadowstep                  = 36554,
                    sinisterStrike              = 1752,
                    toxicBlade                  = 245388,
                    vendetta                    = 79140,
                    woundPoison                 = 8679,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    blindside                   = 111240,
                    cripplingPoison             = 3408,
                    deadlyPoison                = 2823,
                    elaboratePlanning           = 193641,
                    envenom                     = 32645,
                    hiddenBlades                = 270070,
                    leechingPoison              = 108211,
                    sharpenedBlades             = 272916,
                    masterAssassin              = 256735,
                    stealth                     = 1784 or 115191,
                    subterfuge                  = 115192,
                    theDreadlordsDeceit         = 208692,
                    woundPoison                 = 8679,
                },
                debuffs                         = {
                    crimsonTempest              = 121411,
                    cripplingPoison             = 3409,
                    deadlyPoison                = 2818,
                    garrote                     = 703,
                    internalBleeding            = 154953,
                    kidneyShot                  = 408,
                    rupture                     = 1943,
                    surgeOfToxins               = 192425,
                    toxicBlade                  = 245389,
                    vendetta                    = 79140,
                    woundPoison                 = 8680,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    blindside                   = 111240,
                    crimsonTempest              = 121411,
                    elaboratePlanning           = 193640,
                    elusiveness                 = 79008,
                    exsanguinate                = 200806,
                    hiddenBlades                = 270061,
                    internalBleeding            = 154904,
                    ironWire                    = 196861,
                    leechingPoison              = 280716,
                    masterAssassin              = 255989,
                    masterPoisoner              = 196864,
                    nightstalker                = 14062,
                    poisonBomb                  = 255544,
                    subterfuge                  = 108208,
                    toxicBlade                  = 245388,
                    venomRush                   = 152152,
                },
                traits                          = {
                    doubleDose                  = 273007,
                    echoingBlades               = 287649,
                    sharpenedBlades             = 272911,
                    shroudedSuffocation         = 278666,
                }
            },
            -- Outlaw
            [260] = {
                abilities                       = {
                    adrenalineRush              = 13750,
                    ambush                      = 8676,
                    betweenTheEyes              = 199804,
                    bladeFlurry                 = 13877,
                    bladeRush                   = 271877,
                    blind                       = 2094,
                    curseOfTheDreadblades       = 202665,
                    dispatch                    = 2098,
                    ghostlyStrike               = 196937,
                    gouge                       = 1776,
                    grapplingHook               = 195457,
                    killingSpree                = 51690,
                    masteryMainGauche           = 76806,
                    pistolShot                  = 185763,
                    riposte                     = 199754,
                    rollTheBones                = 193316,
                    sinisterStrike              = 193315,
                    stealth                     = 1784,
                },
                artifacts                       = {
                    blackPowder                 = 216230,
                    bladeDancer                 = 202507,
                    bladeMaster                 = 202628,
                    blunderbuss                 = 202897,
                    blurredTime                 = 202769,
                    cannonballBarrage           = 185767,
                    curseOfTheDreadblades       = 202665,
                    cursedEdge                  = 202463,
                    cursedSteel                 = 214929,
                    deception                   = 202755,
                    fatesThirst                 = 202514,
                    fatebringer                 = 202524,
                    fortuneStrikes              = 202530,
                    fortunesBoon                = 202907,
                    fortunesStrike              = 202521,
                    ghostlyShell                = 202533,
                    greed                       = 202820,
                    gunslinger                  = 202522,
                    hiddenBlade                 = 202573,
                    killingSpree                = 51690,
                    loadedDice                  = 238139,
                },
                buffs                           = {
                    adrenalineRush              = 13750,
                    alacrity                    = 193538,
                    bladeFlurry                 = 13877,
                    blunderbuss                 = 202895,
                    broadside                   = 193356,
                    buriedTreasure              = 199600,
                    deadShot                    = 272940,
                    grandMelee                  = 193358,
                    greenskinsWaterloggedWristcuffs = 209420,
                    hiddenBlade                 = 202754,
                    jollyRoger                  = 199603,
                    loadedDice                  = 256171,
                    opportunity                 = 195627,
                    ruthlessPrecision           = 193357,
                    rollTheBones                = {
                        broadside                   = 193356,
                        buriedTreasure              = 199600,
                        grandMelee                  = 193358,
                        ruthlessPrecision           = 193357,
                        skullAndCrossbones          = 199603,
                        trueBearing                 = 193359,
                    },
                    sharkInfestedWaters         = 193357,
                    skullAndCrossbones          = 199603,
                    sliceAndDice                = 5171,
                    snakeeeyes                  = 275863,
                    stealth                     = 1784,
                    swordplay                   = 211669,
                    trueBearing                 = 193359,
                    wits                        = 288988,
                },
                debuffs                         = {
                    ghostlyStrike               = 196937,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    acrobaticStikes             = 196924,
                    dirtyTricks                 = 108216,
                    bladeRush                   = 271877,
                    ghostlyStrike               = 196937,
                    grapplingHook               = 256188,
                    hitAndRun                   = 196922,
                    ironStomach                 = 193546,
                    killingSpree                = 51690,
                    sliceAndDice                = 5171,
                    weaponmaster                = 200733,
                    quickDraw                   = 196938,
                },
                 traits                          = {
                    deadshot                    = 272935,
                    aceupyoursleeve             = 278676,
                    snakeeyes                   = 275846,
                },
            },
            -- Subtlety
            [261] = {
                abilities                       = {
                    backstab                    = 53,
                    evasion                     = 5277,
                    eviscerate                  = 196819,
                    gloomblade                  = 200758,
                    kidneyShot                  = 408,
                    nightblade                  = 195452,
                    shadowBlades                = 121471,
                    shadowDance                 = 185313,
                    shadowstep                  = 36554,
                    shadowstrike                = 185438,
                    shurikenStorm               = 197835,
                    shurikenToss                = 114014,
                    symbolsOfDeath              = 212283,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    masterOfShadows             = 196980,
                    nightsVengeance             = 273424,
                    shadowBlades                = 121471,
                    shadowDance                 = 185422,
                    sharpenedBlades             = 272916,
                    shurikenCombo               = 245640,
                    shurikenTornado             = 277925,
                    subterfuge                  = 115192,
                    symbolsOfDeath              = 212283,
                    theDreadlordsDeceit         = 228224,
                },
                debuffs                         = {
                    findWeakness                = 91021,
                    nightblade                  = 195452,
                    shadowsGrasp                = 206760,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    alacrity                    = 193539,
                    darkShadow                  = 245687,
                    envelopingShadows           = 238104,
                    findWeakness                = 91023,
                    gloomblade                  = 200758,
                    masterOfShadows             = 196976,
                    nightTerrors                = 277953,
                    nightstalker                = 14062,
                    secretTechnique             = 280719,
                    shadowFocus                 = 108209,
                    shotInTheDark               = 257505,
                    shurikenTornado             = 277925,
                    soothingDarkness            = 200759,
                    subterfuge                  = 108208,
                    weaponmaster                = 193537,
                },
                traits                          = {
                    bladeInTheShadows           = 275896,
                    nightsVengeance             = 273418,
                    replicatingShadows          = 286121,
                    sharpenedBlades             = 272911,
                    theFirstDance               = 278681
                }
            },
            -- All
            Shared = {
                abilities                       = {
                    blind                       = 2094,
                    cheapShot                   = 1833,
                    cloakOfShadows              = 31224,
                    crimsonVial                 = 185311,
                    detection                   = 56814 or 210108,
                    distract                    = 1725,
                    feint                       = 1966,
                    kick                        = 1766,
                    markedForDeath              = 137619,
                    pickLock                    = 1804,
                    pickPocket                  = 921,
                    sap                         = 6770,
                    shadowmeld                  = 58984,
                    sprint                      = 2983,
                    stealth                     = 115191,
                    tricksOfTheTrade            = 57934,
                    vanish                      = 1856,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    cloakOfShadows              = 31224,
                    deathFromAbove              = 152150,
                    feint                       = 1966,
                    masterAssassinsInitiative   = 235027, --235022
                    sprint                      = 2983,
                    stealth                     = 115191,
                    vanish                      = 11327 or 115193,
                },
                debuffs                         = {
                    cheapShot                   = 1833,
                    markedForDeath              = 137619,
                    sap                         = 6770,
                },
                glyphs                          = {
                    glyphOfBlackout             = 219693,
                    glyphOfBurnout              = 220279,
                    glyphOfDisguise             = 63268,
                    glyphOfFlashBang            = 219678,
                },
                talents                         = {
                    cheatDeath                  = 31230,
                    deeperStratagem             = 193531,
                    elusiveness                 = 79008,
                    markedForDeath              = 137619,
                    preyOnTheWeak               = 131511,
                    vigor                       = 14983,
                },
            },
        },
        SHAMAN = {
            -- Elemental
            [262] = {
                abilities                       = {
                    ancestralGuidance           = 108281,
                    ascendance                  = 114050,
                    chainLightning              = 188443,
                    earthElemental              = 198103,
                    earthquake                  = 61882,
                    earthShield                 = 974,
                    earthShock                  = 8042,
                    elementalBlast              = 117014,
                    --elementalMastery            = 16166,
                    eyeOfTheStorm               = 157375,
                    fireBlast                   = 57984,
                    fireElemental               = 198067,
                    flameShock                  = 188389,
                    frostShock                  = 196840,
                    --gustOfWind                  = 192063,
                    hardenSkin                  = 118337,
                    healingSurge                = 8004,
                    iceFury                     = 210714,
                    immolate                    = 118297,
                    lavaBeam                    = 114074,
                    lavaBurst                   = 51505,
                    lightningBolt               = 188196,
                    liquidMagmaTotem            = 192222,
                    meteor                      = 117588,
                    pulverize                   = 118345,
                    stormElemental              = 192249,
                    stormKeeper                 = 191634,
                    thunderstorm                = 51490,
                    totemMastery                = 210643,
                    windGust                    = 157331,
                },
                artifacts                       = {
                    seismicStorm                = 238141,
                    stormkeeper                 = 205495,
                    swellingMaelstrom           = 238105,
                },
                buffs                           = {
                    ascendance                  = 114050,
                    bloodlust                   = 2825,
                    earthShield                 = 974,
                    echoesOfTheGreatSundering   = 208722,
                    elementalFocus              = 16164,
                    elementalMastery            = 16166,
                    emberTotem                  = 210658,
                    hardenSkin                  = 118337,
                    heroism                     = 32182,
                    iceFury                     = 210714,
                    lavaSurge                   = 77762,
                    masterOfTheElements         = 260734,
                    powerOfTheMaelstrom         = 191877,
                    resonanceTotem              = 202192,
                    stormKeeper                 = 191634,
                    stormTotem                  = 210652,
                    surgeOfPower                = 285514,
                    tailwindTotem               = 210659,
                    windGust                    = 263806,
                },
                debuffs                         = {
                    flameShock                  = 188389,
                    frostShock                  = 196840,
                    immolate                    = 118297,
                    lightningRod                = 197209,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    aftershock                  = 273221,
                    ancestralGuidance           = 108281,
                    --ancestralSwiftness          = 192087,
                    ascendance                  = 114050,
                    callTheThunder              = 260897,
                    earthenRage                 = 170374,
                    echoOfTheElements           = 108283,
                    elementalBlast              = 117014,
                    --elementalFusion             = 192235,
                    --elementalMastery            = 16166,
                    --gustOfWind                  = 192063,
                    iceFury                     = 210714,
                    --lightningRod                = 210689,
                    liquidMagmaTotem            = 192222,
                    masterOfTheElements         = 16166,
                    --pathOfFlame                 = 201909,
                    primalElementalist          = 117013,
                    stormElemental              = 192249,
                    stormKeeper                 = 191634,
                    surgeOfPower                = 262303,
                    totemMastery                = 210643,
                },
                traits                          = {
                    naturalHarmony              = 278697,
                },
            },
            -- Enhancement
            [263] = {
                abilities                       = {
                    ascendance                  = 114051,
                    cleanseSpirit               = 51886,
                    crashLightning              = 187874,
                    earthShield                 = 974,
                    earthenSpike                = 188089,
                    feralLunge                  = 196884,
                    feralSpirit                 = 51533,
                    flametongue                 = 193796,
                    frostbrand                  = 196834,
                    furyOfAir                   = 197211,
                    healingSurge                = 188070,
                    lavaLash                    = 60103,
                    lightningBolt               = 187837,
                    lightningShield             = 192106,
                    rockbiter                   = 193786,
                    spiritWalk                  = 58875,
                    stormstrike                 = 17364,
                    sundering                   = 197214,
                    totemMastery                = 262395,
                    windstrike                  = 115356, --17364,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    ascendance                  = 114051,
                    crashLightning              = 187878,
                    earthShield                 = 974,
                    flametongue                 = 194084,
                    forcefulWinds               = 262652,
                    frostbrand                  = 196834,
                    furyOfAir                   = 197211,
                    gatheringStorms             = 198300,
                    hailstorm                   = 210853,
                    hotHand                     = 215785,
                    landslide                   = 202004,
                    lightningCrash              = 242284, -- T20 - 2 piece buff
                    lightningShield             = 192106,
                    lightningShieldOvercharge   = 273323,
                    naturalHarmonyFrost         = 279029,
                    oldWar                      = 188028,
                    prolongedPower              = 229206,
                    resonanceTotem              = 262417,
                    stormbringer                = 201846,
                    strengthOfTheEarth          = 273465,
                },
                debuffs                         = {
                    earthenSpike                = 188089,
                    frostbrand                  = 147732,
                    lightningConduit            = 275391,
                    primalPrimer                = 273006,
                    searingAssault              = 268429,
                    stormTempests               = 214265,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    ascendance                  = 114051,
                    boulderfist                 = 246035, -- 201897, Changed to Passive in Patch 7.2.5
                    crashingStorm               = 192246,
                    earthenSpike                = 188089,
                    elementalSpirits            = 262624,
                    feralLunge                  = 196884,
                    forcefulWinds               = 262647,
                    furyOfAir                   = 197211,
                    hailstorm                   = 210853,
                    hotHand                     = 201900,
                    landslide                   = 197992,
                    lightningShield             = 192106,
                    overcharge                  = 210727,
                    searingAssault              = 192087,
                    sundering                   = 197214,
                    totemMastery                = 262395,
                },
                traits                          = {
                    lightningConduit            = 275389,
                    naturalHarmony              = 278697,
                    primalPrimer                = 272992,
                },
            },
            -- Restoration
            [264] = {
                abilities                       = {
                 --   ancestralGuidance           = 108281,
                    ancestralProtectionTotem    = 207399,
                    ascendance                  = 114052,
                    chainHeal                   = 1064,
                    chainLightning              = 421,
                    cloudburstTotem             = 157153,
                    downpour                    = 207778,
                    earthShield                 = 974,
                    earthenWallTotem            = 198838,
                    flameShock                  = 188838,
                  --  giftOfTheQueen              = 207778,
                    healingRain                 = 73920,
                    healingSurge                = 8004,
                    healingStreamTotem          = 5394,
                    healingTideTotem            = 108280,
                    healingWave                 = 77472,
                    heroism                     = 32182,
                    lavaBurst                   = 51505,
                    lightningBolt               = 403,
                    purifySpirit                = 77130,
                    riptide                     = 61295,
                    spiritLinkTotem             = 98008,
                    spiritwalkersGrace          = 79206,
                    wellspring                  = 197995,
                },
                artifacts                       = {
                 --   giftOfTheQueen              = 207778,
                },
                buffs                           = {
                    ascendance                  = 114052,
                    cloudburstTotem             = 157504,
                    earthShield                 = 974,
                    healingRain                 = 73920,
                    jonatsFocus                 = 210607,
                    lavaSurge                   = 77762,
                    riptide                     = 61295,
                    tidalWaves                  = 53390,
                    unleashLife                 = 73685,
                    spiritwalkersGrace          = 79206,
                },
                debuffs                         = {
                    flameShock                  = 188838,
                },
                glyphs                          = {
                },
                talents                         = {
                    --ancestralGuidance           = 108281,
                    ancestralProtectionTotem    = 207399,
                    ascendance                  = 114052,
                    cloudburstTotem             = 157153,
                    downpour                    = 207778,
                    earthenWallTotem          = 198838,
                    earthShield                 = 974,
                    echoOfTheElements           = 108283,
                   -- gustOfWind                  = 192063,
                    highTide                    = 157154,
                    unleashLife                 = 73685,
                    wellspring                  = 197995,
                    windRushTotem               = 192077,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    ancestralSpirit             = 2008,
                    astralShift                 = 108271,
                    capacitorTotem              = 192058,
                    earthElemental              = 198103,
                    earthbindTotem              = 2484,
                    ghostWolf                   = 2645,
                    hex                         = 51514,
                    purge                       = 370,
                    tremorTotem                 = 8143,
                    waterWalking                = 546,
                    windRushTotem               = 192077,
                    windShear                   = 57994,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    astralShift                 = 108271,
                    ghostWolf                   = 2645,
                    waterWalking                = 546,
                },
                debuffs                         = {
                    hex                         = 51514,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    earthShield                 = 974,
                    naturesGuardian             = 30884,
                    spiritWolf                  = 260878,
                    staticCharge                = 265046,
                    windRushTotem               = 192077,
                },
            },
        },
        WARLOCK = {
            -- Affliction
            [265] = {
                abilities                       = {
                    agony                       = 980,
                    commanddemon                = 119898,
                    corruption                  = 172,
                    darkSoul                    = 113860,
                    deathbolt                   = 264106,
                    drainLife                   = 234153,
                    drainSoul                   = 198590,
                    grimoireOfSacrifice         = 108503,
                    haunt                       = 48181,
                    howlOfTerror                = 5484,
                    phantomSingularity          = 205179,
                    reapSouls                   = 216698,
                    seedOfCorruption            = 27243,
                    shadowBolt                  = 232670,
                    shadowLock                  = 171138,
                    siphonLife                  = 63106,
                    spellLock                   = 19647,
                    spellLockgrimoire           = 132409,
                    soulEffigy                  = 205178,
                    summonDarkglare             = 205180,
                    unstableAffliction          = 30108,
                    vileTaint                   = 278350,
                },
                artifacts                       = {
                    compoundingHorror           = 199282,
                    crystallineShadows          = 221862,
                    drainedToAHusk              = 199120,
                    fatalEchoes                 = 199257,
                    harvesterOfSouls            = 201424,
                    hideousCorruption           = 199112,
                    inherentlyUnstable          = 199152,
                    inimitableAgony             = 199111,
                    longDarkNightOfTheSoul      = 199214,
                    perdition                   = 199158,
                    reapSouls                   = 216698,
                    seedsOfDoom                 = 199153,
                    shadowsOfTheFlesh           = 199212,
                    shadowyIncantations         = 199163,
                    soulFlame                   = 199471,
                    soulstealer                 = 214934,
                    sweetSouls                  = 199220,
                    wrathOfConsumption          = 199472,
                },
                buffs                           = {
                    cascadingCalamity           = 275378,
                    compoundingHorror           = 199281,
                    deadwindHarvester           = 216708,
                    demonicPower                = 196099,
                    empoweredLifeTap            = 235156,
                    nightfall                   = 264571,
                    tormentedSouls              = 216695,
                    wrathOfConsumption          = 199646,
                    inevitableDemise            = 273525,
                },
                debuffs                         = {
                    agony                       = 980,
                    corruption                  = 146739,
                    haunt                       = 48181,
                    seedOfCorruption            = 27243,
                    shadowEmbrace               = 32388,
                    siphonLife                  = 63106,
                    unstableAffliction1         = 233490,
                    unstableAffliction2         = 233496,
                    unstableAffliction3         = 233497,
                    unstableAffliction4         = 233498,
                    unstableAffliction5         = 233499,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    absoluteCorruption          = 196103,
                    creepingDeath               = 264000,
                    darkSoul                    = 113860,
                    deathbolt                   = 264106,
                    drainSoul                   = 198590,
                    grimoireOfSacrifice         = 108503,
                    haunt                       = 48181,
                    phantomSingularity          = 205179,
                    shadowEmbrace               = 32388,
                    siphonLife                  = 63106,
                    soulConduit                 = 215941,
                    sowTheSeeds                 = 196226,
                    vileTaint                   = 278350,
                    writheInAgony               = 196102,
                },
                traits                          = {
                    cascadingCalamity           = 275372,
                }
            },
            -- Demonology
            [266] = {
                abilities                       = {
                    bilescourgeBombers          = 267211,
                    callDreadstalkers           = 104316,
                    commandDemon                = 119898,
                    demonbolt                   = 264178,
                    demonicEmpowerment          = 193396,
                    demonicStrength             = 267171,
                    demonwrath                  = 193440,
                    doom                        = 603,
                    drainLife                   = 234153,
                    felstorm                    = 89751,
                    grimoireFelguard            = 111898,
                    handOfGuldan                = 105174,
                    implosion                   = 196277,
                    netherPortal                = 267217,
                    powerSiphon                 = 264130,
                    shadowBolt                  = 686,
                    shadowflame                 = 205181,
                    shadowLock                  = 171138,
                    soulStrike                  = 264057,
                    spellLock                   = 19647,
                    summonDarkglare             = 205180,
                    summonDemonicTyrant         = 265187,
                    summonVilefiend             = 264119,
                    thalkielsConsumption        = 211714,
                },
                artifacts                       = {
                    thalkielsAscendance         = 238145,
                    thalkielsConsumption        = 211714,
                    
                },
                buffs                           = {
                    demonicCalling              = 205146,
                    demonicCore                 = 264173,--267102,
                    demonicEmpowerment          = 193396,
                    demonicPower                = 265273,
                    demonwrath                  = 193440,
                    forbiddenKnowledge          = 278738,
                    netherPortal                = 267218,
                    shadowyInspiration          = 196269,
                    shadowsBite                 = 272945,
                    explosivePotential          = 275398,
                },
                debuffs                         = {
                    doom                        = 603,
                    shadowflame                 = 205181,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    bilescourgeBombers          = 267211,
                    demonicStrength             = 267171,
                    doom                        = 265412,
                    netherPortal                = 267217,
                    powerSiphon                 = 264130,
                    soulStrike                  = 264057,
                    summonVilefiend             = 264119,
                    demonicConsumption          = 267215,
    
                },
                traits                          = {
                    explosivePotential          = 275395,
                    shadowsBite                 = 272944,
                    baleful_invocation          = 287059,
                    
                }
            },
            -- Destruction
            [267] = {
                abilities                       = {
                    cataclysm                   = 152108,
                    channelDemonfire            = 196447,
                    chaosBolt                   = 116858,
                    conflagrate                 = 17962,
                    darkSoul                    = 113858,
                    devourMagic                 = 19505,
                    dimensionalRift             = 196586,
                    drainLife                   = 234153,
                    grimoireOfSacrifice         = 108503,
                    havoc                       = 80240,
                    immolate                    = 348,
                    incinerate                  = 29722,
                    rainOfFire                  = 5740,
                    shadowBolt                  = 686,
                    shadowburn                  = 17877,
                    shadowLock                  = 171138,
                    singeMagic                  = 119905,
                    singeMagicGrimoire          = 132411,
                    soulFire                    = 6353,
                    spellLock                   = 19647,
                    spellLockgrimoire           = 132409,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    backdraft                   = 117828, --196406,
                    darkSoul                    = 113858,
                    demonicPower                = 196099,
                    empoweredLifeTap            = 235156,
                    lessonsOfSpaceTime          = 236174,
                    lordOfFlames                = 224103,
                },
                debuffs                         = {
                    conflagrate                 = 265931,
                    eradication                 = 196414,
                    immolate                    = 157736,
                    havoc                       = 80240,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    cataclysm                   = 152108,
                    channelDemonfire            = 196447,
                    darkSoul                    = 113858,
                    eradication                 = 196412,
                    flashover                   = 267115,
                    fireAndBrimstone            = 196408,
                    grimoireOfSacrifice         = 108503,
                    inferno                     = 270545,
                    internalCombustion          = 266134,
                    eradication                 = 196412,
                    reverseEntropy              = 205148,
                    roaringBlaze                = 205184,
                    shadowburn                  = 17877,
                    soulFire                    = 6353,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    darkPact                    = 108416,
                    demonicCircle               = 48018,
                    fear                        = 5782,
                    grimoireFelhunter           = 111897,
                    grimoireImp                 = 111859,
                    grimoireOfService           = 108501,
                    grimoireSuccubus            = 111896,
                    grimoireVoidwalker          = 111895,
                    healthFunnel                = 755,
                    lifeTap                     = 1454,
                    mortalCoil                  = 6789,
                    shadowfury                  = 30283,
                    soulHarvest                 = 196098,
                    soulstone                   = 20707,
                    --summonDoomguard             = 18540,
                    summonFelguard              = 30146,
                    summonFelhunter             = 691,
                    summonFelImp                = 688,
                    summonImp                   = 688,
                    summonInfernal              = 1122,
                    summonSuccubus              = 712,
                    summonVoidwalker            = 697,
                    summonWrathguard            = 112870,
                    unendingResolve             = 104773,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    demonicSynergy              = 171982,
                    sindoreiSpite               = 208871,
                    soulHarvest                 = 196098,
                    soulstone                   = 20707,
                },
                debuffs                         = {
    
                },
                glyphs                          = {
                    glyphOfTheFelImp            = 219424,
                },
                pets                            = {
                    darkglare                   = 103673,
                    demonicTyrant               = 135002,
                    doomguard                   = 78158,
                    dreadstlaker                = 98035,
                    felguard                    = 17252,
                    felhunter                   = 417,
                    imp                         = 416,
                    infernal                    = 78217,
                    succubus                    = 1863,
                    voidwalker                  = 1860,
                    wildImp                     = 55659,
                    wrathguard                  = 58965,
                },
                talents                         = {
                    burningRush                 = 111400,
                    darkPact                    = 108416,
                    demonSkin                   = 219272,
                    mortalCoil                  = 6789,
                },
            },
        },
        WARRIOR = {
            -- Arms
            [71] = {
                abilities                       = {
                    bladestorm                  = 227847,
                    cleave                      = 845,
                    colossusSmash               = 167105,
                    commandingShout             = 97462,
                    deadlyCalm                  = 262228,
                    defensiveStance             = 197690,
                    dieByTheSword               = 118038,
                    execute                     = 163201,
                    hamstring                   = 1715,
                    mortalStrike                = 12294,
                    overpower                   = 7384,
                    ravager                     = 152277,
                    rend                        = 772,
                    slam                        = 1464,
                    sweepingStrikes             = 260708,
                    warbreaker                  = 262161,
                    whirlwind                   = 1680,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    crushingAssasult            = 278826,
                    deadlyCalm                  = 262228,
                    defensiveStance             = 197690,
                    inForTheKill                = 215550,
                    overpower                   = 60503,
                    stoneHeart                  = 225947,
                    suddenDeath                 = 52437,
                    sweepingStrikes             = 260708,
                    testOfMight                 = 275540,
                },
                debuffs                         = {
                    colossusSmash               = 208086,
                    deepWounds                  = 262115,
                    executionersPrecision       = 272870,
                    rend                        = 772,
                },
                glyphs                          = {
                    glyphOfThunderStrike        = 68164,
                },
                talents                         = {
                    avatar                      = 107574,
                    cleave                      = 845,
                    collateralDamage            = 268243,
                    deadlyCalm                  = 262228,
                    defensiveStance             = 197690,
                    doubleTime                  = 103827,
                    dreadnaught                 = 262150,
                    fervorOfBattle              = 202316,
                    inForTheKill                = 248621,
                    massacre                    = 281001,
                    ravager                     = 152277,
                    rend                        = 772,
                    secondWind                  = 29838,
                    skullsplitter               = 260643,
                    suddenDeath                 = 29725,
                    warMachine                  = 262231,
                    warbreaker                  = 262161,
                },
                traits                          = {
                    seismicWave                 = 277639,
                    testOfMight                 = 275529,
                }
            },
            -- Fury
            [72] = {
                abilities                       = {
                    bladestorm                  = 46924,
                    bloodthirst                 = 23881,
                    dragonRoar                  = 118000,
                    enragedRegeneration         = 184364,
                    execute                     = 5308,
                    furiousSlash                = 100130,
                    piercingHowl                = 12323,
                    ragingBlow                  = 85288,
                    rampage                     = 184367,
                    recklessness                = 1719,
                    siegebreaker                = 280772,
                    whirlwind                   = 190411,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    enrage                      = 184362,
                    furiousSlash                = 202539,
                    meatCleaver                 = 85739,
                    recklessness                = 1719,
                    suddenDeath                 = 280776,
                    whirlwind                   = 85739,
                },
                debuffs                         = {
                    siegebreaker                = 280773,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    bladestorm                  = 46924,
                    carnage                     = 202922,
                    doubleTime                  = 103827,
                    dragonRoar                  = 118000,
                    endlessRage                 = 202296,
                    freshMeat                   = 215568,
                    frothingBerserker           = 215571,
                    furiousCharge               = 202224,
                    furiousSlash                = 100130,
                    innerRage                   = 215573,
                    massacre                    = 206315,
                    meatCleaver                 = 280392,
                    recklessAbandon             = 202751,
                    siegebreaker                = 280772,
                    suddenDeath                 = 280721,
                    warMachine                  = 262231,
                    warpaint                    = 208154,
                },
                traits                          = {
                    coldSteelHotBlood           = 288080
                }
            },
            -- Protection
            [73] = {
                abilities                       = {
                    demoralizingShout           = 1160,
                    devastate                   = 20243,
                    focusedRage                 = 204488,
                    ignorePain                  = 190456,
                    impendingVictory            = 202168,
                    intercept                   = 198304,
                    lastStand                   = 12975,
                    ravager                     = 228920,
                    revenge                     = 6572,
                    shieldBlock                 = 2565,
                    shieldSlam                  = 23922,
                    shieldWall                  = 871,
                    shockwave                   = 46968,
                    spellReflection             = 23920,
                    thunderClap                 = 6343,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    avatar                      = 107574,
                    defensiveStance             = 71,
                    ignorePain                  = 190456,
                    lastStand                   = 12975,
                    revenge                     = 5302,
                    shieldBlock                 = 132404,
                    shieldWall                  = 871,
                    vengeanceFocusedRage        = 202573,
                    vengeanceIgnorePain         = 202574,
                    vengeanceRevenge            = 202573,
                    victorious                  = 32216,
                },
                debuffs                         = {
                    deepwoundsProt              = 115767,
                    demoralizingShout           = 1160,
                    thunderClap                 = 6343,
                },
                glyphs                          = {
    
                },
                talents                         = {
                    bestServedCold              = 202560,
                    bolster                     = 280001,
                    boomingVoice                = 202743,
                    cracklingThunder            = 203201,
                    devastator                  = 236279,
                    dragonRoar                  = 118000,
                    heavyRepercussions          = 203177,
                    indomitable                 = 202095,
                    intoTheFray                 = 202603,
                    menace                      = 275338,
                    neverSurrender              = 202561,
                    punish                      = 275334,
                    ravager                     = 228920,
                    rumblingEarth               = 275339,
                    safeguard                   = 223657,
                    unstoppableForce            = 275336,
                    vengeance                   = 202572,
                },
            },
            -- All
            Shared = {
                abilities                       = {
                    avatar                      = 107574,
                    battleShout                 = 6673,
                    berserkerRage               = 18499,
                    charge                      = 100,
                    heroicLeap                  = 6544,
                    heroicThrow                 = 57755,
                    intimidatingShout           = 5246,
                    pummel                      = 6552,
                    rallyingCry                 = 97462,
                    stormBolt                   = 107570,
                    taunt                       = 355,
                    victoryRush                 = 34428,
                },
                artifacts                       = {
    
                },
                buffs                           = {
                    battleShout                 = 6673,
                    berserkerRage               = 18499,
                    fujiedasFury                = 207776,
                    victorious                  = 32216,
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                items                           = {
                    archavonsHeavyHand          = 137060,
                    kazzalaxFujiedasFury        = 137053,
                    weightOfTheEarth            = 137077,
                },
                talents                         = {
                    angerManagement             = 152278,
                    boundingStride              = 202163,
                    impendingVictory            = 202168,
                    stormBolt                   = 107570,
                },
            },
        },
        -- Global
        Shared = {
            Shared = {
                abilities                           = {
                    giftOfTheNaaru                  = 28880,
                    global                          = 61304,
                    shadowmeld                      = 58984,
                    quakingPalm                     = 107079,
                    racial                          = getRacial(),
                    lightsJudgment                  = 247427,
                },
                artifacts                           = {
                    artificialDamage                = 226829,
                    artificialStamina               = 211309,
                    concordanceOfTheLegionfall      = 239042,
                },
                buffs                               = {
                    ancientHysteria                 = 90355,
                    battlePotionOfAgility           = 279152,
                    battlePotionOfIntellect         = 279151,
                    battlePotionOfStrength          = 279153,
                    bloodLust                       = {
                        ancientHysteria             = 90355,
                        bloodlust                   = 2825,
                        drumsOfRage                 = 146555,
                        drumsOfTheMaelstrom         = 256740,
                        drumsOfTheMountain          = 230935,
                        heroism                     = 32182,
                        netherwinds                 = 160452,
                        primalRage                  = 264667,
                        timewarp                    = 80353,
                    },
                    concordanceOfTheLegionfall      = 239042,
                    defiledAugmentation             = 224001, -- Lightforged Augment Rune buff
                    felFocus                        = 242551,
                    flaskOfTenThousandScars         = 188035,
                    flaskOfTheCountlessArmies       = 188034,
                    flaskOfTheSeventhDemon          = 188033,
                    flaskOfTheWhisperedPact         = 188031,
                    flaskOfTheCurrents              = 251836,
                    flaskOfEndlessFathoms           = 251837,
                    flaskOfTheVastHorizon           = 251838,
                    flaskOfTheUndertow              = 251839,
                    fruitfulMachinatins             = 242623, -- Absorb Shield from Deceiver's Grand Design
                    guidingHand                     = 242622, -- from The Deceiver's Grand Design
                    heroism                         = 32182,
                    netherwinds                     = 160452,
                    norgannonsForesight             = 236373,
                    potionOfBurstingBlood           = 265514,
                    prolongedPower                  = 229206,
                    sephuz1                         = 208051, -- the fulltime 10% movement, 2% haste buff
                    sephuz2                         = 208052, -- the proc, 70% movement, 25% haste buff
                    sephuzCooldown                  = 226262, -- CD (30 seconds) for the proc
                    shadowmeld                      = 58984,
                    timeWarp                        = 80353,
                    whispersOfInsanity              = 176151,
                },
                debuffs                             = {
                    dampening                       = 110310,
                    eyeOfLeotheras                  = 206649,
                    temptation                      = 234143,
                },
                items                               = {
                    battleScarredAugmentRune        = 160053,
                    battlePotionOfAgility           = 163223,
                    battlePotionOfIntellect         = 163222,
                    battlePotionOfStrength          = 163224,
                    bygoneBeeAlmanac                = 163936,
                    convergenceOfFates              = 140806,
                    deceiversGrandDesign            = 147007,
                    defiledAugmentRune              = 140587,
                    draughtOfSouls                  = 140808,
                    eternalAmuletOfTheRedeemed      = 122663,
                    eternalEmberfuryTalisman        = 122667,
                    eternalHorizonChoker            = 122664,
                    eternalTalismanOfEvasion        = 122662,
                    eternalWillOfTheMartyr          = 122668,
                    eternalWovenIvyNecklace         = 122666,
                    feloiledInfernalMachine         = 144482,
                    flaskOfTenThousandScars         = 127850,
                    flaskOfTheCountlessArmies       = 127849,
                    flaskOfTheSeventhDemon          = 127848,
                    flaskOfTheWhisperedPact         = 127847,
                    flaskOfTheCurrents              = 152638,
                    flaskOfEndlessFathoms           = 152639,
                    flaskOfTheVastHorizon           = 152640,
                    flaskOfTheUndertow              = 152641,
                    galecallersBeak                 = 161379,
                    healthstone                     = 5512,
                    heirloomNeck                    = getHeirloomNeck(),
                    hornOfValor                     = 133642,
                    lightforgedAugmentRune          = 153023, -- 7.3 augment rune item
                    jesHowler                       = 159627,
                    manariTrainingAmulet            = 153130,
                    oraliusWhisperingCrystal        = 118922,
                    potionOfBurstingBlood           = 152560,
                    potionOfTheOldWar               = 127844,
                    potionOfProlongedPower          = 142117,
                    repurposedFelFocuser            = 147707,
                    ringOfCollapsingFutures         = 142173,
                    specterOfBetrayal               = 151190,
                    umbralMoonglaives               = 147012,
                    vialOfCeaselessToxins           = 147011,
                },
            },
        },
        ClassTemplate = {
            SpecTemplate = {
                abilities                       = {
    
                },
                artifacts                       = {
    
                },
                buffs                           = {
    
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
    
                },
            },
            SpecTemplate = {
                abilities                       = {
    
                },
                artifacts                       = {
    
                },
                buffs                           = {
    
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
    
                },
            },
            SpecTemplate = {
                abilities                       = {
    
                },
                artifacts                       = {
    
                },
                buffs                           = {
    
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
    
                },
            },
            Shared = {
                abilities                       = {
    
                },
                artifacts                       = {
    
                },
                buffs                           = {
    
                },
                debuffs                         = {
    
                },
                glyphs                          = {
    
                },
                talents                         = {
    
                },
            },
        },
    }
    

    -- 基本类
    function cUnit:new(unit)
        local self = {}
        local function getHP(Unit)
            if Unit == nil then 
                Unit = "player";
                return UnitHealth(Unit)/UnitHealthMax(Unit)
            end
            if UnitExists(Unit) and not UnitIsDeadOrGhost(Unit) then
                if UnitIsEnemy("player", Unit) and UnitIsVisible(Unit) then
                    return UnitHealth(Unit)/UnitHealthMax(Unit)
                else
                    if not UnitIsDeadOrGhost(Unit) and UnitIsVisible(Unit) then                        
                        return UnitHealth(Unit)/UnitHealthMax(Unit)                        
                    end
                end
            end
            return 0
        end
        
        self.artifact       = {} 	
        self.buff           = {}       
        self.debuff         = {}        
        self.cooldown       = {}        
        self.charges        = {} 
        self.spell	        = {}
        self.pct_health     = getHP
        self.time_to_die    = getTimeToDie 
        self.spell	    		= {}        -- Spells all classes may have (e.g. Racials, Mass Ressurection)
        self.talent         = {}        -- Talents
        self.timeToMax	    = 0		-- Time To Max Power
        self.traits         = {}	-- Azerite Traits
        self.units          = {}  
        self.action          = {}  
        return self
    end

    --玩家类
    function cPlayer:new(unit,spec)    
        -- 继承基本类
        local self = cUnit:new(unit)
        -- 根据职业，专精取list数据       
        local playerClass = select(2,UnitClass("player"))
        local spec = select(1,GetSpecializationInfo(GetSpecialization()))
        local specSpells = lists.spells[playerClass][spec]
        local sharedClassSpells = lists.spells[playerClass]["Shared"]
        local sharedGlobalSpells = lists.spells["Shared"]["Shared"]
        local function getSpells(spellTable)
            
            for spellType, spellTypeTable in pairs(spellTable) do
                
                if self.spell[spellType] == nil then self.spell[spellType] = {} end
                
                for spellRef, spellID in pairs(spellTypeTable) do
                    
                    self.spell[spellType][spellRef] = spellID
                    
                    if not IsPassiveSpell(spellID)
                        and (spellType == 'abilities' or spellType == 'traits' or spellType == 'talents')
                    then
                        if self.spell.abilities == nil then self.spell.abilities = {} end
                        self.spell.abilities[spellRef] = spellID
                        self.spell[spellRef] = spellID
                    end
                end
            end
        end    
        getSpells(specSpells)    
        getSpells(sharedClassSpells)    
        getSpells(sharedGlobalSpells)    
        if self.spell.abilities["racial"] == nil then
            local racialID = getRacialID()
            self.spell.abilities["racial"] = racialID
            self.spell["racial"] = racialID
        end
        
        
        --构造技能属性
        for k,v in pairs(self.spell.abilities) do
            
            if self.charges[k]      == nil then self.charges[k]         = {}; end        
            if self.cooldown[k]     == nil then self.cooldown[k]        = {}; end 
            if self.cast            == nil then self.cast               = {}; end       
            if self.cast.able       == nil then self.cast.able          = {}; end
            if self.prev_gcd        == nil then self.prev_gcd           = {}; end
            if self.action[k]       == nil then self.action[k]          = {}; end
            -- if self.prev_gcd.1      == nil then self.prev_gcd.1         = {} end
            -- if self.prev_gcd.2      == nil then self.prev_gcd.2         = {} end

            -- Build Spell Charges
            local charges = self.charges[k]
            charges.exists = function()
                return getCharges(v) >= 1
            end
            charges.count = function()
                return getCharges(v)
            end
            charges.frac = function()
                return getChargesFrac(v)
            end
            charges.max = function()
                return getChargesFrac(v,true)
            end
            charges.recharge = function(chargeMax)
                if chargeMax then
                    return getRecharge(v,true)
                else
                    return getRecharge(v)
                end
            end
            charges.timeTillFull = function()
                return getFullRechargeTime(v)
            end
            charges.full_recharge_time = function()
                return getFullRechargeTime(v)
            end

            -- Build Spell Cooldown
            local cooldown = self.cooldown[k]
            cooldown.exists = function()
                return getSpellCD(v) > 0
            end
            cooldown.up = function()
                return getSpellCD(v) <= 0
            end
            cooldown.ready = function()
                return getSpellCD(v) <= 0
            end
            cooldown.remain = function()
                return getSpellCD(v)
            end
            cooldown.remains = function()
                return getSpellCD(v)
            end
            cooldown.duration = function()
                return getSpellCD(v)
            end
            cooldown.charges = function()
                return getCharges(v)
            end
            cooldown.full_recharge_time = function()
                return getFullRechargeTime(v)
            end


            -- 构造施法函数
            self.cast[k] = function(thisUnit,FacingCheck,MovementCheck,SpamAllowed,KnownSkip,DeadCheck,DistanceSkip,usableSkip)
                if thisUnit == nil then thisUnit = "target";end
                return csi(thisUnit,v,FacingCheck,MovementCheck,SpamAllowed,KnownSkip,DeadCheck,DistanceSkip,usableSkip) 
                -- if Y.spell_cast_return == v then
                --     return true
                -- else
                --     return false
                -- end
            end
            self.cast.able[k] = function()
                return canCast(v)
                -- return self.cast[v](nil,"debug")
            end

            self.prev_gcd[k] = function (targetunit)
                if targetunit == nil then targetunit = "target";end
                return Y.lastspell_success.spellName == v --[[ and UnitIsUnit(Y.lastspell_success.spelltarget,targetunit) ]]
            end

            local action = self.action[k]
            action.cast_time = function()
                return getCastTime(v)
            end
            action.execute_time = function()
                return getCastTime(v)
            end
            action.charges = function()
                return getCharges(v)
            end
            action.full_recharge_time = function()
                return getFullRechargeTime(v)
            end
            action.executing = function (unit,intr)
                return isCastingSpell(unit,v,intr)
            end
            action.execute_remains = function (unit)
                if unit == nil then unit = "player";end
                return getCastTimeRemain(unit)
            end
            action.in_flight = function ()
                return getOneMyMissile() == v
            end
            action.in_flight_remains = function ()
                if getOneMyMissile() == v then
                    return 0.1
                end
            end
            
            
            
        end

        --构造能量列表
        if not self.power then self.power = {} end
        self.power.list     = {
            mana            = 0, --SPELL_POWER_MANA, --0,
            rage            = 1, --SPELL_POWER_RAGE, --1,
            focus           = 2, --SPELL_POWER_FOCUS, --2,
            energy          = 3, --SPELL_POWER_ENERGY, --3,
            comboPoints     = 4, --SPELL_POWER_COMBO_POINTS, --4,
            runes           = 5, --SPELL_POWER_RUNES, --5,
            runicPower      = 6, --SPELL_POWER_RUNIC_POWER, --6,
            soulShards      = 7, --SPELL_POWER_SOUL_SHARDS, --7,
            astralPower     = 8, --SPELL_POWER_LUNAR_POWER, --8,
            holyPower       = 9, --SPELL_POWER_HOLY_POWER, --9,
            altPower        = 10, --SPELL_POWER_ALTERNATE_POWER, --10,
            maelstrom       = 11, --SPELL_POWER_MAELSTROM, --11,
            chi             = 12, --SPELL_POWER_CHI, --12,
            insanity        = 13, --SPELL_POWER_INSANITY, --13,
            obsolete        = 14,
            obsolete2       = 15,
            arcaneCharges   = 16, --SPELL_POWER_ARCANE_CHARGES, --16,
            fury            = 17, --SPELL_POWER_FURY, --17,
            pain            = 18, --SPELL_POWER_PAIN, --18,
        }
        --构造能量属性
        for k, v in pairs(self.power.list) do
            if not self.power[k] then self.power[k] = {} end
            local power = self.power[k]
            local isDKRunes = select(2,UnitClass("player")) == "DEATHKNIGHT" and v == 5

            power.amount = function()
                if isDKRunes then
                    local runeCount = 0
                    for i = 1, 6 do
                        runeCount = runeCount + GetRuneCount(i)
                    end
                    return runeCount
                else
                    return getPower("player",v)
                end
            end
            power.deficit = function()
                return getPowerMax("player",v) - getPower("player",v)
            end
            power.frac = function()
                if isDKRunes then
                    local runeCount = 0
                    for i = 1, 6 do
                        runeCount = runeCount + GetRuneCount(i)
                    end
                    return runeCount + math.max(runeCDPercent(1),runeCDPercent(2),runeCDPercent(3),runeCDPercent(4),runeCDPercent(5),runeCDPercent(6))
                else
                    return 0
                end
            end
            power.max = function()
                return getPowerMax("player",v)
            end
            power.percent = function()
                if getPowerMax("player",v) == 0 then
                    return 0
                else
                    return ((getPower("player",v) / getPowerMax("player",v)) * 100)
                end
            end
            power.regen = function()
                return getRegen("player")
            end
            power.ttm = function(amount)
                if amount == nil then amount = 6 end
                if isDKRunes then
                    return runeTimeTill(amount)
                else
                    return getTimeToMax("player")
                end
            end
            power.time_to_max = function(amount)
                if amount == nil then amount = 6 end
                if isDKRunes then
                    return runeTimeTill(amount)
                else
                    return getTimeToMax("player")
                end
            end
        end

        --构造buff属性
        for k,v in pairs(self.spell.buffs) do
            if k ~= "rollTheBones" then
                if self.buff[k] == nil then self.buff[k] = {} end
                local buff = self.buff[k]
                buff.cancel = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    if UnitBuffID(thisUnit,v,sourceUnit) ~= nil then
                        RunMacroText("/cancelaura "..GetSpellInfo(v))
                        -- CancelUnitBuff(thisUnit,v,sourceUnit)
                    end
                end
                buff.exists = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return UnitBuffID(thisUnit,v,sourceUnit) ~= nil
                end
                buff.up = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return UnitBuffID(thisUnit,v,sourceUnit) ~= nil
                end
                buff.react = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return UnitBuffID(thisUnit,v,sourceUnit) ~= nil
                end
                buff.ticking = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return UnitBuffID(thisUnit,v,sourceUnit) ~= nil
                end
                buff.down = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return not UnitBuffID(thisUnit,v,sourceUnit)
                end
                buff.duration = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return getBuffDuration(thisUnit,v,sourceUnit)
                end
                buff.remain = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return math.abs(getBuffRemain(thisUnit,v,sourceUnit))
                end
                buff.remains = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return math.abs(getBuffRemain(thisUnit,v,sourceUnit))
                end
                buff.stack = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return getBuffStacks(thisUnit,v,sourceUnit)
                end
                buff.refresh = function(thisUnit,sourceUnit)
                    return buff.remain(thisUnit,sourceUnit) <= buff.duration(thisUnit,sourceUnit) * 0.3
                end
                buff.count = function()
                    return tonumber(getBuffCount(v))
                end
            end
        end

        --获得dot每跳间隔
        function self.getSnapshotValue(dot)
            
            if GetSpecializationInfo(GetSpecialization()) == 103 then
                local multiplier        = 1.00
                local Bloodtalons       = 1.30
                -- local SavageRoar        = 1.40
                local TigersFury        = 1.15
                local RakeMultiplier    = 1
                
                if self.buff.bloodtalons.exists() then multiplier = multiplier*Bloodtalons end
                
                if self.buff.tigersFury.exists() then multiplier = multiplier*TigersFury end
                
                if dot == self.spell.debuffs.rip then
                    
                    return 5*multiplier
                end
                
                if dot == self.spell.debuffs.rake then
                    
                    if self.buff.incarnationKingOfTheJungle.exists() or self.buff.prowl.exists() then
                        RakeMultiplier = 2
                    end
                    
                    return multiplier*RakeMultiplier
                end

            end

            if GetSpecializationInfo(GetSpecialization()) == 259 then
                local multiplier = 1
                if self.buff.stealth.exists() and self.talent.nightstalker and (dot == self.spell.debuffs.rupture or dot == self.spell.debuffs.garrote) then multiplier = 1.5 end
                if (self.buff.stealth.exists() or self.buff.vanish.exists() or (self.buff.subterfuge.exists() and self.buff.subterfuge.remain() >= 0.1 and self.buff.subterfuge.remain() >= getSpellCD(61304))) and dot == self.spell.debuffs.garrote and self.talent.subterfuge then multiplier = 1.8 end
                return multiplier
            end
            return 0

        end

        --构造debuff属性
        for k,v in pairs(self.spell.debuffs) do
            if self.debuff[k] == nil then self.debuff[k] = {} end
            local debuff = self.debuff[k]
            debuff.exists = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return UnitDebuffID(thisUnit,v,sourceUnit) ~= nil
            end
            debuff.ticking = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return UnitDebuffID(thisUnit,v,sourceUnit) ~= nil
            end
            debuff.duration = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return getDebuffDuration(thisUnit,v,sourceUnit) or 0
            end
            debuff.remain = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return math.abs(getDebuffRemain(thisUnit,v,sourceUnit))
            end
            debuff.remains = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return math.abs(getDebuffRemain(thisUnit,v,sourceUnit))
            end
            debuff.stack = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                if getDebuffStacks(thisUnit,v,sourceUnit) == 0 and UnitDebuffID(thisUnit,v,sourceUnit) ~= nil then
                    return 1
                else
                    return getDebuffStacks(thisUnit,v,sourceUnit)
                end
            end
            debuff.refresh = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return debuff.remain(thisUnit,sourceUnit) <= debuff.duration(thisUnit,sourceUnit) * 0.3
            end
            debuff.refreshable = function(thisUnit,sourceUnit)
                if thisUnit == nil then thisUnit = 'target' end
                if sourceUnit == nil then sourceUnit = 'player' end
                return debuff.remain(thisUnit,sourceUnit) <= debuff.duration(thisUnit,sourceUnit) * 0.3
            end
            debuff.count = function()
                return tonumber(getDebuffCount(v))
            end
            debuff.remainCount = function(remain)
                return tonumber(getDebuffRemainCount(v,remain))
            end
            debuff.lowest = function(range,debuffType)
                if range == nil then range = 40 end
                if debuffType == nil then debuffType = "remain" end
                return getDebuffMinMax(k, range, debuffType, "min")
            end
            debuff.max = function(range,debuffType)
                if range == nil then range = 40 end
                if debuffType == nil then debuffType = "remain" end
                return getDebuffMinMax(k, range, debuffType, "max")
            end
            if spec == 103 or spec == 259 then
                debuff.exsang = function(thisUnit)
                        return debuff.exsa[thisUnit] or false
                end
                debuff.calc = function()
                    return self.getSnapshotValue(v)
                end
                debuff.applied = function(thisUnit)
                    return debuff.bleed[thisUnit] or 0
                end
            end
        end

        -- 构造天赋
        local function getTalentInfo()
            local talentFound
            activeSpecGroup = GetActiveSpecGroup()
            if self.talent == nil then self.talent = {} end
            for k,v in pairs(self.spell.talents) do
                talentFound = false
                for r = 1, 7 do --search each talent row
                    for c = 1, 3 do -- search each talent column
                        local _,_,_,selected,_,talentID = GetTalentInfo(r,c,activeSpecGroup)
                        if v == talentID then
                            talentFound = true
                            -- Add All Matches to Talent List for Boolean Checks
                            self.talent[k] = selected
                            -- Add All Active Ability Matches to Ability/Spell List for Use Checks
                            if not IsPassiveSpell(v) then
                                self.spell['abilities'][k] = v
                                self.spell[k] = v
                            end
                            break;
                        end
                    end
                    -- If we found the talent, then stop looking for it.
                    if talentFound then break end
                end
                -- No matching talent for listed talent id, report to
                if not talentFound then
                    Print("|cffff0000No talent found for: |r"..k.." ("..v..") |cffff0000in the talent spell list, please notify profile developer.")
                end
            end
        end
         
        
        --特质
        local function getAzeriteTraitInfo()
            if self.traits == nil then self.traits = {};end
            local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
            if self.spell.traits == nil then return end
            for k, v in pairs(self.spell.traits) do
                self.traits[k] = {}
                self.traits[k].active = false
                self.traits[k].rank = 0
            end
            if not azeriteItemLocation then return end
            local azeritePowerLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
            for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED - 1 do -- exclude tabard
                local item = Item:CreateFromEquipmentSlot(slot)
                if (not item:IsItemEmpty()) then
                    local itemLocation = item:GetItemLocation()
                    if (C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLocation)) then
                        local tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfo(itemLocation)
                        for tier, info in next, tierInfo do
                            if (info.unlockLevel <= azeritePowerLevel) then
                                for _, powerID in next, info.azeritePowerIDs do
                                    local isSelected = C_AzeriteEmpoweredItem.IsPowerSelected(itemLocation, powerID)
                                    local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(powerID)
                                    if powerInfo and isSelected then
                                        local azeriteSpellID = powerInfo["spellID"]
                                        for k, v in pairs(self.spell.traits) do
                                            if v == azeriteSpellID then
                                                self.traits[k].active = true
                                                self.traits[k].enabled = true
                                                self.traits[k].rank = self.traits[k].rank + 1
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        -- if self.talent == nil then 
        getTalentInfo();
        getAzeriteTraitInfo();
        -- end
        
        
        return self
    end


    print("已加载core")

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
    -------------------------------------------------
    --每一秒刷新一次oop
    if _G._T2 == nil then
        -- body
        _G._T2 = 0
    end
    if GetTime() - _G._T2 > 1 then
        player              = cPlayer:new("player",63)
        target              = player
        talent              = player.talent
        buff                = player.buff
        debuff              = player.debuff
        cast                = player.cast
        cooldown            = player.cooldown
        power               = player.power
        azerite             = player.traits
        pct_health          = player.pct_health
        full_recharge_time  = player.full_recharge_time
        charges             = player.charges
        action              = player.action
        prev_gcd            = player.prev_gcd
        soulShards          = power.soulShards
        _G._T2 = GetTime()
        
    end
    -----------------------------------------------------
    local ZDzhaobb = ZDzhaobb_setting.is_enabled  -- 自动自动招宝宝 
    local BB = BB_setting.value               --选择宝宝类型
    local BF = BF_setting.value               --选择爆发模式
    local zls = zls_setting.value            --治疗石
    if IsRightControlKeyDown() then
        castSpell("target",267211)
        print(1)
    end

    if IsMounted("player") then
       return true;
    end

    if getHP("player")<zls and isMoving("player") and hasItem(5512) then
        useItem(5512)
    end
   --[[if not UnitBuffID("player",224001) and getSpellCD(153023)<=0 and zdfw == true then
      rm("/cast 光铸调和符文")
   end]]
   if not UnitBuffID("player",20707) and getSpellCD(20707)<=0 and ZDlhs == true then
      rm("/cast [target=player]灵魂石") 
   end 
   if getHP("pet")~=0 and getTalent(6,3) then
        csi("player",108503)
   end


   if _t1==nil then _t1 = GetTime(); end
   if ZDzhaobb == true and not UnitBuffID("player",196099) and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then
      if BB == "恶魔卫士" and getPetNum()~=5 then rm("/cast 召唤恶魔卫士") end 
      if BB == "虚空行者" and getPetNum()~=2 then rm("/cast 召唤虚空行者") end
      if BB == "小鬼" and getPetNum()~=1 then rm("/cast 召唤小鬼") end
      if BB == "地狱猎犬" and getPetNum()~=3 then rm("/cast 召唤地狱猎犬") end
      if BB == "魅魔" and getPetNum()~=4 then rm("/cast 召唤魅魔") end
      _t1=GetTime()+ 5
   end 
   --包里没治疗石头了自己制作
   if _t==nil then _t=GetTime(); end
   if not hasItem(5512) and not isMoving("player") and GetTime()>= _t then 
    csi("player",6201)
    _t=GetTime()+ 10
   end 

    -- print(ydebug.is_enabled)
    -- print(cast.scorch())
end


function rotation:build_a_shard()
    print("build_a_shard")
    self:rest()

    -- actions.build_a_shard=soul_strike,if=!talent.demonic_consumption.enabled|time>15|prev_gcd.1.hand_of_guldan&!buff.bloodlust.remains

    if not talent.demonicConsumption or time>15 or prev_gcd.handOfGuldan() --[[ and not (buff.bloodlust.remains() > 0) ]] then
        if cast.able.soulStrike() and cast.soulStrike() then
            if ydebug.is_enabled then
                print(201)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.build_a_shard+=/shadow_bolt

    if cast.able.shadowBolt() and cast.shadowBolt() then
        if ydebug.is_enabled then
            print(202)
            return 0
        else
            return 0
        end
    end

    return 0

end

function rotation:dcon_opener()

    print("dcon_opener")
    self:rest()

    if line_cd_1 == nil then line_cd_1 = 0;end
    if line_cd_2 == nil then line_cd_2 = 0;end
    if line_cd_3 == nil then line_cd_3 = 0;end


    -- actions.dcon_opener=hand_of_guldan,line_cd=30,if=azerite.explosive_potential.enabled

    if azerite.explosivePotential.enabled then
        if GetTime() - line_cd_1 >=30 and soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            -- line_cd_1 = GetTime()
            if ydebug.is_enabled then
                print(301)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/implosion,if=azerite.explosive_potential.enabled&buff.wild_imps.stack>2&buff.explosive_potential.down

    if azerite.explosivePotential.enabled and getMyImpCount()>2 and buff.explosivePotential.down() then
        if getMyImpCount()>0 and cast.able.implosion() and cast.implosion() then
            if ydebug.is_enabled then
                print(302)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/doom,line_cd=30

    if GetTime() - line_cd_2 >=30 and cast.able.doom() and cast.doom() then
        -- line_cd_2 = GetTime()
        if ydebug.is_enabled then
            print(303)
            return 0
        else
            return 0
        end
    end
    -- actions.dcon_opener+=/hand_of_guldan,if=prev_gcd.1.hand_of_guldan&soul_shard>0&prev_gcd.2.soul_strike

    if #Y.spelllist_success.list > 1 then
        if prev_gcd.handOfGuldan() and soulShards.amount()>0 and ( Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174) then
            if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
                if ydebug.is_enabled then
                    print(304)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    -- actions.dcon_opener+=/demonic_strength,if=prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan&(buff.wild_imps.stack>1&action.hand_of_guldan.in_flight)
    if #Y.spelllist_success.list > 1 then
        if prev_gcd.handOfGuldan() and  not ( Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174) and (getMyImpCount()>1 and action.handOfGuldan.in_flight()) and (getSpellCD(89751) == 0 or getSpellCD(89751) <= 25 ) then
            if cast.able.demonicStrength() and cast.demonicStrength() then
                if ydebug.is_enabled then
                    print(305)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    -- actions.dcon_opener+=/bilescourge_bombers

    if soulShards.amount() >1 and cast.able.bilescourgeBombers() and cast.bilescourgeBombers() then
        if ydebug.is_enabled then
            print(306)
            return 0
        else
            return 0
        end
    end
    -- actions.dcon_opener+=/soul_strike,line_cd=30,if=!buff.bloodlust.remains|time>5&prev_gcd.1.hand_of_guldan

    if  --[[ not (buff.bloodlust.remains() >0) or ]] time>5 and prev_gcd.handOfGuldan() then
        if GetTime() - line_cd_3 >=30 and cast.able.soulStrike() and cast.soulStrike() then
            -- line_cd_3 = GetTime()
            if ydebug.is_enabled then
                print(307)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/summon_vilefiend,if=soul_shard=5

    if soulShards.amount()==5 then
        if soulShards.amount()>0 and cast.able.summonVilefiend() and cast.summonVilefiend() then
            if ydebug.is_enabled then
                print(308)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/grimoire_felguard,if=soul_shard=5

    if soulShards.amount()==5 then
        if soulShards.amount()>0 and cast.able.grimoireFelguard() and cast.grimoireFelguard() then
            if ydebug.is_enabled then
                print(309)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/call_dreadstalkers,if=soul_shard=5

    if soulShards.amount()==5 then
        if soulShards.amount()>1 and cast.able.callDreadstalkers() and cast.callDreadstalkers() then
            if ydebug.is_enabled then
                print(310)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/hand_of_guldan,if=soul_shard=5

    if soulShards.amount()==5 then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(311)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/hand_of_guldan,if=soul_shard>=3&prev_gcd.2.hand_of_guldan&time>5&(prev_gcd.1.soul_strike|!talent.soul_strike.enabled&prev_gcd.1.shadow_bolt)
    if #Y.spelllist_success.list > 1 then
        if soulShards.amount()>=3 and Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174 and time>5 and (prev_gcd.soulStrike() or not talent.soulStrike and prev_gcd.shadowBolt()) then
            if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
                if ydebug.is_enabled then
                    print(312)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    -- # 2000%spell_haste is shorthand for the cast time of Demonic Tyrant. The intent is to only begin casting if a certain number of imps will be out by the end of the cast.
    -- actions.dcon_opener+=/summon_demonic_tyrant,if=prev_gcd.1.demonic_strength|prev_gcd.1.hand_of_guldan&prev_gcd.2.hand_of_guldan|!talent.demonic_strength.enabled&buff.wild_imps.stack+imps_spawned_during.2000%spell_haste>=6

    if prev_gcd.demonicStrength() or prev_gcd.handOfGuldan() and Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174 or not talent.demonicStrength and getMyImpCount()--[[ +imps_spawned_during.2000%spell_haste ]]>=6 then
        if cast.able.summonDemonicTyrant() and cast.summonDemonicTyrant() then
            if ydebug.is_enabled then
                print(313)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/demonbolt,if=soul_shard<=3&buff.demonic_core.remains

    if soulShards.amount()<=3 and buff.demonicCore.remains()>0 then
        if cast.able.demonbolt() and cast.demonbolt() then
            if ydebug.is_enabled then
                print(314)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.dcon_opener+=/call_action_list,name=build_a_shard

    self:build_a_shard()

    return 0

end

function rotation:implosion_list()
    print("implosion_list")
    -- actions.implosion=implosion,if=(buff.wild_imps.stack>=6&(soul_shard<3|prev_gcd.1.call_dreadstalkers|buff.wild_imps.stack>=9|prev_gcd.1.bilescourge_bombers|(!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan))&!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan&buff.demonic_power.down)|(time_to_die<3&buff.wild_imps.stack>0)|(prev_gcd.2.call_dreadstalkers&buff.wild_imps.stack>2&!talent.demonic_calling.enabled)

    if (getMyImpCount()>=6 and (soulShards.amount()<3 or prev_gcd.callDreadstalkers() or getMyImpCount()>=9 or prev_gcd.bilescourgeBombers() or ( not prev_gcd.handOfGuldan() and not (Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174))) and  not prev_gcd.handOfGuldan() and not (Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174) and buff.demonicPower.down()) or (target.time_to_die()<3 and getMyImpCount()>0) or ((Y.spelllist_success.list[#Y.spelllist_success.list-1] == 104316) and getMyImpCount()>2 and not talent.demonicCalling) then
        if getMyImpCount()>0 and cast.able.implosion() and cast.implosion() then
            if ydebug.is_enabled then
                print(401)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369

    if cooldown.summonDemonicTyrant.remains<13 or not hasEquiped(132369) then
        if soulShards.amount()>0 and cast.able.grimoireFelguard() and cast.grimoireFelguard() then
            if ydebug.is_enabled then
                print(402)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14

    if (cooldown.summonDemonicTyrant.remains()<9 and buff.demonicCalling.remains()>0) or (cooldown.summonDemonicTyrant.remains()<11 and not (buff.demonicCalling.remains()>0)) or cooldown.summonDemonicTyrant.remains()>14 then
        if soulShards.amount()>1 and cast.able.callDreadstalkers() and cast.callDreadstalkers() then
            if ydebug.is_enabled then
                print(403)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/summon_demonic_tyrant

    if cast.able.summonDemonicTyrant() and cast.summonDemonicTyrant() then
        if ydebug.is_enabled then
            print(403)
            return 0
        else
            return 0
        end
    end
    -- actions.implosion+=/hand_of_guldan,if=soul_shard>=5

    if soulShards.amount()>=5 then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(404)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/hand_of_guldan,if=soul_shard>=3&(((prev_gcd.2.hand_of_guldan|buff.wild_imps.stack>=3)&buff.wild_imps.stack<9)|cooldown.summon_demonic_tyrant.remains<=gcd*2|buff.demonic_power.remains>gcd*2)

    if soulShards.amount()>=3 and (((Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174 or getMyImpCount()>=3) and getMyImpCount()<9) or cooldown.summonDemonicTyrant.remains()<=gcd*2 or buff.demonicPower.remains()>gcd*2) then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(405)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/demonbolt,if=prev_gcd.1.hand_of_guldan&soul_shard>=1&(buff.wild_imps.stack<=3|prev_gcd.3.hand_of_guldan)&soul_shard<4&buff.demonic_core.up

    if prev_gcd.handOfGuldan() and soulShards.amount()>=1 and (getMyImpCount()<=3 or Y.spelllist_success.list[#Y.spelllist_success.list-2] ==105174) and soulShards.amount()<4 and buff.demonicCore.up() then
        if cast.able.demonbolt() and cast.demonbolt() then
            if ydebug.is_enabled then
                print(406)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/summon_vilefiend,if=(cooldown.summon_demonic_tyrant.remains>40&spell_targets.implosion<=2)|cooldown.summon_demonic_tyrant.remains<12

    if (cooldown.summonDemonicTyrant.remains()>40 and emnum<=2) or cooldown.summonDemonicTyrant.remains()<12 then
        if soulShards.amount()>0 and cast.able.summonVilefiend() and cast.summonVilefiend() then
            if ydebug.is_enabled then
                print(407)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/bilescourge_bombers,if=cooldown.summon_demonic_tyrant.remains>9

    if cooldown.summonDemonicTyrant.remains()>9 then
        if soulShards.amount() >1 and cast.able.bilescourgeBombers() and cast.bilescourgeBombers() then
            if ydebug.is_enabled then
                print(408)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2

    if soulShards.amount()<5 and buff.demonicCore.stack()<=2 then
        if cast.able.soulStrike() and cast.soulStrike() then
            if ydebug.is_enabled then
                print(409)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/demonbolt,if=soul_shard<=3&buff.demonic_core.up&(buff.demonic_core.stack>=3|buff.demonic_core.remains<=gcd*5.7)

    if soulShards.amount()<=3 and buff.demonicCore.up() and (buff.demonicCore.stack()>=3 or buff.demonicCore.remains()<=gcd*5.7) then
        if cast.able.demonbolt() and cast.demonbolt() then
            if ydebug.is_enabled then
                print(410)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.implosion+=/doom,cycle_targets=1,max_cycle_targets=7,if=refreshable

    local tb_doom = getEnemy(35,filler_unit_doom)
    for i=1,7 do
        if UnitExists(tb_doom[i]) and debuff.doom.refreshable(tb_doom[i]) then
            if cast.able.doom() and cast.doom(tb_doom[i]) then
                if ydebug.is_enabled then
                    print(411)
                    return 0
                else
                    return 0
                end
            end
        end
    end
    -- actions.implosion+=/call_action_list,name=build_a_shard

    self:build_a_shard()

    return 0
    
end

function rotation:netherPortal_list()
    print("netherPortal_list")
    -- actions.nether_portal=call_action_list,name=nether_portal_building,if=cooldown.nether_portal.remains<20

    if cooldown.netherPortal.remains()<20 then
        self:netherPortal_building()
    end
    -- actions.nether_portal+=/call_action_list,name=nether_portal_active,if=cooldown.nether_portal.remains>165

    if cooldown.netherPortal.remains()>165 then
        self:netherPortal_active()
    end
    return 0
end

function rotation:netherPortal_active()
    print("netherPortal_active")
    -- actions.nether_portal_active=bilescourge_bombers

    if soulShards.amount() >1 and cast.able.bilescourgeBombers() and cast.bilescourgeBombers() then
        if ydebug.is_enabled then
            print(501)
            return 0
        else
            return 0
        end
    end
    -- actions.nether_portal_active+=/grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369

    if cooldown.summonDemonicTyrant.remains()<13 or not hasEquiped(132369) then
        if soulShards.amount()>0 and cast.able.grimoireFelguard() and cast.grimoireFelguard() then
            if ydebug.is_enabled then
                print(502)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12

    if cooldown.summonDemonicTyrant.remains()>40 or cooldown.summonDemonicTyrant.remains()<12 then
        if soulShards.amount()>0 and cast.able.summonVilefiend() and cast.summonVilefiend() then
            if ydebug.is_enabled then
                print(503)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14

    if (cooldown.summonDemonicTyrant.remains()<9 and buff.demonicCalling.remains()>0) or (cooldown.summonDemonicTyrant.remains()<11 and not (buff.demonicCalling.remains()>0)) or cooldown.summonDemonicTyrant.remains()>14 then
        if soulShards.amount()>1 and cast.able.callDreadstalkers() and cast.callDreadstalkers() then
            if ydebug.is_enabled then
                print(504)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/call_action_list,name=build_a_shard,if=soul_shard=1&(cooldown.call_dreadstalkers.remains<action.shadow_bolt.cast_time|(talent.bilescourge_bombers.enabled&cooldown.bilescourge_bombers.remains<action.shadow_bolt.cast_time))

    if soulShards.amount()==1 and (cooldown.callDreadstalkers.remains()<action.shadowBolt.cast_time() or (talent.bilescourgeBombers and cooldown.bilescourgeBombers.remains()<action.shadowBolt.cast_time())) then
        self:build_a_shard()
    end
    -- actions.nether_portal_active+=/hand_of_guldan,if=((cooldown.call_dreadstalkers.remains>action.demonbolt.cast_time)&(cooldown.call_dreadstalkers.remains>action.shadow_bolt.cast_time))&cooldown.nether_portal.remains>(165+action.hand_of_guldan.cast_time)

    if ((cooldown.callDreadstalkers.remains()>action.demonbolt.cast_time()) and (cooldown.callDreadstalkers.remains()>action.shadowBolt.cast_time())) and cooldown.netherPortal.remains()>(165+action.handOfGuldan.cast_time()) then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(505)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/summon_demonic_tyrant,if=buff.nether_portal.remains<5&soul_shard=0

    if buff.netherPortal.remains()<5 and soulShards.amount()==0 then
        if cast.able.summonDemonicTyrant() and cast.summonDemonicTyrant() then
            if ydebug.is_enabled then
                print(506)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/summon_demonic_tyrant,if=buff.nether_portal.remains<action.summon_demonic_tyrant.cast_time+0.5

    if buff.netherPortal.remains()<action.summonDemonicTyrant.cast_time()+0.5 then
        if cast.able.summonDemonicTyrant() and cast.summonDemonicTyrant() then
            if ydebug.is_enabled then
                print(507)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/demonbolt,if=buff.demonic_core.up&soul_shard<=3

    if buff.demonicCore.up() and soulShards.amount()<=3 then
        if cast.able.demonbolt() and cast.demonbolt() then
            if ydebug.is_enabled then
                print(507)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_active+=/call_action_list,name=build_a_shard

    self:build_a_shard()

    return 0
    
end

function rotation:netherPortal_building()
    print("netherPortal_building")
    -- actions.nether_portal_building=nether_portal,if=soul_shard>=5&(!talent.power_siphon.enabled|buff.demonic_core.up)

    if soulShards.amount()>=5 and ( not talent.powerSiphon or buff.demonicCore.up()) then
        if soulShards.amount()>=1 and cast.able.netherPortal() and cast.netherPortal() then
            if ydebug.is_enabled then
                print(601)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_building+=/call_dreadstalkers

    if soulShards.amount()>1 and cast.able.callDreadstalkers() and cast.callDreadstalkers() then
        if ydebug.is_enabled then
            print(602)
            return 0
        else
            return 0
        end
    end
    -- actions.nether_portal_building+=/hand_of_guldan,if=cooldown.call_dreadstalkers.remains>18&soul_shard>=3

    if cooldown.callDreadstalkers.remains()>18 and soulShards.amount()>=3 then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(603)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_building+=/power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&soul_shard>=3

    if getMyImpCount()>=2 and buff.demonicCore.stack()<=2 and buff.demonicPower.down() and soulShards.amount()>=3 then
        if cast.able.powerSiphon() and cast.powerSiphon() then
            if ydebug.is_enabled then
                print(604)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_building+=/hand_of_guldan,if=soul_shard>=5

    if soulShards.amount()>=5 then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(605)
                return 0
            else
                return 0
            end
        end
    end
    -- actions.nether_portal_building+=/call_action_list,name=build_a_shard

    self:build_a_shard()

    return 0
    
end


function rotation:default_action()

    -------------------------------------------------
    --每一秒刷新一次oop
    if _G._T2 == nil then
        -- body
        _G._T2 = 0
    end
    if GetTime() - _G._T2 > 1 then
        player              = cPlayer:new("player",63)
        target              = player
        talent              = player.talent
        buff                = player.buff
        debuff              = player.debuff
        cast                = player.cast
        cooldown            = player.cooldown
        power               = player.power
        azerite             = player.traits
        pct_health          = player.pct_health
        full_recharge_time  = player.full_recharge_time
        charges             = player.charges
        action              = player.action
        prev_gcd            = player.prev_gcd
        soulShards          = power.soulShards
        _G._T2 = GetTime()
        
    end

    --本地化
    --local aoe  = aoe_setting.is_enabled -- aoe模式
    zdxmb  = zdxmb_setting.is_enabled -- 自动选目标 
    emlltype = self.settings.emll --恶魔力量模式
    zyhztype = self.settings.zyhz  --灾怨轰炸模式
    zls = zls_setting.value            --治疗石
    xqsm1 = xqsm1_setting.value            --吸取生命阈值
    xqsm = xqsm1_setting.is_enabled        --治疗石
    bumie = bumie_setting.value    --不灭决心阀值
    qiyue = qiyue_setting.value   --黑暗契约阀值 
    ZDzhaobb = ZDzhaobb_setting.is_enabled  -- 自动自动招宝宝    
    BB = BB_setting.value               --选择宝宝类型
        BF = BF_setting.value               --选择爆发模式   
    variables = self.variables;
    autopause = autopause_setting.is_enabled
    shadowfury = shadowfury_setting.value
    aoe_num = self.settings.aoenum --aoe人数
    ydebug = self.settings.ydebug --调试信息
    ydebug2 = self.settings.ydebug2 --调试信息
    --获得目标周围10码的敌人数量
    active_enemies = getNumEnemies("target",10)

    if autopause then 
        if hasAOEPending() then
            return
        end
    end
    --print一个想要的东西 调试
   if IsRightControlKeyDown() then
   		--castSpell(tg,Spells["召唤恐惧猎犬"])
        print(getLastSpell())
    end


    emnum = getNumEnemies(tg,8)+1
    gcd = getGCD()
    time = getCombatTime()

    if UnitCastingInfo("player")  then
        -- print("fhl_1")
        return;
   end;
    if UnitChannelInfo("player")  then
        -- print("fhl_2")
        return;
   end;
    if getSpellCD(61304) > 0   then
        -- print("fhl_3")
        return;
   end;

    if zdxmb then
        --自动选怪
        --autoTarget(348,true)
        autoTarget(686,true)
        --如果有当前目标，并且当前目标可以攻击，则对当前目标攻击
        if UnitExists("target") and isAlive("target") and UnitCanAttack("player","target") then
            tg1 = "target"
            -- return 0            
        end

        if not UnitExists("target") or not isAlive("target") or not UnitCanAttack("player","target") then
            tg1 = getOneEnemy(40,filler_unit)  
            TargetUnit(tg1)
            -- return 0
        end
        --[[自动邪能球
        local xnq = getOneEnemy(40,getxnzyfilter)
        if GetUnitName("target") ~= "爆炸物" then
            if isInRange(348,xnq) and getHP(xnq) > 0 then
                TargetUnit(xnq)
            end
        end
        if GetUnitName("target") == "爆炸物" then
            if not isInRange(348,"target") or UnitIsDeadOrGhost("target") then
                ClearTarget()
                return 0
            end
        end]]
    end


    -- warlock="T23_Warlock_Demonology"
    -- source=default
    -- spec=demonology
    -- level=120
    -- race=troll
    -- role=spell
    -- position=ranged_back
    -- talents=2103032

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
    -- actions.precombat+=/summon_pet
    -- actions.precombat+=/inner_demons,if=talent.inner_demons.enabled
    -- actions.precombat+=/snapshot_stats
    -- actions.precombat+=/potion
    -- actions.precombat+=/demonbolt

    -- # Executed every time the actor is available.
    -- actions=potion,if=pet.demonic_tyrant.active&(!talent.nether_portal.enabled|cooldown.nether_portal.remains>160)|target.time_to_die<30
    -- actions+=/use_items,if=pet.demonic_tyrant.active|target.time_to_die<=15
    -- actions+=/berserking,if=pet.demonic_tyrant.active|target.time_to_die<=15
    -- actions+=/blood_fury,if=pet.demonic_tyrant.active|target.time_to_die<=15
    -- actions+=/fireblood,if=pet.demonic_tyrant.active|target.time_to_die<=15
    -- actions+=/call_action_list,name=dcon_opener,if=talent.demonic_consumption.enabled&time<30&!cooldown.summon_demonic_tyrant.remains

    if talent.demonicConsumption and time<30 and not (cooldown.summonDemonicTyrant.remains()>0) then
        self:dcon_opener()
        print("end of open")
        return 0
    end
    -- actions+=/hand_of_guldan,if=azerite.explosive_potential.rank&time<5&soul_shard>2&buff.explosive_potential.down&buff.wild_imps.stack<3&!prev_gcd.1.hand_of_guldan&&!prev_gcd.2.hand_of_guldan
    -- if #Y.spelllist_success.list > 1 then
        if azerite.explosivePotential.rank >= 1 and time<5 and soulShards.amount()>2 and buff.explosivePotential.down() and getMyImpCount()<3 and  not prev_gcd.handOfGuldan() and  not (Y.spelllist_success.list[#Y.spelllist_success.list-1] == 105174) then
            if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
                if ydebug.is_enabled then
                    print(101)
                    return 0
                else
                    return 0
                end
            end
        end
    -- end
    -- actions+=/demonbolt,if=soul_shard<=3&buff.demonic_core.up&buff.demonic_core.stack=4
    
    if soulShards.amount()<=3 and buff.demonicCore.up() and buff.demonicCore.stack()==4 then
        if cast.able.demonbolt() and cast.demonbolt() then
            if ydebug.is_enabled then
                print(102)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/implosion,if=azerite.explosive_potential.rank&buff.wild_imps.stack>2&buff.explosive_potential.remains<action.shadow_bolt.execute_time&(!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>12)

    if azerite.explosivePotential.rank>=1 and getMyImpCount()>2 and buff.explosivePotential.remains()<action.shadowBolt.execute_time() and ( not talent.demonicConsumption or cooldown.summonDemonicTyrant.remains()>12) then
        if getMyImpCount()>0 and cast.able.implosion() and cast.implosion() then
            if ydebug.is_enabled then
                print(103)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/doom,if=!ticking&time_to_die>30&spell_targets.implosion<2

    if  not debuff.doom.ticking() and target.time_to_die()>30 and emnum<2 then
        if cast.able.doom() and cast.doom() then
            if ydebug.is_enabled then
                print(104)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/bilescourge_bombers,if=azerite.explosive_potential.rank>0&time<10&spell_targets.implosion<2&buff.dreadstalkers.remains&talent.nether_portal.enabled

    if azerite.explosivePotential.rank>0 and time<10 and emnum<2 and getMyDreadstalkersCount() > 0 and talent.netherPortal then
        if soulShards.amount() >1 and cast.able.bilescourgeBombers() and cast.bilescourgeBombers() then
            if ydebug.is_enabled then
                print(105)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/demonic_strength,if=(buff.wild_imps.stack<6|buff.demonic_power.up)|spell_targets.implosion<2

    if (getMyImpCount()<6 or buff.demonicPower.up()) or emnum<2 then
        if (getSpellCD(89751) == 0 or getSpellCD(89751) <= 25 ) and cast.able.demonicStrength() and cast.demonicStrength()  then
            if ydebug.is_enabled then
                print(106)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/call_action_list,name=nether_portal,if=talent.nether_portal.enabled&spell_targets.implosion<=2

    if talent.netherPortal and emnum<=2 then
        self:netherPortal_list()
        return 0
    end
    -- actions+=/call_action_list,name=implosion,if=spell_targets.implosion>1

    if emnum>1 then
        self:implosion_list()
        return 0
    end
    -- actions+=/grimoire_felguard,if=(target.time_to_die>120|target.time_to_die<cooldown.summon_demonic_tyrant.remains+15|cooldown.summon_demonic_tyrant.remains<13)

    if (target.time_to_die()>120 or target.time_to_die()<cooldown.summonDemonicTyrant.remains()+15 or cooldown.summonDemonicTyrant.remains()<13) then
        if soulShards.amount()>0 and cast.able.grimoireFelguard() and cast.grimoireFelguard() then
            if ydebug.is_enabled then
                print(107)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12

    if cooldown.summonDemonicTyrant.remains()>40 or cooldown.summonDemonicTyrant.remains()<12 then
        if soulShards.amount()>0 and cast.able.summonVilefiend() and cast.summonVilefiend() then
            if ydebug.is_enabled then
                print(108)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14

    if (cooldown.summonDemonicTyrant.remains()<9 and buff.demonicCalling.remains()) or (cooldown.summonDemonicTyrant.remains()<11 and  not buff.demonicCalling.remains()) or cooldown.summonDemonicTyrant.remains()>14 then
        if soulShards.amount()>1 and cast.able.callDreadstalkers() and cast.callDreadstalkers() then
            if ydebug.is_enabled then
                print(109)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/bilescourge_bombers

    if soulShards.amount() >1 and cast.able.bilescourgeBombers() and cast.bilescourgeBombers() then
        if ydebug.is_enabled then
            print(110)
            return 0
        else
            return 0
        end
    end
    -- actions+=/hand_of_guldan,if=(azerite.baleful_invocation.enabled|talent.demonic_consumption.enabled)&prev_gcd.1.hand_of_guldan&cooldown.summon_demonic_tyrant.remains<2

    if (azerite.baleful_invocation.enabled or talent.demonicConsumption) and prev_gcd.handOfGuldan() and cooldown.summonDemonicTyrant.remains()<2 then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(110)
                return 0
            else
                return 0
            end
        end
    end
    -- # 2000%spell_haste is shorthand for the cast time of Demonic Tyrant. The intent is to only begin casting if a certain number of imps will be out by the end of the cast.
    -- actions+=/summon_demonic_tyrant,if=soul_shard<3&(!talent.demonic_consumption.enabled|buff.wild_imps.stack+imps_spawned_during.2000%spell_haste>=6&time_to_imps.all.remains<cast_time)|target.time_to_die<20

    if soulShards.amount()<3 and ( not talent.demonicConsumption or getMyImpCount()--[[ +imps_spawned_during.2000%spell_haste ]]>=6 and true --[[ time_to_imps.all.remains<cast_time ]]) or target.time_to_die()<20 then
        if cast.able.summonDemonicTyrant() and cast.summonDemonicTyrant() then
            if ydebug.is_enabled then
                print(111)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&spell_targets.implosion<2

    if getMyImpCount()>=2 and buff.demonicCore.stack()<=2 and buff.demonicPower.down() and emnum<2 then
        if cast.able.powerSiphon() and cast.powerSiphon() then
            if ydebug.is_enabled then
                print(112)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/doom,if=talent.doom.enabled&refreshable&time_to_die>(dot.doom.remains+30)

    if talent.doom and debuff.doom.refreshable() and target.time_to_die()>(debuff.doom.remains()+30) then
        if cast.able.doom() and cast.doom() then
            if ydebug.is_enabled then
                print(113)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/hand_of_guldan,if=soul_shard>=5|(soul_shard>=3&cooldown.call_dreadstalkers.remains>4&(cooldown.summon_demonic_tyrant.remains>20|(cooldown.summon_demonic_tyrant.remains<gcd*2&talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains<gcd*4&!talent.demonic_consumption.enabled))&(!talent.summon_vilefiend.enabled|cooldown.summon_vilefiend.remains>3))

    if soulShards.amount()>=5 or (soulShards.amount()>=3 and cooldown.callDreadstalkers.remains()>4 and (cooldown.summonDemonicTyrant.remains()>20 or (cooldown.summonDemonicTyrant.remains()<gcd*2 and talent.demonicConsumption or cooldown.summonDemonicTyrant.remains()<gcd*4 and  not talent.demonicConsumption)) and ( not talent.summonVilefiend or cooldown.summonVilefiend.remains()>3)) then
        if soulShards.amount() > 0 and cast.able.handOfGuldan() and cast.handOfGuldan() then
            if ydebug.is_enabled then
                print(114)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2

    if soulShards.amount()<5 and buff.demonicCore.stack()<=2 then
        if cast.able.soulStrike() and cast.soulStrike() then
            if ydebug.is_enabled then
                print(115)
                return 0
            else
                return 0
            end
        end
    end
    -- actions+=/demonbolt,if=soul_shard<=3&buff.demonic_core.up&((cooldown.summon_demonic_tyrant.remains<6|cooldown.summon_demonic_tyrant.remains>22&!azerite.shadows_bite.enabled)|buff.demonic_core.stack>=3|buff.demonic_core.remains<5|time_to_die<25|buff.shadows_bite.remains)

    if soulShards.amount()<=3 and buff.demonicCore.up() and ((cooldown.summonDemonicTyrant.remains()<6 or cooldown.summonDemonicTyrant.remains()>22 and  not azerite.shadowsBite.enabled) or buff.demonicCore.stack()>=3 or buff.demonicCore.remains()<5 or target.time_to_die()<25 or buff.shadowsBite.remains()>0) then
        if cast.able.demonbolt() and cast.demonbolt() then
            if ydebug.is_enabled then
                print(115)
                return 0
            else
                return 0
            end
        end
    end

    -- if soulShards.amount()<=3 and buff.demonicCore.up() then
    --     if cast.able.demonbolt() and cast.demonbolt() then
    --         if ydebug.is_enabled then
    --             print(116)
    --             return 0
    --         else
    --             return 0
    --         end
    --     end
    -- end

    -- actions+=/call_action_list,name=build_a_shard

    self:build_a_shard()

    return 0

end

-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);













