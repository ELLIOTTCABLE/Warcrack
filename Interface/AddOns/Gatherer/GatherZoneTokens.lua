--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.2.3 (<%codename%>)
	Revision: $Id: GatherZoneTokens.lua 894 2010-12-02 22:46:33Z Esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Functions for converting to and from the locale independent zone tokens
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherZoneTokens.lua $", "$Rev: 894 $")

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.ZoneTokens, metatable )
setfenv(1, Gatherer.ZoneTokens)

local MapIdToTokenMap = {
	-- Kalimdor
	{
		[43]  = "ASHENVALE",
		[181] = "AZSHARA",
		[464] = "AZUREMYST_ISLE",
		[476] = "BLOODMYST_ISLE",
		[42]  = "DARKSHORE",
		[381] = "DARNASSUS",
		[101] = "DESOLACE",
		[4]   = "DUROTAR",
		[141] = "DUSTWALLOW_MARSH",
		[182] = "FELWOOD",
		[121] = "FERALAS",
		[241] = "MOONGLADE",
		[9]   = "MULGORE",
		[321] = "ORGRIMMAR",
		[261] = "SILITHUS",
		[81]  = "STONETALON_MOUNTAINS",
		[161] = "TANARIS",
		[41]  = "TELDRASSIL",
		[471] = "EXODAR",
		[61]  = "THOUSAND_NEEDLES",
		[362] = "THUNDER_BLUFF",
		[201] = "UNGORO_CRATER",
		[281] = "WINTERSPRING",
		[772] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
		[606] = "MOUNT_HYJAL",
		[607] = "SOUTHERN_BARRENS",
		[11]  = "NORTHERN_BARRENS",
		[720] = "ULDUM",
	},
	-- Eastern Kingdoms
	{
		[16]  = "ARATHI_HIGHLANDS",
		[17]  = "BADLANDS",
		[19]  = "BLASTED_LANDS",
		[29]  = "BURNING_STEPPES",
		[32]  = "DEADWIND_PASS",
		[27]  = "DUN_MOROGH",
		[34]  = "DUSKWOOD",
		[23]  = "EASTERN_PLAGUELANDS",
		[30]  = "ELWYNN_FOREST",
		[462] = "EVERSONG_WOODS",
		[463] = "GHOSTLANDS",
		[24]  = "HILLSBRAD_FOOTHILLS",
		[26]  = "HINTERLANDS",
		[341] = "IRONFORGE",
		[35]  = "LOCH_MODAN",
		[36]  = "REDRIDGE_MOUNTAINS",
		[28]  = "SEARING_GORGE",
		[480] = "SILVERMOON",
		[21]  = "SILVERPINE_FOREST",
		[301] = "STORMWIND",
		[689] = "STRANGLETHORN_VALE",
		[499] = "QUEL_DANAS",
		[38]  = "SWAMP_OF_SORROWS",
		[20]  = "TIRISFAL_GLADES",
		[382] = "UNDERCITY",
		[22]  = "WESTERN_PLAGUELANDS",
		[39]  = "WESTFALL",
		[40]  = "WETLANDS",
		[708] = "TOL_BARAD",
		[610] = "KELPTHAR_FOREST",
		[614] = "ABYSSAL_DEPTHS",
		[685] = "RUINS_OF_GILNEAS_CITY",
		[709] = "TOL_BARAD_PENINSULA",
		[613] = "VASHJIR",
		[615] = "SHIMMERING_EXPANSE",
		[684] = "RUINS_OF_GILNEAS",
		[37]  = "NORTHERN_STRANGLETHORN",
		[700] = "TWILIGHT_HIGHLANDS",
		[673] = "CAPE_OF_STRANGLETHORN",
	},
	-- Outland
	{
		[475] = "BLADES_EDGE_MOUNTAINS",
		[465] = "HELLFIRE_PENINSULA",
		[477] = "NAGRAND",
		[479] = "NETHERSTORM",
		[473] = "SHADOWMOON_VALLEY",
		[481] = "SHATTRATH",
		[478] = "TEROKKAR_FOREST",
		[467] = "ZANGARMARSH",
	},
	-- Northrend
	{
		[486] = "BOREAN_TUNDRA",
		[510] = "CRYSTALSONG_FOREST",
		[504] = "DALARAN", 
		[488] = "DRAGONBLIGHT",
		[490] = "GRIZZLY_HILLS",
		[541] = "HROTHGARS_LANDING",
		[491] = "HOWLING_FJORD",
		[492] = "ICECROWN_GLACIER",
		[493] = "SHOLAZAR_BASIN",
		[495] = "STORM_PEAKS",
		[501] = "LAKE_WINTERGRASP",
		[496] = "ZULDRAK",
	},
	-- Maelstrom Continent
	{
		[605] = "KEZAN",
		[640] = "DEEPHOLM",
		[737] = "MAELSTROM",
		[544] = "LOST_ISLES",
	},
}

Tokens = {}
TokenToMapID = {}
TempTokens = {}

unrecognizedZones = {}

Ver3To4TempTokens = {
	["AhnQirajTheFallenKingdom"] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
	["Uldum"] = "ULDUM",
	["SouthernBarrens"] = "SOUTHERN_BARRENS",
	["Orgrimmar"] = "ORGRIMMAR",
	["Hyjal_terrain1"] = "MOUNT_HYJAL",
	["Darnassus"] = "DARNASSUS",
	["VashjirRuins"] = "SHIMMERING_EXPANSE",
	["StormwindCity"] = "STORMWIND",
	["RuinsofGilneasCity"] = "RUINS_OF_GILNEAS_CITY",
	["StranglethornVale"] = "STRANGLETHORN_VALE",
	["TwilightHighlands"] = "TWILIGHT_HIGHLANDS",
	["VashjirKelpForest"] = "KELPTHAR_FOREST",
	["HillsbradFoothills"] = "HILLSBRAD_FOOTHILLS",
	["StranglethornJungle"] = "NORTHERN_STRANGLETHORN",
	["RuinsofGilneas"] = "RUINS_OF_GILNEAS",
	["Vashjir"] = "VASHJIR",
	["TolBaradDailyArea"] = "TOL_BARAD_PENINSULA",
	["TolBarad"] = "TOL_BARAD",
	["TheCapeOfStranglethorn"] = "CAPE_OF_STRANGLETHORN",
	["VashjirDepths"] = "ABYSSAL_DEPTHS",
	["Kezan"] = "KEZAN",
	["TheLostIsles"] = "LOST_ISLES",
	["Deepholm"] = "DEEPHOLM",
	["TheMaelstrom"] = "MAELSTROM",
}

for continent, zones in pairs(Astrolabe.ContinentList) do
	local fileTokenMap = MapIdToTokenMap[continent];
	local tokenMap = {}
	for index, mapID in pairs(zones) do
		if ( index > 0 ) then
			local zoneToken
			if not ( fileTokenMap and fileTokenMap[mapID] ) then
				-- use the map name as a temporary token and 
				-- mark the map name as such
				zoneToken = tostring(mapID)
				TempTokens[zoneToken] = 1;
				table.insert(unrecognizedZones, (select(index, GetMapZones(continent))))
			else
				zoneToken = fileTokenMap[mapID]
			end
			tokenMap[index] = zoneToken
			tokenMap[zoneToken] = index
			TokenToMapID[zoneToken] = mapID
			TokenToMapID[mapID] = zoneToken
		end
	end
	Tokens[continent] = tokenMap
end

if ( next(unrecognizedZones) ) then
	-- some zones were unrecognized, warn user
	local zoneList = string.join(", ", unpack(unrecognizedZones))
	Gatherer.Notifications.AddInfo(_tr("Gatherer was unable to identify the following zones: "..HIGHLIGHT_FONT_COLOR_CODE.."%1|r.  \nIf these are new zones, then this is not a problem, and you can continue as normal.  \nIf these are not new zones, then remain calm, "..HIGHLIGHT_FONT_COLOR_CODE.."your data IS NOT LOST!|r  Your data for these zones is still intact, but you will need to update Gatherer in order to access it.  Until then you can continue as normal and any new data you collect will be merged with your old data once you upgrade.  \n\n"..HIGHLIGHT_FONT_COLOR_CODE.."Please upgrade Gatherer when convenient.  |r", zoneList))
end
unrecognizedZones = nil

function GetZoneToken( continent, zone )
	if not ( Tokens[continent] ) then
		return nil
	end
	local val = Tokens[continent][zone]
	if ( val ) then
		if ( type(zone) == "number" ) then
			return val
		else
			return zone
		end
	else
		-- try other sources
		val = Ver3To4TempTokens[zone]
		if ( val ) then
			return val
		end
	end
end

function GetContinentAndZone( token )
	for continent, zoneTokens in pairs(Tokens) do
		if ( zoneTokens[token] ) then
			return continent, zoneTokens[token]
		end
	end
end

function GetZoneIndex( continent, token )
	if not ( Tokens[continent] ) then
		return nil
	end
	local val = Tokens[continent][token]
	if ( val ) then
		if ( type(token) == "string" ) then
			return val
		else
			return token
		end
	end
end

function GetZoneMapID( continent, token )
	local zone = nil
	if ( Tokens[continent] ) then
		zone = Tokens[continent][token]
	end
	if ( type(zone) ~= "number" and type(token) == "number" ) then
		zone = Tokens[continent][Tokens[continent][token]]
	end
	return Astrolabe:GetMapID(continent, zone)
end

function GetZoneMapIDAndFloor( mapToken )
	local mapID = TokenToMapID[mapToken]
	if ( mapID ) then
		return mapID, ((Astrolabe:GetNumFloors(mapID) == 0) and 0 or 1)
	end
end

function GetZoneTokenFromMapID( mapID )
	return TokenToMapID[mapID]
end

function IsTempZoneToken( continent, token )
	if ( Gatherer.ZoneTokens.Tokens[continent][token] == nil or Gatherer.ZoneTokens.TempTokens[token] ) then
		return true
	else
		return false
	end
end

function GetTokenFromMapID( continent, zone )
	if ( MapIdToTokenMap[continent] ) then
		return MapIdToTokenMap[continent][zone]
	else
		for i, contData in pairs(MapIdToTokenMap) do
			if ( contData[zone] ) then
				return contData[zone]
			end
		end
	end
end
