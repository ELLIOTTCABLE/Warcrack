-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_Destroying                          --
--           http://www.curse.com/addons/wow/tradeskillmaster_destroying          --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- register this file with Ace Libraries
local TSM = select(2, ...)
TSM = LibStub("AceAddon-3.0"):NewAddon(TSM, "TSM_Destroying", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_Destroying") -- loads the localization table

--Professions--
TSM.spells = {
	milling = 51005,
	prospect = 31252,
	disenchant = 13262,
}

local savedDBDefaults = {
	global = {
		history = {},
		ignore = {},
		autoStack = true,
		autoShow = true,
		timeFormat = "ago",
		deMaxQuality = 3,
		logDays = 14,
		includeSoulbound = false,
		deCustomPrice = "0c",
		deAboveVendor = false,
	},
}

-- Called once the player has loaded WOW.
function TSM:OnInitialize()
	-- create shortcuts to all the modules
	for moduleName, module in pairs(TSM.modules) do
		TSM[moduleName] = module
	end
	
	-- load the savedDB into TSM.db
	TSM.db = LibStub:GetLibrary("AceDB-3.0"):New("TradeSkillMaster_DestroyingDB", savedDBDefaults, true)

	-- register this module with TSM
	TSM:RegisterModule()
	
	-- request itemInfo for everything in the disenchant log
	local deSpellName = GetSpellInfo(TSM.spells.disenchant)
	if deSpellName and TSM.db.global.history[deSpellName] then
		for _, deInfo in ipairs(TSM.db.global.history[deSpellName]) do
			TSMAPI:GetSafeItemInfo(deInfo.item)
		end
	end
end

-- registers this module with TSM by first setting all fields and then calling TSMAPI:NewModule().
function TSM:RegisterModule()
	TSM.icons = {
		{side="module", desc="Destroying", slashCommand = "destroying", callback="Options:Load", icon="Interface\\Icons\\INV_Gizmo_RocketBoot_Destroyed_02"},
	}
	TSM.slashCommands = {
		{key="destroy", label=L["Opens the Destroying frame if there's stuff in your bags to be destroyed."], callback="GUI:ShowFrame"},
	}

	TSMAPI:NewModule(TSM)
end


function TSM:OnTSMDBShutdown()
	local data = {}
	local iTypeLookup = {[WEAPON]=2, [ARMOR]=4}
	for _, deInfo in ipairs(TSM.db.global.history[GetSpellInfo(TSM.spells.disenchant)]) do
		local rarity, iLevel, iType = TSMAPI:Select({3, 4, 6}, TSMAPI:GetSafeItemInfo(deInfo.item))
		local isValid = true
		if type(rarity) == "number" and rarity >= 2 and rarity <= 4 and type(iLevel) == "number" and iLevel > 0 and type(iType) == "string" and iTypeLookup[iType] and deInfo.isDraenicEnchanting then
			local result = {}
			for itemString, num in pairs(deInfo.result) do
				local itemID = TSMAPI:GetItemID(itemString)
				if itemID and num > 0 then
					tinsert(result, itemID)
					tinsert(result, num)
				end
			end
			for i=#result+1, 6 do
				result[i] = 0
			end
			tinsert(data, {rarity, iLevel, (iType == WEAPON and 2 or 4), deInfo.time, unpack(result)})
		end
	end
	if TSM.appDB and TSM.appDB.global then
		TSM.appDB.global.disenchant = data
		TradeSkillMasterAppDB.version = max(TradeSkillMasterAppDB.version, 1)
	end
end

-- determines if an item is millable or prospectable
local destroyCache = {}
function TSM:IsDestroyable(itemString)
	if destroyCache[itemString] then
		return unpack(destroyCache[itemString])
	end

	local quality, iType, iSubType = TSMAPI:Select({3, 6, 7}, TSMAPI:GetSafeItemInfo(itemString))
	local WEAPON, ARMOR, TRADE_GOODS = TSMAPI:Select({1, 2, 6}, GetAuctionItemClasses())
	local METAL_AND_STONE, HERB = TSMAPI:Select({4, 6}, GetAuctionItemSubClasses(6))
	if itemString and not TSMAPI.DisenchantingData.notDisenchantable[itemString] and (iType == ARMOR or iType == WEAPON) and (quality >= 2 and quality <= TSM.db.global.deMaxQuality) then
		destroyCache[itemString] = {IsSpellKnown(TSM.spells.disenchant) and GetSpellInfo(TSM.spells.disenchant), 1}
		return unpack(destroyCache[itemString])
	end
	
	if iType ~= TRADE_GOODS or (iSubType ~= METAL_AND_STONE and iSubType ~= HERB) then
		destroyCache[itemString] = {}
		return unpack(destroyCache[itemString])
	end
	

	-- milling
	for _, targetItem in ipairs(TSMAPI:GetConversionTargetItems("mill")) do
		local herbs = TSMAPI:GetItemConversions(targetItem)
		if herbs[itemString] then
			destroyCache[itemString] = {IsSpellKnown(TSM.spells.milling) and GetSpellInfo(TSM.spells.milling), 5}
			break
		end
	end

	-- prospecting
	for _, targetItem in ipairs(TSMAPI:GetConversionTargetItems("prospect")) do
		local gems = TSMAPI:GetItemConversions(targetItem)
		if gems[itemString] then
			destroyCache[itemString] = {IsSpellKnown(TSM.spells.prospect) and GetSpellInfo(TSM.spells.prospect), 5}
			break
		end
	end
	return unpack(destroyCache[itemString] or {})
end

function TSM:GetPrice(customPrice, itemString)
	local price, err
	if type(customPrice) == "number" then
		price = customPrice
	elseif type(customPrice) == "string" then
		local func, parseErr = TSMAPI:ParseCustomPrice(customPrice)
		err = parseErr
		price = func and func(itemString)
	end
	return price ~= 0 and price or nil, err
end

function TSM:HasDraenicEnchanting()
	local profession1, profession2 = GetProfessions()
	
	-- check first profession
	if profession1 then
		local skillName, _, level, maxLevel = GetProfessionInfo(profession1)
		if skillName == GetSpellInfo(7411) and level >= 600 and maxLevel == 700 then
			return true
		end
	end
	
	-- check second profession
	if profession2 then
		local skillName, _, level, maxLevel = GetProfessionInfo(profession2)
		if skillName == GetSpellInfo(7411) and level >= 600 and maxLevel == 700 then
			return true
		end
	end
end