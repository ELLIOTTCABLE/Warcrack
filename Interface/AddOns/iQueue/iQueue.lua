-----------------------------------
-- Setting up scope and libs
-----------------------------------

local AddonName, iQueue = ...;
LibStub("AceEvent-3.0"):Embed(iQueue);
LibStub("AceTimer-3.0"):Embed(iQueue);

local L = LibStub("AceLocale-3.0"):GetLocale(AddonName);

local LibCrayon = LibStub("LibCrayon-3.0");

local _G = _G;

-------------------------------
-- Registering with iLib
-------------------------------

LibStub("iLib"):Register(AddonName, nil, iQueue);

-----------------------------------------
-- Variables, functions and colors
-----------------------------------------

local EyeTimer; -- the timer for our animated eyeball

local COLOR_GOLD = "|cfffed100%s|r";
local COLOR_RED  = "|cffff0000%s|r";
local COLOR_GREEN= "|cff00ff00%s|r";
local COLOR_YELLOW= "|cffffff00%s|r";
local COLOR_GREY = "|cffaaaaaa%s|r";

local STATUS_NONE = 0; -- set if queue isn't active
local STATUS_PAUSED = 1; -- WG/TB: Queue available, all others: paused
local STATUS_QUEUED = 2; -- set if queued
local STATUS_PROPOSAL = 3; -- set if invite is pending
local STATUS_ACTIVE = 4; -- set if in assembled group

local QUEUE_LFG 		= _G.LE_LFG_CATEGORY_LFD; -- ID for lfg dungeons used by Blizzard
local QUEUE_RF  		= _G.LE_LFG_CATEGORY_RF; -- ID for raid finder used by Blizzard
local QUEUE_SCE 		= _G.LE_LFG_CATEGORY_SCENARIO; -- ID for scenarios used by Blizzard
local QUEUE_LFR 		= _G.LE_LFG_CATEGORY_LFR; -- ID for LFR used by Blizzard
local QUEUE_PET			= _G.NUM_LE_LFG_CATEGORYS +1; -- virtual queue ID for pet battles
local QUEUE_PVP 		= _G.NUM_LE_LFG_CATEGORYS +2; -- virtual queue ID for PvP queues, set by me (should be 5)
local QUEUE_WG			= QUEUE_PVP +1; -- queue ID for Wintergrasp (should be 6)
local QUEUE_TB			= QUEUE_PVP +2; -- queue ID for Tol Barad (should be 7)

local Queues = { -- Stores a status for each queue category, defaults to STATUS_NONE
	[QUEUE_LFG] = STATUS_NONE,
	[QUEUE_RF]  = STATUS_NONE,
	[QUEUE_SCE] = STATUS_NONE,
	[QUEUE_LFR] = STATUS_NONE,
	[QUEUE_PET] = STATUS_NONE,
	[QUEUE_PVP] = STATUS_NONE,
	[QUEUE_WG]  = STATUS_NONE,
	[QUEUE_TB]	= STATUS_NONE,
};

-----------------------------
-- Setting up the LDB
-----------------------------

iQueue.ldb = LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
	type = "data source",
	text = "",
});

iQueue.ldb.OnClick = function(anchor, button)
	-- left click
	if( button == "LeftButton" ) then
		-- on CTRL/ALT/Shift pressed
		if( _G.IsModifierKeyDown() ) then
			-- Shift + Left opens LFD frame
			if( _G.IsShiftKeyDown() ) then
				_G.ToggleLFDParentFrame();
			end
		else
			-- no modifier pressed, but if not queued, no action is done
			--if( not iQueue:IsQueued() ) then
			--	return;
			--end
		end
	-- right click
	elseif( button == "RightButton" ) then
		-- on CTRL/ALT/Shift pressed
		if( _G.IsModifierKeyDown() ) then
			-- Shift + Right opens PVP frame
			if( _G.IsShiftKeyDown() ) then
				_G.TogglePVPFrame();
			end
		else
			-- no modifier pressed, open options
			iQueue:OpenOptions();
		end
	end
end

iQueue.ldb.OnEnter = function(anchor)
	-- does not show mouseover tooltip when not queued (or just available queue) or if Blizzard tooltip is visible
	local queued, paused = iQueue:IsQueued();
	if( not queued or iQueue:IsTooltip("Main") ) then --_G["DropDownList1"]:IsVisible() ) then
		return;
	end
	
	-- the mouse over tooltip (Blizzard UI element) needs to be attached to Broker plugin
	--if( _G.QueueStatusFrame:GetParent() ~= anchor ) then
	--	_G.QueueStatusFrame:ClearAllPoints();
	--	_G.QueueStatusFrame:SetParent(anchor);
	--	_G.QueueStatusFrame:SetClampedToScreen(true);
	--	_G.QueueStatusFrame:SetPoint("TOP", anchor, "TOP", 14, -anchor:GetHeight());
	--end
	
	_G.QueueStatusFrame:Show();
end

iQueue.ldb.OnLeave = function(anchor)
	_G.QueueStatusFrame:Hide();
end

------------------------------------------
-- OnInitialize and Reset
------------------------------------------

function iQueue:Boot()
	self.db = LibStub("AceDB-3.0"):New("iQueueDB", self:CreateDB(), "Default").profile;
	
	--_G.QueueStatusMinimapButton.Show = _G.QueueStatusMinimapButton.Hide;
	--_G.QueueStatusMinimapButton:Hide();
	
	-- All
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "EventHandler"); -- when leaving a battlefield, no event is fired. So we check the group.
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "EventHandler"); -- need for loot rolling detection and world pvp areas
	self:RegisterEvent("ZONE_CHANGED", "EventHandler"); -- need for loot rolling detection and world pvp areas
	
	-- PvE
	self:RegisterEvent("LFG_UPDATE", "EventHandler");
	self:RegisterEvent("LFG_PROPOSAL_UPDATE", "EventHandler");
	self:RegisterEvent("LFG_PROPOSAL_FAILED", "EventHandler");
	self:RegisterEvent("LFG_PROPOSAL_SUCCEEDED", "EventHandler");
	self:RegisterEvent("LFG_PROPOSAL_SHOW", "EventHandler");
	self:RegisterEvent("LFG_QUEUE_STATUS_UPDATE", "EventHandler");
	
	-- PvP
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS", "EventHandler");
	
	-- Pet Battles
	self:RegisterEvent("PET_BATTLE_QUEUE_STATUS", "EventHandler");
	
	-- World PvP
	self:WatchWorldPvP(); -- toggles World PvP Area events, depending on the World PvP options
	
	self:DungeonComplete(); -- toggles LFG_COMPLETION_REWARD event, depending on the LeaveDungeon option
	self:EventHandler("SELF_BOOT");
end
iQueue:RegisterEvent("PLAYER_ENTERING_WORLD", "Boot");

---------------------------
-- Event Handler
---------------------------

function iQueue:EventHandler(event)
	-- see _DungeonComplete function. If the player leaves the group before the loot roll has ended, we need to reset it manually
	-- We determine leaving the group by a simple zone change :)
	if( event == "ZONE_CHANGED" and self.WatchLootRoll ) then
		self:_DungeonComplete("reset");
	end
	
	local mode, submode;

	-- check PvE queues
	for i = 1, _G.NUM_LE_LFG_CATEGORYS do
		mode, submode = _G.GetLFGMode(i);
		
		if( not mode or mode == "abandonedInDungeon" ) then
			Queues[i] = STATUS_NONE;
			if( self["Queue"..i.."Current"] or self["Queue"..i.."Total"] ) then
				self["Queue"..i.."Current"] = nil;
				self["Queue"..i.."Total"] = nil;
			end
		elseif( mode == "suspended" ) then
			Queues[i] = STATUS_PAUSED;
		else			
			if( mode == "lfgparty" ) then
				Queues[i] = STATUS_ACTIVE;
			elseif( mode == "proposal" ) then
				Queues[i] = STATUS_PROPOSAL;
			elseif( mode == "queued" ) then
				Queues[i] = STATUS_QUEUED;
				
				local hasData, _, tankNeed, healNeed, dpsNeed, tankTotal, healTotal, dpsTotal = _G.GetLFGQueueStats(i);
				local current, total;
				
				if( hasData ) then
					total = tankTotal + healTotal + dpsTotal;
					current = total - (tankNeed + healNeed + dpsNeed);
					self["Queue"..i.."Current"] = current - 1; -- we sub the player from the needs, because he is always marked as "found"
					self["Queue"..i.."Total"] = total - 1; -- we sub the player from the totals, see comment above
				end
			end
		end
	end
	
	-- check PvP queues
	
	-- There are one or two PvP queues available.
	-- 1 queue if queueing for random BGs, 2 queues if queueing for specified BGs
	-- We simply reset the PvP queue status and run our checks. This is a really clean way without declaring 1-2 helper vars.
	Queues[QUEUE_PVP] = STATUS_NONE;
	for i = 1, _G.GetMaxBattlefieldID() do
		--local status, mapName, instanceID, levelRangeMin, levelRangeMax, teamSize, registeredMatch, eligibleInQueue, waitingOnOtherActivity = GetBattlefieldStatus(i);
		local status = _G.GetBattlefieldStatus(i);
		
		if( status and status ~= "none" and status ~= "error" ) then
			if( status == "active" ) then
				status = STATUS_ACTIVE;
			elseif( status == "confirm" ) then
				status = STATUS_PROPOSAL;
			elseif( status == "queued" ) then
				status = STATUS_QUEUED;
			end
			
			-- Because of 2 queues possible and just 1 PvP display, we store the "higher" queue status
			Queues[QUEUE_PVP] = status > Queues[QUEUE_PVP] and status or Queues[QUEUE_PVP];
		end
	end
	
	-- check pet battles
	mode = _G.C_PetBattles.GetPVPMatchmakingInfo();
	if( mode == "queued" ) then
		Queues[QUEUE_PET] = STATUS_QUEUED;
	elseif( mode == "suspended" ) then
		Queues[QUEUE_PET] = STATUS_PAUSED;
	elseif( mode == "proposal" ) then
		Queues[QUEUE_PET] = STATUS_PROPOSAL;
	elseif( mode == "entry" ) then
		Queues[QUEUE_PET] = STATUS_ACTIVE;
	else
		Queues[QUEUE_PET] = STATUS_NONE
	end
	
	-- check World PvP queues
	if( self.db.WatchWorldPvP ) then
		for area = 1, _G.GetNumWorldPVPAreas() do
			local _, locName = _G.GetWorldPVPAreaInfo(area);
			
			local queued = false;
			local mapName, status;
			
			-- The only way to identify a queued World PvP Area is to check its localized map name (e.g. Tol Barad)
			-- Why? Well, I hardcoded WG/TB queue IDs (6 and 7), but GetWorldPVPQueueStatus() may also return TB as ID 1 (= 6 in iQueue, which is WG!)
			for queue = 1, _G.MAX_WORLD_PVP_QUEUES do
				status, mapName = _G.GetWorldPVPQueueStatus(queue);
				if( mapName == locName ) then
					queued = true;
					break;
				end
			end
			
			local newStatus;
			
			-- this is our transporter variable. If it is set, the queue is active!
			if( self["WorldPvP"..locName] ) then
				newStatus = STATUS_PAUSED;
			else
				newStatus = STATUS_NONE;
			end
			
			-- if we identified the queue, we store the queue status for it.
			if( queued ) then
				if( _G.GetRealZoneText() == locName ) then -- World PvP Areas have no "active" state in the Blizzard API, so we emulate it.
					newStatus = STATUS_ACTIVE; -- iQueue assumes that you are playing a World PvP Area, if you are in the area.
				elseif( status == "confirm" ) then
					newStatus = STATUS_PROPOSAL;
				elseif( status == "queued" ) then
					newStatus = STATUS_QUEUED;
				end
			end
			
			Queues[QUEUE_PVP +area] = newStatus;
		end
	end
		
	self:UpdateBroker(); -- simply display our changes
end

----------------------
-- Animated Eye
----------------------

local path = "Interface\\Addons\\iQueue\\Images\\eye";
function iQueue:AnimateEye(state)
	if( state ) then
		self.animEye = self.animEye and self.animEye + 1 or 25;
		self.animEye = self.animEye > 28 and 1 or self.animEye;
		
		self.ldb.icon = path..self.animEye;
		
		if( not EyeTimer ) then
			EyeTimer = self:ScheduleRepeatingTimer("AnimateEye", 0.15, true);
		end
	else
		self.animEye = nil;
		
		self.ldb.icon = path..(state == false and "1" or "off");
		
		if( EyeTimer ) then
			self:CancelTimer(EyeTimer);
			EyeTimer = nil;
		end
	end
end

--------------------------
-- Dungeon Complete
--------------------------

function iQueue:DungeonComplete()
	if( self.db.LeaveDungeonWhenFinished ) then
		self:RegisterEvent("LFG_COMPLETION_REWARD", "_DungeonComplete");
	else
		self:UnregisterEvent("LFG_COMPLETION_REWARD");
	end
end

function iQueue:_DungeonComplete(event, ...)
	-- the dungeon is cleared and the loot roll starts soon
	if( event == "LFG_COMPLETION_REWARD") then
		self:RegisterEvent("START_LOOT_ROLL", "_DungeonComplete");
	-- the loot roll takes place, we store the number of maximum items dropped by the boss
	elseif( event == "START_LOOT_ROLL" ) then
		self.WatchLootRoll = select(1, ...);
		self:RegisterEvent("CHAT_MSG_LOOT", "_DungeonComplete");
	-- loot gets assigned to players
	elseif( event == "CHAT_MSG_LOOT") then
		local looting;
		for i = 1, self.WatchLootRoll do
			if( _G.GetLootRollItemInfo(i) ) then
				looting = 1; -- one or more items are still rolled
			end
		end
		
		-- when rolling has finished, we fire a message to the player or auto-leave him, depending on the options
		if( not looting ) then
			self:_DungeonComplete("reset");
			
			if( self.db.LeaveDungeonAction == 1 ) then
				_G.StaticPopup_Show("IQUEUE_DUNGEONEND");
			else
				_G.LeaveParty();
			end
		end
	-- simply refactoring of code by using a dummy event: we need this snippet twice
	elseif( event == "reset" ) then
		self:UnregisterEvent("CHAT_MSG_LOOT");
		self:UnregisterEvent("START_LOOT_ROLL");
		self.WatchLootRoll = nil;
	end
end

-----------------------
-- WatchWorldPvP
-----------------------

function iQueue:WatchWorldPvP()
	-- if World PvP Areas should be watched, we need to register some events...
	if( self.db.WatchWorldPvP ) then
		if( not self.WorldPvPEventsRegistered ) then
			self:RegisterEvent("BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE", "EventHandler");
			self:RegisterEvent("BATTLEFIELD_MGR_EJECT_PENDING", "EventHandler");
			self:RegisterEvent("BATTLEFIELD_MGR_EJECTED", "EventHandler");
			self:RegisterEvent("BATTLEFIELD_MGR_QUEUE_INVITE", "EventHandler");
			self:RegisterEvent("BATTLEFIELD_MGR_ENTRY_INVITE", "EventHandler");
			self:RegisterEvent("BATTLEFIELD_MGR_ENTERED", "EventHandler");
			self.WorldPvPEventsRegistered = 1;
		end
		
		-- ...and if iQueue shall tell the player when to queue for WG/TB, we need to register a timer
		if( self.db.WorldPvPTimer and not self.WorldPvPTimer ) then
			self:CheckWorldPvPStatus();
			self.WorldPvPTimer = self:ScheduleRepeatingTimer("CheckWorldPvPStatus", 30);
		end
	-- ...if watching isn't enabled, we check if we need to unregister the events
	else
		if( self.WorldPvPEventsRegistered ) then
			self:UnregisterEvent("BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE");
			self:UnregisterEvent("BATTLEFIELD_MGR_EJECT_PENDING");
			self:UnregisterEvent("BATTLEFIELD_MGR_EJECTED");
			self:UnregisterEvent("BATTLEFIELD_MGR_QUEUE_INVITE");
			self:UnregisterEvent("BATTLEFIELD_MGR_ENTRY_INVITE");
			self:UnregisterEvent("BATTLEFIELD_MGR_ENTERED");
			self.WorldPvPEventsRegistered = nil;
		end
		
		-- ...and the timer
		if( self.WorldPvPTimer ) then
			self:CancelTimer(self.WorldPvPTimer);
			self.WorldPvPTimer = nil;
		end
		
		-- finally, all World PvP Areas queues are set to STATUS_NONE
		for i = QUEUE_PVP, #Queues do
			Queues[i] = STATUS_NONE;
		end
	end
	
	self:EventHandler("SELF_WORLD_PVP_CHECK"); -- run the EventHandler to clear out remaining data
end

local function check_world_pvp_alert(index)
	local pvpID, locName, isActive, canQueue, startTime, canEnter = _G.GetWorldPVPAreaInfo(index);
	
	if( canEnter and startTime ~= 0 ) then -- if the player cannot enter the World PvP Area, we don't check it
		if( isActive or canQueue or startTime <= 900 ) then
			iQueue["WorldPvP"..locName] = 1; -- I don't wanna set the queue status here, so we set a transporter variable
			iQueue:EventHandler(iQueue, "SELF_WORLD_PVP_QUEUE_OPEN");
			
			-- remembers the player to queue for the World PvP Area
			if( (time() - iQueue.db.WorldPvPLastAlert[index]) >= 3600 ) then
				_G.StaticPopupDialogs["IQUEUE_WORLDPVPALARM"].text = (L["Queue for %s has opened!"]):format(locName);
				_G.StaticPopup_Show("IQUEUE_WORLDPVPALARM");
				iQueue.db.WorldPvPLastAlert[index] = time(); -- we just want this popup once
			end
		else
			iQueue["WorldPvP"..locName] = nil; -- if the queue isn't active (anymore), the transporter variable is cleared
		end
	end
end

function iQueue:CheckWorldPvPStatus()
	for i = 1, 2 do -- 1 WG, 2 TB
		if( self.db.WorldPvPPopup == 2 or self.db.WorldPvPPopup == (2 + i) ) then
			check_world_pvp_alert(i);
		end
	end
end

----------------------
-- UpdateBroker
----------------------

function iQueue:IsQueued() -- returns 1 if queued somewhere (2 if just available queue), nil otherwise
	local answer, paused = false, false;
	
	for i, v in ipairs(Queues) do
		if( v > STATUS_PAUSED ) then
			answer = true;
		elseif( v == STATUS_PAUSED ) then
			paused = true;
		end
	end
	
	return answer, paused;
end

local function get_queue_name(queue)
	-- simply gets an abbreviation for the queue (e.g. Looking for Dungeon = LFG)
	if    ( queue == QUEUE_LFG ) then return L["LFG"]
	elseif( queue == QUEUE_RF  ) then return L["RF"]
	elseif( queue == QUEUE_SCE ) then return L["SCE"]
	elseif( queue == QUEUE_LFR ) then return L["LFR"]
	elseif( queue == QUEUE_PET ) then return "PET"
	elseif( queue == QUEUE_PVP ) then return _G.PVP
	elseif( queue  > QUEUE_PVP ) then -- uhhh... hard coding sucks -.-
		if(     (queue - QUEUE_PVP) == 1 ) then return L["WG"]
		elseif( (queue - QUEUE_PVP) == 2 ) then return L["TB"]
		end
	else
		return _G.UNKNOWN; -- should NEVER happen!
	end
end

function iQueue:UpdateBroker()
	-- by default, iQueue assumes that no queues are active
	local text = "";
	
	local queued, paused = self:IsQueued();
	local name, color, active;
	
	-- if at least one queue is active, we loop thru our Queues table
	if( queued or paused ) then		
		for q, v in ipairs(Queues) do
			-- the queue status must be ~= STATUS_NONE in order to display a queue
			if( v ~= STATUS_NONE ) then
				name = get_queue_name(q);
				
				-- colorizing the queue name abbreviation
				if( v == STATUS_QUEUED ) then
					if( self["Queue"..q.."Current"] and self["Queue"..q.."Total"] ) then
						color = "|cff"..LibCrayon:GetThresholdHexColor(self["Queue"..q.."Current"], self["Queue"..q.."Total"]*2).."%s|r";
					else
						color = COLOR_RED;
					end
				elseif( v == STATUS_PROPOSAL ) then
					color = COLOR_YELLOW;
				elseif( v == STATUS_ACTIVE ) then
					color = COLOR_GREEN;
					active = true;
				elseif( v == STATUS_PAUSED ) then
					color = COLOR_GREY;
				end
				
				-- finally displaying it
				text = text.." "..(color):format(name);
			end
		end
		
		if( queued ) then
			self:AnimateEye(not active);
		end
	end
	
	if( not queued ) then
		self:AnimateEye();
	end
	
	self.ldb.text = text;
end

---------------------
-- Final stuff
---------------------

_G.StaticPopupDialogs["IQUEUE_WORLDPVPALARM"] = {
	preferredIndex = 3, -- apparently avoids some UI taint
	button1 = _G.OKAY,
	button2 = _G.CANCEL,
	timeout = 900,
	whileDead = true,
	hideOnEscape = true,
	OnAccept = function(self)
		_G.TogglePVPFrame();
	end,
};

_G.StaticPopupDialogs["IQUEUE_DUNGEONEND"] = {
	preferredIndex = 3, -- apparently avoids some UI taint
	text = L["The dungeon is cleared and loot is assigned to players. Leave group?"],
	button1 = _G.YES,
	button2 = _G.NO,
	timeout = 900,
	whileDead = true,
	hideOnEscape = true,
	OnAccept = function(self)
		_G.LeaveParty();
	end,
};