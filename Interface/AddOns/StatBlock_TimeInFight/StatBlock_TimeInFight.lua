
local TiF = CreateFrame("Frame")
local obj = LibStub("LibDataBroker-1.1"):NewDataObject("TimeInFight", {type = "data source", value = "00:00", suffix = "TiF", text = "00:00 TiF"})

local floor = math.floor
local mod = mod
local format = string.format
local GetTime = GetTime
local CTimerAfter = C_Timer.After

local shouldUpdate = false
local infight = 0

local L_TIF = "Longest Fight"

do
	local L = GetLocale()
	if L == "zhCN" then
		L_TIF = "最长战斗"
	elseif L == "zhTW" then
		L_TIF = "最長戰鬥"
	end
end

TiF:RegisterEvent("PLAYER_REGEN_ENABLED")
TiF:RegisterEvent("PLAYER_REGEN_DISABLED")

local function updateTime()
	if not shouldUpdate then return end
	CTimerAfter(0.1, updateTime)

	local t = GetTime() - infight
	local showTime
	local s = floor(t)
	s = mod(s, 86400)
	local h = floor(s / 3600)
	s = mod(s, 3600)
	local m = floor(s / 60)
	s = mod(s, 60)

	if h == 0 then
		showTime = format("%02d:%02d", m, s)
	else
		showTime = format("%02d:%02d:%02d", h, m, s)
	end

	obj.text = showTime.." TiF"
	obj.value = showTime
end

TiF:SetScript("OnEvent", function(_, event)
	if event == "PLAYER_REGEN_ENABLED" then
		shouldUpdate = false
		local t = GetTime() - infight
		if t > (StatBlock_TimeInFightDB or 0) then
			StatBlock_TimeInFightDB = t
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		infight = GetTime()
		shouldUpdate = true
		CTimerAfter(0.1, updateTime)
	end
end)

function obj.OnTooltipShow(tooltip)
	if not tooltip or not tooltip.AddDoubleLine then return end
	tooltip:AddDoubleLine(L_TIF, SecondsToTime(StatBlock_TimeInFightDB or 0), 1, 1, 0, 0, 1, 1)
end

