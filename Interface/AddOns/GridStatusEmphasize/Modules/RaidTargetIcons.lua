local Emphasize = Grid:GetModule("GridStatus"):GetModule("GridStatusEmphasize")
local GridStatusEmphasize_RaidTargetIcons = Emphasize:NewModule("GridStatusEmphasize_RaidTargetIcons", "AceEvent-3.0")

local GridRoster = Grid:GetModule("GridRoster")

-- upvalues
local GetRaidTargetIndex = GetRaidTargetIndex

GridStatusEmphasize_RaidTargetIcons.defaultDB = {
	color = { r = 1, g = 1, b = 1 },
	priority = 95,
	raid_icons = true,
	raid_icons_enabled = {
		[1] = true,
		[2] = true,
		[3] = true,
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
		[8] = true,
	}
}

local options = {
	["color"] = {
		order = 1,
		type = "color",
		hasAlpha = false,
		name = "Color",
		get = function ()
			local color = GridStatusEmphasize_RaidTargetIcons.db.profile.color
			return color.r, color.g, color.b
		end,
		set = function (_, r, g, b)
			local color = GridStatusEmphasize_RaidTargetIcons.db.profile.color
			color.r = r
			color.g = g
			color.b = b
		end,
	},
	["priority"] = {
		order = 2,
		type = "range",
		max = 99,
		min = 0,
		step = 1,
		name = "Priority",
		get = function() return GridStatusEmphasize_RaidTargetIcons.db.profile.priority end,
		set = function(_, v)
			GridStatusEmphasize_RaidTargetIcons.db.profile.priority = v
			GridStatusEmphasize_RaidTargetIcons:UpdateRaidTargets()
		end,
	},
	["rt"] = {
		order = 3,
		type = "toggle",
		width = "full",
		name = "Emphasize these raid icons",
		desc = "Emphasize these raid icons",
		get = function () return GridStatusEmphasize_RaidTargetIcons.db.profile.raid_icons end,
		set = function (_, v)
				GridStatusEmphasize_RaidTargetIcons.db.profile.raid_icons = v 
				GridStatusEmphasize_RaidTargetIcons:EnableDisable()
			end,
	},
}

local settings

function GridStatusEmphasize_RaidTargetIcons:OnInitialize()
	self.super.OnInitialize(self)
	
	-- add raid target icons to options
	for i = 1, 8 do
		options["raid_icon_" .. i] = {
			order = 10 + i,
			type = "toggle",
			disabled = function() return self.db.profile.raid_icons == false end,
			name = string.format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%i:20|t %s", i, _G["RAID_TARGET_"..i]),
			desc = "Emphasize " .. _G["RAID_TARGET_"..i],
			get = function () return GridStatusEmphasize_RaidTargetIcons.db.profile.raid_icons_enabled[i] end,
			set = function (_, v)
					GridStatusEmphasize_RaidTargetIcons.db.profile.raid_icons_enabled[i] = v
					GridStatusEmphasize_RaidTargetIcons:UpdateRaidTargets()
				end,
		}
	end

	self:RegisterOptions("Raid Target Icons", options)
	settings = self.db.profile
	
	self:EnableDisable()
end

function GridStatusEmphasize_RaidTargetIcons:EnableDisable()
	if settings.raid_icons then
		self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateRaidTargets")
	else
		self:UnregisterEvent("RAID_TARGET_UPDATE", "UpdateRaidTargets")
	end	

	self:UpdateRaidTargets()
end

function GridStatusEmphasize_RaidTargetIcons:UpdateRaidTargets()
	self:Debug("Update raidtargets")

	Emphasize:Pause()
	
	Emphasize:DeemphasizeAllUnits("raid_target")
	
	if settings.raid_icons then
		for guid, unitid in GridRoster:IterateRoster() do
			-- raid target icons
			local rt = GetRaidTargetIndex(unitid)
			if rt and settings.raid_icons_enabled[rt] then
				Emphasize:EmphasizeUnit(guid, "raid_target", settings.priority, settings.color)
			end
		end
	end
	
	Emphasize:Resume()
end
