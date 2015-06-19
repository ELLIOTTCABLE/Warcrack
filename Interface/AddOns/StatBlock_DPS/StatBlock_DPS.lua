
local DPS_TOOLTIP_DISPLAY = "|cffeda55fClick|r to reset DPS"

do
	local L = GetLocale()
	if L == "esES" or L == "esMX" then
		DPS_TOOLTIP_DISPLAY = "|cffeda55fClic|r para resetear el DPS"
	elseif L == "zhTW" then
		DPS_TOOLTIP_DISPLAY = "|cffeda55f點擊|r 重設 DPS"
	elseif L == "zhCN" then
		DPS_TOOLTIP_DISPLAY = "|cffeda55f点击|r 重设 DPS"
	end
end

local DPS = CreateFrame("Frame")
local lbl = _G["STAT_DPS_SHORT"]
local obj = LibStub("LibDataBroker-1.1"):NewDataObject("DPS", {type = "data source", value = "0", suffix = lbl, text = "0"..lbl})

DPS:RegisterEvent("UNIT_PET")
DPS:RegisterEvent("PLAYER_LOGIN")
DPS:RegisterEvent("PLAYER_REGEN_DISABLED")
DPS:RegisterEvent("PLAYER_REGEN_ENABLED")
DPS:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local pId
local petId
local format = string.format

local myDamage = 0
local combatStartTime = 0
local lastUpdate = 0

function DPS:PLAYER_LOGIN()
	pId = UnitGUID("player")
	if not petId then
		petId = UnitGUID("pet") or "0x0"
	end
	self.PLAYER_LOGIN = nil
end

function DPS:UNIT_PET(unit)
	if unit == "player" then
		petId = UnitGUID("pet") or "0x0"
	end
end

local events = {
	SWING_DAMAGE = true,
	RANGE_DAMAGE = true,
	SPELL_DAMAGE = true,
	SPELL_PERIODIC_DAMAGE = true,
	DAMAGE_SHIELD = true,
	DAMAGE_SPLIT = true,
}
function DPS:COMBAT_LOG_EVENT_UNFILTERED(time, eventType, _, Id, _, _, _, _, _, _, _, spellID, _, _, damage)
	if not events[eventType] then return end

	if Id == pId or Id == petId then
		if eventType == "SWING_DAMAGE" then
			damage = spellID
		end
		myDamage = myDamage + damage
	end

	if time - lastUpdate > 0.2 then
		lastUpdate = time
		if combatStartTime == 0 then
			combatStartTime = time - 1 -- -1 to avoid /0 issues
		end
		local dmg = myDamage / (time - combatStartTime)
		if dmg > 10000 then
			local txt = format("%.1fK", dmg/1000)
			obj.text = txt..lbl
			obj.value = txt
		else
			local txt = format("%.0f", dmg)
			obj.text = txt..lbl
			obj.value = txt
		end
	end
end

function DPS:PLAYER_REGEN_DISABLED()
	combatStartTime = 0
	myDamage = 0
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function DPS:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function obj.OnTooltipShow(tooltip)
	if not tooltip.AddLine then return end
	tooltip:AddLine(DPS_TOOLTIP_DISPLAY)
end

function obj.OnClick()
	combatStartTime = 0
	myDamage = 0
	obj.text = "0"..lbl
	obj.value = "0"
end

