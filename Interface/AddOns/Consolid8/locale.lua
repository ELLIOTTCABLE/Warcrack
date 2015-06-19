--[[Consolid8, a World of Warcraft chat frame addon
Copyright 2015 Harry Cutts

This work by Harry Cutts is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
To read this license, please see http://creativecommons.org/licenses/by-nc-sa/3.0/ .]]--

local function CreateHybridPattern(str)
	-- Returns: a pattern string used to process reputation gain messages.
	local returnStr = gsub(str, "%%s", "(.*)")
	returnStr = gsub(returnStr, "%%d", "(%%d*)")
	return returnStr
end

local function CreateIntegerPattern(str)
	-- Returns: a pattern string used to process honor and money messages.
	return gsub(str, "%%d", "(%%d*)")
end

local function CreateStringPattern(str)
	-- Returns: a pattern string used to process loot messages.
	return gsub(str, "%%s", "(.*)")
end

local addOnName,L= ...

-- Money format string with coin textures, size 10
L["MONEY_FORMAT"] = [[%d|TInterface\MoneyFrame\UI-GoldIcon:10:10:2:0|t %d|TInterface\MoneyFrame\UI-SilverIcon:10:10:2:0|t %d|TInterface\MoneyFrame\UI-CopperIcon:10:10:2:0|t]]

-- Localised strings
L["ADD"]	= ADD
L["AUTO"]	= "Automatically report"
L["CHANGE"]	= "Change"
L["ENTER_ITEM_NAME"] = "Enter the item name (case sensitive):"
L["HIDE"]	= HIDE
L["REMOVE"]	= REMOVE
L["REPORT"]	= "Report"
L["RESET_POS"]	= "Reset Position"
L["SHOW"]	= "Show"

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
	L["AUTO"]	= "Automatiquement rapport"
	L["CHANGE"] = "Changement"
	L["ENTER_ITEM_NAME"] = "Écrivez le nom d'article (distinguant majuscules et minuscules) :"
	L["REPORT"] = "Rapport"
	L["RESET_POS"]	= "RÀZ de la position"
	L["SHOW"]	= "Afficher"

elseif loc == "deDE" then
	L["AUTO"]	= "Automatisch Report"
	L["CHANGE"] = "Änderung"
	L["ENTER_ITEM_NAME"] = "Tragen Sie den Einzelteilnamen ein (den Fall empfindlich):"
	L["REPORT"] = "Report"
	L["RESET_POS"]	= "Position zurücksetzen"
	L["SHOW"]	= "Zeige"

elseif (loc == "esES") or (loc == "esMX") then
	L["AUTO"]	= "Automáticamente informe"
	L["CHANGE"] = "Cambio"
	L["ENTER_ITEM_NAME"] = "Incorpore el nombre del artículo (con diferenciación entre mayúsculas y minúsculas):"
	L["REPORT"] = "Informe"
	L["RESET_POS"]	= "Restablecer Posición"
	L["SHOW"]	= "Mostrar"

elseif loc == "ruRU" then
	L["AUTO"]	= "Автоматически рапорт"
	L["CHANGE"] = "Изменение"
	L["ENTER_ITEM_NAME"] = "Введите имя элемента (с учетом регистра):"
	L["REPORT"] = "Рапорт"
	L["RESET_POS"]	= "Сбросить позицию"
	L["SHOW"]	= "Показать"

elseif loc == "zhCN" then
	L["AUTO"]	= "自动报告"
	L["CHANGE"] = "变动"
	L["ENTER_ITEM_NAME"] = "输入项目的名称（区分大小写）："
	L["REPORT"] = "报告"
	L["RESET_POS"]	= "重置位置"
	L["SHOW"]	= "显示"

elseif loc == "zhTW" then
	L["AUTO"]	= "自動報告"
	L["CHANGE"] = "變動"
	L["ENTER_ITEM_NAME"] = "輸入項目名稱（區分大小寫）："
	L["REPORT"] = "報告"
	L["RESET_POS"]	= "重置位置"
	L["SHOW"]	= "顯示"
end
