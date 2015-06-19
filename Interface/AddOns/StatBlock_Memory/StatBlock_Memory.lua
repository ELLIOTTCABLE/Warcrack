
local L_TOTAL = "\nTotal"
local L_BLIZZ = "Total & Blizzard AddOns"
local L_TIP = "\n|cffeda55fClick|r to collect garbage"
local L_MB = "MB"
local L_KB = "KB"
local L_PROCESS = "Time to process your addons"
local L_WARNING = "\n|cffff0000WARNING:|r If it takes over 105 ms to process\nyour addons then StatBlock_Memory will stop\nupdating in combat to prevent errors."
local L_MS = MILLISECONDS_ABBR

local L = GetLocale()
if L == "frFR" then
	L_TOTAL = "\nTotal"
	L_BLIZZ = "Total & AddOns Blizzard"
	L_TIP = "\n|cffeda55fCliquer|r pour récupérer de la mémoire."
	L_MB = "Mo"
	L_KB = "Ko"
elseif L == "zhCN" then
	L_TOTAL = "\n全部用户插件"
	L_BLIZZ = "全部用户插件&暴雪插件"
	L_TIP = "\n|cffeda55f点击|r内存清理"
	L_MB = "MB"
	L_KB = "KB"
elseif L == "zhTW" then
	L_TOTAL = "\n全部"
	L_BLIZZ = "全部和暴雪插件"
	L_TIP = "\n|cffeda55f點擊|r收集垃圾"
	L_MB = "MB"
	L_KB = "KB"
end

local format = string.format
local CTimerAfter = C_Timer.After
local obj = LibStub("LibDataBroker-1.1"):NewDataObject("Memory", {type = "data source", value = "0", suffix = L_MB, text = "0 "..L_MB})
local inCombat = nil

local function formatMemory(n)
	if n > 999 then
		return format("%.1f %s", n / 1024, L_MB)
	else
		return format("%.0f %s", n, L_KB)
	end
end

local function updateMemory()
	CTimerAfter(20, updateMemory)

	-- If a user is running a LOT of addons, the Blizz function 'UpdateAddOnMemoryUsage()' can take a while to process.
	-- It can infact take so long that it gets killed off with a 'script too long' error.
	-- We now detect this per-user and prevent updating in combat if it's taking too long for the user to run Blizz's function.
	if (not inCombat or inCombat == "block") and InCombatLockdown() then
		return
	end

	local t = debugprofilestop()
	UpdateAddOnMemoryUsage()
	local shouldBlock = debugprofilestop()-t
	if shouldBlock > 105 then -- Kill if over 105 ms to prevent script too long errors in combat
		inCombat = "block"
	end

	local total = 0
	for i = 1, GetNumAddOns() do
		total = total + GetAddOnMemoryUsage(i)
	end
	obj.text = formatMemory(total)
	if total > 999 then
		obj.suffix = L_MB
		obj.value = format("%.1f", total / 1024)
	else
		obj.suffix = L_KB
		obj.value = format("%.0f", total)
	end
end
updateMemory()

function obj.OnClick()
	GameTooltip:Hide()
	collectgarbage("collect")
	updateMemory()
end

local mySort = function(x,y)
	return x > y
end

local memTbl, sortTbl = {}, {}
function obj.OnTooltipShow(tooltip)
	if not tooltip or not tooltip.AddLine or not tooltip.AddDoubleLine then return end

	if (not inCombat or inCombat == "block") and InCombatLockdown() then
		return
	end

	local t = debugprofilestop()
	UpdateAddOnMemoryUsage()
	local shouldBlock = debugprofilestop()-t
	if shouldBlock > 105 then -- Kill if over 105 ms to prevent script too long errors in combat
		inCombat = "block"
	end

	local grandtotal = collectgarbage("count")
	local total = 0

	for i = 1, GetNumAddOns() do
		local memused = GetAddOnMemoryUsage(i)
		if memused > 0 then
			total = total + memused
			memTbl[memused] = GetAddOnInfo(i)
			sortTbl[#sortTbl+1] = memused
		end
	end

	table.sort(sortTbl, mySort)
	local killPoint = tonumber(SB_MEM_KILL) or 0
	for i=1, #sortTbl do
		local val = sortTbl[i]
		tooltip:AddDoubleLine(format("%d. %s", i, memTbl[val]), formatMemory(val), 0, 1, 1, 0, 1, 0)
		if i == killPoint then break end
	end
	wipe(memTbl)
	wipe(sortTbl)

	tooltip:AddDoubleLine(L_TOTAL, "\n"..formatMemory(total), 1, 1, 1, 0, 1, 0)
	tooltip:AddDoubleLine(L_BLIZZ, formatMemory(grandtotal), 1, 1, 1, 0, 1, 0)
	tooltip:AddDoubleLine(L_PROCESS, format("%.0f %s", shouldBlock, L_MS), 1, 1, 1, 0, 1, 0)
	tooltip:AddLine(L_WARNING, 1, 1, 1)
	tooltip:AddLine(L_TIP, 1, 1, 1)
end

