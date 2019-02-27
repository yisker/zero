----------------------------------------------
-- 模块属性
-----------------------------------------------------------
do
    -- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
    local rotation_id = "f60430eb-d774-457a-8913-7bbefd23bf5c";
    -- 定义循环的英文名称。
    local rotation_name = "test_priest_discipline";
    Scorpio("zeus." .. rotation_name)("");
    -- 定义多语言字符串。
    local L = _Locale("zhCN", true);
    if L then
        -- 简体中文系列。
        L[rotation_name] = "测试戒律";
        L["Welcome to use test module."] = "欢迎使用测试戒律模块！";
        L["Test 1"] = "测试1号";
        L["Test 2"] = "测试2号";
        L["At least 2 values must be entered."] = "至少要输入2个值";
        L["Test Category"] = "测试类别";
        L["Test 3"] = "测试3号";
        L["Test 4"] = "测试4号";
        L["Test 5"] = "测试5号";
    end
    L = _Locale("zhTW");
    if L then
        -- 繁体中文系列。
        L[rotation_name] = "測試戒律";
        L["Welcome to use test module."] = "歡迎使用測試戒律模組！";
        L["Test 1"] = "測試1號";
        L["Test 2"] = "測試2號";
        L["At least 2 values must be entered."] = "至少要输入2个值";
        L["Test Category"] = "測試類別";
        L["Test 3"] = "測試3號";
        L["Test 4"] = "測試4號";
        L["Test 5"] = "測試5號";
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
    rotation.macro = "abc";
end
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
do
    -- 给默认类别添加一个配置变量test1，并配置相关属性。
    local test1_setting = rotation.default_setting_category:create_setting("test1"); -- 指定变量的名字为test1，用于在脚本中进行引用
    test1_setting.display_name = L["Test 1"]; -- 变量在界面上显示的名字
    test1_setting.description = "这是number数组类型的变量，其值为number数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    test1_setting.value_type = rotation_setting_type.numbers; -- 变量值类型（number数组类型）
    test1_setting.default_value = {100, 200}; -- 变量默认值（删除此行不设，则为{}）
    test1_setting.optional_values = {100, 200, 300}; -- 变量备选值（设置备选值后会出现多选下拉菜单，供用户选择）
    test1_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    test1_setting.is_enabled_by_default = true; -- 是否默认启用（勾选框默认选中）
    test1_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    test1_setting.value_width = 120; -- 值显示宽度像素（默认为100）
    -- 给默认类别添加一个配置变量test2，并配置相关属性。
    local test2_setting = rotation.default_setting_category:create_setting("test2"); -- 指定变量的名字为test2，用于在脚本中进行引用（名字不能与test1重复）
    test2_setting.display_name = L["Test 2"]; -- 变量在界面上显示的名字
    test2_setting.description = "这是text数组类型的变量，其值为string数组。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    test2_setting.value_type = rotation_setting_type.texts; -- 变量值类型（text数组类型）
    test2_setting.default_value = {"Hello", "World"}; -- 变量默认值（可以留空则为{}）
    test2_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框，需用户手动输入多个值，用英文逗号分隔）
    test2_setting.can_enable_disable = false; -- 是否支持启用停用（不支持则在界面上不显示勾选框）
    test2_setting.is_enabled_by_default = false; -- 是否默认启用
    test2_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (#value > 1) then
            return true;
        else
            return false, L["At least 2 values must be entered."];
        end
    end;
    test2_setting.value_width = 90; -- 值显示宽度像素（默认为100）
    -- 添加一个自定义类别test_category。
    local test_category = rotation:create_setting_category("test_category"); -- 指定类别的名字，目前没啥用，但是还是写上吧
    test_category.display_name = L["Test Category"]; -- 类别在界面上显示的名字
    -- 在类别test_category下添加配置变量test3
    local test3_setting = test_category:create_setting("test3"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    test3_setting.display_name = L["Test 3"];
    test3_setting.description = "这是plain类型的变量，它没有值。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    test3_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
    test3_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
    test3_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
    test3_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
    test3_setting.is_enabled_by_default = false; -- 是否默认启用
    test3_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
    test3_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）
    -- 在类别test_category下添加配置变量test4
    local test4_setting = test_category:create_setting("test4"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    test4_setting.display_name = L["Test 4"];
    test4_setting.description = "这是number类型的变量，它只能接受number。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    test4_setting.value_type = rotation_setting_type.number; -- 变量值类型（number类型）
    test4_setting.default_value = 500; -- 变量默认值
    test4_setting.optional_values = nil; -- 变量备选值（此处不设，则为文本输入框）
    test4_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    test4_setting.is_enabled_by_default = false; -- 是否默认启用
    test4_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (value > 100) then
            return true;
        else
            return false, "The number is too small.";
        end
    end;
    test4_setting.value_width = 80; -- 值显示宽度像素（默认为100）
    -- 在类别test_category下添加配置变量test5
    local test5_setting = test_category:create_setting("test5"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    test5_setting.display_name = L["Test 5"];
    test5_setting.description = "这是string类型的变量，它只能接受string。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    test5_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    test5_setting.default_value = "Hello"; -- 变量默认值
    test5_setting.optional_values = {"Hello", "World", "Hello, World"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    test5_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
    test5_setting.is_enabled_by_default = false; -- 是否默认启用
    test5_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    test5_setting.value_width = 130; -- 值显示宽度像素（默认为100）
    -- 在类别test_category下添加配置变量test5
    local targets_setting = test_category:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    targets_setting.display_name = L["targets"];
    targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    targets_setting.default_value = "智能"; -- 变量默认值
    targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    targets_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    targets_setting.is_enabled_by_default = false; -- 是否默认启用
    targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    targets_setting.value_width = 130; -- 值显示宽度像素（默认为100）
end
-----------------------------------------------------------
-- 注册事件
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
                        -- if source == guid then
                            --print(spellName.." 失败原因: "..spellType)
                        -- end
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
                        Y.lastspell_cast = {spellname = spell, spelltarget = destination}
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
    return true
end
function rotation:prestart_action()
    -- 编写模块启动前脚本。
    print("oop")
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
    function getRacialID()
        local race = select(2,UnitRace("player"))

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
        return racialSpells[race]
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
                    demonSpikes                 = 203819,
                    bladeTurning                = 247254,
                    empowerWards                = 218256,
                    immolationAura              = 178740,
                    soulFragments               = 203981,
                    metamorphosis               = 187827,
                    feastofSouls                = 207693,
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
                    barrage                     = 120360,
                    burstingShot                = 186387,
                    concussiveShot              = 5116,
                    counterShot                 = 147362,
                    doubleTap                   = 260402,
                    explosiveShot               = 212431,
                    multiShot                   = 257620,
                    piercingShot                = 198670,
                    rapidFire                   = 257044,
                    serpentSting                = 271788,
                    steadyShot                  = 56641,
                    trueShot                    = 193526,
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
                    preciseShots                = 260242,
                    steadyFocus                 = 193534,
                    trickShots                  = 257622,
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
                    inTheRhytm                  = 264198,
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
                    erosion                     = 205039,
                    manaShield                  = 235463,
                    netherTempest               = 114923,
                    overpowered                 = 155147,
                    resonance                   = 205028,
                    slipstream                  = 236457,
                    supernova                   = 157980,
                    temporalFlux                = 234302,
                    wordsOfPower                = 205035,
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
                    lightOfTuure                = 208065,
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
                    spiritOfRedemption          = 20711,
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
                    powerWordShield             = 17,
                    powerInfusion               = 10060,
                    shadowyInsight              = 124430,
                    shadowform                  = 232698,
                    surrenderedSoul             = 212570,
                    surrenderToMadness          = 193223,
                    void                        = 211657,
                    voidForm                    = 194249,
                    voidTorrent                 = 205065,
                    zeksExterminatus            = 236546, -- Legendary Cloak proc
                    thoughtsHarvester           = 288340,
                },
                debuffs                         = {
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
                    stealth                     = 1784,
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
                    stealth                     = 1784 or 115191,
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
                    demonicCore                 = 267102,
                    demonicEmpowerment          = 193396,
                    demonicPower                = 265273,
                    demonwrath                  = 193440,
                    forbiddenKnowledge          = 278738,
                    netherPortal                = 267218,
                    shadowyInspiration          = 196269,
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
    
                },
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
                    summonDoomguard             = 18540,
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
                    defensiveStance             = 71,
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
                    racial                          = getRacialID(),
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
            
            if self.charges[k]      == nil then self.charges[k]         = {} end        
            if self.cooldown[k]     == nil then self.cooldown[k]        = {} end 
            if self.cast            == nil then self.cast               = {} end       
            if self.cast.able       == nil then self.cast.able          = {} end
            if self.cast.able       == nil then self.cast.able          = {} end
            if self.prev_gcd        == nil then self.prev_gcd           = {} end
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

            -- Build Spell Cooldown
            local cooldown = self.cooldown[k]
            cooldown.exists = function()
                return getSpellCD(v) > 0
            end
            cooldown.up = function()
                return getSpellCD(v) <= 0
            end
            cooldown.remain = function()
                return getSpellCD(v)
            end
            cooldown.remains = function()
                return getSpellCD(v)
            end
            cooldown.charges = function()
                return getCharges(v)
            end


            -- 构造施法函数
            self.cast[k] = function(thisUnit,FacingCheck,MovementCheck,SpamAllowed,KnownSkip,DeadCheck,DistanceSkip,usableSkip)
                if thisUnit == nil then thisUnit = "target";end
                return castSpell(thisUnit,v,FacingCheck,MovementCheck,SpamAllowed,KnownSkip,DeadCheck,DistanceSkip,usableSkip)
            end
            self.cast.able[k] = function()
                return canCast(v)
                -- return self.cast[v](nil,"debug")
            end

            self.prev_gcd[k] = function (targetunit)
                if targetunit == nil then targetunit = "target";end
                return Y.lastspell_cast["spellname"] == v and UnitIsUnit(Y.lastspell_cast["spelltarget"],targetunit)
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
                buff.down = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return not UnitBuffID(thisUnit,v,sourceUnit)
                end
                buff.ticking = function(thisUnit,sourceUnit)
                    if thisUnit == nil then thisUnit = 'player' end
                    if sourceUnit == nil then sourceUnit = 'player' end
                    return UnitBuffID(thisUnit,v,sourceUnit) ~= nil
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
            activeSpecGroup = GetActiveSpecGroup()
            if self.talent == nil then self.talent = {} end
            for r = 1, 7 do --search each talent row
                for c = 1, 3 do -- search each talent column
                -- Cache Talent IDs for talent checks
                    local _,_,_,selected,_,talentID = GetTalentInfo(r,c,activeSpecGroup)
                    -- Compare Row/Column Spell Id to Talent Id List for matches
                    for k,v in pairs(self.spell.talents) do
                        if v == talentID then
                            -- Add All Matches to Talent List for Boolean Checks
                            self.talent[k] = selected
                            -- Add All Active Ability Matches to Ability/Spell List for Use Checks
                            if not IsPassiveSpell(v) then
                                self.spell['abilities'][k] = v
                                self.spell[k] = v
                            end
                        end
                    end
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

        if self.talent == nil then 
            getTalentInfo();
            getAzeriteTraitInfo();
        end
        
        
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
    -- 编写在非战斗中循环执行的脚本。
    -- local test1 = self.settings.test1; -- 返回指定配置变量是否启用+当前值。
    -- local test5 = self.settings.test5; -- 返回指定配置变量是否启用+当前值。
    -- print("Precombat", test1.is_enabled, #test1.value, test5.is_enabled, test5.value); -- 这里会打印配置变量的启用状态和值。
    -- print("Addon Macro is", ADDON_SLASH_COMMAND);
    -- self:rest();

    

    -- player          = cPlayer:new("player",262)
    -- talent          = player.talent
    -- buff            = player.buff
    -- debuff          = player.debuff
    -- cast            = player.cast
    -- cooldown        = player.cooldown
    -- power           = player.power

    -- target          = cPlayer:new()
    -- Debuff          = target.debuff

    -- if talent.totemMastery and buff.resonanceTotem.remains()<2 then
    --     if cast.able.totemMastery() and cast.totemMastery("player") then
    --         return 0
    --     end
    -- end
    -- -- actions+=/fireElemental, 
    -- if  not talent.stormElemental then
    --     if cast.able.fireElemental() and cast.fireElemental("player") then
    --         return 0
    --     end
    -- end
    -- -- actions+=/stormElemental, 
    -- if talent.stormElemental and ( not talent.iceFury or  not buff.iceFury.up() and  not cooldown.iceFury.up()) then
    --     if cast.able.stormElemental() and cast.stormElemental("player") then
    --         return 0
    --     end
    -- end
    -- -- actions+=/earthElemental, 
    -- if  not talent.primalElementalist or talent.primalElementalist and (cooldown.fireElemental.remains()<120 and  not talent.stormElemental or cooldown.stormElemental.remains()<120 and talent.stormElemental) then
    --     if cast.able.earthElemental() and cast.earthElemental("player") then
    --         return 0
    --     end
    -- end

end
function rotation:default_action()

    player          = cPlayer:new("player",269)
    target          = player
    talent          = player.talent
    buff            = player.buff
    debuff          = player.debuff
    cast            = player.cast
    cooldown        = player.cooldown
    power           = player.power
    azerite         = player.traits
    pct_health      = player.pct_health
    energy          = player.power.energy
    chi             = player.power.chi.amount

    -- 不打断施法
    if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;

    tgtype = self.settings.targets --目标选择

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
    
    gcd = getGCD()
    time = getCombatTime()
    expected_combat_length = getTimeToDie(tg)
    active_enemies = getNumEnemies(tg,8)
    tb = getEnemy(5,filler_unit)

    function getDebuffRemainMin(tb,debuffid)
        if tb ~= nil and UnitExists(tb[1]) then 
            local tgg = tb[1]
            if #tb == 1 then
                return tb[1]
            end
            for i=1,#tb do
                if UnitExists(tb[i]) and not UnitDebuffID(tb[i],debuffid) then
                    return tb[i]                
                elseif UnitExists(tb[i]) and getDebuffRemain(tgg,debuffid) > getDebuffRemain(tb[i],debuffid) then
                    tgg = tb[i]
                    self:rest()
                end
            end
            return tgg
        end
        return "target"
    end    
    
    -- monk="T23_Monk_Windwalker_Serenity"
    -- source=default
    -- spec=windwalker
    -- level=120
    -- race=pandaren
    -- role=dps
    -- position=back
    -- talents=2022033

    -- # Default consumables
    -- potion=bursting_blood
    -- flask=currents
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
    -- # Snapshot raid buffed stats before combat begins and pre-potting is done.
    -- actions.precombat+=/snapshot_stats
    -- actions.precombat+=/potion
    -- actions.precombat+=/chiBurst, if ( not talent.serenity.enabled or  not talent.fistOfTheWhiteTiger.enabled)
    -- actions.precombat+=/chiWave

    -- # Executed every time the actor is available.
    -- actions=auto_attack
    StartAttack()
    -- actions+=/spearHandStrike, if target.debuff.casting.react
    -- # Touch of Karma on cooldown, if Good Karma is enabled equal to 100% of maximum health
    -- actions+=/touchOfKarma,interval=90,
    if pct_health()==0.5 then
        if cast.able.touchOfKarma() and cast.touchOfKarma() then
            return 0
        end
    end
    -- # Potion if Serenity or Storm, Earth, and Fire are up or you are running serenity and a main stat trinket procs, or you are under the effect of bloodlust, or target time to die is greater or equal to 60
    -- actions+=/potion, if buff.serenity.up or buff.stormEarthAndFire.up or ( not talent.serenity.enabled and trinket.proc.agility.react) or buff.bloodlust.react or target.time_to_die<=60
    -- actions+=/call_action_list,name=serenity, 
    if buff.serenity.up()
    -- actions+=/fistOfTheWhiteTiger, 
    if (energy.time_to_max()<1 or (talent.serenity and cooldown.serenity.remains()<2)) and chi.max()-chi()>=3 then
        if cast.able.fistOfTheWhiteTiger() and cast.fistOfTheWhiteTiger() then
            return 0
        end
    end
    -- actions+=/tigerPalm,target_ if min:debuff.markOfTheCrane.remains, 
    tg1 = getDebuffRemainMin(tb,lists.spells["MONK"][269]["debuffs"]["markOfTheCrane"])
    if (energy.time_to_max()<1 or (talent.serenity and cooldown.serenity.remains()<2)) and chi.max()-chi()>=2 and  not prev_gcd.tigerPalm(tg1) then
        if cast.able.tigerPalm() and cast.tigerPalm(tg1) then
            return 0
        end
    end
    -- actions+=/call_action_list,name=cd
    self:cd()
    -- # Call the ST action list if there are 2 or less enemies
    -- actions+=/call_action_list,name=st, 
    if active_enemies<3 then
        self:st()
    end
    -- # Call the AoE action list if there are 3 or more enemies
    -- actions+=/call_action_list,name=aoe, 
    if active_enemies>=3 then
        self:aoe()
    end             

    return 0    
end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);










function rotation:aoe(args)
    -- # Actions.AoE is intended for use with Hectic_Add_Cleave and currently needs to be optimized
    -- actions.aoe=risingSunKick,target_ if min:debuff.markOfTheCrane.remains, 
    if (talent.whirlingDragonPunch and cooldown.whirlingDragonPunch.remains()<5) and cooldown.fistsOfFury.remains()>3 then
        if cast.able.risingSunKick() and cast.risingSunKick(tg1) then
            return 0
        end
    end
    -- actions.aoe+=/whirlingDragonPunch
    if cast.able.whirlingDragonPunch() and cast.whirlingDragonPunch() then
        return 0
    end
    -- actions.aoe+=/energizingElixir, 
    if  not prev_gcd.tigerPalm() and chi()<=1 and energy()<50 then
        if cast.able.energizingElixir() and cast.energizingElixir() then
            return 0
        end
    end
    -- actions.aoe+=/fistsOfFury, 
    if energy.time_to_max()>3 then
        if cast.able.fistsOfFury() and cast.fistsOfFury() then
            return 0
        end
    end
    -- actions.aoe+=/rushingJadeWind, 
    if buff.rushingJadeWind.down() then
        if cast.able.rushingJadeWind() and cast.rushingJadeWind() then
            return 0
        end
    end
    -- actions.aoe+=/spinningCraneKick, 
    if  not prev_gcd.spinningCraneKick() and (((chi()>3 or cooldown.fistsOfFury.remains()>6) and (chi()>=5 or cooldown.fistsOfFury.remains()>2)) or energy.time_to_max()<=3) then
        if cast.able.spinningCraneKick() and cast.spinningCraneKick() then
            return 0
        end
    end
    -- actions.aoe+=/chiBurst, 
    if chi()<=3 then
        if cast.able.chiBurst() and cast.chiBurst() then
            return 0
        end
    end
    -- actions.aoe+=/fistOfTheWhiteTiger, 
    if chi.max()-chi()>=3 then
        if cast.able.fistOfTheWhiteTiger() and cast.fistOfTheWhiteTiger() then
            return 0
        end
    end
    -- actions.aoe+=/tigerPalm,target_ if min:debuff.markOfTheCrane.remains, 
    if chi.max()-chi()>=2 and ( not talent.hitCombo or  not prev_gcd.tigerPalm()) then
        if cast.able.tigerPalm() and cast.tigerPalm() then
            return 0
        end
    end
    -- actions.aoe+=/chiWave
    if cast.able.chiWave() and cast.chiWave() then
        return 0
    end
    -- actions.aoe+=/flyingSerpentKick, if buff.bok_proc.down,interrupt=1
    -- actions.aoe+=/blackoutKick,target_ if min:debuff.markOfTheCrane.remains, 
    if  not prev_gcd.blackoutKick() and (buff.bok_proc.up() or (talent.hitCombo and prev_gcd.tigerPalm(tg1) and chi()<4)) then
        if cast.able.tigerPalm() and cast.tigerPalm(tg1) then
            return 0
        end
    end
    return 0
end




function rotation:cd(args)
    -- # Cooldowns
    -- actions.cd=invokeXuenTheWhiteTiger
    if cast.able.invokeXuenTheWhiteTiger() and cast.invokeXuenTheWhiteTiger() then
        return 0
    end
    -- actions.cd+=/use_item,name=variable_intensity_gigavolt_oscillating_reactor
    -- actions.cd+=/blood_fury
    -- actions.cd+=/berserking
    -- # Use Arcane Torrent if you are missing at least 1 Chi and won't cap energy within 0.5 seconds
    -- actions.cd+=/arcaneTorrent, 
    if chi.max()-chi()>=1 and energy.time_to_max()>=0.5 then
        if cast.able.arcaneTorrent() and cast.arcaneTorrent() then
            return 0
        end
    end
    -- actions.cd+=/lights_judgment
    -- actions.cd+=/fireblood
    -- actions.cd+=/ancestral_call
    -- actions.cd+=/touchOfDeath, 
    if target.time_to_die(tg)>9 then
        if cast.able.touchOfDeath() and cast.touchOfDeath() then
            return 0
        end
    end
    -- actions.cd+=/stormEarthAndFire, 
    if cooldown.stormEarthAndFire.charges()==2 or (cooldown.fistsOfFury.remains()<=6 and chi()>=3 and cooldown.risingSunKick.remains()<=1) or target.time_to_die(tg)<=15 then
        if cast.able.stormEarthAndFire() and cast.stormEarthAndFire() then
            return 0
        end
    end
    -- actions.cd+=/serenity, 
    if cooldown.risingSunKick.remains()<=2 or target.time_to_die()<=12 then
        if cast.able.serenity() and cast.serenity() then
            return 0
        end
    end
    return 0
end


function rotation:serenity(args)
    -- # Serenity priority
    -- actions.serenity=risingSunKick,target_ if min:debuff.markOfTheCrane.remains, 
    if active_enemies<3 or prev_gcd.spinningCraneKick(tg1) then
        if cast.able.risingSunKick() and cast.risingSunKick() then
            return 0
        end
    end
    -- actions.serenity+=/fistsOfFury, 
    if (buff.bloodlust.up() and prev_gcd.risingSunKick()) or buff.serenity.remains()<1 or (active_enemies>1 and active_enemies<5) then
        if cast.able.fistsOfFury() and cast.fistsOfFury() then
            return 0
        end
    end
    -- actions.serenity+=/spinningCraneKick, 
    if  not prev_gcd.spinningCraneKick() and (active_enemies>=3 or (active_enemies=2 and prev_gcd.blackoutKick())) then
        if cast.able.spinningCraneKick() and cast.spinningCraneKick() then
            return 0
        end
    end
    -- actions.serenity+=/blackoutKick,target_ 
    if debuff.markOfTheCrane.remains(tg1) then
        if cast.able.blackoutKick() and cast.blackoutKick(tg1) then
            return 0
        end
    end
    return 0
end


function rotation:st(args)
    -- actions.st=whirlingDragonPunch
    if cast.able.whirlingDragonPunch() and cast.whirlingDragonPunch() then
        return 0
    end
    -- actions.st+=/risingSunKick,target_ if min:debuff.markOfTheCrane.remains, 
    if chi()>=5 then
        if cast.able.risingSunKick() and cast.risingSunKick(tg1) then
            return 0
        end
    end
    -- actions.st+=/fistsOfFury, 
    if energy.time_to_max()>3 then
        if cast.able.fistsOfFury() and cast.fistsOfFury() then
            return 0
        end
    end
    -- actions.st+=/risingSunKick,target_ 
    if debuff.markOfTheCrane.remains(tg1) then
        if cast.able.risingSunKick() and cast.risingSunKick() then
            return 0
        end
    end
    -- actions.st+=/spinningCraneKick, 
    if  not prev_gcd.spinningCraneKick() and buff.dance_of_chiji.up() then
        if cast.able.spinningCraneKick() and cast.spinningCraneKick() then
            return 0
        end
    end 
    -- actions.st+=/rushingJadeWind, 
    if buff.rushingJadeWind.down() and active_enemies>1 then
        if cast.able.rushingJadeWind() and cast.rushingJadeWind() then
            return 0
        end
    end
    -- actions.st+=/fistOfTheWhiteTiger, 
    if chi()<=2 then
        if cast.able.fistOfTheWhiteTiger() and cast.fistOfTheWhiteTiger() then
            return 0
        end
    end
    -- actions.st+=/energizingElixir, 
    if chi()<=3 and energy()<50 then
        if cast.able.energizingElixir() and cast.energizingElixir() then
            return 0
        end
    end
    -- actions.st+=/blackoutKick,target_ if min:debuff.markOfTheCrane.remains, 
    if  not prev_gcd.blackoutKick() and (cooldown.risingSunKick.remains()>3 or chi()>=3) and (cooldown.fistsOfFury.remains()>4 or chi()>=4 or (chi()==2 and prev_gcd.tigerPalm())) and buff.swiftRoundhouse.stack()<2 then
        if cast.able.blackoutKick() and cast.blackoutKick(tg1) then
            return 0
        end
    end
    -- actions.st+=/chiWave
    if cast.able.chiWave() and cast.chiWave() then
        return 0
    end
    -- actions.st+=/chiBurst, 
    if chi.max()-chi()>=1 and active_enemies==1 or chi.max()-chi()>=2 then
        if cast.able.chiBurst() and cast.chiBurst() then
            return 0
        end
    end
    -- actions.st+=/tigerPalm,target_ if min:debuff.markOfTheCrane.remains, 
    if  not prev_gcd.tigerPalm() and chi.max()-chi()>=2 then
        if cast.able.tigerPalm() and cast.tigerPalm(tg1) then
            return 0
        end
    end
    -- actions.st+=/flyingSerpentKick, 
    if prev_gcd.blackoutKick and chi()>3 and buff.swiftRoundhouse.stack()<2 then
        if cast.able.flyingSerpentKick() and cast.flyingSerpentKick() then
            return 0
        end
    end
end

