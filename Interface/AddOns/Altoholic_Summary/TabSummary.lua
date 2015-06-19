local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local parentName = "AltoholicTabSummary"
local parent

local OPTION_REALMS = "UI.Tabs.Summary.CurrentRealms"
local OPTION_FACTIONS = "UI.Tabs.Summary.CurrentFactions"
local OPTION_LEVELS = "UI.Tabs.Summary.CurrentLevels"
local OPTION_LEVELS_MIN = "UI.Tabs.Summary.CurrentLevelsMin"
local OPTION_LEVELS_MAX = "UI.Tabs.Summary.CurrentLevelsMax"
local OPTION_CLASSES = "UI.Tabs.Summary.CurrentClasses"
local OPTION_TRADESKILL = "UI.Tabs.Summary.CurrentTradeSkill"

local THISREALM_THISACCOUNT = 1
local THISREALM_ALLACCOUNTS = 2
local ALLREALMS_THISACCOUNT = 3
local ALLREALMS_ALLACCOUNTS = 4

-- local NUM_MENU_ITEMS = 6

addon.Tabs.Summary = {}

local ns = addon.Tabs.Summary		-- ns = namespace

local locationLabels = {
	[THISREALM_THISACCOUNT] = format("%s %s(%s)", L["This realm"], colors.green, L["This account"]),
	[THISREALM_ALLACCOUNTS] = format("%s %s(%s)", L["This realm"], colors.green, L["All accounts"]),
	[ALLREALMS_THISACCOUNT] = format("%s %s(%s)", L["All realms"], colors.green, L["This account"]),
	[ALLREALMS_ALLACCOUNTS] = format("%s %s(%s)", L["All realms"], colors.green, L["All accounts"]),
}

local function DropDownLocation_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = locationLabels[THISREALM_THISACCOUNT]
	info.value = THISREALM_THISACCOUNT
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = locationLabels[THISREALM_ALLACCOUNTS]
	info.value = THISREALM_ALLACCOUNTS
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = locationLabels[ALLREALMS_THISACCOUNT]
	info.value = ALLREALMS_THISACCOUNT
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	

	info.text = locationLabels[ALLREALMS_ALLACCOUNTS]
	info.value = ALLREALMS_ALLACCOUNTS
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
end

function ns:MenuItem_OnClick(id)
	addon.Summary:SetMode(id)
	addon.Summary:Update()
	
	-- for i=1, NUM_MENU_ITEMS do 
		-- AltoholicTabSummary["MenuItem"..i]:UnlockHighlight()
	-- end
	-- AltoholicTabSummary["MenuItem"..id]:LockHighlight()
end

function ns:AccountSharingButton_OnEnter(self)
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT")
	AltoTooltip:ClearLines()
	AltoTooltip:SetText(L["Account Sharing Request"])
	AltoTooltip:AddLine(L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"],1,1,1)
	AltoTooltip:Show()
end

function ns:AccountSharingButton_OnClick()
	if addon:GetOption("UI.AccountSharing.IsEnabled") == 0 then
		addon:Print(L["Both parties must enable account sharing\nbefore using this feature (see options)"])
		return
	end
	addon:ToggleUI()
	
	if AltoAccountSharing_SendButton.requestMode then
		addon.Comm.Sharing:SetMode(2)
	else
		addon.Comm.Sharing:SetMode(1)
	end
	AltoAccountSharing:Show()
end


-- ** Icon events **
local function OnRealmFilterChange(frame)
	addon:SetOption(OPTION_REALMS, frame.value)
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function OnFactionFilterChange(frame)
	addon:SetOption(OPTION_FACTIONS, frame.value)
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function OnLevelFilterChange(frame, minLevel, maxLevel)
	addon:SetOption(OPTION_LEVELS, frame.value)
	addon:SetOption(OPTION_LEVELS_MIN, minLevel)
	addon:SetOption(OPTION_LEVELS_MAX, maxLevel)
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function OnTradeSkillFilterChange(frame)
	addon:SetOption(OPTION_TRADESKILL, frame.value)
	parent.ContextualMenu:Close()
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function OnClassFilterChange(frame)
	addon:SetOption(OPTION_CLASSES, frame.value)
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function ShowOptionsCategory(self)
	addon:ToggleUI()
	InterfaceOptionsFrame_OpenToCategory(self.value)
end

local function ResetAllData_MsgBox_Handler(self, button)
	if not button then return end
	
	DataStore:ClearAllData()
	addon:Print(L["Information saved in DataStore has been completely deleted !"])
	
	-- rebuild the main character table, and all the menus
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function ResetAllData()
	-- reset all data stored in datastore modules
	addon:SetMsgBoxHandler(ResetAllData_MsgBox_Handler)
	
	AltoMsgBox_Text:SetText(L["WIPE_DATABASE"])
	AltoMsgBox:Show()
end

local function ResetConnectedRealms_MsgBox_Handler(self, button)
	if not button then return end
	
	DataStore:ClearAllConnectedRealms()
	addon:Print(L["Realm links successfully deleted"])
end

local function ResetConnectedRealms()
	-- reset connected realms, only the links between realms, not the data from other alts
	addon:SetMsgBoxHandler(ResetConnectedRealms_MsgBox_Handler)
	
	AltoMsgBox_Text:SetText(L["Reset connected realms ?"])
	AltoMsgBox:Show()
end


-- ** Menu Icons **
local function RealmsIcon_Initialize(frame, level)
	frame:AddTitle(L["FILTER_REALMS"])
	local option = addon:GetOption(OPTION_REALMS)

	-- add specific account/realm filters
	for key, text in ipairs(locationLabels) do
		frame:AddButton(text, key, OnRealmFilterChange, nil, (key == option))
	end
	frame:AddCloseMenu()
end

local function FactionIcon_Initialize(frame, level)
	local option = addon:GetOption(OPTION_FACTIONS)

	frame:AddTitle(L["FILTER_FACTIONS"])
	frame:AddButton(FACTION_ALLIANCE, 1, OnFactionFilterChange, nil, (option == 1))
	frame:AddButton(FACTION_HORDE, 2, OnFactionFilterChange, nil, (option == 2))
	frame:AddButton(L["Both factions"], 3, OnFactionFilterChange, nil, (option == 3))
	frame:AddCloseMenu()
end

local function LevelIcon_Initialize(frame, level)
	local option = addon:GetOption(OPTION_LEVELS)
	
	frame:AddTitle(L["FILTER_LEVELS"])
	frame:AddButtonWithArgs(ALL, 1, OnLevelFilterChange, 1, 100, (option == 1))
	frame:AddTitle()
	frame:AddButtonWithArgs("1-59", 2, OnLevelFilterChange, 1, 59, (option == 2))
	frame:AddButtonWithArgs("60-69", 3, OnLevelFilterChange, 60, 69, (option == 3))
	frame:AddButtonWithArgs("70-79", 4, OnLevelFilterChange, 70, 79, (option == 4))
	frame:AddButtonWithArgs("80-89", 5, OnLevelFilterChange, 80, 89, (option == 5))
	frame:AddButtonWithArgs("90-99", 6, OnLevelFilterChange, 90, 99, (option == 6))
	frame:AddButtonWithArgs("90-100", 7, OnLevelFilterChange, 90, 100, (option == 7))
	frame:AddButtonWithArgs("100", 8, OnLevelFilterChange, 100, 100, (option == 8))
	frame:AddCloseMenu()
end

local function ProfessionsIcon_Initialize(frame, level)
	if not level then return end

	local tradeskills = addon.TradeSkills.AccountSummaryFiltersSpellIDs
	local option = addon:GetOption(OPTION_TRADESKILL)
	
	if level == 1 then
		frame:AddTitle(L["FILTER_PROFESSIONS"])
		frame:AddButton(ALL, 0, OnTradeSkillFilterChange, nil, (option == 0))
		frame:AddTitle()
		frame:AddCategoryButton(PRIMARY_SKILLS, 1, level)
		frame:AddCategoryButton(SECONDARY_SKILLS, 2, level)
		frame:AddCloseMenu()
	
	elseif level == 2 then
		local spell, icon, _
		local firstSecondarySkill = addon.TradeSkills.AccountSummaryFirstSecondarySkillIndex
	
		if frame:GetCurrentOpenMenuValue() == 1 then				-- Primary professions
			for i = 1, (firstSecondarySkill - 1) do
				spell, _, icon = GetSpellInfo(tradeskills[i])
				frame:AddButton(spell, i, OnTradeSkillFilterChange, icon, (option == i), level)
			end
		
		elseif frame:GetCurrentOpenMenuValue() == 2 then		-- Secondary professions
			for i = firstSecondarySkill, #tradeskills do
				spell, _, icon = GetSpellInfo(tradeskills[i])
				
				frame:AddButton(spell, i, OnTradeSkillFilterChange, icon, (option == i), level)
			end
		end
	end
end

local function ClassIcon_Initialize(frame, level)
	local option = addon:GetOption(OPTION_CLASSES)
	
	frame:AddTitle(L["FILTER_CLASSES"])
	frame:AddButton(ALL, 0, OnClassFilterChange, nil, (option == 0))
	frame:AddTitle()
	
	-- See constants.lua
	for key, value in ipairs(CLASS_SORT_ORDER) do
		frame:AddButton(
			format("|c%s%s", RAID_CLASS_COLORS[value].colorStr, LOCALIZED_CLASS_NAMES_MALE[value]), 
			key, OnClassFilterChange, nil, (option == key)
		)
	end
	frame:AddCloseMenu()
end

local function AltoholicOptionsIcon_Initialize(frame, level)
	frame:AddTitle(format("%s: %s", GAMEOPTIONS_MENU, addonName))

	frame:AddButton(GENERAL, AltoholicGeneralOptions, ShowOptionsCategory)
	frame:AddButton(L["Calendar"], AltoholicCalendarOptions, ShowOptionsCategory)
	frame:AddButton(MAIL_LABEL, AltoholicMailOptions, ShowOptionsCategory)
	frame:AddButton(MISCELLANEOUS, AltoholicMiscOptions, ShowOptionsCategory)
	frame:AddButton(SEARCH, AltoholicSearchOptions, ShowOptionsCategory)
	frame:AddButton(L["Tooltip"], AltoholicTooltipOptions, ShowOptionsCategory)
	
	frame:AddTitle()
	frame:AddTitle(OTHER)	
	frame:AddButton("What's new?", AltoholicWhatsNew, ShowOptionsCategory)
	frame:AddButton("Getting support", AltoholicSupport, ShowOptionsCategory)
	frame:AddButton(L["Memory used"], AltoholicMemoryOptions, ShowOptionsCategory)
	frame:AddButton(HELP_LABEL, AltoholicHelp, ShowOptionsCategory)
	frame:AddCloseMenu()
end

local addonList = {
	"DataStore_Auctions",
	"DataStore_Characters",
	"DataStore_Garrisons",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Quests",
}

local function DataStoreOptionsIcon_Initialize(frame, level)
	frame:AddTitle(format("%s: %s", GAMEOPTIONS_MENU, "DataStore"))
	
	for _, module in ipairs(addonList) do
		if _G[module] then	-- only add loaded modules
			frame:AddButton(module, module, ShowOptionsCategory)
		end
	end
	
	frame:AddTitle()
	frame:AddButton(L["Reset all data"], nil, ResetAllData)
	frame:AddButton(L["Reset connected realms"], nil, ResetConnectedRealms)
	frame:AddButton(HELP_LABEL, DataStoreHelp, ShowOptionsCategory)
	frame:AddCloseMenu()
end


local menuIconCallbacks = {
	RealmsIcon_Initialize,
	FactionIcon_Initialize,
	LevelIcon_Initialize,
	ProfessionsIcon_Initialize,
	ClassIcon_Initialize,
	AltoholicOptionsIcon_Initialize,
	DataStoreOptionsIcon_Initialize,
}

function ns:Icon_OnEnter(frame)
	local currentMenuID = frame:GetID()
	
	local menu = frame:GetParent().ContextualMenu
	
	menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
	menu:Close()
	menu:Toggle(frame, 0, 0)
end

function ns:OnLoad()
	parent = _G[parentName]
	parent.MenuItem1:SetText(L["Account Summary"])
	parent.MenuItem2:SetText(L["Bag Usage"])
	parent.MenuItem3:SetText(SKILLS)
	parent.MenuItem4:SetText(L["Activity"])
	parent.MenuItem5:SetText(CURRENCY)
	parent.MenuItem6:SetText(GARRISON_FOLLOWERS_TITLE)
	parent.RequestSharing:SetText(L["Account Sharing"])
	
	parent.ClassIcon.Icon:SetTexture(addon:GetCharacterIcon())
end
