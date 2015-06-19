local GridStatusIncomingRes = Grid:NewStatusModule("GridStatusIncomingRes")
local GridRoster = Grid:GetModule("GridRoster")

local L_RES = "Incoming resurrection"
if GetLocale() == "deDE" then
	L_RES = "Eingehende Wiederbelebung"
elseif GetLocale() == "esES" or GetLocale() == "esMX" then
	L_RES = "Resurrección lanzado"
elseif GetLocale() == "frFR" then
	L_RES = "Résurrection entrante"
elseif GetLocale() == "ptBR" then
	L_RES = "Ressurreição de entrada"
elseif GetLocale() == "ruRU" then
	L_RES = "Входящее воскрешение"
elseif GetLocale() == "koKR" then
	L_RES = "부활 받음"
elseif GetLocale() == "zhCN" then
	L_RES = "接受复活"
elseif GetLocale() == "zhTW" then
	L_RES = "接受復活"
end

local targets = {}
local updater = CreateFrame("Frame")
updater:Hide()
do
	local last = 1
	updater:SetScript("OnUpdate", function(self, elapsed)
		last = last + elapsed
		if last < 1 then return end
		last = 0

		for guid in next, targets do
			local unit = GridRoster:GetUnitidByGUID(guid)
			if unit then
				GridStatusIncomingRes:INCOMING_RESURRECT_CHANGED(nil, unit)
			else
				targets[guid] = nil
			end
		end

		if not next(targets) then
			self:Hide()
			return
		end
	end)
end

GridStatusIncomingRes.defaultDB = {
	alert_resinc = {
		enable = true,
		priority = 90,
		color = { r = 1, g = 1, b = 1, a = 1 },
		range = false,
	},
}

function GridStatusIncomingRes:PostInitialize()
	self:RegisterStatus("alert_resinc", L_RES, nil, true)
end

function GridStatusIncomingRes:OnStatusEnable(status)
	if status == "alert_resinc" then
		self:RegisterEvent("INCOMING_RESURRECT_CHANGED")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateUnits")
		self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateUnits")

		self:UpdateUnits()
	end
end

function GridStatusIncomingRes:OnStatusDisable(status)
	if status == "alert_resinc" then
		updater:Hide()
		wipe(targets)

		self:UnregisterEvent("INCOMING_RESURRECT_CHANGED")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("GROUP_ROSTER_UPDATE")
		self.core:SendStatusLostAllUnits("alert_resinc")
	end
end

function GridStatusIncomingRes:UpdateUnits()
	for guid, unit in GridRoster:IterateRoster() do
		self:INCOMING_RESURRECT_CHANGED(nil, unit)
	end
end

function GridStatusIncomingRes:INCOMING_RESURRECT_CHANGED(_, unit)
	local guid = UnitGUID(unit)
	if not guid or not GridRoster:IsGUIDInRaid(guid) then return end
	local settings = self.db.profile.alert_resinc

	if UnitHasIncomingResurrection(unit) then
		targets[guid] = true
		updater:Show()
		self.core:SendStatusGained(
			guid, "alert_resinc", settings.priority, nil,
			settings.color, nil, nil, nil, [[Interface\RaidFrame\Raid-Icon-Rez]]
		)
	else
		targets[guid] = nil
		self.core:SendStatusLost(guid, "alert_resinc")
	end
end