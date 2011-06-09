--[[Consolid8, a World of Warcraft chat frame addon
Copyright 2011 Harry Cutts

This work by Harry Cutts is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
To read this license, please see http://creativecommons.org/licenses/by-nc-sa/3.0/ .]]--

local function CreateHybridPattern(str)
	-- Returns: a pattern string used to process reputation gain messages.
	local returnStr = str:replace("%s", "(.*)",  0, true)
	returnStr = returnStr:replace("%d", "(%d*)", 0, true)
	return returnStr
end

local function CreateIntegerPattern(str)
	-- Returns: a pattern string used to process honor and money messages.
	return str:replace("%d", "(%d*)", 0, true)
end

local function CreateStringPattern(str)
	-- Returns: a pattern string used to process loot messages.
	return str:replace("%s", "(.*)", 0, true)
end

local addOnName,L= ...

-- Money format string with coin textures, size 16.
L["MONEY_FORMAT"] = "%d\124TInterface\\MoneyFrame\\UI-GoldIcon:16:16:2:0\124t %d\124TInterface\\MoneyFrame\\UI-SilverIcon:16:16:2:0\124t %d\124TInterface\\MoneyFrame\\UI-CopperIcon:16:16:2:0\124t"

-- Localised strings
L["CHANGE"]	= "Change"
L["REPORT"]	= "Report"
L["SHOW"]	= "Show"
L["HIDE"]	= HIDE
--[[Show translations 'borrowed' from Omen Threat Meter, credits go to:
Ben (Aesyl - US Tanaris), Pettigrow, Stan (Arcádia - EU Zirkel des Cenarius), Ananhaid, StingerSoft, and Sayclub.
Thanks guys!]]
L["AUTO"]	= "Automatically report"

-- Processed Blizzard Localisation
-- Pattern strings
local linkAndQuantity = "(|c.*|r)x?(%d*)"
L["REP_DEC"]	= CreateHybridPattern (FACTION_STANDING_DECREASED)
L["REP_INC"]	= CreateHybridPattern (FACTION_STANDING_INCREASED)

L["GOLD"]		= CreateIntegerPattern(GOLD_AMOUNT)
L["SILVER"]		= CreateIntegerPattern(SILVER_AMOUNT)
L["COPPER"]		= CreateIntegerPattern(COPPER_AMOUNT)

L["CREATE"]		= format(LOOT_ITEM_CREATED_SELF, linkAndQuantity)
L["SKILL_UP"]	= CreateHybridPattern (SKILL_RANK_UP)

L["LOOT"]		= format(LOOT_ITEM_SELF, linkAndQuantity)
L["LOOT_OTHER"]	= CreateStringPattern (LOOT_ITEM)


local loc = GetLocale()

if loc == "frFR" then
	L["CHANGE"] = "Changement"
	L["REPORT"] = "Rapport"
	L["SHOW"]	= "Afficher"
	L["AUTO"]	= "Automatiquement rapport"

elseif loc == "deDE" then
	L["CHANGE"] = "Änderung"
	L["REPORT"] = "Report"
	L["SHOW"]	= "Zeige"
	L["AUTO"]	= "Automatisch Report"

elseif (loc == "esES") or (loc == "esMX") then
	L["CHANGE"] = "Cambio"
	L["REPORT"] = "Informe"
	L["SHOW"]	= "Mostrar"
	L["AUTO"]	= "Automáticamente informe"

elseif loc == "ruRU" then
	L["CHANGE"] = "Изменение"
	L["REPORT"] = "Рапорт"
	L["SHOW"]	= "Показать"
	L["AUTO"]	= "Автоматически рапорт"

elseif loc == "zhCN" then
	L["CHANGE"] = "变动"
	L["REPORT"] = "报告"
	L["SHOW"]	= "显示"
	L["AUTO"]	= "自动报告"

elseif loc == "zhTW" then
	L["CHANGE"] = "變動"
	L["REPORT"] = "報告"
	L["SHOW"]	= "顯示"
	L["AUTO"]	= "自動報告"

end