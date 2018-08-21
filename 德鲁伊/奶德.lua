----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "47bf9781-e0b2-43d5-94e8-9bfd128054c4";
-- 定义循环的英文名称。
local rotation_name = "Druid Restoration v1.02";
Scorpio("zeus."..rotation_name)("");
-- import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    L[rotation_name] = "德鲁伊-恢复"
    L["Welcome to use test module."] = "欢迎使用[德鲁伊-恢复]模块"
    L["condition_yes_message"] = "N/A"
    L["condition_no_message"] = "N/A"
    L["macro"] = "NDHSZ"
    -- 3 = "3"
    -- 6 = "6"
    -- 25 = "25"
    -- 30 = "30"
    -- 50 = "50"
    -- 70 = "70"
    -- 75 = "75"
    -- 80 = "80"
    -- 95 = "95"
    -- 99 = "99"
    -- L["GeneralWidth_65"] = "65"
    L["HealthValidator01-999"] = "请输入 0.1 - 99.9 的有效生命值"
    L["HealthValidator1-40"] = "请输入 1 - 40 的有效生命值"
    L["SpellOrItemCDValidator1-60"] = "请输入 1 - 60 的有效冷却时间" 

    L["Category1"] = "Ⅰ 常规设置"
    L["MountSetting"] = "坐骑停止治疗/输出"
    L["MountSettingDescription"] = "设置玩家坐骑状态/平静状态停止治疗/输出"
    L["OutSetting"] = "脱站停止治疗/输出"
    L["OutSettingDescription"] = "设置玩家脱站状态/平静状态停止治疗/输出"

    L["Category2"] = "Ⅱ 辅助设置"
    L["ProwlSetting"] = "智能猎豹潜行"
    L["ProwlSettingDescription"] = "设置玩家非战斗状态进入猎豹潜行状态"
    L["HealthStoneSetting"] = "自动治疗石"
    L["HealthStoneSettingDescription"] = "设置玩家何时自动使用治疗石的生命值百分比"
    L["RenewalSetting"] = "自动甘霖"
    L["RenewalSettingDescription"] = "设置玩家何时自动使用甘霖的生命值百分比"
    L["BarkskinSetting"] = "自动树皮术"
    L["BarkskinSettingDescription"] = "设置玩家何时自动使用树皮术的生命值百分比"

    L["Category3"] = "Ⅲ 急救设置"
    L["BearSetting"] = "智能熊形态"
    L["BearSettingDescription"] = "设置玩家战斗状态低生命值时熊形态"
    L["BearFormRotationSetting"] = "熊形态智能输出"
    L["BearFormRotationSettingDescription"] = "设置玩家战斗中在熊形态智能输出"
    L["IronbarkSetting"] = "智能铁木树皮"
    L["IronbarkSettingDescription"] = "设置玩家战斗时智能使用铁木树皮"
    L["IronbarkSettingOptionalValue1"] = "智能"
    L["IronbarkSettingOptionalValue2"] = "坦克"
    L["IronbarkSettingOptionalValue3"] = "自己"
    L["IronbarkHPSetting"] = "铁木树皮阈值"
    L["IronbarkHPSettingDescription"] = "设置玩家何时智能使用铁木树皮的生命值百分比"
   
    L["InnervateSetting"] = "智能激活"
    L["InnervateSettingDescription"] = "设置玩家战斗时智能使用激活"
    L["FlourishSetting"] = "智能繁盛"
    L["FlourishSettingDescription"] = "设置玩家战斗时智能使用繁盛"
    L["FlourishSettingOptionalValue1"] = "智能"
    L["FlourishSettingOptionalValue2"] = "常规"
    L["FlourishSettingOptionalValue3"] = "宁静"
    L["FlourishSettingOptionalValue4"] = "手动"

    L["Category4"] = "Ⅳ 团刷设置"
    L["TranquilitySetting"] = "智能保护宁静"
    L["TranquilitySettingDescription"] = "设置保护玩家施放宁静"
    L["WildGrowthPartySetting"] = "智能野性成长(小队)"
    L["WildGrowthPartySettingDescription"] = "设置小队中自动使用野性成长目标数\n默认：" .."3".. " 个"
    L["WildGrowthPartyHPSetting"] = "智能野性成长阈值(小队)"
    L["WildGrowthPartyHPSettingDescription"] = "设置小队中自动使用野性成长目标的生命值百分比\n默认：" ..'70'.. " %"
    L["WildGrowthRaidSetting"] = "智能野性成长(团队)"
    L["WildGrowthRaidSettingDescription"] = "设置团队中自动使用野性成长目标数\n默认：" ..'6'.." 个"
    L["WildGrowthRaidHPSetting"] = "智能野性成长阈值(团队)"
    L["WildGrowthRaidHPSettingDescription"] = "设置团队中自动使用野性成长目标的生命值百分比\n默认：" ..'70'.. " %"
    L["EfflorescenceSetting"] = "智能百花齐放"
    L["EfflorescenceSettingOptionalValue1"] = "智能"
    L["EfflorescenceSettingOptionalValue2"] = "坦克"
    L["EfflorescenceSettingOptionalValue4"] = "人群"
    L["EfflorescenceSettingDescription"] = "设置智能使用百花齐放的目标位置\n默认：" ..L["EfflorescenceSettingDefaultValue"].. " 位置"
    
    L["Category5"] = "Ⅴ 单刷设置"
    L["LifeBloomSetting"] = "智能生命绽放"
    L["LifeBloomSettingDescription"] = "设置智能使用生命绽放的目标"
    L["LifeBloomSettingOptionalValue1"] = "智能"
    L["LifeBloomSettingOptionalValue2"] = "坦克"
    L["LifeBloomSettingOptionalValue3"] = "自己"
    L["LifeBloomSettingOptionalValue4"] = "焦点"
    L["CenarionWardSetting"] = "智能塞纳里奥结界"
    L["CenarionWardSettingDescription"] = "设置玩家战斗时智能使用塞纳里奥结界"
    L["CenarionWardSettingOptionalValue1"] = "智能"
    L["CenarionWardSettingOptionalValue2"] = "坦克"
    L["CenarionWardSettingOptionalValue3"] = "自己"
    L["CenarionWardHPSetting"] = "塞纳里奥结界阈值"
    L["CenarionWardHPSettingDescription"] = "设置玩家何时智能使用塞纳里奥结界的生命值百分比"
    L["LifeBloomHPSetting"] = "智能生命绽放阈值"
    L["LifeBloomHPSettingDescription"] = "设置智能使用生命绽放目标的生命值百分比"
    L["SwiftmendSetting"] = "智能迅捷治愈"
    L["SwiftmendSettingDescription"] = "设置智能迅捷治愈的生命值百分比"
    L["RegrowthSetting"] = "智能愈合"
    L["RegrowthSettingDescription"] = "设置智能愈合的生命值百分比"
    L["AbundanceSetting"] = "智能丰饶愈合"
    L["AbundanceSettingDescription"] = "设置智能丰饶天赋愈合的生命值百分比"
    L["RejuvenationSetting"] = "智能回春术"
    L["RejuvenationSettingDescription"] = "设置智能使用回春术的生命值百分比"

    L["Category6"] = "Ⅵ 输出设置"
    L["MoonFireSetting"] = "智能月火术"
    L["MoonFireSettingDescription"] = "设置自动保持当前目标月火术DOT\n优先级：低"
    L["SunFireSetting"] = "智能阳炎术"
    L["SunFireSettingDescription"] = "设置智能保持当前目标阳炎术DOT\n优先级：低"
    L["SolarWrathSetting"] = "智能阳炎之怒"
    L["SolarWrathSettingDescription"] = "设置智能使用阳炎之怒攻击当前目标\n优先级：低"
end
L = _Locale
local rotation = zeus.rotation(rotation_id, L[rotation_name]);
-- 定义循环加载并可用时的消息，填入"N/A"则不显示。
rotation.condition_yes_message = L["Welcome to use test module."];
-- 定义循环加载并不可用时的消息，填入"N/A"则不显示。
rotation.condition_no_message = "N/A";
-- 定义循环的执行间隔（秒），如果不设默认是0.1。
rotation.interval = 0.1;
-- 定义模块专用宏命令，下面的例子会定义出：/zeus test [argument]。如果不需要宏控制，则删除下面一行。
rotation.macro = "ND";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
local GeneralSetting = rotation:create_setting_category("General0T1")
GeneralSetting.display_name =  L["Category1"]
-----------------------------------------------------------------------------
local MountSetting = GeneralSetting:create_setting("Mount8865")
MountSetting.display_name = L["MountSetting"]
MountSetting.description = L["MountSettingDescription"]
MountSetting.value_type = rotation_setting_type.plain
MountSetting.default_value = nil
MountSetting.optional_values = nil
MountSetting.can_enable_disable = true
MountSetting.is_enabled_by_default = true
MountSetting.value_width = 65
-----------------------------------------------------------------------------
local OutSetting = GeneralSetting:create_setting("Out71")
OutSetting.display_name = L["OutSetting"]
OutSetting.description = L["OutSettingDescription"]
OutSetting.value_type = rotation_setting_type.plain
OutSetting.default_value = nil
OutSetting.optional_values = nil
OutSetting.can_enable_disable = true
OutSetting.is_enabled_by_default = true
OutSetting.value_width = 65
-----------------------------------------------------------------------------
local UnAssistingSetting = rotation:create_setting_category("UnAssisting325")
UnAssistingSetting.display_name = L["Category2"]
-----------------------------------------------------------------------------
local ProwlSetting = UnAssistingSetting:create_setting("Prowl209")
ProwlSetting.display_name = L["ProwlSetting"]
ProwlSetting.description = L["ProwlSettingDescription"]
ProwlSetting.value_type = rotation_setting_type.plain
ProwlSetting.default_value = nil
ProwlSetting.optional_values = nil
ProwlSetting.can_enable_disable = true
ProwlSetting.is_enabled_by_default = true
ProwlSetting.value_width = 65
-----------------------------------------------------------------------------
local HealthStoneSetting = UnAssistingSetting:create_setting("HealthStone991")
HealthStoneSetting.display_name = L["HealthStoneSetting"]
HealthStoneSetting.description = L["HealthStoneSettingDescription"]
HealthStoneSetting.value_type = rotation_setting_type.number
HealthStoneSetting.default_value = 25
HealthStoneSetting.optional_values = nil
HealthStoneSetting.can_enable_disable = true
HealthStoneSetting.is_enabled_by_default = true
HealthStoneSetting.value_width = 65
HealthStoneSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9  or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local RenewalSetting = UnAssistingSetting:create_setting("Renewal9811")
RenewalSetting.display_name = L["RenewalSetting"]
RenewalSetting.description = L["RenewalSettingDescription"]
RenewalSetting.value_type = rotation_setting_type.number
RenewalSetting.default_value = 25
RenewalSetting.optional_values = nil
RenewalSetting.can_enable_disable = true
RenewalSetting.is_enabled_by_default = true
RenewalSetting.value_width = 65
RenewalSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9  or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local BarkskinSetting = UnAssistingSetting:create_setting("Renewal9812")
BarkskinSetting.display_name = L["BarkskinSetting"]
BarkskinSetting.description = L["BarkskinSettingDescription"]
BarkskinSetting.value_type = rotation_setting_type.number
BarkskinSetting.default_value = 30
BarkskinSetting.optional_values = nil
BarkskinSetting.can_enable_disable = true
BarkskinSetting.is_enabled_by_default = true
BarkskinSetting.value_width = 65
BarkskinSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9  or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local AssistingSetting = rotation:create_setting_category("Assisting12222")
AssistingSetting.display_name = L["Category3"]
-----------------------------------------------------------------------------
local BearSetting = AssistingSetting:create_setting("Bear_LowHealth110999")
BearSetting.display_name = L["BearSetting"]
BearSetting.description = L["BearSettingDescription"]
BearSetting.value_type = rotation_setting_type.number
BearSetting.default_value = 30
BearSetting.optional_values = nil
BearSetting.can_enable_disable = true
BearSetting.is_enabled_by_default = true
BearSetting.value_width = 65
BearSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local BearFormRotationSetting = AssistingSetting:create_setting("BearFormRotation87Y")
BearFormRotationSetting.display_name = L["BearFormRotationSetting"]
BearFormRotationSetting.description = L["BearFormRotationSettingDescription"]
BearFormRotationSetting.value_type = rotation_setting_type.plain
BearFormRotationSetting.default_value = nil
BearFormRotationSetting.optional_values = nil
BearFormRotationSetting.can_enable_disable = true
BearFormRotationSetting.is_enabled_by_default = true
BearFormRotationSetting.value_width = 65
-----------------------------------------------------------------------------
local IronbarkSetting = AssistingSetting:create_setting("IronbarkM12P")
IronbarkSetting.display_name = L["IronbarkSetting"]
IronbarkSetting.description = L["IronbarkSettingDescription"]
IronbarkSetting.value_type = rotation_setting_type.text
IronbarkSetting.default_value = L["IronbarkSettingOptionalValue1"]
IronbarkSetting.optional_values =  {
    L["IronbarkSettingOptionalValue1"],
    L["IronbarkSettingOptionalValue2"], 
    L["IronbarkSettingOptionalValue3"], 
}
IronbarkSetting.can_enable_disable = true
IronbarkSetting.is_enabled_by_default = true
IronbarkSetting.value_width = 65
-----------------------------------------------------------------------------
local IronbarkHPSetting = AssistingSetting:create_setting("IronbarkM12Q")
IronbarkHPSetting.display_name = L["IronbarkHPSetting"]
IronbarkHPSetting.description = L["IronbarkHPSettingDescription"]
IronbarkHPSetting.value_type = rotation_setting_type.number
IronbarkHPSetting.default_value = 30
IronbarkHPSetting.optional_values = nil
IronbarkHPSetting.can_enable_disable = true
IronbarkHPSetting.is_enabled_by_default = true
IronbarkHPSetting.value_width = 65
-----------------------------------------------------------------------------
local InnervateSetting = AssistingSetting:create_setting("Innervate9TTA8")
InnervateSetting.display_name = L["InnervateSetting"]
InnervateSetting.description = L["InnervateSettingDescription"]
InnervateSetting.value_type = rotation_setting_type.plain
InnervateSetting.default_value = nil
InnervateSetting.optional_values = nil
InnervateSetting.can_enable_disable = true
InnervateSetting.is_enabled_by_default = true
InnervateSetting.value_width = 65
-----------------------------------------------------------------------------
local FlourishSetting = AssistingSetting:create_setting("Flourish9H211")
FlourishSetting.display_name = L["FlourishSetting"]
FlourishSetting.description = L["FlourishSettingDescription"]
FlourishSetting.value_type = rotation_setting_type.text
FlourishSetting.default_value = L["FlourishSettingOptionalValue1"]
FlourishSetting.optional_values =  {
    L["FlourishSettingOptionalValue1"],
    L["FlourishSettingOptionalValue2"], 
    L["FlourishSettingOptionalValue3"], 
    L["FlourishSettingOptionalValue4"]
}
FlourishSetting.can_enable_disable = true
FlourishSetting.is_enabled_by_default = true
FlourishSetting.value_width = 65
-----------------------------------------------------------------------------
local MultipleAssistingSetting = rotation:create_setting_category("MultipleAssisting88A")
MultipleAssistingSetting.display_name = L["Category4"]
-----------------------------------------------------------------------------
local TranquilitySetting = MultipleAssistingSetting:create_setting("Tranquility99MM")
TranquilitySetting.display_name = L["TranquilitySetting"]
TranquilitySetting.description = L["TranquilitySettingDescription"]
TranquilitySetting.value_type = rotation_setting_type.plain
TranquilitySetting.default_value = nil
TranquilitySetting.optional_values = nil
TranquilitySetting.can_enable_disable = true
TranquilitySetting.is_enabled_by_default = true
TranquilitySetting.value_width = 65
-----------------------------------------------------------------------------
local WildGrowthPartySetting = MultipleAssistingSetting:create_setting("WildGrowthParty1222")
WildGrowthPartySetting.display_name = L["WildGrowthPartySetting"]
WildGrowthPartySetting.description = L["WildGrowthPartySettingDescription"]
WildGrowthPartySetting.value_type = rotation_setting_type.number
WildGrowthPartySetting.default_value = 3
WildGrowthPartySetting.optional_values = nil
WildGrowthPartySetting.can_enable_disable = true
WildGrowthPartySetting.is_enabled_by_default = true
WildGrowthPartySetting.value_width = 65
WildGrowthPartySetting.validator = function(self, value) return value >= 1 and value <= 40 or false,L["HealthValidator1-40"] end
-----------------------------------------------------------------------------
local WildGrowthPartyHPSetting = MultipleAssistingSetting:create_setting("WildGrowthPartyHP12222")
WildGrowthPartyHPSetting.display_name = L["WildGrowthPartyHPSetting"]
WildGrowthPartyHPSetting.description = L["WildGrowthPartyHPSettingDescription"]
WildGrowthPartyHPSetting.value_type = rotation_setting_type.number
WildGrowthPartyHPSetting.default_value = 70
WildGrowthPartyHPSetting.optional_values = nil
WildGrowthPartyHPSetting.can_enable_disable = true
WildGrowthPartyHPSetting.is_enabled_by_default = true
WildGrowthPartyHPSetting.value_width = 65
WildGrowthPartyHPSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local WildGrowthRaidSetting = MultipleAssistingSetting:create_setting("WildGrowthRaid998")
WildGrowthRaidSetting.display_name = L["WildGrowthRaidSetting"]
WildGrowthRaidSetting.description = L["WildGrowthRaidSettingDescription"]
WildGrowthRaidSetting.value_type = rotation_setting_type.number
WildGrowthRaidSetting.default_value = 6
WildGrowthRaidSetting.optional_values = nil
WildGrowthRaidSetting.can_enable_disable = true
WildGrowthRaidSetting.is_enabled_by_default = true
WildGrowthRaidSetting.value_width = 65
WildGrowthRaidSetting.validator = function(self, value) return value >= 1 and value <= 40 or false,L["HealthValidator1-40"] end
-----------------------------------------------------------------------------
local WildGrowthRaidHPSetting = MultipleAssistingSetting:create_setting("WildGrowthRaidHP9998")
WildGrowthRaidHPSetting.display_name = L["WildGrowthRaidHPSetting"]
WildGrowthRaidHPSetting.description = L["WildGrowthRaidHPSettingDescription"]
WildGrowthRaidHPSetting.value_type = rotation_setting_type.number
WildGrowthRaidHPSetting.default_value = 70
WildGrowthRaidHPSetting.optional_values = nil
WildGrowthRaidHPSetting.can_enable_disable = true
WildGrowthRaidHPSetting.is_enabled_by_default = true
WildGrowthRaidHPSetting.value_width = 65
WildGrowthRaidHPSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local EfflorescenceSetting = MultipleAssistingSetting:create_setting("EfflorescenceZ111")
EfflorescenceSetting.display_name = L["EfflorescenceSetting"]
EfflorescenceSetting.description = L["EfflorescenceSettingDescription"]
EfflorescenceSetting.value_type = rotation_setting_type.text
EfflorescenceSetting.default_value = L["EfflorescenceSettingOptionalValue1"] 
EfflorescenceSetting.optional_values = {
    L["EfflorescenceSettingOptionalValue1"],
    L["EfflorescenceSettingOptionalValue2"],
    L["EfflorescenceSettingOptionalValue3"]
}
EfflorescenceSetting.can_enable_disable = true
EfflorescenceSetting.is_enabled_by_default = true
EfflorescenceSetting.value_width = 65
EfflorescenceSetting.validator = nil
-----------------------------------------------------------------------------
local SingleAssistingSetting = rotation:create_setting_category("SingleAssisting1A")
SingleAssistingSetting.display_name =  L["Category5"]
-----------------------------------------------------------------------------
local LifeBloomSetting = SingleAssistingSetting:create_setting("LifeBloom1AC")
LifeBloomSetting.display_name = L["LifeBloomSetting"]
LifeBloomSetting.description = L["LifeBloomSettingDescription"]
LifeBloomSetting.value_type = rotation_setting_type.text
LifeBloomSetting.default_value = L["LifeBloomSettingOptionalValue1"]
LifeBloomSetting.optional_values = {
    L["LifeBloomSettingOptionalValue1"],
    L["LifeBloomSettingOptionalValue2"],
    L["LifeBloomSettingOptionalValue3"],
    L["LifeBloomSettingOptionalValue4"]
}
LifeBloomSetting.can_enable_disable = true
LifeBloomSetting.is_enabled_by_default = true
LifeBloomSetting.value_width = 65
LifeBloomSetting.validator = nil
-----------------------------------------------------------------------------
local CenarionWardSetting = SingleAssistingSetting:create_setting("Flourish9H2111")
CenarionWardSetting.display_name = L["CenarionWardSetting"]
CenarionWardSetting.description = L["CenarionWardSettingDescription"]
CenarionWardSetting.value_type = rotation_setting_type.text
CenarionWardSetting.default_value = L["CenarionWardSettingOptionalValue1"]
CenarionWardSetting.optional_values =  {
    L["CenarionWardSettingOptionalValue1"],
    L["CenarionWardSettingOptionalValue2"], 
    L["CenarionWardSettingOptionalValue3"]
}
CenarionWardSetting.can_enable_disable = true
CenarionWardSetting.is_enabled_by_default = true
CenarionWardSetting.value_width = 65
-----------------------------------------------------------------------------
local CenarionWardHPSetting = SingleAssistingSetting:create_setting("Flourish9H2112")
CenarionWardHPSetting.display_name = L["CenarionWardHPSetting"]
CenarionWardHPSetting.description = L["CenarionWardHPSettingDescription"]
CenarionWardHPSetting.value_type = rotation_setting_type.number
CenarionWardHPSetting.default_value = 50
CenarionWardHPSetting.optional_values =  nil
CenarionWardHPSetting.can_enable_disable = true
CenarionWardHPSetting.is_enabled_by_default = true
CenarionWardHPSetting.value_width = 65
-----------------------------------------------------------------------------
local LifeBloomHPSetting = SingleAssistingSetting:create_setting("LifeBloomHP00CCC")
LifeBloomHPSetting.display_name = L["LifeBloomHPSetting"]
LifeBloomHPSetting.description = L["LifeBloomHPSettingDescription"]
LifeBloomHPSetting.value_type = rotation_setting_type.number
LifeBloomHPSetting.default_value = 99
LifeBloomHPSetting.optional_values = nil
LifeBloomHPSetting.can_enable_disable = true
LifeBloomHPSetting.is_enabled_by_default = true
LifeBloomHPSetting.value_width = 65
LifeBloomHPSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local SwiftmendSetting = SingleAssistingSetting:create_setting("Swiftmend09AM")
SwiftmendSetting.display_name = L["SwiftmendSetting"]
SwiftmendSetting.description = L["SwiftmendSettingDescription"]
SwiftmendSetting.value_type = rotation_setting_type.number
SwiftmendSetting.default_value = 70
SwiftmendSetting.optional_values = nil
SwiftmendSetting.can_enable_disable = true
SwiftmendSetting.is_enabled_by_default = true
SwiftmendSetting.value_width = 65
SwiftmendSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local RegrowthSetting = SingleAssistingSetting:create_setting("Regrowth1ZZZ")
RegrowthSetting.display_name = L["RegrowthSetting"]
RegrowthSetting.description = L["RegrowthSettingDescription"]
RegrowthSetting.value_type = rotation_setting_type.number
RegrowthSetting.default_value = 75
RegrowthSetting.optional_values = nil
RegrowthSetting.can_enable_disable = true
RegrowthSetting.is_enabled_by_default = true
RegrowthSetting.value_width = 65
RegrowthSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local AbundanceSetting = SingleAssistingSetting:create_setting("Abundance8ZZ")
AbundanceSetting.display_name = L["AbundanceSetting"]
AbundanceSetting.description = L["AbundanceSettingDescription"]
AbundanceSetting.value_type = rotation_setting_type.number
AbundanceSetting.default_value = 80
AbundanceSetting.optional_values = nil
AbundanceSetting.can_enable_disable = true
AbundanceSetting.is_enabled_by_default = true
AbundanceSetting.value_width = 65
AbundanceSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local RejuvenationSetting = SingleAssistingSetting:create_setting("Rejuvenation8YYY")
RejuvenationSetting.display_name = L["RejuvenationSetting"]
RejuvenationSetting.description = L["RejuvenationSettingDescription"]
RejuvenationSetting.value_type = rotation_setting_type.number
RejuvenationSetting.default_value = 95
RejuvenationSetting.optional_values = nil
RejuvenationSetting.can_enable_disable = true
RejuvenationSetting.is_enabled_by_default = true
RejuvenationSetting.value_width = 65
RejuvenationSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,L["HealthValidator01-999"] end
-----------------------------------------------------------------------------
local RotationsSetting = rotation:create_setting_category("Rotations111111")
RotationsSetting.display_name = L["Category6"]
-----------------------------------------------------------------------------
local MoonFireSetting = RotationsSetting:create_setting("MoonFire0M1")
MoonFireSetting.display_name = L["MoonFireSetting"] 
MoonFireSetting.description = L["MoonFireSettingDescription"] 
MoonFireSetting.value_type = rotation_setting_type.plain
MoonFireSetting.default_value = nil
MoonFireSetting.optional_values = nil
MoonFireSetting.can_enable_disable = true
MoonFireSetting.is_enabled_by_default = true
MoonFireSetting.value_width = 65
-----------------------------------------------------------------------------
local SunFireSetting = RotationsSetting:create_setting("SunFire8UZ")
SunFireSetting.display_name = L["SunFireSetting"]
SunFireSetting.description = L["SunFireSettingDescription"]
SunFireSetting.value_type = rotation_setting_type.plain
SunFireSetting.default_value = nil
SunFireSetting.optional_values = nil
SunFireSetting.can_enable_disable = true
SunFireSetting.is_enabled_by_default = true
SunFireSetting.value_width = 65
-----------------------------------------------------------------------------
local SolarWrathSetting = RotationsSetting:create_setting("SolarWrath66T")
SolarWrathSetting.display_name = L["SolarWrathSetting"]
SolarWrathSetting.description = L["SolarWrathSettingDescription"]
SolarWrathSetting.value_type = rotation_setting_type.plain
SolarWrathSetting.default_value = nil
SolarWrathSetting.optional_values = nil
SolarWrathSetting.can_enable_disable = true
SolarWrathSetting.is_enabled_by_default = true
SolarWrathSetting.value_width = 65
-----------------------------------------------------------------------------
local Spells = {
    ["熊形态"] = 5487,
    ["猎豹形态"] = 768,
    ["旅行形态"] = 783,
    ["树人形态"] = 114282,
    ["雄鹿形态"] = 210053,
    ["乌索尔旋风"] = 102793,
    ["休眠"] = 2637,
    ["化身：生命之树"] = 33891,
    ["回春术"] = 774,
    ["复生"] = 20484,
    ["宁静"] = 740,
    ["安抚"] = 2908,
    ["急奔"] = 1850,
    ["愈合"] = 8936,
    ["新生"] = 212040,
    ["月火术"] = 8921,
    ["树皮术"] = 22812,
    ["潜行"] = 5215,
    ["激活"] = 29166,
    ["生命绽放"] = 33763,
    ["百花齐放"] = 145205,
    ["纠缠根须"] = 339,
    ["自然之愈"] = 88423,
    ["阳炎术"] = 93402,
    ["明月打击"] = 194153,
    ["起死回生"] = 50769,
    ["迅捷治愈"] = 18562,
    ["野性成长"] = 48438,
    ["铁木树皮"] = 102342,
    ["阳炎之怒"] = 5176,
    ["阳炎术"] = 93402,
    ["裂伤"] = 33917,
    ["痛击"] = 106832,
    ["狂暴回复"] = 22842,
    ["铁鬃"] = 192081,

    ["塞纳里奥结界"] = 102351, -- 1-3
    ["猛虎冲刺"] = 252216, -- 2-1
    ["甘霖"] = 108238, -- 2-2
    ["蛮力猛击"] = 5211, -- 4-1
    ["群体缠绕"] = 102359, -- 4-2
    ["台风"] = 132469, -- 4-3
    ["化身：生命之树"] = 102560, -- 5-3
    ["繁盛"] = 202770, -- 7-3

    ["影遁"] = 58984,
}

local Buff = {
    ["嗜血"] = 1,
    ["英勇"] = 2,
    ["时光扭曲"] = 3,
    ["高山战鼓"] = 4,
    ["生命绽放"] = 33763,
    ["愈合"] = 8936,
    ["回春术"] = 774,
    ["萌芽"] = 155777,
    ["树皮术"] = 22812,
    ["猛虎冲刺"] = 252216,
    ["节能施法"] = 16870,
    ["潜行"] = 5215,
    ["丰饶"] = 207640,
    ["野性成长"] = 48438,
    ["丛林之魂"] = 114108,
    ["激活"] = 29166,
    ["化身"] = 117679,
    ["生命之树"] = 33891,
    ["铁木树皮"] = 102342,
    ["繁盛"] = 197721,
    ["塞纳里奥结界"] = 102351,
    ["专注生长"] = 203554,
    ["铁鬃"] = 192081,
    ["狂暴回复"] = 22842,
    ["熊形态"] = 5487,
    ["猎豹形态"] = 768,
    ["旅行形态"] = 783,
    ["树人形态"] = 114282,
}

local Debuff = {
    ["月火术"] = 164812,
    ["阳炎术"] = 164815,
    ["蛮力猛击"] = 5211,
    ["纠缠根须"] = 339,
    ["休眠"] = 2637,
}

local Items = {
    ["治疗石"] = 5521,
}
local player, target, mouseover, focus = "player", "target", "mouseover", "focus"
function rotation:macro_handler(argument)
end
function rotation:condition_action()
    -- 编写判断模块是否可用的脚本。
    local combat = UnitAffectingCombat(player)
    local mount = MountSetting.is_enabled
    if ProwlSetting.is_enabled and not combat and not mount then
        castInsta(player, Spells["潜行"])
    end
    if OutSetting.is_enabled and not combat then
        return 0
    end
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 105 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
    return current_specialization == speci;
    -- return true
end
function rotation:prestart_action()
end
function rotation:prepause_action()
end
function rotation:prestop_action()
end
function rotation:precombat_action()
end
function rotation:default_action()
    local IsFlying = IsFlying
    noLos()
    local function Restoration_Rotation()
        local playerHP =  getHP(player)
        local playerMana = getMana(player)
        local gcd = getGCD()
        local combat = UnitAffectingCombat(player)
        local moving = isMoving("player")
        local default_lifebloom = 90
        local select, pairs, string, table = select, pairs, string, table
        local UnitExists, UnitIsFriend, UnitInParty, UnitInRaid = UnitExists, UnitIsFriend, UnitInParty, UnitInRaid
        local UnitCastingInfo, UnitChannelInfo = UnitCastingInfo, UnitChannelInfo
        local ht = getHT()
        if TranquilitySetting.is_enabled then
            if select(9, UnitChannelInfo(player)) == Spells["宁静"] then
                return 0
            end
        end
        if HealthStoneSetting.is_enabled then
            if playerHP <= HealthStoneSetting.value then
                useItem(Items["治疗石"])
                return 0
            end
        end
        if RenewalSetting.is_enabled then
            if playerHP <= RenewalSetting.value then
                castInsta(player, Spells["甘霖"])
                return 0
            end
        end
        if BearSetting.is_enabled then
            if playerHP <= BearSetting.value then
                castInsta(player, Spells["熊形态"])
                return 0
            else
                if getBuffRemain(player, Buff["熊形态"], player) then
                    castForm(1)
                    return 0
                end
            end
        end
        if BearFormRotationSetting.is_enabled then
            if getTalent(3, 3) then
                if getHP(player) <= BearSetting.value and getRage() >= 10 then
                    castInsta(player, Spells["狂暴回复"])
                    return 0
                end
                if getRage() >= 45 then
                    castInsta(player, Spells["铁鬃"])
                    return 0
                end
                castInsta(target, Spells["痛击"])
                return 0
            end
            castInsta(target, Spells["裂伤"])
            return 0
        end
        if IronbarkSetting.is_enabled then
            if IronbarkSetting.value == "智能" then
                if getHP(getLowestTank()) <= (IronbarkHPSetting.is_enabled and IronbarkHPSetting.value or 30) then
                    castInsta(getLowestTank(), Spells["铁木树皮"])
                    return 0
                elseif getHP(getLowestOther()) <= (IronbarkHPSetting.is_enabled and IronbarkHPSetting.value or 30) then
                    castInsta(getLowestOther(), Spells["铁木树皮"])
                    return 0
                end
            elseif IronbarkSetting.value == "坦克" then
                if getHP(getLowestTank()) <= (IronbarkHPSetting.is_enabled and IronbarkHPSetting.value or 30) then
                    castInsta(getLowestTank(), Spells["铁木树皮"])
                    return 0
                end
            elseif IronbarkSetting.value == "自己" then
                if getHP(player) <= (IronbarkHPSetting.is_enabled and IronbarkHPSetting.value or 30) then
                    if getBuffRemain(player, Buff["树皮术"], player) <= 0 then
                        castInsta(player, Spells["铁木树皮"])
                        return 0
                    end
                end
            end
        end
        if CenarionWardSetting.is_enabled then
            if CenarionWardSetting.value == "智能" then
                if getHP(getLowestOther()) <= (IronbarkHPSetting.is_enabled and IronbarkHPSetting.value or 50) then
                    if getBuffRemain(getLowestOther(), Buff["塞纳里奥结界"], player) <= 0 then
                        castInsta(getLowestOther(), Spells["塞纳里奥结界"])
                        return 0
                    end
                end
            elseif CenarionWardSetting.value == "坦克" then
                if getHP(getLowestTank()) <= (IronbarkHPSetting.is_enabled and IronbarkHPSetting.value or 50) then
                    if getBuffRemain(getLowestTank(), Buff["塞纳里奥结界"], player) <= 0 then
                        castInsta(getLowestTank(), Spells["塞纳里奥结界"])
                        return 0
                    end
                end
            elseif CenarionWardSetting.value == "自己" then
                if getHP(player) <= (CenarionWardHPSetting.is_enabled and CenarionWardHPSetting.value or 50) then
                    if getBuffRemain(player, Buff["塞纳里奥结界"], player) <= 0 then
                        castInsta(player, Spells["塞纳里奥结界"])
                        return 0
                    end
                end
            end
        end
        if WildGrowthPartySetting.is_enabled then
            if UnitInParty(player) then
                local count = 0
                local thisUnit
                for i = 1, #ht do
                    if getHP(ht[i].unit) <= (WildGrowthPartyHPSetting.is_enabled and WildGrowthPartyHPSetting.value or 70) then
                        count = count + 1
                        if getDistance(player, ht[i].unit) <= 40 then 
                            thisUnit = ht[i].unit
                        end
                    end
                end
                if count >= WildGrowthPartySetting.value or 3 then
                    castLong(thisUnit, Spells["野性成长"])
                    return 0
                end
            end
        end
        if WildGrowthRaidSetting.is_enabled then
            if UnitInRaid(player) then
                local count = 0
                local thisUnit
                for i = 1, #ht do
                    if getHP(ht[i].unit) <= (WildGrowthPartyHPSetting.is_enabled and WildGrowthPartyHPSetting.value or 75) then
                        count = count + 1
                        if getDistance(player, ht[i].unit) <= 40 then 
                            thisUnit = ht[i].unit
                        end
                    end
                end
                if count >= WildGrowthPartySetting.value or 6 then
                    castLong(thisUnit, Spells["野性成长"])
                    return 0
                end
            end
        end
        if EfflorescenceSetting.is_enabled then
            if EfflorescenceSetting.value == "智能" then
                castGroundAtBestLocation(Spells["百花齐放"], 5, 3, 40, 0, "heal")
                return 0
            elseif EfflorescenceSetting.value == "坦克" then
                cg(getLowestTank(), Spells["百花齐放"], 40)
                return 0
            elseif EfflorescenceSetting.value == "人群" then
                local thisUnit,lostest,count = getFocusHeal(40, 10)
                if count >= 2 and lostest > 200 then
                    cs(thisUnit,Spells["百花齐放"])
                    return 0
                end
            end
        end
        if LifeBloomSetting.is_enabled then
            if LifeBloomSetting.value == "智能" then
                if getHP(getLowestTank()) < 90 then
                    castInsta(getLowestTank(), Spells["生命绽放"])
                    return 0
                elseif getHP(target) <= (LifeBloomHPSetting.is_enabled and LifeBloomHPSetting.value or default_lifebloom) then
                    if getBuffRemain(target, Buff["生命绽放"], player) <= 0 and UnitExists(target) 
                        and UnitIsFriend(player, target) then
                        castInsta(target, Spells["生命绽放"])
                        return 0
                    end
                end
            elseif LifeBloomSetting.value == "坦克" then
                if getHP(this) <= (LifeBloomHPSetting.is_enabled and LifeBloomHPSetting.value or default_lifebloom) then
                    if getBuffRemain(getLowestTank(), Buff["生命绽放"], player) <= 0 and UnitExists(getLowestTank()) 
                    and UnitIsFriend(player, getLowestTank()) then
                        castInsta(getLowestTank(), Spells["生命绽放"])
                        return 0
                    end
                end
            elseif LifeBloomSetting.value == "自己" then
                if getHP(player) <= (LifeBloomHPSetting.is_enabled and LifeBloomHPSetting.value or default_lifebloom) then
                    if getBuffRemain(player, Buff["生命绽放"], player) <= 0 then
                        castInsta(player, Spells["生命绽放"])
                        return 0
                    end
                end
            elseif LifeBloomSetting.value == "焦点" then
                if getHP(focus) <= (LifeBloomHPSetting.is_enabled and LifeBloomHPSetting.value or default_lifebloom) then
                    if getBuffRemain(focus, Buff["生命绽放"], player) <= 0 and UnitExists(focus) 
                    and UnitIsFriend(player, focus) then
                        castInsta(focus, Spells["生命绽放"])
                        return 0
                    end
                end
            end
        end

        if SwiftmendSetting.is_enabled then
            for i = 1, #ht do
                if getHP(ht[i].unit) <= SwiftmendSetting.value then
                    if getDistance(player, ht[i].unit) <= 40 then
                        castInsta(ht[i].unit, Spells["迅捷治愈"])
                        return 0
                    end
                end
            end
        end

        if RegrowthSetting.is_enabled then
            for i = 1, #ht do
                if getHP(ht[i].unit) <= RegrowthSetting.value then
                    if getDistance(player, ht[i].unit) <= 40 then
                        castInsta(ht[i].unit, Spells["愈合"])
                        return 0
                    end
                end
            end
        end

        if AbundanceSetting.is_enabled then
            for i = 1, #ht do
                if getHP(ht[i].unit) <= AbundanceSetting.value and getBuffStacks(player, Buff["丰饶"], player) > 6 then
                    if getDistance(player, ht[i].unit) <= 40 then
                        castInsta(ht[i].unit, Spells["愈合"])
                        return 0
                    end
                end
            end
        end

        if RejuvenationSetting.is_enabled then
            for i = 1, #ht do
                if getHP(ht[i].unit) <= RejuvenationSetting.value and (getBuffRemain(ht[i].unit, Buff["回春术"], player) <= 15 * 0.3 or getBuffRemain(ht[i].unit, Buff["萌芽"], player) <= 15 * 0.3) then
                    if getDistance(player, ht[i].unit) <= 40 then
                        castInsta(ht[i].unit, Spells["回春术"])
                        return 0
                    end
                end
            end
        end
        if isEnemy(target) or isDummy(target) then
            if MoonFireSetting.is_enabled then
                if getDebuffRemain(target, Debuff["月火术"], player) <= 16 * 0.3 then
                    castInsta(target, Spells["月火术"])
                    return 0
                end
            end
            if SunFireSetting.is_enabled then
                if getDebuffRemain(target, Debuff["阳炎术"], player) <= 12 * 0.3 then
                    castInsta(target, Spells["阳炎术"])
                    return 0
                end
            end
            if moving then
                castInsta(target, Spells["月火术"])
                return 0
            end
            if SolarWrathSetting.is_enabled then
                castLong(target, Spells["阳炎之怒"])
                return 0
            end
        end
    end
    if not IsMounted(player) or not IsFlying() then
        Restoration_Rotation()
    end
end
rotation_manager.instance:register(rotation)