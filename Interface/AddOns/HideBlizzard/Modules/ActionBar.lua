local ActionBar = HideBlizzard:NewModule("ActionBar")

local db
local defaults = {
	profile = {
		["gryphons"] = nil,
		["hotkey"] = nil,
		["mainmenubar"] = nil,
		["multicastbar"] = nil,
		["repbar"] = nil,
		["stancebar"] = nil,
		["vehiclemenubar"] = nil,
		["vehicleseat"] = nil,
		["xpbar"] = nil,
	},
}

local options = nil
local function opt()
	if not options then
		options = {
			type = "group",
--			inline = true,
			name = "ActionBar",
			desc =  "ActionBar module hides frames connected to the main action bar at the bottom of the screen",
			arg = "ActionBar",
			get = function(info)
						local key = info[#info]
						return db[key]
					end,
			set = function(info, value)
						local key = info[#info]
						db[key] = value
						ActionBar:UpdateView()
					end,
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = "|cff00ff66Enable ActionBar|r",
--					descStyle = "inline",
--					desc = "ActionBar module hides frames connected to the main action bar at the bottom of the screen",
					width = "full",
					get = function() return HideBlizzard:GetModuleEnabled("ActionBar") end,
					set = function(info, value) HideBlizzard:SetModuleEnabled("ActionBar", value) end,
				},
				spacer = {
					type = "description",
					order = 1.5,
					name = "",
				},
				gryphons = {
					type = "toggle",
					order = 2,
					name = "Gryphons",
					desc = "Hides the art on the ends of the main action bar",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				hotkey = {
					type = "toggle",
					order = 3,
					name = "Hotkey",
					desc = "Hides the hotkey text on action buttons",
	--				width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				mainmenubar = {
					type = "toggle",
					order = 3,
					name = "Main Menu Bar",
					desc = "Hides the main action bar and the frames connected to it",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() end,
				},
				multicastbar = {
					type = "toggle",
					order = 4,
					name = "Multi Cast Bar",
					desc = "Hides the multi cast bar",
	--				width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				repbar = {
					type = "toggle",
					order = 5,
					name = "Rep Bar",
					desc = "Hides the reputation bar",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				stancebar = {
					type = "toggle",
					order = 6,
					name = "Stance Bar",
					desc = "Hides the stance/shapeshift bar",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				vehiclemenubar = {
					type = "toggle",
					order = 7,
					name = "Vehicle Menu Bar",
					desc = "Hides the vehicle menu bar",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				vehicleseat = {
					type = "toggle",
					order = 8,
					name = "Vehicle Seat",
					desc = "Hides the vehicle seat under the minimap",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
				xpbar = {
					type = "toggle",
					order = 9,
					name = "XP Bar",
					desc = "Hides the experience bar",
	--					width = "full",
					disabled = function() return not ActionBar:IsEnabled() or db.mainmenubar end,
				},
			},
		}
		return options
	end
end

function ActionBar:OnInitialize()
	self:SetEnabledState(HideBlizzard:GetModuleEnabled("ActionBar"))
	self.db = HideBlizzard.db:RegisterNamespace("ActionBar", defaults)
	db = self.db.profile

	HideBlizzard:RegisterModuleOptions("ActionBar", opt, "ActionBar")
end

function ActionBar:OnEnable()
	self:UpdateView()
end

function ActionBar:OnDisable()
	self:UpdateView()
end

function ActionBar:UpdateView()
	db = self.db.profile

	if db.gryphons == true then
		MainMenuBarLeftEndCap:Hide()
		MainMenuBarRightEndCap:Hide()
	else
		MainMenuBarLeftEndCap:Show()
		MainMenuBarRightEndCap:Show()
	end

	if db.hotkey == true then
		for i=1, NUM_ACTIONBAR_BUTTONS do
			-- Action Bar
			local hkab = _G["ActionButton"..i.."HotKey"]
			hkab:Hide()
			local hkbab = _G["BonusActionButton"..i.."HotKey"]
			hkbab:Hide()
			local hkmbl = _G["MultiBarBottomLeftButton"..i.."HotKey"]
			hkmbl:Hide()
			local hkmbr = _G["MultiBarBottomRightButton"..i.."HotKey"]
			hkmbr:Hide()
			-- Vehicle
			if (UnitInVehicle("player")) then
				local hkv = _G["VehicleMenuBarActionButton"..i.."HotKey"]
				hkv:Hide()
			end
		end
	else
		for i=1, NUM_ACTIONBAR_BUTTONS do
			-- Action Bar
			local hkab = _G["ActionButton"..i.."HotKey"]
			hkab:Show()
			local hkbab = _G["BonusActionButton"..i.."HotKey"]
			hkbab:Show()
			local hkmbl = _G["MultiBarBottomLeftButton"..i.."HotKey"]
			hkmbl:Show()
			local hkmbr = _G["MultiBarBottomRightButton"..i.."HotKey"]
			hkmbr:Show()
			-- Vehicle Bar
			if (UnitInVehicle("player")) then
				local hkv = _G["VehicleMenuBarActionButton"..i.."HotKey"]
				hkv:Show()
			end
		end
	end

	if db.mainmenubar == true then
		MainMenuBar:Hide()
		MainMenuBar:UnregisterAllEvents()
		MainMenuBar.Show = function() end
	else
		MainMenuBar.Show = nil
		MainMenuBar:Show()
		MainMenuBar:RegisterEvent("PLAYER_ENTERING_WORLD")
		MainMenuBar:RegisterEvent("BAG_UPDATE")
		MainMenuBar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
		MainMenuBar:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		MainMenuBar:RegisterEvent("ADDON_LOADED")
		MainMenuBar:RegisterEvent("UNIT_ENTERING_VEHICLE")
		MainMenuBar:RegisterEvent("UNIT_ENTERED_VEHICLE")
		MainMenuBar:RegisterEvent("UNIT_EXITING_VEHICLE")
		MainMenuBar:RegisterEvent("UNIT_EXITED_VEHICLE")
		MainMenuBar:RegisterEvent("UNIT_LEVEL")
	end

	if db.multicastbar == true then
		MultiCastActionBarFrame:Hide()
		MultiCastActionBarFrame:UnregisterAllEvents()
		MultiCastActionBarFrame.Show = function() end
	else
		MultiCastActionBarFrame.Show = nil
		MultiCastActionBarFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		MultiCastActionBarFrame:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
		MultiCastActionBarFrame_Update(MultiCastActionBarFrame)
	end

	if db.repbar == true then
		for factionIndex = 1, GetNumFactions() do
			local isWatched = GetFactionInfo(factionIndex)
			if isWatched then
				ReputationWatchBar:Hide()
				ReputationWatchBar.Show = function() end
				ReputationWatchBar_Update()
			else
				ReputationWatchBar:Hide()
				ReputationWatchBar.Show = function() end
				ReputationWatchBar_Update()
			end
		end
	else
		for factionIndex = 1, GetNumFactions() do
			local isWatched = GetFactionInfo(factionIndex)
			if isWatched then
				ReputationWatchBar.Show = nil
				ReputationWatchBar:Show()
				ReputationWatchBar_Update()
			else
				ReputationWatchBar:Hide()
				ReputationWatchBar.Show = function() end
				ReputationWatchBar_Update()
			end
		end
	end

	if db.stancebar == true then
		if(GetNumShapeshiftForms() ~= 0) then
			ShapeshiftBarFrame:Hide()
			ShapeshiftBarFrame.Show = function() end
		end
	else
		if(GetNumShapeshiftForms() ~= 0) then
			ShapeshiftBarFrame.Show = nil
			ShapeshiftBarFrame:Show()
		end
	end

	if db.vehiclemenubar == true then
		VehicleMenuBar:Hide()
		VehicleMenuBar:UnregisterAllEvents()
		VehicleMenuBar.Show = function() end
	else
		if UnitInVehicle("player") then
			VehicleMenuBar.Show = nil
			VehicleMenuBar:Show()
		end
		VehicleMenuBar:RegisterEvent("UNIT_ENTERING_VEHICLE")
		VehicleMenuBar:RegisterEvent("UNIT_ENTERED_VEHICLE")
		VehicleMenuBar:RegisterEvent("UNIT_EXITED_VEHICLE")
		VehicleMenuBar:RegisterEvent("UNIT_DISPLAYPOWER")
		VehicleMenuBar:RegisterEvent("VEHICLE_ANGLE_UPDATE")
		VehicleMenuBar:RegisterEvent("VEHICLE_PASSENGERS_CHANGED")
		VehicleMenuBar:RegisterEvent("PLAYER_GAINS_VEHICLE_DATA")
		VehicleMenuBar:RegisterEvent("PLAYER_LOSES_VEHICLE_DATA")
		VehicleMenuBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	end

	if db.vehicleseat == true then
		VehicleSeatIndicator:Hide()
		VehicleSeatIndicator:UnregisterAllEvents()
		VehicleSeatIndicator.Show = function() end
	else
		if UnitInVehicle("player") then
			VehicleSeatIndicator.Show = nil
			VehicleSeatIndicator:Show()
		end
		VehicleSeatIndicator:RegisterEvent("UNIT_ENTERING_VEHICLE")
		VehicleSeatIndicator:RegisterEvent("UNIT_ENTERED_VEHICLE")
		VehicleSeatIndicator:RegisterEvent("UNIT_EXITED_VEHICLE")
		VehicleSeatIndicator:RegisterEvent("UNIT_DISPLAYPOWER")
		VehicleSeatIndicator:RegisterEvent("VEHICLE_ANGLE_UPDATE")
		VehicleSeatIndicator:RegisterEvent("VEHICLE_PASSENGERS_CHANGED")
		VehicleSeatIndicator:RegisterEvent("PLAYER_GAINS_VEHICLE_DATA")
		VehicleSeatIndicator:RegisterEvent("PLAYER_LOSES_VEHICLE_DATA")
		VehicleSeatIndicator:RegisterEvent("PLAYER_ENTERING_WORLD")
	end

	if db.xpbar == true then
		MainMenuExpBar:Hide()
		MainMenuExpBar.Show = function() end
		MainMenuExpBar_Update()
	else
		MainMenuExpBar.Show = nil
		MainMenuExpBar:Show()
		MainMenuExpBar_Update()
	end
end
