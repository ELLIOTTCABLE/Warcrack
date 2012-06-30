--[[--------------------------------------------------------------------
	GridStatusParty
	Adds Grid statuses for party leader, raid leader, raid assistant, and master looter.
	Authors: Byron Shelden (Dashkal), Pastamancer, Phanx
	URL: http://www.wowace.com/addons/grid-status-party/
	This file is covered under the BSD-2.0 license. See LICENSE.TXT for details
----------------------------------------------------------------------]]

local _, ns = ...

local L = setmetatable(ns.L, {
	__index = function(t, k)
		t[k] = k
		return k
	end
})

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusParty = Grid:GetModule("GridStatus"):NewModule("GridStatusParty")
GridStatusParty.menuName = L["Party Roles"]

GridStatusParty.defaultDB = {
	alert_partylead = {
		enable = true,
		color = { r = 0, g = 0.5, b = 1, a = 1, ignore = true },
		icon = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
		text = L["PL"],
		priority = 25,
		range = false,
		hideInCombat = true,
	},
	alert_raidlead = {
		enable = true,
		color = { r = 1, g = 0.5, b = 0, a = 1, ignore = true },
		icon = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
		text = L["RL"],
		priority = 25,
		range = false,
		hideInCombat = true,
	},
	alert_raidassist = {
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1, ignore = true },
		icon = "Interface\\GroupFrame\\UI-Group-AssistantIcon",
		text = L["RA"],
		priority = 23,
		range = false,
		hideInCombat = true,
	},
	alert_masterloot = {
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1, ignore = true },
		icon = "Interface\\GroupFrame\\UI-Group-MasterLooter",
		text = L["ML"],
		priority = 24,
		range = false,
		hideInCombat = true,
	},
}

local function GetOptionsForStatus(status)
	local status_name = status
	return {
		text = {
			name = L["Text"],
			desc = L["Text to display on text indicators"],
			order = 50,
			type = "input", usage = L["<text>"],
			get = function()
				return GridStatusParty.db.profile[status_name].hideInCombat
			end,
			set = function(_, v)
				GridStatusParty.db.profile[status_name].hideInCombat = v
				GridStatusParty:Update()
			end,
		},
		hideInCombat = {
			name = L["Hide in combat"],
			desc = L["Hide this status while you are in combat."],
			type = "toggle",
			get = function()
				return GridStatusParty.db.profile[status_name].hideInCombat
			end,
			set = function(_, v)
				GridStatusParty.db.profile[status_name].hideInCombat = v
				GridStatusParty:Update()
			end,
		},
	}
end

function GridStatusParty:PostInitialize()
	self:Debug("PostInitialize")

	self.numStatuses, self.numCombatStatuses = 0, 0

	self:RegisterStatus("alert_partylead", PARTY_LEADER, GetOptionsForStatus("alert_partylead"))
	self:RegisterStatus("alert_raidlead", RAID_LEADER, GetOptionsForStatus("alert_raidlead"))
	self:RegisterStatus("alert_raidassist", RAID_ASSISTANT, GetOptionsForStatus("alert_raidassist"))
	self:RegisterStatus("alert_masterloot", MASTER_LOOTER, GetOptionsForStatus("alert_masterloot"))
end

function GridStatusParty:OnStatusEnable(status)
	self:Debug("OnStatusEnable", status)

	if self.numStatuses == 0 then
		self:RegisterEvent("PARTY_LEADER_CHANGED", "Update")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", "Update")
		self:RegisterEvent("RAID_ROSTER_UPDATE", "Update")
		self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED", "Update")
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "Update")
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "Update")
	end

	self.numStatuses = self.numStatuses + 1
end

function GridStatusParty:OnStatusDisable(status)
	self:Debug("OnStatusDisable", status)

	self.numStatuses = self.numStatuses - 1

	if self.numStatuses == 0 then
		self:UnregisterEvent("PARTY_LEADER_CHANGED")
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		self:UnregisterEvent("RAID_ROSTER_UPDATE")
		self:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

function GridStatusParty:Update()
	self.core:SendStatusLostAllUnits("alert_partylead")
	self.core:SendStatusLostAllUnits("alert_raidlead")
	self.core:SendStatusLostAllUnits("alert_raidassist")
	self.core:SendStatusLostAllUnits("alert_masterloot")

	local party, raid = GetNumPartyMembers(), GetNumRaidMembers()
	self:Debug("Update", party, raid)

	if raid > 0 then
		return self:UpdateRaid(raid)
	elseif party > 0 then
		return self:UpdateParty(party)
	end
end

function GridStatusParty:UpdateParty(party)
	self:Debug("UpdateParty", party)
	local partylead, masterloot = self.db.profile.alert_partylead, self.db.profile.alert_masterloot

	local inCombat = UnitAffectingCombat("player")
	local showPL = partylead.enable and (not inCombat or not partylead.hideInCombat)
	local showML = masterloot.enable and (not inCombat or not masterloot.hideInCombat)
	if not showPL and not showML then return end

	local _, ML = GetLootMethod()

	if not party then party = GetNumPartyMembers() end

	for i = 0, party do
		local unit = i > 0 and "party"..i or "player"
		local guid = UnitGUID(unit)

		if showPL and UnitIsPartyLeader(unit) then
			self.core:SendStatusGained(guid, "alert_partylead",
				partylead.priority,
				partylead.range,
				partylead.color,
				partylead.text,
				nil,
				nil,
				partylead.icon)
		end

		if showML and i == ML then
			self.core:SendStatusGained(guid, "alert_masterloot",
				masterloot.priority,
				masterloot.range,
				masterloot.color,
				masterloot.text,
				nil,
				nil,
				masterloot.icon)
		end
	end
end

function GridStatusParty:UpdateRaid(raid)
	self:Debug("UpdateRaid", raid)
	local raidlead, raidassist, masterloot = self.db.profile.alert_raidlead, self.db.profile.alert_raidassist, self.db.profile.alert_masterloot

	local inCombat = UnitAffectingCombat("player")
	local showRL, showRA, showML = raidlead.enable and (not inCombat or not raidlead.hideInCombat), raidassist.enable and (not inCombat or not raidassist.hideInCombat), masterloot.enable and (not inCombat or not masterloot.hideInCombat)
	if not showRL and not showRA and not showML then return end

	if not raid then raid = GetNumRaidMembers() end

	for i = 1, raid do
		local unit = "raid"..i
		local guid = UnitGUID("raid"..i)
		local _, rank, _, _, _, _, _, _, _, role, isML = GetRaidRosterInfo(i)

		if showRL and rank == 2 then
			self.core:SendStatusGained(guid, "alert_raidlead",
				raidlead.priority,
				raidlead.range,
				raidlead.color,
				raidlead.text,
				nil,
				nil,
				raidlead.icon)
		elseif showRA and rank == 1 then
			self.core:SendStatusGained(guid, "alert_raidassist",
				raidassist.priority,
				raidassist.range,
				raidassist.color,
				raidassist.text,
				nil,
				nil,
				raidassist.icon)
		end

		if showML and isML then
			self.core:SendStatusGained(guid, "alert_masterloot",
				masterloot.priority,
				masterloot.range,
				masterloot.color,
				masterloot.text,
				nil,
				nil,
				masterloot.icon)
		end
	end
end