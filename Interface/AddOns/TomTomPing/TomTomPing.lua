-- TODO:

-- arrow shows when player->target is without path - to test
-- distance calculation doesnt work properly (for tooltip) - to test
-- set waypoint on map / via command? on valid unit (via tooltip? at least for waypoint on target) - to test 
-- check cross server behaviour (class colors/names etc.) - to test
-- dont wordmap zoom if player is in instance to find unit position (no possible path anyway) - to test
-- sticky handling - to test
-- LE_PARTY_CATEGORY_INSTANCE handling - to test
-- zone change reset ref point (implement MapHandler event) - to test

-- LibMapData:IsContinentMap(862/Pandaria) -> false?
-- how to prevent world map zoom if we are outside but unit is inside instance?
-- dont zoom in if we are on current continent level but unit doesnt show up

-- rework spinning arrow
-- update option through addon -> reload
-- modificator options in subsection?

local _G = _G

-- addon name and namespace
local ADDON, NS = ...

-- setup libs
local LibStub   = LibStub

-- get translations
local L         = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

-- local functions
local GetCVar                      = _G.GetCVar
local GetMouseFocus                = _G.GetMouseFocus
local GetPlayerFacing              = _G.GetPlayerFacing
local GetUnitSpeed                 = _G.GetUnitSpeed
local IsAltKeyDown                 = _G.IsAltKeyDown
local InCombatLockdown             = _G.InCombatLockdown
local IsControlKeyDown             = _G.IsControlKeyDown
local IsInGroup                    = _G.IsInGroup
local IsInRaid                     = _G.IsInRaid
local IsMouseButtonDown            = _G.IsMouseButtonDown
local IsShiftKeyDown               = _G.IsShiftKeyDown
local IsSpellInRange               = _G.IsSpellInRange
local SecureButton_GetModifiedUnit = _G.SecureButton_GetModifiedUnit
local UnitIsDead                   = _G.UnitIsDead
local UnitIsUnit                   = _G.UnitIsUnit
local UnitName                     = _G.UnitName
local UnitClass                    = _G.UnitClass
local UnitIsFriend                 = _G.UnitIsFriend
local UnitIsPlayer                 = _G.UnitIsPlayer

local sqrt, abs, floor = math.sqrt, math.abs, math.floor
local gsub, strsub = gsub, string.sub
local cos     = math.cos
local sin     = math.sin

local _

-- constants

-- direction calculation
local PI    = math.pi
local FRAD  = 180 / PI
local CRAD  = FRAD / 10

-- binding descriptions
BINDING_HEADER_TOM_TOM_PING            = ADDON
BINDING_NAME_TOMTOMPING_TARGET         = L["Target as destination"]
BINDING_NAME_TOMTOMPING_STICK          = L["(Un)Stick current destination"]
BINDING_NAME_TOMTOMPING_PING           = L["Ping your position"]
BINDING_NAME_TOMTOMPING_CLEAR          = L["Release CrazyArrow"]
BINDING_NAME_TOMTOMPING_WAYPOINT       = L["Set waypoint at target location"]
BINDING_NAME_TOMTOMPING_CLEAR_WAYPOINT = L["Clear waypoint"]

-- addon and locals
local Addon = LibStub:GetLibrary("AceAddon-3.0"):NewAddon(ADDON, "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

TomTomPing = Addon

-- addon constants
Addon.MODNAME   = "TomTomPing"
Addon.FULLNAME  = "TomTomPing"
Addon.SHORTNAME = "TTP"

-- modules
local Options       = nil
local CrazyArrow    = nil
local Tooltip       = nil
local MinimapButton = nil
local DataBroker    = nil
local MapHandler    = nil

-- constants
local ICON_DEFAULT = "Interface\\Addons\\"..ADDON.."\\icon.tga"
local ICON_COMPASS = "Interface\\Addons\\"..ADDON.."\\compass.tga"
local ICON_ARROW   = "Interface\\Addons\\"..ADDON.."\\arrow.tga"

-- error codes related to distance calculation
Addon.NO_PATH        = 1
Addon.MISSING_DATA   = 2
Addon.INVALID_COORDS = 3

-- local variables
local targetCoords = {}
local playerCoords = {}

-- invisible dummy frame for OnUpdate (only used when target tracking is "mouseover*")
do
	local onUpdateFrame = CreateFrame("Frame", ADDON .. "_Dummy", UIParent)
	onUpdateFrame:SetHeight(1)
	onUpdateFrame:SetWidth(1)
	onUpdateFrame:SetFrameStrata("BACKGROUND")
	onUpdateFrame:SetPoint("TOPLEFT", 0, 0)
	onUpdateFrame:Show()

	function Addon:ActivateOnUpdate(active)
		if active then
			onUpdateFrame:SetScript("OnUpdate", function() TomTomPing:UpdateDestination() end)
		else
			onUpdateFrame:SetScript("OnUpdate", nil)
		end
	end
end

-- reference spell for range test
local classHealSpells = { 
	["DRUID"]   = GetSpellInfo(5185)   or "Healing Touch",
	["MONK"]    = GetSpellInfo(115175) or "Soothing Mist",
	["PRIEST"]  = GetSpellInfo(2061)   or "Flash Heal",
	["PALADIN"] = GetSpellInfo(19750)  or "Flash of Light",
	["SHAMAN"]  = GetSpellInfo(8004)   or "Lesser Healing Wave"
}

local classRezSpells = { 
	["DRUID"]   = GetSpellInfo(20484)  or "Rebirth",
	["MONK"]    = GetSpellInfo(115178) or "Resuscitate",
	["PRIEST"]  = GetSpellInfo(2006)   or "Resurrection",
	["PALADIN"] = GetSpellInfo(7328)   or "Redemption",
	["SHAMAN"]  = GetSpellInfo(2008)   or "Ancestral Spirit"
}

-- label data
local compass = "NW---N---NE---E---SE---S---SW---W---NW---N---NE---E---"

-- class color when unknown
local GRAY = {r = 0.535, g = 0.535, b = 0.535}

-- yellow North
local NORTH = NS:Colorize("Yellow", "N")

-- modificator key check
local function ValidModificatorKeys(alt, ctrl, shift, modificators)
	if modificators == "never" then
		return false
	elseif modificators == "always" then
		return true
	elseif modificators == "alt" then
		return alt and true
	elseif modificators == "ctrl" then
		return ctrl and true
	elseif modificators == "shift" then
		return shift and true
	elseif modificators == "ctrl-alt" or modificators == "alt-ctrl" then
		return ctrl and alt
	elseif modificators == "ctrl-shift" or modificators == "shift-ctrl" then
		return ctrl and shift
	elseif modificators == "alt-shift" or modificators == "shift-alt" then
		return alt and shift
	elseif modificators == "ctrl-alt-shift" or modificators == "ctrl-alt-shift" or modificators == "alt-ctrl-shift" or modificators == "alt-shift-ctrl" or modificators == "shift-ctrl-alt" or modificators == "shift-alt-ctrl" then
		return ctrl and alt and shift
	end
	
	return false
end

-- infrastructure functions
function Addon:OnInitialize()
	-- set module references
	Options       = self:GetModule("Options")
	Tooltip       = self:GetModule("Tooltip")
	CrazyArrow    = self:GetModule("CrazyArrow")
	MinimapButton = self:GetModule("MinimapButton")
	DataBroker    = self:GetModule("DataBroker")
	MapHandler    = self:GetModule("MapHandler")

	self:SetupVariables()

	self:RegisterChatCommand("tomtomping", "ChatCommand")
    self:RegisterChatCommand("ttp",        "ChatCommand")
end

function Addon:OnEnable()
	self:SetupEventHandlers()
	self:SetupPingEventHandler(self:GetSetting("Ping"))
	self:SetupDestinationEventHandler(self:GetSetting("Destination"), true)
	
	self:UpdateIcon()

	MinimapButton:SetShow(Options:GetSetting("Minimap"))
	
	self:SetupPlayer()
	self:UpdateRaidUnits()
	
	-- set initial combat state
	self:UpdateCombatState()
		
	self:ScheduleRepeatingTimer("UpdateDirection", 0.1)
end

function Addon:OnDisable()
	self:ResetEventHandlers()
	self:SetupPingEventHandler(false)
	self:SetupDestinationEventHandler(self:GetSetting("Destination"), false)

	MinimapButton:SetShow(false)	

	self:CancelAllTimers()
end

function Addon:OnOptionsReloaded()
	MinimapButton:SetShow(Options:GetSetting("Minimap"))

	self:SetupPingEventHandler(self:GetSetting("Ping"))

	-- reset all possible old destination events
	for destination in Options:IterateDestinations() do
		self:SetupDestinationEventHandler(destination, false)
	end
	
	-- setup new destination event
	self:SetupDestinationEventHandler(self:GetSetting("Destination"), true)
	
	self:UpdateDestination()
	
	self:Refresh()
end

function Addon:ChatCommand(input)
    if input then  
		args = NS:GetArgs(input)
		
		self:TriggerAction(args[1], args)
	else
		self:TriggerAction("help")
	end
	
end

function Addon:OnClick(button)
    if button == "RightButton" then 
		if IsShiftKeyDown() then
			-- unused
		elseif IsControlKeyDown() then
			-- release arrow
			self:TriggerAction("clear")
		elseif IsAltKeyDown() then
			-- clear waypoint
			self:TriggerAction("waypointclear")
		else
			-- open options menu
			self:TriggerAction("menu")
		end
	elseif button == "LeftButton" then 
		if IsShiftKeyDown() then
			-- ping at self
			self:TriggerAction("ping")
		elseif IsControlKeyDown() then
			-- (un)stick destination
			self:TriggerAction("sticky")
		elseif IsAltKeyDown() then
			-- set waypoint at self
			self:TriggerAction("waypoint")
		else
			-- target as destination
			self:TriggerAction("target")
		end
	end
end

function Addon:TriggerAction(action, args)
	if action == "target" then
		-- target as destination
		local destination = self:GetSetting("Destination")
		
		self:SetDestination("target", destination ~= "none")
	elseif action == "sticky" then
		-- (un)stick destination
		self:ToggleSticky()
	elseif action == "clear" then
		-- release arrow
		self:Release()
	elseif action == "ping" then
		-- ping at self
		self:Ping()
	elseif action == "waypoint" or action == "wp" or action == "way" then
		if args and args[3] then
			-- waypoint on position
			local map, floor = MapHandler:GetUnitPosition("player")
			
			local x = tonumber(args[2])
			local y = tonumber(args[3])
	
			if x and y then	
				if x > 1 then
					x = x / 100
				end
				
				if y > 1 then
					y = y / 100
				end
				
				self:SetWaypoint(map, floor, x, y)
			end
		else
			-- set waypoint on unit
			self:SetWaypointOnUnit(args and args[2] or nil)
		end
	elseif action == "waypointclear" or action == "wpclear" or action == "wayclear" then
		-- clear waypoint
		self:ClearWaypoint()
	elseif action == "measure" then
		-- init map size measurement
		self:Measure()
	elseif action == "menu" then
		-- open options menu
		InterfaceOptionsFrame_OpenToCategory(self.FULLNAME)
	elseif action == "version" then
		-- print version information
		self:PrintVersionInfo()
	elseif action == "pos" then
		local map, floor, x, y = MapHandler:GetUnitPosition("player")
		
		self:Output(string.format("Position of player: %s %s %s %s", tostring(map), tostring(floor), tostring(x), tostring(y)))

		map, floor, x, y = MapHandler:GetUnitPosition("target")
		self:Output(string.format("Position of target: %s %s %s %s", tostring(map), tostring(floor), tostring(x), tostring(y)))
	elseif action == "status" then
		self:PrintStatus()
	elseif action == "mouse" then
		self:Output("Mouse over: " .. tostring(self:GetMouseOverUnit()))
	elseif action == "debug" then
		if args[2] == "on" then
			self:Output("debug mode turned on")
			self.debug = true
		end
		if args[2] == "off" then
			self:Output("debug mode turned off")
			self.debug = false
		end
	else -- if action == "help" then
		-- display help
		self:Output(L["Usage:"])
		self:Output(L["/tomtomping arg"])
		self:Output(L["/ttp arg"])
		self:Output(L["Args:"])
		self:Output(L["target - use current target as arrow target"])
		self:Output(L["sticky - stick/unstick current arrow target"])
		self:Output(L["clear - release the crazy arrow"])
		self:Output(L["ping - ping on self"])
		self:Output(L["waypoint unit/name - set waypoint on specified unit or name"])
		self:Output(L["waypoint x y - set waypoint at specified coordinates"])
		self:Output(L["wpclear - clear waypoint"])
		self:Output(L["measure - init map size measurement (Move at least 20 yards!)"])
		self:Output(L["version - display version information"])
		self:Output(L["menu - display options menu"])
		self:Output(L["help - display this help"])
	end
end

function Addon:CreateTooltip(obj)
	Tooltip:Create(obj)
end

function Addon:RemoveTooltip()
	Tooltip:Remove()
end

-- setup functions
function Addon:SetupVariables()
	-- player data
	self.playerClass    = nil
	self.playerName     = nil
	self.playerIsHealer = false
	self.healSpellName  = nil
	self.rezSpellName   = nil

	-- destination data
	self.destinationUnit = nil
	self.destinationName = nil
	self.sticky = false

	-- ping data
	self.pingerName = nil

	-- waypoints
	self.waypoint = {}

	-- map name to raid/party unit
	self.name2Unit = {}

	-- reference point for map measurement
	self.refPoint = nil

	-- track combat 
	self.inCombat = false
	
	-- debugging
	self.debug = false
	
	-- class cache
	self.classCache = {}

	-- direction
	self.directionLabelIndex = nil
end

function Addon:SetupPlayer()
	_, self.playerClass = UnitClass("player")
	self.playerName     = UnitName("player")
	
	self.classCache[self.playerName] = self.playerClass
	
	if self.playerClass == "DRUID" or 
	   self.playerClass == "MONK" or
	   self.playerClass == "PRIEST" or
	   self.playerClass == "PALADIN" or 
	   self.playerClass == "SHAMAN" then 
		self.playerIsHealer = true
		self.healSpellName = classHealSpells[self.playerClass]
		self.rezSpellName  = classRezSpells[self.playerClass]
	end
end

function Addon:SetupEventHandlers()
	Options.RegisterCallback(self, ADDON .. "_SETTING_CHANGED", "UpdateSetting")	

	-- raid/party events
	self:RegisterEvent("PARTY_CONVERTED_TO_RAID", "UpdateRaidUnits")
	self:RegisterEvent("GROUP_ROSTER_UPDATE",     "UpdateRaidUnits")	

	-- register events to track combat
	self:RegisterEvent("PLAYER_REGEN_ENABLED",  "UpdateCombatState", false)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "UpdateCombatState", true)
end

function Addon:ResetEventHandlers()
	Options.UnregisterCallback(self, ADDON .. "_SETTING_CHANGED")	

	-- raid/party events
	self:UnregisterEvent("PARTY_CONVERTED_TO_RAID")
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")	
	
	-- unregister events to track combat
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
end

function Addon:SetupPingEventHandler(activate)
	if activate then
		self:RegisterEvent("MINIMAP_PING", "OnEventPing")
	else
		self:UnregisterEvent("MINIMAP_PING")
	end
end

function Addon:SetupDestinationEventHandler(destination, activate)
	if activate then
		if destination == "target" then
			self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateDestination")
		elseif destination == "focus" then
			self:RegisterEvent("PLAYER_FOCUS_CHANGED", "UpdateDestination")
		elseif destination == "mouseover" then
			-- unfortunately UPDATE_MOUSEOVER_UNIT only works to a distance of about 120 yards
			self:ActivateOnUpdate(true)
		elseif destination == "mouseoverclick" then
			self:ActivateOnUpdate(true)
		end
	else
		if destination == "target" then
			self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		elseif destination == "focus" then
			self:UnregisterEvent("PLAYER_FOCUS_CHANGED")
		elseif destination == "mouseover" then
			self:ActivateOnUpdate(false)
		elseif destination == "mouseoverclick" then
			self:ActivateOnUpdate(false)
		end
	end
end

-- update functions
function Addon:Refresh()
	CrazyArrow:Point()
end

function Addon:UpdateDirection()
	local facing = GetPlayerFacing()
	local i = floor(facing * CRAD)	
	
	if i ~= self.directionLabelIndex then
		self.directionLabelIndex = i
		
		self:UpdateLabel()
	end
	
	if self:GetSetting("Compass") then
		local xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR
		
		local cosDir = cos(facing)
		local sinDir = sin(facing)
		
		local gX = (sinDir + cosDir) * 0.5
		local gY = (sinDir - cosDir) * 0.5
		
		xUL = 0.5 - gX
		yUL = 0.5 + gY
		xLL = 0.5 + gY
		yLL = 0.5 + gX
		xUR = 0.5 - gY
		yUR = 0.5 - gX
		xLR = 0.5 + gX
		yLR = 0.5 - gY
		
		DataBroker:SetIconTexCoord(xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR)
		MinimapButton:SetIconTexCoord(xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR)		
	end
end

function Addon:UpdateLabel()
	local i = self.directionLabelIndex	
	local label = compass:sub((36-i)+1, (36-i)+11)
	
	if i == 5 then
		label = label:gsub("NW[-][-][-]N", "NW---" .. NORTH, 1)
	else
		label = label:gsub("N[-]", NORTH .. "-", 1)
	end

	DataBroker:SetText(NS:Colorize("White", label))	
end

function Addon:UpdateIcon()
	local icon = self:GetIcon()
	
	DataBroker:SetIcon(icon)
	MinimapButton:SetIcon(icon)
	
	if not self:GetSetting("Compass") then
		DataBroker:SetIconTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		MinimapButton:SetIconTexCoord(0, 0, 0, 1, 1, 0, 1, 1)			
	end
end

function Addon:GetIcon()
	local icon = ICON_DEFAULT
	
	if Options:GetSetting("Compass") then
		local selected = Options:GetSetting("Icon")
		
		if selected == "arrow" then
			icon = ICON_ARROW
		elseif selected == "compass" then
			icon = ICON_COMPASS
		end
	end
	
	return icon
end

-- settings
function Addon:UpdateSetting(event, setting, value, old)
	if setting == "MonitoringActive" then
		self:UpdateMonitoring()
		self:UpdateIcon()
		self:Update()	
	elseif setting == "TimePrecision" then
		self:Refresh()
	elseif setting == "RangePrecision" then
		self:Refresh()
	elseif setting == "Release" then
		self:Refresh()
	elseif setting == "Duration" then
		self:Refresh()
	elseif setting == "ArrivalRange" then
		self:Refresh()
	elseif setting == "RangeCheck" then
		self:Refresh()
	elseif setting == "ShowNoDest" then
		self:Refresh()
	elseif setting == "Destination" then
		self:SetupDestinationEventHandler(old, false)
		self:SetupDestinationEventHandler(value, true)
		
		self:UpdateDestination()
		
		self:Refresh()
	elseif setting == "Compass" then
		self:UpdateIcon()		
	elseif setting == "Icon" then
		self:UpdateIcon()
	elseif setting == "Ping" then
		self:SetupPingEventHandler(self:GetSetting("Ping"))
		self:Refresh() 
	elseif setting == "Minimap" then
		MinimapButton:SetShow(Options:GetSetting("Minimap"))
	end
end

function Addon:GetSetting(setting)
	return Options:GetSetting(setting)
end

function Addon:SetSetting(setting, value)
	return Options:SetSetting(setting, value)
end

-- event callbacks
function Addon:OnEventPing(event, unit) 
    self.pingerName = UnitName(unit)
	
    if not self.pingerName then 
		return
	end
	
	-- somebody else pinged and messed up our measurement
    if self.pingerName ~= self.playerName then 
		self.refPoint = nil
	end
	
	CrazyArrow:Ping()
end 

function Addon:UpdateZone(event, map, floor)
	self.refPoint = nil
end

function Addon:UpdateRaidUnits()
	NS:ClearTable(self.name2Unit)

	if IsInGroup() then
		if IsInRaid() then
			for i = 1, 40, 1 do
				local unit = "raid"..i
				local name = UnitName(unit)

				if name then
					self.name2Unit[name] = unit
					
					self:GetClass(name)
				end				
			end
		else
			for i = 1, 4, 1 do
				local unit = "party"..i
				local name = UnitName(unit)
				
				if name then
					self.name2Unit[name] = unit
					
					self:GetClass(name)
				end
			end
		end
	end

	self.name2Unit[self.playerName] = "player"
	
	self:SetDestination(self:GetRaidUnitByName(self.destinationName))
end

function Addon:UpdateDestination()
	self:Debug("UpdateDestination")
	if self.sticky then
		return
	end
	
	local unit = nil
	local click = IsMouseButtonDown(self:GetSetting("MouseButton"))

	self:Debug("UpdateDestination: click " .. tostring(click) .. " (" .. tostring(self:GetSetting("MouseButton")) .. ")")
	
	local destination = self:GetSetting("Destination")
	
	if destination == "target" or destination == "focus" then
		unit = destination
	elseif destination == "mouseover" or destination == "mouseoverclick" then
		if destination == "mouseover" or click then
			unit = self:GetMouseOverUnit()			
		end		
	end

	-- map unit to raid unit if possible
	if self:UnitIsValid(unit) then
		-- make sure the modificator keys are valid for mouse-over destination
		if destination == "mouseover" or destination == "mouseoverclick" then
			if not self:ValidMouseOverUnit(unit) then
				unit = nil
			end
		end
	else
		unit = nil
	end
		
	-- mouseover* refreshes OnUpdate, make sure we keep the work low
	if destination ~= "mouseoverclick" or click then
		local same = false
		if unit and self.destinationUnit then
			same = UnitIsUnit(unit, self.destinationUnit)
		else
			same = unit == self.destinationUnit
		end
		
		if not same then
			self:Debug("UpdateDestination: set " .. tostring(unit) .. " - " .. tostring(name))
			self:SetDestination(unit)
		end
	end
end

-- user functions
function Addon:SetDestination(unit, sticky)
	local name = unit and UnitName(unit) or nil
	
	unit = self:GetRaidUnitByName(name)
	
	if unit then
		self.destinationName = name
		self.destinationUnit = unit

		if sticky == nil then
			self:Refresh()
		else
			self:SetSticky(sticky)
		end
	else
		self:Release()
	end
end

function Addon:GetSticky()
	return self.sticky
end

function Addon:SetSticky(sticky)
	-- if there is no destination we don't make it sticky
	sticky = sticky and self.destinationUnit
	
	if sticky == self.sticky then
		return
	end
	
	self.sticky = sticky
	
	if not sticky then
		self:UpdateDestination()
	end
	
	self:Refresh()	
end

function Addon:ToggleSticky()
	self:SetSticky(not self:GetSticky())
end

function Addon:Release()
	self.destinationName = nil
	self.destinationUnit = nil
	self:SetSticky(false)

	CrazyArrow:Release()
end

function Addon:Ping()
    Minimap:PingLocation(0, 0)
end

function Addon:Measure()
    local map, floor, x, y = MapHandler:GetPlayerPosition()
	
	if x == nil or y == nil then
		self:Output(L["No map coordinates present for this instance! Aborting measurement."])
		return
	end
	
	self.refPoint = {}
	
	self.refPoint.map   = map
	self.refPoint.floor = floor
	self.refPoint.x     = x
	self.refPoint.y     = y
	
    self:Ping()
end

function Addon:SetWaypointOnUnit(unit)
	if not unit then
		unit = "player"
	end
	
	if not self:UnitIsValid(unit) then
		-- try to get unit by name
		unit = UnitName(self:GetRaidUnitByName(unit))		
	end
	
    local map, floor, x, y = MapHandler:GetUnitPosition(unit)
	
	self:SetWaypoint(map, floor, x, y)
end

function Addon:SetWaypoint(map, floor, x, y)
    self.waypoint["map"]   = map
	self.waypoint["floor"] = floor
	self.waypoint["x"]     = x
	self.waypoint["y"]     = y
	
	if MapHandler:ValidCoords(self.waypoint) then
		self:Refresh()
	else
		self:ClearWaypoint()
	end
end

function Addon:ClearWaypoint()
	NS:ClearTable(self.waypoint)

	self:Refresh()
end

function Addon:PrintVersionInfo()
    self:Output(L["Version"] .. " " .. NS:Colorize("White", GetAddOnMetadata(ADDON, "Version")))
end

-- auxillary functions	
function Addon:UnitIsValid(unit)
    return unit and (UnitInRaid(unit) or UnitInParty(unit) or UnitIsUnit(unit, "player"))
end

function Addon:GetRaidUnitByName(name)
	return self.name2Unit[name]
end

function Addon:ColorizeChar(name)
	local unit = self:GetRaidUnitByName(name)
	
	if unit then
		local class = self:GetClass(name)
		
		local colortable = _G["CUSTOM_CLASS_COLORS"] or _G["RAID_CLASS_COLORS"]
		local color = colortable[class] or GRAY
		return "|cff" .. string.format("%02x%02x%02x", color.r*255, color.g*255, color.b*255) .. name .. "|r"
	end
	
	return NS:Colorize("Red", name)
end

function Addon:GetClass(name)
	local class = self.classCache[name]
	
	if not class then
		local unit = self:GetRaidUnitByName(name)
		if unit and UnitIsPlayer(unit) or UnitIsFriend("player", unit) then
			_, class = UnitClass(unit)
			
			self.classCache[name] = class
		end
	end

	return class
end

function Addon:GetMouseOverUnit()
	local frame = GetMouseFocus()

	if frame then
		local unit = SecureButton_GetModifiedUnit(frame)
		
		if unit and self:UnitIsValid(unit) then
			return unit
		end
	end
	
	return nil
end

function Addon:UpdateCombatState(inCombat)
	if inCombat == nil then
		self.inCombat = InCombatLockdown()
	else
		self.inCombat = inCombat and true
	end
	
	self:Debug("UpdateCombatState: now " .. tostring(self.inCombat))
end

function Addon:InCombat()
	return self.inCombat
end

function Addon:ValidMouseOverUnit(unit)
	if not unit then
		return false
	end

	local alt   = IsAltKeyDown()
	local ctrl  = IsControlKeyDown()
	local shift = IsShiftKeyDown()

	-- check combat
	if self:InCombat() then
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("InCombat")) then
			return false
		end
	else
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("OutOfCombat")) then
			return false
		end
	end
	
	-- check alive
	if UnitIsDead(unit) then
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("WhenTargetDead")) then
			return false
		end
	else
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("WhenTargetAlive")) then
			return false
		end
	end
	
	-- check range
	if self:InHealRange(unit) then
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("InRange")) then
			return false
		end
	else
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("OutOfRange")) then
			return false
		end
	end
	
	-- check pet
	if UnitIsUnit(unit, "player") then
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("UnitIsPlayer")) then
			return false
		end
	-- check player
	elseif not UnitIsPlayer(unit) then
		if not ValidModificatorKeys(alt, ctrl, shift, self:GetSetting("UnitIsPet")) then
			return false
		end
	end
	
	return true
end

-- distance related functions
function Addon:ValidCoords(coords)
	return MapHandler:ValidCoords(coords)
end

function Addon:GetDistanceToDestination(outStatus)
	NS:ClearTable(targetCoords)
	
	if not self.sticky and self:GetSetting("Destination") == "waypoint" then
		targetCoords.map, targetCoords.floor, targetCoords.x, targetCoords.y = self.waypoint.map, self.waypoint.floor, self.waypoint.x, self.waypoint.y
	elseif self.destinationUnit then
		targetCoords.map, targetCoords.floor, targetCoords.x, targetCoords.y = MapHandler:GetUnitPosition(self.destinationUnit)
	end
	
	if MapHandler:ValidCoords(targetCoords) then
		NS:ClearTable(playerCoords)
		
		playerCoords.map, playerCoords.floor, playerCoords.x, playerCoords.y = MapHandler:GetPlayerPosition()
		
		return MapHandler:GetDistance(playerCoords, targetCoords, outStatus)
	else
		if type(outStatus) == "table" then
			outStatus.errorCode = self.INVALID_COORDS
		end
	end
	
	return
end

function Addon:GetDirectionToDestination(outStatus)
	local distance, dx, dy = self:GetDistanceToDestination(outStatus)
	local angle = MapHandler:GetViewAngle(dx, dy)
	
	return angle, distance
end

function Addon:GetDirectionToPing()
	local distance, dx, dy = MapHandler:GetDistanceToPing()
	local angle = MapHandler:GetViewAngle(dx, dy, true)
	
	return angle, distance
end

-- dist(travelled) = (coord_stop(minimap) - coord_start(minimap)) * dimension(minimap)
-- dimension(map)  = dist(travelled) / (coord_stop(map) - coord_start(map))
function Addon:CalculateMapSize()
    if not self.refPoint then 
		self:Output(L["No reference point set. Please retry measurement."])
		return
	end
	
	-- current minimap ping position 
	-- we started out at ping on self (0, 0) 
	-- distance in terms of minimap coords
    local dxMini, dyMini = Minimap:GetPingPosition()
	
    local _, _, x, y = self:GetPlayerPosition()
	
	-- distance in terms of global coords
    local dxGlob = self.refPoint.x - x
    local dyGlob = self.refPoint.y - y
	
    if dxMini == 0 and dyMini == 0 then 
        self:Output(L["No range calculation. You have to move first!"])
        return
    end
	
    local xDim, yDim
    local minimapsize = self:GetMinimapSize(Minimap:GetZoom())
	
	-- calculate map dimension
	-- we use the direction we travelled farther
	if abs(dxMini) > abs(dyMini) then
		xDim = abs((dxMini * minimapsize)/dxGlob) 
		-- adjust aspect ratio
		yDim = xDim / 1.5
	else
		yDim = abs((dyMini * minimapsize)/dyGlob)
		-- adjust aspect ratio
		xDim = yDim * 1.5
	end
	
	-- save calculated dimensions
	Options:SetZoneDimensions(self.refPoint.map, self.refPoint.floor, xDim, yDim)
	
	self:Output(string.format(L["Map dimensions stored for %s[%i]: x, y = %f, %f"], self.refPoint.map, self.refPoint.floor, xDim, yDim) )
	
	-- reset reference point
	self.refPoint = nil
end

function Addon:InHealRange(target)
    if not self:GetSetting("RangeCheck") or not self.playerIsHealer then 
		return true
	end
	
    local spellName = self.healSpellName
	
    if UnitIsDead(target) then 
		spellName = self.rezSpellName
	end
	
    if IsSpellInRange(spellName, target) == 1 then 
		return true
    else 
		return false
    end
end

-- utilities
function Addon:Output(msg)
	if (msg ~= nil and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage( self.MODNAME..": "..msg, 0.6, 1.0, 1.0 )
	end
end

-- testing
function Addon:Debug(msg)
	if ( self.debug and msg ~= nil and DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage( self.MODNAME .. " (dbg): " .. msg, 1.0, 0.37, 0.37 )
	end
end

function Addon:PrintStatus()
	self:Output("Map: " .. tostring(MapHandler.actMap))
	self:Output("Floor: " .. tostring(MapHandler.dungeonLvl))
	self:Output("Indoors: " .. tostring(MapHandler.GetIndoors()))
	self:Output("Target Type: " .. tostring(L[self:GetSetting("Destination")]))
	self:Output("Destination name: " .. tostring(self.destinationName))
	self:Output("Destination unit: " .. tostring(self.destinationUnit))
	
	local plC = {}
	plC.map, plC.floor, plC.x, plC.y = self:GetPlayerPosition()
	
	local tarC = {}
	
	if self:GetSetting("Destination") == "waypoint" then
		tarC = self.waypoint
	elseif self.destinationUnit ~= nil then
		tarC.map, tarC.floor, tarC.x, tarC.y = MapHandler:GetUnitPosition(self.destinationUnit)
	end
	
	local pValid = MapHandler:ValidCoords(plC)
	local tValid = MapHandler:ValidCoords(tarC)
	
	self:Output("Player location valid: " .. tostring(pValid))
	self:Output("Target location valid: " .. tostring(tValid))

	if pValid then
		self:Output("Player location: " .. tostring(plC.map) .. "/" .. tostring(plC.floor) .. "/" .. tostring(plC.x) .. "/" .. tostring(plC.y))
	end
	if tValid then
		self:Output("Target location: " .. tostring(tarC.map) .. "/" .. tostring(tarC.floor) .. "/" .. tostring(tarC.x) .. "/" .. tostring(tarC.y))
	end

	local realdist, dx, dy = 0, 0, 0
	if pValid and tValid and MapHandler:AreIdenticalCoords(plC, tarC) then
		self:Output("Identical coords.")
	else
		local pAvailable = pValid and MapHandler:MapAvailable(plC.map, plC.floor)
		local tAvailable = tValid and MapHandler:MapAvailable(tarC.map, tarC.floor)
		
		local sameFloor = pValid and tValid and MapHandler:IsOnSameFloor(plC, tarC)
		
		local pMeasured = pValid and MapHandler:MeasurementDataAvailable(plC.map, plC.floor)
		local tMeasured = tValid and MapHandler:MeasurementDataAvailable(tarC.map, tarC.floor)
	
		self:Output("Player coord available: " .. tostring(pAvailable))
		self:Output("Target coord available: " .. tostring(tAvailable))
		self:Output("Same floor: " .. tostring(sameFloor))
		self:Output("Player measurements available: " .. tostring(pMeasured))
		self:Output("Target measurements available: " .. tostring(tMeasured))
	
		if pAvailable and tAvailable then
			if MapHandler:CanComputeDistance(plC, tarC) then
				realdist, dx, dy = MapHandler:GetDistanceLibrary(plC, tarC)
				
				self:Output("Distance (measured data): " .. tostring(realdist) .. " (" .. tostring(dx) .. "/" .. tostring(dy) .. ")")
			else
				self:Output("No path.")
			end
		elseif sameFloor and pMeasured and tMeasured then
			realdist, dx, dy = MapHandler:GetDistanceMeasured(plC, tarC)
			
			self:Output("Distance (measured data): " .. tostring(realdist) .. " (" .. tostring(dx) .. "/" .. tostring(dy) .. ")")
		else
			self:Output("Missing map data.")
		end
	end
end
