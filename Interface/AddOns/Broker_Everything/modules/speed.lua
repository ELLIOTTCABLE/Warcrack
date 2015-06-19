
----------------------------------
-- module independent variables --
----------------------------------
local addon, ns = ...
local C, L, I = ns.LC.color, ns.L, ns.I


-----------------------------------------------------------
-- module own local variables and local cached functions --
-----------------------------------------------------------
local name = "Speed" -- L["Speed"]
local ldbName, ttName = name, name.."TT"
local tt = nil
local string,GetUnitSpeed,UnitInVehicle = string,GetUnitSpeed,UnitInVehicle
local ttColumns = 2;
local riding_skills = { -- <spellid>, <skill>, <minLevel>, <speed increase>
	{90265, 300, 80, 310},
	{34091, 225, 70, 280},
	{34090, 150, 60, 150},
	{33391,  75, 40, 100},
	{33388,  50, 20, 60},
};
local licences = { -- <spellid>, <minLevel>, <mapIds>
	{90267,  60, {[4]=1,[9]=1,[11]=1,[13]=1,[14]=1,[16]=1,[17]=1,[19]=1,[20]=1,[21]=1,[22]=1,[23]=1,[24]=1,[26]=1,[27]=1,[28]=1,[29]=1,[30]=1,[32]=1,[34]=1,[35]=1,[36]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=1,[42]=1,[43]=1,[61]=1,[81]=1,[101]=1,[121]=1,[141]=1,[161]=1,[181]=1,[182]=1,[201]=1,[241]=1,[261]=1,[281]=1,[301]=1,[321]=1,[341]=1,[362]=1,[381]=1,[382]=1,[462]=1,[463]=1,[464]=1,[471]=1,[476]=1,[480]=1,[499]=1,[502]=1,[545]=1,[606]=1,[607]=1,[610]=1,[611]=1,[613]=1,[614]=1,[615]=1,[640]=1,[673]=1,[684]=1,[685]=1,[689]=1,[700]=1,[708]=1,[709]=1,[720]=1,[772]=1,[795]=1,[864]=1,[866]=1,[888]=1,[889]=1,[890]=1,[891]=1,[892]=1,[893]=1,[894]=1,[895]=1}},
	{54197,  68, {[485]=1,[486]=1,[510]=1,[504]=1,[488]=1,[490]=1,[491]=1,[541]=1,[492]=1,[493]=1,[495]=1,[501]=1,[496]=1}},
	{115913, 85, {[862]=1,[858]=1,[929]=1,[928]=1,[857]=1,[809]=1,[905]=1,[903]=1,[806]=1,[873]=1,[808]=1,[951]=1,[810]=1,[811]=1,[807]=1}}

}
local bonus_spells = {
	
}

-------------------------------------------
-- register icon names and default files --
-------------------------------------------
I[name] = {iconfile="Interface\\Icons\\Ability_Rogue_Sprint",coords={0.05,0.95,0.05,0.95}}; --IconName::Speed--


---------------------------------------
-- module variables for registration --
---------------------------------------
local desc = L["How fast are you swimming, walking, riding or flying."]
ns.modules[name] = {
	desc = desc,
	events = {},
	updateinterval = 0.1, -- false or integer
	config_defaults = {
		precision = 0
	},
	config_allowed = {
	},
	config = {
		{ type="header", label=L[name], align="left", icon=I[name] },
		{ type="separator" },
		{ type="slider", name="precision", label=L["Precision"], tooltip=L["Adjust the count of numbers behind the dot."], min = 0, max = 3, default = 0, format="%d" }
	}
}


--------------------------
-- some local functions --
--------------------------
local function createTooltip(tt)
	tt:Clear();

	tt:AddHeader(C("dkyellow",L[name]));
	tt:AddSeparator(4,0,0,0,0);

	tt:AddLine(C("ltblue",L["Riding skill"]));
	tt:AddSeparator();
	local learned = nil;
	for i,v in ipairs(riding_skills) do
		local Name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(v[1]);
		if(IsSpellKnown(v[1]))then
			learned = true;
		end
		if (learned==nil) then
			if(UnitLevel("player")>=v[3])then
				tt:AddLine(C("yellow",Name), "+"..v[4].."%");
			else
				tt:AddLine(C("red",Name), "+"..v[4].."%");
			end
		elseif(learned==true)then
			tt:AddLine(C("green",Name), "+"..v[4].."%");
			learned=false;
		elseif(learned==false)then
			tt:AddLine(C("dkgreen",Name), "+"..v[4].."%");
		end
	end

	tt:AddSeparator(4,0,0,0,0);
	tt:AddLine(C("ltblue",L["Flight licences"]));
	tt:AddSeparator();
	for i,v in ipairs(licences) do
		local Name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(v[1]);
		if(IsSpellKnown(v[1])) then
			tt:AddLine(C("green",Name));
		else
			tt:AddLine(C("red",Name));
		end
	end

	--[[
	tt:AddSeparator(4,0,0,0,0);
	tt:AddLine(C("ltblue",L["Speed bonus"]));
	tt:AddSeparator();
	-- by race
	-- by class
		-- hunter
		-- paladin
	-- by item
	]]
end

------------------------------------
-- module (BE internal) functions --
------------------------------------
ns.modules[name].init = function(obj)
	ldbName = (Broker_EverythingDB.usePrefix and "BE.." or "")..name
end

-- ns.modules[name].onevent = function(self,event,msg) end

ns.modules[name].onupdate = function(self)
	local obj = self.obj or ns.LDB:GetDataObjectByName(ldbName)

	local unit = "player"
	if UnitInVehicle("player") then unit = "vehicle" end

	local speed = ("%."..Broker_EverythingDB[name].precision.."f"):format(GetUnitSpeed(unit) / 7 * 100 ) .. "%"

	obj.text = speed
end

-- ns.modules[name].optionspanel = function(panel) end
-- ns.modules[name].onmousewheel = function(self,direction) end
-- ns.modules[name].ontooltip = function(tt) end


-------------------------------------------
-- module functions for LDB registration --
-------------------------------------------
ns.modules[name].onenter = function(self)
	tt = ns.LQT:Acquire(ttName, ttColumns, "LEFT","RIGHT", "RIGHT", "CENTER", "LEFT", "LEFT", "LEFT", "LEFT" );
	createTooltip(tt);
	ns.createTooltip(self,tt);
end -- tt prevention (currently not on all broker panels...)

ns.modules[name].onleave = function(self)
	if (tt) then ns.hideTooltip(tt,ttName,true); end
end

-- ns.modules[name].onclick = function(self,button)
	--if not PetJournalParent then PetJournal_LoadUI() end 
	--securecall("TogglePetJournal",1)
--end

-- ns.modules[name].ondblclick = function(self,button) end

