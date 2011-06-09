--[[Consolid8, a World of Warcraft chat frame addon
	Copyright 2011 Harry Cutts

	This work by Harry Cutts is licensed under a
	Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
	To read this license, please see http://creativecommons.org/licenses/by-nc-sa/3.0/ .
]]--

--[[ Local variables ]]--
local addOnName, L = ...	-- Name and locale table

local frame
local originalHonor
local originalXP, originalXPMax,
	gainedXP	-- [XP] XP gained before the last level up
local data = {}
local specialData = {
	-- money	: money looted
	-- greyValue: value of looted poor quality items
}
Consolid8 = { data = data, specialData = specialData, }

local GetHonorCurrency = function() return select(2,GetCurrencyInfo(392)) or 0 end

--[[ Utility Functions ]]--
local print,CoppersToString,StringToCoppers,ChangeData,ChangeSpecialData,ConcatKeys,ConcatValues;do

function print(msg)
	return DEFAULT_CHAT_FRAME:AddMessage(format("|cFF0080FF%s:|r %s", addOnName, tostring(msg)))
end

function CoppersToString(copper)
	-- Returns: a formatted money string.
	local gold	 = math.floor(copper / 10000)
	copper		 = copper % 10000
	local silver = math.floor(copper / 100)
	copper		 = copper % 100
	return format(L["MONEY_FORMAT"], gold, silver, copper)
end

function StringToCoppers(str)
	-- Returns: the amount of money in str, in coppers.
	return (str:match(L["GOLD"]) or 0) * 10000 + (str:match(L["SILVER"]) or 0) * 100 + (str:match(L["COPPER"]) or 0)
end

function ChangeData(faction, change)
	data[faction] = (data[faction] or 0) + change
end

function ChangeSpecialData(key, change)
	specialData[key] = (specialData[key] or 0) + change
end

-- Thanks to Slakah of WoWInterface.com for these two functions
function ConcatKeys(tbl, key, ...)
	local newKey, newValue = next(tbl, key)
	if not newValue then return strjoin("\n", ...) end
	return ConcatKeys(tbl, newKey, newKey, ...)
end

function ConcatValues(tbl, key, ...)
	local newKey, newValue = next(tbl, key)
	if not newValue then return strjoin("\n", ...) end
	return ConcatValues(tbl, newKey, newValue, ...)
end

end

--[[ Chat Message Printing ]]--

-- These are arrays of chat frames which receive certain message types. Each also has a msgType value equal to the
-- message type that they receive. For example, lootCFs is populated with chat frames receiving LOOT messages, and
-- lootCFs.msg = "LOOT".
local lootCFs, skillCFs

local printing = false	-- true if ChatPrint is running; else false. Consolid8's filters return false when printing is true.
local lastLootCF		-- the last chat frame that receives LOOT messages.

local function UpdateCFArrays()
	-- [Printing] Adds all chat frames receiving LOOT messages to lootCFs and all receiving SKILL to skillCFs

	local function receives(msgType, ...)
		-- Returns: true if one of ... == "LOOT"; else false.
		for i = 1, select('#', ...) do
			if select(i, ...) == msgType then
				return true
			end
		end
		return false
	end

	lootCFs		= { msgType = "LOOT" }
	skillCFs	= { msgType = "SKILL" }
	for i = 1, NUM_CHAT_WINDOWS do
		if receives("LOOT", GetChatWindowMessages(i)) then
			lastLootCF = _G["ChatFrame"..i]
			tinsert(lootCFs, lastLootCF)
		end
		if receives("SKILL", GetChatWindowMessages(i)) then
			tinsert(skillCFs, _G["ChatFrame"..i])
		end
	end
end

local function ChatPrint(CFs, msg)
	-- [ Printing Core ] Sends CHAT_MSG_(CFs.msgType) events to all chat frames in CFs.
	printing = true
	local msgType = "CHAT_MSG_" .. CFs.msgType
	for i = 1, #CFs do
		ChatFrame_OnEvent(CFs[i], msgType, msg, "", "", "", "", "", "", "", "", "", "", "")
	end
	printing = false
end

--[[ Tradeskill handling ]]--
-- Note: loot message filtering for tradeskills is handled by LootFilter() in the Looting section

local craftingLink	-- Link to the item being crafted
local lastSkillMsg	-- The last skill message that was filtered by SkillFilter

local crafting		-- If player is crafting, the number of actions remaining; else nil.
local totalCrafted	-- The total number of items crafted

-- DoTradeSkill hook to detect start of crafting
local orig_DoTradeSkill = DoTradeSkill
DoTradeSkill = function(index, quantity, ...)
	local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo(index)
	if not crafting and Consolid8_Settings.skill and (altVerb == nil) then
		-- altVerb == nil: ensures that this is a "Create" skill (e.g. not "Enchant")
		craftingLink = GetTradeSkillItemLink(index)
		crafting = quantity
		totalCrafted = 0
	end
	orig_DoTradeSkill(index, quantity, ...)
end

local function ReportCrafting()
	-- Prints the final skill gain and loot messages to their proper chat frames.
	if totalCrafted and totalCrafted <= 0 then return end
	if lastSkillMsg then ChatPrint(skillCFs, lastSkillMsg) end
	ChatPrint(lootCFs, format(LOOT_ITEM_CREATED_SELF, format("%sx%s", craftingLink, totalCrafted)))
	craftingLink = nil
	lastSkillMsg = nil
	totalCrafted = nil
end

-- TODO: Stop this happening for enchanting
local function SkillFilter(chatFrame, event, msg)
	-- Returns: true (discard) if crafting and the message is a skill increase.
	if crafting and not printing and msg:match(L["SKILL_UP"]) then
		lastSkillMsg = msg
		return true
	end
end

-- Settings functions
local ToggleSkill; do

function ToggleSkill()
	return Consolid8.SetSkillSetting(not Consolid8_Settings.skill)
end

function Consolid8.SetSkillSetting(skill)
	Consolid8_Settings.skill = skill
	if skill then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SKILL", SkillFilter)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SKILL", SkillFilter)
	end
end

end

--[[ Looting ]]--

local looting = false		-- true if player is looting; a number if player is auto-looting; else false.
local lootString
local masterLooting = false	-- [Master Loot workaround] true if using Master Looter
local timeout				-- [Timeout] the time remaining until loot is reported, in seconds.

local function ReportLoot()
	if lootString then
		ChatPrint(lootCFs, format(LOOT_ITEM_SELF, lootString))
		lootString = nil
	end
	timeout = nil	-- [Timeout] Disable timer
end

local function NextItem()
	-- To be called whenever the autolooter moves on to the next item; e.g. item looted, inventory full error, money looted etc.
	-- Calls ReportLoot if the last item has been autolooted or LootFrame has closed.
	timeout = 10	-- [Timeout] Enable/reset timer

	if type(looting) == "number" then
		-- See whether this was the last item
		looting = looting - 1
		if looting == 0 then
			ReportLoot()
		end

	elseif not LootFrame:IsShown() then
		-- See if the loot frame has been closed
		ReportLoot()
	end
end

local function LogLoot(link, quantity)
	quantity = (quantity == "") and 1 or quantity
	local _,_, rarity, _,_,_,_,_,_,_, sellPrice = GetItemInfo(link)
	if masterLooting and rarity > GetLootThreshold() then
		ChatPrint(lootCFs, format(LOOT_ITEM_SELF, link))

	elseif rarity > ITEM_QUALITY_POOR then -- the item is not poor quality
		local msg = (quantity ~= 1) and format("%sx%s", link, quantity) or link
		lootString = ( lootString and (lootString .. ", " .. msg) ) or msg
	else
		ChangeSpecialData("greyValue", sellPrice * quantity)
	end
end

local function LootFilter(chatFrame, event, msg)	-- +[Tradeskill] Discard args 2-11
	-- Returns: true (discard) if (auto-)looting or crafting and msg matches pattern; else false.
	if printing then return false end

	local returnValue =
		looting and msg:match(L["LOOT"]) or msg:match(L["LOOT_OTHER"])
		or crafting and msg:match(L["CREATE"])

	-- Set looting/crafting to false if this message was trailing (and if this is the last CF to receive LOOT messages)
	-- A trailing message is one that comes after the loot frame has closed
	if chatFrame == lastLootCF then
		if looting == 0 or (type(looting) == "boolean" and not LootFrame:IsShown()) then
			looting = false
		end
		if crafting == 0 then
			crafting = false
		end
	end

	return returnValue
end

-- Settings functions
local ToggleLoot; do

function ToggleLoot()
	return Consolid8.SetLootSetting(not Consolid8_Settings.loot)
end

function Consolid8.SetLootSetting(loot)
	Consolid8_Settings.loot = loot
	if loot then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", LootFilter)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", LootFilter)
	end
end

end

--[[ XP ]]--

local function GetXP()
	return UnitXP("player") - originalXP + gainedXP
end

--[[ Public functions ]]--

function Consolid8.Reset()
	-- Clears all stored data.
	for key, value in pairs(data) do
		data[key] = nil
	end
	for key, value in pairs(specialData) do
		specialData[key] = nil
	end
	originalHonor	= GetHonorCurrency()
	originalXP		= UnitXP("player")
	print(RESET)
end

--[[ Event Handling ]]--

local inInstance = false			-- Instance tracking. Initialized on frame load.
local orig_ConfigOkayButton_OnClick	-- Stores original funcion for ChatConfigFrameOkayButton:GetScript("OnClick")

local eventHandlers; eventHandlers = {
	CHAT_MSG_COMBAT_FACTION_CHANGE = function(msg)	-- Reputation
		-- Attempt to match the increased pattern string
		local faction, change = msg:match(L["REP_INC"])

		if change then
			ChangeData(faction, change)
		else
			-- Attempt to match the decreased pattern string
			faction, change = msg:match(L["REP_DEC"])
			
			if change then ChangeData(faction, -change) end
		end
	end,

	--[[ Looting ]]--
	CHAT_MSG_MONEY = function(msg)					-- Money
		ChangeSpecialData("money", StringToCoppers(msg))
		NextItem()
	end,

	LOOT_OPENED = function(autolooting)				-- Start logging
		-- autolooting: 1 if autolooting, else 0 (NOT NIL!)
		if not Consolid8_Settings.loot then return end

		looting = (autolooting == 1) and GetNumLootItems() or true
	end,

	CHAT_MSG_LOOT = function(msg)					-- +[Tradeskill] Log message
		if crafting then
			local link, quantity = msg:match(L["CREATE"])
			crafting = crafting - 1
			totalCrafted = (totalCrafted or 0) + ((quantity == "") and 1 or quantity or 1)
			if crafting == 0 then
				ReportCrafting()
			end

		elseif looting and Consolid8_Settings.loot then
			local link, quantity = msg:match(L["LOOT"])
			if link then
				LogLoot(link, quantity)
				NextItem()
			end
		end
	end,

	UI_ERROR_MESSAGE = function(msg)				-- +[Tradeskill] Check for full inventory etc.
		if crafting and (msg == INTERRUPTED or msg == ERR_INV_FULL) then
			-- [Tradeskill] Register that crafting has been interrupted
			ReportCrafting()
		elseif msg == ERR_INV_FULL or msg == ERR_LOOT_CANT_LOOT_THAT or msg == ERR_LOOT_CANT_LOOT_THAT_NOW or msg == ERR_LOOT_ROLL_PENDING then
			NextItem()
		end
	end,

	PARTY_LOOT_METHOD_CHANGED = function()			-- [Master Loot workaround] set masterLooting
		masterLooting = (GetLootMethod() == "master")
	end,

	--[[ Tradeskill ]]--

	TRADE_SKILL_CLOSE = function()					-- Note that the crafting process will stop after the next action
		if crafting then
			crafting = 1
		end
	end,

	--[[ XP ]]--

	PLAYER_LEVEL_UP = function()					-- Update XP logging
		gainedXP		= gainedXP + originalXPMax - originalXP
		originalXP 		= 0
		originalXPMax 	= UnitXPMax("player")
	end,

	--[[ Other ]]--
	ADDON_LOADED = function(name)					-- Load saved variables (self-destructs)
		if name ~= addOnName then return end

		if not Consolid8_Settings then
			Consolid8_Settings = { loot = true, skill = true, visible = true, auto = true }
		end
		-- Check for upgrade
		local versionMeta = GetAddOnMetadata(addOnName, "Version")
		if Consolid8_Settings.version ~= versionMeta then
			Consolid8_Settings.version = versionMeta
			Consolid8_Settings.skill = true
		end

		if not Consolid8_Settings.visible then
			frame:Hide()
		end
		Consolid8.SetLootSetting(Consolid8_Settings.loot)
		Consolid8.SetSkillSetting(Consolid8_Settings.skill)

		-- Self-destruct
		frame:UnregisterEvent("ADDON_LOADED")
		eventHandlers.ADDON_LOADED = nil
	end,

	UPDATE_CHAT_WINDOWS = UpdateCFArrays,			-- Update lootCFs array

	PLAYER_ENTERING_WORLD = function()				-- Check for leaving an instance
		if IsInInstance() then
			inInstance = true
		else
			if Consolid8_Settings.auto and inInstance and not UnitIsDeadOrGhost("player") then
				Consolid8.Report()
			end
			inInstance = false
		end
	end,

	PLAYER_LOGIN = function()						-- Scale frame, initialize variables
		-- Set the scale to be the same as the other chat buttons, or to the user's setting
		frame:SetScale(Consolid8_Settings.scale or ChatFrameMenuButton:GetScale())

		originalHonor	= GetHonorCurrency()
		-- [XP] Record the starting XP
		originalXP		= UnitXP("player")
		originalXPMax	= UnitXPMax("player")
		gainedXP		= 0
	end,
}

function Consolid8.OnEvent(event, ...)
	local handler = eventHandlers[event]
	if handler then	return handler(...) end
end

function Consolid8.OnLoad()
	-- Initialize local and public variables
	frame = Consolid8_Frame
	Consolid8.frame = frame
	inInstance = IsInInstance()

	-- Hook ChatConfigFrameOkayButton's OnClick script
	orig_ConfigOkayButton_OnClick = ChatConfigFrameOkayButton:GetScript("OnClick")
	ChatConfigFrameOkayButton:SetScript("OnClick", function(...)
		orig_ConfigOkayButton_OnClick(...)
		UpdateCFArrays()
	end)

	-- [Looting][Timeout] Register OnUpdate function (not in XML for speed and local access)
	frame:SetScript("OnUpdate", function(self, elapsed)
		if timeout then
			timeout = timeout - elapsed
			if timeout <= 0 then
				ReportLoot()
			end
		end
	end)

	-- Register events
	for event in pairs(eventHandlers) do
		frame:RegisterEvent(event)
	end
end

do --[[ UI ]]--

-- Grey color
local r, g, b = GetItemQualityColor(0)
local GREY_TEXT = format("|cff%02x%02x%02x", r * 255, g * 255, b * 255 ) .. "%s|r"

-- Report dialog
StaticPopupDialogs.Consolid8 = {
	text		= "|cFF0080FF" .. addOnName .. ":|r " .. L["REPORT"] .. ":\n",
	button1		= RESET,	-- Accept button
	button2		= OKAY,		-- Cancel button

	OnShow = function(self)
		local namesStr, valuesStr = ConcatKeys(data, nil), ConcatValues(data, nil)

		-- Money, Honor, and XP
		if specialData.money then
			namesStr  = namesStr .. "\n" .. MONEY
			valuesStr = valuesStr .. "\n" .. CoppersToString(specialData.money)
		end
		if specialData.greyValue then
			namesStr  = namesStr .. "\n"
			valuesStr = valuesStr .. "\n" .. format(GREY_TEXT, CoppersToString(specialData.greyValue))
		end

		local honorGain = GetHonorCurrency() - originalHonor
		if honorGain ~= 0 then
			namesStr  = namesStr  .. "\n" .. HONOR
			valuesStr = valuesStr .. "\n" .. honorGain
		end

		local xpGain = GetXP()
		if xpGain ~= 0 then
			namesStr  = namesStr  .. "\n" .. COMBAT_XP_GAIN
			valuesStr = valuesStr .. "\n" .. xpGain
		end

		-- Custom popup frames
		local namesFS, valuesFS, autoCB
		if not self.namesFS then
			namesFS	 = self:CreateFontString(nil, "ARTWORK", "Consolid8NameStyle")
			namesFS:SetPoint("LEFT", self, "LEFT", 15, 0)
			self.namesFS = namesFS

			valuesFS = self:CreateFontString(nil, "ARTWORK", "Consolid8ValueStyle")
			valuesFS:SetPoint("RIGHT", self, "RIGHT", -15, 0)
			self.valuesFS = valuesFS

			autoCB 	 = CreateFrame("CheckButton", nil, self, "Consolid8_CBTemplate")
			autoCB:SetText(L["AUTO"])
			autoCB:SetPoint("BOTTOMLEFT", self.button1, "TOPLEFT", 0, 0)
			self.autoCB = autoCB
		else
			namesFS	 = self.namesFS
			valuesFS = self.valuesFS
			autoCB	 = self.autoCB
		end
		
		namesFS:SetText(namesStr)
		namesFS:SetWidth(namesFS:GetStringWidth())

		valuesFS:SetText(valuesStr)
		valuesFS:SetWidth(valuesFS:GetStringWidth())

		-- Automatic report checkbox
		autoCB:SetChecked(Consolid8_Settings.auto)
		autoCB:Show()

		self.height = self:GetHeight() + namesFS:GetStringHeight() + autoCB:GetHeight() + 10	-- Calculate the height
	end,

	OnUpdate = function(self)
		return self:SetHeight(self.height)	-- Set the previously calculated height
	end,

	OnAccept = Consolid8.Reset,

	OnHide = function(self)
		self.namesFS:Hide()
		self.valuesFS:Hide()
		self.autoCB:Hide()
		Consolid8.SetReportSetting(self.autoCB:GetChecked() and true or false)	-- Store a boolean, not 1/nil
	end,

	whileDead = 1, hideOnEscape = 1, notClosableByLogout = 1, timeout = 0,
}

-- Report settings
local function ToggleReport()
	return Consolid8.SetReportSetting(not Consolid8_Settings.auto)
end

function Consolid8.SetReportSetting(auto)
	Consolid8_Settings.auto = auto
end

function Consolid8.Report()
	return StaticPopup_Show("Consolid8")
end

-- Slash handler
SLASH_CONSOLID1 = "/"..addOnName
SlashCmdList["CONSOLID"] = function(msg)
	msg = string.lower(msg)
	if msg == string.lower(L["REPORT"]) then
		return Consolid8.Report()
	elseif msg == string.lower(RESET) then
		return Consolid8.Reset()
	elseif msg == string.lower(L["SHOW"]) then
		return Consolid8.Show()
	elseif msg == string.lower(L["HIDE"]) then
		return Consolid8.Hide()
	else
		return print(SLASH_CONSOLID1 .. format(" %s, %s, %s, %s", L["REPORT"], RESET, L["SHOW"], L["HIDE"]))
	end
end

-- Show/hide button
function Consolid8.Show()
	frame:Show()
	Consolid8_Settings.visible = true
end

function Consolid8.Hide()
	frame:Hide()
	Consolid8_Settings.visible = false
end

-- Tooltip
local tooltip;

function Consolid8.ShowTooltip()
	-- Create the tooltip if need be
	if not tooltip then
		tooltip = CreateFrame("GameTooltip", "Consolid8_Tooltip", UIParent, "GameTooltipTemplate")
		GameTooltip_SetDefaultAnchor(tooltip, UIParent)
	end

	tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
	tooltip:ClearLines()

	-- Header
	tooltip:AddLine(addOnName, 0, 0.5, 1)	-- Title line. Color the same as used in print method.
	tooltip:AddLine(" ")

	-- Faction changes
	tooltip:AddDoubleLine(FACTION, L["CHANGE"])	-- Column headers

	for key, value in pairs(data) do
		tooltip:AddDoubleLine(key, value, 0.5, 0.5, 1,	0.5, 0.5, 1)
	end

	tooltip:AddLine(" ")
	-- Money
	if specialData.money then
		tooltip:AddDoubleLine(MONEY, CoppersToString(specialData.money))
	end
	if specialData.greyValue then
		tooltip:AddDoubleLine(" ", format(GREY_TEXT, CoppersToString(specialData.greyValue)))
	end

	-- Honor, levels & XP
	local honorGain = GetHonorCurrency() - originalHonor
	if honorGain ~= 0 then
		tooltip:AddDoubleLine(HONOR, honorGain)
	end

	local xpGain = GetXP()
	if xpGain ~= 0 then
		tooltip:AddDoubleLine(COMBAT_XP_GAIN, xpGain)
	end

	return tooltip:Show()
end

function Consolid8.HideTooltip()
	return tooltip:Hide()
end

-- Menu
local menuList =
{
	{	--[[ Consolid8 ]]--
		text	= addOnName,
		isTitle = true,
	},
	{	-- Reset
		text 	= RESET,
		func 	= Consolid8.Reset,
	},
	{	-- Report
		text	= L["REPORT"],
		func	= Consolid8.Report,
	},
	{	--[ ] Loot
		text	= LOOT,
		update	= function(tbl)
			if Consolid8_Settings then tbl.checked = Consolid8_Settings.loot end
		end,
		func	= ToggleLoot,
	},
	{	--[ ] Loot
		text	= TRADESKILLS,
		update	= function(tbl)
			if Consolid8_Settings then tbl.checked = Consolid8_Settings.skill end
		end,
		func	= ToggleSkill,
	},
}

function Consolid8.MenuFunction()
	for key, value in pairs(menuList) do
		if value.update then value:update()	end
		UIDropDownMenu_AddButton(value)
	end
end

function Consolid8.ShowMenu()
	return ToggleDropDownMenu(1, nil, Consolid8_Menu, "cursor", 0, 0)
end

-- Broker Plugin
local dataObj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(addOnName,
	{
		type	= "data source",
		icon	= [[Interface\AddOns\Consolid8\Broker]],
		label	= addOnName,

		-- Scripts
		OnClick	= Consolid8.ShowMenu,
		OnEnter	= Consolid8.ShowTooltip,
		OnLeave	= Consolid8.HideTooltip,
	})
end