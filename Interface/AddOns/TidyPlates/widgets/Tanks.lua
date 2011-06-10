	
	
	
------------------------------
-- Target Tracker
------------------------------

local TrackedUnits = {}
local TrackedUnitTargets = {}
local TrackedUnitTargetHistory = {}
local TargetWatcher

local function TargetWatcherEvents()
	local widget, plate
	local target, unitid, guid
	local changes = false
	wipe(TrackedUnits)
	
	-- Store target history
	for guid, target in pairs(TrackedUnitTargets) do
		TrackedUnitTargetHistory[guid] = target
		TrackedUnitTargets[guid] = nil
	end
	
	-- Reset the Tracking List
	for guid in pairs(TrackedUnits) do TrackedUnits[guid] = nil end
	
	-- Build a list of Trackable targets (via target, focus, and raid members)
	guid = UnitGUID("target")
	if guid then TrackedUnits[guid] = "target" end

	guid = UnitGUID("focus")
	if guid then TrackedUnits[guid] = "focus" end
	
	local raidsize = GetNumRaidMembers() - 1
	for index = 1, raidsize do
		unitid = "raid"..index.."target"
		guid = UnitGUID(unitid)
		if guid then TrackedUnits[guid] = unitid end
	end
	
	-- Build a list of the target's targets and check for changes
	for guid, unitid in pairs(TrackedUnits) do
		if unitid then 
			TrackedUnitTargets[guid] = UnitName(unitid.."target")
			if TrackedUnitTargets[guid] ~= TrackedUnitTargetHistory[guid] then changes = true end
		end
	end
	
	-- Call for indicator Update, if needed
	if changes then 
		TidyPlates:Update()			-- To Do: Make a better update hook: either update specific GUIDs or update only indicators
	end
end


---------------
-- Tank Monitor
---------------
local TankNames = {}
local TankWatcher

local function IsTankedByAnotherTank(unit)
	local targetOf
	if unit.guid then
		if unit.isTarget then targetOf = UnitName("targettarget")				-- Nameplate is a target
		elseif unit.isMouseover then targetOf = UnitName("mouseovertarget")		-- Nameplate is a mouseover
		else targetOf = TrackedUnitTargets[unit.guid] end
		
		if targetOf and TankNames[targetOf] then return true end
	end
	return false
end

local function TankWatcherEvents()
	local index, size
	if UnitInRaid("player") then
		size = GetNumRaidMembers() - 1
		for index = 1, size do
			local raidid = "raid"..tostring(index)
			
			local isAssigned = GetPartyAssignment("MAINTANK", raidid) or ("TANK" == UnitGroupRolesAssigned(raidid))
			
			if isAssigned then TankNames[UnitName(raidid)] = true 
			else TankNames[UnitName(raidid)] = nil end
		end			
	else 
		wipe(TankNames)
		if HasPetUI("player") and UnitName("pet") then 
			TankNames[UnitName("pet")] = true  			-- Adds your pet to the list (for you, only)
		end	
	end	
end
	

local function EnableTankWatch()
	if not TargetWatcher then TargetWatcher = CreateFrame("Frame") end
	TargetWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
	TargetWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
	TargetWatcher:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetWatcher:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	TargetWatcher:RegisterEvent("UNIT_TARGET")
	TargetWatcher:SetScript("OnEvent", TargetWatcherEvents)
	TargetWatcherEvents()
	
	if not TankWatcher then TankWatcher = CreateFrame("Frame") end
	TankWatcher:RegisterEvent("RAID_ROSTER_UPDATE")
	TankWatcher:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TankWatcher:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	TankWatcher:SetScript("OnEvent", TankWatcherEvents)
	TankWatcherEvents()
end

local function DisableTankWatch() 
	if TargetWatcher then
		TargetWatcher:SetScript("OnEvent", nil)
		TargetWatcher:UnregisterAllEvents()
		TargetWatcher = nil
	end
	
	if TankWatcher then
		TankWatcher:SetScript("OnEvent", nil)
		TankWatcher:UnregisterAllEvents()
		TankWatcher = nil
	end
end

TidyPlatesWidgets.EnableTankWatch = EnableTankWatch
TidyPlatesWidgets.DisableTankWatch = DisableTankWatch
TidyPlatesWidgets.IsTankedByAnotherTank = IsTankedByAnotherTank
	
	