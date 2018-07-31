----------------------------------------------
-- 模块属性
-----------------------------------------------------------
-- 定义循环的唯一ID，可以去https://1024tools.com/uuid生成，保证每次都不一样，宇宙唯一。
local rotation_id = "bc378939-482d-4ce6-a751-51acc0222213";
-- 定义循环的英文名称。
local rotation_name = "test_pwarrior_ArmsBfA";
Scorpio("zeus." .. rotation_name)("");
-- 定义多语言字符串。
local L = _Locale("zhCN", true);
if L then
    -- 简体中文系列。
    L[rotation_name] = "测试武器战BfA";
    L["Welcome to use test module."] = "欢迎使用pWarrior_ArmsBfA！";
    L["BCtri"] = "自动爆发";
    L["Avtri"] = "神器饰品";
    L["Attri"] = "自动目标";
    L["AutoAOE"] = "自动AOE";
    L["interrupt"] = "打断模式选择";
end
L = _Locale("zhTW");
if L then
    -- 繁体中文系列。
    L[rotation_name] = "测试武器战BfA";
    L["Welcome to use test module."] = "欢迎使用pWarrior_ArmsBfA！";
    L["BCtri"] = "自动爆发";
    L["Avtri"] = "神器饰品";
    L["Attri"] = "自动目标";
    L["AutoAOE"] = "自动AOE";
    L["interrupt"] = "打断模式选择";
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
rotation.macro = "tt";
-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------
-- 一个模块可以拥有若干配置变量的类别，每个类别可以包含若干配置变量。
-- 有一个不可删除和修改的默认配置变量的类别default_setting_category，还可以自定义添加。
-- 类别和变量会根据添加的先后顺序，依次在界面自上而下显示。默认类别下的变量会显示在最上面。
-- 变量的当前值会保存在WTF中。
-----------------------------------------------------------
-- 给默认类别添加一个配置变量test1，并配置相关属性。
local BCtri_setting = rotation.default_setting_category:create_setting("BCtri"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
BCtri_setting.display_name = L["BCtri"];
BCtri_setting.description = "是否开启自动爆发"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
BCtri_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
BCtri_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
BCtri_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
BCtri_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
BCtri_setting.is_enabled_by_default = true; -- 是否默认启用
BCtri_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
BCtri_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）
local Avtri_setting = rotation.default_setting_category:create_setting("Avtri"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
Avtri_setting.display_name = L["Avtri"];
Avtri_setting.description = "是否自动使用饰品天神和神器技能"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
Avtri_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
Avtri_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
Avtri_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
Avtri_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
Avtri_setting.is_enabled_by_default = true; -- 是否默认启用
Avtri_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
Avtri_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）
local Attri_setting = rotation.default_setting_category:create_setting("Attri"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
Attri_setting.display_name = L["Attri"];
Attri_setting.description = "自动选择目标"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
Attri_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
Attri_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
Attri_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
Attri_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
Attri_setting.is_enabled_by_default = true; -- 是否默认启用
Attri_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
Attri_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）
local AutoAOE_setting = rotation.default_setting_category:create_setting("AutoAOE"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
AutoAOE_setting.display_name = L["AutoAOE"];
AutoAOE_setting.description = "是否自动切换AOE模式，关闭即强制单体循环"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
AutoAOE_setting.value_type = rotation_setting_type.plain; -- 变量值类型（空类型，也就是说只有启用停用一说）
AutoAOE_setting.default_value = nil; -- 变量默认值（空类型不需要默认值）
AutoAOE_setting.optional_values = nil; -- 变量备选值（空类型不需要备选值）
AutoAOE_setting.can_enable_disable = true; -- 是否支持启用停用（既然是空类型就必须支持了，否则还有什么意义）
AutoAOE_setting.is_enabled_by_default = true; -- 是否默认启用
AutoAOE_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（空类型连值都没，还验证个毛）
AutoAOE_setting.value_width = 100; -- 值显示宽度像素（空类型设多少都一回事，反正不显示，就这么搁着吧）
-- 在类别test_category下添加配置变量test5
local interrupt_setting = rotation.default_setting_category:create_setting("interrupt"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
interrupt_setting.display_name = L["interrupt"];
interrupt_setting.description = "Off：关闭 \nBefore：补断 \nAfter：秒断 \n按住Ctrl可暂时屏蔽打断功能"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
interrupt_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
interrupt_setting.default_value = "Before"; -- 变量默认值
interrupt_setting.optional_values = {"Off", "Before", "After"}; -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
interrupt_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
interrupt_setting.is_enabled_by_default = true; -- 是否默认启用
interrupt_setting.validator = nil; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
interrupt_setting.value_width = 130; -- 值显示宽度像素（默认为100）
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
    local speci = 71 --- 250 在 游戏中，/run print(GetSpecializationInfo(GetSpecialization())) 获取当前职业专精
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
    if not IsMounted() and not UnitBuffID("player",6673) then
       if castSpell("player",6673) then return 0; end
    end
    self:rest();
end
function rotation:default_action()
    local zls=5512
    local sil=772
    local zsdj=12294
    local juren=167105
    local jurend=208086
    local zhans=163201
    local xfz=1680
    local yaz=7384
    local tsxf=107574
    local quanj=6552
    local hengs=260708
    local mengj=1464
    local zhongs=262115
    local zj = "player" --自己的引用
    local tg = "target" --目标的引用
    local fz = "focus" --焦点目标的引用
    --[[ if canUse(zls) and getHP("player")<20 then
      useItem(zls)
   end]]
    if IsCurrentSpell("英勇飞跃") or IsCurrentSpell("圣光裁决者") then
        return 0;
    end
    local haste = GetHaste()
    local gcd = max(0.75, 1.5 * 100 / (100+haste))
   local BCtriG 
   local AVtriG
   local AttriG    
    if BCtriG == nil then BCtriG = rotation.settings.BCtri.is_enabled; end
    if AVtriG == nil then AVtriG = rotation.settings.Avtri.is_enabled; end
    if AttriG == nil then AVtrit = rotation.settings.Avtri.is_enabled; end
    local Interrupt = rotation.settings.interrupt.value
    local function SweepCount()
        local sweepCount = 0
        local AutoAOE = rotation.settings.AutoAOE; 
        if AutoAOE.is_enabled then
            for i = 1, 40 do
                local unit = "nameplate" .. i
                if UnitCanAttack("player", unit) and (UnitIsPlayer(unit) or not isInPvP()) and IsSpellInRange(GetSpellInfo(12294), unit) == 1 then sweepCount = sweepCount + 1 end
            end
            if sweepCount <= 7 then
                return sweepCount
            else
                return 7
            end
        else 
            return 1
        end
    end
    local AOE = SweepCount() or 0
    --[[if UnitBuffID(zj,swzy) and getBuffRemain(zj,swzy)<gcd and canCast(swzy) then
      if castSpell(zj,swzy) then return 0; end
   end]]
		autoTarget(zsdj)
    if IsMounted() or not UnitAffectingCombat(zj) or not UnitCanAttack(zj,tg) then
        return 0;
    else
       --[[if UnitIsPlayer(tg) and not AvtriG and not isSlow(tg) and not UnitDebuffID(tg,jurend,zj)  then
            if castSpell(tg,1715) then return 0 ;end
        end  ]]    
        if AOE>1 and (getSpellCD(juren)>30 or getSpellCD(juren)<3) and BCtriG and not morph then
            if castSpell(tg,hengs,true,false,true) then return 0 ;end
        end
        if getRage()<75 then --碎颅
            if castSpell(tg,260643,true,false,true) then return 0 ;end
        end
        if BCtriG and getRage()>30 and (getBuffStacks(zj,yaz,zj)>1 or (UnitBuffID(zj,yaz,zj) and canCast(yaz))) then
            if castSpell(zj,tsxf,true,false,true) then return 0 ;end
            if castSpell(tg,juren,true,false,true) then return 0 ;end
        end
        if UnitDebuffID(tg,jurend,zj) then
            if castSpell(zj,198817) then return 0 ;end--打磨
        end
        if BCtriG and UnitDebuffID(tg,jurend,zj) and getBuffStacks(zj,yaz,zj)<2 then
           if castSpell(tg,yaz,true,false,true) then return 0 ;end
        end
        if (getDebuffRemain(tg,zhongs,zj)<1 or getBuffStacks(zj,yaz,zj)>1) and not (BCtriG and getSpellCD(juren)<4 and getBuffStacks(zj,yaz,zj)>0 and getChargesFrac(yaz)<1.6) then
            if castSpell(tg,zsdj,true,false,true) then return 0 ;end        
        end
		if not (BCtriG and getSpellCD(juren)>2 and getSpellCD(juren)<7 and getChargesFrac(yaz)<1.6) then
			if castSpell(tg,yaz,true,false,true) then return 0 ;end
		end
        if not (BCtriG and getSpellCD(juren)<4 and getBuffStacks(zj,yaz,zj)>0 and getChargesFrac(yaz)<1.6) then
           if castSpell(tg,zsdj,true,false,true) then return 0 ;end
        end
        if getDebuffRemain(tg,sil,zj)<5 then
            if castSpell(tg,sil,true,false,true) then return 0 ;end
        end
		if UnitExists(slt) then
			if castSpell(slt,sil,true,false,true) then return 0 ;end
		end
        if BCtriG and UnitDebuffID(tg,jurend,zj) then
            if castSpell(zj,227847,true,false,true) then return 0 ;end --风车
        end
        if castSpell(tg,zhans,true,false,true)  then return 0 ;end
        if (AOE>2 or getTalent(3,2)) and (getRage()>70 or UnitDebuffID(tg,jurend,zj)) then
           if castSpell(tg,xfz,true,false,true) then return 0 ;end
        elseif getRage()>66 or UnitDebuffID(tg,jurend,zj) then
           if castSpell(tg,mengj,true,false,true) then return 0 ;end
        end
    end
    self:rest();
end
-----------------------------------------------------------
-- 注册模块（自己手动开启）
-----------------------------------------------------------
rotation_manager.instance:register(rotation);