-----------------------------------------------------------
-- 模块属
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-- https://1024tools.com/uuid
local rotation_id = "08d37fa5-a411-4b0b-8859-8acc83731c78"
-- 定义循环的英文名称。
local rotation_name = "death-blood"
Scorpio("zeus." .. rotation_name)("")
local rotation = zeus.rotation(rotation_id, "死亡骑士-鲜血")
rotation.condition_yes_message = "N/A"
rotation.condition_no_message = "N/A"
rotation.interval = 0.1
rotation.macro = "dkt"

-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------

local shuoming = rotation:create_setting_category("/zkm dkt m 创建宏")
shuoming.display_name = "/zkm dkt m 创建宏"
local test_category1 = rotation:create_setting_category("一般选项")
test_category1.display_name = "一般设置"
-- 自动打断
local ddkg_setting = test_category1:create_setting("ddset")
ddkg_setting.display_name = "自动打断及施法进度"
ddkg_setting.description = "自动打断及施法进度百分比数值"
ddkg_setting.value_type = rotation_setting_type.number
ddkg_setting.default_value = 20
ddkg_setting.can_enable_disable = true
ddkg_setting.is_enabled_by_default = true
ddkg_setting.value_width = 50
ddkg_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end

local HPcategory = rotation:create_setting_category("减伤设置")
HPcategory.display_name = "减伤设置"
-- 灵界打击
local ljdjsz1_setting = HPcategory:create_setting("ljdjset")
ljdjsz1_setting.display_name = "灵界打击"
ljdjsz1_setting.description = "当血量低于该值时使用该技能"
ljdjsz1_setting.value_type = rotation_setting_type.number
ljdjsz1_setting.default_value = 70
ljdjsz1_setting.can_enable_disable = false
--ljdjsz1_setting.is_enabled_by_default = true;
ljdjsz1_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
ljdjsz1_setting.value_width = 50

-- 减伤个数
local jsgs1_setting = HPcategory:create_setting("jsnum")
jsgs1_setting.display_name = "同时开减伤个数"
jsgs1_setting.description = "防止掉血过多时，减伤全开"
jsgs1_setting.value_type = rotation_setting_type.number
jsgs1_setting.default_value = 2
jsgs1_setting.can_enable_disable = false
--jsgs1_setting.is_enabled_by_default = true;
jsgs1_setting.validator = function(self, value)
    if (value > 10) or (value < 1) then
        return false
    else
        return true
    end
end
jsgs1_setting.value_width = 50
-- 吸血鬼之血
local xxgsz1_setting = HPcategory:create_setting("xxgset")
xxgsz1_setting.display_name = "吸血鬼之血"
xxgsz1_setting.description = "当血量低于该值时使用该技能"
xxgsz1_setting.value_type = rotation_setting_type.number
xxgsz1_setting.default_value = 70
xxgsz1_setting.can_enable_disable = true
xxgsz1_setting.is_enabled_by_default = true
xxgsz1_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
xxgsz1_setting.value_width = 50
-- 冰封之刃
local bfzrsz1_setting = HPcategory:create_setting("bfzrset")
bfzrsz1_setting.display_name = "冰封之刃"
bfzrsz1_setting.description = "当血量低于该值时使用该技能"
bfzrsz1_setting.value_type = rotation_setting_type.number
bfzrsz1_setting.default_value = 40
bfzrsz1_setting.can_enable_disable = true
bfzrsz1_setting.is_enabled_by_default = true
bfzrsz1_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
bfzrsz1_setting.value_width = 50
-- 符文剑舞
local fwrwsz1_setting = HPcategory:create_setting("fwrwset")
fwrwsz1_setting.display_name = "符文剑舞"
fwrwsz1_setting.description = "当血量低于该值时使用该技能"
fwrwsz1_setting.value_type = rotation_setting_type.number
fwrwsz1_setting.default_value = 50
fwrwsz1_setting.can_enable_disable = true
fwrwsz1_setting.is_enabled_by_default = true
fwrwsz1_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
fwrwsz1_setting.value_width = 50
-- 反魔法护罩
local fmfhzsz1_setting = HPcategory:create_setting("fmfhzset")
fmfhzsz1_setting.display_name = "反魔法护罩"
fmfhzsz1_setting.description = "点出 4-2 天赋时，当血量低于该值时使用该技能"
fmfhzsz1_setting.value_type = rotation_setting_type.number
fmfhzsz1_setting.default_value = 70
fmfhzsz1_setting.can_enable_disable = true
fmfhzsz1_setting.is_enabled_by_default = false
fmfhzsz1_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
fmfhzsz1_setting.value_width = 50
local ms_setting = HPcategory:create_setting("msset")
ms_setting.display_name = "墓石"
ms_setting.description = "点出 3-3 天赋时，当血量低于该值时使用该技能"
ms_setting.value_type = rotation_setting_type.number
ms_setting.default_value = 70
ms_setting.can_enable_disable = true
ms_setting.is_enabled_by_default = true
ms_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
ms_setting.value_width = 50
-- 治疗石头
local zlssz1_setting = HPcategory:create_setting("zlsset")
zlssz1_setting.display_name = "治疗石"
zlssz1_setting.description = "当血量低于该值时使用该技能"
zlssz1_setting.value_type = rotation_setting_type.number
zlssz1_setting.default_value = 30
zlssz1_setting.can_enable_disable = true
zlssz1_setting.is_enabled_by_default = true
zlssz1_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
zlssz1_setting.value_width = 50
local castcategory = rotation:create_setting_category("循环设置")
castcategory.display_name = "循环设置"
-- 骨盾层数
local bgzdsz1_setting = castcategory:create_setting("bgzdset")
bgzdsz1_setting.display_name = "骨盾层数阈值"
bgzdsz1_setting.description = "在循环中保持骨盾的层数"
bgzdsz1_setting.value_type = rotation_setting_type.number
bgzdsz1_setting.default_value = 6
bgzdsz1_setting.can_enable_disable = false
--bgzdsz1_setting.is_enabled_by_default = true;
bgzdsz1_setting.validator = function(self, value)
    if (value > 10) or (value < 1) then
        return false
    else
        return true
    end
end
bgzdsz1_setting.value_width = 50
-- 自动嘲讽
local zdcf_setting = castcategory:create_setting("cfset")
zdcf_setting.display_name = "自动嘲讽"
zdcf_setting.description = "在自动嘲讽丢失仇恨的小怪"
zdcf_setting.value_type = rotation_setting_type.plain
zdcf_setting.can_enable_disable = true
zdcf_setting.is_enabled_by_default = true
-- 白骨风暴
local bgfbkg1_setting = castcategory:create_setting("bgfbset")
bgfbkg1_setting.display_name = "白骨风暴及人数"
bgfbkg1_setting.description = "在循环中达到人数后释放白骨风暴，如果你点了白骨风暴天赋"
bgfbkg1_setting.value_type = rotation_setting_type.number
bgfbkg1_setting.default_value = 3
bgfbkg1_setting.can_enable_disable = true
bgfbkg1_setting.is_enabled_by_default = true
bgfbkg1_setting.value_width = 50
bgfbkg1_setting.validator = function(self, value)
    if (value < 1) then
        return false
    else
        return true
    end
end

-- 枯萎凋零
local kwdlkg1_setting = castcategory:create_setting("kwdlset")
kwdlkg1_setting.display_name = "枯萎凋零"
kwdlkg1_setting.description = "在循环中非移动状态下在玩家脚下释放枯萎凋零"
kwdlkg1_setting.value_type = rotation_setting_type.plain
kwdlkg1_setting.can_enable_disable = true
kwdlkg1_setting.is_enabled_by_default = true
-- 保留一层血液沸腾
local ycxf1_setting = castcategory:create_setting("xyftset")
ycxf1_setting.display_name = "保留一层血液沸腾"
ycxf1_setting.description = "在循环中保留一层血液沸腾"
ycxf1_setting.value_type = rotation_setting_type.plain
ycxf1_setting.can_enable_disable = true
ycxf1_setting.is_enabled_by_default = false
-- 鲜血印记
local xxyj_setting = castcategory:create_setting("xxyjset")
xxyj_setting.display_name = "自动鲜血印记"
xxyj_setting.description = "对周围血量较多的目标上鲜血印记"
xxyj_setting.value_type = rotation_setting_type.plain
xxyj_setting.can_enable_disable = true
xxyj_setting.is_enabled_by_default = true
-- 血债血偿
local xzxc_setting = castcategory:create_setting("xzxcset")
xzxc_setting.display_name = "|cff990000血债血偿|r"
xzxc_setting.description = "血债血偿最低血量"
xzxc_setting.value_type = rotation_setting_type.number
xzxc_setting.default_value = 50
xzxc_setting.can_enable_disable = true
xzxc_setting.is_enabled_by_default = true
xzxc_setting.value_width = 50
xzxc_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
-- 杀戮意图
local slyt_setting = castcategory:create_setting("slytset")
slyt_setting.display_name = "|cff990000杀戮意图|r"
slyt_setting.description = "杀戮意图开关"
slyt_setting.value_type = rotation_setting_type.plain
slyt_setting.default_value = nil
slyt_setting.can_enable_disable = true
slyt_setting.is_enabled_by_default = true
slyt_setting.value_width = 50
slyt_setting.validator = nil
-- 死亡锁链
local swsl_setting = castcategory:create_setting("swslset")
swsl_setting.display_name = "|cff990000死亡锁链|r"
swsl_setting.description = "在循环中达到人数后释放死亡锁链，如果你点了死亡锁链天赋"
swsl_setting.value_type = rotation_setting_type.number
swsl_setting.default_value = 2
swsl_setting.can_enable_disable = true
swsl_setting.is_enabled_by_default = true
swsl_setting.value_width = 50
swsl_setting.validator = function(self, value)
    if (value < 1) then
        return false
    else
        return true
    end
end
-----------------------------------------------------------
-- 控制UI
-----------------------------------------------------------
local bgfbxhkg = false
local kwdjkey = false
local ddkey = false
local ddfocuskey = false
local tgql = false
local plql = false
local zxkey = false
local zxfocuskey = false
local cfkey = false
local keykg = false
local dlkey = false
local dlfocuskey = false
local fmflykey = false
-------技能引用-------
local ddspell = 47528
-------通用技能-------
local zx = 221562 ----窒息
local haml = 56222 ----黑暗命令
local kwdl = 43265 ----枯萎凋零
local xlbd = 47528 ----心灵冰冻
local ljdj = 49998 ----灵界打击
local hyb = 212552 ----幻影步
local hayz = 178819 -----黑暗援助
local fmfhz = 48707 ----反魔法护罩
-------血DK技能-------
local ggfl = 195182 ----骨骼分裂
local xzdj = 206930 ----心脏打击
local bgfb = 194844 ----白骨风暴
local xyft = 50842 ----血液沸腾
local ssfw = 195292 ----死神抚慰
local xmzw = 108199 ----血魔之握
local xxg = 55233 ----吸血鬼
local bfzr = 48792 ----冰封之刃
local fwrw = 49028 ----符文剑舞
local fhmy = 61999 ----复活盟友
local yxz = 206931 ----饮血者
local xxyj = 206940 ----鲜血印记
local ms = 219809 ----墓室
local fwfl = 194679 ----符文分流
local fwdj = 210764 ----符文打击
local sqts = 274156 ----吞噬
local swsl = 203173 --死亡锁链
local slyt = 207018 --杀戮意图
local xzxc = 233411 --雪灾血肠
local pvpzx = 47476 ---- 窒息
local fmfly = 51052 ----反魔法领域
-------血DK BUFF-------
local bgzd = 195181 ----白骨之盾
local dlbf = 188290 ----凋零BUFF
local cstz = 81141 ----赤色天灾
-------血DK DEBUFF-------
local xzyb = 55078 ----血之疫病
local kh = 206891 ----恐吓
local Macro = {
    ["打断-zkm-dkt"] = "#showtooltip 心灵冰冻\n/zkm dkt dd\n",
    ["打断焦点-zkm-dkt"] = "#showtooltip 心灵冰冻\n/zkm dkt ddfocus\n",
    ["目标群拉-zkm-dkt"] = "#showtooltip 血魔之握\n/zkm dkt xmzw\n",
    ["自身群拉-zkm-dkt"] = "#showtooltip 血魔之握\n/zkm dkt xmzwplayer\n",
    ["窒息-zkm-dkt"] = "#showtooltip 窒息\n/zkm dkt zx\n",
    ["窒息焦点-zkm-dkt"] = "#showtooltip 窒息\n/zkm dkt zxfocus\n",
    ["枯萎凋零-zkm-dkt"] = "#showtooltip 枯萎凋零\n/zkm dkt kwdl\n",
    ["反魔法领域-zkm-dkt"] = "#showtooltip 反魔法领域\n/zkm dkt fmfly\n",
    ["嘲讽上病-zkm-dkt"] = "#showtooltip 黑暗命令\n/zkm dkt cf\n",
    ["白骨风暴-zkm-dkt"] = "#showtooltip 白骨风暴\n/zkm dkt bgfb\n",
    ["死亡之握-zkm-dkt"] = "#showtooltip 死亡之握\n/zkm dkt dl\n",
    ["死亡之握焦点-zkm-dkt"] = "#showtooltip 死亡之握\n/zkm dkt dlfocus\n"
}
-----------------------------------------------------------
function rotation:macro_handler(argument)
    if argument == "m" then
        for k, v in pairs(Macro) do
            local n = 0
            for i = 1, MAX_ACCOUNT_MACROS do
                local index = MAX_ACCOUNT_MACROS - i
                local name, texture, body = GetMacroInfo(index)
                if name == k then
                    n = n + 1
                end
                if n == 1 and name == k and body ~= v then
                    EditMacro(index, k, "INV_MISC_QUESTIONMARK", v)
                    print("已经修正宏:" .. k)
                end
                if n > 1 and name == k then
                    DeleteMacro(index)
                    print("删除多余宏" .. k)
                    n = n - 1
                end
            end
            if n == 0 then
                CreateMacro(k, "INV_MISC_QUESTIONMARK", v)
                print("已经创建宏:" .. k)
            end
        end
    end
    if argument == "bgfb" then
        bgfbxhkg = not bgfbxhkg
        if bgfbxhkg == true then
            api.log_message(log_level.important, "白骨风暴：开启", false, true, true)
        end
        if bgfbxhkg == false then
            api.log_message(log_level.important, "白骨风暴：关闭", false, true, true)
        end
    end
    if argument == "kwdl" then
        if getSpellCD(43265) <= getGCD() then
            kwdjkey = true
        end
    end
    if argument == "fmfly" then
        if isKnown(51052) and getSpellCD(51052) <= getGCD() then
            fmflykey = true
        end
    end
    if argument == "dd" then
        if getSpellCD(ddspell) == 0 then
            if amac("target", 1, 0) then
                ddkey = true
            end
            if amac("mouseover", 1, 0) then
                ddkey = true
            end
        end
    end
    if argument == "ddfocus" then
        if getSpellCD(ddspell) == 0 then
            if amac("focus", 1, 0) then
                ddfocuskey = true
            end
        end
    end
    if argument == "zx" then
        if UnitExists("target") or UnitExists("mouseover") then
            if getSpellCD(221562) <= getGCD() then
                zxkey = true
            end
        end
    end
    if argument == "zxfocus" then
        if UnitExists("focus") then
            if getSpellCD(221562) <= getGCD() then
                zxfocuskey = true
            end
        end
    end
    if argument == "xmzw" then
        if getSpellCD(108199) <= getGCD() then
            if UnitExists("target") then
                tgql = true
            end
        end
    end
    if argument == "xmzwplayer" then
        if getSpellCD(108199) <= getGCD() then
            if UnitExists("player") then
                plql = true
            end
        end
    end
    if argument == "cf" then
        if UnitExists("target") or UnitExists("mouseover") then
            cfkey = true
        end
    end
    if argument == "dl" then
        if UnitExists("target") or UnitExists("mouseover") then
            if getSpellCD(49576) <= getGCD() then
                dlkey = true
            end
        end
    end
    if argument == "dlfocus" then
        if UnitExists("focus") then
            if getSpellCD(49576) <= getGCD() then
                dlfocuskey = true
            end
        end
    end
end
function rotation:condition_action()
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    return current_specialization == 250
end
-----------------------------------------------------------

local function canDo(Unit, SpellID)
    return castSpell(Unit, SpellID, false, false, true, _, _, _, _, true)
end
local function targetfilter(u)
    return IsSpellInRange(GetSpellInfo(49998), u) == 1 and ObjectIsFacing("player", u)
end
local function xxyjfilter(u)
    return isKnown(xxyj) and IsSpellInRange(GetSpellInfo(xxyj), u) == 1 and IsUsableSpell(xxyj) and
        getSpellCD(xxyj) < 0.5 and
        getDebuffRemain(u, xxyj, "player") < getGCD() and
        UnitTarget(u) ~= nil and
        ObjectGUID(UnitTarget(u)) == ObjectGUID("player") and
        getHP(u) > 20
end
local function getXxyjtarget()
    local aaa = getET()
    local tar
    local tarh

    if tarh == nil then
        tarh = 0
    end
    for i = 1, #aaa do
        local tg1 = aaa[i]
        if xxyjfilter(tg1) and UnitHealth(tg1) >= tarh then
            tar = tg1
            tarh = getHP(tg1)
        end
    end
    return tar
end
local function getCastTarget()
    local tar
    local tar2 = getOneEnemy(10, targetfilter)
    if
        UnitExists("target") and isAlive("target") and canAttack("player", "target") and
            IsSpellInRange(GetSpellInfo(49998), "target") == 1 and
            ObjectIsFacing("player", "target")
     then
        tar = "target"
    else
        if tar2 ~= nil then
            tar = tar2
        else
            tar = "target"
        end
    end
    return tar, tar2
end
local NeedInsertSpell = {
    [49576] = 1, --死亡之握
    [221562] = 1, --窒息
    [212552] = 1, --幻影步
    [49028] = 1, --符文剑舞
    [61999] = 1, --复活盟友
    [206931] = 1, --饮血者
    [206940] = 1, --鲜血印记
    [219809] = 1, --墓石
    [194679] = 1, --符文分流
    [195292] = 1, --死神抚慰
    [50842] = 1, --血液沸腾
    [203173] = 1, --死亡锁链
    [108199] = 1, --血魔之握
    [207018] = 1, --杀戮意图
    [47476] = 1, --PVP  窒息
    [49998] = 2, --灵界打击
    [195182] = 2, --骨骼分裂
    [210764] = 2, --符文打击
    [206930] = 2, --心脏打击
    [233411] = 2, --雪灾血肠
    [274156] = 2 --吞噬
}
local function InsertSpell()
    for k, v in pairs(NeedInsertSpell) do
        if FailSpell == k and GetTime() - Failtime < getGCD() and aaa == "尚未恢复" and getSpellCD(FailSpell) <= getGCD() then
            InsertSpells = FailSpell
        else
            Inserttarget = nil
            InsertSpells = nil
        end
        --[[         if IsAltKeyDown() and InsertSpells ~= nil then
            if UnitExists("focus") then
                Inserttarget = "focus"
            end
        end ]]
        if InsertSpells ~= nil and Inserttarget == nil then
            if v == 1 then
                Inserttarget = "target"
            elseif v == 2 then
                Inserttarget = getCastTarget()
            end
        end
        if Inserttarget ~= nil and InsertSpells ~= nil then
            if castInsta(Inserttarget, InsertSpells) then
                break
            end
            return true
        end
    end
end
local function DKT_control()
    if GetSpecializationInfo(GetSpecialization()) == 250 then
        if getLastSpell() == 194844 then
            bgfbxhkg = false
            api.log_message(log_level.important, "白骨风暴：关闭", false, true, true)
        end
        if bgfbxhkg == true then
            api.log_message(log_level.important, "白骨风暴：开启", false, true, true)
            if not getTalent(7, 3) or getSpellCD(194844) > 4 then
                bgfbxhkg = false
                api.log_message(log_level.important, "白骨风暴：关闭", false, true, true)
            end
        end
        if UnitAffectingCombat("player") then
            keykg = true
        end
        if keykg == true then
            if not UnitAffectingCombat("player") then
                bgfbxhkg = false
                ddkey = false
                ddfocuskey = false
                cfkey = false
                plql = false
                tgql = false
                zxkey = false
                zxfocuskey = false
                keykg = false
                dlkey = false
                dlfocuskey = false
                fmflykey = false
            end
        end
        do
            if IsCurrentSpell("枯萎凋零") or IsCurrentSpell("反魔法领域") then
                kwdjkey = false
                fmflykey = false
                return 0
            end
            if IsAltKeyDown() then
                rm("/施放 [mod:alt,@mouseover,dead]复活盟友")
            end
            -- 技能插入
            if ddkey == true then
                if getSpellCD(ddspell) == 0 then
                    if amac("target", 1, 0) then
                        if castInsta("target", ddspell) then
                            ddkey = false
                            ddfocuskey = false
                        end
                    else
                        ddkey = false
                        ddfocuskey = false
                    end
                    if amac("mouseover", 1, 0) then
                        if castInsta("mouseover", ddspell) then
                            ddkey = false
                            ddfocuskey = false
                        end
                    else
                        ddkey = false
                        ddfocuskey = false
                    end
                else
                    ddkey = false
                    ddfocuskey = false
                end
            end
            if ddfocuskey == true then
                if getSpellCD(ddspell) == 0 then
                    if amac("focus", 1, 0) then
                        if castInsta("focus", ddspell) then
                            ddfocuskey = false
                            ddkey = false
                        end
                    else
                        ddfocuskey = false
                        ddkey = false
                    end
                else
                    ddfocuskey = false
                    ddkey = false
                end
            end
            if cfkey == true then
                if getSpellCD(56222) > 0 and getSpellCD(56222) < 7.5 then
                    if castInsta("mouseover", 195292) then
                        cfkey = false
                    end
                end
                if getSpellCD(56222) > 0 and getSpellCD(56222) < 7.5 then
                    if castInsta("target", 195292) then
                        cfkey = false
                    end
                end

                if castInsta("mouseover", 56222) then
                    cfkey = false
                end

                if castInsta("target", 56222) then
                    cfkey = false
                end
            end
            if getSpellCD(43265) <= getGCD() then
                if kwdjkey == true then
                    rm("/施放 枯萎凋零")
                end
            else
                kwdjkey = false
            end
            if isKnown(51052) and getSpellCD(51052) <= getGCD() then
                if fmflykey == true then
                    rm("/施放 反魔法领域")
                end
            else
                kwdjkey = false
            end
            if zxkey == true then
                if getSpellCD(221562) <= getGCD() then --插入窒息
                    if castInsta("mouseover", 221562) then
                        zxkey = false
                        zxfocuskey = false
                    end
                    if castInsta("target", 221562) then
                        zxkey = false
                        zxfocuskey = false
                    end
                else
                    zxkey = false
                    zxfocuskey = false
                end
            end
            if zxfocuskey == true then
                if getSpellCD(221562) <= getGCD() then --插入窒息
                    if castInsta("focus", 221562) then
                        zxfocuskey = false
                        zxkey = false
                    end
                    if castInsta("focus", 221562) then
                        zxfocuskey = false
                        zxkey = false
                    end
                else
                    zxfocuskey = false
                    zxkey = false
                end
            end
            -- 单拉
            if dlkey == true then
                if getSpellCD(49576) <= getGCD() then
                    if castInsta("mouseover", 49576) then
                        dlkey = false
                        dlfocuskey = false
                    end
                    if castInsta("target", 49576) then
                        dlkey = false
                        dlfocuskey = false
                    end
                else
                    dlkey = false
                    dlfocuskey = false
                end
            end
            if dlfocuskey == true then
                if getSpellCD(49576) <= getGCD() then
                    if castInsta("focus", 49576) then
                        dlfocuskey = false
                        dlkey = false
                    end
                    if castInsta("focus", 49576) then
                        dlfocuskey = false
                        dlkey = false
                    end
                else
                    dlfocuskey = false
                    dlkey = false
                end
            end
            -- 群拉插入
            if getSpellCD(108199) <= getGCD() then
                if plql == true then
                    if castInsta("player", 108199) then
                        plql = false
                        tgql = false
                    end
                end
                if tgql == true then
                    if castInsta("target", 108199) then
                        plql = false
                        tgql = false
                    end
                end
            else
                plql = false
                tgql = false
            end
        end
    end
end
-----------------------------------------------------------
-- 主要循环
-----------------------------------------------------------
function rotation:prestart_action()
    if rotation_id == "08d37fa5-a411-4b0b-8859-8acc83731c78" and GetSpecializationInfo(GetSpecialization()) == speci then
        if DKT == nil then
            DKT = CreateFrame("Frame")
            DKT:SetScript("OnUpdate", DKT_control)
        end
    end
end

function rotation:precombat_action()
    self:rest()
end
function rotation:default_action()
    --debugprofilestart()
    --local function dkt()
    local gcd = getGCD()
    local aoe = getNumEnemies(player, 8)
    --[[  local getOneEnemy = getOneEnemy
        local getSpellCD = getSpellCD
        local MAX_ACCOUNT_MACROS = MAX_ACCOUNT_MACROS
        local GetMacroInfo = GetMacroInfo
        local EditMacro = EditMacro
        local print = print
        local DeleteMacro = DeleteMacro
        local CreateMacro = CreateMacro
        local getGCD = getGCD
        local isKnown = isKnown
        local amac = amac
        local UnitExists = UnitExists
        local GetSpecializationInfo = GetSpecializationInfo
        local GetSpecialization = GetSpecialization
        local IsSpellInRange = IsSpellInRange
        local GetSpellInfo = GetSpellInfo
        local IsUsableSpell = IsUsableSpell
        local ObjectGUID = ObjectGUID
        local getTalent = getTalent
        local getRunesTimerTable = getRunesTimerTable
        local getBuffRemain = getBuffRemain
        local getBuffStacks = getBuffStacks
        local getDebuffStacks = getDebuffStacks
        local TargetUnit = TargetUnit
        local InsertSpell = InsertSpell
        local IsCurrentSpell = IsCurrentSpell
        local IsMounted = IsMounted
        local UnitCanAttack = UnitCanAttack
        local StartAttack = StartAttack
        local castInsta = castInsta
        local castSpell = castSpell
        local canDo = canDo
        local useItem = useItem
        local getCastTarget = getCastTarget
        local getXxyjtarget = getXxyjtarget
        local getHP = getHP
        local canInterrupt = canInterrupt
        local UnitChannelInfo = UnitChannelInfo
        local UnitCastingInfo = UnitCastingInfo
        local AutoTaunt = AutoTaunt
        local GetUnitName = GetUnitName
        local getRunicPower = getRunicPower
        local isMoving = isMoving
        local IsShiftKeyDown = IsShiftKeyDown
        local IsAltKeyDown = IsAltKeyDown
        local getChargesFrac = getChargesFrac
        local rm = rm
        local getDebuffRemain = getDebuffRemain
        local getRunes = getRunes ]]
    local player = "player"
    local target, tar2 = getCastTarget()
    --local xxyjtar = getOneEnemy(15, xxyjfilter)
    local xxyjtar = getXxyjtarget()
    local mouseover = "mouseover"
    local focus = "focus"
    -- 变量

    local ddset = self.settings.ddset

    local ljdjset = self.settings.ljdjset

    local jsnum = self.settings.jsnum

    local xxgset = self.settings.xxgset

    local bfzrset = self.settings.bfzrset

    local fwrwset = self.settings.fwrwset

    local fmfhzset = self.settings.fmfhzset

    local zlsset = self.settings.zlsset

    local bgzdset = self.settings.bgzdset

    local cfset = self.settings.cfset

    local bgfbset = self.settings.bgfbset

    local kwdlset = self.settings.kwdlset

    local xyftset = self.settings.xyftset

    local xzxcset = self.settings.xzxcset

    local slytset = self.settings.slytset

    local swslset = self.settings.swslset

    local xxyjset = self.settings.xxyjset

    local msset = self.settings.msset

    local wait_for_fenliu = ((getTalent(4, 3) and getRunesTimerTable(2) <= getSpellCD(fwfl)) or not getTalent(4, 3))
    local wait_for_gudun =
        ((getBuffRemain(player, bgzd) >= 6 and getBuffStacks(player, bgzd) > 5) or getRunesTimerTable(3) <= gcd)
    local wait_for_kwdl =
        (((getTalent(2, 1) and getRunesTimerTable(2) <= getSpellCD(kwdl)) or not getTalent(2, 1)) or
        getBuffRemain(player, cstz) > 0)
    local wait_for_bgfb = (getTalent(7, 3) and aoe >= 3 and getSpellCD(bgfb) <= gcd * 2 and bgfbset.is_enabled)

    -- 选目标
    if not UnitExists("target") then
        if tar2 ~= nil then
            TargetUnit(tar2)
        end
    end
    if InsertSpell() then
        return 0
    end
    -- 释放枯萎凋零时停止循环
    if IsCurrentSpell("枯萎凋零") or IsCurrentSpell("反魔法领域") then
        kwdjkey = false
        fmflykey = false
        return 0
    end
    if IsMounted(player) or not UnitCanAttack(player, target) then
        return 0
    end
    if UnitCanAttack(player, target) then
        StartAttack(target)
    end
    ------------
    --减伤部分--
    ------------
    if IsSpellInRange(GetSpellInfo(ljdj), target) == 1 then
        local anyjianshang = 0 -- hasBuffCont(player, {55233, 48707, 48792, 81265, 194679})
        --local jisnshangjineng = {55233, 48707, 48792, 81265, 194679}
        local a = 0
        local b = 0
        local c = 0
        local d = 0
        local e = 0
        if getBuffRemain(player, 55233) > 0 then
            a = 1
        end
        if getBuffRemain(player, 48707) > 0 then
            b = 1
        end
        if getBuffRemain(player, 48792) > 0 then
            c = 1
        end
        if getBuffRemain(player, 81265) > 0 then
            e = 1
        end
        if getBuffRemain(player, 194679) > 0 then
            e = 1
        end
        local anyjianshang = a + b + c + d + e
        if anyjianshang < jsnum.value and (not jianshangDelay or jianshangDelay < GetTime()) then
            if xxgset.is_enabled and getHP(player) <= xxgset.value then --------吸血鬼数值
                if castInsta(player, xxg) then
                    jianshangDelay = GetTime() + 1
                    return 0
                end
            end
            if bfzrset.is_enabled and getHP(player) <= bfzrset.value then --------冰封之刃数值
                if castInsta(player, bfzr) then
                    jianshangDelay = GetTime() + 1
                    return 0
                end
            end

            if fwrwset.is_enabled and getHP(player) <= fwrwset.value then --------符文剑舞数值
                if castInsta(target, fwrw) then
                    jianshangDelay = GetTime() + 1
                    return 0
                end
            end
            if fmfhzset.is_enabled and getHP(player) <= fmfhzset.value and getTalent(4, 2) then --------反魔法护罩数值
                if castInsta(player, fmfhz) then
                    jianshangDelay = GetTime() + 1
                    return 0
                end
            end
            if msset.is_enabled and getHP(player) <= msset.value and getTalent(3, 3) then
                if getBuffStacks(player, bgzd) >= 6 and getRunesTimerTable(2) < gcd then
                    if castInsta(player, ms) then
                        jianshangDelay = GetTime() + 1
                        return 0
                    end
                end
            end
        end
        if zlsset.is_enabled and getHP(player) <= zlsset.value then --------治疗石头数值
            useItem(5512)
            useItem(127834)
        end
    end
    -- 自动打断
    if ddset.is_enabled then
        if canInterrupt("target", ddset.value / 100) then
            if castInsta("target", ddspell) then
            end
        end
    end
    -- 施法防止打断
    if UnitChannelInfo(player) ~= "阿格拉玛之盾" then
        if UnitChannelInfo(player) or UnitCastingInfo(player) then
            return 0
        end
    end
    if cfset.is_enabled then
        AutoTaunt(haml, 30)
    end
    if getSpellCD(61304) > 0.3 then
        return 0
    end
    ---- 建立骨盾
    if getBuffRemain(player, bgzd) < 6 or getBuffStacks(player, bgzd) < 3 then
        if castInsta(target, ggfl) then
            return 0
        end
    end
    ---- 易爆打球技能
    if GetUnitName("target") == "邪能炸药" then
        if getRunicPower() > 100 or getHP(player) < ljdjset.value then
            if castInsta("target", ljdj) then
                return 0
            end
        end
        if castInsta("target", ggfl) then
            return 0
        end
        if castInsta("target", ljdj) then
            return 0
        end
        if castInsta("target", xzdj) then
            return 0
        end
    end

    ------------------------------------
    ----白骨循环 点白骨风暴 风暴钱5秒
    ------------------------------------
    do
        if
            getTalent(7, 3) and getSpellCD(bgfb) < 5 and
                ((bgfbset.is_enabled and aoe >= bgfbset.value) or bgfbxhkg == true)
         then
            --- 不打打灵打用 饮血者 和 神器 代替
            if getRunicPower() > 80 and aoe > 0 and isMoving(player) == false then
                if castInsta(target, bgfb) then
                    return 0
                end
            end
            if getHP(player) <= ljdjset.value then
                if getTalent(1, 2) then
                    if castInsta(target, yxz) then
                        return 0
                    end
                end
                if getTalent(2, 3) and IsSpellInRange(GetSpellInfo(49998), "target") == 1 then
                    if castInsta(target, sqts) then
                    end
                end
            end
            ---- 按键补骨盾
            if IsShiftKeyDown() then
                if getBuffRemain(player, bgzd) < 20 or getBuffStacks(player, bgzd) < 8 then
                    if castInsta(target, ggfl) then
                        return 0
                    end
                    return 0
                end
            end
            ---- 两层血液沸腾
            if getBuffRemain(player, bgzd) >= gcd * 2 and getChargesFrac(xyft) >= 1.8 and aoe > 0 then
                if castInsta(target, xyft) then
                    return 0
                end
                return 0
            end
            ---- 枯萎凋零
            if kwdlset.is_enabled then
                if
                    ((wait_for_fenliu and wait_for_gudun) or getBuffRemain(player, cstz) > 0) and aoe > 0 and
                        isMoving(player) == false
                 then
                    if getSpellCD(kwdl) == 0 then
                        rm("/施放 [@player]枯萎凋零")
                        rm("/施放 [@player]枯萎凋零")
                    end
                end
            end
            ---- 恐吓
            if
                isKnown(slyt) and slytset.is_enabled and getDebuffRemain("target", kh, player) < 1 and
                    IsSpellInRange(GetSpellInfo(49998), "target") == 1
             then
                if castInsta(target, slyt) then
                    return 0
                end
            end
            ---- 死亡锁链
            if
                isKnown(swsl) and swslset.is_enabled and swslset.value < aoe and
                    IsSpellInRange(GetSpellInfo(49998), "target") == 1
             then
                if castInsta(target, swsl) then
                    return 0
                end
            end
            ---- 符文刃舞输出
            if IsAltKeyDown() or getBuffRemain(player, fwrw) > 0 then
                if aoe > 2 then
                    if wait_for_fenliu and wait_for_gudun and getBuffRemain(player, dlbf) > 0 then
                        if
                            isKnown(xzxc) and canDo(target, xzdj) and xzxcset.is_enabled and
                                getHP(player) > xzxcset.value and
                                getBuffRemain(player, xzxc, player) < gcd and
                                IsSpellInRange(GetSpellInfo(49998), "target") == 1
                         then
                            if castInsta(target, xzxc) then
                                return 0
                            end
                        end
                        if castInsta(target, xzdj) then
                            return 0
                        end
                    end
                end
            end
            ---- 常规溢出灵打
            if getRunicPower() >= 100 and getDebuffRemain(player, 243961) == 0 then
                if castInsta(target, ljdj) then
                    return 0
                end
            end
            ---- 叠骨盾
            if wait_for_fenliu then
                if getBuffStacks(player, bgzd) < bgzdset.value or getBuffRemain(player, bgzd) < 6 then
                    if castInsta(target, ggfl) then
                        return 0
                    end
                end
            end
            -- 心脏打击
            if wait_for_gudun and (getRunesTimerTable(3) < gcd or getRunicPower() < 100) then
                if
                    isKnown(xzxc) and canDo(target, xzdj) and xzxcset.is_enabled and getHP(player) > xzxcset.value and
                        getBuffRemain(player, xzxc, player) < gcd and
                        IsSpellInRange(GetSpellInfo(49998), "target") == 1
                 then
                    if castInsta(target, xzxc) then
                        return 0
                    end
                end
                if castInsta(target, xzdj) then
                    return 0
                end
            end
            if getTalent(1, 3) then
                if getRunes() < 3 then
                    if castInsta(target, fwdj) then
                        return 0
                    end
                end
            end

            ---- 常规血液沸腾
            if getRunes() < 3 and aoe > 0 then
                if not xyftset.is_enabled then
                    if castInsta(target, xyft) then
                        return 0
                    end
                end
            end
            return 0
        end
    end
    ------------------------------------
    ----标准循环 不点白骨风暴
    ------------------------------------
    ---- 回血灵打

    do
        if
            (getHP(player) <= ljdjset.value or getDebuffStacks(player, 240559) == 5) and
                getDebuffRemain(player, 243961) == 0
         then
            if castInsta(target, ljdj) then
                return 0
            end
            --- 打不出灵打用 饮血者 和 神器 代替
            if getTalent(1, 2) then
                if castInsta("target", yxz) then
                    return 0
                end
            end
            if getTalent(2, 3) and IsSpellInRange(GetSpellInfo(49998), "target") == 1 then
                if castInsta(target, sqts) then
                end
            end
        end
        ---- 按键补骨盾
        if IsShiftKeyDown() then
            if getBuffRemain(player, bgzd) < 20 or getBuffStacks(player, bgzd) < 8 then
                if castInsta(target, ggfl) then
                    return 0
                end
            end
            if getDebuffRemain(player, 243961) == 0 then
                if castInsta(target, ljdj) then
                    return 0
                end
            end
        end
        ---- 两层血液沸腾
        if getBuffRemain(player, bgzd) >= gcd * 2 and getChargesFrac(xyft) >= 1.8 and aoe > 0 then
            if castInsta(target, xyft) then
                return 0
            end
        end
        ---- 符文
        ---- 枯萎凋零
        if kwdlset.is_enabled then
            if
                ((wait_for_fenliu and wait_for_gudun) or getBuffRemain(player, cstz) > 0) and aoe > 0 and
                    isMoving(player) == false and
                    (getBuffRemain(player, cstz) > 0 or getTalent(2, 1))
             then
                if getSpellCD(kwdl) == 0 then
                    rm("/施放 [@player]枯萎凋零")
                    rm("/施放 [@player]枯萎凋零")
                end
            end
        end
        -- 献血印记
        if xxyjset.is_enabled then
            if getRunesTimerTable(5) > gcd then
                if (getRunicPower() >= 70 or getHP(player) > ljdjset.value) and getDebuffRemain(player, 243961) == 0 then
                    if getTalent(6, 3) then
                        if xxyjtar ~= nil then
                            if castSpell(xxyjtar, xxyj, true, false, true) then
                                return 0
                            end
                        end
                    end
                end
            end
        end
        -- 杀戮意图
        if
            isKnown(slyt) and slytset.is_enabled and getDebuffRemain("target", kh, player) < 1 and
                IsSpellInRange(GetSpellInfo(49998), "target") == 1
         then
            if castInsta(target, slyt) then
                return 0
            end
        end
        ---- 死亡锁链
        if
            isKnown(swsl) and swslset.is_enabled and swslset.value < aoe and
                IsSpellInRange(GetSpellInfo(49998), "target") == 1
         then
            if castInsta(target, swsl) then
                return 0
            end
        end
        ---- 符文刃舞输出
        if IsAltKeyDown() or getBuffRemain(player, fwrw) > 0 then
            if aoe > 2 then
                if getRunes() <= 3 and not xyftset.is_enabled then
                    if castInsta(target, xyft) then
                        return 0
                    end
                end
                if wait_for_fenliu and wait_for_gudun and getBuffRemain(player, dlbf) > 0 then
                    if
                        isKnown(xzxc) and canDo(target, xzdj) and xzxcset.is_enabled and getHP(player) > xzxcset.value and
                            getBuffRemain(player, xzxc, player) < gcd and
                            IsSpellInRange(GetSpellInfo(49998), "target") == 1
                     then
                        if castInsta(target, xzxc) then
                            return 0
                        end
                    end
                    if castInsta(target, xzdj) then
                        return 0
                    end
                end
            end
        end
        ---- 常规溢出灵打 鲜血印记
        if getRunicPower() >= 100 and getDebuffRemain(player, 243961) == 0 then
            if xxyjset.is_enabled then
                if getTalent(6, 3) then
                    if xxyjtar ~= nil then
                        if castSpell(xxyjtar, xxyj, true, false, true) then
                            return 0
                        end
                    end
                end
            end
            if castInsta(target, ljdj) then
                return 0
            end
        end
        ---- 叠骨盾
        if wait_for_fenliu then
            if getBuffStacks(player, bgzd) < bgzdset.value or getBuffRemain(player, bgzd) < 6 then
                if castInsta(target, ggfl) then
                    return 0
                end
            end
        end
        ---- 符文打击
        if getTalent(1, 3) then
            if getRunes() < 3 and getChargesFrac(fwdj) > 1.8 then
                if castInsta(target, fwdj) then
                    return 0
                end
            end
        end
        ---- 常规血液沸腾
        if getRunes() < 3 and aoe > 0 then
            if not xyftset.is_enabled then
                if castInsta(target, xyft) then
                    return 0
                end
            end
        end
        if wait_for_gudun and wait_for_fenliu and wait_for_kwdl then
            if
                isKnown(xzxc) and canDo(target, xzdj) and xzxcset.is_enabled and getHP(player) > xzxcset.value and
                    getBuffRemain(player, xzxc, player) < gcd and
                    IsSpellInRange(GetSpellInfo(49998), "target") == 1
             then
                if castInsta(target, xzxc) then
                    return 0
                end
            end
            if castInsta(target, xzdj) then
                return 0
            end
        end
        if getTalent(1, 3) then
            if getRunes() < 3 then
                if castInsta(target, fwdj) then
                    return 0
                end
            end
        end
    end
    --end
    --dkt()
    --self:rest()
    --local t = debugprofilestop()
    --print((t))
end
-----------------------------------------------------------
-- 注册模块（这里别改）
-----------------------------------------------------------
rotation_manager.instance:register(rotation)
