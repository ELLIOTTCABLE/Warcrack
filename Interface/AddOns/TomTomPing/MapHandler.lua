local _G = _G

-- addon name and namespace
local ADDON, NS = ...

local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON)

-- the MapHandler module
local MapHandler = Addon:NewModule("MapHandler", "AceEvent-3.0")

-- local functions
local GetCurrentMapAreaID           = _G.GetCurrentMapAreaID
local GetCurrentMapDungeonLevel     = _G.GetCurrentMapDungeonLevel
local GetMapInfo                    = _G.GetMapInfo
local GetPlayerFacing               = _G.GetPlayerFacing
local GetPlayerMapPosition          = _G.GetPlayerMapPosition 
local IsInInstance                  = _G.IsInInstance
local SetDungeonMapLevel            = _G.SetDungeonMapLevel
local SetMapByID                    = _G.SetMapByID
local SetMapToCurrentZone           = _G.SetMapToCurrentZone
local WorldMapZoomOutButton_OnClick = _G.WorldMapZoomOutButton_OnClick

local atan2 = math.atan2
local sqrt  = math.sqrt

local pairs   = pairs
local tinsert = table.insert

-- aux variables
local _

-- setup libs
local LibStub   = LibStub

-- translations
local L = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

-- libmapdata
local LibMapData = LibStub("LibMapData-1.0")

-- constants
local PI         = math.pi
local TWOPI      = PI * 2
local FRAD       = 180 / PI
local CRAD       = FRAD / 10

-- modules
local Options = nil

-- module data
local moduleData = {
	indoors        = false,
	dungeonLvl     = nil,
	actMap         = nil,
}

-- scaling data
local MinimapSize = {
	indoor = {
		[0] = 300, -- scale
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}

-- module handling
function MapHandler:OnInitialize()	
	-- set module references
	Options = Addon:GetModule("Options")

	-- create the minimap button
	self:Setup()
end

function MapHandler:OnEnable()
	self:SetupEventHandlers()

	-- force zone update
	LibMapData:ZoneChanged(true)
	
	-- update indoor state
	self:UpdateIndoors()
end

function MapHandler:OnDisable()
	self:ResetEventHandlers()
end

function MapHandler:Setup()
	-- empty
end

function MapHandler:SetupEventHandlers()
	-- register event to track zone changes
	LibMapData.RegisterCallback(MapHandler, "MapChanged", "UpdateZone")

	-- zoning events
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateIndoors")
	self:RegisterEvent("ZONE_CHANGED",          "UpdateIndoors")
	self:RegisterEvent("ZONE_CHANGED_INDOORS",  "UpdateIndoors")
end

function MapHandler:ResetEventHandlers()
	-- unregister event to track zone changes
	LibMapData.UnregisterCallback(MapHandler, "MapChanged")

	-- zoning events
	self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	self:UnregisterEvent("ZONE_CHANGED")
	self:UnregisterEvent("ZONE_CHANGED_INDOORS")
end

-- event callbacks
function MapHandler:UpdateZone(event, map, floor)
    moduleData.actMap     = map
    moduleData.dungeonLvl = floor

	Addon:UpdateZone(event, map, floor)
end

function MapHandler:UpdateIndoors()
	local curZoom = Minimap:GetZoom()
	
	if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
		if curZoom < 2 then 
			Minimap:SetZoom(curZoom + 1)
		else 
			Minimap:SetZoom(curZoom - 1)
		end
	end
	
	if GetCVar("minimapZoom")+0 == Minimap:GetZoom() then 
		moduleData.indoors = false
    else 
		moduleData.indoors = true
	end
	
	Minimap:SetZoom(curZoom)
end

-- user functions
function MapHandler:GetIndoors()
	return moduleData.indoors
end

function MapHandler:GetUnitPosition(unit)
	local x, y = GetPlayerMapPosition(unit)
	
	if x <= 0 and y <= 0 then
		if _G.WorldMapFrame:IsVisible() then
			-- no valid position on the current map, and we cannot change map if map is being displayed by player
			return
		end
		
		-- NOTE: we do not recover original map to reduce load
		SetMapToCurrentZone()

		x, y = GetPlayerMapPosition(unit)

		if x <= 0 and y <= 0 then
			if IsInInstance() then
				-- if player is in instance but unit is not on the same map we don't need the position since there is no path anyway
				return
			end
			
			ZoomOut()
			
			x, y = GetPlayerMapPosition(unit)
			
			if x <= 0 and y <= 0 then
				-- we are off the map
				return
			end
		end
	end

	-- microdungeon check
	local mapName, textureWidth, textureHeight, isMicroDungeon, microDungeonName = GetMapInfo()
	
	if isMicroDungeon then
		if not _G.WorldMapFrame:IsVisible() then
			-- zoom out to the main map of this zone
			ZoomOut()
			
			x, y = GetPlayerMapPosition(unit)
			
			-- no further check required, if we got a valid position inside a mini dungeon we get a valid position one zoom level out
		end
	end

	local map   = GetMapInfo()
	local floor = GetCurrentMapDungeonLevel()
	
	return map, floor, x, y
end

function MapHandler:GetPlayerPosition()
	return self:GetUnitPosition("player")
end

function MapHandler:GetMinimapSize(zoom)
	if moduleData.indoors then
		return MinimapSize["indoor"][zoom]
	else
		return MinimapSize["outdoor"][zoom]
	end
end

function MapHandler:GetDistanceLibrary(srcCoords, tgtCoords)
    if srcCoords.map == tgtCoords.map and srcCoords.floor == tgtCoords.floor then
        return LibMapData:Distance(srcCoords.map, srcCoords.floor, srcCoords.x, srcCoords.y, tgtCoords.x, tgtCoords.y)        
    else
        return LibMapData:DistanceWithinContinent(srcCoords.map, srcCoords.floor, srcCoords.x, srcCoords.y,  tgtCoords.map, tgtCoords.floor, tgtCoords.x, tgtCoords.y)        
	end	
end

function MapHandler:GetDistanceMeasured(srcCoords, tgtCoords)
	-- only works within the same zone
    if srcCoords.map == tgtCoords.map and srcCoords.floor == tgtCoords.floor then
		local xDim, yDim = Options:GetZoneDimensions(srcCoords.map, srcCoords.floor)

		if xDim and yDim then
			local dx = (tarC.x - plC.x) * xDim
			local dy = (tarC.y - plC.y) * yDim
			
			distance = sqrt(dx * dx + dy * dy)
			
			return distance, dx, dy
		end
	end	

	-- missing data
	return
end

function MapHandler:GetDistance(srcCoords, tgtCoords, outStatus)
	local errorCode = nil

	if self:ValidCoords(srcCoords) and self:ValidCoords(tgtCoords) then
		if self:AreIdenticalCoords(srcCoords, tgtCoords) then
			return 0, 0, 0
		elseif self:MapAvailable(srcCoords.map, srcCoords.floor) and self:MapAvailable(tgtCoords.map, tgtCoords.floor) then
			if self:CanComputeDistance(srcCoords, tgtCoords) then
				return self:GetDistanceLibrary(srcCoords, tgtCoords)
			else
				errorCode = Addon.NO_PATH
			end
		elseif self:IsOnSameFloor(srcCoords, tgtCoords) and self:MeasurementDataAvailable(srcCoords) then
			return self:GetDistanceMeasured(srcCoords, tgtCoords)
		else
			errorCode = Addon.MISSING_DATA
		end
	else
		errorCode = Addon.INVALID_COORDS
	end

	if type(outStatus) == "table" then
		outStatus.errorCode = errorCode
	end
	
	return
end

function MapHandler:GetMapDimensions(map, floor)
	local width, height = LibMapData:MapArea(map, floor)
	
	if not width then
		width, height = Options:GetZoneDimensions(map, floor)
	end
	
    return width, height
end

function MapHandler:ValidCoords(coords)
	if not coords or type(coords) ~= "table" then
		return false
	end

	return coords.map and coords.floor and coords.x and coords.y and true or false
end

function MapHandler:AreIdenticalCoords(srcCoords, tgtCoords)
	-- coords are more likely to be different and will be checked first
	return self:IsOnSameFloor(srcCoords, tgtCoords) and srcCoords.x == tgtCoords.x and srcCoords.y == tgtCoords.y
end

-- in instances we need to be on the same floor and in the same instance
-- on the world map we have to be on the same continent
function MapHandler:CanComputeDistance(srcCoords, tgtCoords)
	-- we cannot compute between different floors 
	if srcCoords.floor ~= tgtCoords.floor then
		return false
	end

	if LibMapData:MapFloors(srcCoords.map) == 0 then
		-- outside area with no floors
		
		-- check continent
		return LibMapData:GetContinentFromMap(srcCoords.map) == LibMapData:GetContinentFromMap(tgtCoords.map)
	else
		-- inside an instance
		return srcCoords.map == tgtCoords.map
	end
end

function MapHandler:IsOnSameFloor(srcCoords, tgtCoords)
	return srcCoords.map == tgtCoords.map and srcCoords.floor == tgtCoords.floor
end

function MapHandler:MapAvailable(map, floor)
	return LibMapData:MapArea(map, floor) and true or false
end

function MapHandler:MeasurementDataAvailable(map, floor)
	return Options:HasZoneDimensions(map, floor)
end

function MapHandler:GetViewAngle(dx, dy, minimap)
	if not dx or not dy then
		return
	end

    local miniRotate = minimap and GetCVar("rotateMinimap") ~= "0"
	
	dy = minimap and dy or -dy

	local facing = miniRotate and 0 or GetPlayerFacing()
	local angle  = atan2(dx, dy)

	if angle < 0 then
		angle = angle * -1
	else
		angle = TWOPI - angle
	end

	return angle - facing 
end

function MapHandler:GetDistanceToPing()
	local dx, dy = Minimap:GetPingPosition()

	if not dx or not dy then
		return
	end
	
	local distance = sqrt(dx * dx + dy * dy) * self:GetMinimapSize(Minimap:GetZoom())
	
	return distance, dx, dy
end

-- test
function MapHandler:Debug(msg)
	Addon:Debug("(MapHandler) " .. msg)
end
