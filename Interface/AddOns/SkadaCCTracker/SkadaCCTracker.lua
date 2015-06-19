---------------------------------------
-- Globals
---------------------------------------

local addonName, vars = ...
local L = vars.L
local SkadaCCId = vars.SkadaCCId

local Skada = Skada

local mod_done_general = Skada:NewModule(L["LOCALE_MOD_DONE_GENERAL"])
local mod_done_player = Skada:NewModule(L["LOCALE_MOD_DONE_SPELLS"])
local mod_done_player_spell = Skada:NewModule(L["LOCALE_MOD_DONE_SPELL_TARGETS"])
local mod_done_spell = Skada:NewModule(L["LOCALE_MOD_DONE_TARGETS"])
local mod_done_spell_player = Skada:NewModule(L["LOCALE_MOD_DONE_TARGET_SPELLS"])

local mod_taken_general = Skada:NewModule(L["LOCALE_MOD_TAKEN_GENERAL"])
local mod_taken_player = Skada:NewModule(L["LOCALE_MOD_TAKEN_SPELLS"])
local mod_taken_player_spell = Skada:NewModule(L["LOCALE_MOD_TAKEN_SPELL_SOURCES"])
local mod_taken_spell = Skada:NewModule(L["LOCALE_MOD_TAKEN_SOURCES"])
local mod_taken_spell_player = Skada:NewModule(L["LOCALE_MOD_TAKEN_SOURCE_SPELLS"])

local CLIENT_VERSION = tonumber((select(4, GetBuildInfo())))

local WoW5 = CLIENT_VERSION > 50000

---------------------------------------
local function logCcCountDone(set, cc)
	---------------------------------------

	local player = Skada:get_player(set, cc.srcGUID, cc.srcName)

	if player then
		player.ccDoneCount = player.ccDoneCount + 1

		if not player.ccDoneSpells[cc.spellName] then
			player.ccDoneSpells[cc.spellName] = { id = cc.spellId, count = 0, targets = {} }
		end

		player.ccDoneSpells[cc.spellName].count = player.ccDoneSpells[cc.spellName].count + 1

		if not player.ccDoneSpells[cc.spellName].targets[cc.dstName] then
			player.ccDoneSpells[cc.spellName].targets[cc.dstName] = { id = cc.dstGUID, count = 0 }
		end

		player.ccDoneSpells[cc.spellName].targets[cc.dstName].count = player.ccDoneSpells[cc.spellName].targets[cc.dstName].count + 1

		if not player.ccDoneTargets[cc.dstName] then
			player.ccDoneTargets[cc.dstName] = { id = cc.dstGUID, count = 0, spells = {} }
		end

		player.ccDoneTargets[cc.dstName].count = player.ccDoneTargets[cc.dstName].count + 1

		if not player.ccDoneTargets[cc.dstName].spells[cc.spellName] then
			player.ccDoneTargets[cc.dstName].spells[cc.spellName] = { id = cc.spellId, count = 0 }
		end

		player.ccDoneTargets[cc.dstName].spells[cc.spellName].count = player.ccDoneTargets[cc.dstName].spells[cc.spellName].count + 1

		set.ccDoneCount = set.ccDoneCount + 1
	end
end

---------------------------------------
local function SpellAuraAppliedDone(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	---------------------------------------

	local spellId, spellName, spellSchool, auraType, extraSpellId, extraSpellName, extraSchool

	if eventtype == "SPELL_AURA_APPLIED" or eventtype == "SPELL_AURA_REFRESH" then
		spellId, spellName, spellSchool, auraType = ...
	else
		spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool, auraType = ...
	end

	if SkadaCCId[spellId] then
		srcGUID, srcName = Skada:FixMyPets(srcGUID, srcName)
		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		local cc = {}
		cc.srcGUID = srcGUID
		cc.srcName = srcName
		cc.dstGUID = dstGUID
		cc.dstName = dstName
		cc.spellId = spellId
		cc.spellName = spellName
		cc.spellSchool = spellSchool
		logCcCountDone(Skada.current, cc)
		logCcCountDone(Skada.total, cc)
	end
end

---------------------------------------
function mod_done_general:Update(win, set)
	---------------------------------------

	local max = 0
	local nr = 1

	for i, player in ipairs(set.players) do
		if player.ccDoneCount > 0 then
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.value = player.ccDoneCount
			d.label = player.name
			d.valuetext = tostring(player.ccDoneCount)
			d.id = player.id
			d.class = player.class
			if player.ccDoneCount > max then
				max = player.ccDoneCount
			end
			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_done_player:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), id)

	if player then
		mod_done_player.playerid = id
		mod_done_player.title = player.name .. " " .. L["LOCALE_MOD_DONE_SPELLS"]
	end
end

---------------------------------------
function mod_done_player:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, self.playerid)

	local max = 0
	local nr = 1

	if player then
		for spellname, spell in pairs(player.ccDoneSpells) do
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.label = spellname
			d.id = spellname
			d.icon = select(3, GetSpellInfo(spell.id))
			d.spellid = spell.id
			d.value = spell.count
			d.valuetext = spell.count
			if spell.count > max then
				max = spell.count
			end
			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_done_player_spell:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), mod_done_player.playerid)

	mod_done_player_spell.spellName = label
	mod_done_player_spell.title = player.name .. " " .. L["LOCALE_MOD_DONE_GENERAL"] .. " <" .. label .. "> " .. L["LOCALE_TARGETS"]
end

---------------------------------------
function mod_done_player_spell:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, mod_done_player.playerid)

	local max = 0
	local nr = 1

	if player then
		local spell = self.spellName
		if spell then
			local targets = player.ccDoneSpells[spell].targets
			for targetName, target in pairs(targets) do

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				d.value = tonumber(target.count)
				d.label = targetName
				d.valuetext = tostring(target.count)
				d.id = target.id
				if tonumber(target.count) > max then
					max = tonumber(target.count)
				end
				nr = nr + 1
			end
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_done_spell:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), id)

	if player then
		mod_done_spell.playerid = id
		mod_done_spell.title = player.name .. " " .. L["LOCALE_MOD_DONE_TARGETS"]
	end
end

---------------------------------------
function mod_done_spell:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, self.playerid)

	local max = 0
	local nr = 1

	if player then
		for targetName, target in pairs(player.ccDoneTargets) do
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.value = tonumber(target.count)
			d.label = targetName
			d.valuetext = tostring(target.count)
			d.id = target.id
			if tonumber(target.count) > max then
				max = tonumber(target.count)
			end
			nr = nr + 1
		end
	end


	win.metadata.maxvalue = max
end

---------------------------------------
function mod_done_spell_player:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), mod_done_player.playerid)

	mod_done_spell_player.targetName = label
	mod_done_spell_player.title = player.name .. " " .. L["LOCALE_MOD_DONE_GENERAL"] .. " <" .. label .. "> " .. L["LOCALE_SPELLS"]
end

---------------------------------------
function mod_done_spell_player:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, mod_done_player.playerid)

	local max = 0
	local nr = 1

	if player then
		local target = self.targetName
		if target then
			local spells = player.ccDoneTargets[target].spells
			for spellname, spell in pairs(spells) do
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				d.label = spellname
				d.id = spellname
				d.icon = select(3, GetSpellInfo(spell.id))
				d.spellid = spell.id
				d.value = spell.count
				d.valuetext = spell.count
				if spell.count > max then
					max = spell.count
				end
				nr = nr + 1
			end
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_done_general:OnEnable()
	---------------------------------------

	mod_done_general.metadata = { click1 = mod_done_player, click2 = mod_done_spell, showspots = true }

	mod_done_player.metadata = { click1 = mod_done_player_spell }
	mod_done_player_spell.metadata = {}

	mod_done_spell.metadata = { click1 = mod_done_spell_player }
	mod_done_spell_player.metadata = {}

	Skada:RegisterForCL(SpellAuraAppliedDone, 'SPELL_AURA_APPLIED', { src_is_interesting = true })
	Skada:RegisterForCL(SpellAuraAppliedDone, 'SPELL_AURA_REFRESH', { src_is_interesting = true })

	Skada:AddMode(self)
end

---------------------------------------
function mod_done_general:OnDisable()
	---------------------------------------

	Skada:RemoveMode(self)
end

---------------------------------------
function mod_done_general:GetSetSummary(set)
	---------------------------------------

	return set.ccDoneCount
end

---------------------------------------
function mod_done_general:AddPlayerAttributes(player)
	---------------------------------------

	if not player.ccDoneCount then
		player.ccDoneCount = 0
		player.ccDoneSpells = {}
		player.ccDoneTargets = {}
	end
end

---------------------------------------
function mod_done_general:AddSetAttributes(set)
	---------------------------------------

	if not set.ccDoneCount then
		set.ccDoneCount = 0
	end
end

---------------------------------------
local function logCcCountTaken(set, cc)
	---------------------------------------

	local player = Skada:get_player(set, cc.srcGUID, cc.srcName)

	if player then
		player.ccTakenCount = player.ccTakenCount + 1

		if not player.ccTakenSpells[cc.spellName] then
			player.ccTakenSpells[cc.spellName] = { id = cc.spellId, count = 0, targets = {} }
		end

		player.ccTakenSpells[cc.spellName].count = player.ccTakenSpells[cc.spellName].count + 1

		if not player.ccTakenSpells[cc.spellName].targets[cc.dstName] then
			player.ccTakenSpells[cc.spellName].targets[cc.dstName] = { id = cc.dstGUID, count = 0 }
		end

		player.ccTakenSpells[cc.spellName].targets[cc.dstName].count = player.ccTakenSpells[cc.spellName].targets[cc.dstName].count + 1

		if not player.ccTakenTargets[cc.dstName] then
			player.ccTakenTargets[cc.dstName] = { id = cc.dstGUID, count = 0, spells = {} }
		end

		player.ccTakenTargets[cc.dstName].count = player.ccTakenTargets[cc.dstName].count + 1

		if not player.ccTakenTargets[cc.dstName].spells[cc.spellName] then
			player.ccTakenTargets[cc.dstName].spells[cc.spellName] = { id = cc.spellId, count = 0 }
		end

		player.ccTakenTargets[cc.dstName].spells[cc.spellName].count = player.ccTakenTargets[cc.dstName].spells[cc.spellName].count + 1

		set.ccTakenCount = set.ccTakenCount + 1
	end
end

---------------------------------------
local function SpellAuraAppliedTaken(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	---------------------------------------

	local spellId, spellName, spellSchool, auraType, extraSpellId, extraSpellName, extraSchool

	if eventtype == "SPELL_AURA_APPLIED" or eventtype == "SPELL_AURA_REFRESH" then
		spellId, spellName, spellSchool, auraType = ...
	else
		spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool, auraType = ...
	end

	if SkadaCCId[spellId] then
		srcGUID, srcName = Skada:FixMyPets(srcGUID, srcName)
		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		local cc = {}
		cc.srcGUID = dstGUID
		cc.srcName = dstName
		cc.dstGUID = srcGUID
		cc.dstName = srcName
		cc.spellId = spellId
		cc.spellName = spellName
		cc.spellSchool = spellSchool
		logCcCountTaken(Skada.current, cc)
		logCcCountTaken(Skada.total, cc)
	end
end

---------------------------------------
function mod_taken_general:Update(win, set)
	---------------------------------------

	local max = 0
	local nr = 1

	for i, player in ipairs(set.players) do
		if player.ccTakenCount > 0 then
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.value = player.ccTakenCount
			d.label = player.name
			d.valuetext = tostring(player.ccTakenCount)
			d.id = player.id
			d.class = player.class
			if player.ccTakenCount > max then
				max = player.ccTakenCount
			end
			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_taken_player:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), id)

	if player then
		mod_taken_player.playerid = id
		mod_taken_player.title = player.name .. " " .. L["LOCALE_MOD_TAKEN_SPELLS"]
	end
end

---------------------------------------
function mod_taken_player:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, self.playerid)

	local max = 0
	local nr = 1

	if player then
		for spellname, spell in pairs(player.ccTakenSpells) do
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.label = spellname
			d.id = spellname
			d.icon = select(3, GetSpellInfo(spell.id))
			d.spellid = spell.id
			d.value = spell.count
			d.valuetext = spell.count
			if spell.count > max then
				max = spell.count
			end
			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_taken_player_spell:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), mod_taken_player.playerid)

	mod_taken_player_spell.spellName = label
	mod_taken_player_spell.title = player.name .. " " .. L["LOCALE_MOD_TAKEN_GENERAL"] .. " <" .. label .. "> " .. L["LOCALE_SOURCES"]
end

---------------------------------------
function mod_taken_player_spell:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, mod_taken_player.playerid)

	local max = 0
	local nr = 1

	if player then
		local spell = self.spellName
		if spell then
			local targets = player.ccTakenSpells[spell].targets
			for targetName, target in pairs(targets) do

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				d.value = tonumber(target.count)
				d.label = targetName
				d.valuetext = tostring(target.count)
				d.id = target.id
				if tonumber(target.count) > max then
					max = tonumber(target.count)
				end
				nr = nr + 1
			end
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_taken_spell:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), id)

	if player then
		mod_taken_spell.playerid = id
		mod_taken_spell.title = player.name .. " " .. L["LOCALE_MOD_TAKEN_SOURCES"]
	end
end

---------------------------------------
function mod_taken_spell:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, self.playerid)

	local max = 0
	local nr = 1

	if player then
		for targetName, target in pairs(player.ccTakenTargets) do
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.value = tonumber(target.count)
			d.label = targetName
			d.valuetext = tostring(target.count)
			d.id = target.id
			if tonumber(target.count) > max then
				max = tonumber(target.count)
			end
			nr = nr + 1
		end
	end


	win.metadata.maxvalue = max
end

---------------------------------------
function mod_taken_spell_player:Enter(win, id, label)
	---------------------------------------

	local player = Skada:find_player(win:get_selected_set(), mod_taken_player.playerid)

	mod_taken_spell_player.targetName = label
	mod_taken_spell_player.title = player.name .. " " .. L["LOCALE_MOD_TAKEN_GENERAL"] .. " <" .. label .. "> " .. L["LOCALE_SPELLS"]
end

---------------------------------------
function mod_taken_spell_player:Update(win, set)
	---------------------------------------

	local player = Skada:find_player(set, mod_taken_player.playerid)

	local max = 0
	local nr = 1

	if player then
		local target = self.targetName
		if target then
			local spells = player.ccTakenTargets[target].spells
			for spellname, spell in pairs(spells) do
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				d.label = spellname
				d.id = spellname
				d.icon = select(3, GetSpellInfo(spell.id))
				d.spellid = spell.id
				d.value = spell.count
				d.valuetext = spell.count
				if spell.count > max then
					max = spell.count
				end
				nr = nr + 1
			end
		end
	end

	win.metadata.maxvalue = max
end

---------------------------------------
function mod_taken_general:OnEnable()
	---------------------------------------

	mod_taken_general.metadata = { click1 = mod_taken_player, click2 = mod_taken_spell, showspots = true }

	mod_taken_player.metadata = { click1 = mod_taken_player_spell }
	mod_taken_player_spell.metadata = {}

	mod_taken_spell.metadata = { click1 = mod_taken_spell_player }
	mod_taken_spell_player.metadata = {}

	Skada:RegisterForCL(SpellAuraAppliedTaken, 'SPELL_AURA_APPLIED', { dst_is_interesting = true })
	Skada:RegisterForCL(SpellAuraAppliedTaken, 'SPELL_AURA_REFRESH', { dst_is_interesting = true })

	Skada:AddMode(self)
end

---------------------------------------
function mod_taken_general:OnDisable()
	---------------------------------------

	Skada:RemoveMode(self)
end

---------------------------------------
function mod_taken_general:GetSetSummary(set)
	---------------------------------------

	return set.ccTakenCount
end

---------------------------------------
function mod_taken_general:AddPlayerAttributes(player)
	---------------------------------------

	if not player.ccTakenCount then
		player.ccTakenCount = 0
		player.ccTakenSpells = {}
		player.ccTakenTargets = {}
	end
end

---------------------------------------
function mod_taken_general:AddSetAttributes(set)
	---------------------------------------

	if not set.ccTakenCount then
		set.ccTakenCount = 0
	end
end
