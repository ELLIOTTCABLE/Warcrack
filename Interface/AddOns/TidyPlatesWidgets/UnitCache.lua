
TidyPlatesData.UnitDescriptions = TidyPlatesData.UnitDescriptions or {}
TidyPlatesData.UnitGuild = TidyPlatesData.UnitGuild or {}
TidyPlatesData.UnitClass = TidyPlatesData.UnitClass or {}
TidyPlatesData.Friends = TidyPlatesData.Friends or {}
TidyPlatesData.Guild = TidyPlatesData.Guild or {}

--/run print("?", TidyPlatesData); for i,v in pairs(TidyPlatesData) do print(i,v); if type(v) == 'table' then for x,y in pairs(v) do print(x,y) end end end
--/run wipe(TidyPlatesData.UnitClass)

local UnitCacheMonitor
local UnitCacheMonitorEvents = {}
local _
local myRealm = GetRealmName("player")
local inInstance

local function UpdateGuildCache()
	if TidyPlatesData.Guild then 
		TidyPlatesData.Guild = wipe(TidyPlatesData.Guild)
	else
		TidyPlatesData.Guild = {} 
	end
	-- Blah blah blah
	local guildname = GetGuildInfo("player")
	if not guildname then return end
	local numGuildMembers, numOnline = GetNumGuildMembers()
	for index = 1, numGuildMembers do
		local name, rank, rankIndex, level, class = GetGuildRosterInfo(index)
		TidyPlatesData.Guild[name] = true
		TidyPlatesData.UnitClass[name] = class
		TidyPlatesData.UnitGuild[name] = guildname
	end
end

-- [[
local function UpdateCacheByZone(zone)
	-- /run TidyPlatesUtility.UpdateCacheByZone("Stormwind")
	SendWho(zone or GetZoneText())
end


local function UpdateCacheByCharacterName(character)
	-- /run SendWho("Binbwen"); print(GetWhoInfo(1)); print(GetWhoInfo(2))
	SendWho(character)
	
	local name, guild, level, race, class = GetWhoInfo(1)

	--print(name, guild, level, race, class)
	if character == name then
		TidyPlatesData.UnitClass[name] = class
		TidyPlatesData.UnitGuild[name] = guild
	end
end
--]]

local function UpdateFriendCache()
	if TidyPlatesData.Friends then 
		TidyPlatesData.Friends = wipe(TidyPlatesData.Friends)
	else
		TidyPlatesData.Friends = {} 
	end
	--
	local numFriends = GetNumFriends()
	for index = 1, numFriends do
		local name, level, class = GetFriendInfo(index)
		if name then TidyPlatesData.Friends[name] = true end
	end
end

local InstanceTypes = {
	["none"] = 1,
	["party"] = 2,
	["raid"] = 2,
	["arena"] = 3,
	["pvp"] = 3,
}

function UnitCacheMonitorEvents.WHO_LIST_UPDATE()
	local name, guild, level, race, class, zone, localClass

	for i = 1, GetNumWhoResults() do
		name, guild, level, race, localClass, zone, class	= GetWhoInfo(i)
		-- Check for alterations
		if TidyPlatesData.UnitGuild[name] ~= guild or TidyPlatesData.UnitClass[name] ~= class then 
			unitadded = true 
			TidyPlatesData.UnitClass[name] = class
			TidyPlatesData.UnitGuild[name] = guild
		end
	end
	
	if unitadded then TidyPlates:RequestDelegateUpdate() end
end


function UnitCacheMonitorEvents.PLAYER_ENTERING_WORLD()
	local _, itype = GetInstanceInfo()
	if itype and itype ~= "none" then inInstance = true else inInstance = false end		
end

function UnitCacheMonitorEvents.UPDATE_MOUSEOVER_UNIT(self, ...)
	-- Bypass caching while in an instance
	if inInstance then return end
	
	-- Vars
	local name, class, level, realm, description, _, unitadded
	
	-- Player
	------------------------------------
	if UnitIsPlayer( "mouseover" ) then
		realm = GetRealmName("mouseover")		
		if myRealm ~= realm then return end		-- Don't cache folks from other servers
		
		name = UnitName("mouseover")
		description = GetGuildInfo("mouseover")
		_, class = UnitClass("mouseover")
		
		-- Check for alterations
		if TidyPlatesData.UnitGuild[name] ~= description or TidyPlatesData.UnitClass[name] ~= class then 
			unitadded = true 
			TidyPlatesData.UnitClass[name] = class
			TidyPlatesData.UnitGuild[name] = description
		end
		
	-- NPC
	------------------------------------
	elseif GameTooltipTextLeft1:GetText() == UnitName("mouseover") then
		name = GameTooltipTextLeft1:GetText()
		description = GameTooltipTextLeft2:GetText()
		if description then
			_, level = strsplit( " ", description )
			if tonumber(level) or level == "??" then
				description = nil
			end
		end
		
		if TidyPlatesData.UnitDescriptions[name] ~= description then 
			unitadded = true 
			TidyPlatesData.UnitDescriptions[name] = description
		end
		
	end

	if unitadded then TidyPlates:RequestDelegateUpdate() end
end

function UnitCacheMonitorEvents.GUILD_ROSTER_UPDATE(self, ...)
	UpdateGuildCache()
	TidyPlates:RequestDelegateUpdate()
end

function UnitCacheMonitorEvents.FRIENDLIST_UPDATE(self, ...)
	UpdateFriendCache()
	TidyPlates:RequestDelegateUpdate()
end

local function OnEvent(frame, event, ...)
	UnitCacheMonitorEvents[event](...)
end

local function Enable()
	if not UnitCacheMonitor then UnitCacheMonitor = CreateFrame("Frame") end
	for event in pairs(UnitCacheMonitorEvents) do UnitCacheMonitor:RegisterEvent(event) end
	UnitCacheMonitor:SetScript("OnEvent", OnEvent)
	
	if not TidyPlatesData.UnitDescriptions then TidyPlatesData.UnitDescriptions = {} end
	if not TidyPlatesData.UnitClass then TidyPlatesData.UnitClass = {} end
	if not TidyPlatesData.Guild then TidyPlatesData.Guild = {} end
	if not TidyPlatesData.Friends then TidyPlatesData.Friends = {} end
	
	GuildRoster()
	UpdateFriendCache()
end

local function Disable() 
	if UnitCacheMonitor then
		UnitCacheMonitor:SetScript("OnEvent", nil)
		UnitCacheMonitor:UnregisterAllEvents()
	end
end

TidyPlatesUtility.EnableUnitCache = Enable
TidyPlatesUtility.DisableUnitCache = Disable
TidyPlatesUtility.UpdateCacheByZone = UpdateCacheByZone


--[[

/run TidyPlatesUtility.EnableUnitCache()

local isPlayer = UnitIsPlayer( "mouseover" )
local reaction = UnitReaction( "mouseover", "player" ) -- 4 is neutral

if not isPlayer then
	DocsScanningTooltip:ClearLines()
	DocsScanningTooltip:SetUnit( "mouseover" )
	local text = DocsScanningTooltipTextLeft3:GetText()
	
	if text then
		_, text = strsplit( " ", text )
		
		if text=="??" or tonumber( text ) then
			global.npcList[name] = DocsScanningTooltipTextLeft2:GetText()
		else
			global.npcList[name] = "NONE"
		end
	else
		global.npcList[name] = "NONE"
	end
	
	if UnitClassification( "mouseover" )=="worldboss" then collectUnitInfo( "mouseover" ) end
else
	collectUnitInfo( "mouseover" )
end
--]]

