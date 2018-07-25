-- 注册全局事件
-- local _G = _G
local guid = UnitGUID("player")
local frame = CreateFrame('Frame')
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

if _G.lastspell_failed == nil then
_G.lastspell_failed = 0;
end
if _G.lastspell_failedtime == nil then
_G.lastspell_failedtime = 0;
end
if _G.lastspell_time == nil then
_G.lastspell_time = 0;
end
if _G.lastspell_cast == nil then
_G.lastspell_cast = 0;
end
if _G.spelllist_failed == nil then 
_G.spelllist_failed = {};
end
if _G.spelllist_success == nil then 
_G.spelllist_success = {};
end
if _G.data == nil then 
_G.data = {};
end
if _G.nNove == nil then 
    _G.nNove = {};
end
if _G.nTank == nil then 
_G.nTank = {};
end
if _G.data["Combat Started"] == nil then
    _G.data["Combat Started"] = 0
end

-------------------------------------------------------------------------------------------------------------------
-- 记录进入战斗后自己释放成功和失败的技能队列，

-- 通过访问_G.lastspell_failed获得上一次失败的技能ID，
-- _G.lastspell_failedtime获得上一次失败的技能时间，
-- _G.spelllist_failed记录失败的施法队列，
-- _G.spelllist_failed[id]为最近一次释放同ID技能失败的列表，键值是name，target，stime

-- 通过访问_G.lastspell_time获得上一次成功的技能ID，
-- _G.lastspell_time获得上一次失败的技能时间，
-- _G.lastspell_cast记录失败的施法队列，
-- _G.spelllist_success[id]为最近一次释放同ID技能成功的列表，键值是name，target，stime
-------------------------------------------------------------------------------------------------------------------
local function reader(self,event,...)
    local timeStamp, param, hideCaster, source, sourceName, sourceFlags, 
    sourceRaidFlags, destination,
    destName, destFlags, destRaidFlags, spell, spellName, _, spellType = CombatLogGetCurrentEventInfo()

    if source == guid then
        if param == "SPELL_CAST_FAILED" then
            if sourceName ~= nil then
                if isInCombat("player") and UnitIsUnit(sourceName,"player") 
                and spell ~= 48018 and spell ~= 48020 then
                    _G.lastspell_failed = spell
                    _G.lastspell_failedtime = GetTime()
                    if _G.spelllist_failed[spell] == nil then 
                        _G.spelllist_failed[spell] = {};
                    end
                    table.insert(_G.spelllist_failed[spell],
                    {name = spellName, target = destination, 
                    stime = _G.lastspell_failedtime})
                    if source == guid then
                        --print(spellName.." 失败原因: "..spellType)
                    end
                    if spell == _G.lastspell_start then
                        _G.lastspell_start = nil
                    end
                end
            end
        end
        
        if param == "SPELL_CAST_START" then
            _G.lastspell_start = spell
        end
        
        if param == "SPELL_CAST_SUCCESS" then
            if sourceName ~= nil then
                if isInCombat("player") and UnitIsUnit(sourceName,"player") 
                then
                    _G.lastspell_time = GetTime()
                    _G.lastspell_cast = spell
                    if _G.spelllist_success[spell] == nil then 
                        _G.spelllist_success[spell] = {};
                    end
                    table.insert(_G.spelllist_success[spell],
                    {name = spellName, target = destination, 
                    stime = _G.lastspell_time})
                    if destination then
                        _G.lastspell_target = destination               
                        GH_Print("成功对 "..destName.." ".."施放了 "..spellName)
                    else
                        _G.lastspell_target = none
                    end
                end
            end
        end
    end
end
frame:SetScript("OnEvent", reader)


-------------------------------------------------------------------------------------------------------------------
-- 记录进入战斗的时间
-- 通过访问_G.data["Combat Started"]获得战斗开始时间，
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
        _G.data["Combat Started"] = GetTime();
        -- _G.data["GCD"] = getGCD();
        --ChatOverlay("|cffFF0000Entering Combat")
        -- SetupTables()
    end
    if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_DEAD"  then
        
        _G.data["Combat Started"] = 0
        _G.lastspell_failed = 0;
        _G.lastspell_failedtime = 0;
        _G.lastspell_cast = 0;
        _G.lastspell_time = 0;
        _G.spelllist_failed = {};
        _G.spelllist_success = {};
        -- _G.data["GCD"] = getGCD();
        -- SetupTables()
        
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
--     table.wipe(_G.nNove)
--     table.wipe(_G.nTank)  
--     SetupTables()
--   end)
  
-- 	-- if _G.nNove == nil then
-- 		-- SetupTables()
-- 	-- end
  
--   function SetupTables()    
    
-- 	table.wipe(_G.nNove)
--     table.wipe(_G.nTank)
--     local group =  IsInRaid() and "raid" or "party" 
--     local groupSize = IsInRaid() and GetNumGroupMembers() or 
--     GetNumGroupMembers() - 1

--     for i=1, groupSize do 
--       local groupUnit = group..i      
--       if UnitExists(groupUnit) then table.insert(_G.nNove, groupUnit); end -- Inserting a newly created Unit into the Main Frame
--       if UnitExists(groupUnit) and UnitGroupRolesAssigned(groupUnit) == "TANK" then table.insert(_G.nTank, groupUnit); end
--     end

--     table.insert(_G.nNove, "player")
	
--   end


function getGCD()
    local start, duration, enabled, modRate = GetSpellCooldown(61304)
    if GCD == nil then
      GCD = 1.5 / ((UnitSpellHaste("player")/100)+1);
    end
    if duration ~= 0 then
      GCD = duration
    end
    return GCD
end
----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "0c02decd-b730-4509-b5bf-269d28ca3c28";
-- 定义循环的英文名称。
local rotation_name = "huofa";
Scorpio(rotation_name)("");
import "zeus";
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "火法测试";
    L["Welcome to use test module."] = "欢迎使用火法测试模块！";
    L["Test 1"] = "测试1号";
    L["Test 2"] = "测试2号";
    L["At least 2 values must be entered."] = "至少要输入2个值";
    L["Test Category"] = "测试类别";
    L["Test 3"] = "测试3号";
    L["Test 4"] = "测试4号";
    L["Test 5"] = "测试5号";
    L["targets"] = "目标选择";
end
L = _Locale("zhTW");
if L then
    -- 繁体中文系列。
    L[rotation_name] = "測試";
    L["Welcome to use test module."] = "歡迎使用測試模組！";
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
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------

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
test5_setting.description = "这是number类型的变量，它只能接受string。"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
test5_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
test5_setting.default_value = "Hello"; -- 变量默认值
test5_setting.optional_values = {"Hello", "World", "Hello, World"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
test5_setting.can_enable_disable = true; -- 是否支持启用停用（支持则在界面上出现勾选框）
test5_setting.is_enabled_by_default = false; -- 是否默认启用
test5_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
test5_setting.value_width = 130; -- 值显示宽度像素（默认为100）
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
    local speci = 63 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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
function rotation:prestop_action()
    -- 编写模块停止前脚本。
    print("stop now!");
end
function rotation:precombat_action()    
   
    
    

end

function rotation:default_action()
    -- if UnitCastingInfo("player") or UnitChannelInfo("player") or getSpellCD(61304) > 0.1 then return; end;
    
    local spell_haste = GetHaste("player")/100
    local time = (GetTime() - _G.data["Combat Started"]) or 0
    local gcd = getGCD()
    local charges_fractional = getChargesFrac
    local regen = select(2,GetPowerRegen("player"))
	local focus = getRealMana("player")


    local tgtype = self.settings.targets --目标选择
    
    local bestial_wrath = 19574 --狂野怒火
    local ancestral_call = 274738 --
	local fireblood = 265221
	local lights_judgment = 247427
	local frenzy = 138895
	local barbed_shot = 217200 --倒刺射击
	local a_murder_of_crows = 131894 --夺命黑鸦
	local spitting_cobra = 194407 --喷毒眼镜蛇
	local stampede = 201430  --群兽奔腾
	local aspect_of_the_wild = 193530 --野性守护
	local beast_cleave = 115939  --野兽顺劈
	local multishot = 2643 --多重射击
	local chimaera_shot = 53209 --奇美拉射击
	local kill_command = 34026 --杀戮命令
	local dire_beast = 120679 --凶暴野兽
	local barrage = 120360 --弹幕射击
	local cobra_shot = 193455 --眼镜蛇射击
	-- local barbed_shot = 217200
	
	

    --过滤函数，留下敌对目标，并且进入了战斗，并且自己面对方向的
    local function filler_unit(Unit)
        if UnitReaction(Unit,"player") == 1 or UnitReaction(Unit,"player") == 2 or UnitReaction(Unit,"player") == 3 and getLineOfSight("player",Unit) and not isLongTimeCCed(Unit) and isFacing("player",Unit) then
            return true
        else
            return false
        end
    end
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

    local active_enemies = getNumEnemies(tg,8)
    local spell_targets = active_enemies

    actions=auto_shot
-- actions+=/counter_shot,if=equipped.sephuzs_secret&target.debuff.casting.react&cooldown.buff_sephuzs_secret.up&!buff.sephuzs_secret.up
-- actions+=/use_items
-- actions+=/berserking,if=cooldown.bestial_wrath.remains>30
-- actions+=/blood_fury,if=cooldown.bestial_wrath.remains>30
-- actions+=/ancestral_call,if=cooldown.bestial_wrath.remains>30
if getSpellCD(bestial_wrath)>30 then
    if castSpell(tg,ancestral_call) then
        print(101)
    end
end
-- actions+=/fireblood,if=cooldown.bestial_wrath.remains>30
if getSpellCD(bestial_wrath)>30 then
	if castSpell(tg,fireblood) then
		print(102)
	end
end
-- actions+=/lights_judgment
if castSpell(tg,lights_judgment) then
	print(103)
end
-- actions+=/potion,if=buff.bestial_wrath.up&buff.aspect_of_the_wild.up
-- actions+=/barbed_shot,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<=gcd.max
if UnitBuffID("pet",frenzy) and getBuffRemain("pet",frenzy)<=gcd then
	if getCharges(barbed_shot)>=1 and castSpell(tg,barbed_shot) then
		print(104)
	end
end
-- actions+=/a_murder_of_crows
if focus>=30 and castSpell(tg,a_murder_of_crows) then
	print(105)
end
-- actions+=/spitting_cobra
if canCast(spitting_cobra) and castSpell(tg,spitting_cobra) then
	print(106)
end
-- actions+=/stampede,if=buff.bestial_wrath.up|cooldown.bestial_wrath.remains<gcd|target.time_to_die<15
if UnitBuffID("player",bestial_wrath) or getSpellCD(bestial_wrath)<gcd or getTimeToDie(tg)<15 then
	if canCast(stampede) and castSpell(tg,stampede) then
		print(107)
	end
end
-- actions+=/aspect_of_the_wild
if canCast(aspect_of_the_wild) and castSpell("player",aspect_of_the_wild) then
	print(108)
end
-- actions+=/bestial_wrath,if=!buff.bestial_wrath.up
if not UnitBuffID("player",bestial_wrath) then
	if castSpell(tg,bestial_wrath) then
		print(109)
	end
end
-- actions+=/multishot,if=spell_targets>2&(pet.cat.buff.beast_cleave.remains<gcd.max|pet.cat.buff.beast_cleave.down)
if spell_targets>2 and (getBuffRemain("pet",beast_cleave)<gcd or not UnitBuffID("pet",beast_cleave)) then
	if focus>= 40 and castSpell(tg,multishot) then
		print(110)
	end
end
-- actions+=/chimaera_shot
if canCast(chimaera_shot) and castSpell(tg,chimaera_shot) then
	print(111)
end
-- actions+=/kill_command
if focus>=30 and canCast(kill_command) and castSpell(tg,kill_command) then
	print(112)
end
-- actions+=/dire_beast
if focus>=25 and canCast(dire_beast) and castSpell(tg,dire_beast) then
	print(113)
end
-- actions+=/barbed_shot,if=pet.cat.buff.frenzy.down&charges_fractional>1.4|full_recharge_time<gcd.max|target.time_to_die<9
if UnitBuffID("pet",frenzy) and charges_fractional(barbed_shot)>1.4 or full_recharge_time(barbed_shot) < gcd or getTimeToDie(tg)<9 then
	if getCharges(barbed_shot)>=1 and castSpell(tg,barbed_shot) then
		print(114)
	end
end
-- actions+=/barrage
if canCast(barrage) and focus>=60 and castSpell(tg,barrage) then
	print(115)
end
-- actions+=/multishot,if=spell_targets>1&(pet.cat.buff.beast_cleave.remains<gcd.max|pet.cat.buff.beast_cleave.down)
if spell_targets>1 and (getBuffRemain("pet",beast_cleave)<gcd or not UnitBuffID("pet",beast_cleave)) then
	if focus>=40 and castSpell(tg,multishot) then
		print(116)
	end
end
-- actions+=/cobra_shot,if=(active_enemies<2|cooldown.kill_command.remains>focus.time_to_max)&(buff.bestial_wrath.up&active_enemies>1|cooldown.kill_command.remains>1+gcd&cooldown.bestial_wrath.remains>focus.time_to_max|focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost)
if (active_enemies<2 or getSpellCD("player",kill_command)>getTimeToMax("player")) and (UnitBuffID("player",bestial_wrath) and active_enemies>1 or getSpellCD(kill_command)>1+gcd and getSpellCD(bestial_wrath)>getTimeToMax("player") or getRealMana("player")-35+regen*(getSpellCD(kill_command)-1)>30) then
	if focus>=35 and castSpell(tg,cobra_shot) then
		print(116)
	end
end
    
end

-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);