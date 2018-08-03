

----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "5a319e03-2c54-495e-8dc7-6e1d5452b666";
-- 定义循环的英文名称。
local rotation_name = "warlock_Destruction";
Scorpio("zeus." .. rotation_name)("");
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then 
   -- 简体中文系列。
   L[rotation_name] = "毁灭术士";
   L["Welcome to use warlock_Destruction module."] = "欢迎使用毁灭术士模块！";
   L["mzmsname"] = "|cff7FFF00自动AOE";
   L["zdxmbname"] = "|cff7FFF00自动选目标";
   L["zdfocusname"] = "|cff7FFF00自动设焦点";   
   L["zdfwname"] = "|cff7FFF00自动光铸符文";
   L["ZDlhsname"] = "|cff7FFF00自动给自己绑石头";  
   L["zdqxxpname"] = "|cff7FFF00自动取消爆燃冲刺"; 
   L["zdkqxpname"] = "|cff7FFF00自动开启爆燃冲刺"; 
   L["zdxpfzname"] = "|cff7FFF00爆燃冲刺阈值";  
   L["ZDzhaobbname"] = "|cff7FFF00自动招宝宝";
   L["BBname"] = "|cff7FFF00选择宝宝类型";     
   L["zlsname"]    = "|cff7FFF00治疗石阈值"; 
   L["bumiename"]  = "|cff7FFF00不灭决心阈值";      
   L["qiyuename"] = "|cff7FFF00黑暗契约阈值";
   L["autopause"] = "|cff7FFF00绿圈技能暂停";
   L["pvp Category"] = "|cff8B0000PVP设置";
   L["xjre"] = "|cff7FFF00补献祭最大剩余时间";
   L["aoenum"] = "|cff7FFF00火焰之雨目标数量";
   L["Insert Category"] = "|cff8B0000插入技能";
   L["lifedrain"] = "|cff7FFF00吸取生命"
   L["inferstun"] = "|cff7FFF00地狱火";
   L["shadowfury"] = "|cff7FFF00暗影之怒";
   L["aoename"]  = "|cff8B0000一键爆发宏：".."|cff0A0A0A/zkm ss baofa";
   L["aoe1name"] = "|cff7FFF00按住左Shift鼠标指向战复"
--[[    L["aoe2name"] = "按住此宏战复鼠标指向目标:/zkm tk zf"
   L["aoe3name"] = "按住此宏放逐鼠标指向目标:/zkm tk fz"   
   L["aoe4name"] = "留片等爆发或易伤开关宏:/zkm tk lp"
   L["aoe5name"] = "强  制  卸  片  开关宏:/zkm tk xp"   ]]
--    L["aoe6name"] = "按住左ALT放种子"
   L["aoe7name"] = "|cff7FFF00按住左CTRL鼠标指向放逐"     
end
local rotation = zeus.rotation(rotation_id, L[rotation_name]);
-- 定义循环加载并可用时的消息,填入"N/A"则不显示。rm("/targetenemy [help][dead][noexists]")
rotation.condition_yes_message = L["Welcome to use warlock_Destruction module."];
-- 定义循环加载并不可用时的消息,填入"N/A"则不显示。
rotation.condition_no_message = "N/A";
-- 定义循环的执行间隔（秒）,如果不设默认是0.1。
rotation.interval = 0.05;
rotation.macro = "ss";

-- -- 添加一个自定义类别test_category。
local jc_category = rotation:create_setting_category("jc_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
jc_category.display_name = L["|cff8B0000基础设置"]; -- 类别在界面上显示的名字

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

-- aoe模式
local aoe_setting = jc_category:create_setting("aoe"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
aoe_setting.display_name = L["mzmsname"];
aoe_setting.description = "不点钩可用左ALT手动AOE"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
aoe_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
aoe_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
aoe_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
aoe_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
aoe_setting.is_enabled_by_default = false; -- 是否默认启用
aoe_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
aoe_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

-- 自动选目标
local zdxmb_setting = jc_category:create_setting("zdxmb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdxmb_setting.display_name = L["zdxmbname"];
zdxmb_setting.description = "是否启用自动选目标。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
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

-- 自动光铸符文
local zdfw_setting = jc_category:create_setting("zdfw"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdfw_setting.display_name = L["zdfwname"];
zdfw_setting.description = "自动光铸符文。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdfw_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdfw_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
zdfw_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
zdfw_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdfw_setting.is_enabled_by_default = false; -- 是否默认启用
zdfw_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
zdfw_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）ZDlhs


-- 自动取消爆燃冲刺
local zdqxxp_setting = jc_category:create_setting("zdqxxp"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdqxxp_setting.display_name = L["zdqxxpname"];
zdqxxp_setting.description = "自动取消爆燃冲刺。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdqxxp_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdqxxp_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
zdqxxp_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
zdqxxp_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdqxxp_setting.is_enabled_by_default = false; -- 是否默认启用
zdqxxp_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
zdqxxp_setting.value_width = 80; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）

-- 自动开启爆燃冲刺
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
zdxpfz_setting.value_width = 80;

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
BB_setting.default_value = "小鬼"; -- 变量默认值
BB_setting.optional_values = {"小鬼","虚空行者","地狱猎犬","魅魔"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
BB_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
BB_setting.is_enabled_by_default = false; -- 是否默认启用
BB_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
BB_setting.value_width = 80; -- 值显示宽度像素（默认为100）


-- -- 添加一个自定义类别test_category。
local bm_category = rotation:create_setting_category("bm_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
bm_category.display_name = L["|cff8B0000保命设置"]; -- 类别在界面上显示的名字

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
local pvp_category = rotation:create_setting_category("pvp_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
pvp_category.display_name = L["pvp Category"]; -- 类别在界面上显示的名字

local xjre_setting = pvp_category:create_setting("xjre"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
xjre_setting.display_name = L["xjre"];
xjre_setting.description = "这是献祭Dot剩余时间，少于这个时间将会自动补一个献祭。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
xjre_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
xjre_setting.default_value = 5; -- 变量默认值
xjre_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
xjre_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
xjre_setting.is_enabled_by_default = true; -- 是否默认启用
xjre_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    if (value < 10 and value >= 0) then
        return true;
    else
        return false, "The number is too small.";
    end
end;
xjre_setting.value_width = 80; -- 值显示宽度像素（默认为100）

local aoenum_setting = pvp_category:create_setting("aoenum"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
aoenum_setting.display_name = L["aoenum"];
aoenum_setting.description = "这是火焰之雨最小的aoe数量，多于这个数量的目标才丢火焰之雨"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
aoenum_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
aoenum_setting.default_value = 5; -- 变量默认值
aoenum_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
aoenum_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
aoenum_setting.is_enabled_by_default = true; -- 是否默认启用
aoenum_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    if (value < 100 and value >= 3) then
        return true;
    else
        return false, "The number is too small.";
    end
end;
aoenum_setting.value_width = 80; -- 值显示宽度像素（默认为100）

local insert_category = rotation:create_setting_category("insert_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
insert_category.display_name = L["Insert Category"]; -- 类别在界面上显示的名字

local inferstun_setting = insert_category:create_setting("inferstun"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
inferstun_setting.display_name = L["inferstun"];
inferstun_setting.description = "按住这个键对目标丢地狱火！"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
inferstun_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
inferstun_setting.default_value = "x"; -- 变量默认值
inferstun_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
inferstun_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
inferstun_setting.is_enabled_by_default = true; -- 是否默认启用
inferstun_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
    if (#value == 1 ) then
        return true;
    else
        return false, "没有这个按键";
    end
end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
inferstun_setting.value_width = 70; -- 值显示宽度像素（默认为100）

local shadowfury_setting = insert_category:create_setting("shadowfury"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
shadowfury_setting.display_name = L["shadowfury"];
shadowfury_setting.description = "按住这个键对目标丢暗影之怒！"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
shadowfury_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
shadowfury_setting.default_value = "q"; -- 变量默认值
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

--吸取生命
local xqsm1_setting = insert_category:create_setting("xqsm1"); 
xqsm1_setting.display_name = L["|cff7FFF00吸取生命快捷键"];
xqsm1_setting.description = "按下按键吸取生命";
xqsm1_setting.value_type = rotation_setting_type.text; 
xqsm1_setting.default_value = "z"; 
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
--[[ local aoe2_category = rotation:create_setting_category("aoe2"); 
aoe2_category.display_name = L["aoe2name"];
local aoe2_category = rotation:create_setting_category("aoe3"); 
aoe2_category.display_name = L["aoe3name"];
local aoe2_category = rotation:create_setting_category("aoe4"); 
aoe2_category.display_name = L["aoe4name"];
local aoe2_category = rotation:create_setting_category("aoe5"); 
aoe2_category.display_name = L["aoe5name"]; ]]
--[[ local aoe2_category = rotation:create_setting_category("aoe6"); 
aoe2_category.display_name = L["aoe6name"]; ]]
local aoe2_category = rotation:create_setting_category("aoe7"); 
aoe2_category.display_name = L["aoe7name"];
-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
    -- 编写执行模块宏对应的处理脚本。
   if argument == "baofa" and baofa ~= true then
        OverlayR("爆发开启",true)
        baofa = true
        return 0;
    end
    if argument == "baofa" and baofa == true then
        OverlayG("爆发关闭",true)    
        baofa = false 
        return 0;
    end 
end
function rotation:condition_action()
    -- 编写判断模块是否可用的脚本。
	if select(3, UnitClass("player")) == 9 and GetSpecialization() == 3 then
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
    -- 编写在非战斗中循环执行的脚本。
   local zdfw = zdfw_setting.is_enabled  -- 自动光铸符文 
   local ZDlhs = ZDlhs_setting.is_enabled  -- 自动光铸符文 
   local zdqxxp = zdqxxp_setting.is_enabled -- 自动取消爆燃冲刺 
   local zdkqxp = zdkqxp_setting.is_enabled     --自动开启爆燃冲刺
   local ZDzhaobb = ZDzhaobb_setting.is_enabled  -- 自动自动招宝宝 
   local zdxpfz = zdxpfz_setting.value            --爆燃冲刺阀值
   local BB = BB_setting.value               --选择宝宝类型
   local zls = zls_setting.value            --治疗石
   if IsMounted("player") then
      return true;
   end
   if getTalent(3,2) and zdqxxp == true and UnitBuffID("player",111400) and (not isMoving("player") or getHP("player")<=zdxpfz) then
      rm("/cancelAura 爆燃冲刺")
   end 
   if getTalent(3,2) and isMoving("player") and not UnitBuffID("player",111400) and zdkqxp == true and getHP("player")>zdxpfz then
      rm("/cast 爆燃冲刺")
   end
   if getHP("player")<zls and isMoving("player") and hasItem(5512) then
        useItem(5512)
    end
   if not UnitBuffID("player",224001) and getSpellCD(153023)<=0 and zdfw == true then
      rm("/cast 光铸调和符文")
   end
   if not UnitBuffID("player",20707) and getSpellCD(20707)<=0 and ZDlhs == true then
      rm("/cast [target=player]灵魂石") 
   end 
   if getHP("pet")~=0 and getTalent(6,3) then
        csi("player",108503)
   end


   if _t1==nil then _t1 = GetTime(); end
   if ZDzhaobb == true and not UnitBuffID("player",196099) and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then
--[[       if BB == "末日守卫" and getPetNum()~=6 then rm("/cast 召唤末日守卫") end
      if BB == "地狱火" and getPetNum()~=7 then rm("/cast 召唤地狱火") end ]]
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
   self:rest();
end
 	-----------------------施法距离判定 /run print(getPetNum())
local function isInRange(SpellID, unit)
	local index = FindSpellBookSlotBySpellID(SpellID)
	local spellname = GetSpellInfo(SpellID) --法术名称
	if index == nil then
		return false
	end
	local inRange = IsSpellInRange(spellname, unit)
	if inRange == 1 or inRange == nil then
		return true
	else
		return false
	end
end
----------------------------------------------------
--SS专用函数
-----------------------------------------------------

--本地化
-- 

function rotation:default_action()
    -- 编写在战斗中循环执行的脚本。
    if IsMounted("player") then 
        return true;
    end  
   --本地化
    local aoe  = aoe_setting.is_enabled -- aoe模式
    local zdxmb  = zdxmb_setting.is_enabled -- 自动选目标 
    local zdfw = zdfw_setting.is_enabled  -- 自动光铸符文 
    local zdqxxp = zdqxxp_setting.is_enabled -- 自动取消爆燃冲刺 
    local zdkqxp = zdkqxp_setting.is_enabled     --自动开启爆燃冲刺
    local zdxpfz = zdxpfz_setting.value            --爆燃冲刺阀值
    local zls = zls_setting.value            --治疗石
    local xqsm1 = xqsm1_setting.value            --吸取生命阈值
    local xqsm = xqsm1_setting.is_enabled        --治疗石
    local bumie = bumie_setting.value    --不灭决心阀值
    local qiyue = qiyue_setting.value   --黑暗契约阀值 
    local ZDzhaobb = ZDzhaobb_setting.is_enabled  -- 自动自动招宝宝    
    local BB = BB_setting.value               --选择宝宝类型   
    local variables = self.variables;
    variables["tgA"],variables["tgAn"] = getBiggestUnitCluster(35,8,true) --获取35码最密集的aoe目标及个数
--[[     if not isInCombat(variables["tgA"]) then
        variables["tgA"]=nil
        variables["tgAn"] = 0
    end ]]

    local autopause = autopause_setting.is_enabled
    local inferstun = inferstun_setting.value
    local shadowfury = shadowfury_setting.value

    if autopause then 
        if hasAOEPending() then
            return
        end
    end

    --保命模块
    --应对震荡词缀（id：240447）/run print(getCastTimeRemain("player"))
    if getDebuffRemain("player",240447) < getCastTimeRemain("player") and getDebuffRemain("player",240447)>0 then 
        SpellStopCasting()
        return
    end

    if UnitExists("mouseover") and not amac("player",0) and IsLeftControlKeyDown() then 
        rm("/cast [target=mouseover]放逐术")
        ActionStatus_DisplayMessage("已放逐鼠标指向目标",true)    
    end 
    if UnitExists("mouseover") and UnitIsDeadOrGhost("mouseover") and not amac("player",0) and IsLeftShiftKeyDown() then 
        rm("/cast [target=mouseover]灵魂石")
        ActionStatus_DisplayMessage("已战复鼠标指向目标",true)         
    end
    if not amac("player",0) and IsLeftAltKeyDown() then --腐蚀之种
        if castSpell(tg,27243,false,false) then
            return 0;
        end  
    end
    
    if getTalent(3,2) and zdqxxp == true and UnitBuffID("player",111400) and (not isMoving("player") or getHP("player")<=zdxpfz) then
        rm("/cancelAura 爆燃冲刺")
    end 
    if getTalent(3,2) and isMoving("player") and not UnitBuffID("player",111400) and zdkqxp == true and getHP("player")>zdxpfz then
        rm("/cast 爆燃冲刺")
    end
    if not UnitBuffID("player",224001) and getSpellCD(153023)<=0 and zdfw == true then
        rm("/cast 光铸调和符文")
    end

    --[[    --强制宝宝跟随
    if IsLeftControlKeyDown() and UnitExists("pet") and getHP("pet")>0 and UnitCreatureFamily("pet") == "小鬼" then
        rm("/petfollow")
    end ]]
    if getHP("pet")~=0 and getTalent(6,3) then
        csi("player",108503)
   end

    if _t1==nil then _t1=GetTime(); end
    if ZDzhaobb == true and not UnitBuffID("player",196099) and not amac("player",0) and (not UnitExists("pet") or getHP("pet")==0 or getPetNum()==0) and GetTime() >= _t1 then
    --[[       if BB == "末日守卫" and getPetNum()~=6 then rm("/cast 召唤末日守卫") end
        if BB == "地狱火" and getPetNum()~=7 then rm("/cast 召唤地狱火") end ]]
        if BB == "虚空行者" and getPetNum()~=2 then rm("/cast 召唤虚空行者") end
        if BB == "小鬼" and getPetNum()~=1 then rm("/cast 召唤小鬼") end
        if BB == "地狱猎犬" and getPetNum()~=3 then rm("/cast 召唤地狱猎犬") end
        if BB == "魅魔" and getPetNum()~=0 then rm("/cast 召唤魅魔") end
        _t1=GetTime()+ 5
    end        


-----------------------------------------------------------
  
    -------------------------------保命技能
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
    if getHP("player")<=bumie then 
        if csi("player",104773) then
            return 0;
        end
    end

    --黑暗契约
    if getHP("player")<=qiyue and getTalent(3,3) then
        if csi("player",108416) then
            return 0;
        end
    end
    
	--读条结束或GCD结束才执行以下程序
	if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0 then
        return;
   end;

    --吸取生命 z
    if xqsm and canAttack(zj,tg) and not isMagicinv(tg) and getDistance(tg,zj) <= 34 then
        if isKeyDown(xqsm1) then
            if castSpell(tg,234153,false,true) then
                return 0;
            end        
        end
    end

    if canAttack(zj,tg) and not isMagicinv(tg) and getDistance(tg,zj) <= 34 then
        if isKeyDown(shadowfury) then
            if cs(tg,30283,true,false) then
                return
            end        
        end
        if isKeyDown(inferstun)  then
            cs(tg,1122,true,false)
        end
    end

    --自动选怪
    if zdxmb then autoTarget(348,true) end

    --PVP
    if isInPvP() then
        self:pvp_action()
        return
    end


    --自动邪能球
	local function getxnzyfilter(unit)
		return UnitIsVisible(unit) and UnitExists(unit) and UnitCanAttack("player", unit) and not UnitIsDeadOrGhost(unit) and getFacing("player", unit, 90) and GetUnitName(unit) == "爆炸物"
	end
	local xnq = getOneEnemy(40,getxnzyfilter)
	if GetUnitName("target") ~= "爆炸物" then
		if isInRange(29722,xnq) and getHP(xnq) > 0 then
			TargetUnit(xnq)
		end
	end
	if GetUnitName("target") == "爆炸物" then
		if not isInRange(29722,"target") or UnitIsDeadOrGhost("target") then
			ClearTarget()
		end
	end
    if  GetUnitName("target") == "爆炸物" then
        -- body
        self:yibao_action()  
    end


    -- 开始战斗simc开始 simc推荐天赋2203023    and not UnitIsUnit("target",unit)   
--[[     local function func_havoc(unit)
        return not UnitDebuffID(unit,80240) and UnitAffectingCombat(unit) and UnitCanAttack("player",unit) and UnitExists(unit) and not UnitIsDeadOrGhost(unit) and UnitIsVisible(unit) and isInRange(80240,unit)
    end
    local x_tb = getEnemy(50,func_havoc) --获取一个能放浩劫的目标
    print(x_tb[1],#x_tb)
    local havoc_tb = {}
    local comppp = function(a, b) return UnitHealth(a) > UnitHealth(b) end
    if x_tb and #x_tb>=2 then
        table.sort(havoc_tb,comppp)
        variables["havocTg"] = havoc_tb[1]
        if UnitExists("target") and UnitIsUnit("target",havoc_tb[1]) then
            variables["havocTg"] = havoc_tb[2]  
        end
    else
        variables["havocTg"] = false
    end ]]
    variables["havocTg"] = getOneEnemyWithoutHavok()
    -- print(variables["tgA"],variables["tgAn"],variables["havocTg"],x_tb[1])
    -- # Executed every time the actor is available.
    -- actions=run_action_list,name=cata,if=spell_targets.infernal_awakening>=3&talent.cataclysm.enabled
    if variables["tgAn"] >=3 and getTalent(4,3) then
        self:cata_action()       -- body
    end

    -- actions+=/run_action_list,name=fnb,if=spell_targets.infernal_awakening>=3&talent.fire_and_brimstone.enabled
    if variables["tgAn"] >=3 and getTalent(4,2) then
        self:fnb_action()     -- body
    end

    -- actions+=/run_action_list,name=inf,if=spell_targets.infernal_awakening>=3&talent.inferno.enabled
    if variables["tgAn"] >=3 and getTalent(4,1) then
        self:inf_action()       -- body
    end

    -- actions+=/immolate,cycle_targets=1,if=!debuff.havoc.remains&(refreshable|talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains-action.chaos_bolt.travel_time-5<duration*0.3)
    -- 献祭
    if --[[not UnitDebuffID("target",80240) and ]](getDebuffRemain("target",157736)<2 or (getTalent(2,2) --[[ and action.chaos_bolt.in_flight ]] and getDebuffRemain("target",157736)-getCastTime(348)-5 < getGCD())) then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end
    -- actions+=/call_action_list,name=cds
    if baofa then
        self:cds_action()-- body
    end
    -- actions+=/havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10
    -- 浩劫
    -- actions+=/havoc,if=active_enemies>1
    -- 浩劫
    if variables["havocTg"] and getTimeToDie(variables["havocTg"])>10 then
        -- body
        if csi(variables["havocTg"],80240) then
            variables["havocEm"] = variables["havocTg"]
            return 0;
        end
    end
    -- actions+=/channel_demonfire
    -- 恶魔之火 天赋7-2
    if getTalent(7,2) and canCast(196447) then
        if castSpell("target",196447,false,true) then
            return 0;
        end
    end
    -- actions+=/cataclysm
    -- 大灾变
    if getTalent(4,3) and canCast(152108) then
        if castGround(unit1,152108,30,true) then
            return 0;
        end
    end
    -- actions+=/soul_fire,cycle_targets=1,if=!debuff.havoc.remains
    -- 灵魂之火
    if getTalent(1,3) and canCast(6353) --[[and not UnitDebuffID("target",80240)]]then
        -- body
        if castSpell("target",6353,false,true) then
            return 0;
        end
    end
    -- actions+=/chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&execute_time+travel_time<target.time_to_die&(talent.internal_combustion.enabled|!talent.internal_combustion.enabled&soul_shard>=4|(talent.eradication.enabled&debuff.eradication.remains<=cast_time)|buff.dark_soul_instability.remains>cast_time|pet.infernal.active&talent.grimoire_of_supremacy.enabled)
    -- 混乱之箭
    if --[[not UnitDebuffID("target",80240) and ]]getCastTime(116858) +1.3<getTimeToDie("target") and (getTalent(2,2) or (not getTalent(2,2) and getSoulShards()>=4) or (getTalent(1,2) and getDebuffRemain("target",196414) <=getCastTime(116858)) or getBuffRemain("player",113858) > getCastTime(116858) or (getSpellCD(1122) > 165 and getTalent(6,2))) then
        -- body
        if castSpell("target",116858,false,true) then
            return 0;
        end
    end
    -- actions+=/conflagrate,cycle_targets=1,if=!debuff.havoc.remains&((talent.flashover.enabled&buff.backdraft.stack<=2)|(!talent.flashover.enabled&buff.backdraft.stack<2))
    -- 燃烧 
    if --[[not UnitDebuffID("target",80240) and ]]((getTalent(1,1) and getBuffStacks("player",117828)<=2) or (not getTalent(1,1) and getBuffStacks("player",117828)<2)) then
        -- body
        if castSpell("target",17962,false,false) then
            return 0;
        end
    end
    -- actions+=/shadowburn,cycle_targets=1,if=!debuff.havoc.remains&((charges=2|!buff.backdraft.remains|buff.backdraft.remains>buff.backdraft.stack*action.incinerate.execute_time))
    -- 暗影灼烧
    if --[[not UnitDebuffID("target",80240) and ]]getTalent(2,3) and ((getCharges(17877)==2 or not UnitBuffID("player",117828) or getBuffRemain("player",117828)>getBuffStacks("player",117828)*getCastTime(29722))) then
        -- body
        if castSpell("target",17877,false,true) then
            return 0;
        end
    end
    -- actions+=/incinerate,cycle_targets=1,if=!debuff.havoc.remains
    -- 烧尽
    if not UnitDebuffID("target",80240) then
        if castSpell("target",29722,false,true) then
            return 0;
        end
    end
    self:rest();
end
function rotation:cata_action()  --unit1,AOE目标，unit2，浩劫目标
    local variables = self.variables;
    -- actions.cata=call_action_list,name=cds
    if baofa then
        self:cds_action()-- body
    end
    -- actions.cata+=/rain_of_fire,if=soul_shard>=4.5
    -- 火焰之雨
    if getSoulShards()>=4.5 and canCast(5740) then
        -- body
        castGround(variables["tgA"],5740,30,false)
    end
    -- actions.cata+=/cataclysm
    -- 大灾变
    if getTalent(4,3) and canCast(152108) then
        castGround(variables["tgA"],152108,30,true)
    end
    -- actions.cata+=/immolate,if=talent.channel_demonfire.enabled&!remains&cooldown.channel_demonfire.remains<=action.chaos_bolt.execute_time
    -- 献祭
    if getTalent(7,2) and getDebuffRemain("target",157736)<getGCD() and getSpellCD(196447)<=getCastTime(116858) then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/channel_demonfire
    -- 恶魔之火 天赋7-2
    if getTalent(7,2) and canCast(196447) then
        if castSpell("target",196447,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=8&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    -- 浩劫
    -- actions.cata+=/havoc,if=spell_targets.rain_of_fire<=8&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    -- 浩劫
    if variables["havocTg"] and variables["tgAn"]<=8 and getTalent(6,2) and getSpellCD(1122) > 165 and getSpellCD(1122)<=175 and getTimeToDie(variables["havocTg"])>10 then
        -- body
        if csi(variables["havocTg"],80240) then
            variables["havocEm"] = variables["havocTg"]
            return 0;
        end
    end
    -- actions.cata+=/chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&talent.grimoire_of_supremacy.enabled&pet.infernal.remains>execute_time&active_enemies<=8&((108*spell_targets.rain_of_fire%3)<(240*(1+0.08*buff.grimoire_of_supremacy.stack)%2*(1+buff.active_havoc.remains>execute_time)))
    -- 混乱之箭
    local havoc_remains= 0
    if  UnitExists(variables["havocEm"]) and not UnitIsDeadOrGhost(variables["havocEm"]) and UnitIsVisible(variables["havocEm"]) then
        havoc_remains = getDebuffRemain(variables["havocEm"],80240)
    end
    if --[[not UnitDebuffID("target",80240) and ]]getTalent(6,2) and 15-(180 - getSpellCD(1122))>getCastTime(116858) and variables["tgAn"]<=8 and ((108 * variables["tgAn"]%3)<(240*(1+0.08*getBuffStacks("player",266091))%2*(1+havoc_remains>getCastTime(116858)))) then
        -- body
        if castSpell("target",116858,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4
    -- 浩劫
    -- actions.cata+=/havoc,if=spell_targets.rain_of_fire<=4
    -- 浩劫
    if variables["havocTg"] and variables["tgAn"]<=4 and getTimeToDie(variables["havocTg"])>10 then
        -- body
        if csi(variables["havocTg"],80240) then
            variables["havocEm"] = variables["havocTg"]
            return 0;
        end
    end
    -- actions.cata+=/chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&buff.active_havoc.remains>execute_time&spell_targets.rain_of_fire<=4
    -- 混乱之箭
    if --[[not UnitDebuffID("target",80240) and ]]havoc_remains > getCastTime(116858) and variables["tgAn"]<=4 then
        -- body
        if castSpell("target",116858,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/immolate,cycle_targets=1,if=!debuff.havoc.remains&refreshable&remains<=cooldown.cataclysm.remains
    -- 献祭
    if --[[not UnitDebuffID("target",80240) and ]]getDebuffRemain("target",157736)<=getSpellCD(152108) then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/rain_of_fire
    -- 火焰之雨
    if canCast(5740) then
        -- body
        castGround(variables["tgA"],5740,30,false)
    end
    -- actions.cata+=/soul_fire,cycle_targets=1,if=!debuff.havoc.remains
    -- 灵魂之火
    if getTalent(1,3) and canCast(6353) --[[and not UnitDebuffID("target",80240)]]then
        -- body
        if castSpell("target",6353,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/conflagrate,cycle_targets=1,if=!debuff.havoc.remains
    -- 燃烧 17962
    if not UnitDebuffID("target",80240) then
        if castSpell("target",17962,false,false) then
            return 0;
        end
    end
    -- actions.cata+=/shadowburn,cycle_targets=1,if=!debuff.havoc.remains&((charges=2|!buff.backdraft.remains|buff.backdraft.remains>buff.backdraft.stack*action.incinerate.execute_time))
    -- 暗影灼烧 2-3   17877
    if --[[not UnitDebuffID("target",80240) and ]]getTalent(2,3) and ((getCharges(17877)==2 or not UnitBuffID("player",117828) or getBuffRemain("player",117828)>getBuffStacks("player",117828)*getCastTime(29722))) then
        -- body
        if castSpell("target",17877,false,true) then
            return 0;
        end
    end
    -- actions.cata+=/incinerate,cycle_targets=1,if=!debuff.havoc.remains
    -- 烧尽 29722
    if not UnitDebuffID("target",80240) then
        if castSpell("target",29722,false,true) then
            return 0;
        end
    end
    self:rest();
end
function rotation:cds_action() --爆发
    local variables = self.variables;
    -- actions.cds=summon_infernal,if=target.time_to_die>=210|!cooldown.dark_soul_instability.remains|target.time_to_die<=30+gcd|!talent.dark_soul_instability.enabled
    -- 召唤地狱火 1122
    if getTimeToDie("target")>=210 or getSpellCD(113858)>0 or getTimeToDie("target") <= 30 + getGCD() or not getTalent(7,3) then
        -- body
        castGround("target",1122,30,false)
    end
    -- actions.cds+=/dark_soul_instability,if=target.time_to_die>=140|pet.infernal.active|target.time_to_die<=20+gcd
    -- 黑暗灵魂：动荡 113858
    if getTimeToDie("target")>=140 or getSpellCD(1122) > 170 or getTimeToDie("target") <= 20 + getGCD() then
        -- body
        if csi("player",113858) then
            return 0;
        end
    end
    -- actions.cds+=/potion,if=pet.infernal.active|target.time_to_die<65
    -- actions.cds+=/berserking
    -- actions.cds+=/blood_fury
    -- actions.cds+=/fireblood
    -- actions.cds+=/use_items
    useTrinket()
    self:rest();
end

function rotation:fnb_action()
    local variables = self.variables;
    -- actions.fnb=call_action_list,name=cds
    if baofa then
        self:cds_action()-- body
    end
    -- actions.fnb+=/rain_of_fire,if=soul_shard>=4.5
    -- 火焰之雨
    if getSoulShards()>=4.5 and canCast(5740) then
        -- body
        castGround(variables["tgA"],5740,30,false)
    end
    -- actions.fnb+=/immolate,if=talent.channel_demonfire.enabled&!remains&cooldown.channel_demonfire.remains<=action.chaos_bolt.execute_time
    -- 献祭
    if getTalent(7,2) and getDebuffRemain("target",157736)<=3 and getSpellCD(196447)<=getCastTime(116858) then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end
    -- actions.fnb+=/channel_demonfire
    -- 恶魔之火 天赋7-2
    if getTalent(7,2) and canCast(196447) then
        if castSpell("target",196447,false,true) then
            return 0;
        end
    end
    -- actions.fnb+=/havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    -- 浩劫
    -- actions.fnb+=/havoc,if=spell_targets.rain_of_fire<=4&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    -- 浩劫
    if variables["havocTg"] and variables["tgAn"]<=4 and  getTalent(6,2) and getSpellCD(1122) > 165 and getSpellCD(1122)<=175 and getTimeToDie(variables["havocTg"])>10 then
        -- body
        if csi(variables["havocTg"],80240) then
            variables["havocEm"] = variables["havocTg"]
            return 0;
        end
    end
    -- actions.fnb+=/chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&talent.grimoire_of_supremacy.enabled&pet.infernal.remains>execute_time&active_enemies<=4&((108*spell_targets.rain_of_fire%3)<(240*(1+0.08*buff.grimoire_of_supremacy.stack)%2*(1+buff.active_havoc.remains>execute_time)))
    -- 混乱之箭
    local havoc_remains= 0
    if  UnitExists(variables["havocEm"]) and not UnitIsDeadOrGhost(variables["havocEm"]) and UnitIsVisible(variables["havocEm"]) then
        havoc_remains = getDebuffRemain(variables["havocEm"],80240)
    end
    if --[[not UnitDebuffID("target",80240) and ]]getTalent(6,2) and 15-(180 - getSpellCD(1122))>getCastTime(116858) and variables["tgAn"]<=4 and ((108 * variables["tgAn"]%3)<(240*(1+0.08*getBuffStacks("player",266091))%2*(1+havoc_remains>getCastTime(116858)))) then
        -- body
        if castSpell("target",116858,false,true) then
            return 0;
        end
    end
    -- actions.fnb+=/immolate,cycle_targets=1,if=!debuff.havoc.remains&refreshable&spell_targets.incinerate<=8
    -- 献祭
    if --[[not UnitDebuffID("target",80240) and ]]getDebuffRemain("target",157736)<=2 and variables["tgAn"]<=8 then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end
    -- actions.fnb+=/rain_of_fire
    -- 火焰之雨
    if canCast(5740) then
        -- body
        castGround(variables["tgA"],5740,30,false)
    end
    -- actions.fnb+=/soul_fire,cycle_targets=1,if=!debuff.havoc.remains&spell_targets.incinerate=3
    -- 灵魂之火
    if getTalent(1,3) and canCast(6353) and --[[not UnitDebuffID("target",80240) and ]]variables["tgAn"]==3 then
        -- body
        if castSpell("target",6353,false,true) then
            return 0;
        end
    end
    -- actions.fnb+=/conflagrate,cycle_targets=1,if=!debuff.havoc.remains&(talent.flashover.enabled&buff.backdraft.stack<=2|spell_targets.incinerate<=7|talent.roaring_blaze.enabled&spell_targets.incinerate<=9)
    -- 燃烧 
    if --[[not UnitDebuffID("target",80240) and ]](getTalent(1,1) and getBuffStacks("player",117828)<=2 or variables["tgAn"]<=7 or getTalent(6,1) and variables["tgAn"] <= 9) then
        -- body
        if castSpell("target",17962,false,false) then
            return 0;
        end
    end
    -- actions.fnb+=/incinerate,cycle_targets=1,if=!debuff.havoc.remains
    -- 烧尽
    if not UnitDebuffID("target",80240) then
        if castSpell("target",29722,false,true) then
            return 0;
        end
    end
    self:rest();
end

function rotation:inf_action()
    local variables = self.variables;
    -- actions.inf=call_action_list,name=cds
    if baofa then
        self:cds_action()-- body
    end
    -- actions.inf+=/rain_of_fire,if=soul_shard>=4.5
    -- 火焰之雨
    if getSoulShards()>=4.5 and canCast(5740) then
        -- body
        castGround(variables["tgA"],5740,30,false)
    end
    -- actions.inf+=/cataclysm
    -- 大灾变
    if getTalent(4,3) and canCast(152108) then
        castGround(variables["tgA"],152108,30,true)
    end
    -- actions.inf+=/immolate,if=talent.channel_demonfire.enabled&!remains&cooldown.channel_demonfire.remains<=action.chaos_bolt.execute_time
    -- 献祭
    if getTalent(7,2) and getDebuffRemain("target",157736)<=3 and getSpellCD(196447)<=getCastTime(116858) then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end
    -- actions.inf+=/channel_demonfire
    -- 恶魔之火 天赋7-2
    if getTalent(7,2) and canCast(196447) then
        if castSpell("target",196447,false,true) then
            return 0;
        end
    end
    -- actions.inf+=/havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4+talent.internal_combustion.enabled&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    -- 浩劫
    -- actions.inf+=/havoc,if=spell_targets.rain_of_fire<=4+talent.internal_combustion.enabled&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    -- 浩劫
    if variables["havocTg"] and variables["tgAn"]<=4 and  getTalent(6,2) and getSpellCD(1122) > 165 and getSpellCD(1122)<=175 and getTimeToDie(variables["havocTg"])>10 then
        -- body
        if csi(variables["havocTg"],80240) then
            variables["havocEm"] = variables["havocTg"]
            return 0;
        end
    end
    -- actions.inf+=/chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&talent.grimoire_of_supremacy.enabled&pet.infernal.remains>execute_time&spell_targets.rain_of_fire<=4+talent.internal_combustion.enabled&((108*spell_targets.rain_of_fire%(3-0.16*spell_targets.rain_of_fire))<(240*(1+0.08*buff.grimoire_of_supremacy.stack)%2*(1+buff.active_havoc.remains>execute_time)))
    -- 混乱之箭
    local havoc_remains= 0
    if  UnitExists(variables["havocEm"]) and not UnitIsDeadOrGhost(variables["havocEm"]) and UnitIsVisible(variables["havocEm"]) then
        havoc_remains = getDebuffRemain(variables["havocEm"],80240)
    end
    if --[[not UnitDebuffID("target",80240) and ]]getTalent(6,2) and 15-(180 - getSpellCD(1122))>getCastTime(116858) and variables["tgAn"]<=4 and ((108 * variables["tgAn"]%(3-0.16*variables["tgAn"]))<(240*(1+0.08*getBuffStacks("player",266091))%2*(1+havoc_remains>getCastTime(116858)))) then
        -- body
        if castSpell("target",116858,false,true) then
            return 0;
        end
    end
    -- actions.inf+=/havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=3&(talent.eradication.enabled|talent.internal_combustion.enabled)
    -- 浩劫
    -- actions.inf+=/havoc,if=spell_targets.rain_of_fire<=3&(talent.eradication.enabled|talent.internal_combustion.enabled)
    -- 浩劫
    if variables["havocTg"] and variables["tgAn"]<=3 and (getTalent(1,2) or getTalent(2,2)) and getTimeToDie(variables["havocTg"])>10 then
        -- body
        if csi(variables["havocTg"],80240) then
            variables["havocEm"] = variables["havocTg"]
            return 0;
        end
    end
    -- actions.inf+=/chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&buff.active_havoc.remains>execute_time&spell_targets.rain_of_fire<=3&(talent.eradication.enabled|talent.internal_combustion.enabled)
    -- 混乱之箭
    if --[[not UnitDebuffID("target",80240) and ]]havoc_remains > getCastTime(116858) and variables["tgAn"]<=3 and (getTalent(1,2) or getTalent(2,2)) then
        -- body
        if castSpell("target",116858,false,true) then
            return 0;
        end
    end
    -- actions.inf+=/immolate,cycle_targets=1,if=!debuff.havoc.remains&refreshable
    -- 献祭
    if --[[not UnitDebuffID("target",80240) and ]]getDebuffRemain("target",157736)<=2 then
        -- body
        if castSpell("target",348,false,true) then
            return 0;
        end
    end

    -- actions.inf+=/rain_of_fire
    -- 火焰之雨
    if canCast(5740) then
        -- body
        castGround(variables["tgA"],5740,30,false)
    end
    -- actions.inf+=/soul_fire,cycle_targets=1,if=!debuff.havoc.remains
    -- 
    if getTalent(1,3) and canCast(6353) --[[and not UnitDebuffID("target",80240)]]then
        -- body
        if castSpell("target",6353,false,true) then
            return 0;
        end
    end
    -- actions.inf+=/conflagrate,cycle_targets=1,if=!debuff.havoc.remains
    -- 燃烧 
    if not UnitDebuffID("target",80240) then
        if castSpell("target",17962,false,false) then
            return 0;
        end
    end
    -- actions.inf+=/shadowburn,cycle_targets=1,if=!debuff.havoc.remains&((charges=2|!buff.backdraft.remains|buff.backdraft.remains>buff.backdraft.stack*action.incinerate.execute_time))
    -- 暗影灼烧
    if --[[not UnitDebuffID("target",80240) and ]]getTalent(2,3) and ((getCharges(17877)==2 or not UnitBuffID("player",117828) or getBuffRemain("player",117828)>getBuffStacks("player",117828)*getCastTime(29722))) then
        -- body
        if castSpell("target",17877,false,true) then
            return 0;
        end
    end
    -- actions.inf+=/incinerate,cycle_targets=1,if=!debuff.havoc.remains
    -- 烧尽
    if not UnitDebuffID("target",80240) then
        if castSpell("target",29722,false,true) then
            return 0;
        end
    end
    self:rest();
end
function rotation:pvp_action()
    local tg = "target"
    local zj = "player"
    local fz = "focus"
    local cs = castSpell
    local mo = "mouseover"
    local ls = getLastSpell()
    local mygcd = getGCDRemain()
    local de = getDebuffRemain
    local be = getBuffRemain
    local ic = getChargesFrac(17962)
    local rm = RunMacroText
    local sn = getEmber()

    if not isAlive(zj)  or IsMounted(zj) or UnitIsDeadOrGhost(tg) or not canAttack(zj,tg) or amac_bak(zj,0) == "恶魔之火" or amac_bak(zj,0) == "吸取生命" then
        return
    end 
    local isst,stt = isStun(zj) 
    if isst and stt >= 2.5 and stt<10 then
        
        if cs(zj,208683,false,false) then
            return
        end
        
        
    end


    if isInPvP() then
        castDispelCC(89808,3)
        if getMana(fz) <= 15 and hasDog() then
            petAttack(fz)
        end
        
        
        
        
    end


    if not isAlive(zj)  or IsMounted(zj) or UnitIsDeadOrGhost(tg) or not canAttack(zj,tg) or amac_bak(zj,0) == "恶魔之火" or amac_bak(zj,0) == "吸取生命" then
        return
    end 



    --dd fz
    if  UnitExists(fz) and amac(fz,1) and (isPlayer(fz) and isInPvP() or not isInPvP()) and not isMagicinv(fz)  then
        if hasDog() then
            if cs(fz,19647,false,false,true,true,_,true) then
                return
            end
        end
        
        
    end
    --dd
    if amac(tg,1) and  not isMagicinv(tg)  then
        if hasDog() then
            
            if cs(tg,19647,false,false,true,true,_,true) then
                return
            end
        end
        
        
    end
    if isInPvP() then

        GlobalIntCCm(19647)
            self:rest();
    end

    
    local tgn = getNumEnemies(tg,10) 
    if isInPvP() then
        tgn = getNumEnemiesp(zj,10)
    end
    if isInCombat(zj) and canAttack(zj,tg) and not isMagicinv(tg)  then
        if  getSpellCD(212295) < 1 and  (GlobalRef() == 1 or isCastingCCSpellLast1(tg) and UnitIsUnit(zj,tg..tg) or  isCastingCCSpellLast1(mo) and UnitIsUnit(zj,mo..tg) or  isCastingCCSpellLast1(fz) and UnitIsUnit(zj,fz..tg) ) then
            if amac_bak(zj,0) then
                rm("/stopcasting")
            end
            
            if castSpell(zj,212295,true,false) then
                return
            end     
        end
        if UnitExists(tg) and canPD(tg)  then
            if cspet(tg,19505) then
                return
            end
        end    
        if canCast(80240) and getDistance(tg,zj) <= 40 and getLineOfSight(tg,zj) then
            local tg2 =getOneEnemyWithoutHavok()
            if tg2  then
                if cs(tg2,80240,true,false,true) then
                    return
                end
            end
        end
    
          
        if getHP(zj) <= 50 then
            useItem(5512)
            cs(zj,119899,true,false)
        end       
        --强化生命分流
        
        --献祭             
        
        if  ls ~=  348 and ls ~= 152108   then 
            if de(tg,157736,zj) < xjre_setting.value + 1.5 and getTalent(4,3) and getDistance(tg) < 40  then
                if cs(tg,152108,false,true,false) then             
                    return                    
                end
            end   
            if (getTalent(4,3) and getSpellCD(152108) > 1 or not getTalent(4,3)  ) and de(tg,157736,zj) < xjre_setting.value   then

                if cs(tg,348,false,true,false) then             
                    return                
                end
            end
        end
        
        if tgn >= 3 and not isInPvP() and sn>= 3  then
            if cs(zj,5740,true,false) then
                return
            end
            
        end
        if tgn >= aoenum_setting.value and not isInPvP() and sn >= 3 and getDistance(tg) < 35 then
            if cs(tg,5740,true,false) then
                return;
            end            
        end
        
        --被打断
        if getSpellCD(29722) > 1.5 then
            if cs(tg,116858,false,true) then
                return;
            end
        end
        
        
        
        --mana
        if getHP(zj) > 60 and getMana(zj) < 20 then
            if cs(zj,1454) then
                return;
            end
        end
        
        
        --keep buff
        if getTalent(2,3) then
            if be(zj,235156) < 6 then
                if cs(zj,1454) then
                    return
                end
                
            end
            
        end
        
        --xj  
        
        if sn >= 4.2 and de(tg,157736,zj) >5 then
            if cs(tg,116858,false,true,false) then
                return;
            end        
        end
        
        --
        if getCharges(196586) >= 2.75 and ls~= 196586 or isMoving(zj) then
            if cs(tg,196586,true,false,true) then
                return;
            end
        end
        
        
        --bp
        if sn < 4 and de(tg,233582) == 0 and ls ~= 17962 then
            if cs(tg,17962,false,false,true) then
                return;
            end    
        end
        
        
        
        -- actions+=/conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remains&(charges=1&recharge_time<action.chaos_bolt.cast_time|charges=2)&soul_shard<5
        if  be(zj,117828) == 0 and (ic == 1  or ic >= 1.8 ) and sn < 4.5 then
            
            if cs(tg,17962,false,false,true) then
                return;
            end  
        end
        
        
        if sn >= 2 then
            if cs(tg,116858,false,true,true) then
                return;
            end 
        end
        
        
        
        if getTalent(7,2) and de(tg,157736,zj) > 4  then
            if cs(zj,196447,false,true,true) then
                return
            end
        end
        
        if ls~= 196586 and getSpellCD(17962) > 1 and be(zj,117828) == 0  then
            if cs(tg,196586,true,false,true) then
                return;
            end
        end
        
        if not isPlayer(tg) then
            if cs(tg,116858,false,true) then
                return;
            end
        end
        
        if de(tg,157736,zj) > xjre_setting.value + 1.2 and sn< 2 then
            if cs(tg,29722,false,true,true) then
                return;
            end
        end
        
        
        
        
    end


    self:rest();
end

function rotation:yibao_action()

    if castSpell("target",17962,false,true) then
        return 0;
    end

    if castSpell("target",2972,false,true) then
        return 0;
    end


    self:rest();
end

-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);