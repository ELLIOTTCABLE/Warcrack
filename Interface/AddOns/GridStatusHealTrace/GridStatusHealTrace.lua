--[[--------------------------------------------------------------------
	GridStatusHealTrace
	Shows in Grid who was healed by your multi-target heals.
	Copyright (c) 2010-2015 Akkorian <akkorian@hotmail.com>.
	Copyright (c) 2010-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info16608-GridStatusHealTrace.html
	http://www.curse.com/addons/wow/gridstatushealtrace
	https://github.com/Phanx/GridStatusHealTrace
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridStatusHealTrace = Grid:NewStatusModule("GridStatusHealTrace")
local active, spellOrder, playerGUID, settings, spells = {}, {}

------------------------------------------------------------------------

GridStatusHealTrace.defaultDB = {
	alert_healTrace = {
		color = { r = 0.8, g = 1.0, b = 0.2, a = 1 },
		enable = true,
		holdTime = 1,
		priority = 75,
		range = false,
		spells = {},
	}
}
for _, spellID in ipairs({
	-- Druid
--	44203,  -- Tranquility
--	81262,  -- Wild Mushroom
	-- Monk
	130654, -- Chi Burst -- NEEDS CHECK
	123986, -- Chi Burst -- NEW?
	124040, -- Chi Torpedo -- NEEDS CHECK
	115008, -- Chi Torpedo -- NEW?
	115098, -- Chi Wave
	101546, -- Spinning Crane Kick -- NEEDS CHECK
	116670, -- Uplift
	124101, -- Zen Sphere: Detonate -- NEEDS CHECK
	-- Paladin
	114852, -- Holy Prism (enemy target)
	114871, -- Holy Prism (friendly target)
	82327,  -- Holy Radiance
	85222,  -- Light of Dawn
	-- Priest
	121148, -- Cascade
	34861,  -- Circle of Healing
	155245, -- Clarity of Purpose -- NEEDS CHECK
	64844,  -- Divine Hymn
	110745, -- Divine Star (holy version)
	122128, -- Divine Star (shadow version)
	120692, -- Halo (holy version)
	120696, -- Halo (shadow version)
	132157, -- Holy Nova -- NEEDS CHECK
--	88686,  -- Holy Word: Sanctuary
	129250, -- Power Word: Solace -- NEEDS CHECK
	596,    -- Prayer of Healing
	-- Shaman
	1064,   -- Chain Heal
--	73921,  -- Healing Rain
}) do
	local name, _, icon = GetSpellInfo(spellID)
	if name then
		GridStatusHealTrace.defaultDB.alert_healTrace.spells[name] = icon
	end
end

------------------------------------------------------------------------

local optionsForStatus = {
	holdTime = {
		order = -3,
		width = "double",
		name = L["Hold time"],
		desc = L["Show the status for this many seconds."],
		type = "range",
		min = 0.25,
		max = 5,
		step = 0.25,
		get = function()
			return GridStatusHealTrace.db.profile.alert_healTrace.holdTime
		end,
		set = function(_, v)
			GridStatusHealTrace.db.profile.alert_healTrace.holdTime = v
		end,
	},
	addSpell = {
		order = -2,
		width = "double",
		name = L["Add new spell"],
		desc = L["Add another healing spell to trace."],
		type = "input",
		usage = L["<spell name or spell ID>"],
		get = false,
		set = function(_, v)
			GridStatusHealTrace:AddSpell(string.trim(v))
		end,
	},
	removeSpell = {
		order = -1,
		name = L["Remove spell"],
		desc = L["Remove a spell from the trace list."],
		type = "group", dialogInline = true,
		args = {},
	},
}

------------------------------------------------------------------------

do
	local function removeSpell_func(info)
		GridStatusHealTrace:RemoveSpell(info.arg)
	end

	function GridStatusHealTrace:AddSpell(name, icon)
		local id, _ = name:match("(%d+)")
		if id then
			name, _, icon = GetSpellInfo(tonumber(id))
		elseif type(icon) ~= "string" then
			icon = nil
		end

		if not name then return end

		self.db.profile.alert_healTrace.spells[name] = icon or true

		optionsForStatus.removeSpell.args[name] = {
			name = string.format("|T%s:0:0:0:0:32:32:2:30:2:30|t %s", icon or "", name),
			desc = string.format(L["Remove %s from the trace list."], name),
			type = "execute",
			func = removeSpell_func,
			arg = name,
		}

		if not spellOrder[name] then
			spellOrder[name] = true
			spellOrder[#spellOrder + 1] = name
			table.sort(spellOrder)
			for i = 1, #spellOrder do
				optionsForStatus.removeSpell.args[spellOrder[i]].order = i
			end
		end
	end

	function GridStatusHealTrace:RemoveSpell(name)
		self.db.profile.alert_healTrace.spells[name] = nil
		optionsForStatus.removeSpell.args[name] = nil
	end
end

------------------------------------------------------------------------

function GridStatusHealTrace:PostInitialize()
	self:RegisterStatus("alert_healTrace", L["Heal Trace"], optionsForStatus, true)

	settings = self.db.profile.alert_healTrace
	spells = settings.spells

	for name, icon in pairs(spells) do
		self:AddSpell(name, icon)
	end
end

function GridStatusHealTrace:PostEnable()
	playerGUID = UnitGUID("player")
	self:RegisterEvent("SPELLS_CHANGED", "OnStatusEnable")
end

function GridStatusHealTrace:OnStatusEnable(status)
	for name in pairs(spells) do
		if GetSpellInfo(name) then
			return self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end
	self:OnStatusDisable(status)
end

function GridStatusHealTrace:OnStatusDisable(status)
	self:UnregisterAllEvents()
	self.core:SendStatusLostAllUnits("alert_healTrace")
end

function GridStatusHealTrace:PostReset()
	self.core:SendStatusLostAllUnits("alert_healTrace")

	settings = self.db.profile.alert_healTrace
	spells = settings.spells
	for name in pairs(optionsForStatus.removeSpell.args) do
		if not spells[name] then
			optionsForStatus.removeSpell.args[name] = nil
		end
	end
	for name, icon in pairs(spells) do
		if not optionsForStatus.removeSpell.args[name] then
			self:AddSpell(name, icon)
		end
	end
end

------------------------------------------------------------------------

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()
timerFrame:SetScript("OnUpdate", function(self, elapsed)
	local i = 0
	for destGUID, holdTime in pairs(active) do
		holdTime = holdTime - elapsed
		if holdTime <= 0 then
			GridStatusHealTrace.core:SendStatusLost(destGUID, "alert_healTrace")
			active[destGUID] = nil
		else
			active[destGUID] = holdTime
			i = i + 1
		end
	end
	if i == 0 then
		self:Hide()
	end
end)

function GridStatusHealTrace:COMBAT_LOG_EVENT_UNFILTERED(_, _, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName)
	if sourceGUID ~= playerGUID or event ~= "SPELL_HEAL" or not spells[spellName] then
		return
	end

	local spellIcon = spells[spellName]
	if type(spellIcon) == "boolean" then
		local name, _, icon = GetSpellInfo(spellID)
		self:RemoveSpell(name)
		self:AddSpell(name, icon)
		spellIcon = icon
	end

	self.core:SendStatusGained(destGUID, "alert_healTrace",
		settings.priority,
		settings.range,
		settings.color,
		spellName,
		nil,
		nil,
		spellIcon
	)

	active[destGUID] = settings.holdTime
	timerFrame:Show()
end