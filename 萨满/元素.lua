----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "5afd17f4-f03f-4b10-851b-4a069abef8f3";
-- 定义循环的英文名称。
local rotation_name = "test_shaman_elemental";
Scorpio("zeus." .. rotation_name)("");
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "萨满-元素";
    L["Welcome to use test module."] = "欢迎使用萨满元素模块！";
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
    L[rotation_name] = "薩滿-元素";
    L["Welcome to use test module."] = "歡迎使用薩滿元素模組！";
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
rotation.macro = "yss";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
local test_category1 = rotation:create_setting_category("一般选项")
test_category1.display_name = L["一般设置"]


local targets_setting = test_category1:create_setting("targets"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
targets_setting.display_name = L["目标管理"];
targets_setting.description = "确定目标的选择方式"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
targets_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
targets_setting.default_value = "智能"; -- 变量默认值
targets_setting.optional_values = {"智能", "当前目标"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
targets_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
targets_setting.is_enabled_by_default = false; -- 是否默认启用
targets_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
targets_setting.value_width =80; -- 值显示宽度像素（默认为100）




-- 自动打断
local ddkg_setting = test_category1:create_setting("打断")
ddkg_setting.display_name = L["打断及施法进度"]
ddkg_setting.description = "打断及施法进度,0到1"
ddkg_setting.value_type = rotation_setting_type.number
ddkg_setting.default_value = 0.4
ddkg_setting.can_enable_disable = true
ddkg_setting.is_enabled_by_default = true
ddkg_setting.validator = function(self, value)
    if (value > 1) or (value < 0) then
        return false
    else
        return true
    end
end
ddkg_setting.value_width = 50

-- AOE开关 
local AOE_setting = test_category1:create_setting("AOE"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
AOE_setting.display_name = L["AOE及人数阈值"]
AOE_setting.description = "当敌方人数高于设定值进入AOE循环"
AOE_setting.value_type = rotation_setting_type.number
AOE_setting.default_value = 3
AOE_setting.can_enable_disable = true
AOE_setting.is_enabled_by_default = true
AOE_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
AOE_setting.value_width = 50

-- 切怪开关 
local zdqg_setting = test_category1:create_setting("zdqg"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdqg_setting.display_name = L["自动切怪"]
zdqg_setting.description = "(开启/关闭自动转目标)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdqg_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdqg_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdqg_setting.is_enabled_by_default = true

-- 爆发开关 
local baofa_setting = test_category1:create_setting("baofa"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
baofa_setting.display_name = L["自动爆发"]
baofa_setting.description = "(开启/关闭自动爆发)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
baofa_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
baofa_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
baofa_setting.is_enabled_by_default = true

--自动光铸调和符文开关 
local fw_setting = test_category1:create_setting("fw"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
fw_setting.display_name = L["光铸调和符文"]
fw_setting.description = "(开启/关闭自动光铸调和符文)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
fw_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
fw_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
fw_setting.is_enabled_by_default = true

--自动变狼开关 
local zdbl_setting = test_category1:create_setting("zdbl"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
zdbl_setting.display_name = L["自动变狼"]
zdbl_setting.description = "(开启/关闭当不骑坐骑时且移动时自动变狼)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
zdbl_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
zdbl_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
zdbl_setting.is_enabled_by_default = false

--一键驱散开关 
local yjqs_setting = test_category1:create_setting("yjqs"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
yjqs_setting.display_name = L["驱散诅咒"]
yjqs_setting.description = "(开启/关闭驱散debuff)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
yjqs_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
yjqs_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
yjqs_setting.is_enabled_by_default = false

--进攻驱散开关 
local jgqs_setting = test_category1:create_setting("jgqs"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
jgqs_setting.display_name = L["进攻驱散"]
jgqs_setting.description = "(开启/关闭进攻驱散，请根据实际情况开启，如有法师，是否留给法师偷取，只做pve环境适用，pvp慎用！)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
jgqs_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
jgqs_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
jgqs_setting.is_enabled_by_default = false

--自动大地之盾开关
local ddzd_setting = test_category1:create_setting("ddzd"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
ddzd_setting.display_name = L["大地之盾"]
ddzd_setting.description = "(开启/关闭自动大地之盾,如果选了大地之盾天赋)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
ddzd_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
ddzd_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
ddzd_setting.is_enabled_by_default = false

--岩浆图腾开关
local yjtt_setting = test_category1:create_setting("yjtt"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
yjtt_setting.display_name = L["岩浆图腾"]
yjtt_setting.description = "(开启/关闭自动岩浆图腾,如果选了岩浆图腾天赋)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
yjtt_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
yjtt_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
yjtt_setting.is_enabled_by_default = false

--雷霆风暴开关
local ltfb_setting = test_category1:create_setting("ltfb"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
ltfb_setting.display_name = L["雷霆风暴"]
ltfb_setting.description = "(开启/关闭自动雷霆风暴)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
ltfb_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
ltfb_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
ltfb_setting.is_enabled_by_default = false

--闪电奔涌图腾
local sdby_setting = test_category1:create_setting("sdby"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
sdby_setting.display_name = L["闪电奔涌图腾"]
sdby_setting.description = "(开启/关闭自动闪电奔涌图腾)"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
sdby_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
sdby_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
sdby_setting.is_enabled_by_default = false







local HPcategory = rotation:create_setting_category("减伤设置")
HPcategory.display_name = L["减伤设置"]


--脱战治疗
local tzzl_setting = HPcategory:create_setting("治疗之涌血量阈值")
tzzl_setting.display_name = L["脱战治疗"]
tzzl_setting.description = "当自己血量低于该值时使用该技能"
tzzl_setting.value_type = rotation_setting_type.number
tzzl_setting.default_value = 90
tzzl_setting.can_enable_disable = true
tzzl_setting.is_enabled_by_default = true
tzzl_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
tzzl_setting.value_width = 50


--治疗石
local zlssz1_setting = HPcategory:create_setting("治疗石血量阈值")
zlssz1_setting.display_name = L["治疗石"]
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



--自动星界转移
local xj_setting = HPcategory:create_setting("躯不坏血量阈值")
xj_setting.display_name = L["星界转移"]
xj_setting.description = "当血量低于该值时使用该技能"
xj_setting.value_type = rotation_setting_type.number
xj_setting.default_value = 50
xj_setting.can_enable_disable = true
xj_setting.is_enabled_by_default = true
xj_setting.validator = function(self, value)
    if (value > 100) or (value < 0) then
        return false
    else
        return true
    end
end
xj_setting.value_width = 50






-- 脚本介绍（标题模板）
local category_intro = rotation:create_setting_category("intro");
category_intro.display_name = "脚本介绍"; -- 类别在界面上显示的名字
-- 介绍内容（纯文本模板）
--[[local content11_setting = category_intro:create_setting("content11");
content11_setting.display_name = "10月6号更新";
content11_setting.can_enable_disable = false;
local content12_setting = category_intro:create_setting("content12");
content12_setting.display_name = "新增闪电奔涌图腾开关，地震术等技能细节优化";
content12_setting.can_enable_disable = false;]]
--[[local content13_setting = category_intro:create_setting("content13");
content13_setting.display_name = "优化烈焰暴击等循环";
content13_setting.can_enable_disable = false;]]
--[[local content14_setting = category_intro:create_setting("content14");
content14_setting.display_name = "--------------------------------------";
content14_setting.can_enable_disable = false;]]



local content_setting = category_intro:create_setting("content");
content_setting.display_name = "推荐天赋1311121";
content_setting.can_enable_disable = false;
local content7_setting = category_intro:create_setting("content7");
content7_setting.display_name = "爆发宏：/ "..ADDON_SLASH_COMMAND.." yss baofa";
content7_setting.can_enable_disable = false;
--[[local content2_setting = category_intro:create_setting("content2");
content2_setting.display_name = "爆发会自动放元素尊者，火尊者的技能会卡CD放";
content2_setting.can_enable_disable = false;
local content6_setting = category_intro:create_setting("content6");
content6_setting.display_name = "aoe会给各个怪上烈焰buff";
content6_setting.can_enable_disable = false;
local content5_setting = category_intro:create_setting("content5");
content5_setting.display_name = "脱战会自动治疗自己";
content5_setting.can_enable_disable = false;
local content8_setting = category_intro:create_setting("content8");
content8_setting.display_name = "地缚图腾/闪电奔涌图腾/岩浆图腾可以手动选位置插入";
content8_setting.can_enable_disable = false;
local content9_setting = category_intro:create_setting("content9");
content9_setting.display_name = "支持元素冲击/图腾掌握/大地之盾/风暴元素/岩浆图腾";
content9_setting.can_enable_disable = false;
local content3_setting = category_intro:create_setting("content3");
content3_setting.display_name = "欢迎提出改进意见 近期会持续更新";
content3_setting.can_enable_disable = false;
local content4_setting = category_intro:create_setting("content4");
content4_setting.display_name = "推荐天赋不一定最优 具体可根据自己喜好调整";
content4_setting.can_enable_disable = false;]]

-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
   -- AOE 
   if argument == "aoe" and AOE_setting.is_enabled ~= true then
	AOE_setting.is_enabled = true
	print("开启AOE!!!!!!")
	return 0;
end
if argument == "aoe" and AOE_setting.is_enabled == true then
	AOE_setting.is_enabled = false 
	print("关闭AOE!!!!!!")
	return 0;
end
	-- 爆发 
if argument == "baofa" and baofa_setting.is_enabled ~= true then
	baofa_setting.is_enabled = true
	print("开启爆发!!!!!!")
	return 0;
end
if argument == "baofa" and baofa_setting.is_enabled == true then
	baofa_setting.is_enabled = false 
	print("关闭爆发!!!!!!")
	return 0;
end
end
function rotation:condition_action()
   -- 编写判断模块是否可用的脚本。
    local current_specialization = GetSpecializationInfo(GetSpecialization())
    local speci = 262 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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
  --  local test1 = self.settings.test1; -- 返回指定配置变量是否启用+当前值。
  --  local test5 = self.settings.test5; -- 返回指定配置变量是否启用+当前值。
  --  print("Precombat", test1.is_enabled, #test1.value, test5.is_enabled, test5.value); -- 这里会打印配置变量的启用状态和值。
    self:rest();
	
	if zdbl_setting.is_enabled == true and  isMoving("player") and getBuffRemain("player",2645)==0 and  not isBused("player")   then
		if csi("player",2645) then
			return 0
		end
	end
	

	--脱离战斗后，自动加血
	
	if  tzzl_setting.is_enabled == true  and   getHP("player")<=tzzl_setting.value  and  canCast(188070) then
			if csl("player",188070) then
				return 0
			end
	end
end

function rotation:default_action()
	
	if UnitName("player") == "丨丶三叔公"then return;end
	
   	--模块变量设置
local ddkg = ddkg_setting.is_enabled
local ddtime = ddkg_setting.value
local zlssz1 = zlssz1_setting.value
local zlssz1kg = zlssz1_setting.is_enabled
local AOE = AOE_setting.is_enabled
local AOERS = AOE_setting.value
local baofa = baofa_setting.is_enabled
local xj = xj_setting.value
local xjkg = xj_setting.is_enabled
local yjqs = yjqs_setting.is_enabled 
local ddzd = ddzd_setting.is_enabled
local yjtt = yjtt_setting.is_enabled
local ltfb = ltfb_setting.is_enabled
local zdqg = zdqg_setting.is_enabled
local jgqs = jgqs_setting.is_enabled
--local lastspell = getLastSpell()
local sdby = sdby_setting.is_enabled

--应对震荡词缀
if getDebuffRemain("player",240447) < 0.3 and getDebuffRemain("player",240447)>0 then 
   rm("/stopcasting"); 

    return
end

 --没事不要乱进战斗
 if  isBused("player")  then return; end



--[[local tgtype = targets_setting
function filter(Unit)
	local group =  IsInRaid() and "raid" or "party" 
        local groupSize = IsInRaid() and GetNumGroupMembers() or GetNumGroupMembers() - 1
        for i=1, groupSize do 
		local groupUnit = group..i 
		if UnitExists(groupUnit) and UnitGroupRolesAssigned(groupUnit) == "TANK" then 
			local tg = UnitTarget(groupUnit)
			if UnitIsUnit(Unit,tg) then
				return true
			end
		end
        end
	return false
end

if tgtype.value == "智能" then
    tg = getOneEnemy(10,filter)
    
else
    tg = "target"
    
end
castSpell(tg,196840)]]



--绿圈技能暂停（地缚图腾，闪电奔涌图腾）
  
	if IsCurrentSpell("地缚图腾") then
		print("放地缚图腾")
		return 0
	end
	
	if IsCurrentSpell("闪电奔涌图腾") then
		print("放闪电奔涌图腾")
		return 0
	end

	if IsCurrentSpell("岩浆图腾") then
		print("放岩浆图腾")
		return 0
	end
	




		



-- 自动打断
        if ddkg == true and canInterrupt("target",ddtime)  then
           if csi("target",57994) then
			  return 0
		    end
        end
		

	
	--饰品
	  if  zdspkg == true  then
		if useItem(13) or  useItem(14) then
          return 0
        end
	   end



-- 自动石头
        if zlssz1kg == true and getHP("player") <= zlssz1 and canUse(5512) then --------治疗石头数值
              if  useItem(5512) then 
				return 0
			end
        end

--自动星界转移
        if xjkg == true and getHP("player") <= xj  and canCast(108271) then
			if castSpell("player",108271) then
				return 0
			end
		end

	  --一键驱散
	   if yjqs == true  then
	        if  CurseDispel(51886)  then
				return 0
			end
		end

		  --进攻驱散
		  local pd = getEnemy(30)
		  for i = 1,#pd do
			local p1 = pd[i] 
				if jgqs == true and  canPD(p1) and isInCombat(p1) then
				   if   csi(p1,370)  then
					   print("驱散敌方魔法！！！")
					   end
				end
		  end

		-- 自动大地之盾
        if ddzd == true and  getBuffRemain("player",974)<=0.5 and canCast(974) then 
			if  csi("player",974) then
				return 0
			end
		end

		

	

	 --自动转怪
	 if zdqg == true  and  not UnitExists("target") or not isAlive("target") then
		autoTarget(370,true)
	   end
		 if not UnitCanAttack("target","player")  then
	   return 0
	   end 
			
	

     

    -- 图腾
	   if getBuffRemain("player",202192)==0 then
		if  csi("player",210643) then
		return 0
		end
		end

		--雷霆风暴
	    local lt = getEnemy(10)
          for i = 1,#lt do
            local l1 = lt[i] 
                if ltfb == true and  getDistance(l1,"player") <8 and canCast(51490) then
                     csi(l1,51490)
                end
		  end
	   
		--岩浆图腾  
		  if  yjtt == true then 
			 if isInCombat("target") and isInCombat("player") then
			 if csi("target",192222) then
				return 0
			 end 
			end 
		end
				


		--元素冲击
		  if canCast(117014) then
			if  csl("target",117014) then 
				return 0
			end
		end 
		  
		--移动中 
        if isMoving("player") and isInCombat("target") and  getMaelstorm()>= 60 and  canCast(61882) and   getNumEnemies("target",10)>=AOERS  and AOE==true  then
			if csi("target",61882)then 
				return 0
			end
		end

        if isMoving("player") and isInCombat("target") and  getMaelstorm()>= 60 and canCast(8042) then
		
			if csi("target",8042) then
				return 0
			end
		end
		
		if isMoving("player") and  getBuffRemain("player",77762)> 0  and isInCombat("target") then
			if csi("target",51505) then 
				return 0
			end
		end

		--烈焰震击(移动中)
	    if isMoving("player") and  getDebuffRemain("target",188389)<0.5 and  canCast(188389) then
		    if   csi("target",188389) then
		   return 0
		   end 
	     end 



		if isMoving("player") and isInCombat("target") then
			if  canCast(196840) then 
				
		              if castSp("target",196840)then 
						
			               return 0
		              end
		    end
	    end
	

    --爆发
	 
	if baofa == true then
		
		if canCast(198067) then
		 if 	csi("target",198067) then
			return 0
		end
	  end

	  if canCast(192249) then
		if 	csi("target",192249) then
		   return 0
	   end
	 end
		
		if  (getSpellCD(198067)<=120 and getSpellCD(198067)>0.5 or getSpellCD(192249)<=120 and getSpellCD(192249)>0.5) and   canCast(198103) then
			if	csi("target",198103) then
			  return 0
			  end
		  end 
		
	end
		
		


	 	


	   --AOE攻击
	--mk(40); --初始化敌对列表，使得计数函数工作。

	 if isInCombat("target") and isInCombat("player") and  getNumEnemies("target",10)>=AOERS  and AOE==true  then 
		
		if  canCast(192058) and sdby ==true then
			if csi("target",192058) then 
				return 0
			end
		end
		
		
		
		local tl = getEnemy(40)
          for i = 1,#tl do
            local t1 = tl[i] 
                if getDistance(t1,"player") <40 and getHP(t1)>30  and getDebuffRemain(t1,188389)<0.5 and isInCombat(t1)  then
                     csi(t1,188389)
                end
		  end
		
		if getBuffRemain("player",77762)> 0 then
		        if csi("target",51505) then 
			return 0
		         end
	    end
	
		if   canCast(61882) then
			if csi("target",61882)then 
				return 0
			end
		end
		if  canCast(188443) then
			
			if csl("target",188443) then
				return 0
			end
         end
		
		


		
	end

	--烈焰震击
	if getDebuffRemain("target",188389)<0.5 and  canCast(188389) then
		if   csi("target",188389) then
		  return 0
		end 
	  end 

				--大地震击
				if canCast(8042) then
		
					if csi("target",8042) then
						return 0
					end
				end

				--熔岩爆裂
					if canCast(51505) then
						if csl("target",51505) then
							return 0
						end
					end
				
				--闪电箭
				if getSpellCD(51505)>=2  and getNumEnemies("target",5)<AOERS   then 
						if castSp("target",188196) then
							return 0
						end
					end
					
				--熔岩奔腾
				if getBuffRemain("player",77762)> 0 then
					if csi("target",51505) then 
						return 0
					end
				end

	
	

	


	

		
	

	
		

	
		

		
		
	--流星 （火领主）
	if castPetSpell("target",117588) then
	
		return 0
	 
	end

	--风暴之眼 （风领主）
	if castPetSpell("target",157375) then
	
		return 0
	 
	end
		
		
			
				
			
         
		
end	
	

	
	
	
	

	
	
	




	

	

-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);