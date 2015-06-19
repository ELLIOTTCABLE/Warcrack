local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local MODE_SUMMARY = 1
local MODE_BAGS = 2
local MODE_SKILLS = 3
local MODE_ACTIVITY = 4
local MODE_CURRENCIES = 5
local MODE_FOLLOWERS = 6

local SKILL_CAP = 700
local CURRENCY_ID_CONQUEST = 390
local CURRENCY_ID_HONOR = 392
local CURRENCY_ID_JUSTICE = 395
local CURRENCY_ID_VALOR = 396
local CURRENCY_ID_APEXIS = 823
local CURRENCY_ID_GARRISON = 824
local CURRENCY_ID_SOTF = 994		-- Seals of Tempered Fate (WoD)

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"

local VIEW_BAGS = 1
local VIEW_QUESTS = 2
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_MAILS = 7
local VIEW_MOUNTS = 8
local VIEW_COMPANIONS = 9
local VIEW_GARRISONS = 13

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

addon.Summary = {}

local ns = addon.Summary		-- ns = namespace

-- *** Utility functions ***
local function EmptyFunc()
end

local function EmptyString()
	return ""
end

local function GetRestedXP(character)
	local rate = DataStore:GetRestXPRate(character)

	local coeff = 1
	if addon:GetOption("UI.Tabs.Summary.ShowRestXP150pc") then
		coeff = 1.5
	end
	rate = rate * coeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	local color = colors.green
	if rate >= (100 * coeff) then 
		rate = 100 * coeff
	else
		if rate < (30 * coeff) then
			color = colors.red
		elseif rate < (60 * coeff) then
			color = colors.yellow
		end
	end

	return format("%s%d", color, rate).."%", rate
end

local function WriteLine(size, free, link, bagtype)
	AltoTooltip:AddLine(	format("%s |r%s (%s|r %s) %s %s",
		colors.gold..size, L["slots"], 
		colors.green..free, L["free"],
		link or "",
		(bagtype and strlen(bagtype) > 0) and (colors.yellow .. "(" .. bagtype .. ")") or "") ,1,1,1);
end

local skillColors = { colors.recipeGrey, colors.red, colors.orange, colors.yellow, colors.green }

local function GetSkillRankColor(rank, skillCap)
	skillCap = skillCap or SKILL_CAP
	return skillColors[ floor(rank / (skillCap/4)) + 1 ]
end

local function Tradeskill_OnEnter(frame, skillName, showRecipeStats)
	local character = frame:GetParent().character
	if not DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character) then return end
	
	local curRank, maxRank = DataStore:GetProfessionInfo(DataStore:GetProfession(character, skillName))
	local profession = DataStore:GetProfession(character, skillName)

	local tt = AltoTooltip
	
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_RIGHT")
	tt:AddLine(skillName,1,1,1)
	tt:AddLine(format("%s%s/%s", GetSkillRankColor(curRank), curRank, maxRank),1,1,1)
	
	if showRecipeStats then	-- for primary skills + cooking & first aid
		if DataStore:GetProfessionSpellID(skillName) ~= 2366 and skillName ~= GetSpellInfo(8613) then		-- no display for herbalism & skinning
			tt:AddLine(" ")
			
			if not profession then
				tt:AddLine(L["No data"])
				tt:Show()
				return
			end
		
			if DataStore:GetNumCraftLines(profession) == 0 then
				tt:AddLine(format("%s: 0 %s", L["No data"], TRADESKILL_SERVICE_LEARN),1,1,1)
			else
				local orange, yellow, green, grey = DataStore:GetNumRecipesByColor(profession)
				
				tt:AddLine(orange+yellow+green+grey .. " " .. TRADESKILL_SERVICE_LEARN,1,1,1)
				tt:AddLine(format("%s%d %s%s|r / %s%d %s%s|r / %s%d %s%s",
					colors.white, green, colors.recipeGreen, L["COLOR_GREEN"],
					colors.white, yellow, colors.yellow, L["COLOR_YELLOW"],
					colors.white, orange, colors.recipeOrange, L["COLOR_ORANGE"]))
			end
		end
	end
	
	tt:AddLine(" ")
	tt:AddLine(format("%s%s|r %s %s", colors.recipeGrey, L["COLOR_GREY"], L["up to"], (floor(SKILL_CAP*0.25)-1)),1,1,1)
	tt:AddLine(format("%s%s|r %s %s", colors.red, RED_GEM, L["up to"], (floor(SKILL_CAP*0.50)-1)),1,1,1)
	tt:AddLine(format("%s%s|r %s %s", colors.orange, L["COLOR_ORANGE"], L["up to"], (floor(SKILL_CAP*0.75)-1)),1,1,1)
	tt:AddLine(format("%s%s|r %s %s", colors.yellow, YELLOW_GEM, L["up to"], (SKILL_CAP-1)),1,1,1)
	tt:AddLine(format("%s%s|r %s %s %s", colors.green, L["COLOR_GREEN"], L["at"], SKILL_CAP, L["and above"]),1,1,1)

	local suggestion = addon:GetSuggestion(skillName, curRank)
	if suggestion then
		tt:AddLine(" ",1,1,1)
		tt:AddLine(format("%s: ", L["Suggestion"]),1,1,1)
		tt:AddLine(format("%s%s", colors.teal, suggestion),1,1,1)
	end
	
	-- parse profession cooldowns
	if profession then
		DataStore:ClearExpiredCooldowns(profession)
		local numCooldows = DataStore:GetNumActiveCooldowns(profession)
		
		if numCooldows == 0 then
			tt:AddLine(" ",1,1,1)
			tt:AddLine(L["All cooldowns are up"],1,1,1)
		else
			tt:AddLine(" ",1,1,1)
			for i = 1, numCooldows do
				local craftName, expiresIn = DataStore:GetCraftCooldownInfo(profession, i)
				tt:AddDoubleLine(craftName, addon:GetTimeString(expiresIn))
			end
		end
	end
	
	tt:Show()
end

local function Tradeskill_OnClick(frame, skillName)
	local character = frame:GetParent().character
	if not skillName or not DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character) then return end

	local profession = DataStore:GetProfession(character, skillName)
	if not profession or DataStore:GetNumCraftLines(profession) == 0 then		-- if profession hasn't been scanned (or scan failed), exit
		return
	end
	
	local charName, realm, account = strsplit(".", character)
	local chat = ChatEdit_GetLastActiveWindow()
	
	if chat:IsShown() and IsShiftKeyDown() and realm == GetRealmName() then
		-- if shift-click, then display the profession link and exit
		local link = profession.FullLink	
		if link and link:match("trade:") then
			chat:Insert(link);
		end
		return
	end

	addon.Tabs:OnClick("Characters")
	addon.Tabs.Characters:SetAltKey(character)
	addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
	addon.Tabs.Characters:SetCurrentProfession(skillName)
end

local Characters = addon.Characters

local function GetFactionTotals(f, line)
	local _, realm, account = Characters:GetInfo(line)
	
	local level = 0
	local money = 0
	local played = 0
	
	for _, character in pairs(DataStore:GetCharacters(realm, account)) do
		if DataStore:GetCharacterFaction(character) == f then
			level = level + DataStore:GetCharacterLevel(character)
			money = money + DataStore:GetMoney(character)
			played = played + DataStore:GetPlayTime(character)
		end
	end
	
	return level, money, played
end

local function ShowTotals(frame)
	local line = frame:GetParent():GetID()
	local tt = AltoTooltip
	
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_TOP")
	tt:AddLine(L["Totals"])
	
	local aLevels, aMoney, aPlayed = GetFactionTotals("Alliance", line)
	local hLevels, hMoney, hPlayed = GetFactionTotals("Horde", line)
	
	tt:AddLine(" ",1,1,1)
	tt:AddDoubleLine(colors.white..L["Levels"] , format("%s|r (%s %s|r, %s %s|r)", 
		Characters:GetField(line, "level"),
		addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), colors.white..aLevels,
		addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), colors.white..hLevels))
	
	tt:AddLine(" ",1,1,1)
	tt:AddDoubleLine(colors.white..MONEY, format("%s|r (%s %s|r, %s %s|r)", 
		addon:GetMoneyString(Characters:GetField(line, "money"), colors.white, true),
		addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), 
		addon:GetMoneyString(aMoney, colors.white, true),
		addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
		addon:GetMoneyString(hMoney, colors.white, true)))
	
	tt:AddLine(" ",1,1,1)
	tt:AddDoubleLine(colors.white..PLAYED , format("%s|r (%s %s|r, %s %s|r)",
		Characters:GetField(line, "played"),
		addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18),
		addon:GetTimeString(aPlayed),
		addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
		addon:GetTimeString(hPlayed)))
	
	tt:Show()
end

local function SortView(columnName)
	addon:SetOption("UI.Tabs.Summary.CurrentColumn", columnName)
	addon.Summary:Update()
end

local function GetColorFromAIL(level)
	if (level < 600) then return colors.grey end
	if (level <= 615) then return colors.green end
	if (level <= 630) then return colors.rare end
	return colors.epic
end


-- ** Right-Click Menu **
local function ViewAltInfo(self, characterInfoLine)
	addon.Tabs:OnClick("Characters")
	addon.Tabs.Characters:SetAlt(Characters:GetInfo(characterInfoLine))
	addon.Tabs.Characters:ViewCharInfo(self.value)
end

local function DeleteAlt_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end
	
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	DataStore:DeleteCharacter(name, realm, account)
	
	-- rebuild the main character table, and all the menus
	Characters:InvalidateView()
	addon.Summary:Update()
		
	addon:Print(format( L["Character %s successfully deleted"], name))
end

local function DeleteAlt(self, characterInfoLine)
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) and (name == UnitName("player")) then
		addon:Print(L["Cannot delete current character"])
		return
	end

	addon:SetMsgBoxHandler(DeleteAlt_MsgBox_Handler, characterInfoLine)
	
	AltoMsgBox_Text:SetText(L["Delete this Alt"] .. "?\n" .. name)
	AltoMsgBox:Show()
end

local function UpdateRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
	
	AltoAccountSharing_AccNameEditBox:SetText(account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	
	local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
	AltoAccountSharing_AccTargetEditBox:SetText(updatedWith)
	
	addon.Tabs.Summary:AccountSharingButton_OnClick()
end

local function DeleteRealm_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end

	local _, realm, account = Characters:GetInfo(characterInfoLine)
	DataStore:DeleteRealm(realm, account)

	-- if the realm being deleted was the current ..
	local tc = addon.Tabs.Characters
	if tc and tc:GetRealm() == realm and tc:GetAccount() == account then
		
		-- reset to this player
		local player = UnitName("player")
		local realmName = GetRealmName()
		addon.Tabs.Characters:SetAlt(player, realmName, THIS_ACCOUNT)
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
	
	-- rebuild the main character table, and all the menus
	Characters:InvalidateView()
	addon.Summary:Update()
		
	addon:Print(format( L["Realm %s successfully deleted"], realm))
end

local function DeleteRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
		
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) then
		addon:Print(L["Cannot delete current realm"])
		return
	end

	addon:SetMsgBoxHandler(DeleteRealm_MsgBox_Handler, characterInfoLine)
	AltoMsgBox_Text:SetText(L["Delete this Realm"] .. "?\n" .. realm)
	AltoMsgBox:Show()
end

local function NameRightClickMenu_Initialize(frame)
	local characterInfoLine = ns.CharInfoLine
	if not characterInfoLine then return end

	local lineType = Characters:GetLineType(characterInfoLine)
	if not lineType then return end

	if lineType == INFO_REALM_LINE then
		local _, realm, account = Characters:GetInfo(characterInfoLine)
		local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
		
		if updatedWith then
			frame:AddButtonWithArgs(format("Update from %s", colors.green..updatedWith), nil, UpdateRealm, characterInfoLine)
		end
		frame:AddButtonWithArgs(L["Delete this Realm"], nil, DeleteRealm, characterInfoLine)
		return
	end

	frame:AddTitle(DataStore:GetColoredCharacterName(Characters:Get(characterInfoLine).key))
	frame:AddTitle()
	frame:AddButtonWithArgs(L["View bags"], VIEW_BAGS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View mailbox"], VIEW_MAILS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View quest log"], VIEW_QUESTS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View auctions"], VIEW_AUCTIONS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View bids"], VIEW_BIDS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(COMPANIONS, VIEW_COMPANIONS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["Delete this Alt"], nil, DeleteAlt, characterInfoLine)
	frame:AddCloseMenu()
end

local function Name_OnClick(frame, button)
	local line = frame:GetParent():GetID()
	if line == 0 then return end

	local lineType = Characters:GetLineType(line)
	if lineType == INFO_TOTAL_LINE then
		return
	end
	
	if button == "RightButton" then
		ns.CharInfoLine = line	-- line containing info about the alt on which action should be taken (delete, ..)
		
		local scrollFrame = frame:GetParent():GetParent().ScrollFrame
		local menu = scrollFrame:GetParent():GetParent().ContextualMenu
		local offset = scrollFrame:GetOffset()
		
		menu:Initialize(NameRightClickMenu_Initialize, "LIST")
		menu:Close()
		menu:Toggle(frame, frame:GetWidth() - 20, 10)
			
		return
	elseif button == "LeftButton" and lineType == INFO_CHARACTER_LINE then
		addon.Tabs:OnClick("Characters")
		
		local tc = addon.Tabs.Characters
		tc:SetAlt(Characters:GetInfo(line))
		tc:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
end


-- *** Specific sort functions ***
local function GetCharacterLevel(self, character)
	local level = DataStore:GetCharacterLevel(character) or 0
	local rate = DataStore:GetXPRate(character) or 0

	return level + (rate / 100)
end

local function GetRarityLevel(self, character)
	local numEpic = DataStore:GetNumEpicFollowers(character) or 0
	local numRare = DataStore:GetNumRareFollowers(character) or 0
	
	return numEpic + (numRare / 100)
end

local function GetFollowersLevel615To630(self, character)
	local num615 = DataStore:GetNumFollowersAtiLevel615(character) or 0
	local num630 = DataStore:GetNumFollowersAtiLevel630(character) or 0
	
	return num630 + (num615 / 100)
end

local function GetFollowersLevel645To660(self, character)
	local num645 = DataStore:GetNumFollowersAtiLevel645(character) or 0
	local num660 = DataStore:GetNumFollowersAtiLevel660(character) or 0
	
	return num660 + (num645 / 100)
end

local function GetFollowersItemLevel(self, character)
	local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
	local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
	
	avgWeapon = math.floor(avgWeapon*10)	-- 615.17 becomes 6151
	avgArmor = math.floor(avgArmor*10)
	
	return avgWeapon + (avgArmor / 10000)
end


-- *** Column definitions ***
local columns = {}

-- ** Account Summary **
columns["Name"] = {
	-- Header
	HeaderWidth = 100,
	Header = NAME,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Name") end,
	HeaderSort = DataStore.GetCharacterName,
	
	-- Content
	Width = 150,
	JustifyH = "LEFT",
	GetText = function(character) 
			local name = DataStore:GetColoredCharacterName(character)
			local class = DataStore:GetCharacterClass(character)
			local icon = (DataStore:GetCharacterFaction(character) == "Alliance") and ICON_FACTION_ALLIANCE or ICON_FACTION_HORDE
			
			return format("%s %s (%s)", addon:TextureToFontstring(icon, 18, 18), name, class)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local tt = AltoTooltip
		
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), DataStore:GetColoredCharacterFaction(character))
			tt:AddLine(format("%s %s%s |r%s %s", L["Level"], 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)

			local zone, subZone = DataStore:GetLocation(character)
			tt:AddLine(format("%s: %s%s |r(%s%s|r)", L["Zone"], colors.gold, zone, colors.gold, subZone),1,1,1)
			
			local guildName = DataStore:GetGuildInfo(character)
			if guildName then
				tt:AddLine(format("%s: %s%s", GUILD, colors.green, guildName),1,1,1)
			end

			local suggestion = addon:GetSuggestion("Leveling", DataStore:GetCharacterLevel(character))
			if suggestion then
				tt:AddLine(" ",1,1,1)
				tt:AddLine(L["Suggested leveling zone: "],1,1,1)
				tt:AddLine(colors.teal .. suggestion,1,1,1)
			end

			-- parse saved instances
			local bLineBreak = true

			local dungeons = DataStore:GetSavedInstances(character)
			if dungeons then
				for key, _ in pairs(dungeons) do
					local hasExpired, expiresIn = DataStore:HasSavedInstanceExpired(character, key)
					
					if hasExpired then
						DataStore:DeleteSavedInstance(character, key)
					else
						if bLineBreak then
							tt:AddLine(" ",1,1,1)		-- add a line break only once
							bLineBreak = nil
						end
						
						local instanceName, instanceID = strsplit("|", key)
						tt:AddDoubleLine(format("%s (%sID: %s|r)", colors.gold..instanceName, colors.white, colors.green..instanceID), addon:GetTimeString(expiresIn))
					end
				end
			end

			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s%s", colors.green, L["Right-Click for options"]))
			tt:Show()
		end,
	OnClick = Name_OnClick,
	GetTotal = function(line) return format("  %s", L["Totals"]) end,
}

columns["Level"] = {
	-- Header
	HeaderWidth = 60,
	Header = LEVEL,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Level") end,
	HeaderSort = GetCharacterLevel,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetCharacterLevel(character)
		if level ~= MAX_PLAYER_LEVEL then
			local rate = DataStore:GetXPRate(character)
			level = format("%.1f", level + (rate/100))		-- show level as 98.4 if not level cap
		end
	
		return format("%s%s", colors.green, level)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(format("%s %s%s |r%s %s", L["Level"], 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)
			
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s %s%s%s/%s%s%s (%s%s%%%s)", EXPERIENCE_COLON,
				colors.green, DataStore:GetXP(character), colors.white,
				colors.green, DataStore:GetXPMax(character), colors.white,
				colors.green, DataStore:GetXPRate(character), colors.white),1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = function(line) return Characters:GetField(line, "level") end,
}

columns["RestXP"] = {
	-- Header
	HeaderWidth = 65,
	Header = TUTORIAL_TITLE26,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("RestXP") end,
	HeaderSort = DataStore.GetRestXPRate,
	
	-- Content
	Width = 65,
	JustifyH = "CENTER",
	GetText = function(character) 
		if DataStore:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
			return colors.white .. "0%"	-- show 0% at max level
		end

		return GetRestedXP(character)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end

			local restXP = DataStore:GetRestXP(character)
			if not restXP or restXP == 0 then return end

			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s%s", L["Rest XP"], colors.green, restXP),1,1,1)
			tt:Show()
		-- - Improve "rested xp"
			-- - tooltip : Fully rested in 4 days 12 hours (18 days if not left in an inn) on 29.05.09 4:00 pm
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["Money"] = {
	-- Header
	HeaderWidth = 115,
	Header = MONEY,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Money") end,
	HeaderSort = DataStore.GetMoney,
	
	-- Content
	Width = 110,
	JustifyH = "RIGHT",
	GetText = function(character) 
		return addon:GetMoneyString(DataStore:GetMoney(character))
	end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = function(line) return addon:GetMoneyString(Characters:GetField(line, "money"), colors.white) end,
}

columns["Played"] = {
	-- Header
	HeaderWidth = 100,
	Header = PLAYED,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Played") end,
	HeaderSort = DataStore.GetPlayTime,
	
	-- Content
	Width = 100,
	JustifyH = "RIGHT",
	GetText = function(character) 
		return addon:GetTimeString(DataStore:GetPlayTime(character))
	end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = function(line) return Characters:GetField(line, "played") end,
}

columns["AiL"] = {
	-- Header
	HeaderWidth = 55,
	Header = ITEM_LEVEL_ABBR,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("AiL") end,
	HeaderSort = DataStore.GetAverageItemLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local AiL = DataStore:GetAverageItemLevel(character) or 0
		return format("%s%.1f", colors.yellow, AiL)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(format("%s%s: %s%.1f",
				colors.white, L["Average Item Level"],
				colors.green, DataStore:GetAverageItemLevel(character)
			),1,1,1)

			addon:AiLTooltip()
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = function(line) return colors.white..format("%.1f", Characters:GetField(line, "realmAiL")) end,
}

columns["LastOnline"] = {
	-- Header
	HeaderWidth = 90,
	Header = LASTONLINE,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("LastOnline") end,
	HeaderSort = DataStore.GetLastLogout,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local account, realm, player = strsplit(".", character)
		
		if (player == UnitName("player")) and (realm == GetRealmName()) and (account == "Default") then
			return format("%s%s", colors.green, GUILD_ONLINE_LABEL)
		end
		
		return format("%s%s", colors.white, addon:FormatDelay(DataStore:GetLastLogout(character)))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local text
			local account, realm, player = strsplit(".", character)
			
			if (player == UnitName("player")) and (realm == GetRealmName()) and (account == "Default") then
				-- current player ? show ONLINE
				text = format("%s%s", colors.green, GUILD_ONLINE_LABEL)
			else
				-- other player, show real time since last online
				text = format("%s: %s", LASTONLINE, SecondsToTime(time() - DataStore:GetLastLogout(character)))
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			-- then - now = x seconds
			tt:AddLine(text,1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}


-- ** Bag Usage **
columns["BagSlots"] = {
	-- Header
	HeaderWidth = 100,
	Header = L["Bags"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("BagSlots") end,
	HeaderSort = DataStore.GetNumBagSlots,
	
	-- Content
	Width = 100,
	JustifyH = "LEFT",
	GetText = function(character)
				if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
					return UNKNOWN
				end
				
				return format("%s/%s|r/%s|r/%s|r/%s",
					DataStore:GetContainerSize(character, 0),
					DataStore:GetColoredContainerSize(character, 1),
					DataStore:GetColoredContainerSize(character, 2),
					DataStore:GetColoredContainerSize(character, 3),
					DataStore:GetColoredContainerSize(character, 4)
				)
			end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			
			local _, link, size, free, bagtype = DataStore:GetContainerInfo(character, 0)
			WriteLine(size, free, "[" .. BACKPACK_TOOLTIP .. "]")

			for i = 1, 4 do
				_, link, size, free, bagtype = DataStore:GetContainerInfo(character, i)
				WriteLine(size, free, link, bagtype)
			end
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = function(line) return format("%s%s |r%s", colors.white, Characters:GetField(line, "bagSlots"), L["slots"]) end,
	TotalJustifyH = "CENTER",
}

columns["FreeBagSlots"] = {
	-- Header
	HeaderWidth = 70,
	Header = L["free"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FreeBagSlots") end,
	HeaderSort = DataStore.GetNumFreeBagSlots,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numSlots = DataStore:GetNumBagSlots(character)
			local numFree = DataStore:GetNumFreeBagSlots(character)
			local color = ((numFree / numSlots) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, numSlots)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s%s |r (%s%s|r %s) ", SLOT_ABBR, 
				colors.cyan, DataStore:GetNumBagSlots(character), 
				colors.green, DataStore:GetNumFreeBagSlots(character), L["free"])
				,1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = function(line) return format("%s%s", colors.white, Characters:GetField(line, "freeBagSlots")) end,
}

columns["BankSlots"] = {
	-- Header
	HeaderWidth = 160,
	Header = L["Bank"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("BankSlots") end,
	HeaderSort = DataStore.GetNumBankSlots,
	
	-- Content
	Width = 160,
	JustifyH = "LEFT",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return UNKNOWN
			end

			if DataStore:GetNumBankSlots(character) == 0 then
				return L["Bank not visited yet"]
			end
			
			return format("%s/%s|r/%s|r/%s|r/%s|r/%s|r/%s|r/%s",
				DataStore:GetContainerSize(character, 100),
				DataStore:GetColoredContainerSize(character, 5),
				DataStore:GetColoredContainerSize(character, 6),
				DataStore:GetColoredContainerSize(character, 7),
				DataStore:GetColoredContainerSize(character, 8),
				DataStore:GetColoredContainerSize(character, 9),
				DataStore:GetColoredContainerSize(character, 10),
				DataStore:GetColoredContainerSize(character, 11)
			)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			
			if DataStore:GetNumBankSlots(character) == 0 then
				tt:AddLine(L["Bank not visited yet"],1,1,1)
				tt:Show()
				return
			end
			
			local _, link, size, free, bagtype = DataStore:GetContainerInfo(character, 100)
			WriteLine(size, free, "[" .. L["Bank"] .. "]")
				
			for i = 5, 11 do
				_, link, size, free, bagtype = DataStore:GetContainerInfo(character, i)
				WriteLine(size, free, link, bagtype)
			end
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = function(line) return format("%s%s |r%s", colors.white, Characters:GetField(line, "bankSlots"), L["slots"]) end,
	TotalJustifyH = "CENTER",
}

columns["FreeBankSlots"] = {
	-- Header
	HeaderWidth = 70,
	Header = L["free"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FreeBankSlots") end,
	HeaderSort = DataStore.GetNumFreeBankSlots,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numSlots = DataStore:GetNumBankSlots(character)
			local numFree = DataStore:GetNumFreeBankSlots(character)
			local color = ((numFree / numSlots) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, numSlots)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s%s |r (%s%s|r %s) ", SLOT_ABBR, 
				colors.cyan, DataStore:GetNumBankSlots(character),
				colors.green, DataStore:GetNumFreeBankSlots(character), L["free"])
				,1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = function(line) return format("%s%s", colors.white, Characters:GetField(line, "freeBankSlots")) end,
}

columns["FreeReagentBankSlots"] = {	-- TO DO 
	-- Header
	HeaderWidth = 50,
	Header = LASTONLINE,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function(frame) 
		-- SortView("FreeReagentBankSlots") 
	end,
	--HeaderSort = DataStore.xxx,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			-- TO DO : problem to workaround GetContainerNumFreeSlots returns 0 when the bag (-3) is scanned when not at the bank..
			
			return 0
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

-- ** Skills **
columns["Prof1"] = {
	-- Header
	HeaderWidth = 70,
	Header = L["Prof. 1"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Prof1") end,
	HeaderSort = DataStore.GetProfession1,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank, _, _, name = DataStore:GetProfession1(character)
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and addon:TextureToFontstring(addon:GetSpellIcon(spellID), 18, 18) .. " " or ""
			
			return format("%s%s%s", icon, GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession1(character)
			Tradeskill_OnEnter(frame, skillName, true)
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession1(character)
			Tradeskill_OnClick(frame, skillName)
		end,
	GetTotal = EmptyFunc,
}

columns["Prof2"] = {
	-- Header
	HeaderWidth = 70,
	Header = L["Prof. 2"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Prof2") end,
	HeaderSort = DataStore.GetProfession2,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank, _, _, name = DataStore:GetProfession2(character)
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and addon:TextureToFontstring(addon:GetSpellIcon(spellID), 18, 18) .. " " or ""
			
			return format("%s%s%s", icon, GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession2(character)
			Tradeskill_OnEnter(frame, skillName, true)
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession2(character)
			Tradeskill_OnClick(frame, skillName)
		end,
	GetTotal = EmptyFunc,
}

columns["ProfCooking"] = {
	-- Header
	HeaderWidth = 60,
	Header = "   " .. addon:TextureToFontstring(addon:GetSpellIcon(2550), 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("ProfCooking") end,
	HeaderSort = DataStore.GetCookingRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetCookingRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(2550), true)
		end,
	OnClick = function(frame, button)
			Tradeskill_OnClick(frame, GetSpellInfo(2550))
		end,
	GetTotal = EmptyFunc,
}

columns["ProfFirstAid"] = {
	-- Header
	HeaderWidth = 60,
	Header = "   " .. addon:TextureToFontstring(addon:GetSpellIcon(3273), 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("ProfFirstAid") end,
	HeaderSort = DataStore.GetFirstAidRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetFirstAidRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(3273), true)
		end,
	OnClick = function(frame, button)
			Tradeskill_OnClick(frame, GetSpellInfo(3273))
		end,
	GetTotal = EmptyFunc,
}

columns["ProfFishing"] = {
	-- Header
	HeaderWidth = 60,
	Header = "   " .. addon:TextureToFontstring(addon:GetSpellIcon(131474), 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("ProfFishing") end,
	HeaderSort = DataStore.GetFishingRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetFishingRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(131474))
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["ProfArchaeology"] = {
	-- Header
	HeaderWidth = 60,
	Header = "   " .. addon:TextureToFontstring(addon:GetSpellIcon(78670), 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("ProfArchaeology") end,
	HeaderSort = DataStore.GetArchaeologyRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetArchaeologyRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(78670))
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

-- ** Activity **
columns["Mails"] = {
	-- Header
	HeaderWidth = 60,
	Header = L["Mails"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Mails") end,
	HeaderSort = DataStore.GetNumMails,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local color = colors.grey
			local num = DataStore:GetNumMails(character) or 0

			if num ~= 0 then
				color = colors.green		-- green by default, red if at least one mail is about to expire
							
				local threshold = DataStore:GetOption("DataStore_Mails", "MailWarningThreshold")
				if DataStore:GetNumExpiredMails(character, threshold) > 0 then
					color = colors.red
				end
			end
			return format("%s%s", color, num)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumMails(character)
			if not num or num == 0 then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), format("%sMails found: %s%d", colors.white, colors.green, num))
			
			local numReturned, numDeleted, numExpired = 0, 0, 0
			local closestReturn
			local closestDelete
			
			for index = 1, num do
				local _, _, _, _, _, isReturned = DataStore:GetMailInfo(character, index)
				local _, seconds = DataStore:GetMailExpiry(character, index)
				
				if seconds < 0 then		-- mail has already expired
					if isReturned then	-- .. and it was a returned mail
						numExpired = numExpired + 1
					end
				else
					if isReturned then
						numDeleted = numDeleted + 1
						
						if not closestDelete then
							closestDelete = seconds
						else
							if seconds < closestDelete then
								closestDelete = seconds
							end
						end
					else
						numReturned = numReturned + 1
						
						if not closestReturn then
							closestReturn = seconds
						else
							if seconds < closestReturn then
								closestReturn = seconds
							end
						end
					end
				end
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%d %swill be returned upon expiry", colors.green, numReturned, colors.white))
			if closestReturn then
				tt:AddLine(format("%sClosest return in %s%s", colors.white, colors.green, SecondsToTime(closestReturn)))
			end
			
			if numDeleted > 0 then
				tt:AddLine(" ")
				tt:AddLine(format("%s%d %swill be %sdeleted%s upon expiry", colors.green, numDeleted, colors.white, colors.red, colors.white))
				if closestDelete then
					tt:AddLine(format("%sClosest deletion in %s%s", colors.white, colors.green, SecondsToTime(closestDelete)))
				end
			end
			
			if numExpired > 0 then
				tt:AddLine(" ")
				tt:AddLine(format("%s%d %shave expired !", colors.red, numExpired, colors.white))
			end
			
			tt:Show()
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end
	
			local num = DataStore:GetNumMails(character)
			if not num or num == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_MAILS)
		end,
	GetTotal = EmptyFunc,
}

columns["LastMailCheck"] = {
	-- Header
	HeaderWidth = 70,
	Header = L["Visited"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("LastMailCheck") end,
	HeaderSort = DataStore.GetMailboxLastVisit,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			return format("%s%s", colors.white, addon:FormatDelay(DataStore:GetMailboxLastVisit(character)))
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Mails", character) then
				return
			end
			
			local lastVisit = DataStore:GetMailboxLastVisit(character)
			if not lastVisit then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), MINIMAP_TRACKING_MAILBOX)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["Auctions"] = {
	-- Header
	HeaderWidth = 70,
	Header = AUCTIONS,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Auctions") end,
	HeaderSort = DataStore.GetNumAuctions,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num = DataStore:GetNumAuctions(character) or 0
			return format("%s%s", ((num == 0) and colors.grey or colors.green), num)
		end,
	OnEnter = EmptyFunc,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumAuctions(character)
			if not num or num == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_AUCTIONS)
		end,
	GetTotal = EmptyFunc,
}

columns["Bids"] = {
	-- Header
	HeaderWidth = 60,
	Header = BIDS,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("Bids") end,
	HeaderSort = DataStore.GetNumBids,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local num = DataStore:GetNumBids(character) or 0
			return format("%s%s", ((num == 0) and colors.grey or colors.green), num)
		end,
	OnEnter = EmptyFunc,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumBids(character)
			if not num or num == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_BIDS)
		end,

	GetTotal = EmptyFunc,
}

columns["AHLastVisit"] = {
	-- Header
	HeaderWidth = 70,
	Header = L["Visited"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("AHLastVisit") end,
	HeaderSort = DataStore.GetAuctionHouseLastVisit,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			return format("%s%s", colors.white, addon:FormatDelay(DataStore:GetAuctionHouseLastVisit(character)))
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Mails", character) then
				return
			end
			
			local lastVisit = DataStore:GetAuctionHouseLastVisit(character)
			if not lastVisit then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), BUTTON_LAG_AUCTIONHOUSE)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["MissionTableLastVisit"] = {
	-- Header
	HeaderWidth = 80,
	Header = GARRISON_MISSIONS,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("MissionTableLastVisit") end,
	HeaderSort = DataStore.GetMissionTableLastVisit,
	
	-- Content
	Width = 65,
	JustifyH = "RIGHT",
	GetText = function(character)
		local numAvail = DataStore:GetNumAvailableMissions(character) or 0
			local numActive = DataStore:GetNumActiveMissions(character) or 0
			local numCompleted = DataStore:GetNumCompletedMissions(character) or 0
			local text = ""
			
			if numCompleted > 0 then		-- add a '*' to show that there are some completed missions
				if numCompleted == numActive then
					text = format(" %s*", colors.red)	-- red if ALL active missions are complete
				else
					text = format(" %s*", colors.green)
				end
			elseif numActive == 0 and numAvail ~= 0 then
				text = format(" %s!", colors.red)	-- red '!' no mission is active !
			end
	
			return format("%s%s%s", colors.white, addon:FormatDelay(DataStore:GetMissionTableLastVisit(character)), text)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local lastVisit = DataStore:GetMissionTableLastVisit(character)
			if not lastVisit then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), GARRISON_MISSIONS_TITLE)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:AddLine(" ",1,1,1)
			
			local numAvail = DataStore:GetNumAvailableMissions(character) or 0
			local numActive = DataStore:GetNumActiveMissions(character) or 0
			local numCompleted = DataStore:GetNumCompletedMissions(character) or 0
			local color = colors.green
			
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.gold or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)
			
			tt:Show()
		end,
		
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_GARRISONS)
		end,
	GetTotal = EmptyFunc,
}


-- ** Currencies **
columns["CurrencyGarrison"] = {
	-- Header
	HeaderWidth = 80,
	Header = "   " .. addon:TextureToFontstring("Interface\\Icons\\inv_garrison_resource", 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("CurrencyGarrison") end,
	HeaderSort = DataStore.GetGarrisonResources,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local uncollected = DataStore:GetUncollectedResources(character) or 0
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_GARRISON) or 0
			local color = (amount == 0) and colors.grey or colors.white
			local colorUncollected
			
			if uncollected <= 300 then
				colorUncollected = colors.green
			elseif uncollected < 450 then
				colorUncollected = colors.yellow
			else
				colorUncollected = colors.red
			end

			return format("%s%s/%s+%s", color, amount, colorUncollected , uncollected)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_GARRISON) or 0
			local uncollected = DataStore:GetUncollectedResources(character) or 0
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Garrison resources"])
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s%s", L["Garrison resources"], colors.green, amount),1,1,1)
			tt:AddLine(format("%s: %s%s", L["Uncollected resources"], colors.green, uncollected),1,1,1)
			
			local lastVisit = DataStore:GetLastResourceCollectionTime(character)
			if lastVisit then
				tt:AddLine(format("%s: %s", L["Last collected"], SecondsToTime(time() - lastVisit)),1,1,1)
			end
			
			if uncollected < 500 then
				tt:AddLine(" ",1,1,1)
				
				-- (resources not yet obtained * 600 seconds)
				tt:AddLine(format("%s: %s", L["Max. uncollected resources in"], SecondsToTime((500 - uncollected) * 600)),1,1,1)
			end
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["CurrencyApexis"] = {
	-- Header
	HeaderWidth = 100,
	Header = "        " .. addon:TextureToFontstring("Interface\\Icons\\inv_apexis_draenor", 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("CurrencyApexis") end,
	HeaderSort = DataStore.GetApexisCrystals,
	
	-- Content
	Width = 100,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_APEXIS)
			local color = (amount == 0) and colors.grey or colors.white
				
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["CurrencySOTF"] = {
	-- Header
	HeaderWidth = 60,
	Header = "   " .. addon:TextureToFontstring("Interface\\Icons\\ability_animusorbs", 18, 18),
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("CurrencySOTF") end,
	HeaderSort = DataStore.GetSealsOfFate,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_SOTF)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["CurrencyHonor"] = {
	-- Header
	HeaderWidth = 80,
	Header = L["Honor"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("CurrencyHonor") end,
	HeaderSort = DataStore.GetHonorPoints,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_HONOR)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["CurrencyConquest"] = {
	-- Header
	HeaderWidth = 90,
	Header = L["Conquest"],
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("CurrencyConquest") end,
	HeaderSort = DataStore.GetConquestPoints,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local _, earnedThisWeek, weeklyMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_CONQUEST)
			local color = (earnedThisWeek == 0) and colors.grey or colors.white

			return format("%s%s%s/%s%s", color, earnedThisWeek, colors.white, colors.yellow, weeklyMax)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(
				DataStore:GetColoredCharacterName(character),
				DataStore:GetColoredCharacterFaction(character)
			)
			
			tt:AddLine(format("%s %s%s |r%s %s", L["Level"], colors.green, 
				DataStore:GetCharacterLevel(character), 
				DataStore:GetCharacterRace(character),	
				DataStore:GetCharacterClass(character))
			,1,1,1)

			local zone, subZone = DataStore:GetLocation(character)
			tt:AddLine(format("%s: %s%s |r(%s%s|r)", L["Zone"], colors.gold, zone, colors.gold, subZone),1,1,1)
			
			tt:AddLine(format("%s %s%s%s/%s%s%s (%s%s%%%s)", EXPERIENCE_COLON,
				colors.green, DataStore:GetXP(character), colors.white,
				colors.green, DataStore:GetXPMax(character), colors.white,
				colors.green, DataStore:GetXPRate(character), colors.white),1,1,1)
			
			local restXP = DataStore:GetRestXP(character)
			if restXP and restXP > 0 then
				tt:AddLine(format("%s: %s%s", L["Rest XP"], colors.green, restXP),1,1,1)
			end

			tt:AddLine(" ",1,1,1)
			tt:AddLine(colors.gold..CURRENCY..":",1,1,1)
			
			local num = DataStore:GetNumCurrencies(character) or 0
			for i = 1, num do
				local isHeader, name, count = DataStore:GetCurrencyInfo(character, i)
				name = name or ""
				
				if isHeader then
					tt:AddLine(colors.yellow..name)
				else
					tt:AddLine(format("  %s: %s%s", name, colors.green, count),1,1,1)
				end
			end
			
			if num == 0 then
				tt:AddLine(colors.white..NONE,1,1,1)
			end
			
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}


-- ** Garrison Followers **
columns["FollowersLV100"] = {
	-- Header
	HeaderWidth = 70,
	Header = "Lv 100",
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FollowersLV100") end,
	HeaderSort = DataStore.GetNumFollowersAtLevel100,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetNumFollowers(character) or 0
			local color = (amount == 0) and colors.grey or colors.white
			local amountLv100 = DataStore:GetNumFollowersAtLevel100(character) or 0
			
			return format("%s%s/%s", color, amountLv100, amount)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["FollowersEpic"] = {
	-- Header
	HeaderWidth = 55,
	-- Header = "Epic",
	Header = RARITY,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FollowersEpic") end,
	HeaderSort = GetRarityLevel,
	
	-- Content
	Width = 55,
	JustifyH = "CENTER",
	GetText = function(character)
			local numRare = DataStore:GetNumRareFollowers(character) or 0
			local colorRare = (numRare == 0) and colors.grey or colors.rare
			
			local numEpic = DataStore:GetNumEpicFollowers(character) or 0
			local colorEpic = (numEpic == 0) and colors.grey or colors.epic
			
			return format("%s%s%s/%s%s", colorRare, numRare, colors.white, colorEpic, numEpic)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["FollowersLV630"] = {
	-- Header
	HeaderWidth = 70,
	Header = "615/630",
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FollowersLV630") end,
	HeaderSort = GetFollowersLevel615To630,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num615 = DataStore:GetNumFollowersAtiLevel615(character) or 0
			local color615 = (num615 == 0) and colors.grey or colors.green
			local num630 = DataStore:GetNumFollowersAtiLevel630(character) or 0
			local color630 = (num630 == 0) and colors.grey or colors.rare
			
			return format("%s%s%s/%s%s", color615, num615, colors.white, color630, num630)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["FollowersLV660"] = {
	-- Header
	HeaderWidth = 70,
	Header = "645/660",
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FollowersLV660") end,
	HeaderSort = GetFollowersLevel645To660,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num645 = DataStore:GetNumFollowersAtiLevel645(character) or 0
			local color645 = (num645 == 0) and colors.grey or colors.epic
			local num660 = DataStore:GetNumFollowersAtiLevel660(character) or 0
			local color660 = (num660 == 0) and colors.grey or colors.epic
			
			return format("%s%s%s/%s%s", color645, num645, colors.white, color660, num660)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["FollowersLV675"] = {
	-- Header
	HeaderWidth = 50,
	Header = "675",
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FollowersLV675") end,
	HeaderSort = DataStore.GetNumFollowersAtiLevel675,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetNumFollowersAtiLevel675(character) or 0
			local color = (amount == 0) and colors.grey or colors.epic
			
			return format("%s%s", color, amount)
		end,
	OnEnter = EmptyFunc,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

columns["FollowersItems"] = {
	-- Header
	HeaderWidth = 75,
	Header = ITEM_LEVEL_ABBR,
	GetHeaderTooltip = EmptyFunc,
	HeaderOnEnter = EmptyFunc,
	HeaderOnLeave = EmptyFunc,
	HeaderOnClick = function() SortView("FollowersItems") end,
	HeaderSort = GetFollowersItemLevel,
	
	-- Content
	Width = 75,
	JustifyH = "CENTER",
	GetText = function(character)
			local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
			local colorW = GetColorFromAIL(avgWeapon)
			
			local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
			local colorA = GetColorFromAIL(avgArmor)
			
			return format("%s%.1f%s/%s%.1f", colorW, avgWeapon, colors.white, colorA, avgArmor)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
			local colorW = GetColorFromAIL(avgWeapon)
			local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
			local colorA = GetColorFromAIL(avgArmor)
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ",1,1,1)
			tt:AddLine(format("%s: %s%.1f", WEAPON, colorW, avgWeapon),1,1,1)
			tt:AddLine(format("%s: %s%.1f", ARMOR, colorA, avgArmor),1,1,1)
			tt:Show()
		end,
	OnClick = EmptyFunc,
	GetTotal = EmptyFunc,
}

local function SetButtonData(frame, character, columnName)
	local obj = columns[columnName]
	
	-- Set basic properties
	frame:SetWidth(obj.Width)
	frame.Text:SetWidth(obj.Width)
	frame.Text:SetJustifyH(obj.JustifyH)
	frame.Text:SetText(obj.GetText(character))
	frame:Show()

	-- Set Scripts
	frame:SetScript("OnEnter", obj.OnEnter)
	frame:SetScript("OnClick", obj.OnClick)
end

local function SetTotalButtonData(frame, line, columnName)
	local obj = columns[columnName]
	
	-- Set basic properties
	frame:SetWidth(obj.Width)
	frame.Text:SetWidth(obj.Width)
	
	if obj.TotalJustifyH then
		frame.Text:SetJustifyH(obj.TotalJustifyH)
	else
		frame.Text:SetJustifyH(obj.JustifyH)
	end
	

	if obj.GetTotal ~= EmptyFunc then
		frame.Text:SetText(obj.GetTotal(line))
		frame:Show()
	else
		frame:Hide()
	end

	-- Set Scripts
	frame:SetScript("OnEnter", EmptyFunc)
	frame:SetScript("OnClick", EmptyFunc)
end

local modes = {
	[MODE_SUMMARY] = { "Name", "Level", "RestXP", "Money", "Played", "AiL", "LastOnline" },
	[MODE_BAGS] = { "Name", "Level", "BagSlots", "FreeBagSlots", "BankSlots", "FreeBankSlots" },
	[MODE_SKILLS] = { "Name", "Level", "Prof1", "Prof2", "ProfCooking", "ProfFirstAid", "ProfFishing", "ProfArchaeology" },
	[MODE_ACTIVITY] = { "Name", "Level", "Mails", "LastMailCheck", "Auctions", "Bids", "AHLastVisit", "MissionTableLastVisit" },
	[MODE_CURRENCIES] = { "Name", "Level", "CurrencyGarrison", "CurrencyApexis", "CurrencySOTF", "CurrencyHonor", "CurrencyConquest" },
	[MODE_FOLLOWERS] = { "Name", "Level", "FollowersLV100", "FollowersEpic", "FollowersLV630", "FollowersLV660", "FollowersLV675", "FollowersItems" },
}

function ns:SetMode(mode)
	addon:SetOption("UI.Tabs.Summary.CurrentMode", mode)
	
	local parent = AltoholicTabSummary
	
	-- add the appropriate columns for this mode
	for i = 1, #modes[mode] do
		local columnName = modes[mode][i]
		local column = columns[columnName]
		
		parent.SortButtons:SetButton(i, column.Header, column.HeaderWidth, column.HeaderOnClick)
	end
end

function ns:Update()
	
	local frame = AltoholicFrameSummary
	local scrollFrame = frame.ScrollFrame
	local numRows = scrollFrame.numRows
	local offset = scrollFrame:GetOffset()

	local isRealmShown
	local numVisibleRows = 0
	local numDisplayedRows = 0

	local sortOrder = addon:GetOption("UI.Tabs.Summary.SortAscending")
	local currentColumn = addon:GetOption("UI.Tabs.Summary.CurrentColumn")
	local currentModeIndex = addon:GetOption("UI.Tabs.Summary.CurrentMode")
	local currentMode = modes[currentModeIndex]
	
	-- rebuild and get the view, then sort it
	Characters:InvalidateView()
	local view = Characters:GetView()
	if columns[currentColumn] then	-- an old column name might still be in the DB.
		Characters:Sort(sortOrder, columns[currentColumn].HeaderSort)
	end

	-- attempt to restore the arrow to the right sort button
	local container = AltoholicTabSummary.SortButtons
	for i = 0, #currentMode do
		if currentMode[i] == currentColumn then
			container["Sort"..i].Arrow:Draw(sortOrder)
		end
	end
	
	local rowIndex = 1
	local item
	
	for _, line in pairs(view) do
		local rowFrame = scrollFrame:GetRow(rowIndex)
		local lineType = Characters:GetLineType(line)
		
		if (offset > 0) or (numDisplayedRows >= numRows) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				if not Characters:IsRealmCollapsed(line) then
					isRealmShown = true
				else
					isRealmShown = false
				end
				
				numVisibleRows = numVisibleRows + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif isRealmShown then
				numVisibleRows = numVisibleRows + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType == INFO_REALM_LINE then
				local _, realm, account = Characters:GetInfo(line)
				
				if not Characters:IsRealmCollapsed(line) then
					isRealmShown = true
				else
					isRealmShown = false
				end
				rowFrame.Collapse:Show()
				
				item = rowFrame.Item1
				item:SetWidth(300)
				item:SetPoint("TOPLEFT", 25, 0)
				item.Text:SetWidth(300)
				item.Text:SetJustifyH("LEFT")
				
				if account == THIS_ACCOUNT then	-- saved as default, display as localized.
					item.Text:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", realm, colors.white, colors.green, L["Default"]))
				else
					local last = addon:GetLastAccountSharingInfo(realm, account)
					item.Text:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", realm, colors.white, colors.green, account, colors.yellow, last or ""))
				end
				
				item:SetScript("OnEnter", EmptyFunc)
				item:SetScript("OnClick", Name_OnClick)
				
				for i = 2, 10 do
					rowFrame["Item"..i]:Hide()
				end
	
				rowFrame.character = nil
				rowFrame:SetID(line)
				rowFrame:Show()
				rowIndex = rowIndex + 1
				numVisibleRows = numVisibleRows + 1
				numDisplayedRows = numDisplayedRows + 1
			elseif isRealmShown then
				if (lineType == INFO_CHARACTER_LINE) then
					local character = DataStore:GetCharacter( Characters:GetInfo(line) )
					
					rowFrame.character = character
					rowFrame.Collapse:Hide()
					rowFrame.Item1:SetPoint("TOPLEFT", 10, 0)

					-- fill the visible cells for this mode
					for i = 1, #currentMode do
						SetButtonData(rowFrame["Item"..i], character, currentMode[i])
					end
					
				elseif (lineType == INFO_TOTAL_LINE) then
					rowFrame.character = nil
					rowFrame.Collapse:Hide()
					
					-- fill the visible cells for this mode
					for i = 1, #currentMode do
						SetTotalButtonData(rowFrame["Item"..i], line, currentMode[i])
					end
					
					item = rowFrame.Item1
					item:SetPoint("TOPLEFT", 10, 0)
					item:SetScript("OnEnter", ShowTotals)
				end
					
				-- hide the extra cells
				for i = #currentMode+1, 10 do
					rowFrame["Item"..i]:Hide()
				end
				
				rowFrame:SetID(line)
				rowFrame:Show()
				rowIndex = rowIndex + 1
				numVisibleRows = numVisibleRows + 1
				numDisplayedRows = numDisplayedRows + 1
			end
		end
	end
	
	while rowIndex <= numRows do
		local rowFrame = scrollFrame:GetRow(rowIndex) 
		
		rowFrame:SetID(0)
		rowFrame:Hide()
		rowIndex = rowIndex + 1
	end

	scrollFrame:Update(numVisibleRows)
end

function addon:AiLTooltip()
	local tt = AltoTooltip
	
	tt:AddLine(" ",1,1,1);
	-- tt:AddLine(colors.teal .. L["Level"] .. " 60",1,1,1);
	-- tt:AddDoubleLine(colors.yellow .. "58-63", colors.white .. "Tier 0")
	-- tt:AddDoubleLine(colors.yellow .. "66", colors.white .. "Tier 1")
	-- tt:AddDoubleLine(colors.yellow .. "76", colors.white .. "Tier 2")
	-- tt:AddDoubleLine(colors.yellow .. "86-92", colors.white .. "Tier 3")
	-- tt:AddLine(" ",1,1,1);
	
	-- tt:AddLine(colors.teal .. L["Level"] .. " 70",1,1,1);
	-- tt:AddDoubleLine(colors.yellow .. "115", colors.white .. GetMapNameByID(799))	-- "Karazhan"
	-- tt:AddDoubleLine(colors.yellow .. "120", colors.white .. "Tier 4")
	-- tt:AddDoubleLine(colors.yellow .. "128", colors.white .. GetMapNameByID(781))	-- "Zul'Aman"
	-- tt:AddDoubleLine(colors.yellow .. "133", colors.white .. "Tier 5")
	-- tt:AddDoubleLine(colors.yellow .. "146-154", colors.white .. "Tier 6")
	-- tt:AddLine(" ",1,1,1);

	tt:AddLine(colors.teal .. L["Level"] .. " 80",1,1,1);
	tt:AddDoubleLine(colors.yellow .. "200", colors.white .. GetMapNameByID(535) .. " (10)")	-- "Naxxramas"
	tt:AddDoubleLine(colors.yellow .. "213", colors.white .. GetMapNameByID(535) .. " (25)")
	tt:AddDoubleLine(colors.yellow .. "200-219", colors.white .. GetMapNameByID(542))		-- "Trial of the Champion"
	tt:AddDoubleLine(colors.yellow .. "219", colors.white .. GetMapNameByID(529) .. " (10)")	-- "Ulduar"
	tt:AddDoubleLine(colors.yellow .. "226-239", colors.white .. GetMapNameByID(529) .. " (25)")
	tt:AddDoubleLine(colors.yellow .. "232-258", colors.white .. GetMapNameByID(543) .. " (10)")		-- "Trial of the Crusader"
	tt:AddDoubleLine(colors.yellow .. "245-272", colors.white .. GetMapNameByID(543) .. " (25)")
	tt:AddDoubleLine(colors.yellow .. "251-271", colors.white .. GetMapNameByID(604) .. " (10)")		-- "Icecrown Citadel"
	tt:AddDoubleLine(colors.yellow .. "264-284", colors.white .. GetMapNameByID(604) .. " (25)")
	tt:AddLine(" ",1,1,1);
	
	tt:AddLine(colors.teal .. L["Level"] .. " 85",1,1,1);
	tt:AddDoubleLine(colors.yellow .. "333", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY1))
	tt:AddDoubleLine(colors.yellow .. "346", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY2))
	tt:AddDoubleLine(colors.yellow .. "359", format("%s%s: %s", colors.white, CALENDAR_TYPE_RAID, PLAYER_DIFFICULTY1))
	tt:AddDoubleLine(colors.yellow .. "372", format("%s%s: %s", colors.white, CALENDAR_TYPE_RAID, PLAYER_DIFFICULTY2))
	
	tt:AddLine(colors.teal .. L["Level"] .. " 90",1,1,1);
	tt:AddDoubleLine(colors.yellow .. "358", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY1))
	tt:AddDoubleLine(colors.yellow .. "425", format("%s%s: %s", colors.white, GUILD_CHALLENGE_TYPE4, PLAYER_DIFFICULTY1))
	tt:AddDoubleLine(colors.yellow .. "435", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY2))
	tt:AddDoubleLine(colors.yellow .. "480", format("%s%s: %s", colors.white, GUILD_CHALLENGE_TYPE4, PLAYER_DIFFICULTY2))
	tt:AddLine(" ",1,1,1);
	tt:AddDoubleLine(colors.yellow .. "460", format("%s%s: %s", colors.white, GetMapNameByID(896), PLAYER_DIFFICULTY3))	-- "Mogu'shan Vaults"
	tt:AddDoubleLine(colors.yellow .. "470", format("%s%s: %s", colors.white, GetMapNameByID(897), PLAYER_DIFFICULTY3))	-- "Heart of Fear"
	tt:AddDoubleLine(colors.yellow .. "470", format("%s%s: %s", colors.white, GetMapNameByID(886), PLAYER_DIFFICULTY3))	-- "Terrace of Endless Spring"
	tt:AddDoubleLine(colors.yellow .. "480", format("%s%s: %s", colors.white, GetMapNameByID(930), PLAYER_DIFFICULTY3))	-- "Throne of Thunder"
	tt:AddDoubleLine(colors.yellow .. "496", format("%s%s: %s", colors.white, GetMapNameByID(953), PLAYER_DIFFICULTY3))	-- "Siege of Ogrimmar"
	tt:AddDoubleLine(colors.yellow .. "510", format("%s%s: %s", colors.white, GetMapNameByID(953), "10"))
	tt:AddDoubleLine(colors.yellow .. "520", format("%s%s: %s", colors.white, GetMapNameByID(953), PLAYER_DIFFICULTY4))
	tt:AddDoubleLine(colors.yellow .. "530", format("%s%s: %s", colors.white, GetMapNameByID(953), "25"))
end
