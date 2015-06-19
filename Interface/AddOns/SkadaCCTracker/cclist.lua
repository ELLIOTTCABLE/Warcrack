---------------------------------------
-- Globals
---------------------------------------

local addonName, vars = ...

---------------------------------------
-- CC spell IDs. Shamelessly stolen from RecountCC!
---------------------------------------

vars.SkadaCCId = {
	-- Death Knight
	[47476] = true, -- Strangulate
	[49203] = true, -- Hungering Cold
	[96294] = true, -- Chains of Ice
	[108194] = true, -- Asphyxiate
	[91800] = true, -- Gnaw
	[91797] = true, -- Monstrous Blow
	[108200] = true, -- Remorseless Winter
	-- Druid
	-- Possibly missing Entangling Roots Treants (Balance)
	-- Missing Wild Charge's Immobilize in Bear Form
	[339] = true, -- Entangling Roots
	[102359] = true, -- Mass Entanglement
	[5211] = true, -- Mighty Bash
	[2637] = true, -- Hibernate
	[33786] = true, -- Cyclone
	[22570] = true, -- Maim
	[9005] = true, -- Pounce
	[102546] = true, -- Pounce
	[102795] = true, -- Bear Hug
	[99] = true, -- Disorienting Roar
	[113801] = true, -- Bash (Treants in feral spec)
	[16689] = true, -- Nature's Grasp
	-- Hunter
	[19503] = true, -- Scatter Shot
	[19386] = true, -- Wyvern Sting
	-- Looks wrong [1499] = true, -- Freezing Trap
	[3355] = true, -- Freezing Trap
	[128405] = true, -- Narrow Escape
	[50245] = true, -- Pin (Crab)
	[4167] = true, -- Web (Spider)
	[90327] = true, -- Lock Jaw (Dog)
	[54706] = true, -- Venom Web Spray (Silithid)
	[117526] = true, -- Binding Shot
	[24394] = true, -- Intimidation
	[90337] = true, -- Bad Manner (Monkey)
	[50519] = true, -- Sonic Blast (Bat)
	[91644] = true, -- Snatch (Bird of Prey)
	[50541] = true, -- Clench (Scorpid)
	[1513] = true, -- Scare Beast
	[34490] = true, -- Silencing Shot
	[64803] = true, -- Entrapment
	-- Mage
	[118] = true, -- Polymorph
	[61305] = true, -- Polymorph Black Cat
	[28272] = true, -- Polymorph Pig
	[61721] = true, -- Polymorph Rabbit
	[61780] = true, -- Polymorph Turkey
	[28271] = true, -- Polymorph Turtle
	[82691] = true, -- Ring of Frost
	[31661] = true, -- Dragon's Breath
	[44572] = true, -- Deep Freeze
	[122] = true, -- Frost Nova
	[33395] = true, -- Freeze (Frost Water Elemental)
	[118271] = true, -- Combustion
	[102051] = true, -- Frostjaw
	[55021] = true, -- Silenced Improved Counterspell
	[111340] = true, -- Ice Ward
	-- Monk
	[116706] = true, -- Disable
	[119392] = true, -- Charging Ox Wave
	[119381] = true, -- Leg Sweep
	[122242] = true, -- Clash
	[120086] = true, -- Fists of Fury
	[117368] = true, -- Grapple Weapon
	[115078] = true, -- Paralysis
	[116709] = true, -- Spear Hand Strike
	-- Paladin
	-- Missing Glyph of Blinding Light Stun
	[853] = true, -- Hammer of Justice
	[105593] = true, -- Fist of Justice
	[10326] = true, -- Turn Evil
	[20066] = true, -- Repentance
	[119072] = true, -- Holy Wrath
	[31935] = true, -- Avengers Shield
	[105421] = true, -- Blinding Light
	-- Priest
	[8122] = true, -- Psychic Scream
	[9484] = true, -- Shackle Undead
	[605] = true, -- Dominate Mind (Mind Control)
	[15487] = true, -- Silence
	[64044] = true, -- Psychic Horror
	[114404] = true, -- Void Tendril's Grasp
	[113792] = true, -- Psychic Terror
	[131556] = true, -- Sin and Punishment
	-- Rogue
	[6770] = true, -- Sap
	[408] = true, -- Kidney Shot
	[2094] = true, -- Blind
	[51722] = true, -- Dismantle
	[1833] = true, -- Cheap Shot
	[115197] = true, -- Partial Paralysis (Paralytic Poison Shiv effect)
	[113953] = true, -- Paralysis
	[51722] = true, -- Dismantle
	[1776] = true, -- Gouge
	[703] = true, -- Garrote
	-- Shaman
	[76780] = true, -- Bind Elemental
	[51514] = true, -- Hex
	[63685] = true, -- Freeze (Frost Shock)
	[118905] = true, -- Static Charge (Capacitor Totem)
	[64695] = true, -- Earthgrab
	[77505] = true, -- Earthquake
	-- Warlock
	[118699] = true, -- Fear
	[5484] = true, -- Howl of Terror
	[30283] = true, -- Shadowfury
	[103131] = true, -- Felguard: Axe Toss
	[118093] = true, -- Voidwalker: Disarm
	[6358] = true, -- Seduction
	[115268] = true, -- Mesmerize
	[22703] = true, -- Infernal Awakening
	[6789] = true, -- Mortal Coil
	[24259] = true, -- Spell Lock
	[115782] = true, -- Optical Blast
	[710] = true, -- Banish
	-- Warrior
	[676] = true, -- Disarm
	[5246] = true, -- Initmidating Shout
	[85388] = true, -- Throwdown
	[12809] = true, -- Concussion Blow
	[107566] = true, -- Staggering Shout
	[132168] = true, -- Shockwave
	[105771] = true, -- Warbringer (Charge Stun)
	[107570] = true, -- Storm Bolt
	[118895] = true, -- Dragon Roar
	[6552] = true, -- Pummel
	[57755] = true, -- Heroic Throw
	[100] = true, -- Charge
	-- Racials
	[20549] = true, -- War Stomp
	[129597] = true, -- Arcane Torrent
	[107079] = true, -- Quaking Palm
	-- Symbiosis
	[113506] = true, -- Cyclone
	[127361] = true, -- Bear Hug
	[110693] = true, -- Frost Nova
	[126458] = true, -- Grapple Weapon
	[126449] = true, -- Clash
	[110698] = true, -- Hammer of Justice
	[113004] = true, -- Intimidating Roar
}
