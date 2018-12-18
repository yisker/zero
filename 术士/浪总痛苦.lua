local rotation_id = "5b98395e-9b3a-49b4-8c40-aa592a07bec3";  --本地
local rotation_name = "术士-痛苦 ";
Scorpio("zeus." .. rotation_name)("");
local rotation = zeus.rotation(rotation_id, "术士-痛苦")
rotation.condition_yes_message = "N/A";
rotation.condition_no_message = "N/A";
rotation.interval = 0.1;
rotation.macro = "tongku";

-----------------------------------------------------------
-- 模块变量
-----------------------------------------------------------

-- 一般设置选项  yibanname 
local yibanname = rotation:create_setting_category("yibanname"); 
yibanname.display_name = "|cff00FFFF快捷开关";

--只打目标 gjfocus
local gjfocusname = yibanname:create_setting("gjfocus"); 
gjfocusname.display_name = "只打目标";
gjfocusname.description = "集火时可以使用";
gjfocusname.value_type = rotation_setting_type.plain; 
gjfocusname.default_value = nil; 
gjfocusname.optional_values = nil; 
gjfocusname.can_enable_disable = true; 
gjfocusname.is_enabled_by_default = false; 
gjfocusname.validator = nil; 
gjfocusname.value_width = 80; 

--种子上腐蚀 zzfs
local zzfsname = yibanname:create_setting("zzfs"); 
zzfsname.display_name = "种子上腐蚀";
zzfsname.description = "大于3目标时用种子上腐蚀";
zzfsname.value_type = rotation_setting_type.plain; 
zzfsname.default_value = nil; 
zzfsname.optional_values = nil; 
zzfsname.can_enable_disable = true; 
zzfsname.is_enabled_by_default = false; 
zzfsname.validator = nil; 
zzfsname.value_width = 80; 


--DOT血量限定
local dotHPname = yibanname:create_setting("dotHP"); 
dotHPname.display_name = "血量限定(万)";
dotHPname.description = "低于限定血量的目标不上DOT";
dotHPname.value_type = rotation_setting_type.number; 
dotHPname.default_value = 3; 
dotHPname.optional_values = nil; 
dotHPname.can_enable_disable = false; 
dotHPname.is_enabled_by_default = false; 
dotHPname.validator = function(self, value) 
   if (value >= 0 and value <=200) then
      return true;
   else
      return false, "The number is too small.";
   end
end;
dotHPname.value_width = 100;

-- 诡异魅影 meiying
local meiyingname = yibanname:create_setting("meiying"); 
meiyingname.display_name = "诡异魅影";
meiyingname.description = "诡异魅影设置"; 
meiyingname.value_type = rotation_setting_type.text; 
meiyingname.default_value = "自动卡CD"; 
meiyingname.optional_values = {"自己手动","自动卡CD","AOE"}; 
meiyingname.can_enable_disable = false; 
meiyingname.is_enabled_by_default = false; 
meiyingname.validator = nil; 
meiyingname.value_width = 100; 

-- 邪恶污染 wuran
local wuranname = yibanname:create_setting("wuran"); 
wuranname.display_name = "邪恶污染";
wuranname.description = "邪恶污染设置"; 
wuranname.value_type = rotation_setting_type.text; 
wuranname.default_value = "数量大于1"; 
wuranname.optional_values = {"自动卡CD","数量大于1","数量大于2","数量大于3","自己手动"}; 
wuranname.can_enable_disable = false; 
wuranname.is_enabled_by_default = false; 
wuranname.validator = nil; 
wuranname.value_width = 100; 

-- 腐蚀之种 zhongzi
local zhongziname = yibanname:create_setting("zhongzi"); 
zhongziname.display_name = "腐蚀之种";
zhongziname.description = "腐蚀之种设置"; 
zhongziname.value_type = rotation_setting_type.text; 
zhongziname.default_value = "数量大于2";  
zhongziname.optional_values = {"数量大于2","数量大于3","自己手动"}; 
zhongziname.can_enable_disable = false; 
zhongziname.is_enabled_by_default = false; 
zhongziname.validator = nil; 
zhongziname.value_width = 100;

--黑暗灵魂：哀难  
local ainanname = yibanname:create_setting("ainan"); 
ainanname.display_name = "黑魂：哀难";
ainanname.description = "二绑二卡：能打满6分钟以上时选择,4次黑魂3次黑眼。第1次第4次黑魂绑定第1次第3次黑眼.第2次黑眼无黑魂.第2次第3次黑魂无黑眼"; 
ainanname.value_type = rotation_setting_type.text; 
ainanname.default_value = "绑定黑眼";  
ainanname.optional_values = {"自己手动","绑定黑眼","二绑二卡"};
ainanname.can_enable_disable = false; 
ainanname.is_enabled_by_default = false; 
ainanname.validator = nil; 
ainanname.value_width = 100;

    local ayzn_setting = yibanname:create_setting("ayzn"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    ayzn_setting.display_name = L["暗影之怒"];
    ayzn_setting.description = "按下这个键在鼠标目标位置暗影之怒！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    ayzn_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    ayzn_setting.default_value = "G"; -- 变量默认值
    ayzn_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    ayzn_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    ayzn_setting.is_enabled_by_default = true; -- 是否默认启用
    ayzn_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (#value == 1 ) then
            return true;
        else
            return false, "没有这个按键";
        end
    end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    ayzn_setting.value_width = 100; -- 值显示宽度像素（默认为100）

    local qztkwc_setting = yibanname:create_setting("qztkwc"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    qztkwc_setting.display_name = L["强制痛苦无常"];
    qztkwc_setting.description = "按下这个键强制痛苦无常！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    qztkwc_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    qztkwc_setting.default_value = "E"; -- 变量默认值
    qztkwc_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    qztkwc_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    qztkwc_setting.is_enabled_by_default = true; -- 是否默认启用
    qztkwc_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (#value == 1 ) then
            return true;
        else
            return false, "没有这个按键";
        end
    end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    qztkwc_setting.value_width = 100; -- 值显示宽度像素（默认为100） 

    local qzaoe_setting = yibanname:create_setting("qzaoe"); -- 指定变量的名字，用于在脚本中进行引用（注意，哪怕是不同类别下的配置变量名字也不能重复）
    qzaoe_setting.display_name = L["强制施放AOE技能"];
    qzaoe_setting.description = "按下这个键强制AOE技能(诡异魅影、腐蚀之种)！由于暴雪本身限制，只能支持A-Z，0-9"; -- 变量在界面上的鼠标提示说明，充分利用换行符和暴雪颜色可以实现丰富的效果
    qzaoe_setting.value_type = rotation_setting_type.text; -- 变量值类型（text类型）
    qzaoe_setting.default_value = "F"; -- 变量默认值
    qzaoe_setting.optional_values = nil -- 变量备选值（设置备选值后会出现单选下拉菜单，供用户选择）
    qzaoe_setting.can_enable_disable = false; -- 是否支持启用停用（支持则在界面上出现勾选框）
    qzaoe_setting.is_enabled_by_default = true; -- 是否默认启用
    qzaoe_setting.validator = function(self, value) -- 变量值校验函数，检测值除了类型以外的其他合法性（如果合法就返回true，否则返回false, [错误信息]）
        if (#value == 1 ) then
            return true;
        else
            return false, "没有这个按键";
        end
    end; -- 变量值校验函数，检测值除了类型以外的其他合法性（因为带备选值，所以不可能需要校验，不设即可）
    qzaoe_setting.value_width = 100; -- 值显示宽度像素（默认为100）

local zaxiang = rotation:create_setting_category("zaxiang"); 
zaxiang.display_name = "|cff00FFFF杂项";

--不攻击怪物名字
local test = zaxiang:create_setting("test"); 
test.display_name = "不攻击目标";
test.description = "填写不攻击目标的全名,只能填写一个名字,(纳兹曼尼鲜血妖术师,蛛魔虚空编织者,黑暗幼体,腐烂孢子,祖尔的爪牙.已经内置不用填写)"; 
test.value_type = rotation_setting_type.text; 
test.default_value = ""; 
test.optional_values = {};
test.can_enable_disable = false; 
test.is_enabled_by_default = false; 
test.validator = nil; 
test.value_width = 100; 


--自动选目标zdxmb
local zdxmbname = zaxiang:create_setting("zdxmb"); 
zdxmbname.display_name = "自动目标";
zdxmbname.description = "无目标,目标不可攻击,目标死亡时自动选目标";
zdxmbname.value_type = rotation_setting_type.plain; 
zdxmbname.default_value = nil; 
zdxmbname.optional_values = nil; 
zdxmbname.can_enable_disable = true; 
zdxmbname.is_enabled_by_default = false; 
zdxmbname.validator = nil; 
zdxmbname.value_width = 80; 

--PVP 开关
local pvpkgname = zaxiang:create_setting("pvpkg"); 
pvpkgname.display_name = "PVP 开关";
pvpkgname.description = "不勾选时不会攻击玩家控制的角色";
pvpkgname.value_type = rotation_setting_type.plain; 
pvpkgname.default_value = nil; 
pvpkgname.optional_values = nil; 
pvpkgname.can_enable_disable = true; 
pvpkgname.is_enabled_by_default = false; 
pvpkgname.validator = nil; 
pvpkgname.value_width = 80; 

-- 自动给自己绑灵魂石
local zdlhsname = zaxiang:create_setting("zdlhs"); 
zdlhsname.display_name = "自动石头";
zdlhsname.description = "自动给自己绑灵魂石。"; 
zdlhsname.value_type = rotation_setting_type.plain; 
zdlhsname.default_value = nil; 
zdlhsname.optional_values = nil; 
zdlhsname.can_enable_disable = true; 
zdlhsname.is_enabled_by_default = false; 
zdlhsname.validator = nil; 
zdlhsname.value_width = 80;

--驱散 qvsan
local qvsanname = zaxiang:create_setting("qvsan"); 
qvsanname.display_name = "无脑驱散"
qvsanname.description = "带小鬼或者牺牲小鬼时勾选有效";
qvsanname.value_type = rotation_setting_type.plain; 
qvsanname.default_value = nil; 
qvsanname.optional_values = nil; 
qvsanname.can_enable_disable = true; 
qvsanname.is_enabled_by_default = false; 
qvsanname.validator = nil; 
qvsanname.value_width = 80; 

--打断 zddd
local zdddname = zaxiang:create_setting("zddd"); 
zdddname.display_name = "无脑打断"
zdddname.description = "带狗或者牺牲狗时勾选有效";
zdddname.value_type = rotation_setting_type.plain; 
zdddname.default_value = nil; 
zdddname.optional_values = nil; 
zdddname.can_enable_disable = true; 
zdddname.is_enabled_by_default = false; 
zdddname.validator = nil; 
zdddname.value_width = 80; 

-- 自动招宝宝
local zdzhaobbname = zaxiang:create_setting("zdzhaobb"); 
zdzhaobbname.display_name = "自动宝宝";
zdzhaobbname.description = "自动招宝宝"; 
zdzhaobbname.value_type = rotation_setting_type.plain; 
zdzhaobbname.default_value = nil; 
zdzhaobbname.optional_values = nil; 
zdzhaobbname.can_enable_disable = true; 
zdzhaobbname.is_enabled_by_default = false; 
zdzhaobbname.validator = nil; 
zdzhaobbname.value_width = 80;

--选择宝宝类型
local BBname = zaxiang:create_setting("BB");
BBname.display_name = "宝宝类型";
BBname.description = "选择宝宝类型"; 
BBname.value_type = rotation_setting_type.text; 
BBname.default_value = "虚空行者"; 
BBname.optional_values = {"小鬼","虚空行者","地狱猎犬","魅魔"}; 
BBname.can_enable_disable = false; 
BBname.is_enabled_by_default = false; 
BBname.validator = nil; 
BBname.value_width = 80; 

-- 自动开启爆燃冲刺
local zdkqxpname = zaxiang:create_setting("zdkqxp"); 
zdkqxpname.display_name = "自动爆燃"; 
zdkqxpname.description = "自动开启爆燃冲刺。自动开启的血量阀值在下面设置"; 
zdkqxpname.value_type = rotation_setting_type.plain;
zdkqxpname.default_value = nil; 
zdkqxpname.optional_values = nil; 
zdkqxpname.can_enable_disable = true; 
zdkqxpname.is_enabled_by_default = false; 
zdkqxpname.validator = nil; 
zdkqxpname.value_width = 80; 

--开启爆燃冲刺阀值
local zdxpfzname = zaxiang:create_setting("zdxpfz"); 
zdxpfzname.display_name = "爆燃血量";
zdxpfzname.description = "自动开启爆燃冲刺血量限定";
zdxpfzname.value_type = rotation_setting_type.number; 
zdxpfzname.default_value = 2; 
zdxpfzname.optional_values = nil; 
zdxpfzname.can_enable_disable = false; 
zdxpfzname.is_enabled_by_default = false; 
zdxpfzname.validator = function(self, value) 
   if (value >= 0 and value <=100) then
      return true;
   else
      return false, "The number is too small.";
   end
end;
zdxpfzname.value_width = 80;


local jianshang = rotation:create_setting_category("jianshang"); 
jianshang.display_name = "|cff00FFFF减伤选项";

--治疗石zls
local zlsname = jianshang:create_setting("zls"); 
zlsname.display_name = "治疗石阈值";
zlsname.description = "设置为0时不使用";
zlsname.value_type = rotation_setting_type.number; 
zlsname.default_value = 35; 
zlsname.optional_values = nil; 
zlsname.can_enable_disable = false; 
zlsname.is_enabled_by_default = false; 
zlsname.validator = function(self, value) 
   if (value >= 0 and value < 100) then
      return true;
   else
      return false, "数字超出范围";
   end
end;
zlsname.value_width = 80;

--不灭决心  bmjx
local bmjxname = jianshang:create_setting("bmjx"); 
bmjxname.display_name = "不灭决心阈值";
bmjxname.description = "设置为0时不会对自己自动使用不灭决心";
bmjxname.value_type = rotation_setting_type.number; 
bmjxname.default_value = 30; 
bmjxname.optional_values = nil; 
bmjxname.can_enable_disable = false; 
bmjxname.is_enabled_by_default = false; 
bmjxname.validator = function(self, value) 
   if (value >= 0 and value <= 100) then
      return true;
   else
      return false, "The number is too small.";
   end
end;
bmjxname.value_width = 80;  

--黑暗契约  haqy
local haqy = jianshang:create_setting("haqy"); 
haqy.display_name = "黑暗契约阈值";
haqy.description = "设置为0时不会对自己自动使用黑暗契约";
haqy.value_type = rotation_setting_type.number; 
haqy.default_value = 30; 
haqy.optional_values = nil; 
haqy.can_enable_disable = false; 
haqy.is_enabled_by_default = false; 
haqy.validator = function(self, value) 
   if (value >= 0 and value <= 100) then
      return true;
   else
      return false, "The number is too small.";
   end
end;
haqy.value_width = 80;  

--吸取生命  xqsm
local xqsm = jianshang:create_setting("xqsm"); 
xqsm.display_name = "吸取生命阈值";
xqsm.description = "设置为0时不使用,也可按住左Ctrl手动吸取生命,没人奶你时可以很快吸满";
xqsm.value_type = rotation_setting_type.number; 
xqsm.default_value = 30; 
xqsm.optional_values = nil; 
xqsm.can_enable_disable = false; 
xqsm.is_enabled_by_default = false; 
xqsm.validator = function(self, value) 
   if (value >= 0 and value <= 100) then
      return true;
   else
      return false, "The number is too small.";
   end
end;
xqsm.value_width = 80; 

-- 提示信息
local shuoming1 =  rotation:create_setting_category("shuoming1")
shuoming1.display_name = "|cffbdbdbd单体天赋推荐：33X2X23或者31X2X23(有钻心特质)";
local shuoming2 =  rotation:create_setting_category("shuoming2")
shuoming2.display_name = "|cffbdbdbd多目标天赋推荐：32X2X22或者32X2X23";
local shuoming3 =  rotation:create_setting_category("shuoming3")
shuoming3.display_name = "|cffbdbdbd黑眼爆发开关宏：/"..ADDON_SLASH_COMMAND.." tongku baofa";
local shuoming10 =  rotation:create_setting_category("shuoming10")
shuoming10.display_name = "|cffbdbdbd宝宝跟随宏：/petfollow";
local shuoming11 =  rotation:create_setting_category("shuoming11")
shuoming11.display_name = "|cffbdbdbd解散宝宝宏：/run PetDismiss()";
--local shuoming4 =  rotation:create_setting_category("shuoming4")
--shuoming4.display_name = "|cffbdbdbd按住'e'键:强制施放痛苦无常";
local shuoming5 =  rotation:create_setting_category("shuoming5")
shuoming5.display_name = "|cffbdbdbd按住左Shift:战复鼠标指向目标)";
--shuoming5.display_name = "|cffbdbdbd按住'1'键:战复鼠标指向目标)";
--local shuoming6 =  rotation:create_setting_category("shuoming6")
--shuoming6.display_name = "|cffbdbdbd按住'2'键:鼠标位置暗影之怒";
local shuoming7 =  rotation:create_setting_category("shuoming7")
shuoming7.display_name = "|cffbdbdbd按住左'Ctrl'键:手动吸取生命";
local shuoming8 =  rotation:create_setting_category("shuoming8")
shuoming8.display_name = "|cffbdbdbd按住左'Alt'键:手动驱散、打断、魅惑(不同的宝宝)";
--local shuoming9 =  rotation:create_setting_category("shuoming9")
--shuoming9.display_name = "|cffbdbdbd按住左'F'键:手动AOE技能(诡异魅影、腐蚀之种)";

-- 定义技能ID
local S={}; 
S["死亡之箭"]   = 264106
S["鬼影缠身"]   = 48181
S["不灭决心"]   = 104773
S["黑暗契约"]   = 108416
S["召唤黑眼"]   = 205180
S["吸取灵魂"]   = 198590
S["吸取生命"]   = 234153
S["暗影之怒"]   = 30283
S["灵魂石"]     = 20707   
S["爆燃冲刺"]   = 111400
S["生命虹吸"]   = 63106
S["生命通道"]   = 755
S["痛楚"]       = 980
S["痛苦无常"]   = 30108
S["腐蚀之种"]   = 27243
S["腐蚀术de"]   = 146739
S["腐蚀术"]     = 172
S["诡异魅影"]   = 205179
S["恶魔掌控"]   = 119898
S["烧灼驱魔"]   = 119905
S["法术封锁"]   = 19647
S["诱惑"]       = 119909 
S["暗影箭"]     = 232670
S["黑暗灵魂"]   = 113860
S["灾难瀑流"]   = 275378
S["邪恶污染"]   = 278350
S["制造灵魂之井"]   = 29893

S["践踏"]    = 240447
S["禁锢"]   = 217832
S["妖术"]   = 51514
S["冰冻陷阱"]   = 187650
S["分筋错骨"]   = 115078
S["忏悔"]   = 20066
S["魅惑"]   = 6358
S["放逐"]   = 710
S["恐惧"]   =  5782
S["束缚亡灵"]   = 9484
S["变形术"]   = 118
S["闷棍"]   = 6770
S["能源关闭"]   = 271965
S["老七"]= 274230 
------------------------------------------------------------------------------------------------ ------------------------------------------------       
-- 函数简写
local be  = getBuffRemain
local bs  = getBuffStacks
local de  = getDebuffRemain
local isp  = IsSpellInRange
local cs  = CastSpellByName
local cd  = getSpellCD
local Group = GetNumGroupMembers
local Speed = GetUnitSpeed
local dec =getDebuffCount 
-----------------------------------------------------------
-- 模块脚本
-----------------------------------------------------------
function rotation:macro_handler(argument)
   if argument == "baofa" and baofa ~= true then
      --api.log_message(log_level.important, "|cffcc3300黑眼爆发：开启", false, true, true)
      ActionStatus_DisplayMessage("|cffcc3300黑眼爆发：开启",true) 
      baofa = true
      return 0;
   end
   if argument == "baofa" and baofa == true then
      ActionStatus_DisplayMessage("黑眼爆发：关闭",true) 
      --api.log_message(log_level.important, "黑眼爆发：关闭", false, true, true)
      baofa = false 
      return 0;
   end  
end

function rotation:condition_action()    
   local current_specialization = GetSpecializationInfo(GetSpecialization())
   return current_specialization == 265;
end 
-----------------------------------------------------------------------------------------------------------------------------------------

function rotation:precombat_action()
   if de("player",S["践踏"])~=0 and de("player",S["践踏"])<=0.15 and (UnitCastingInfo("player")~=nil or UnitChannelInfo("player")~=nil) then
      rm("/stopcasting")
   end 
   if baofauto == true then baofauto = false end  
      local qa =  qzaoe_setting.value                        --强制aoe    qa
   if isKeyDown(qa) and  UnitExists("target") and isp("腐蚀之种","target") and (de("player",S["践踏"])==0 or de("player",S["践踏"])>(getGCD()*1.67+0.1)) then cs("腐蚀之种","target") end 
   if IsMounted("player") or UnitCastingInfo("player")~=nil or UnitChannelInfo("player")~=nil or cd(61304) > 0.2 then
      return true;
   end 
   local zdlhs = self.settings.zdlhs.is_enabled        -- 自动给自己绑灵魂石 
   local zdkqxp = self.settings.zdkqxp.is_enabled      --自动开启爆燃冲刺
   local zdzhaobb = self.settings.zdzhaobb.is_enabled  -- 自动自动招宝宝 
   local zdxpfz = self.settings.zdxpfz.value           --爆燃冲刺阀值
   local BB = self.settings.BB.value                   --选择宝宝类型
   
   if (Speed("player")==0 or getHP("player")<=zdxpfz) and be("player",S["爆燃冲刺"]) ~= 0 then
      rm("/cancelAura 爆燃冲刺")
   end 
   if getTalent(3,2) and Speed("player")>0 and be("player",S["爆燃冲刺"]) == 0 and zdkqxp == true and getHP("player")>zdxpfz then
      rm("/cast 爆燃冲刺")
   end
   -----------------------------------------------------------------------------------------------------------------------------------------
   --制造治疗石
   local _,hasin = hasItem(5512)
   if hasin == 0 and cd(S["制造灵魂之井"])<=0.2 then rm("/cast 制造灵魂之井") end  
   -----------------------------------------------------------------------------------------------------------------------------------------
   --灵魂石
   if be("player",S["灵魂石"]) == 0 and cd(S["灵魂石"])<=0.2 and zdlhs == true then
      rm("/cast [target=player]灵魂石") 
   end   
   --招宝宝 
   if _t==nil then _t=GetTime(); end
   if zdzhaobb == true  and GetTime()>= _t then
      if BB == "虚空行者" and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "虚空行者") and rm("/cast 召唤虚空行者") then end
      if BB == "小鬼"  and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "小鬼") and rm("/cast 召唤小鬼") then end
      if BB == "地狱猎犬" and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "地狱猎犬") and rm("/cast 召唤地狱猎犬") then end
      if BB == "魅魔" and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "魅魔") and rm("/cast 召唤魅魔") then end
      _t=GetTime()+getGCD()
   end   
   self:rest();
end

-- 主循环 
---------------------------------------------------------------------
function rotation:default_action() 
   if de("player",S["践踏"])~=0 and de("player",S["践踏"])<=0.15 and (UnitCastingInfo("player")~=nil or UnitChannelInfo("player")~=nil) then
      rm("/stopcasting")
   end 
   if baofauto == true and cd(S["召唤黑眼"])>170 then baofauto = false end    
   if IsMounted("player") or UnitChannelInfo("player") == "生命通道" or UnitChannelInfo("player") == "吸取生命" then 
      return true; 
   end 
   --按2暗影之怒   
   local an =  ayzn_setting.value                        --暗怒    an
   if isKeyDown(an) and (de("player",S["践踏"])==0 or de("player",S["践踏"])>(getGCD()+0.1)) then rm("/cast [@cursor] 暗影之怒") end  
   ------------------------------------------------------------------------------------------------ ------------------------------------------------     
   --变量赋值1
   local zls = self.settings.zls.value                   --治疗石        zls
   local bmjx = self.settings.bmjx.value                 --不灭决心       bmjx
   local zdzhaobb = self.settings.zdzhaobb.is_enabled    --自动自动招宝宝 
   local BB = self.settings.BB.value                     --选择宝宝类型
   local zdxmb = self.settings.zdxmb.is_enabled          --自动选目标    zdxmb
   local pvpkg = self.settings.pvpkg.is_enabled          --pvp开关       pvpkg   
   local zzfs = self.settings.zzfs.is_enabled            --种子上腐蚀     zzfs   
   local gjfocus = self.settings.gjfocus.is_enabled      --强制攻击焦点   gjfocus
   local meiying = self.settings.meiying.value           --诡异魅影 meiying
   local wuran = self.settings.wuran.value               --污染 wuran   
   local dotHP = self.settings.dotHP.value               --DOT血量限定 dotHP
   local zhongzi = self.settings.zhongzi.value           --腐蚀之种 zhongzi
   local ainan = self.settings.ainan.value               --黑暗灵魂：哀难 ainan
   local haqy = self.settings.haqy.value                 --黑暗契约      haqy
   local xqsm = self.settings.xqsm.value                 --吸取生命      xqsm
   local test = self.settings.test.value        
   local qvsan = self.settings.qvsan.is_enabled         --驱散 qvsan   
   local zddd = self.settings.zddd.is_enabled           --打断 zddd  
   --local SayjHP   = getNumInSpell(232670)                --暗影箭伤害
   local qa =  qzaoe_setting.value                        --强制aoe    qa
   local qtk =  qztkwc_setting.value                        --强制痛苦无常    qtk

   
   ------------------------------------------------------------------------------------------------ ------------------------------------------------    
   --治疗石 
   local _,hasin = hasItem(5512)
   if getHP("player")<zls and hasin>0 and getItemCD(5512)<=0 then
      rm("/cast 治疗石")             
   end    
   ------------------------------------------------------------------------------------------------ ------------------------------------------------ 
   --圣佑术
   if getHP("player")<=bmjx and cd(S["不灭决心"]) <= 0.2 then
      rm("/cast 不灭决心")
   end       
   ------------------------------------------------------------------------------------------------ ------------------------------------------------ 
   --黑暗契约
   if getTalent(3,3) == true and getHP("player")<=haqy and cd(S["黑暗契约"]) <= 0.2 then
      rm("/cast 黑暗契约")
   end   
   if cd(61304) > 0.2 then
      return true; 
   end 
   -------------------------------------------------------------------------------------------------------------------------------------------------        
   --变量赋值2
   local bn = UnitPower("player",7)   
   ------------------------------------------------------------------------------------------------ ------------------------------------------------     
   --取消爆燃冲刺
   if Speed("player")==0 and be("player",S["爆燃冲刺"]) ~= 0 then
      rm("/cancelAura 爆燃冲刺")
   end 
   ------------------------------------------------------------------------------------------------ ------------------------------------------------        
   --战复
   if IsLeftShiftKeyDown() and UnitExists("mouseover") then rm("/cast [target=mouseover]灵魂石") end   
   --if isKeyDown('1') and UnitExists("mouseover") then rm("/cast [target=mouseover]灵魂石") end
   ------------------------------------------------------------------------------------------------ ------------------------------------------------           

      --打断当前目标施法 
      if (zddd or IsLeftAltKeyDown()) and UnitExists("pet") and UnitCreatureFamily("pet") == "地狱猎犬"  and UnitExists("target") and cd(S["法术封锁"]) <= 0.2 and amac("target", 1, 0)  then
         cs("法术封锁","target")
      end  
      --诱惑当前目标  
      if IsLeftAltKeyDown() and UnitExists("pet") and UnitCreatureFamily("pet") == "魅魔" and UnitExists("target") and cd(S["诱惑"]) <= 0.2 then
         cs("诱惑","target")    
      end  
      --自动驱散 
      if (qvsan or IsLeftAltKeyDown()) and UnitExists("pet") and UnitCreatureFamily("pet") == "小鬼" and cd(S["烧灼驱魔"]) <= 0.2 and  MagicDispel(S["烧灼驱魔"]) then         
      end  
  
   ------------------------------------------------------------------------------------------------ ------------------------------------------------        
   --召唤宝宝
   if _t==nil then _t=GetTime(); end
   if zdzhaobb == true  and GetTime()>= _t then
      if BB == "虚空行者" and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "虚空行者") and rm("/cast 召唤虚空行者") then end
      if BB == "小鬼"  and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "小鬼") and rm("/cast 召唤小鬼") then end
      if BB == "地狱猎犬" and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "地狱猎犬") and rm("/cast 召唤地狱猎犬") then end
      if BB == "魅魔" and (not UnitExists("pet") or getHP("pet")<=1 or UnitCreatureFamily("pet") ~= "魅魔") and rm("/cast 召唤魅魔") then end
      _t=GetTime()+getGCD()
   end    
   ------------------------------------------------------------------------------------------------ ------------------------------------------------     
   --filter
   local function zhendang()  --震荡1.5
      return de("player",S["践踏"])==0 or de("player",S["践踏"])>(getGCD()+0.1)
   end  
   local function zhendang2()  --震荡2.0
      return de("player",S["践踏"])==0 or de("player",S["践踏"])>(getGCD()*1.333+0.1)
   end  
   local function zhendang3()  --震荡2.5
      return de("player",S["践踏"])==0 or de("player",S["践踏"])>(getGCD()*1.667+0.1)
   end  
   -- local function znpl(u)
   --   return (de(u,233490,"player")>getGCD() or de(u,233496,"player")>getGCD() or de(u,233497,"player")>getGCD() or de(u,233498,"player")>getGCD() or de(u,233499,"player")>getGCD())
   --  and dec(u,S["痛苦无常"] ,"player")==1 and (de(u,233490,"player")<2*getGCD() and de(u,233496,"player")<2*getGCD() and de(u,233497,"player")<2*getGCD() and de(u,233498,"player")<2*getGCD() and de(u,233499,"player")<2*getGCD())
   -- end 
   local function NOtgfilter(u)
      return de(u,S["禁锢"])==0 and de(u,S["妖术"])==0 and de(u,S["冰冻陷阱"])==0 and de(u,S["分筋错骨"])==0 and de(u,S["妖术"])==0 and de(u,S["忏悔"])==0 and de(u,S["魅惑"])==0 
      and de(u,S["放逐"])==0 and de(u,S["恐惧"])==0 and de(u,S["束缚亡灵"])==0 and de(u,S["变形术"])==0 and de(u,S["闷棍"])==0 and be(u,S["能源关闭"])==0 and be(u,S["老七"])==0 
      and de(u,261266)==0 and de(u,261265)==0 and de(u,261264)==0 and UnitName(u)~="黑暗幼体" and UnitName(u)~="腐烂孢子" and UnitName(u)~="祖尔的爪牙"
   end 
   local function NOnamefilter(u)
      return UnitName(u)~="纳兹曼尼鲜血妖术师" and UnitName(u)~="蛛魔虚空编织者" and UnitName(u) ~= test        
   end     
   local function tgfilter(u)
      return (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end
   --没有有腐蚀之种的
   local function tgnotfssfilter(u)
      return de(u,S["腐蚀术de"],"player")==0 and (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end  
   --有腐蚀之种的
   local function tgfszzfilter(u)
      return de(u,S["腐蚀之种"],"player")~=0 and (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end 
   --痛楚unit0
   local function tgtc0filter(u)
      return de(u,S["痛楚"],"player")~=0 and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end    
   --痛楚unit1
   local function tgtc1filter(u)
      return de(u,S["痛楚"],"player")~=0 and de(u,S["痛楚"],"player")<5.4 and UnitHealth(u)>dotHP*10000 and (UnitAffectingCombat(u) or getHP(u)<100) 
      and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end 
   --痛楚unit2
   local function tgtc2filter(u)
      return de(u,S["痛楚"],"player")==0 and UnitHealth(u)>dotHP*10000 and (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end
   --痛楚unit3
   local function tgtc3filter(u)
      return de(u,S["痛楚"],"player")<9 and UnitHealth(u)>dotHP*10000 and (UnitAffectingCombat(u) or getHP(u)<100) 
      and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end
   --腐蚀术unit
   local function tgfssfilter(u)
      return ((getTalent(2,2) and de(u,S["腐蚀术de"],"player")==0) or (not getTalent(2,2) and de(u,S["腐蚀术de"],"player")<=4.2)) and NOtgfilter(u) and NOnamefilter(u)
      and de(u,S["痛楚"],"player")~=0 and UnitHealth(u)>dotHP*10000 and (UnitAffectingCombat(u) or getHP(u)<100) and (pvpkg or not UnitIsPlayer(u))
   end
   --腐蚀术3unit
   local function tgfss3filter(u)
      return not getTalent(2,2) and de(u,S["腐蚀术de"],"player")<=8 and de(u,S["痛楚"],"player")~=0 and UnitHealth(u)>dotHP*10000 
      and (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end    
   --生命虹吸3unit
   local function tgsmhxfilter(u)
      return getTalent(2,3) and de(u,S["生命虹吸"],"player")<=4.5 and de(u,S["痛楚"],"player")~=0 and UnitHealth(u)>dotHP*10000 
      and (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
   end  
   --生命虹吸3unit
   local function tgsmhx3filter(u)
      return getTalent(2,3) and de(u,S["生命虹吸"],"player")<=8 and de(u,S["痛楚"],"player")~=0 and (pvpkg or not UnitIsPlayer(u))
      and UnitHealth(u)>dotHP*10000 and (UnitAffectingCombat(u) or getHP(u)<100) and NOtgfilter(u) and NOnamefilter(u)
   end 
   
   --痛苦无常1unit
   local function tgwc1filter(u)
      return de(u,S["痛楚"],"player")~=0 and de(u,S["腐蚀术de"],"player")~=0 and (de(u,S["鬼影缠身"],"player")~=0 or de(u,S["诡异魅影"],"player")~=0) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
      and (dec(u,S["痛苦无常"] ,"player")==0 or (dec(u,S["痛苦无常"] ,"player")==1 and de(u,233490,"player")<getGCD() and de(u,233496,"player")<getGCD() and de(u,233497,"player")<getGCD() and de(u,233498,"player")<getGCD() and de(u,233499,"player")<getGCD()))
   end 
   --痛苦无常2unit   
   local function tgwc2filter(u)
      return de(u,S["痛楚"],"player")~=0 and de(u,S["腐蚀术de"],"player")~=0 and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
      and (dec(u,S["痛苦无常"] ,"player")==0 or (dec(u,S["痛苦无常"] ,"player")==1 and de(u,233490,"player")<getGCD() and de(u,233496,"player")<getGCD() and de(u,233497,"player")<getGCD() and de(u,233498,"player")<getGCD() and de(u,233499,"player")<getGCD()))
   end 
   --痛苦无常3unit   
   local function tgwc3filter(u)
      return (de(u,S["痛楚"],"player")~=0 or de(u,S["腐蚀术de"],"player")~=0) and NOtgfilter(u) and NOnamefilter(u) and (pvpkg or not UnitIsPlayer(u))
      and (dec(u,S["痛苦无常"] ,"player")==0 or (dec(u,S["痛苦无常"] ,"player")==1 and de(u,233490,"player")<getGCD() and de(u,233496,"player")<getGCD() and de(u,233497,"player")<getGCD() and de(u,233498,"player")<getGCD() and de(u,233499,"player")<getGCD()))
   end 
   
   --[[
   -- or (znpl(u) and be("player",S["灾难瀑流"])==0) 
   local function wckg(u)   
      return ((getTalent(1,3) and cd(S["死亡之箭"])<=3*getGCD() and cd(S["死亡之箭"])>getGCD() and dec(u,S["痛苦无常"] ,"player")<=1) or (getTalent(1,3) and cd(S["死亡之箭"])<=0 and dec(u,S["痛苦无常"] ,"player")==0)            
         or (cd(S["召唤黑眼"])>161 and dec(u,S["痛苦无常"] ,"player")<5) or bn>4 or (dec(u,S["痛苦无常"] ,"player")==0 and lp~=true)) and ((baofa == true and cd(S["召唤黑眼"]) >= (5-bn)*11) or baofa ~= true)
      and bn>0 and getLastSpell() ~= S["痛苦无常"] and UnitCastingInfo("player")~="痛苦无常" and isp("痛苦无常",u)==1 and NOtgfilter(u) and (UnitAffectingCombat(u) or getHP(u)<100)
   end  
   ]]--
   
   --死亡之箭
   local function swzj()
      return getTalent(1,3) and cd(S["死亡之箭"])<=getGCD() and (cd(S["召唤黑眼"])>15 or baofa ~= true)
   end
   
   --腐蚀术条件
   local tgfszz = getOneEnemy(40,tgfszzfilter) 
   local function fss() 
      return UnitCastingInfo("player")~="腐蚀之种" and tgfszz==nil
   end  
   ------------------------------------------------------------------------------------------------ ------------------------------------------------
   
   -- 目标引擎  
   local tg
   local tgauto = getOneEnemy(40,tgfilter)
   if UnitExists("target") and getDistance("player","target")<=40 and (pvpkg or not UnitIsPlayer("target")) and NOtgfilter("target") 
   and (UnitAffectingCombat("target") or getHP("target")<100) then
      tg = "target"
   else
      if UnitExists(tgauto) and tgfilter(tgauto) and (pvpkg or not UnitIsPlayer(tgauto)) and (UnitAffectingCombat(tgauto) or getHP(tgauto)<100) then
         tg = tgauto  
      else    
         tg = nil  
      end 
   end 
   -- 自动选目标     
   if (not UnitExists("target") or not UnitCanAttack("target","player") or (UnitExists("target") and getDistance("player","target")>40) or not NOtgfilter("target")) and zdxmb == true and tg then
      TargetUnit(tg)
   end
   
   ------------------------------------------------------------------------------------------------ ----------------------------------------------
   local tgtc,tgwc
   local tgtcs = getEnemy(40,tgtc0filter)
   local tgwc1 = getOneEnemy(40,tgwc1filter)
   local tgwc2 = getOneEnemy(40,tgwc2filter)
   local tgwc3 = getOneEnemy(40,tgwc3filter)
   
   local tgtc1 = getOneEnemy(40,tgtc1filter)
   local tgtc2 = getOneEnemy(40,tgtc2filter)
   local tgtc3 = getOneEnemy(40,tgtc3filter)       
   local tgfss = getOneEnemy(40,tgfssfilter) 
   local tgsmhx = getOneEnemy(40,tgsmhxfilter) 
   local tgfss3 = getOneEnemy(40,tgfss3filter) 
   local tgsmhx3 = getOneEnemy(40,tgsmhx3filter) 
   local tgaoe,tgaoen = getBiggestUnitCluster(40,10,tgfilter)                         --AOE判断
   local tgaoenotfss,tgaoenotfssn = getBiggestUnitCluster(40,10,tgnotfssfilter)       --种子上DOT  
   ------------------------------------------------------------------------------------------------ ----------------------------------------------  

   if tgtc1 then
      tgtc = tgtc1
   else
      if tgtc2 then
         tgtc = tgtc2  
      else 
         tgtc = nil
      end   
   end  

   local function wckg()   
      return ((baofa == true and cd(S["召唤黑眼"]) >= (5-bn)*11) or baofa ~= true) and bn>0 and getLastSpell() ~= S["痛苦无常"] and UnitCastingInfo("player")~="痛苦无常" 
   end  

   if UnitExists("target") and getDistance("player","target")<=40 and (pvpkg or not UnitIsPlayer("target")) and de("target",S["痛楚"],"player")~=0 and de("target",S["腐蚀术de"],"player")~=0 and NOtgfilter("target")
      and (dec("target",S["痛苦无常"],"player")==0 or (dec("target",S["痛苦无常"],"player")==1 and de("target",233490,"player")<getGCD() and de("target",233496,"player")<getGCD() and de("target",233497,"player")<getGCD() and de("target",233498,"player")<getGCD() and de("target",233499,"player")<getGCD())) then
      tgwc = "target" 
   else
      if tgwc1 then
         tgwc = tgwc1
      else
         if tgwc2 then
            tgwc = tgwc2 
         else
            if tgwc3 then
               tgwc = tgwc3 
            else
               tgwc = nil
            end
         end
      end
   end 
   ------------------------------------------------------------------------------------------------ ----------------------------------------------   
   if tgaoe and isKeyDown(qa) and getTalent(4,2) and cd(S["诡异魅影"])<=0.2 and getTimeToDie(tgaoe)>8 then 
      cs("诡异魅影",tgaoe)
   end
   if tgaoe and isKeyDown(qa) and isp("腐蚀之种",tgaoe) and zhendang3() then cs("腐蚀之种",tgaoe) end
   ------------------------------------------------------------------------------------------------ ----------------------------------------------  
   local function tgdot1()           
      if tg and isp("痛楚",tg)==1 and de(tg,S["痛楚"],"player")<=5.4 then
         cs("痛楚",tg)
         return true      
      end
      if tg and isp("腐蚀术",tg)==1 and fss() and getTalent(2,2) and de(tg,S["腐蚀术de"],"player")==0 then
         cs("腐蚀术",tg)
         return true      
      end                      
      if tg and isp("腐蚀术",tg)==1 and fss() and not getTalent(2,2) and de(tg,S["腐蚀术de"],"player")<=4.2 then
         cs("腐蚀术",tg)
         return true      
      end       
      if tg and getTalent(2,3) and isp("生命虹吸",tg)==1 and de(tg,S["生命虹吸"],"player")<=4.5 then
         cs("生命虹吸",tg)
         return true      
      end      
   end  
   
   local function tgdot2()   
      if tg and isp("痛楚",tg)==1 and de(tg,S["痛楚"],"player")<=6 then
         cs("痛楚",tg)
      end   
      if tg and isp("腐蚀术",tg)==1 and fss() and ((getTalent(2,2) and de(tg,S["腐蚀术de"],"player")==0) or (not getTalent(2,2) and de(tg,S["腐蚀术de"],"player")<=6)) then
         cs("腐蚀术",tg) 
      end
      if tg and getTalent(2,3) and isp("生命虹吸",tg)==1 and de(tg,S["生命虹吸"],"player")<=6 then
         cs("生命虹吸",tg)  
      end  
   end  
   ------------------------------------------------------------------------------------------- ----------------------------------------------  
   --aoe循环
   local function aoe()
      if bn>0 then
         if tgaoe and isp("腐蚀之种",tgaoe)==1 and zhendang3() then
            cs("腐蚀之种",tgaoe) 
            return true      
         end 
      else
         if tg and isp("痛楚",tg)==1 and de(tg,S["痛楚"],"player")<=5.4 then
            cs("痛楚",tg)
            return true      
         end
         if tgtc and isp("痛楚",tgtc)==1 and de(tgtc,S["痛楚"],"player")<=5.4 and not gjfocus then
            cs("痛楚",tgtc)
            return true      
         end        
         if tg and getTalent(2,3) and isp("生命虹吸",tg)==1 and de(tg,S["生命虹吸"],"player")<=4.5 then
            cs("生命虹吸",tg)
            return true      
         end  
         if tg and cd(S["召唤黑眼"])<=0.2 and bn==0 and dec(tg,S["痛苦无常"] ,"player")>2 and baofa then
            rm("/cast 召唤黑眼")
         end        
         if tg and swzj() and isp("死亡之箭",tg)==1 and de(tg,S["痛楚"],"player")~= 0 and de(tg,S["腐蚀术de"],"player")~=0 then
            cs("死亡之箭",tg)
         end                        
         if tgsmhx and getTalent(2,3) and isp("生命虹吸",tgsmhx)==1 and de(tgsmhx,S["生命虹吸"],"player")<=4.5 and not gjfocus then
            cs("生命虹吸",tgsmhx)
            return true      
         end     
         if tg and getTalent(6,2) and isp("鬼影缠身",tg)==1 and cd(S["鬼影缠身"])<=0.2 and zhendang() then
            cs("鬼影缠身",tg)
            return true       
         end                                          
         if tg and getTalent(1,2) and isp("吸取灵魂",tg)==1 and UnitChannelInfo("player") ~= "吸取灵魂" and zhendang() then
            cs("吸取灵魂",tg)
            return true      
         end
         if tg and not getTalent(1,2) and isp("暗影箭",tg)==1 and canCast(S["暗影箭"],false,true) and UnitCastingInfo("player")==nil and cd(61304)<=0 and zhendang2() then
            cs("暗影箭",tg)
            return true      
         end  
      end                       
   end 
   ------------------------------------------------------------------------------------------------ ----------------------------------------------    
   --移动循环
   local function Sped()
      if tg and isp("痛楚",tg)==1 and de(tg,S["痛楚"],"player")<=5.4 then
         cs("痛楚",tg)
         return true      
      end
      if tgtc and isp("痛楚",tgtc)==1 and de(tgtc,S["痛楚"],"player")<=5.4 and not gjfocus then
         cs("痛楚",tgtc)
         return true      
      end    
      if tg and getTalent(4,2) and cd(S["诡异魅影"])<=0.2 and meiying == "自动卡CD" and getTimeToDie(tg)>8 then 
         cs("诡异魅影",tg)
         return true 
      end           
      if tg and isp("腐蚀术",tg)==1 and fss() and ((getTalent(2,2) and de(tg,S["腐蚀术de"],"player")==0) or (not getTalent(2,2) and de(tg,S["腐蚀术de"],"player")<=4.5)) then
         cs("腐蚀术",tg)
         return true      
      end
      if tg and getTalent(2,3) and isp("生命虹吸",tg)==1 and de(tg,S["生命虹吸"],"player")<=4.5 then
         cs("生命虹吸",tg)
         return true      
      end  
      if tg and cd(S["召唤黑眼"])<=0.2 and bn==0 and dec(tg,S["痛苦无常"] ,"player")>2 and baofa then
         rm("/cast 召唤黑眼")
      end                       
      if tgfss and isp("腐蚀术",tgfss)==1 and ((getTalent(2,2) and de(tgfss,S["腐蚀术de"],"player")==0) or (not getTalent(2,2) and de(tgfss,S["腐蚀术de"],"player")<=4.2)) and not gjfocus then
         cs("腐蚀术",tgfss)
         return true      
      end     
      if tgsmhx and getTalent(2,3) and isp("生命虹吸",tgsmhx)==1 and de(tgsmhx,S["生命虹吸"],"player")<=4.5 and not gjfocus then
         cs("生命虹吸",tgsmhx)
         return true      
      end      
      if tg and swzj() and isp("死亡之箭",tg)==1 and de(tg,S["痛楚"],"player")~= 0 and de(tg,S["腐蚀术de"],"player")~=0 then   
         cs("死亡之箭",tg)
         return true 
      end 
      if tg and isp("痛楚",tg)==1 and de(tg,S["痛楚"],"player")<=9 then
         cs("痛楚",tg)
         return true      
      end
      if tgtc and isp("痛楚",tgtc)==1 and de(tgtc,S["痛楚"],"player")<=9 and not gjfocus then
         cs("痛楚",tgtc)
         return true      
      end  
      if tgtc3 and isp("痛楚",tgtc3)==1 and de(tgtc3,S["痛楚"],"player")<=9 and not gjfocus then
         cs("痛楚",tgtc3)
         return true      
      end            
      if tg and isp("腐蚀术",tg)==1 and fss() and not getTalent(2,2) and de(tg,S["腐蚀术de"],"player")<=8 then
         cs("腐蚀术",tg)
         return true      
      end
      if tg and getTalent(2,3) and isp("生命虹吸",tg)==1 and de(tg,S["生命虹吸"],"player")<=8 then
         cs("生命虹吸",tg)
         return true      
      end                    
      if tgfss3 and isp("腐蚀术",tgfss3)==1 and not getTalent(2,2) and de(tgfss3,S["腐蚀术de"],"player")<=8 and not gjfocus then
         cs("腐蚀术",tgfss3)
         return true      
      end     
      if tgsmhx3 and getTalent(2,3) and isp("生命虹吸",tgsmhx3)==1 and de(tgsmhx3,S["生命虹吸"],"player")<8 and not gjfocus then
         cs("生命虹吸",tgsmhx3)
         return true      
      end                        
   end
   ------------------------------------------------------------------------------------------------ ---------------------------------------------- 
   local function bfa()     
      if tg and cd(S["召唤黑眼"])<=0.2 and (bn==0 or (bn==1 and UnitCastingInfo("player")=="痛苦无常")) and dec(tg,S["痛苦无常"] ,"player")>2 then
         rm("/cast 召唤黑眼")    
      end   
      if tg and getTalent(6,2) and isp("鬼影缠身",tg)==1 and cd(S["鬼影缠身"])<=0.2 and zhendang() then
         cs("鬼影缠身",tg)  
      end 
      if tg and isp("痛楚",tg)==1 and ((de(tg,S["痛楚"],"player")<6*getGCD() and bn>3) or de(tg,S["痛楚"],"player")<5.4) then  
         cs("痛楚",tg)  
      end   
      if tg and isp("腐蚀术",tg)==1 and fss() and getTalent(2,2) and de(tg,S["腐蚀术de"],"player")==0 then 
         cs("腐蚀术",tg)  
      end
      if tg and isp("腐蚀术",tg)==1 and fss() and not getTalent(2,2) and ((de(tg,S["腐蚀术de"],"player")<6*getGCD() and bn>3) or de(tg,S["腐蚀术de"],"player")<4.5) then 
         cs("腐蚀术",tg)  
      end      
      if tg and getTalent(2,3) and isp("生命虹吸",tg)==1 and ((de(tg,S["生命虹吸"],"player")<6*getGCD() and bn>3) or de(tg,S["生命虹吸"],"player")<4.5) then 
         cs("生命虹吸",tg)   
      end  
      if tg and getTalent(4,2) and cd(S["诡异魅影"])<=0.2 and meiying == "自动卡CD" and getTimeToDie(tg)>8 then 
         cs("诡异魅影",tg)
      end
      if tg and getTalent(4,3) and cd(S["邪恶污染"])<=0.2 and wuran == "自动卡CD" and bn>0 and zhendang() then
         castGround(tg,S["邪恶污染"],40,true) 
      end 
      ------------------------------------------------------------------------------------------------ ----------------------------------------------  
      if getTalent(7,3) and cd(S["黑暗灵魂"])<=0.2 and bn>=3 and (ainan== "绑定黑眼" or ainan== "二绑二卡") then 
         rm("/cast 黑暗灵魂：哀难") 
      end       
      if tg and isp("痛苦无常",tg)==1 and bn>0 and zhendang() then
         useTrinket() 
         rm("/cast 黑暗灵魂：哀难")
         cs("痛苦无常",tg)
         return true      
      end              
   end 
   ------------------------------------------------------------------------------------------------ ----------------------------------------------  
   if tg and UnitHealth(tg)>dotHP*50000 and bn>2 and cd(S["召唤黑眼"]) <=6*getGCD() and ((getTalent(1,3) and cd(S["死亡之箭"])<=7*getGCD()) or not getTalent(1,3)) then
      baofauto = true
   end 
   ------------------------------------------------------------------------------------------------ ----------------------------------------------   
   --宝宝攻击
   if tg and (UnitAffectingCombat(tg) or getHP(tg)<100) and UnitExists("pet") then
      PetAttack()
   end 
   ------------------------------------------------------------------------------------------------ ----------------------------------------------   
   if tg and UnitChannelInfo("player") ~= "吸取生命" and ((getHP("player")<30 and Group()<4) or IsLeftControlKeyDown()) and zhendang() then
      cs("吸取生命",tg)
      return true      
   end
   --诡异魅影 
   if tgaoe and tgaoen>2 and getTalent(4,2) and cd(S["诡异魅影"])<=0.2 and UnitHealth(tgaoe)>dotHP*30000 and (meiying == "自动卡CD" or meiying == "AOE") then 
      cs("诡异魅影",tgaoe)
      return true 
   end 
   --移动循环
   if Speed("player")>0 then
      Sped()
      self:rest();
      return true      
   end   
   ------------------------------------------------------------------------------------------------ ----------------------------------------------  
   if tgaoe and getTalent(4,3)  and cd(S["邪恶污染"])<=0.2 and bn>0 and ((wuran == "数量大于1" and tgaoen>1) or (wuran == "数量大于2" and tgaoen>2) or (wuran == "数量大于3" and tgaoen>3)) and zhendang() then
      castGround(tgaoe,S["邪恶污染"],40,true) 
      return true 
   end 
   ------------------------------------------------------------------------------------------------ ----------------------------------------------  
   --黑暗灵魂：哀难  
   if getTalent(7,3) and cd(S["黑暗灵魂"])<=0.2 and cd(S["召唤黑眼"])>45 and ainan == "二绑二卡" then
      rm("/cast 黑暗灵魂：哀难")
   end  
   ------------------------------------------------------------------------------------------------ ----------------------------------------------  
   --手动痛苦无常
   if tgwc and isp("痛苦无常",tgwc)==1 and dec(tgwc,S["痛苦无常"] ,"player")<5 and isKeyDown(qtk) and zhendang() then
      cs("痛苦无常",tgwc) 
      return true               
   end  
   --黑眼期间补痛苦无常
   if tg and isp("痛苦无常",tg)==1 and dec(tg,S["痛苦无常"] ,"player")<5 and cd(S["召唤黑眼"])>162 and baofauto ~= true and bn>0 then
      cs("痛苦无常",tg) 
      return true               
   end      
   if tg and getTalent(1,3) and isp("死亡之箭",tg)==1 and cd(S["召唤黑眼"])>165 and dec(tg,S["痛苦无常"] ,"player")>0 
   and getLastSpell() ~= S["痛苦无常"] and UnitCastingInfo("player")~="痛苦无常" then
      cs("死亡之箭",tg)
   end
   
   if baofauto == true and baofa == true then
      bfa() 
      self:rest();              
   end
   if tgaoe and ((zhongzi == "数量大于2" and tgaoen>2) or (zhongzi == "数量大于3" and tgaoen>3)) then
      --aoe循环
      aoe()
      self:rest();  
   else
      if tgaoenotfss and tgaoenotfssn>2 and isp("腐蚀之种",tgaoenotfss)==1 and UnitCastingInfo("player")~="腐蚀之种" and zhendang3() and fss() and zzfs then
         cs("腐蚀之种",tgaoenotfss) 
         return true      
      end     
      --痛苦无常 
      if tgwc and isp("痛苦无常",tgwc)==1 and bn==5 and UnitCastingInfo("player")~="痛苦无常" and zhendang() then 
         cs("痛苦无常",tgwc)             
         return true       
      end 
      --主循环
      if tg and getTalent(6,2) and cd(S["鬼影缠身"])<=0.2 and zhendang() then
         cs("鬼影缠身",tg)
         return true       
      end
     ------------------------------------------------------------------------------------------------ ----------------------------------------------                        
      --诡异魅影
      if tg and getTalent(4,2) and cd(S["诡异魅影"])<=0.2 and meiying == "自动卡CD" then 
         cs("诡异魅影",tg)
         return true 
      end 
      if tg and getTalent(4,3) and cd(S["邪恶污染"])<=0.2 and wuran == "自动卡CD" and bn>0 and zhendang() then
         castGround(tg,S["邪恶污染"],40,true) 
         return true 
      end          
      ------------------------------------------------------------------------------------------------ ----------------------------------------------                             
      --主目标3DOT            
      tgdot1()    
      ------------------------------------------------------------------------------------------------ ----------------------------------------------  
      if swzj() == true then
         tgdot2() 
         if tg and isp("死亡之箭",tg)==1 and dec(tg,S["痛苦无常"] ,"player")>0 and de(tg,S["痛楚"],"player")~= 0 and de(tg,S["腐蚀术de"],"player")~=0 
         and getLastSpell() ~= S["痛苦无常"] and UnitCastingInfo("player")~="痛苦无常" then
            cs("死亡之箭",tg)
         end      
      end              
      ------------------------------------------------------------------------------------------------ ----------------------------------------------                    
      --痛苦无常 
      if tgwc ~= nil and wckg() and bn>3 and isp("痛苦无常",tgwc)==1 and zhendang() then
         cs("痛苦无常",tgwc)           
         return true   
      end  
      if tgtc and (not tgtcs or (tgtcs and #tgtcs<3)) and isp("痛楚",tgtc)==1 and de(tgtc,S["痛楚"],"player")<=5.4 and not gjfocus then
         cs("痛楚",tgtc)
         return true      
      end  
      ------------------------------------------------------------------------------------------------ ----------------------------------------------
      --痛苦无常 
      if tgwc ~= nil and wckg() and bn>0 and isp("痛苦无常",tgwc)==1 and zhendang() then
         cs("痛苦无常",tgwc)           
         return true   
      end       
      ------------------------------------------------------------------------------------------------ ----------------------------------------------                                                           
      --副目标3DOT       
      if tgtc and isp("痛楚",tgtc)==1 and de(tgtc,S["痛楚"],"player")<=5.4 and not gjfocus then
         cs("痛楚",tgtc)
         return true      
      end  
      if tgfss and isp("腐蚀术",tgfss)==1 and fss() and ((getTalent(2,2) and de(tgfss,S["腐蚀术de"],"player")==0) or (not getTalent(2,2) and de(tgfss,S["腐蚀术de"],"player")<=4.5)) and not gjfocus then
         cs("腐蚀术",tgfss)
         return true      
      end     
      if tgsmhx and getTalent(2,3) and isp("生命虹吸",tgsmhx)==1 and de(tgsmhx,S["生命虹吸"],"player")<=4.5 and not gjfocus then
         cs("生命虹吸",tgsmhx)
         return true      
      end  
      ------------------------------------------------------------------------------------------------ ----------------------------------------------                                                            
      if UnitChannelInfo("player")~=nil or UnitCastingInfo("player")~=nil or bn==5 or cd(61304)>0 then        
         return true      
      end    
      if tg and getTalent(1,2) and UnitChannelInfo("player") ~= "吸取灵魂" and zhendang() then
         cs("吸取灵魂",tg)
         return true      
      end
      if tg and not getTalent(1,2) and isp("暗影箭",tg)==1 and canCast(S["暗影箭"],false,true) and UnitCastingInfo("player")==nil and zhendang2() then
         cs("暗影箭",tg)
         return true      
      end 
   end 
   self:rest();
end 
rotation_manager.instance:register(rotation);