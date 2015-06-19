local Emphasize = Grid:GetModule("GridStatus"):GetModule("GridStatusEmphasize")
-- local QuickHealth = LibStub and LibStub("LibQuickHealth-2.0", true) -- don't error if not found
local GridStatusEmphasize_Health = Emphasize:NewModule("GridStatusEmphasize_Health", "AceEvent-3.0")

local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")

-- upvalues
local UnitHealth = QuickHealth and QuickHealth.UnitHealth or UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitGUID = UnitGUID
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsConnected = UnitIsConnected
local UnitIsCharmed = UnitIsCharmed
local UnitIsEnemy = UnitIsEnemy
local UnitIsPlayer = UnitIsPlayer

-- data
local SPELLID_SOR = 27827 -- spirit of redemption

local spellname_sor = "Not Yet Known" -- just a temporary name until the spellname is updated, to prevent UnitBuff errors

local settings


GridStatusEmphasize_Health.defaultDB = {
	color = { r = 1, g = 0, b = 0 },
	priority = 90,
	enable = true,
	emphasize_lowhp_pc = 10,
	emphasize_lowhp_abs = 0,
	range = true,
	ignore_pets = true,
}

local options = {
	["enable"] = {
		order = 1,
		type = "toggle",
		name = "Enable",
		desc = "Enable Health module",
		width = "full",
		get = function () return GridStatusEmphasize_Health.db.profile.enable end,
		set = function (_, v)
				GridStatusEmphasize_Health.db.profile.enable = v
				GridStatusEmphasize_Health:EnableDisable()
			end,
	},
	["color"] = {
		order = 2,
		type = "color",
		hasAlpha = false,
		name = "Color",
		disabled = function () return not GridStatusEmphasize_Health.db.profile.enable end,
		get = function ()
			local color = GridStatusEmphasize_Health.db.profile.color
			return color.r, color.g, color.b
		end,
		set = function (_, r, g, b)
			local color = GridStatusEmphasize_Health.db.profile.color
			color.r = r
			color.g = g
			color.b = b
		end,
	},
	["priority"] = {
		order = 3,
		type = "range",
		max = 99,
		min = 0,
		step = 1,
		name = "Priority",
		disabled = function () return not GridStatusEmphasize_Health.db.profile.enable end,
		get = function() return GridStatusEmphasize_Health.db.profile.priority end,
		set = function(_, v)
			GridStatusEmphasize_Health.db.profile.priority = v
			GridStatusEmphasize_Health:UpdateAll()
		end,
	},
	["range"] = {
		order = 4,
		type = "toggle",
		width = "full",
		name = "Range filter",
		desc = "Don't emphasize units out of range, even when they are below the threshold",
		disabled = function () return not GridStatusEmphasize_Health.db.profile.enable end,
		get = function () return GridStatusEmphasize_Health.db.profile.range end,
		set = function (_, v)
				GridStatusEmphasize_Health.db.profile.range = v
				GridStatusEmphasize_Health:EnableDisable()
			end,
	},
	["ignore_pets"] = {
		order = 5,
		type = "toggle",
		width = "full",
		name = "Ignore pets",
		desc = "Don't emphasize pets, even when they are below the threshold",
		disabled = function () return not GridStatusEmphasize_Health.db.profile.enable end,
		get = function () return GridStatusEmphasize_Health.db.profile.ignore_pets end,
		set = function (_, v)
				GridStatusEmphasize_Health.db.profile.ignore_pets = v
				GridStatusEmphasize_Health:UpdateAll()
			end,
	},
	["emphasize_lowhp_pc"] = {
		order = 6,
		type = "range",
		min = 0,
		max = 99,
		step = 0.01,
		bigStep = 1,
		width = "full",
		name = "Emphasize threshold (HP %)",
		desc = "Emphasize units under HP %",
		disabled = function () return not GridStatusEmphasize_Health.db.profile.enable end,
		get = function () return GridStatusEmphasize_Health.db.profile.emphasize_lowhp_pc*100 end,
		set = function (_, v)
				GridStatusEmphasize_Health.db.profile.emphasize_lowhp_pc = v/100
				GridStatusEmphasize_Health:EnableDisable()
			end,
	},
	["emphasize_lowhp_abs"] = {
		order = 7,
		type = "range",
		min = 0,
		softMax = 100000,
		step = 1,
		bigStep = 1,
		width = "full",
		name = "Emphasize threshold (HP)",
		desc = "Emphasize units under HP",
		disabled = function () return not GridStatusEmphasize_Health.db.profile.enable end,
		get = function () return GridStatusEmphasize_Health.db.profile.emphasize_lowhp_abs end,
		set = function (_, v)
				GridStatusEmphasize_Health.db.profile.emphasize_lowhp_abs = v
				GridStatusEmphasize_Health:EnableDisable()
			end,
	},	
}

function GridStatusEmphasize_Health:OnInitialize()
	self.super.OnInitialize(self)
	
	self:RegisterOptions("Health", options)
	settings = self.db.profile
	
	self:RegisterEvent("PLAYER_LOGIN", "UpdateSpellInfo")
	
	self:EnableDisable()
end

function GridStatusEmphasize_Health:UpdateSpellInfo()
	spellname_sor = GetSpellInfo(SPELLID_SOR)
end

function GridStatusEmphasize_Health:EnableDisable()
	if settings.enable and (settings.emphasize_lowhp_abs > 0 or settings.emphasize_lowhp_pc > 0) then
		if QuickHealth then
			QuickHealth.RegisterCallback(self, "UnitHealthUpdated", "UnitHealthUpdated")
		else
			self:RegisterEvent("UNIT_HEALTH", "UpdateUnit")
		end

		self:RegisterMessage("Grid_UnitJoined")
		self:RegisterEvent("UNIT_HEALTH_MAX", "UpdateUnit")
		self:RegisterEvent("UNIT_CONNECTION", "UpdateUnit")
		self:RegisterEvent("UNIT_NAME_UPDATE", "UpdateUnit")
		self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateAll")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateAll")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAll")
		
		self:UpdateAll()
	else
		if QuickHealth then
			QuickHealth.UnregisterCallback(self, "UnitHealthUpdated")
		else
			self:UnregisterEvent("UNIT_HEALTH")
		end
		self:UnregisterMessage("Grid_UnitJoined")
		self:UnregisterEvent("UNIT_HEALTH_MAX")
		self:UnregisterEvent("UNIT_CONNECTION")
		self:UnregisterEvent("UNIT_NAME_UPDATE")
		self:UnregisterEvent("RAID_ROSTER_UPDATE")
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		
		Emphasize:DeemphasizeAllUnits("lowhp")
	end	
end

function GridStatusEmphasize_Health:Grid_UnitJoined(event, guid, unitid)
	self:UpdateUnit("Grid_UnitJoined", unitid)
end

function GridStatusEmphasize_Health:UpdateAll()
	Emphasize:Pause()
	
	Emphasize:DeemphasizeAllUnits("lowhp")
	
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit("UpdateAll", unitid)
	end
	
	Emphasize:Resume()
end

function GridStatusEmphasize_Health:UnitHealthUpdated(unitid, health, healthmax)
	local guid = UnitGUID(unitid)
	local hp = health / healthmax
	
	if GridRoster:IsGUIDInRaid(guid) then
		if	hp > 0 and (hp <= settings.emphasize_lowhp_pc or health <= settings.emphasize_lowhp_abs) and	-- HP
			(not settings.range or UnitInRange(unitid)) and 		-- Range						
			(not settings.ignore_pets or UnitIsPlayer(unitid)) and 	-- Pets
			UnitIsConnected(unitid) and	not UnitIsDeadOrGhost(unitid) and not UnitIsEnemy("player", unitid) and -- Misc
			not UnitBuff(unitid, spellname_sor)	-- SoR		
			then
			Emphasize:EmphasizeUnit(guid, "lowhp", settings.priority, settings.color)
		else
			Emphasize:DeemphasizeUnit(guid, "lowhp")
		end
	end
end

function GridStatusEmphasize_Health:UpdateUnit(event, unitid)
	self:UnitHealthUpdated(unitid, UnitHealth(unitid), UnitHealthMax(unitid))
end
