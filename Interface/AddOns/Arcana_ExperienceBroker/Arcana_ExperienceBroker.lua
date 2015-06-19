-- LibDataBroker Initialization
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("Arcana_ExperienceBroker", {
	type = "data source",
	icon = "Interface\\AddOns\\Arcana_ExperienceBroker\\icons\\icon",
	text = "0",
	label = "Arcana's Experience Broker",
})

local UPDATEPERIOD = 5
local elapsed = 0

local xp = {
	initial = 0, -- XP at the start of the session
	current = 0, -- your current XP
	session = 0, -- your session XP
	accumulated = 0, -- how much XP you got total, including previous levels
	total = 0, -- total XP to level
	rest = 0, -- rest XP
	lastMob = 0, -- value of the last XP gain
	last = 0,
}

local times = {
	entrance = time(), -- when you entered the game
	levelUp = 0, -- when you last levelled
	total = time(), -- time played total
	level = time(), -- time played this level
	session = 0, -- time played this session
}

local MAX_LEVEL = nil

local displayOptions = {
	percent = 1,
	remainingPercent = 2,
	amount = 3,
	remaining = 4,
	bars = 5,
	timeToLevel = 6,
}
local displayOptionsSize = 6 -- until I figure out why #displayOptions doesn't work

local function cycleDisplayOption(displayText, size)
	return displayText % size + 1
end

-- from Broker_XPRate
local function getAccountMaxLevel()
	if not MAX_LEVEL then
		local expansionlevel = GetAccountExpansionLevel()
		if expansionlevel == 0 then --Vanilla
			MAX_LEVEL = 60
		elseif expansionlevel == 1 then --TBC
			MAX_LEVEL = 70
		elseif expansionlevel == 2 then --WOTLK
			MAX_LEVEL = 80
		elseif expansionlevel == 3 then -- Cataclysm
			MAX_LEVEL = 85
		elseif expansionlevel == 4 then -- Mists of Pandaria
			MAX_LEVEL = 90
		elseif expansionlevel == 5 then -- 
			MAX_LEVEL = 100
		else  --unknown expansionlevel so no idea but we don't want ppl to hit it
			MAX_LEVEL = 255
		end
	end
	return tonumber(MAX_LEVEL)
end

local periods = {86400, 3600, 60, 1}
local duration = {0, 0, 0, 0}

local function fmttime(timeval)
	local remaining = timeval
	local result = ""

	for key, period in pairs(periods)  do
		duration[key] = floor(remaining/period)
		remaining = remaining % period
	end
	
	if duration[1] > 0 then
		result = string.format("%dd ", duration[1])
	end
	result = result..string.format("%dh %dm %ds", duration[2], duration[3], duration[4])
	
	return result
end

function initialize()
	xp.current = UnitXP("player")
	xp.initial = xp.current
	xp.session = 0
	xp.accumulated = 0
	xp.total = UnitXPMax("player")
	xp.rest = GetXPExhaustion() or 0
	xp.lastMob = 0
	xp.last = 0
	
	times.entrance = time()
	times.levelUp = 0
	times.total = 0
	times.level = 0
	times.session = 0
end

function updateLastMob()
	xp.lastMob = xp.current - xp.last
	xp.last = xp.current
	if xp.lastMob < 0 then
		xp.lastMob = 0
	end
end

function resetSession()
	xp.initial = UnitXP("player")
	xp.session = 0
	times.entrance = time()
	xp.accumulated = 0
end

function newLevel()
	xp.accumulated = xp.accumulated + xp.current - xp.initial
	xp.initial = 0
	times.levelUp = time()
end

function updateExperience()
	xp.current = UnitXP("player")
	xp.total = UnitXPMax("player")
	xp.rest = GetXPExhaustion() or 0
	xp.session = xp.accumulated + xp.current - xp.initial
end

function updateTimes()
	times.level = time() - times.levelUp
	times.session = time() - times.entrance
	times.level = time() - times.level
end

local function xpToLevel()
	return xp.total - xp.current
end


local function timeThisLevel()
	return time() - times.levelUp
end

local function numMobsToLevel()
	return ceil(xpToLevel()/xp.lastMob)
end

local function rateForLevel()
	return (xp.current/timeThisLevel()) * 3600
end

local function rateForSession()
	return (xp.session/times.session) * 3600
end

local function timeToLevelForLevel()
	return xpToLevel() * (timeThisLevel()/xp.current)
end

local function timeToLevelForSession()
	return xpToLevel() * (times.session/xp.session)
end

local function timeToRestForSession()
	return xp.rest * (times.session/xp.session)
end

local function timeToLevelForSession_asStr()
	local val = ""
	if xp.session > 0 then
		val = fmttime(timeToLevelForSession())
	else
		val = "unknown"
	end
	return val	
end

local function timeToRestForSession_asStr()
	local val = ""
	if xp.session > 0 then
		val = fmttime(timeToRestForSession())
	else
		val = ""
	end
	return val	
end

function updateText()
	local levelText = " "
	local restText = ""
	
	if not MAX_LEVEL then
		local restSpec = nil
		if ArcanaExperience_DisplayOptions.labelview == displayOptions.percent then
			local percentXP = xp.current/xp.total * 100
			local percentRest = xp.rest/xp.total * 100
			levelText = string.format("|cffffffff%.1f%%|r", percentXP)
			restSpec = string.format(" |cffffee99R:|r |cffffffff%.1f%%|r", percentRest)

			
		elseif ArcanaExperience_DisplayOptions.labelview == displayOptions.amount then
			levelText = string.format("|cffffffff%d|r", xp.total - xpToLevel())
			restSpec = string.format(" |cffffee99R:|r |cffffffff%d|r", xp.rest)

			
		elseif ArcanaExperience_DisplayOptions.labelview == displayOptions.bars then
			local barsXP = xp.current/xp.total * 20
			local barsRest = xp.rest/xp.total
			levelText = string.format("|cffffffff%.1f bars|r", barsXP)
			restSpec = string.format(" |cffffee99R:|r |cffffffff%.1f levels|r", barsRest)
			
		elseif ArcanaExperience_DisplayOptions.labelview == displayOptions.timeToLevel then
			
			local levelTime = timeToLevelForSession_asStr()
			if levelTime == "unknown" then
				levelTime = "Unknown time"
			end
			levelText =  string.format("|cffffffff%s to level |r", levelTime)

			local restTime = timeToRestForSession_asStr()
			if restTime ~= '' then
				restTime = restTime .." of rest"
			end
			restSpec = string.format(" |cffffee99R:|r |cffffffff%s|r", restTime)

			
		elseif ArcanaExperience_DisplayOptions.labelview == displayOptions.remainingPercent then
			levelText = string.format("|cffffffff(%.1f%%)|r", xpToLevel()/xp.total*100)
			restSpec = string.format(" |cffffee99R:|r |cffffffff%.1f%%|r", xp.rest/xp.total * 100)

		elseif ArcanaExperience_DisplayOptions.labelview == displayOptions.remaining then
			levelText = string.format("|cffffffff(%d)|r", xpToLevel())
			restSpec = string.format(" |cffffee99R:|r |cffffffff%d|r", xp.rest)
		end
		
		if xp.rest ~= 0 and restSpec ~= nil then
			restText = restSpec
		else
			restText = ""
		end
	end
		
	dataobj.text = levelText..restText

end

function initDisplayOptions(textview)
	textview = textview or displayOptions.percent
	options = {
		labelview = textview,
		petview = false,
	}
	
	return options
end



function dataobj:OnClick(button)
	if IsControlKeyDown() and button == "LeftButton" then
		resetSession()
	elseif button == "LeftButton" then
		ArcanaExperience_DisplayOptions.labelview = cycleDisplayOption(ArcanaExperience_DisplayOptions.labelview, displayOptionsSize)
		updateText()
	end
end

--function dataobj:OnTooltipShow()
function updateToolTip()
	
	local toLevelXP = xpToLevel()
	local timeThisLevel = timeThisLevel()
	local currentLevel = UnitLevel("player")
	
	local gainedPercent = xp.current/xp.total * 100
	local remainingPercent = toLevelXP/xp.total * 100
	local restPercent = xp.rest/xp.total * 100
	
	GameTooltip:AddLine("Arcana's Experience Broker")
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total time played"..":", fmttime(times.total), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("Time this level"..":", fmttime(timeThisLevel), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("Time this session"..":", fmttime(times.session), 1,1,0, 1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Level"..":", currentLevel, 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("Total XP this level"..":", xp.total, 1,1,0, 1,1,1)
	
	GameTooltip:AddDoubleLine("Gained"..":", string.format("%d (%.1f%%)", xp.current, gainedPercent), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("Remaining"..":", string.format("%d (%.1f%%)", toLevelXP, remainingPercent), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("Total XP this session"..":", xp.session, 1,1,0, 1,1,1)
	
	GameTooltip:AddDoubleLine("Rest XP"..":", string.format("%d (%d%%)", xp.rest, restPercent), 1,1,0, 1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("XP/hour this level:", string.format("%d", rateForLevel()), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("XP/hour this session"..":", string.format("%d", rateForSession()), 1,1,0, 1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Time to level for this level"..":", fmttime(timeToLevelForLevel()), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine("Time to level for this session"..":", timeToLevelForSession_asStr(), 1,1,0, 1,1,1)
	GameTooltip:AddDoubleLine(string.format("Mobs to kill till level (at %d XP)", xp.lastMob)..":", numMobsToLevel(), 1,1,0, 1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(string.format("%sClick:%s %sChange text display%s", "|cff6ab950", FONT_COLOR_CODE_CLOSE, "|cffeeeeee", FONT_COLOR_CODE_CLOSE))
	GameTooltip:AddLine(string.format("%sCtrl + Click:%s %sResets session%s", "|cff6ab950", FONT_COLOR_CODE_CLOSE, "|cffeeeeee", FONT_COLOR_CODE_CLOSE))
end

function dataobj:OnEnter()
	updateTimes()

 	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	GameTooltip:ClearLines()
	updateToolTip()
	GameTooltip:Show()
end

function dataobj:OnLeave()
    GameTooltip:Hide();
end

local f = CreateFrame("frame")

-- Main Event Loop
f:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2 = ...

	if event == "ADDON_LOADED" and arg1 == "Arcana_ExperienceBroker" then
		self:UnregisterEvent("ADDON_LOADED")
		
		if ArcanaExperience_DisplayOptions == nil then
			print("Reset options!")
			ArcanaExperience_DisplayOptions = initDisplayOptions()
		elseif type(ArcanaExperience_DisplayOptions) == "number" then
			print("Reset options with previous view!")
			-- Convert configuration variable from previous Arcana_ExperienceBroker 40000.3.1
			ArcanaExperience_DisplayOptions = initDisplayOptions(ArcanaExperience_DisplayOptions)
		end
		
	end
	
	if event == "PLAYER_LOGIN" then
		initialize()
		RequestTimePlayed()
	elseif event == "PLAYER_XP_UPDATE" then
		updateLastMob()
	elseif event == "PLAYER_LEVEL_UP" then
		newLevel()
	end
	
	if event == "TIME_PLAYED_MSG" then
		times.total = arg1
		times.levelUp = time() - arg2
	end
	
	updateExperience()	
	updateText()
end)

f:RegisterEvent("PLAYER_XP_UPDATE")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:RegisterEvent("TIME_PLAYED_MSG")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")