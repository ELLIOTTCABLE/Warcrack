
local RDPS_TOOLTIP_DISPLAY = "|cffeda55fClick|r to reset Raid DPS"

--[[local L = GetLocale()
if L == "frFR" then
	RDPS_TOOLTIP_DISPLAY = "|cffeda55fClick|r to reset Raid DPS"
end]]

local RDPS = CreateFrame("Frame")
local lbl = "RDPS"
local obj = LibStub("LibDataBroker-1.1"):NewDataObject(lbl, {type = "data source", value = "0", suffix = lbl, text = "0"..lbl})

local band = bit.band
local format = string.format

local raidDamage = 0
local combatStartTime = 0
local lastUpdate = 0

RDPS:RegisterEvent("PLAYER_REGEN_DISABLED")
RDPS:RegisterEvent("PLAYER_REGEN_ENABLED")
RDPS:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local events = {
	SWING_DAMAGE = true,
	RANGE_DAMAGE = true,
	SPELL_DAMAGE = true,
	SPELL_PERIODIC_DAMAGE = true,
	DAMAGE_SHIELD = true,
	DAMAGE_SPLIT = true,
}
local srcRaidFilter = bit.bor(COMBATLOG_OBJECT_AFFILIATION_RAID,
	COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_MINE
)
function RDPS:COMBAT_LOG_EVENT_UNFILTERED(time, eventType, _, _, _, sourceFlags, _, _, _, _, _, spellID, _, _, damage)
	if not events[eventType] then return end
	if band(sourceFlags, srcRaidFilter) == 0 then return end

	if eventType == "SWING_DAMAGE" then
		damage = spellID
	end

	raidDamage = raidDamage + damage
	if time - lastUpdate > 0.5 then
		lastUpdate = time
		if combatStartTime == 0 then
			combatStartTime = time - 1 -- -1 to avoid /0 issues
		end
		local dmg = raidDamage / (time - combatStartTime)
		if dmg > 1000 then
			local txt = format("%.0fK", dmg/1000)
			obj.text = txt..lbl
			obj.value = txt
		else
			local txt = format("%.0f", dmg)
			obj.text = txt..lbl
			obj.value = txt
		end
	end
end

function RDPS:PLAYER_REGEN_DISABLED()
	combatStartTime = 0
	raidDamage = 0
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function RDPS:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function obj.OnTooltipShow(tooltip)
	if tooltip and tooltip.AddLine then
		tooltip:AddLine(RDPS_TOOLTIP_DISPLAY)
	end
end

function obj.OnClick()
	combatStartTime = 0
	raidDamage = 0
	obj.text = "0"..lbl
	obj.value = "0"
end

