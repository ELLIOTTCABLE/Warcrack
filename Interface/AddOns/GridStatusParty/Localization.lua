--[[
	GridStatusParty
	Adds Grid statuses for party leader, raid leader, raid assistant, and master looter.
	Authors: Byron Shelden (Dashkal), Pastamancer, Phanx
	URL: http://www.wowace.com/addons/grid-status-party/
	This file is covered under the BSD-2.0 license.  See LICENSE.TXT for details
--]]

local _, ns = ...
local L = {
	["Party Roles"] = "Party Roles",
	["Party Leader"] = "PL",
	["Raid Leader"] = "RL",
	["Raid Assistant"] = "RA",
	["Master Looter"] = "ML",
}
ns.L = L

local GAME_LOCALE = GetLocale()

if GAME_LOCALE == "deDE" then
L["ML"] = "PM"
L["Party Flags"] = "Gruppensymbole"
L["PL"] = "GL"
L["RA"] = "SA"
L["RL"] = "SL"


elseif GAME_LOCALE == "esES" then
L["ML"] = "MD"
L["Party Flags"] = "Marcas de grupo"
L["PL"] = "LG"
L["RA"] = "AB"
L["RL"] = "LB"


elseif GAME_LOCALE == "esMX" then
L["ML"] = "MD"
L["Party Flags"] = "Marcas de grupo"
L["PL"] = "LG"
L["RA"] = "AB"
L["RL"] = "LB"


elseif GAME_LOCALE == "frFR" then
L["ML"] = "RB"
L["Party Flags"] = "Indicateurs du groupe"
L["PL"] = "CG"
L["RA"] = "AR"
L["RL"] = "CR"


elseif GAME_LOCALE == "ptBR" then
L["ML"] = "MS"
L["Party Flags"] = "Sinalizações do grupo"
L["PL"] = "LG"
L["RA"] = "AR"
L["RL"] = "LR"


elseif GAME_LOCALE == "ruRU" then
L["ML"] = "ОД"
L["Party Flags"] = "Групповые роли"
L["PL"] = "ЛГ"
L["RA"] = "ПР"
L["RL"] = "ЛР"


elseif GAME_LOCALE == "koKR" then
-- L["ML"] = ""
L["Party Flags"] = "파티 깃발"
-- L["PL"] = ""
L["RA"] = "▷"
L["RL"] = "▶"


elseif GAME_LOCALE == "zhCN" then
L["ML"] = "拾"
L["Party Flags"] = "队伍定义"
L["PL"] = "队"
L["RA"] = "助"
L["RL"] = "领"


elseif GAME_LOCALE == "zhTW" then
L["ML"] = "拾"
L["Party Flags"] = "隊伍定義"
L["PL"] = "隊"
L["RA"] = "助"
L["RL"] = "領"


end