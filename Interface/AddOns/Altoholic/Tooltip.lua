﻿local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local THIS_ACCOUNT = "Default"
local THIS_REALM = GetRealmName()

local Orig_GameTooltip_OnShow
local Orig_GameTooltip_SetItem
local Orig_GameTooltip_ClearItem
local Orig_GameTooltip_SetCurrencyToken
-- local Orig_GameTooltip_SetSpell

local Orig_ItemRefTooltip_OnShow
local Orig_ItemRefTooltip_SetItem
local Orig_ItemRefTooltip_ClearItem
-- local Orig_ItemRefTooltip_SetSpell

local GatheringNodes = {			-- Add herb/ore possession info to Plants/Mines, thanks to Tempus on wowace for gathering this.

	-- Mining nodes
	[L["Adamantite Deposit"]]              = 23425, -- Adamantite Ore
	[L["Copper Vein"]]                     =  2770, -- Copper Ore
	[L["Dark Iron Deposit"]]               = 11370, -- Dark Iron Ore
	[L["Fel Iron Deposit"]]                = 23424, -- Fel Iron Ore
	[L["Gold Vein"]]                       =  2776, -- Gold Ore
	[L["Hakkari Thorium Vein"]]            = 10620, -- Thorium Ore
	[L["Iron Deposit"]]                    =  2772, -- Iron Ore
	[L["Khorium Vein"]]                    = 23426, -- Khorium Ore
	[L["Mithril Deposit"]]                 =  3858, -- Mithril Ore
	[L["Ooze Covered Gold Vein"]]          =  2776, -- Gold Ore
	[L["Ooze Covered Mithril Deposit"]]    =  3858, -- Mithril Ore
	[L["Ooze Covered Rich Thorium Vein"]]  = 10620, -- Thorium Ore
	[L["Ooze Covered Silver Vein"]]        =  2775, -- Silver Ore
	[L["Ooze Covered Thorium Vein"]]       = 10620, -- Thorium Ore
	[L["Ooze Covered Truesilver Deposit"]] =  7911, -- Truesilver Ore
	[L["Rich Adamantite Deposit"]]         = 23425, -- Adamantite Ore
	[L["Rich Thorium Vein"]]               = 10620, -- Thorium Ore
	[L["Silver Vein"]]                     =  2775, -- Silver Ore
	[L["Small Thorium Vein"]]              = 10620, -- Thorium Ore
	[L["Tin Vein"]]                        =  2771, -- Tin Ore
	[L["Truesilver Deposit"]]              =  7911, -- Truesilver Ore

	[L["Lesser Bloodstone Deposit"]]       =  4278, -- Lesser Bloodstone Ore
	[L["Incendicite Mineral Vein"]]        =  3340, -- Incendicite Ore
	[L["Indurium Mineral Vein"]]           =  5833, -- Indurium Ore
	[L["Nethercite Deposit"]]              = 32464, -- Nethercite Ore
	[L["Large Obsidian Chunk"]]				= 22203,	-- Large Obsidian Shard	Both drop on both nodes..
	[L["Small Obsidian Chunk"]]				= 22202,	-- Small Obsidian Shard
	
	-- wotlk
	["Cobalt Deposit"]							= 36909, -- Cobalt Ore
	["Rich Cobalt Deposit"]						= 36909, -- Cobalt Ore
	["Saronite Deposit"]							= 36912, -- Saronite Ore
	["Rich Saronite Deposit"]					= 36912, -- Saronite Ore
	["Titanium Vein"]								= 36910, -- Titanium Ore

	-- cata
	["Obsidium Deposit"]					= 53038, -- Obsidium Ore
	["Rich Obsidium Deposit"]				= 53038, -- Obsidium Ore
	["Elementium Vein"]						= 52185, -- Elementium Ore
	["Rich Elementium Vein"]				= 52185, -- Elementium Ore
	["Pyrite Deposit"]						= 52183, -- Pyrite Ore
	["Rich Pyrite Deposit"]					= 52183, -- Pyrite Ore
	-- Herbs
	[L["Ancient Lichen"]]       = 22790,
	[L["Arthas' Tears"]]        =  8836,
	[L["Black Lotus"]]          = 13468,
	[L["Blindweed"]]            =  8839,
	[L["Bloodthistle"]]         = 22710,
	[L["Briarthorn"]]           =  2450,
	[L["Bruiseweed"]]           =  2453,
	[L["Dreamfoil"]]            = 13463,
	[L["Dreaming Glory"]]       = 22786,
	[L["Earthroot"]]            =  2449,
	[L["Fadeleaf"]]             =  3818,
	[L["Felweed"]]              = 22785,
	[L["Firebloom"]]            =  4625,
	[L["Flame Cap"]]            = 22788,
	[L["Ghost Mushroom"]]       =  8845,
	[L["Golden Sansam"]]        = 13464,
	[L["Goldthorn"]]            =  3821,
	[L["Grave Moss"]]           =  3369,
	[L["Gromsblood"]]           =  8846,
	[L["Icecap"]]               = 13467,
	[L["Khadgar's Whisker"]]    =  3358,
	[L["Kingsblood"]]           =  3356,
	[L["Liferoot"]]             =  3357,
	[L["Mageroyal"]]            =   785,
	[L["Mana Thistle"]]         = 22793,
	[L["Mountain Silversage"]]  = 13465,
	[L["Netherbloom"]]          = 22791,
	[L["Nightmare Vine"]]       = 22792,
	[L["Peacebloom"]]           =  2447,
	[L["Plaguebloom"]]          = 13466,
	[L["Purple Lotus"]]         =  8831,
	[L["Ragveil"]]              = 22787,
	[L["Silverleaf"]]           =   765,
	[L["Stranglekelp"]]         =  3820,
	[L["Sungrass"]]             =  8838,
	[L["Terocone"]]             = 22789,
	[L["Wild Steelbloom"]]      =  3355,
	[L["Wintersbite"]]          =  3819,

	[L["Glowcap"]]              = 24245,
	[L["Netherdust Bush"]]      = 32468, -- Netherdust Pollen
	[L["Sanguine Hibiscus"]]    = 24246,

	["Fel Lotus"]					= 22794,
	["Goldclover"]					= 36901,
	["Adder's Tongue"]			= 36903,
	["Tiger Lily"]					= 36904,
	["Lichbloom"]					= 36905,
	["Icethorn"]					= 36906,
	["Talandra's Rose"]			= 36907,
	["Frost Lotus"]				= 36908,
	["Firethorn"]					= 39970,
	["Cinderbloom"]				= 52983,
	["Stormvine"]				= 52984,
	["Azshara's Veil"]			= 52985,
	["Heartblossom"]			= 52986,
	["Twilight Jasmine"]		= 52987,
	["Whiptail"]				= 52988,
	["Deathspore Pod"]			= 52989,
	["Green Tea Leaf"]			= 72234,
	["Snow Lily"]					= 79010,
}

-- *** Utility functions ***
local function IsGatheringNode(name)
	if name then
		for k, v in pairs(GatheringNodes) do
			if name == k then				-- returns the itemID if "name" is a known type of gathering node (mines & herbs)
				return v
			end
		end
	end
end

local function GetCraftNameFromRecipeLink(link)
	-- get the craft name from the itemlink (strsplit on | to get the 4th value, then split again on ":" )
	local recipeName = select(4, strsplit("|", link))
	local craftName

	-- try to determine if it's a transmute (has 2 colons in the string --> Alchemy: Transmute: blablabla)
	local pos = string.find(recipeName, L["Transmute"])
	if pos then	-- it's a transmute
		return string.sub(recipeName, pos, -2)
	else
		craftName = select(2, strsplit(":", recipeName))
	end
	
	if craftName == nil then		-- will be nil for enchants
		return string.sub(recipeName, 3, -2)		-- ex: "Enchant Weapon - Striking"
	end
	
	return string.sub(craftName, 2, -2)	-- at this point, get rid of the leading space and trailing square bracket
end

local isTooltipDone, isNodeDone			-- for informant
local cachedItemID, cachedCount, cachedTotal, cachedSource
local cachedRecipeOwners

local itemCounts = {}
local itemCountsLabels = {	L["Bags"], L["Bank"], VOID_STORAGE, REAGENT_BANK, L["AH"], L["Equipped"], L["Mail"], CURRENCY }
local counterLines = {}		-- list of lines containing a counter to display in the tooltip

local function AddCounterLine(owner, counters)
	table.insert(counterLines, { ["owner"] = owner, ["info"] = counters } )
end

local function WriteCounterLines(tooltip)
	if #counterLines == 0 then return end

	if addon:GetOption("UI.Tooltip.ShowItemCount") then			-- add count per character/guild
		tooltip:AddLine(" ",1,1,1);
		for _, line in ipairs (counterLines) do
			tooltip:AddDoubleLine(line.owner,  colors.teal .. line.info);
		end
	end
end

local function WriteTotal(tooltip)
	if addon:GetOption("UI.Tooltip.ShowTotalItemCount") and cachedTotal then
		tooltip:AddLine(cachedTotal,1,1,1);
	end
end

local function GetRealmsList()
	-- returns the list of realms to check, either only this realm, or merged realms too.
	local realms = {}
	table.insert(realms, THIS_REALM)
	
	if addon:GetOption("UI.Tooltip.ShowMergedRealmsCount") then
		for _, connectedRealm in pairs(DataStore:GetRealmsConnectedWith(THIS_REALM)) do
			table.insert(realms, connectedRealm)
		end
	end
	
	return realms
end

local function GetCharacterItemCount(character, searchedID)
	itemCounts[1], itemCounts[2], itemCounts[3], itemCounts[4] = DataStore:GetContainerItemCount(character, searchedID)
	itemCounts[5] = DataStore:GetAuctionHouseItemCount(character, searchedID)
	itemCounts[6] = DataStore:GetInventoryItemCount(character, searchedID)
	itemCounts[7] = DataStore:GetMailItemCount(character, searchedID)
	
	local charCount = 0
	for _, v in pairs(itemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local account, realm, char = strsplit(".", character)
		local name = DataStore:GetColoredCharacterName(character) or char		-- if for any reason this char isn't in DS_Characters.. use the name part of the key
		
		local isOtherAccount = (account ~= THIS_ACCOUNT)
		local isOtherRealm = (realm ~= THIS_REALM)
		
		if isOtherAccount and isOtherRealm then		-- other account AND other realm
			name = format("%s%s (%s / %s)", name, colors.yellow, account, realm)
		elseif isOtherAccount then							-- only other account
			name = format("%s%s (%s)", name, colors.yellow, account)
		elseif isOtherRealm then							-- only other realm
			name = format("%s%s (%s)", name, colors.yellow, realm)
		end
		
		local t = {}
		for k, v in pairs(itemCounts) do
			if v > 0 then	-- if there are more than 0 items in this container
				table.insert(t, colors.white .. itemCountsLabels[k] .. ": "  .. colors.teal .. v)
			end
		end

		if addon:GetOption("UI.Tooltip.ShowSimpleCount") then
			AddCounterLine(name, format("%s%s", colors.orange, charCount))
		else
			-- charInfo should look like 	(Bags: 4, Bank: 8, Equipped: 1, Mail: 7), table concat takes care of this
			AddCounterLine(name, format("%s%s%s (%s%s)", colors.orange, charCount, colors.white, table.concat(t, colors.white..", "), colors.white))
		end
	end
	
	return charCount
end

local function GetAccountItemCount(account, searchedID)
	local count = 0

	for _, realm in pairs(GetRealmsList()) do
		for _, character in pairs(DataStore:GetCharacters(realm, account)) do
			if addon:GetOption("UI.Tooltip.ShowCrossFactionCount") then
				count = count + GetCharacterItemCount(character, searchedID)
			else
				if	DataStore:GetCharacterFaction(character) == UnitFactionGroup("player") then
					count = count + GetCharacterItemCount(character, searchedID)
				end
			end
		end
	end
	return count
end

local function GetItemCount(searchedID)
	-- Return the total amount of times an item is present on this realm, and prepares the counterLines table for later display by the tooltip
	wipe(counterLines)

	local count = 0
	if addon:GetOption("UI.Tooltip.ShowAllAccountsCount") and not addon.Comm.Sharing.SharingInProgress then
		for account in pairs(DataStore:GetAccounts()) do
			count = count + GetAccountItemCount(account, searchedID)
		end
	else
		count = GetAccountItemCount(THIS_ACCOUNT, searchedID)
	end
		
	if addon:GetOption("UI.Tooltip.ShowGuildBankCount") then
		for _, realm in pairs(GetRealmsList()) do
			for guildName, guildKey in pairs(DataStore:GetGuilds(realm)) do
				local altoGuild = addon:GetGuild(guildName)
				if not altoGuild or (altoGuild and not altoGuild.hideInTooltip) then
					local guildCount = 0
					
					if addon:GetOption("UI.Tooltip.ShowGuildBankCountPerTab") then
						local tabCounters = {}
						
						local tabCount
						for tabID = 1, 8 do 
							tabCount = DataStore:GetGuildBankTabItemCount(guildKey, tabID, searchedID)
							if tabCount and tabCount > 0 then
								table.insert(tabCounters,  format("%s: %s", colors.white .. DataStore:GetGuildBankTabName(guildKey, tabID), colors.teal..tabCount))
							end
						end
						
						if #tabCounters > 0 then
							guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID) or 0
							AddCounterLine(colors.green..guildName, format("%s %s(%s%s)", colors.orange .. guildCount, colors.white, table.concat(tabCounters, ","), colors.white))
						end
					else
						guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID) or 0
						if guildCount > 0 then
							AddCounterLine(colors.green..guildName, format("%s(%s: %s%s)", colors.white, GUILD_BANK, colors.teal..guildCount, colors.white))
						end
					end
						
					if addon:GetOption("UI.Tooltip.IncludeGuildBankInTotal") then
						count = count + guildCount
					end
				end
			end
		end
	end

	return count
end

function addon:GetRecipeOwners(professionName, link, recipeLevel)
	local craftName
	local spellID = addon:GetSpellIDFromRecipeLink(link)

	if not spellID then		-- spell id unknown ? let's parse the tooltip
		craftName = GetCraftNameFromRecipeLink(link)
		if not craftName then return end		-- still nothing usable ? then exit
	end
	
	local know = {}				-- list of alts who know this recipe
	local couldLearn = {}		-- list of alts who could learn it
	local willLearn = {}			-- list of alts who will be able to learn it later

	if not recipeLevel then
		-- it seems that some tooltip libraries interfere and cause a recipeLevel to be nil
		return know, couldLearn, willLearn
	end
	
	local profession, isKnownByChar
	for characterName, character in pairs(DataStore:GetCharacters()) do
		profession = DataStore:GetProfession(character, professionName)

		isKnownByChar = nil
		if profession then
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				isKnownByChar = DataStore:IsCraftKnown(profession, spellID)
			else
				for i = 1, DataStore:GetNumCraftLines(profession) do
					local isHeader, _, info = DataStore:GetCraftLineInfo(profession, i)
					
					if not isHeader then
						local skillName = GetSpellInfo(info) or ""

						if string.lower(skillName) == string.lower(craftName) then
							isKnownByChar = true
							break
						end				
					end
				end
			end

			local coloredName = DataStore:GetColoredCharacterName(character)
			
			if isKnownByChar then
				table.insert(know, coloredName)
			else
				local currentLevel = DataStore:GetProfessionInfo(DataStore:GetProfession(character, professionName))
				if currentLevel > 0 then
					if currentLevel < recipeLevel then
						table.insert(willLearn, format("%s |r(%d)", coloredName, currentLevel))
					else
						table.insert(couldLearn, format("%s |r(%d)", coloredName, currentLevel))
					end
				end
			end
		end
	end
	
	return know, couldLearn, willLearn
end

local function GetRecipeOwnersText(professionName, link, recipeLevel)

	local know, couldLearn, willLearn = addon:GetRecipeOwners(professionName, link, recipeLevel)
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, colors.teal .. L["Already known by "] ..": ".. colors.white.. table.concat(know, ", ") .."\n")
	end
	
	if #couldLearn > 0 then
		table.insert(lines, colors.yellow .. L["Could be learned by "] ..": ".. colors.white.. table.concat(couldLearn, ", ") .."\n")
	end
	
	if #willLearn > 0 then
		table.insert(lines, colors.red .. L["Will be learnable by "] ..": ".. colors.white.. table.concat(willLearn, ", "))
	end
	
	return table.concat(lines, "\n")
end

local function AddGlyphOwners(itemID, tooltip)
	local know = {}				-- list of alts who know this glyoh
	local couldLearn = {}		-- list of alts who could learn it

	local knows, could
	for characterName, character in pairs(DataStore:GetCharacters()) do
		knows, could = DataStore:IsGlyphKnown(character, itemID)
		if knows then
			table.insert(know, characterName)
		elseif could then
			table.insert(couldLearn, characterName)
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(colors.teal .. L["Already known by "] ..": ".. colors.white.. table.concat(know, ", "), 1, 1, 1, 1);
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(colors.yellow .. L["Could be learned by "] ..": ".. colors.white.. table.concat(couldLearn, ", "), 1, 1, 1, 1);
	end
end

local function ShowGatheringNodeCounters()
	-- exit if player does not want counters for known gathering nodes
	if addon:GetOption("UI.Tooltip.ShowGatheringNodesCount") == false then return end

	local itemID = IsGatheringNode( _G["GameTooltipTextLeft1"]:GetText() )
	if not itemID or (itemID == cachedItemID) then return end					-- is the item in the tooltip a known type of gathering node ?
	
	if Informant then
		isNodeDone = true
	end

	-- check player bags to see how many times he owns this item, and where
	if addon:GetOption("UI.Tooltip.ShowItemCount") or addon:GetOption("UI.Tooltip.ShowTotalItemCount") then
		cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
		cachedTotal = (cachedCount > 0) and format("%s: %s", colors.gold..L["Total owned"], colors.teal..cachedCount) or nil
	end
	
	WriteCounterLines(GameTooltip)
	WriteTotal(GameTooltip)
end

local function ProcessTooltip(tooltip, name, link)
	if Informant and isNodeDone then
		return
	end
	
	local itemID = addon:GetIDFromLink(link)
	
	-- if there's no cached item id OR if it's different from the previous one ..
	if (not cachedItemID) or 
		(cachedItemID and (itemID ~= cachedItemID)) then

		cachedRecipeOwners = nil
		
		-- these are the cpu intensive parts of the update .. so do them only if necessary
		cachedSource = nil
		if addon:GetOption("UI.Tooltip.ShowItemSource") then
			local domain, subDomain = addon.Loots:GetSource(itemID)
			
			cachedItemID = itemID			-- we have searched this ID ..
			if domain then
				subDomain = (subDomain) and format(", %s", subDomain) or ""
				cachedSource = format("%s: %s%s", colors.gold..L["Source"], colors.teal..domain, subDomain)
			end
		end
		
		-- .. then check player bags to see how many times he owns this item, and where
		if addon:GetOption("UI.Tooltip.ShowItemCount") or addon:GetOption("UI.Tooltip.ShowTotalItemCount") then
			cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
			cachedTotal = (cachedCount > 0) and format("%s: %s", colors.gold..L["Total owned"], colors.teal..cachedCount) or nil
		end
	end

	-- add item cooldown text
	local owner = tooltip:GetOwner()
	if owner and owner.startTime then
		tooltip:AddLine(format(ITEM_COOLDOWN_TIME, SecondsToTime(owner.duration - (GetTime() - owner.startTime))),1,1,1);
	end

	WriteCounterLines(tooltip)
	WriteTotal(tooltip)
	
	if cachedSource then		-- add item source
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(cachedSource,1,1,1);
	end
	
	-- addon:CheckMaterialUtility(itemID)
	
	if addon:GetOption("UI.Tooltip.ShowItemID") then
		local iLevel = select(4, GetItemInfo(itemID))
		
		if iLevel then
			tooltip:AddLine(" ",1,1,1);
			tooltip:AddDoubleLine("Item ID: " .. colors.green .. itemID,  "iLvl: " .. colors.green .. iLevel);
		end
	end
	
	local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
	
	-- 25/01/2015: Removed the code that displayed the pet owners, since they have been account wide for a while now..
	
	if itemType == BI["Glyph"] then
		AddGlyphOwners(itemID, tooltip)
		return
	end
	
	if addon:GetOption("UI.Tooltip.ShowKnownRecipes") == false then return end -- exit if recipe information is not wanted
	
	if itemType ~= L["ITEM_TYPE_RECIPE"] then return end		-- exit if not a recipe
	if itemSubType == L["ITEM_SUBTYPE_BOOK"] then return end		-- exit if it's a book

	if not cachedRecipeOwners then
		cachedRecipeOwners = GetRecipeOwnersText(itemSubType, link, addon:GetRecipeLevel(link, tooltip))
	end
	
	if cachedRecipeOwners then
		tooltip:AddLine(" ",1,1,1);	
		tooltip:AddLine(cachedRecipeOwners, 1, 1, 1, 1);
	end	
end

local function Hook_LinkWrangler(frame)
	local name, link = frame:GetItem()
	if name and link then
		ProcessTooltip(frame, name, link)
	end
end

-- ** GameTooltip hooks **
local function OnGameTooltipShow(tooltip, ...)
	if Orig_GameTooltip_OnShow then
		Orig_GameTooltip_OnShow(tooltip, ...)
	end	
	
	ShowGatheringNodeCounters()
	GameTooltip:Show()
end

local function OnGameTooltipSetItem(tooltip, ...)
	if Orig_GameTooltip_SetItem then
		Orig_GameTooltip_SetItem(tooltip, ...)
	end
	
	if (not isTooltipDone) and tooltip then
		local name, link = tooltip:GetItem()
		isTooltipDone = true
		if link then
			ProcessTooltip(tooltip, name, link)
		end
	end
end

local function OnGameTooltipCleared(tooltip, ...)
	isTooltipDone = nil
	isNodeDone = nil		-- for informant
	return Orig_GameTooltip_ClearItem(tooltip, ...)
end

local function Hook_SetCurrencyToken(self,index,...)
	Orig_GameTooltip_SetCurrencyToken(self, index, ...)
	
	if not index then return end

	local currency = GetCurrencyListInfo(index)
	if not currency then return end

	GameTooltip:AddLine(" ",1,1,1);

	local total = 0
	for _, character in pairs(DataStore:GetCharacters()) do
		local _, _, count = DataStore:GetCurrencyInfoByName(character, currency)
		if count and count > 0 then
			GameTooltip:AddDoubleLine(DataStore:GetColoredCharacterName(character),  colors.teal .. count);
			total = total + count
		end
		
	end
	
	if total > 0 then
		GameTooltip:AddLine(" ",1,1,1);
	end
	GameTooltip:AddLine(format("%s: %s", colors.gold..L["Total owned"], colors.teal..total ) ,1,1,1);
	GameTooltip:Show()
end

-- ** ItemRefTooltip hooks **
local function OnItemRefTooltipShow(tooltip, ...)
	if Orig_ItemRefTooltip_OnShow then
		Orig_ItemRefTooltip_OnShow(tooltip, ...)
	end

	addon:ListCharsOnQuest( _G["ItemRefTooltipTextLeft1"]:GetText(), UnitName("player"), ItemRefTooltip)
	ItemRefTooltip:Show()
end

local function OnItemRefTooltipSetItem(tooltip, ...)
	if Orig_ItemRefTooltip_SetItem then
		Orig_ItemRefTooltip_SetItem(tooltip, ...)
	end
	
	if (not isTooltipDone) and tooltip then
		local name, link = tooltip:GetItem()
		isTooltipDone = true
		if link then
			ProcessTooltip(tooltip, name, link)
		end
	end
end

local function OnItemRefTooltipCleared(tooltip, ...)
	isTooltipDone = nil
	return Orig_ItemRefTooltip_ClearItem(tooltip, ...)
end


function addon:InitTooltip()
	-- save all function pointers
	Orig_GameTooltip_OnShow = GameTooltip:GetScript("OnShow")
	Orig_GameTooltip_SetItem = GameTooltip:GetScript("OnTooltipSetItem")
	Orig_GameTooltip_ClearItem = GameTooltip:GetScript("OnTooltipCleared")
	Orig_GameTooltip_SetCurrencyToken = GameTooltip.SetCurrencyToken
	-- Orig_GameTooltip_SetSpell = GameTooltip:GetScript("OnTooltipSetSpell")

	Orig_ItemRefTooltip_OnShow = ItemRefTooltip:GetScript("OnShow")
	Orig_ItemRefTooltip_SetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
	Orig_ItemRefTooltip_ClearItem = ItemRefTooltip:GetScript("OnTooltipCleared")
	-- Orig_ItemRefTooltip_SetSpell = ItemRefTooltip:GetScript("OnTooltipSetSpell")

	-- set new function pointers
	GameTooltip:SetScript("OnShow", OnGameTooltipShow)
	GameTooltip:SetScript("OnTooltipSetItem", OnGameTooltipSetItem)
	GameTooltip:SetScript("OnTooltipCleared", OnGameTooltipCleared)
	GameTooltip.SetCurrencyToken = Hook_SetCurrencyToken
	-- GameTooltip:SetScript("OnTooltipSetSpell", OnGameTooltipSetSpell)

	ItemRefTooltip:SetScript("OnShow", OnItemRefTooltipShow)
	ItemRefTooltip:SetScript("OnTooltipSetItem", OnItemRefTooltipSetItem)
	ItemRefTooltip:SetScript("OnTooltipCleared", OnItemRefTooltipCleared)
	-- ItemRefTooltip:SetScript("OnTooltipSetSpell", OnItemRefTooltipSetSpell)
	
	-- LinkWrangler supoprt
   if LinkWrangler then
      LinkWrangler.RegisterCallback ("Altoholic",  Hook_LinkWrangler, "refresh")
   end
end

function addon:RefreshTooltip()
	cachedItemID = nil	-- putting this at NIL will force a tooltip refresh in self:ProcessToolTip
end

function addon:GetItemCount(searchedID)
	-- "public" for other addons using it
	return GetItemCount(searchedID)
end
