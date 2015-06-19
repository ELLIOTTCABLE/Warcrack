-- IMPORTANT: If you make any changes to this file, make sure you back it up before installing a new version.
-- This will allow you to restore your custom configuration with ease.
-- Also back up any custom textures or sounds you add.

-------
-- The first three variables control the appearance of the texture.
-------

-- The path of the texture file you want to use for characters of each faction relative to the main WoW directory (without the texture's file extension).
-- The default texture is "Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Enhanced\\KillingBlow_Alliance" for Alliance
-- and "Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Enhanced\\KillingBlow_Horde" for Horde; both by OligoFriends.
-- The AddOn also includes three other textures:
--	"Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Enhanced\\KillingBlow_HordeAlliance" by OligoFriends
--	"Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Enhanced\\KillingBlow_Skull" by OligoFriends
--	"Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Enhanced\\KillingBlow_HordeSword" by whitefreli
--	"Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Enhanced\\KillingBlow_Death" by OligoFriends
local ALLIANCE_TEXTURE_PATH = "Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Alliance"
local HORDE_TEXTURE_PATH = "Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow_Horde"

-- You can add your own texture by placing a TGA image in the WoW\Interface\AddOns\KillingBlowImage directory and changing the string after
-- ALLIANCE_TEXTURE_PATH or HORDE_TEXTURE_PATH to match its name.
-- See the "filename" argument on the following page for details on the required texture file format:
-- http://www.wowpedia.org/API_Texture_SetTexture
--
-- GIMP (www.gimp.org) is a free image editing program that can easily convert almost any image format to TGA as well as let you create your own TGA images.
-- If you want your texture to be packaged with the AddOn, just leave a comment on Curse or WoWI with the image embedded or a direct link to download the image.
-- I can convert PNG and other formats to TGA if needed.
-- Make sure that you have ownership rights of any image that you contribute.

-- The height/width of the texture. Using a height:width ratio different to that of the texture file may result in distortion.
local TEXTURE_WIDTH = 200
local TEXTURE_HEIGHT = 200

-------
-- These four variables control how the image is anchored to the screen.
-------

-- Used in image:SetPoint(TEXTURE_POINT, UIParent, ANCHOR_POINT, OFFSET_X, OFFSET_Y)
-- See http://www.wowpedia.org/API_Region_SetPoint for explanation.
local TEXTURE_POINT = "CENTER" -- The point of the texture that should be anchored to the screen.
local ANCHOR_POINT  = "CENTER" -- The point of the screen the texture should be anchored to.
local OFFSET_X = 0 			   -- The x/y offset of the texture relative to the anchor point.
local OFFSET_Y = 5

-------
-- These four variables control the animation that plays when the image is shown
-------

local SCALE_X = 1.5 -- The X scalar that the image should scale by
local SCALE_Y = 1.5 -- The Y scalar that the image should scale by
local SCALE_DURATION = 0.75 -- The duration of the scaling animation in seconds

local DELAY_DURATION = 0.75 -- The amount of time between the end of the scaling animation and the image hiding

-------
-- Other options
-------

-- The sound to play when you get a killing blow
local SOUND_PATH = "Interface\\AddOns\\KillingBlow_Enhanced\\KillingBlow.ogg"

-- The channel to play the sound through. This can be "Master", "SFX", "Music" or "Ambience"
local SOUND_CHANNEL = "Master"

-- If true, the AddOn will only activate in battlegrounds and arenas. If false, it will work everywhere.
local PVP_ONLY = true

-- If true, the AddOn will print a message in your chat frame when you get a killing blow showing your current total.
-- This is reset any time you go through a loading screen (e.g. when entering or leaving a battleground or instance)
local DO_CHAT = true

-------------------
-- END OF CONFIG --
-------------------
-- Do not change anything below here!

-- List globals here for mikk's FindGlobals script
-- GLOBALS: date, PlaySoundFile, UnitGUID, IsInInstance, GetTime, GetUnitName, UnitFactionGroup, SetMapToCurrentZone, GetCurrentMapAreaID, GetInstanceInfo, KillingBlow_Enhanced_DB

------
-- Animations
------
local frame = CreateFrame("Frame", "KillingBlow_EnhancedFrame", UIParent)
frame:SetPoint(TEXTURE_POINT, UIParent, ANCHOR_POINT, OFFSET_X, OFFSET_Y)
frame:SetFrameStrata("HIGH")
frame:Hide()

local texture = frame:CreateTexture()
texture:SetAllPoints()

local group = texture:CreateAnimationGroup()

group:SetScript("OnPlay", function(self)
	frame:SetSize(TEXTURE_WIDTH, TEXTURE_HEIGHT) -- Set the frame to the configured size before scaling animation starts
end)

local scale = group:CreateAnimation("Scale")
scale:SetScale(SCALE_X, SCALE_Y)
scale:SetDuration(SCALE_DURATION)

local delay = group:CreateAnimation("Animation")
delay:SetDuration(DELAY_DURATION)

delay:SetScript("OnPlay", function(self)
	frame:SetSize(TEXTURE_WIDTH * SCALE_X, TEXTURE_HEIGHT * SCALE_Y) -- Set the frame to the scaled size after the scaling animation ends
end)

group:SetScript("OnFinished", function(self)
	frame:Hide()
end)

frame:SetScript("OnShow", function(self)
	group:Play()
	PlaySoundFile(SOUND_PATH, SOUND_CHANNEL)
end)


------
-- Events
------
local addon, ns = ...

local band = bit.band
local print, tonumber = print, tonumber

-- "YYYY-MM-DDThh:mm:ssZ" (ISO 8601 Complete date plus hours, minutes and seconds [UTC])
-- We use date strings instead of Unix times (seconds since epoch) because Lua offers no easy way to get the current Unix time in the UTC timezone (`time` only supports local time).
local DATE_FORMAT = "!%Y-%m-%dT%H:%M:%SZ"

local function GetTimestamp()
	return date(DATE_FORMAT)
end

local FILTER_MINE = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER) -- Matches any "unit" under the player's control

local PLAYER_GUID = UnitGUID("player")
local PLAYER_NAME = GetUnitName("player", true)

local PlayerDB, CurrentSession

local InPVP = false
local KillCount = 0
local RecentKills = setmetatable({}, { __mode = "kv" }) -- [GUID] = killTime (from GetTime())

local function KillingBlow(destGUID, destName, now)
	frame:Show()

	RecentKills[destGUID] = now

	if CurrentSession then
		CurrentSession[GetTimestamp()] = destName
	end

	if DO_CHAT then
		KillCount = KillCount + 1
		print(("|cffCC0033Killing Blows Counter: %d|r"):format(KillCount))
	end
end

local function StartSession(sessionType)
	CurrentSession = { SessionType = sessionType, StartTime = GetTimestamp() }
	PlayerDB[#PlayerDB + 1] = CurrentSession
end

local function EndSession()
	CurrentSession.EndTime = GetTimestamp()
	CurrentSession = nil
end

local IsInPvPZone
do
	local INSTANCEMAPID_TOLBARAD = 732
	local INSTANCEMAPID_ASHRAN = 1191
	local INSTANCEMAPID_NORTHREND = 571
	local AREAID_WINTERGRASP = 501

	function IsInPvPZone()
		local inInstance, instanceType = IsInInstance()
		if inInstance and (instanceType == "pvp" or instanceType == "arena") then -- Is the player is in a BG or arena?
			return true
		end

		local _, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
		if instanceMapID == INSTANCEMAPID_TOLBARAD or instanceMapID == INSTANCEMAPID_ASHRAN then -- Is the player in Tol Barad or Ashran?
			return true
		elseif instanceMapID == INSTANCEMAPID_NORTHREND then -- If the player is in Northrend,
			SetMapToCurrentZone()
			return GetCurrentMapAreaID() == AREAID_WINTERGRASP -- Is the player in Wintergrasp?
		else
			return false -- The player isn't in a PvP zone
		end
	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function frame:ADDON_LOADED(name)
	if name == addon then
		KillingBlow_Enhanced_DB = KillingBlow_Enhanced_DB or {}
	end
end

function frame:PLAYER_LOGIN()
	PLAYER_GUID = UnitGUID("player")
	PLAYER_NAME = GetUnitName("player", true)
end

function frame:PLAYER_ENTERING_WORLD()
	texture:SetTexture(UnitFactionGroup("player") == "Alliance" and ALLIANCE_TEXTURE_PATH or HORDE_TEXTURE_PATH)

	KillingBlow_Enhanced_DB[PLAYER_NAME] = KillingBlow_Enhanced_DB[PLAYER_NAME] or {}
	PlayerDB = KillingBlow_Enhanced_DB[PLAYER_NAME]

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function frame:ZONE_CHANGED_NEW_AREA()
	InPVP = IsInPvPZone()

	if PVP_ONLY then
		if InPVP then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		else
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end

	if CurrentSession then
		EndSession()
	end

	if InPVP then
		local inInstance, instanceType = IsInInstance()
		StartSession(instanceType or "worldpvp")
	end

	KillCount = 0
end

function frame:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	if
		not destGUID or destGUID == "" or -- If there isn't a valid destination GUID
		(sourceGUID ~= PLAYER_GUID and band(sourceFlags, FILTER_MINE) ~= FILTER_MINE) or -- Or the source unit isn't the player or something controlled by the player (the latter check was suggested by Caellian)
		(InPVP and not destGUID:find("^Player%-")) -- Or we're in a PvP zone and the destination unit isn't a player
	then return end -- Return now

	local _, overkill
	if event == "SWING_DAMAGE" then
		_, overkill = ...
	elseif event:find("_DAMAGE", 1, true) and not event:find("_DURABILITY_DAMAGE", 1, true) then
		_, _, _, _, overkill = ...
	end

	local now, previousKill = GetTime(), RecentKills[destGUID]

	-- Caellian has noted that PARTY_KILL doesn't always fire correctly and suggested checking the overkill argument
	-- (which will be 0 [or maybe -1] for non-killing blows) to mitigate against this.
	--
	-- Because most kills will trigger PARTY_KILL and an overkill _DAMAGE, we need to keep a record of recent kill times
	-- and only record kills of the same unit when they're at least 1 second apart.
	if (event == "PARTY_KILL" or (overkill and overkill > 0)) and (not previousKill or now - previousKill > 1.0) then
		KillingBlow(destGUID, destName, now)
	end
end
