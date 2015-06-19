local _G = _G
local Loremaster = Loremaster
--local LoremasterMainFrame, LoremasterZoneFrame, LoremasterContinentFrame
local L = Loremaster.L
local GetCurrentMapZone = GetCurrentMapZone
local GetCurrentMapAreaID = GetCurrentMapAreaID
local mzones = {}
local ipairs, wipe, select = ipairs, wipe, select
local CreateFrame, UIParent, LibStub = CreateFrame, UIParent, LibStub
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton

local function createLDBMenu()
	local LDBMenu = CreateFrame("Frame", "LoremasterLDBMenu")
	
	LDBMenu.displayMode = "MENU"
	LDBMenu.info = {}
	LDBMenu.HideMenu = function() if UIDROPDOWNMENU_OPEN_MENU == LDBMenu then CloseDropDownMenus() end end
	LDBMenu.initialize = 
		function(self, level)
			if not level then return end
			local info = self.info
			local t = L["Loremaster"]
			wipe(info)

			if level == 1 then
				info.isTitle = 1
				info.text = t
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info, level)

				info.keepShownOnClick = 1
				info.disabled = nil
				info.isTitle = nil

				info.text = L["Show Loremaster"]
				info.func = function() self.HideMenu(); Loremaster.MainFrame:Show() end
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Hide Loremaster"]
				info.func = function() self.HideMenu(); Loremaster.MainFrame:Hide() end
				UIDropDownMenu_AddButton(info, level)

				info.text = _G.MAIN_MENU
				info.func = function() InterfaceOptionsFrame_OpenToCategory(_G.LoremasterOptionsMain) end
				UIDropDownMenu_AddButton(info, level)

				info.text = ""
				info.func = nil
				UIDropDownMenu_AddButton(info,level)

				info.text = L["Reset Loremaster"]
				info.func = function() self.HideMenu(); StaticPopup_Show("LOREMASTER_RESET") end
				UIDropDownMenu_AddButton(info, level)

				info.text = ""
				info.func = nil
				UIDropDownMenu_AddButton(info,level)

				-- Close menu item
				info.text = _G.CLOSE
				info.func = self.HideMenu
				UIDropDownMenu_AddButton(info, level)
			end
		end
end

local function LDBOnClick(self, button)
	if button == "LeftButton" then
		if Loremaster.MainFrame:IsVisible() then Loremaster.MainFrame:Hide()
		else Loremaster.MainFrame:Show() end
	else
		--drop down menu
		ToggleDropDownMenu(1, nil, LoremasterLDBMenu, self:GetName(), 0, 0)
	end
end

function Loremaster:questComplete()
	if self.qid then
--		self:removeQuest(self.qid)
		self.qid = nil
		self.rescan = true
	end
end

function Loremaster:achscan()
	local zid
	self:scanAchievements()
	if Loremaster.ContinentFrame.currentline then
		zid = Loremaster.ZoneFrame.currentline
		self:clickResponder(Loremaster.ContinentFrame.currentline)
	end
	Loremaster.ZoneFrame.currentline = zid
	if Loremaster.ZoneFrame.currentline then self:clickResponder(Loremaster.ZoneFrame.currentline) end
end

-- *** watch events ***
function Loremaster:eventHandler(this, event, arg1, ...)
	local zid, cmz, cmc, mid, r, c, e, i

	if event == "ADDON_LOADED" and arg1 == "Loremaster" then

		if LoremasterDB == nil then LoremasterDB = {} end
		--configure LDB
		createLDBMenu()
		ldblib = LibStub:GetLibrary("LibDataBroker-1.1")
		self.ldb = ldblib:NewDataObject(L["Loremaster"], {
			type = "data source", 
			text = L["Loremaster"],
			icon = "Interface\\ICONS\\INV_Misc_Book_07",
			OnClick = LDBOnClick			
		})

		function self.ldb.OnTooltipShow(tip)
			tip:AddLine(L["Loremaster"])
			tip:AddLine(" ")
			tip:AddLine("|cffffffff" .. _G.GAME_VERSION_LABEL .. " " .. GetAddOnMetadata("Loremaster", "Version"))
		end

		self.TT = IsAddOnLoaded("TomTom")
		self.LH = IsAddOnLoaded("LightHeaded")

		if self.TT then
			--code hijacked from TomTom
			local cidx, c, zidx, z
			self.zlist = {}
			if Grail.continentMapIds then
				for cidx, ccode in ipairs(Grail.continentMapIds) do
					for zindx, z in ipairs(Grail.continents[ccode].zones) do
						self.zlist[z.name:lower():gsub("[%L]", "")] = { cidx, zidx, z.name }
					end
				end
			else
				for cidx,c in ipairs{GetMapContinents()} do
					for zidx,z in ipairs{GetMapZones(cidx)} do self.zlist[z:lower():gsub("[%L]", "")] = {cidx, zidx, z} end
				end
			end
		end
		--Add a button to Blizzard's Quest Log Frame
		local blizzquestlogframebutton

		if Grail.blizzardRelease < 18505 then
			blizzquestlogframebutton = CreateFrame("Button", nil, QuestLogFrame, "UIPanelButtonTemplate")
			blizzquestlogframebutton:SetWidth(100)
			blizzquestlogframebutton:SetHeight(22)
			blizzquestlogframebutton:SetText(L["Loremaster"])
			blizzquestlogframebutton:SetPoint("LEFT", QuestLogControlPanel, "RIGHT", 0, 0)
		else
			blizzquestlogframebutton = CreateFrame("Button", nil, QuestScrollFrame.ViewAll, "UIPanelButtonTemplate")
			blizzquestlogframebutton:SetWidth(100)
			blizzquestlogframebutton:SetHeight(19)
			blizzquestlogframebutton:SetText(L["Loremaster"])
			blizzquestlogframebutton:SetPoint("BOTTOMLEFT", QuestScrollFrame.ViewAll, "TOPLEFT", 0, 12)
		end
		blizzquestlogframebutton:SetScript("OnClick", function() if Loremaster.MainFrame:IsVisible() then Loremaster.MainFrame:Hide(); else Loremaster.MainFrame:Show(); end end)
	elseif event == "PLAYER_LOGIN" then self.faction = UnitFactionGroup("player")
		if self.faction == "Alliance" then self.factiontexture = "Interface\\GROUPFRAME\\UI-Group-PVP-Alliance"
		else self.factiontexture = "Interface\\GROUPFRAME\\UI-Group-PVP-Horde" end

		--if (LoremasterDB.Achievements == nil) or self.rescan then self:scanAchievements() end
		self:scanAchievements()
--		r = select(2, UnitRace("player"))
--		c = select(2, UnitClass("player"))
--
--		for i, e in ipairs(self.Races) do
--			if e == r then
--				self.race = i
--				break
--			end
--		end
--
--		for i, e in ipairs(self.Classes) do if e == c then self.class = i end end
		--configure options
		self.defaults = {
			profile = {
			attachLH = true,
			hideach = false,
			hideincombat = true,
			x = (UIParent:GetWidth() - 600) / 2,
			y = (UIParent:GetHeight() - 382) / 2,
			scale = UIParent:GetScale(),
			showinconmap = true,
			mapicon = 10,
			minimap = {hide = false},
			},
		}

		self.db = LibStub("AceDB-3.0"):New("LoremasterVars", self.defaults, "profile")
		if self.db.profile.showinconmap then self.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA") end
		self:createLoremasterOptions()

		--create minimap button
		self.icon = LibStub("LibDBIcon-1.0")
		if self.icon then self.icon:Register("Loremaster", self.ldb, self.db.profile.minimap) end

		--create main frame
		self:CreateQuestFrame()
--		LoremasterMainFrame = _G.LoremasterMainFrame
--		LoremasterZoneFrame = _G.LoremasterZoneFrame
--		LoremasterContinentFrame = _G.LoremasterContinentFrame

		--	Moved these from ADDON_LOADED so the main frame, etc. exist first
		SLASH_LOREMASTER_CMD1 = "/" .. L["lm"]
		SLASH_LOREMASTER_CMD2 = "/" .. L["loremaster"]
		SlashCmdList["LOREMASTER_CMD"] = function(input) self:chatCommand(input) end

		--add map markers
		if self.db.profile.showinconmap then 
			self.tooltip = self.tooltip or CreateFrame("GameTooltip", "Loremaster_Tooltip", nil, "GameTooltipTemplate")
			self:ShowZoneMarkers() 
		end
	elseif event == "ACHIEVEMENT_EARNED" then
		self.rescan = true
		self:scanAchievements()
	elseif event == "QUEST_AUTOCOMPLETE" then
		self.qid = arg1
		self:questComplete()
	elseif event == "PLAYER_REGEN_DISABLED" then
		self.incombat = true
		if self.db.profile.hideincombat then if Loremaster.MainFrame:IsVisible() then Loremaster.MainFrame:Hide() end end
	elseif event == "PLAYER_REGEN_ENABLED" then
		self.incombat = nil
		if self.rescan then self:achscan() end
	elseif event == "CRITERIA_UPDATE" then if (not self.incombat) and Loremaster.MainFrame then self:achscan() end
	elseif event == "ZONE_CHANGED_NEW_AREA" then if self.db.profile.showinconmap then self:ShowZoneMarkers() end end
end