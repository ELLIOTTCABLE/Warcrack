local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Healing"])
local spellsmod = Skada:NewModule(L["Healing spell list"])
local healedmod = Skada:NewModule(L["Healed players"])
local healingtaken = Skada:NewModule(L["Healing taken"])

local function log_heal(set, heal)
	-- Get the player from set.
	local player = Skada:get_player(set, heal.playerid, heal.playername)
	if player then
		-- Subtract overhealing
		local amount = math.max(0, heal.amount - heal.overhealing)
		-- Add absorbed
		amount = amount + heal.absorbed

		-- Add to player total.
		player.healing = player.healing + amount
		player.overhealing = player.overhealing + heal.overhealing
		player.healingabsorbed = player.healingabsorbed + heal.absorbed
		
		-- Also add to set total damage.
		set.healing = set.healing + amount
		set.overhealing = set.overhealing + heal.overhealing
		set.healingabsorbed = set.healingabsorbed + heal.absorbed
		
		-- Create recipient if it does not exist.
		if not player.healed[heal.dstName] then
			player.healed[heal.dstName] = {class = select(2, UnitClass(heal.dstName)), amount = 0}
		end
		
		-- Add to recipient healing.
		player.healed[heal.dstName].amount = player.healed[heal.dstName].amount + amount
		
		-- Create spell if it does not exist.
		if not player.healingspells[heal.spellname] then
			player.healingspells[heal.spellname] = {id = heal.spellid, name = heal.spellname, hits = 0, healing = 0, overhealing = 0, absorbed = 0, critical = 0, min = 0, max = 0}
		end
		
		-- Get the spell from player.
		local spell = player.healingspells[heal.spellname]
		
		spell.healing = spell.healing + amount
		if heal.critical then
			spell.critical = spell.critical + 1
		end
		spell.overhealing = spell.overhealing + heal.overhealing
		spell.absorbed = spell.absorbed + heal.absorbed
		
		spell.hits = (spell.hits or 0) + 1
		
		if not spell.min or amount < spell.min then
			spell.min = amount
		end
		if not spell.max or amount > spell.max then
			spell.max = amount
		end
	end
end

local heal = {}

local function SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Healing
	local spellId, spellName, spellSchool, samount, soverhealing, absorbed, scritical = ...
	
	heal.dstName = dstName
	heal.playerid = srcGUID
	heal.playername = srcName
	heal.spellid = spellId
	heal.spellname = spellName
	heal.amount = samount
	heal.overhealing = soverhealing
	heal.critical = scritical
	heal.absorbed = absorbed
	
	Skada:FixPets(heal)
	log_heal(Skada.current, heal)
	log_heal(Skada.total, heal)
end


local shields = {}

-- Identified absorb abilities by spell ID
local AbsorbSpellDuration = 
{
	-- Death Knight
--	[48707] = true, -- Anti-Magic Shell       reported in a different way in the CL (extra arguments, not sure what they mean)
	[51052] = true, -- Anti-Magic Zone
	[77535] = true, -- Blood Shield (DK)

	-- Druid
	[62606] = true, -- Savage Defense

	-- Mage
	[11426] = true, -- Ice Barrier
	[1463] = true,  -- Mana shield            no amount info in CL
	[543] = true ,  -- Mage Ward

	-- Paladin
	[96263] = true, -- Sacred Shield          (dps)
	[86273] = true, -- Illuminated Healing    (heal)
 	[88063] = true, -- Guarded by the Light   (tank)

	-- Priest
	[17] = true,    -- Power Word: Shield
	[47753] = true, -- Divine Aegis

	-- Warlock
	[7812] = true,  -- Sacrifice
	[6229] = true,  -- Shadow Ward


	-- Consumables
	[29674] = true, -- Lesser Ward of Shielding
	[29719] = true, -- Greater Ward of Shielding (these have infinite duration, set for a day here :P)
--	[29701] = true,
	[28538] = true, -- Major Holy Protection Potion
	[28537] = true, -- Major Shadow
	[28536] = true, --  Major Arcane
	[28513] = true, -- Major Nature
	[28512] = true, -- Major Frost
	[28511] = true, -- Major Fire
	[7233] = true, -- Fire
	[7239] = true, -- Frost
	[7242] = true, -- Shadow Protection Potion
	[7245] = true, -- Holy
	[6052] = true, -- Nature Protection Potion
	[53915] = true, -- Mighty Shadow Protection Potion
	[53914] = true, -- Mighty Nature Protection Potion
	[53913] = true, -- Mighty Frost Protection Potion
	[53911] = true, -- Mighty Fire
	[53910] = true, -- Mighty Arcane
	[17548] = true, --  Greater Shadow
	[17546] = true, -- Greater Nature
	[17545] = true, -- Greater Holy
	[17544] = true, -- Greater Frost
	[17543] = true, -- Greater Fire
	[17549] = true, -- Greater Arcane
	[28527] = true, -- Fel Blossom
	[29432] = true, -- Frozen Rune usage (Naxx classic)
	-- Item usage
	[36481] = true, -- Arcane Barrier (TK Kael'Thas) Shield
	[57350] = true, -- Darkmoon Card: Illusion
	[17252] = true, -- Mark of the Dragon Lord (LBRS epic ring) usage
	[25750] = true, -- Defiler's Talisman/Talisman of Arathor Rank 1
	[25747] = true,
	[25746] = true,
	[23991] = true,
	[31000] = true, -- Pendant of Shadow's End Usage
	[30997] = true, -- Pendant of Frozen Flame Usage
	[31002] = true, -- Pendant of the Null Rune
	[30999] = true, -- Pendant of Withering
	[30994] = true, -- Pendant of Thawing
	[31000] = true, -- 
	[23506]= true, -- Arena Grand Master Usage (Aura of Protection)
	[12561] = true, -- Goblin Construction Helmet usage
	[31771] = true, -- Runed Fungalcap usage
	[21956] = true, -- Mark of Resolution usage
	[29506] = true, -- The Burrower's Shell
	[4057] = true, -- Flame Deflector
	[4077] = true, -- Ice Deflector
	[39228] = true, -- Argussian Compass (may not be an actual absorb)
	-- Item procs
	[27779] = true, -- Divine Protection - Priest dungeon set 1/2  Proc
	[11657] = true, -- Jang'thraze (Zul Farrak) proc
	[10368] = true, -- Uther's Strength proc
	[37515] = true, -- Warbringer Armor Proc
	[42137] = true, -- Greater Rune of Warding Proc
	[26467] = true, -- Scarab Brooch proc
	[27539] = true, -- Thick Obsidian Breatplate proc
	[28810] = true, -- Faith Set Proc Armor of Faith
	[54808] = true, -- Noise Machine proc Sonic Shield 
	[55019] = true, -- Sonic Shield (one of these too ought to be wrong)
	[64411] = true, -- Blessing of the Ancient (Val'anyr Hammer of Ancient Kings equip effect)
	[64413] = true, -- Val'anyr, Hammer of Ancient Kings proc Protection of Ancient Kings
	[105909] = true, -- Shield of Fury (Warrior T13 Protection 2P Bonus)
	[105801] = true, -- Delayed Judgement (Paladin T13 Protection 2P Bonus)
	-- Misc
	[40322] = true, -- Teron's Vengeful Spirit Ghost - Spirit Shield
	-- Boss abilities
	[65874] = true, -- Twin Val'kyr's Shield of Darkness 175000
	[67257] = true, -- 300000
	[67256] = true, -- 700000
	[67258] = true, -- 1200000
	[65858] = true, -- Twin Val'kyr's Shield of Lights 175000
	[67260] = true, -- 300000
	[67259] = true, -- 700000
	[67261] = true, -- 1200000
}

local function AuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Auras
	local spellId, spellName, spellSchool, auraType, amount = ...
	
	if AbsorbSpellDuration[spellId] and amount ~= nil then
		if shields[dstName] == nil then shields[dstName] = {} end
		if shields[dstName][spellId] == nil then shields[dstName][spellId] = {} end
		shields[dstName][spellId][srcName] = amount
	end				   
end

local function AuraRefresh(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Auras
	local spellId, spellName, spellSchool, auraType, amount = ...
	
	if AbsorbSpellDuration[spellId] and amount ~= nil then
		if shields[dstName] and shields[dstName][spellId] and shields[dstName][spellId][srcName] then
			local prev = shields[dstName][spellId][srcName]
			if prev and prev > amount then
			
				heal.dstName = dstName
				heal.playerid = srcGUID
				heal.playername = srcName
				heal.spellid = spellId
				heal.spellname = spellName
				heal.amount = prev - amount
				heal.overhealing = 0
				heal.critical = nil
				heal.absorbed = 0
				
				Skada:FixPets(heal)
				log_heal(Skada.current, heal)
				log_heal(Skada.total, heal)
			end
			shields[dstName][spellId][srcName] = amount
		end
	end
end

local function AuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Auras
	local spellId, spellName, spellSchool, auraType, amount = ...
	
	if AbsorbSpellDuration[spellId] and amount ~= nil then
		if shields[dstName] and shields[dstName][spellId] and shields[dstName][spellId][srcName] then
			local prev = shields[dstName][spellId][srcName]
			if prev and prev > amount then
			
				heal.dstName = dstName
				heal.playerid = srcGUID
				heal.playername = srcName
				heal.spellid = spellId
				heal.spellname = spellName
				heal.amount = prev
				heal.overhealing = amount
				heal.critical = nil
				heal.absorbed = 0
				
				Skada:FixPets(heal)
				log_heal(Skada.current, heal)
				log_heal(Skada.total, heal)
			end
			shields[dstName][spellId][srcName] = 0
		end
	end
end
			
			
			



local function getHPS(set, player)
	local totaltime = Skada:PlayerActiveTime(set, player)
	
	return player.healing / math.max(1,totaltime)
end

local function getHPSByValue(set, player, healing)
	local totaltime = Skada:PlayerActiveTime(set, player)
	
	return healing / math.max(1,totaltime)
end

function healingtaken:Update(win, set)
	local nr = 1
	local max = 0
	
	for i, player in ipairs(set.players) do
		-- Iterate over all players and add to this player's healing taken.
		local totalhealing = 0
		for j, p in ipairs(set.players) do
			
			-- Iterate over each healed player this player did.
			-- Bit expensive doing this once for each player in raid; can be done differently.
			for name, heal in pairs(p.healed) do
				if name == player.name then
					totalhealing = totalhealing + heal.amount
				end
			end
			
		end
		
		-- Now we have a total healing value for this player.
		if totalhealing > 0 then
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.label = player.name
			d.value = totalhealing
			
			d.valuetext = Skada:FormatValueText(
											Skada:FormatNumber(totalhealing), self.metadata.columns.Healing,
											string.format("%02.1f", getHPSByValue(set, player, totalhealing)), self.metadata.columns.HPS,
											string.format("%02.1f%%", totalhealing / set.healing * 100), self.metadata.columns.Percent
										)
			d.class = player.class
			
			if totalhealing > max then
				max = totalhealing
			end
			
			nr = nr + 1
		end
			
	end
	win.metadata.maxvalue = max
end

function mod:Update(win, set)
	local nr = 1
	local max = 0

	for i, player in ipairs(set.players) do
		if player.healing > 0 then
			
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.label = player.name
			d.value = player.healing
			
			d.valuetext = Skada:FormatValueText(
											Skada:FormatNumber(player.healing), self.metadata.columns.Healing,
											string.format("%02.1f", getHPS(set, player)), self.metadata.columns.HPS,
											string.format("%02.1f%%", player.healing / set.healing * 100), self.metadata.columns.Percent
										)
			d.class = player.class
			
			if player.healing > max then
				max = player.healing
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

local function spell_tooltip(win, id, label, tooltip)
	local player = Skada:find_player(win:get_selected_set(), spellsmod.playerid)
	if player then
		local spell = player. healingspells[label]
		if spell then
			tooltip:AddLine(player.name.." - "..label)
			if spell.max and spell.min then
				tooltip:AddDoubleLine(L["Minimum hit:"], Skada:FormatNumber(spell.min), 255,255,255,255,255,255)
				tooltip:AddDoubleLine(L["Maximum hit:"], Skada:FormatNumber(spell.max), 255,255,255,255,255,255)
			end
			tooltip:AddDoubleLine(L["Average hit:"], Skada:FormatNumber(spell.healing / spell.hits), 255,255,255,255,255,255)
			if spell.hits then
				tooltip:AddDoubleLine(L["Critical"]..":", ("%02.1f%%"):format(spell.critical / spell.hits * 100), 255,255,255,255,255,255)
			end
			if spell.hits then
				tooltip:AddDoubleLine(L["Overhealing"]..":", ("%02.1f%%"):format(spell.overhealing / (spell.overhealing + spell.healing) * 100), 255,255,255,255,255,255)
			end
			if spell.hits and spell.absorbed then
				tooltip:AddDoubleLine(L["Absorbed"]..":", ("%02.1f%%"):format(spell.absorbed / (spell.overhealing + spell.healing) * 100), 255,255,255,255,255,255)
			end
		end
	end
end

function spellsmod:Enter(win, id, label)
	spellsmod.playerid = id
	spellsmod.title = label..L["'s Healing"]
end

-- Spell view of a player.
function spellsmod:Update(win, set)
	-- View spells for this player.
		
	local player = Skada:find_player(set, self.playerid)
	local nr = 1
	local max = 0
	
	if player then
		
		for spellname, spell in pairs(player.healingspells) do
		
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = spell.id
			d.label = spell.name
			d.value = spell.healing
			d.valuetext = Skada:FormatValueText(
											Skada:FormatNumber(spell.healing), self.metadata.columns.Healing,
											string.format("%02.1f%%", spell.healing / player.healing * 100), self.metadata.columns.Percent
										)
			d.icon = select(3, GetSpellInfo(spell.id))
			d.spellid = spell.id
			
			if spell.healing > max then
				max = spell.healing
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = max
end

function healedmod:Enter(win, id, label)
	healedmod.playerid = id
	healedmod.title = L["Healed by"].." "..label
end

-- Healed players view of a player.
function healedmod:Update(win, set)
	local player = Skada:find_player(set, healedmod.playerid)
	local nr = 1
	local max = 0
	
	if player then
		for name, heal in pairs(player.healed) do
			if heal.amount > 0 then
		
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				
				d.id = name
				d.label = name
				d.value = heal.amount
				d.class = heal.class
				d.valuetext = Skada:FormatValueText(
												Skada:FormatNumber(heal.amount), self.metadata.columns.Healing,
												string.format("%02.1f%%", heal.amount / player.healing * 100), self.metadata.columns.Percent
											)
				if heal.amount > max then
					max = heal.amount
				end
				
				nr = nr + 1
			end
		end
	end
	
	win.metadata.maxvalue = max
end

function mod:OnEnable()
	mod.metadata		= {showspots = true, click1 = spellsmod, click2 = healedmod, columns = {Healing = true, HPS = true, Percent = true}}
	spellsmod.metadata	= {tooltip = spell_tooltip, columns = {Healing = true, Percent = true}}
	healedmod.metadata 	= {showspots = true, columns = {Healing = true, Percent = true}}
	healingtaken.metadata = {showspots = true, columns = {Healing = true, HPS = true, Percent = true}}

	-- handlers for Healing spells
	Skada:RegisterForCL(SpellHeal, 'SPELL_HEAL', {src_is_interesting = true})
	Skada:RegisterForCL(SpellHeal, 'SPELL_PERIODIC_HEAL', {src_is_interesting = true})

	-- handlers for Absorption spells
	Skada:RegisterForCL(AuraApplied, 'SPELL_AURA_APPLIED', {src_is_interesting_nopets = true})
	Skada:RegisterForCL(AuraRefresh, 'SPELL_AURA_REFRESH', {src_is_interesting_nopets = true})
	Skada:RegisterForCL(AuraRemoved, 'SPELL_AURA_REMOVED', {src_is_interesting_nopets = true})
	
	Skada:AddMode(self)
	Skada:AddMode(healingtaken)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
	Skada:RemoveMode(healingtaken)
end

function mod:AddToTooltip(set, tooltip)
	local endtime = set.endtime
	if not endtime then
		endtime = time()
	end
	local raidhps = set.healing / (endtime - set.starttime + 1)
 	GameTooltip:AddDoubleLine(L["HPS"], ("%02.1f"):format(raidhps), 1,1,1)
end

function mod:GetSetSummary(set)
	return Skada:FormatNumber(set.healing)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	player.healed = player.healed or {}						-- Stored healing per recipient
	player.healing = player.healing or 0					-- Total healing
	player.healingspells = player.healingspells or {}		-- Healing spells
	player.overhealing = player.overhealing or 0			-- Overheal total
	player.healingabsorbed = player.healingabsorbed or 0	-- Absorbed total

	-- update any pre-existing healingspells for new properties
	for _, heal in pairs(player.healingspells) do
		heal.absorbed = heal.absorbed or 0
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	set.healing = set.healing or 0
	set.overhealing = set.overhealing or 0
	set.healingabsorbed = set.healingabsorbed or 0
	wipe(shields)
end
