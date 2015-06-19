-- GridStatusRole
--
-- Created By : Greltok

local _, ns = ...
if not ns.L then ns.L = {} end
local L = setmetatable(ns.L, {
	__index = function(t, k)
		t[k] = k
		return k
	end
})

--{{{ Libraries
local libGroupInSpecT = LibStub("LibGroupInSpecT-1.1")
local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")
--}}}

local GridStatusRole = Grid:NewStatusModule("GridStatusSpecializationRole")
GridStatusRole.menuName = L["Specialization Role"]

local rolestatus = {
	healer = {
		text = L["Healer"],
		icon = "Interface\\Icons\\Spell_Holy_Renew",
	},
	melee = {
		text = L["Melee"],
		icon = "Interface\\Icons\\Ability_DualWield",
	},
	ranged = {
		text = L["Ranged"],
		icon = "Interface\\Icons\\Spell_Fire_BlueFlameBolt",
	},
	tank = {
		text = L["Tank"],
		icon = "Interface\\Icons\\Ability_Warrior_ShieldMastery",
	},
}

--{{{ AceDB defaults
GridStatusRole.defaultDB = {
	specRole = {
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 10,
		range = false,
		useAssigned = true,
		assignedOpacity = 0.25,
		hideInCombat = false,
		colors = {
			healer = { r = 0, g = 1, b = 0, a = 1 },
			melee = { r = 1, g = 1, b = 0, a = 1 },
			ranged = { r = 0, g = 0, b = 1, a = 1 },
			tank = { r = 1, g = 0, b = 0, a = 1 },
		},
		filter = {
			healer = true,
			melee = true,
			ranged = true,
			tank = true,
		},
	},
}
--}}}

GridStatusRole.options = false

local assigned_colors = setmetatable({}, {__index = function(t, k)
	local settings = GridStatusRole.db.profile.specRole
    local roleColor = settings.colors[k]
    local color = { r = roleColor.r, g = roleColor.g, b = roleColor.b, a = ((roleColor.a or 1) * (settings.assignedOpacity or 1)) }
    rawset(t, k, color)
    return color
end })

local assigned_role_map = {
	["HEALER"] = "healer",
	["TANK"] = "tank",
}

local class_role_map = {
	["DAMAGER"] = {
		["DEATHKNIGHT"] = "melee",
		["HUNTER"] = "ranged",
		["MAGE"] = "ranged",
		["MONK"] = "melee",
		["PALADIN"] = "melee",
		["PRIEST"] = "ranged",
		["ROGUE"] = "melee",
		["WARLOCK"] = "ranged",
		["WARRIOR"] = "melee",
	},
}

local function getrolecolor(role)
	local color = GridStatusRole.db.profile.specRole.colors[role]
	return color.r, color.g, color.b, color.a
end

local function setrolecolor(role, r, g, b, a)
	local settings = GridStatusRole.db.profile.specRole
	local color = settings.colors[role]
	color.r = r
	color.g = g
	color.b = b
	color.a = a or 1
	local assignedColor = rawget(assigned_colors, role)
	if assignedColor then
		assignedColor.r = r
		assignedColor.g = g
		assignedColor.b = b
		assignedColor.a = ((a or 1) * (settings.assignedOpacity or 1))
	end
	GridStatus:SendMessage("Grid_ColorsChanged")
end

local function getrolefilter(role)
	return GridStatusRole.db.profile.specRole.filter[role] ~= false
end

local function setrolefilter(role, v)
	GridStatusRole.db.profile.specRole.filter[role] = v
	GridStatusRole:UpdateAllRoles()
end

--{{{ additional options
local roleOptions = {
	["role_color"] = {
		type = "group",
		dialogInline = true,
		name = L["Role colors"],
		order = 80,
		args = {
			["healer"] = {
				type = "color",
				name = L["Healer color"],
				desc = L["Color for Healers."],
				order = 100,
				hasAlpha = true,
				get = function () return getrolecolor("healer") end,
				set = function (_, r, g, b, a) setrolecolor("healer", r, g, b, a) end,
			},
			["melee"] = {
				type = "color",
				name = L["Melee color"],
				desc = L["Color for Melee."],
				order = 101,
				hasAlpha = true,
				get = function () return getrolecolor("melee") end,
				set = function (_, r, g, b, a) setrolecolor("melee", r, g, b, a) end,
			},
			["ranged"] = {
				type = "color",
				name = L["Ranged color"],
				desc = L["Color for Ranged."],
				order = 102,
				hasAlpha = true,
				get = function () return getrolecolor("ranged") end,
				set = function (_, r, g, b, a) setrolecolor("ranged", r, g, b, a) end,
			},
			["tank"] = {
				type = "color",
				name = L["Tank color"],
				desc = L["Color for Tanks."],
				order = 103,
				hasAlpha = true,
				get = function () return getrolecolor("tank") end,
				set = function (_, r, g, b, a) setrolecolor("tank", r, g, b, a) end,
			},
		},
	},
	["role_filter"] = {
		type = "group",
		dialogInline = true,
		name = L["Role filter"],
		order = 85,
		args = {
			["healer"] = {
				type = "toggle",
				name = L["Healer"],
				desc = L["Show on Healers."],
				order = 100,
				get = function () return getrolefilter("healer") end,
				set = function (_, v) setrolefilter("healer", v) end,
			},
			["melee"] = {
				type = "toggle",
				name = L["Melee"],
				desc = L["Show on Melee."],
				order = 101,
				get = function () return getrolefilter("melee") end,
				set = function (_, v) setrolefilter("melee", v) end,
			},
			["ranged"] = {
				type = "toggle",
				name = L["Ranged"],
				desc = L["Show on Ranged."],
				order = 102,
				get = function () return getrolefilter("ranged") end,
				set = function (_, v) setrolefilter("ranged", v) end,
			},
			["tank"] = {
				type = "toggle",
				name = L["Tank"],
				desc = L["Show on Tanks."],
				order = 103,
				get = function () return getrolefilter("tank") end,
				set = function (_, v) setrolefilter("tank", v) end,
			},
		},
	},
	["assigned"] = {
		type = "group",
		dialogInline = true,
		name = L["Assigned roles"],
		order = 90,
		args = {
			["useAssigned"] = {
				type = "toggle",
				name = L["Use assigned roles"],
				desc = L["Use assigned roles while talent info is unknown."],
				order = 100,
				get = function() return GridStatusRole.db.profile.specRole.useAssigned end,
				set = function()
					local settings = GridStatusRole.db.profile.specRole
					settings.useAssigned = not settings.useAssigned
					if settings.enable then
						if settings.useAssigned then
							GridStatusRole:RegisterEvent("PLAYER_ROLES_ASSIGNED")
						else
							GridStatusRole:UnregisterEvent("PLAYER_ROLES_ASSIGNED")
							wipe(assigned_colors)
						end
						GridStatusRole:UpdateAllRoles()
					end
				end,
			},
			["assignedOpacity"] = {
				type = "range",
				name = L["Assigned opacity"],
				desc = L["Opacity for assigned roles."],
				min = 0.05,
				max = 1,
				step = 0.01,
				bigStep = 0.05,
				isPercent = true,
				order = 101,
				get = function () return GridStatusRole.db.profile.specRole.assignedOpacity end,
				set = function (_, v)
					local settings = GridStatusRole.db.profile.specRole
					settings.assignedOpacity = v
					for role, assignedColor in pairs(assigned_colors) do
						local color = settings.colors[role]
						assignedColor.a = ((color and color.a or 1) * (v or 1))
					end
					GridStatus:SendMessage("Grid_ColorsChanged")
				end,
			},
		},
	},
	["hideInCombat"] = {
		type = "toggle",
		name = L["Hide in combat"],
		desc = L["Hide roles while in combat."],
		order = 95,
		get = function() return GridStatusRole.db.profile.specRole.hideInCombat end,
		set = function()
			local settings = GridStatusRole.db.profile.specRole
			settings.hideInCombat = not settings.hideInCombat
			if settings.enable then
				if settings.hideInCombat then
					GridStatusRole:RegisterMessage("Grid_EnteringCombat")
					GridStatusRole:RegisterMessage("Grid_LeavingCombat")
				else
					GridStatusRole:UnregisterMessage("Grid_EnteringCombat")
					GridStatusRole:UnregisterMessage("Grid_LeavingCombat")
				end
				GridStatusRole:UpdateAllRoles()
			end
		end,
	},
	["color"] = false,
}
--}}}

function GridStatusRole:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("specRole", L["Specialization Role"], roleOptions, true)
end

function GridStatusRole:OnStatusEnable(status)
	if status == "specRole" then
		self:RegisterMessage("Grid_UnitJoined")
		libGroupInSpecT.RegisterCallback(self, "GroupInSpecT_Update")
		local settings = self.db.profile.specRole
		if settings.useAssigned then
			self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
		end
		if settings.hideInCombat then
			self:RegisterMessage("Grid_EnteringCombat")
			self:RegisterMessage("Grid_LeavingCombat")
		end
		self:UpdateAllRoles()
	end
end

function GridStatusRole:OnStatusDisable(status)
	if status == "specRole" then
		self:UnregisterMessage("Grid_UnitJoined")
		libGroupInSpecT.UnregisterCallback(self, "GroupInSpecT_Update")
		local settings = self.db.profile.specRole
		if settings.useAssigned then
			self:UnregisterEvent("PLAYER_ROLES_ASSIGNED")
			wipe(assigned_colors)
		end
		if settings.hideInCombat then
			self:UnregisterMessage("Grid_EnteringCombat")
			self:UnregisterMessage("Grid_LeavingCombat")
		end
		self.core:SendStatusLostAllUnits("specRole")
	end
end

function GridStatusRole:Reset()
	self.super.Reset(self)
	wipe(assigned_colors)
	self:UpdateAllRoles()
	local settings = self.db.profile.specRole
	if settings.useAssigned then
		self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
	else
		self:UnregisterEvent("PLAYER_ROLES_ASSIGNED")
	end
	if settings.hideInCombat then
		GridStatusRole:RegisterMessage("Grid_EnteringCombat")
		GridStatusRole:RegisterMessage("Grid_LeavingCombat")
	else
		GridStatusRole:UnregisterMessage("Grid_EnteringCombat")
		GridStatusRole:UnregisterMessage("Grid_LeavingCombat")
	end
end

function GridStatusRole:Grid_UnitJoined(event, guid, unit)
	local info = libGroupInSpecT:GetCachedInfo(guid)
	self:UpdateRole(guid, unit, info and info.spec_role_detailed)
end

function GridStatusRole:Grid_EnteringCombat()
	local settings = self.db.profile.specRole
	if settings.enable and settings.hideInCombat then
		self.core:SendStatusLostAllUnits("specRole")
	end
end

function GridStatusRole:Grid_LeavingCombat()
	local settings = self.db.profile.specRole
	if settings.enable and settings.hideInCombat then
		self:UpdateAllRoles()
	end
end

function GridStatusRole:PLAYER_ROLES_ASSIGNED()
	self:UpdateAllRoles()
end

function GridStatusRole:UpdateAllRoles()
	local settings = self.db.profile.specRole
	if settings.enable and (not settings.hideInCombat or not Grid.inCombat) then
		for guid, unit in GridRoster:IterateRoster() do
			local info = libGroupInSpecT:GetCachedInfo(guid)
			self:UpdateRole(guid, unit, info and info.spec_role_detailed)
		end
	else
		self.core:SendStatusLostAllUnits("specRole")
	end
end

function GridStatusRole:GroupInSpecT_Update(event, guid, unit, info)
	self:UpdateRole(guid, unit, info and info.spec_role_detailed)
end

function GridStatusRole:UpdateRole(guid, unit, role)
	local gained
	local settings = self.db.profile.specRole
	if settings.enable and (not settings.hideInCombat or not Grid.inCombat) then
		local assigned
		if not role and settings.useAssigned then
			local assignedRole = UnitGroupRolesAssigned(unit)
			if assignedRole then
				assigned = true
				role = assigned_role_map[assignedRole]
				if not role then
					local classMap = class_role_map[assignedRole]
					if classMap then
						local _, class = UnitClass(unit)
						role = class and classMap[class]
					end
				end
			end
		end
		if role and settings.filter[role] then
			local status = rolestatus[role]
			self.core:SendStatusGained(guid,
										"specRole",
										settings.priority,
										settings.range,
										assigned and assigned_colors[role] or settings.colors[role],
										status.text,
										nil,
										nil,
										status.icon)
			gained = true
		end
	end
	if not gained then
		self.core:SendStatusLost(guid, "specRole")
	end
end
