local Emphasize = Grid:GetModule("GridStatus"):GetModule("GridStatusEmphasize")
local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")

local GridStatusEmphasize_Auras = Emphasize:NewModule("GridStatusEmphasize_Auras", "AceEvent-3.0")

-- upvalues
local UnitDebuff = UnitDebuff
local UnitBuff = UnitBuff
local UnitGUID = UnitGUID

-- data
local settings

GridStatusEmphasize_Auras.defaultDB = {
	range = true,
	color = { r = 1, g = 1, b = 1 },
	auras = { },
}

local options = {
	["color"] = {
		order = 1,
		type = "color",
		hasAlpha = false,
		name = "Global color",
		desc = "Changing this color changes the color of all the auras",
		get = function ()
			local color = GridStatusEmphasize_Auras.db.profile.color
			return color.r, color.g, color.b
		end,
		set = function (_, r, g, b)
			local color = GridStatusEmphasize_Auras.db.profile.color
			color.r = r
			color.g = g
			color.b = b
			for i, aura in ipairs(settings.auras) do
				aura.color.r = r
				aura.color.g = g
				aura.color.b = b				
			end
		end,
	},
	["range"] = {
		order = 2,
		type = "toggle",
		width = "full",
		name = "Range filter",
		desc = "Don't emphasize units out of range",
		get = function () return GridStatusEmphasize_Auras.db.profile.range end,
		set = function (_, v) GridStatusEmphasize_Auras.db.profile.range = v end,
	},
	["add"] = {
		order = 3,
		type = "input",
		width = "double",
		name = "Add new aura (name or spellid)",
		set = function(_, v) GridStatusEmphasize_Auras:AddAura(v) end,
	},
	["auras"] = {
		order = 4,
		type = "group",
		name = "Auras",
		inline = true,
		args = { },
	}
}

function GridStatusEmphasize_Auras:AddAura(name)
	-- check for duplicates
	for i, aura in ipairs(settings.auras) do
		if aura.name == name then
			return
		end
	end
	
	-- add	
	local aura = {
		name = name,
		priority = 90,
		color = { r = settings.color.r, g = settings.color.g, b = settings.color.b }
	}
	
	if tonumber(name) and GetSpellInfo(name) then
		aura.spellid = tonumber(name)
		aura.name = GetSpellInfo(name)
	end
	
	table.insert(settings.auras, aura)
	
	self:UpdateOptions()
	self:UpdateAll()
end

function GridStatusEmphasize_Auras:RemoveAura(index)
	Emphasize:DeemphasizeAllUnits(settings.auras[index].name)
	table.remove(settings.auras, index)
	
	self:UpdateOptions()
	self:UpdateAll()
end

function GridStatusEmphasize_Auras:UpdateOptions()
	options.auras.args = { }
	
	
	for i, aura in ipairs(settings.auras) do
		--[[
		options.auras.args[aura.name .. i .. "_remove"] = {
			order = aura.name:byte(1) * 0xff + aura.name:byte(2),
			type = "execute",
			width = "double",
			name = aura.name,
			desc = "Remove " .. aura.name,
			func = function() return self:RemoveAura(i) end,
		}
		]]
		
		local _, _, icon = GetSpellInfo(aura.spellid or aura.name)
		local name
		if icon then
			name = string.format("|T%s:0|t %s", icon, aura.name)
		else
			name = aura.name
		end
		
		if aura.spellid then
			name = name .. string.format(" (%i)", aura.spellid)
		end
		
		options.auras.args[aura.name .. i] = {
			order = aura.name:byte(1) * 0xff + aura.name:byte(2),
			type = "group",
			inline = true,
			name = name,
			args = {
				["color"] = {
					order = 1,
					type = "color",
					hasAlpha = false,
					name = "Color",
					get = function ()
						local color = aura.color
						return color.r, color.g, color.b
					end,
					set = function (_, r, g, b)
						local color = aura.color
						color.r = r
						color.g = g
						color.b = b
						self:UpdateAll()
					end,
				},
				["priority"] = {
					order = 2,
					type = "range",
					max = 99,
					min = 0,
					step = 1,
					name = "Priority",
					get = function() return aura.priority end,
					set = function(_, v)
						aura.priority = v
						self:UpdateAll()
					end,
				},
				["remove"] = {
					order = 3,
					type = "execute",
					width = "double",
					name = "Remove " .. aura.name,
					func = function() return self:RemoveAura(i) end,
				},
			}
		}
	end
end

function GridStatusEmphasize_Auras:OnInitialize()
	self.super.OnInitialize(self)
	
	self:RegisterOptions("Auras", options)
	settings = self.db.profile

	-- convert auras from old format
	for i, aura in ipairs(settings.auras) do
		if type(aura) == "string" then
			local newaura = {
				name = aura,
				priority = 90,
				color = { r = 1, g = 1, b = 1 }
			}
			settings.auras[i] = newaura
		end
	end

	self:RegisterEvent("UNIT_AURA", "ScanUnit")
	self:RegisterEvent("Grid_UnitJoined")
	
	self:UpdateOptions()
end

function GridStatusEmphasize_Auras:Grid_UnitJoined(event, guid, unitid)
	self:UpdateUnit("Grid_UnitJoined", unitid)
end

function GridStatusEmphasize_Auras:UpdateAll()
	Emphasize:Pause()
	
	for _, aura in ipairs(settings.auras) do
		Emphasize:DeemphasizeAllUnits(aura.name)
	end
	
	for guid, unitid in GridRoster:IterateRoster() do
		self:ScanUnit("UpdateAllUnits", unitid, guid)
	end
	
	Emphasize:Resume()
end

function GridStatusEmphasize_Auras:ScanUnit(event, unitid, unitguid)
	unitguid = unitguid or UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(unitguid) then
		return
	end
	
	for _, aura in ipairs(settings.auras) do
		local name, _, _, count, debuffType, duration, expirationTime, unitCaster, _, _, spellid = UnitDebuff(unitid, aura.name)		
		
		if not name then
			name, _, _, count, debuffType, duration, expirationTime, unitCaster, _, _, spellid = UnitBuff(unitid, aura.name)
		end
		
		if name and (not settings.range or UnitInRange(unitid)) and (not aura.spellid or aura.spellid == spellid) then
			Emphasize:EmphasizeUnit(unitguid, aura.name, aura.priority, aura.color)
		else
			Emphasize:DeemphasizeUnit(unitguid, aura.name)
		end
	end
end
