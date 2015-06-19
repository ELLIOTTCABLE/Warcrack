local _G = _G
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local Loremaster = Loremaster
local L = Loremaster.L
local icons = {}
local CreateFrame, ipairs, string, table, UIParent = CreateFrame, ipairs, string, table, UIParent

local function createMainPanel()
	local frame = CreateFrame("Frame", "LoremasterOptionsMain")
	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	local version = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	local author = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetFormattedText("|T%s:%d|t %s", "Interface\\ICONS\\INV_Misc_Book_07", 32, L["Loremaster"])
	title:SetPoint("CENTER", frame, "CENTER", 0, 170)	
	version:SetText(_G.GAME_VERSION_LABEL .. " " .. GetAddOnMetadata("Loremaster", "Version"))
	version:SetPoint("CENTER", frame, "CENTER", 0, 130)
	author:SetText(L["Author"] .. ": Deepac")
	author:SetPoint("CENTER", frame, "CENTER", 0, 100)
	return frame
end

local function qgivericons()
	if #icons > 0 then return icons end
	local base = "|TInterface\\MINIMAP\\TRACKING\\OBJECTICONS:16:16:0:-1:256:64:%d:%d:%d:%d|t %s %d"
	local index, c
	for index, c in ipairs(Loremaster.tcoords) do
		table.insert(icons, index, string.format(base, c[1], c[2], c[3], c[4], _G.EMBLEM_SYMBOL, index))
	end
	return icons
end

local checkPanel = {
	order = 1,
	type = "group",
	name = _G.MAIN_MENU,
	args = {
		hidecheck = {
			order = 1,
			type = "toggle",
			name = L["Hide completed achievements"],
			width = "full",
			get = function() return Loremaster.db.profile.hideach end,
			set = function(info, value) 
					Loremaster.db.profile.hideach = not Loremaster.db.profile.hideach 
					Loremaster:resetInterface()					
				end,
		},
		combat = {
			order = 2,
			type = "toggle",
			name = L["Hide in combat"],
			width = "full",
			get = function() return Loremaster.db.profile.hideincombat end,
			set = function(info, value) Loremaster.db.profile.hideincombat = not Loremaster.db.profile.hideincombat end,
		},
		iqg = {
			order = 3,
			type = "toggle",
			name = L["Show incomplete quests on map"],
			desc = L["Show the location of questgivers for incompleted quests on the map for the current zone"],
			width = "full",
			get = function() return Loremaster.db.profile.showinconmap end,
			set = function(info, value)
					Loremaster.db.profile.showinconmap = not Loremaster.db.profile.showinconmap
					if Loremaster.db.profile.showinconmap then
						Loremaster.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
						Loremaster:ShowZoneMarkers()
					else
						Loremaster.frame:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
						Loremaster:ClearMarker(nil, true)
					end
				end,
		},
		showMinimapIcon = {
			order = 3.5,
			type = "toggle",
			width = "full",
			name = L["Minimap Icon"],
			desc = L["Toggle Minimap icon"],
			get = function() return not Loremaster.db.profile.minimap.hide end,
			set = function(info, value)
				Loremaster.db.profile.minimap.hide = not value
				if value then Loremaster.icon:Show("Loremaster")
				else Loremaster.icon:Hide("Loremaster") end
			end,
		},
		icons = {
			order = 4,
			type = "select",
			name = function()
					local t = "%s |TInterface\\MINIMAP\\TRACKING\\OBJECTICONS:16:16:0:-1:256:64:%d:%d:%d:%d|t"
					local c = Loremaster.tcoords[Loremaster.db.profile.mapicon]
					return string.format(t, L["Questgiver icon"], c[1], c[2], c[3], c[4])
				end,
			width = "normal",
			hidden = function() return not Loremaster.db.profile.showinconmap end,
			values = qgivericons(),
			get = function() return Loremaster.db.profile.mapicon end,
			set = function(info, value)
					Loremaster.db.profile.mapicon = value
					if Loremaster.db.profile.showinconmap then
						Loremaster:UpdateMarkerTextures()
					end
				end,
		},
		attach = {
			order = 5,
			type = "toggle",
			name = L["Do not change Lightheaded's settings when Loremaster is not visible"],
			width = "full",
			visible = Loremaster.LH,
			get = function() return Loremaster.db.profile.attachLH end,
			set = function(info, value) Loremaster.db.profile.attachLH = not Loremaster.db.profile.attachLH end,
		},
		spacer1 = {
			order = 6,
			type = "description",
			name = "\n",
		},
		scale = {
			order = 7,
			type = 'range',
			name = _G.UI_SCALE,
			min = 0.25,
			max = 1.5,
			isPercent = true,
			step = 0.01,
			width = 'full',
			get = function() return Loremaster.db.profile.scale end,
			set = 
				function(info, value)
					Loremaster.db.profile.scale = value
					Loremaster.MainFrame:SetScale(value)
				end,
		},
		spacer2 = {
			order = 8,
			type = "description",
			name = "\n",
		},
--		rbutton = {
--			order = 9,
--			type = "execute",
--			name = L["Reset Loremaster"],
--			func = function() StaticPopup_Show("LOREMASTER_RESET") end,
--		},
	},
}

function Loremaster:profileReset()
	local f = Loremaster.MainFrame
	f:SetScale(self.db.profile.scale)
	f:ClearAllPoints()
	f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.profile["x"], self.db.profile["y"])
	if f:IsVisible() then
		f:Hide()
		f:Show()
	end
end

function Loremaster:createLoremasterOptions()
	local mainPanel = createMainPanel()
	mainPanel.name = L["Loremaster"]
	InterfaceOptions_AddCategory(mainPanel)
	self.db.RegisterCallback(self, "OnProfileReset", "profileReset")
	AceConfig:RegisterOptionsTable("LoremasterCheck", checkPanel)
	AceConfig:RegisterOptionsTable("LoremasterProfiles", AceDBOptions:GetOptionsTable(self.db))
	self.optionschecks = AceConfigDialog:AddToBlizOptions("LoremasterCheck", _G.MAIN_MENU, L["Loremaster"])
	self.optionschecks.default = function() self.db:ResetProfile() end
	AceConfigDialog:AddToBlizOptions("LoremasterProfiles", L["Profiles"], L["Loremaster"])
end