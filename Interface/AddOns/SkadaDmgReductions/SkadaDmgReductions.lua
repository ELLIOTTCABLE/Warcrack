local addonName = ...

local Skada = Skada
local floor = math.floor
local band = bit.band

local CLIENT_VERSION = tonumber((select(4, GetBuildInfo())))
local PHYSICAL_DMG, MAGICAL_DMG, ALL_DMG = 1, 126, 255

--------------------------------------------------------------------------------

local effects = {
	--- ### RAID WIDE EFFECTS ### ---
	
	[31821] = { -- Devotion Aura
		reduction = 0.20,
		duration = 6,
		aoe = true,
		school = (CLIENT_VERSION > 60100) and ALL_DMG or MAGICAL_DMG -- All damages since 6.2
	},
	[51052] = { -- Anti-Magic Zone
		reduction = 0.20,
		duration = 3,
		aura = 145629,
		school = MAGICAL_DMG,
		aoe = true
	},
	[62618] = { -- Power Word: Barrier
		reduction = 0.20,
		duration = 10,
		aura = 81782,
		aoe = true
	},
	[76577] = { -- Smoke Bomb
		reduction = 0.10,
		duration = 7,
		debuff = true,
		aura = 88611,
		aoe = true
	},
	[98008] = { -- Spirit Link Totem
		reduction = 0.10,
		duration = 6,
		aura = 98007,
		aoe = true
	},
	
	--- ### PERSONAL EFFECTS ### ---
	
	-- PALADIN
	[498] = { -- Divine Protection
		reduction = function(aura) return aura[16] == 0 and 0.40 or 0.20 end,
		duration = 8,
		school = function(aura) return aura[16] == 0 and MAGICAL_DMG or ALL_DMG end
	},
	[31850] = { -- Ardent Defender
		reduction = function(aura) return aura[15] / 100 end,
		duration = 10
	},
	[86659] = { -- Guardian of Ancient Kings
		reduction = 0.50,
		duration = 10
	},
	[132403] = { -- Shield of the Righteous
		reduction = function(aura) return (aura[15] / -100), true end,
		duration = 3,
		school = PHYSICAL_DMG
	},
	
	-- DEATHKNIGHT
	[48792] = { -- Icebound Fortitude
		reduction = function(aura) return aura[17] / -100 end,
		duration = 8
	},
	[49222] = { -- Bone Shield
		reduction = 0.20,
		duration = 300
	},
	
	-- WARRIOR
	[871] = { -- Shield Wall
		reduction = function(aura) return aura[15] / -100 end,
		duration = 8
	},
	[118038] = { -- Die by the Sword
		reduction = function(aura) return aura[16] / -100 end,
		duration = 8
	},
	
	-- DROOD
	[61336] = { -- Survical Instincts
		reduction = 0.50,
		duration = 6
	},
	[22812] = { -- Barkskin
		reduction = 0.20,
		duration = 12
	},
	
	-- MONK
	[115203] = { -- Fortifying Brew
		reduction = function(aura) return aura[16] / -100 end,
		duration = 15
	},
	--[[
	[122783] = { -- Diffuse Magic
		reduction = 0.90, -- FIXME: Same as Dispersion
		duration = 6,
		school = MAGICAL_DMG
	},
	[122278] = { -- Dampen Harm
		-- Special handling for <15% blows
		reduction = 0.50,
		duration = 45
	},
	[115176] = { -- Zen Meditation
		reduction = 0.90, -- FIXME: Same as Dispersion
		duration = 8
	},
	]]
	
	-- PRIEST
	--[[
	[47585] = { -- Dispersion
		-- FIXME: Huge reduction... 
		-- I did not include Divine Shield, should I include Dispersion?
		-- FIXME: Doesn't handle Glyph of Delayed Coalescence
		reduction = 0.90,
		duration = 6
	},
	]]
	
	-- SHAMAN
	[108271] = { -- Astral Shift
		reduction = 0.40,
		duration = 6
	},
	[30823] = { -- Shamanistic Rage
		-- TODO: Check Glyph of Shamanistic Resolve
		reduction = 0.30,
		duration = 15
	},
	
	-- WARLOCK
	[104773] = { -- Unending Resolve
		reduction = function(aura) return aura[17] / -100 end,
		duration = 8
	},
	
	-- HUNTER
	[19263] = { -- Deterrence
		reduction = function(aura) return aura[19] / -100 end,
		duration = 5
	},
	
	--- ### EXTERNAL EFFECTS ### ---
	
	[6940] = { -- Hand of Sacrifice
		reduction = 0.30,
		duration = 12,
		-- Check if Hand of Sacrifice is glyphed
		validate = function(aura) return aura[15] == 0 end
	},
	[114039] = { -- Hand of Purity
		-- FIXME: doesn't handle periodic dmg reduction
		reduction = 0.15,
		duration = 6
	},
	[33206] = { -- Pain Suppression
		reduction = 0.40,
		duration = 8
	},
	[102342] = { -- Ironbark
		reduction = 0.20,
		duration = 12
	},
	[114030] = { -- Vigilance
		reduction = 0.30,
		duration = 12
	},
}

local raid_effects = {
	[31821] = true, -- DA
	[51052] = true, -- AMZ
	[62618] = true, -- PW:B
	[76577] = true, -- SmB
	[98008] = true, -- SLT
}

local personnal_effects = {
	[498] = true, -- Divine Protection
	[31850] = true, -- Ardent Defender
	[86659] = true, -- Guardian of Ancient Kings
	[132403] = true, -- Shield of the Righteous
	[48792] = true, -- Icebound Fortitude
	[49222] = true, -- Bone Shield
	[871] = true, -- Shield Wall
	[118038] = true, -- Die by the Sword
	[61336] = true, -- Survical Instincts
	[22812] = true, -- Barkskin
	[115203] = true, -- Fortifying Brew
	[122783] = true, -- Diffuse Magic
	[122278] = true, -- Dampen Harm
	[115176] = true, -- Zen Meditation
	[47585] = true, -- Dispersion
	[108271] = true, -- Astral Shift
	[30823] = true, -- Shamanistic Rage
	[104773] = true, -- Unending Resolve
	[19263] = true, -- Deterrence
}

local external_effects = {
	[6940] = true, -- Hand of Sacrifice
	[114039] = true, -- Hand of Purity
	[33206] = true, -- Pain Suppression
	[102342] = true, -- Ironbark
	[114030] = true, -- Vigilance
}

--------------------------------------------------------------------------------

local raid_effects_active = {}
local players_effects_active = {}

--------------------------------------------------------------------------------

local sources = {}
local sources_count = 0
local effects_product = 1
local effects_sum = 0

local function check_instance(set, id, instance, dmg)
	local effect = effects[id]
	local expired = false
	local aura
	
	function evaluate(what, default)
		local fn = effect[what]
		
		-- Ensure fn exists and is a function
		if not fn then return default end
		if type(fn) ~= "function" then return fn end

		-- Check cached value
		local cached = instance.cache[what]
		if cached then return cached end
		
		-- Compute the value
		local value, no_cache = fn(aura, effect, instance, dmg)
		if not no_cache then instance.cache[what] = value end
		return value
	end
	
	-- Check expire time
	if instance.expire < dmg.time then
		expired = true
	elseif effect.debuff then
		aura = { UnitDebuff(dmg.playername, effect.auraname) }
	else
		aura = { UnitAura(dmg.playername, effect.auraname) }
	end
	
	-- Check validate function
	if not expired and not evaluate("validate", true) then
		expired = true
	end
	
	-- Instance is expired
	if expired then 
		set[id] = nil
		return
	end
	
	-- Aura is not present on target
	if next(aura) == nil then
		-- Remove the instance if aura is not an AoE and instance should be
		-- present for more than 0.5 sec
		if not effect.aoe and dmg.time - instance.applied > 0.5 then
			set[id] = nil
		end
		return
	end
	
	-- Check damage school
	local school_valid = true
	if effect.school then
		school_valid = band(255 - evaluate("school", ALL_DMG), dmg.school) == 0
	end
	
	if school_valid then
		local reduction = evaluate("reduction", 0)
		
		effects_product = effects_product * (1 - reduction)
		effects_sum = effects_sum + reduction
		
		sources_count = sources_count + 1
		local source = sources[sources_count]
		if not source then
			source = {}
			sources[sources_count] = source
		end
		
		source.reduction = reduction
		source.id = instance.sourceid
		source.name = instance.sourcename
		source.effectname = effect.name
		source.effectid = id
	end
end

local function log_reduction(set, dmg)
	local time = dmg.time
	
	sources_count = 0
	effects_product = 1
	effects_sum = 0
	
	-- Handle raid-wide effects
	for id, instance in pairs(raid_effects_active) do
		check_instance(raid_effects_active, id, instance, dmg)
	end
	
	-- Handle player effect
	local player_effects = players_effects_active[dmg.playerid]
	if player_effects then
		for id, instance in pairs(player_effects) do
			check_instance(player_effects, id, instance, dmg)
		end
		if not next(player_effects) then
			players_effects_active[dmg.playerid] = nil
		end
	end
	
	if sources_count < 1 or effects_product == 1 then return end
	
	-- Compute total prevented amount
	local total_dmg = floor(dmg.amount / effects_product)
	local prevented = total_dmg - dmg.amount
	
	for idx = 1, sources_count do
		local source = sources[idx]
		local valid = true
		local player = Skada:get_player(set, source.id, source.name)
		
		-- Dampen Harm
		if source.effectid == 122278 then
			valid = (total_dmg / UnitHealthMax(source.name)) >= 0.15
		end
		
		if player and valid then
			local amount = (source.reduction / effects_sum) * prevented
			
			-- Add to player total.
			player.healing = player.healing + amount
			player.shielding = player.shielding + amount
			
			-- Also add to set total damage.
			set.healing = set.healing + amount
			set.shielding = set.shielding + amount
			
			-- Add to recipient healing.
			do
				local healed = player.healed[dmg.playerid]

				-- Create recipient if it does not exist.
				if not healed then
					local _, className = UnitClass(dmg.playername)
					local playerRole = UnitGroupRolesAssigned(dmg.playername)
					healed = {name = dmg.playername, class = className, role = playerRole, amount = 0, shielding = 0}
					player.healed[dmg.playerid] = healed
				end

				healed.amount = healed.amount + amount
				healed.shielding = healed.shielding + amount
			end
			
			-- Add to spell healing
			do
				local spell = player.healingspells[source.effectname]

				-- Create spell if it does not exist.
				if not spell then
					spell = {id = source.effectid, name = source.effectname, hits = 0, healing = 0, overhealing = 0, absorbed = 0, shielding = 0, critical = 0, multistrike = 0, min = nil, max = 0}
					player.healingspells[source.effectname] = spell
				end

				spell.healing = spell.healing + amount
				spell.shielding = spell.shielding + amount
				spell.hits = (spell.hits or 0) + 1

				if not spell.min or amount < spell.min then
					spell.min = amount
				end
				if not spell.max or amount > spell.max then
					spell.max = amount
				end
			end
		end
	end
end

--------------------------------------------------------------------------------

local dmg = {}

local function SpellDamage(_, _, _, _, _, dstGUID, dstName, _, ...)
	local _, _, _, samount, _, sschool = ...
	if samount == 0 then return end

	dmg.playerid = dstGUID
	dmg.playername = dstName
	dmg.amount = samount
	dmg.school = sschool
	dmg.time = GetTime()

	log_reduction(Skada.current, dmg)
	log_reduction(Skada.total, dmg)
end

local function SwingDamage(_, _, _, _, _, dstGUID, dstName, _, ...)
	local samount, _, sschool = ...
	if samount == 0 then return end

	dmg.playerid = dstGUID
	dmg.playername = dstName
	dmg.amount = samount
	dmg.school = sschool
	dmg.time = GetTime()

	log_reduction(Skada.current, dmg)
	log_reduction(Skada.total, dmg)
end

local function SpellAbsorbed(_, _, _, _, _, dstGUID, dstName, _, ...)
	local chk = ...
	local spellSchool, aAmount
	
	if type(chk) == "number" then
		-- Spell event
		spellSchool = select(3, ...)
		aAmount = select(11, ...)
	else
		-- Swing event
		spellSchool = 1
		aAmount = select(8, ...)
	end
	
	if not aAmount or aAmount == 0 then return end
	
	dmg.playerid = dstGUID
	dmg.playername = dstName
	dmg.amount = aAmount
	dmg.school = spellSchool
	dmg.time = GetTime()
	
	log_reduction(Skada.current, dmg)
	log_reduction(Skada.total, dmg)
end

Skada:RegisterForCL(SpellDamage, "SPELL_DAMAGE", {dst_is_interesting_nopets = true})
Skada:RegisterForCL(SpellDamage, "SPELL_PERIODIC_DAMAGE", {dst_is_interesting_nopets = true})
Skada:RegisterForCL(SpellDamage, "RANGE_DAMAGE", {dst_is_interesting_nopets = true})
Skada:RegisterForCL(SwingDamage, "SWING_DAMAGE", {dst_is_interesting_nopets = true})
Skada:RegisterForCL(SpellAbsorbed, "SPELL_ABSORBED", {dst_is_interesting_nopets = true})

--------------------------------------------------------------------------------

local function SpellCast(_, _, srcGUID, srcName, _, dstGUID, dstName, _, ...)
	local spellId, spellName = ...
	
	-- Check if this is an interesting spell
	local effect = effects[spellId]
	if not effect then return end
	
	-- Set the localized name on first occurrence
	if not effect.name then
		effect.name = spellName
		effect.auraname = GetSpellInfo(effect.aura or spellId)
	end
	
	local now = GetTime()
	
	-- Raid-wide effect
	if raid_effects[spellId] then
		raid_effects_active[spellId] = {
			sourceid = srcGUID,
			sourcename = srcName,
			applied = now,
			expire = now + effect.duration + 0.5,
			cache = {}
		}
		return
	end
	
	-- Select the correct target player
	local target_player
	if personnal_effects[spellId] then
		target_player = srcGUID
	elseif external_effects[spellId] then
		target_player = dstGUID
	end
	
	if not target_player then return end
	
	-- Load player effects
	local player_effects = players_effects_active[target_player]
	if not player_effects then
		player_effects = {}
		players_effects_active[target_player] = player_effects
	end
	
	-- Register this spell
	player_effects[spellId] = {
		sourceid = srcGUID,
		sourcename = srcName,
		applied = now,
		expire = now + effect.duration + 0.5,
		cache = {}
	}
end

Skada:RegisterForCL(SpellCast, "SPELL_CAST_SUCCESS", {src_is_interesting_nopets = true})
