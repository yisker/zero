
-- import "zeus"
local specid = 102
local rotation_id = "82999753-b29f-401e-af0f-ec92956f855e"
local rotation_name = "Druid Balance"
Scorpio("zeus." .. rotation_name)("")
local L = _Locale("zhCN", true)
if L then
    L[rotation_name] = "德鲁伊-平衡"
    L["Welcome to use test module."] = "欢迎使用鹌鹑平衡德鲁伊模块"
    L["Test 1"] = "测试1号"
    L["Test 2"] = "测试2号"
    L["At least 2 values must be entered."] = "至少要输入2个值"
    L["Test Category"] = "测试类别"
    L["Test 3"] = "测试3号"
    L["Test 4"] = "测试4号"
    L["Test 5"] = "测试5号"
end
L = _Locale
local rotation = zeus.rotation(rotation_id, L[rotation_name])
rotation.condition_yes_message = L["Welcome to use test module."]
rotation.condition_no_message = "N/A"
rotation.interval = 0.1
rotation.macro = "Balance"
-------------------------------------------------------------------------------
local GeneralSetting = rotation:create_setting_category("General")
GeneralSetting.display_name = "❶ 常规设置"
-------------------------------------------------------------------------------
local SerenSetting = GeneralSetting:create_setting("Seren")
SerenSetting.display_name = "坐骑状态停止输出"
SerenSetting.description = "设置玩家坐骑状态/平静状态停止技能输出"
SerenSetting.value_type = rotation_setting_type.plain
SerenSetting.default_value = nil
SerenSetting.optional_values = nil
SerenSetting.can_enable_disable = true
SerenSetting.is_enabled_by_default = true
SerenSetting.value_width = 65
-------------------------------------------------------------------------------
local HealthzkmneSetting = GeneralSetting:create_setting("Healthzkmne")
HealthzkmneSetting.display_name = "治疗石阈值"
HealthzkmneSetting.description = "设置玩家何时自动使用治疗石的生命值百分比"
HealthzkmneSetting.value_type = rotation_setting_type.number
HealthzkmneSetting.default_value = 25
HealthzkmneSetting.optional_values = nil
HealthzkmneSetting.can_enable_disable = true
HealthzkmneSetting.is_enabled_by_default = true
HealthzkmneSetting.value_width = 65
HealthzkmneSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9  or false,"请输入 0.1 - 99.9 的有效生命值" end
-------------------------------------------------------------------------------
local UnAssistingSetting = rotation:create_setting_category("UnAssisting")
UnAssistingSetting.display_name = "❷ 非战斗辅助设置"
-------------------------------------------------------------------------------
local ProwlSetting = UnAssistingSetting:create_setting("Prowl");
ProwlSetting.display_name = "自动猎豹潜行"
ProwlSetting.description = "设置玩家非战斗状态自动进入猎豹潜行状态"
ProwlSetting.value_type = rotation_setting_type.plain
ProwlSetting.default_value = nil
ProwlSetting.optional_values = nil
ProwlSetting.can_enable_disable = true
ProwlSetting.is_enabled_by_default = true
ProwlSetting.value_width = 65
-------------------------------------------------------------------------------
local AssistingSetting = rotation:create_setting_category("Assisting")
AssistingSetting.display_name = "❸ 战斗辅助设置"
-------------------------------------------------------------------------------
local BearSetting = AssistingSetting:create_setting("Bear_LowHealth");
BearSetting.display_name = "自动低生命值熊形态"
BearSetting.description = "设置玩家战斗状态低生命值时自动进入熊形态"
BearSetting.value_type = rotation_setting_type.number
BearSetting.default_value = 30
BearSetting.optional_values = nil
BearSetting.can_enable_disable = true
BearSetting.is_enabled_by_default = true
BearSetting.value_width = 65
BearSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,"请输入 0.1 - 99.9 的有效生命值" end
-------------------------------------------------------------------------------
local BearFormRotationSetting = AssistingSetting:create_setting("BearFormRotation");
BearFormRotationSetting.display_name = "自动低生命值熊形态输出"
BearFormRotationSetting.description = "设置玩家战斗中在熊形态自动输出"
BearFormRotationSetting.value_type = rotation_setting_type.plain
BearFormRotationSetting.default_value = nil
BearFormRotationSetting.optional_values = nil
BearFormRotationSetting.can_enable_disable = true
BearFormRotationSetting.is_enabled_by_default = true
BearFormRotationSetting.value_width = 65
-------------------------------------------------------------------------------
local MoonkinFormSetting = AssistingSetting:create_setting("MoonkinForm");
MoonkinFormSetting.display_name = "自动枭兽形态"
MoonkinFormSetting.description = "设置玩家战斗中自动保持枭兽形态"
MoonkinFormSetting.value_type = rotation_setting_type.plain
MoonkinFormSetting.default_value = nil
MoonkinFormSetting.optional_values = nil
MoonkinFormSetting.can_enable_disable = true
MoonkinFormSetting.is_enabled_by_default = true
MoonkinFormSetting.value_width = 65
-------------------------------------------------------------------------------
local RegrowthSetting = AssistingSetting:create_setting("Regrowth")
RegrowthSetting.display_name = "自动使用愈合"
RegrowthSetting.description = "设置自动使用愈合的生命值百分比"
RegrowthSetting.value_type = rotation_setting_type.number
RegrowthSetting.default_value = 25
RegrowthSetting.optional_values = nil
RegrowthSetting.can_enable_disable = true
RegrowthSetting.is_enabled_by_default = true
RegrowthSetting.value_width = 65
RegrowthSetting.validator = function(self, value) return value >= 0.1 and value <= 99.9 or false,"请输入  0.1 - 99.9 的有效生命值" end
-------------------------------------------------------------------------------
local SolarBeamSetting = AssistingSetting:create_setting("SolarBeam")
SolarBeamSetting.display_name = "自动日光术"
SolarBeamSetting.description = "设置自动使用日光术打断目标施法"
SolarBeamSetting.value_type = rotation_setting_type.plain
SolarBeamSetting.default_value = nil
SolarBeamSetting.optional_values = nil
SolarBeamSetting.can_enable_disable = true
SolarBeamSetting.is_enabled_by_default = false
SolarBeamSetting.value_width = 65
-------------------------------------------------------------------------------
local DpsSetting = rotation:create_setting_category("Rotations")
DpsSetting.display_name = "❹ 战斗输出设置"
-------------------------------------------------------------------------------
local MultipleTargetSetting = DpsSetting:create_setting("MultipleRotation")
MultipleTargetSetting.display_name = "群体AOE输出"
MultipleTargetSetting.description = "设置自动群体AOE输出"
MultipleTargetSetting.value_type = rotation_setting_type.plain
MultipleTargetSetting.default_value = nil
MultipleTargetSetting.optional_values = nil
MultipleTargetSetting.can_enable_disable = true
MultipleTargetSetting.is_enabled_by_default = false
MultipleTargetSetting.value_width = 65
-------------------------------------------------------------------------------
local SingleTargetSetting = DpsSetting:create_setting("SingleRotation")
SingleTargetSetting.display_name = "单体输出"
SingleTargetSetting.description = "设置自动单体输出"
SingleTargetSetting.value_type = rotation_setting_type.plain
SingleTargetSetting.default_value = nil
SingleTargetSetting.optional_values = nil
SingleTargetSetting.can_enable_disable = true
SingleTargetSetting.is_enabled_by_default = true
SingleTargetSetting.value_width = 65
-------------------------------------------------------------------------------
local Spells = {
    ["枭兽形态"] = 24858,
    ["潜行"] = 5215,
    ["纠缠根须"] = 339,
    ["月火术"] = 8921,
    ["阳炎术"] = 93402,
    ["明月打击"] = 194153,
    ["阳炎之怒"] = 190984,
    ["星涌术"] = 78674,
    ["星辰坠落"] = 191034,
    ["超凡之盟"] = 194223,
    ["愈合"] = 8936,
    ["日光术"] = 78675,
    ["急奔"] = 1850,
    ["复生"] = 20484,
    ["起死回生"] = 50769,
    ["树皮术"] = 22812,
    ["清除腐蚀"] = 2782,
    ["安抚"] = 2908,
    ["激活"] = 29166,

    ["艾露恩的战士"] = 202425, -- 1-2
    ["自然之力"] = 205636, -- 1-3
    ["猛虎冲刺"] = 252216, -- 2-1
    ["甘霖"] = 108238, -- 2-2
    ["蛮力猛击"] = 5211, -- 4-1
    ["群体缠绕"] = 102359, -- 4-2
    ["台风"] = 132469, -- 4-3
    ["化身-艾露恩之眷"] = 102560, -- 5-3
    ["星辰耀斑"] =  202347, -- 6-3
    ["艾露恩之怒"] = 202770, -- 7-2
    ["新月"] = 274281, -- 7-3
    ["半月"] = 274282, -- 7-3
    ["满月"] = 274283, -- 7-3

    ["影遁"] = 58984,
}

local Buff = {
    ["嗜血"] = 1,
    ["英勇"] = 2,
    ["时光扭曲"] = 3,
    ["高山战鼓"] = 4,
    ["枭兽形态"] = 24858,
    ["月光增效"] = 164547,
    ["日光增效"] = 164545,
    ["枭兽狂怒"] = 157228,
    ["树皮术"] = 22812,
    ["猛虎冲刺"] = 252216,
    ["超凡之盟"] = 194223,
    ["潜行"] = 5215,
    ["愈合"] = 8936,
    ["艾露恩的战士"] = 202425,
    ["化身-艾露恩之眷"] = 102560,
}

local Debuff = {
    ["月火术"] = 164812,
    ["阳炎术"] = 164815,
    ["日光术"] = 81261,
    ["蛮力猛击"] = 5211,
    ["纠缠根须"] = 339,
}

local Items = {
    ["治疗石"] = 5521,
}
local player, target, mouseover, focus = "player", "target", "mouseover", "focus"
-------------------------------------------------------------------------------
function rotation:macro_handler(argument)
    -- if (not argument or argument == "") then
    --     print("这里应该显示参数说明。")
    -- else
    --     print("收到宏命令参数：", argument)
    -- end
end
function rotation:condition_action()
    local combat = UnitAffectingCombat(player)
    local prowl = ProwlSetting.is_enabled
    local seren = SerenSetting.is_enabled
    if ProwlSetting.is_enabled and not combat and not seren then
        castInsta(player, Spells["潜行"])
    end
    return specid == GetSpecializationInfo(GetSpecialization())
end
function rotation:prestart_action()
    -- if rotation_id == "f107a5a6-3bd5-4c54-9e43-506016056b41" and rotation:condition_action() then
    --     if Balance == nil then
    --         Balance = CreateFrame("Frame")
    --         Balance:SetScript("OnUpdate", BalanceOnUpdate)
    --     end
    -- end
end
function rotation:prepause_action()
end
function rotation:prezkmp_action()
end
function rotation:precombat_action()
end
function rotation:default_action()
    local function Balance_Rotation()
        local playerHP =  getHP(player)
        local playerMana = getMana(player)
        local playerPower = getLunarPower()
        local gcd = getGCD()
        local targets = getET()
        local target8 = getNumEnemies(player, 8)
        local target40 = getNumEnemies(player, 40)
        local combat = UnitAffectingCombat(player)
        local moving = isMoving("player")
        -------------------------------------------------------------------------------
        -- mk(40)
        -------------------------------------------------------------------------------
        local seren = SerenSetting.is_enabled
        local prowl = ProwlSetting.is_enabled
        local moonkin = MoonkinFormSetting.is_enabled
        local regrowth = RegrowthSetting.is_enabled
        local healthzkmne = HealthzkmneSetting.is_enabled
        if seren then
            if IsMounted(player) then 
                return 0 
            end
        end
        if moonkin then
            if not HasBuff("枭兽形态") then
                castInsta(player, Spells["枭兽形态"])
            end
        end
        if regrowth then
            if playerHP <= RegrowthSetting.value then
                castLong(player, Spells["愈合"])
            end
        end
        if healthzkmne then
            if playerHP <= HealthzkmneSetting.value then
                useItem(Items["治疗石"])
            end
        end
        -- if Multiple then

        -- end
        -- -------------------------------------------------------------------------------
        local single = SingleTargetSetting.is_enabled
        if single and canAttack(player, target) then
            if not HasDebuff("月火术") then
                castInsta(target, Spells["月火术"])
            end
            if not HasDebuff("阳炎术") then
                castInsta(target, Spells["阳炎术"])
            end
            if getTalent(1,2) then
                castInsta(target, Spells["艾露恩的战士"])
            end
            if (HasBuff("枭兽狂怒")) then
                castInsta(target, Spells["明月打击"])
            end
            if (HasBuff("艾露恩的战士")) and BuffStack("日光增效") < 3 then
                castInsta(target, Spells["明月打击"])
            end
            if (HasBuff("月光增效")) and BuffStack("日光增效") < 3 then
                castLong(target, Spells["明月打击"])
            end
            if BuffStack("月光增效") < 3 and BuffStack("日光增效") < 3 then
                castInsta(target, Spells["星涌术"])
            end
            if getDebuffRemain(target, Debuff["阳炎术"], player) <= 18 * 0.3 then
                castInsta(target, Spells["阳炎术"])
            end
            if getDebuffRemain(target, Debuff["月火术"], player) <= 22 * 0.3 then
                castInsta(target, Spells["月火术"])
            end
            if BuffStack("日光增效") > 0 then
                castLong(target, Spells["阳炎之怒"])
            end
            if not isMoving(player) then
                castLong(target, Spells["明月打击"])
            end
            -- if target8 >= 3 then
            --     castInsta(player, Spells["超凡之盟"])
            -- end   
            -- if target8 >= 3 then
            --     castInsta(player, Spells["化身-艾露恩之眷"])
            -- end
            -- local tar,enemies = getBiggestUnitCluster(40, 15)
            -- if tar and enemies then
            --     cg(tar, Spells["星辰坠落"], 40)
            -- end
            -- if target8 >= 3 then
            --     castInsta(player, Spells["艾露恩的战士"])
            -- end
        end
        -------------------------------------------------------------------------------
    end
    Balance_Rotation()
end
-----------------------------------------------------------
-- Something here be do uself
-----------------------------------------------------------
function HasBuff(buffName)
    if buffName then
        return getBuffRemain(player, Buff[buffName], player) > 0 or getBuffStacks(player, Buff[buffName], player) > 0
    end
    return false
end
function HasDebuff(buffName)
    if buffName then
        return getDebuffRemain(target, Debuff[buffName], player) > 3
    end
    return false
end
function BuffStack(buffName)
    if buffName then
        return getBuffStacks(player, Buff[buffName], player)
    end
    return 0
end
-- function CanRefreshDot(dotName)
--     if dotName then
--         for i = 1, #target40 do
--             if bs(target40[i], dotName) <= 3 then
--                 return true, target40[i]
--             end
--         end
--     end
--     return false
-- end
-- function DotRemainingSec(dotName)
--     if dotName then
--         for i = 1, #target40 do
--             if de(target40[i], dotName, player) <= 3  then
--                 return target40[i], de(target40[i], dotName, player)
--             end
--         end
--     end
--     return 0
-- end

rotation_manager.instance:register(rotation)