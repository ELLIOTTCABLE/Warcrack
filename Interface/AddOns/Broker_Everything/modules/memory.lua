
----------------------------------
-- module independent variables --
----------------------------------
local addon, ns = ...
local C, L, I = ns.LC.color, ns.L, ns.I


-----------------------------------------------------------
-- module own local variables and local cached functions --
-----------------------------------------------------------
local name = "Memory" -- L["Memory"]
local ldbName = name
local tt
local ttName = name.."TT"
local GetNumAddOns,GetAddOnMemoryUsage,GetAddOnInfo = GetNumAddOns,GetAddOnMemoryUsage,GetAddOnInfo
local ttColumns = 3
local data = {}
local loginUpdateLock=true;

local addonpanels = {};
local addonpanels_select = {["none"]=L["None (disable right click)"]};
do
	if (ns.build>=60000000) then
		-- BetterAddonList
		addonpanels["Blizzard's Addons Panel"] = function(chk) if (chk) then return (_G.AddonList); end if (_G.AddonList:IsShown()) then _G.AddonList:Hide(); else _G.AddonList:Show(); end end;
		addonpanels_select["Blizzard's Addons Panel"] = "Blizzard's Addons Panel";
	end
	addonpanels["ACP"] = function(chk) if (chk) then return (IsAddOnLoaded("ACP")); end ACP:ToggleUI() end
	addonpanels["Ampere"] = function(chk) if (chk) then return (IsAddOnLoaded("Ampere")); end InterfaceOptionsFrame_OpenToCategory("Ampere"); InterfaceOptionsFrame_OpenToCategory("Ampere"); end
	addonpanels["OptionHouse"] = function(chk) if (chk) then return (IsAddOnLoaded("OptionHouse")); end OptionHouse:Open(1) end
	addonpanels["stAddonManager"] = function(chk) if (chk) then return (IsAddOnLoaded("stAddonManager")); end stAddonManager:LoadWindow() end
	local panelstates,d,s = {};
	local addonname,title,notes,loadable,reason,security,newVersion = 1,2,3,4,5,6,7;
	for i=1, GetNumAddOns() do
		d = {GetAddOnInfo(i)};
		s = (GetAddOnEnableState(ns.player.name,i)>0);
		--panelstates[d[addonname]] = nil -- nil = not present, false = present but not loaded yet, true = present and loaded
		if (addonpanels[d[addonname]]) and (s) then
			addonpanels_select[d[addonname]] = d[title];
		end
	end
end


-- ------------------------------------- --
-- register icon names and default files --
-- ------------------------------------- --
I[name] = {iconfile="Interface\\Addons\\"..addon.."\\media\\memory"}; --IconName::Memory--


---------------------------------------
-- module variables for registration --
---------------------------------------
local desc = L["Broker to show how much memory are consumed through your addons."]
ns.modules[name] = {
	desc = desc,
	events = {
		"PLAYER_ENTERING_WORLD"
	},
	updateinterval = 10,
	config_defaults = {
		mem_max_addons = -1,
		addonpanel = "none",
		updateInCombat = true
	},
	config_allowed = {
	},
	config = {
		{ type="header", label=L[name], align="left", icon=I[name] },
		{ type="separator" },
		{ type="slider", name="mem_max_addons", label=L["Show addons in tooltip"], tooltip=L["Select the maximum number of addons to display, otherwise drag to 'All'."],
			minText = L["All"],
			default = -1,
			min = -1,
			max = 100,
			format = "%d",
			rep = {[-1]=L["All"]}
		},
		{ type="select", name="addonpanel", label=L["Addon panel"], tooltip=L["Choose your addon panel that opens if you rightclick on memory broker or disable the right click option."], default = "none", values = addonpanels_select },
		{ type="toggle", name="updateInCombat", label=L["Update while in combat"], tooltip=L["The 'Script ran too long' error has multible factors. This module can produce this error if you have to much addons and you are in combat. Uncheck it to stop updating in combat."] },
	}
}


--------------------------
-- some local functions --
--------------------------
local function updateMemoryData(sumOnly)
	if (InCombatLockdown()==true) and (not Broker_EverythingDB[name].updateInCombat) then return false; end

	local total, all = 0, {}
	UpdateAddOnMemoryUsage()
	for i = 1, GetNumAddOns() do
		local u = GetAddOnMemoryUsage(i)
		total = total + u
		if not sumOnly then
			local n = select (1, GetAddOnInfo(i))
			all[i] = {name = n, mem = floor(u * 100) / 100}
		end
	end
	if (sumOnly) then
		data.total=total;
	else
		data = {total=total,all=all};
	end
	return true;
end


------------------------------------
-- module (BE internal) functions --
------------------------------------
ns.modules[name].init = function(self)
	ldbName = (Broker_EverythingDB.usePrefix and "BE.." or "")..name
	if (self) then
		ns.LDB:GetDataObjectByName(ldbName).text = L[name];
	end
end

ns.modules[name].onevent = function(self,event,msg)
	if (event=="PLAYER_ENTERING_WORLD") then
		C_Timer.After(15, function() loginUpdateLock=false; end); -- unlock updater 15 seconds after entering world.
	end
end

ns.modules[name].onupdate = function(self)
	if (loginUpdateLock) then return end

	updateMemoryData(true)

	local unit,total = "kb",data.total
	if (total > 1000) then
		total = total / 1000;
		unit = "mb";
	end

	local obj = self.obj or ns.LDB:GetDataObjectByName(ldbName)
	obj.text = string.format ("%.2f", total) .. ns.suffixColour(unit)
end

-- ns.modules[name].optionspanel = function(panel) end
-- ns.modules[name].onmousewheel = function(self,direction) end

ns.modules[name].ontooltip = function(tt)
	if (not tt.key) or tt.key~=ttName then return end -- don't override other LibQTip tooltips...

	local updated = updateMemoryData(false);
	local total, all, unit = data.total,data.all;
	local cnt = tonumber(Broker_EverythingDB[name].mem_max_addons)

	tt:Clear()

	if cnt > 0 then
		tt:AddHeader(string.format("%s ( %s %d )", C("dkyellow",L[name]), "Top", Broker_EverythingDB[name].mem_max_addons))
	else
		tt:AddHeader(C("dkyellow",L[name]))
		cnt = 1000
	end

	if (not updated) then
		local l,c = tt:AddLine();
		tt:SetCell(l, 1, C("orange",L["Update disabled while you are in combat"]),nil,"CENTER", 3);
		l,c = nil,nil;
		tt:AddSeparator();
	end

	table.sort(all, function (x, y) return x.mem > y.mem end)

	line, column = tt:AddLine()
	tt:SetCell(line,1,C("ltgreen",L["Addon"]),nil,nil,1)
	tt:SetCell(line,2,C("ltgreen",L["Memory Usage"]),nil,nil,2)
	tt:AddSeparator()
	for _, v in pairs (all) do
		if v.mem > 0 then
			unit = "kb"
			if v.mem > 1000 then
				v.mem = v.mem / 1000
				unit = "mb"
			end

			line, column = tt:AddLine()
			tt:SetCell(line,1,v.name,nil,nil,2)
			tt:SetCell(line,3,("%.2f %s"):format(v.mem,ns.suffixColour(unit)),nil,nil,1)
			cnt = cnt - 1

			if cnt == 0 then
				break
			end
		end
	end
	tt:AddSeparator()

	unit = "kb"
	if total > 1000 then
		total = total / 1000
		unit = "mb"
	end
	unit = ns.suffixColour(unit)

	line, column = tt:AddLine()
	tt:SetCell(line,1,L["Total Memory usage"]..":",nil,nil,2)
	tt:SetCell(line,3,("%.2f %s"):format(total, unit),nil,nil,1)

	if Broker_EverythingDB.showHints then
		tt:AddSeparator(2,0,0,0)

		line, column = tt:AddLine()
		tt:SetCell(line, 1, C("copper",L["Left-click"]).." || "..C("green",L["Open interface options"]),nil, nil, ttColumns)

		local ap = Broker_EverythingDB[name].addonpanel;
		if (ap) and (ap~="none") then
			if (addonpanels[ap]) and (addonpanels[ap](true)) then
				ap = addonpanels_select[ap];
			elseif (addonpanels["Blizzard's Addons Panel"]) and (addonpanels["Blizzard's Addons Panel"](true)) then
				ap = "Blizzard's Addons Panel";
			end
		else
			ap = false;
		end

		if (ap) then
			line, column = tt:AddLine()
			tt:SetCell(line, 1, C("copper",L["Right-click"]).." || "..C("green",ap), nil, nil, ttColumns)
		end

		line, column = tt:AddLine()
		tt:SetCell(line, 1, C("copper",L["Shift+Right-click"]).." || "..C("green",L["Collect garbage"]), nil, nil, ttColumns)
	end	
end


-------------------------------------------
-- module functions for LDB registration --
-------------------------------------------
ns.modules[name].onenter = function(self)
	if (ns.tooltipChkOnShowModifier(false)) then return; end

	tt = ns.LQT:Acquire(ttName, 3, "LEFT","RIGHT", "RIGHT")
	ns.modules[name].ontooltip(tt)
	ns.createTooltip(self,tt)
end

ns.modules[name].onleave = function(self)
	if (tt) then ns.hideTooltip(tt,ttName,false,true); end
end

ns.modules[name].onclick = function(self,button)
	local shift = IsShiftKeyDown()
	
	if button == "RightButton" and shift then
		print(L["Collecting Garbage..."])
		collectgarbage("collect")
	elseif button == "LeftButton" then
		InterfaceOptionsFrame_OpenToCategory(ns.be_option_panel);
		InterfaceOptionsFrame_OpenToCategory(ns.be_option_panel);
	elseif button == "RightButton" and not shift then
		local ap = Broker_EverythingDB[name].addonpanel;
		if (ap~="none") then
			if (ap~="Blizzard's Addons Panel") then
				if not IsAddOnLoaded(ap) then LoadAddOn(ap) end
			end
			if (addonpanels[ap]) and (addonpanels[ap](true)) then
				addonpanels[ap]();
			end
		end
	end
end

-- ns.modules[name].ondblclick = function(self,button) end

