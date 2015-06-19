--[[--------------------------------------------------------------------
	GridStatusHealingReduced
	Grid plugin to show debuffs which reduce or prevent healing received.
	Copyright (c) 2007-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info7364-GridStatusHealingReduced.html
	http://www.curse.com/addons/wow/gridstatushealingreduced
	https://github.com/Phanx/GridStatusHealingReduced
----------------------------------------------------------------------]]

local _, ns = ...

ns.ReductionDebuffs = {
	--[[ CLASSIC - RAID ]]
	23169,  -- Brood Affliction: Green (Chromaggus in Blackwing Lair)
	19716,  -- Gehennas' Curse (Gehennas in Molten Core)
	22687,  -- Veil of Shadow (Nefarian in Blackwing Lair)

	--[[ CLASSIC - PARTY ]]
	27580,  -- Mortal Strike (Theldren in Blackrock Depths)
	17820,  -- Veil of Shadow (Lord Alexei Barov in Scholomance)

	--[[ CLASSIC - SOLO ]]
	13583,  -- Curse of the Deadwood (Deadwood furbolgs in Felwood)
	83930,  -- Grog-soaked Blade (Fleet Master Firallon in The Cape of Stranglethorn)

	--[[ THE BURNING CRUSADE - RAID ]]
	40599,  -- Arcing Smash (Gurtogg Bloodboil in Black Temple)
	41478,  -- Dampen Magic (High Nethermancer Zerevor in Black Temple)
	45347,  -- Dark Touched (Lady Sacrolash in Sunwell Plateau)
	45996,  -- Darkness (M’uru in Sunwell Plateau)
	38572,  -- Mortal Cleave (Vashj'ir Honor Guard in Serpentshrine Cavern)
	29572,  -- Mortal Strike (Lord Robin Daris in Karazhan)
	46296,  -- Necrotic Poison (Cataclysm Hound in Sunwell Plateau)
	30423,  -- Nether Portal - Dominance (Netherspite in Karazhan)
	45885,  -- Shadow Spike (Kil'jaeden in Sunwell Plateau)
	39665,  -- Wound Poison (Illidari Boneslicer; Shadowmoon Weapon Master in Black Temple)

	--[[ THE BURNING CRUSADE - PARTY ]]
	36023,  -- Deathblow (Shattered Hand Savage in The Shattered Halls)
	36054,  -- Deathblow (Shattered Hand Savage in The Shattered Halls)
	34366,  -- Ebon Poison (Blackfang Tarantula in The Black Morass)
	59513,  -- Embrace of the Vampyr (Prince Taldaram in Ahn'kahet: The Old Kingdom)
	36917,  -- Magma-Thrower's Curse (Sulfuron Magma-Thrower in The Arcatraz)
	31911,  -- Mortal Strike (Lieutenant Drake in Old Hillsbrad Foothills)
	37335,  -- Mortal Strike (Stolen Soul in Auchenai Crypts)
	44268,  -- Mortal Strike (Warlord Salaris in Magisters' Terrace)
	30641,  -- Mortal Wound (Watchkeeper Gargolmar in Hellfire Ramparts)
	36814,  -- Mortal Wound (Watchkeeper Gargolmar in Hellfire Ramparts)
	31464,  -- Mortal Wound (Temporus in The Black Morass)
	36693,  -- Necrotic Poison (Entropic Eye in The Arcatraz)
	35189,  -- Solar Strike (Bloodwarder Slayer in The Mechanar)
	32858,  -- Touch of the Forgotten (Auchenai Soulpriest in Auchenai Crypts)
	38377,  -- Touch of the Forgotten (Auchenai Soulpriest in Auchenai Crypts)
	44534,  -- Wretched Strike (Wretched Bruiser in Magisters' Terrace)

	--[[ THE BURNING CRUSADE - SOLO ]]
	34073,  -- Curse of the Bleeding Hollow (Bleeding Hollow Necrolyte in Hellfire Peninsula)
	34625,  -- Demolish (Negatron in Netherstorm)
	32378,  -- Filet (Warmaul Chef Bufferlo in Nagrand)
	30984,  -- Wound Poison (Chieftain Mummaki in Zangarmarsh)

	--[[ WRATH OF THE LICH KING - RAID ]]
	65883,  -- Aimed Shot (Alyssia Moonstalker; Ruj'kah in Trial of the Crusader)
	63038,  -- Dark Volley (Guardian of Yogg-Saron in Ulduar)
	70671,  -- Leeching Rot (Vampiric Fiend in Icecrown Citadel)
	70710,  -- Leeching Rot (Empowered Vampiric Fiend in Icecrown Citadel)
	65926,  -- Mortal Strike (Shocuul; Narrhok Steelbreaker in Trial of the Crusader)
	67542,  -- Mortal Strike (Marshal Jacob Alerius; Mokra the Skullcrusher in Trial of the Crusader)
	71552,  -- Mortal Strike (Captain Grondel in Icecrown Citadel)
	28467,  -- Mortal Wound (Unstoppable Abomination in Naxxramas)
	54378,  -- Mortal Wound (Gluth in Naxxramas)
	71127,  -- Mortal Wound (Precious; Stinky in Icecrown Citadel)
	69674,  -- Mutated Infection (Rotface in Icecrown Citadel)
	28776,  -- Necrotic Poison (Maexxna; Maexxna Spiderling in Naxxramas)
	54121,  -- Necrotic Poison (Maexxna; Maexxna Spiderling in Naxxramas)
	70588,  -- Suppression (Suppresser in Icecrown Citadel)
	53803,  -- Veil of Shadow (Dread Creeper in Naxxramas)
	28440,  -- Veil of Shadow (Dread Creeper in Naxxramas)
	65962,  -- Wound Poison (Irieth Shadowstep; Maz'dinah in Trial of the Crusader)
	69651,  -- Wounding Strike (Kor'kron Sergeant; Skybreaker Sergeant in Icecrown Citadel)

	--[[ WRATH OF THE LICH KING - PARTY ]]
	48871,  -- Aimed Shot (Ymirjar Flesh Hunter in Utgarde Pinnacle)
	59243,  -- Aimed Shot (Ymirjar Flesh Hunter in Utgarde Pinnacle)
	48291,  -- Fetid Rot (King Ymiron in Utgarde Pinnacle)
	59300,  -- Fetid Rot (King Ymiron in Utgarde Pinnacle)
	57789,  -- Mortal Strike (Twisted Visage in Ahn'kahet: The Old Kingdom)
	54716,  -- Mortal Strikes (Drakkari Colossus in Gundrak)
	59455,  -- Mortal Strikes (Drakkari Colossus in Gundrak)
	59265,  -- Mortal Wound (Frenzied Worgen in Utgarde Pinnacle)
	59525,  -- Ray of Pain (Moragg; Chaos Watcher in The Violet Hold)
	54525,  -- Shroud of Darkness (Zuramat the Obliterator in The Violet Hold)
	59746,  -- Shroud of Darkness (Zuramat the Obliterator; Void Lord in The Violet Hold)
	54074,  -- Wound Poison (Phantasmal Murloc in The Oculus)
	52771,  -- Wounding Strike (Chrono-Lord Epoch in The Culling of Stratholme)
	58830,  -- Wounding Strike (Chrono-Lord Epoch in The Culling of Stratholme)

	--[[ WRATH OF THE LICH KING - SOLO ]]
	54615,  -- Aimed Shot (Shandaral Hunter Spirit in Crystalsong Forest)
	60626,  -- Necrotic Strike (Undying Minion in Icecrown)

	--[[ CATACLYSM - RAID ]]
	100526, -- Blistering Wound (Flamewaker Subjugator in Firelands)
	98443,  -- Fiery Cyclone (Majordomo Staghelm in Firelands)
	83908,  -- Malevolent Strikes (Halfus Wyrmbreaker in The Bastion of Twilight)
	103002, -- Mortal Strike (Twilight Bruiser in Hour of Twilight)
	80390,  -- Mortal Strike (Drakonid Slayer in Blackwing Descent)
	43441,  -- Mortal Strike (Hex Lord Malacrass in Zul'Aman)
	99476,  -- The Widow's Kiss (Beth'tilac in Firelands)
	99506,  -- The Widow's Kiss (Beth'tilac in Firelands)
	43461,  -- Wound Poison (Hex Lord Malacrass in Zul'Aman)

	--[[ CATACLYSM - PARTY ]]
	76189,  -- Crepuscular Veil (Shadow of Obsidius in Blackrock Caverns)
	93956,  -- Cursed Veil (Baron Silverlaine in Shadowfang Keep)
	88010,  -- Cyclone (Wild Vortex in Vortex Pinnacle)
	91801,  -- Mortal Strike (Wailing Guardsman in Shadowfang Keep)
	93675,  -- Mortal Wound (Lord Godfrey in Shadowfang Keep)
	91099,  -- Rotting Bile (Corpse Eater in Shadowfang Keep)
	23224,  -- Veil of Shadow (Baron Silverlaine in Shadowfang Keep)
	83926,  -- Veil of Shadow (Vicious Mindlasher in Throne of the Tides)
	75571,  -- Wounding Strike (Rom'ogg Bonecrusher in Blackrock Caverns)

	--[[ CATACLYSM - SOLO ]]
	86816,  -- Giant's Bane (Dragul Giantbutcher in Deepholm)
	93082,  -- Nerfbat (Ghostcrawler in Abyssal Depths)

	--[[ MISTS OF PANDARIA - RAID ]]
	148375, -- Brutal Hemorrhage (Gate-Crasher Sav'ah in Siege of Orgrimmar)
	117949, -- Closed Circuit (Celestial Protector in Mogu’shan Vaults)
	126901, -- Mortal Rend (Kor'thik Fleshrender in Heart of Fear)
	136670, -- Mortal Strike (Drakkari Frozen Warlord in Throne of Thunder)
	115804, -- Mortal Wounds (Sha of Anger, monk, warrior)
	139550, -- Torment (Tormented Spirit, Throne of Thunder)
	140049, -- Wounding Strike (Zandalari Blade Initiate in Throne of Thunder)
	144056, -- Xuen's Presence: Mortal Strike

	--[[ MISTS OF PANDARIA - PARTY ]]
	133001, -- Gas Bomb (Rak'gor Bloodrazor in Dagger in the Dark)
	121910, -- Scurvy (Ookie in Unga Ingoo)
	110125, -- Shattered Resolve (Minion of Doubt in Temple of the Jade Serpent)
	119354, -- Sik'thik Strike (Sik'thik Bladedancer in Siege of Niuzao Temple)
	123655, -- Traumatic Blow (Haiyan the Unstoppable in Mogu'shan Palace)
	142201, -- Veil of Darkness (Echo of Y'Shaarj in Dark Heart of Pandaria)
	142561, -- Venom Cloud (Huntmaster S'thoc in A Brewing Storm)

	--[[ MISTS OF PANDARIA - SOLO ]]
	118228, -- Aimed Shot (Osul Veteran Archer in Kun-Lai Summit; Wildscale Hunter in Valley of the Four Winds)
	111826, -- Ancient Poison (Krasari Tormentor in Krasarang Wilds)
	139010, -- Darkest Darkness (Mumta in Isle of Thunder)
	126195, -- Dirty Mouth (Vicejaw in Vale of Eternal Blossoms)
	122078, -- Fear of Darkness (Dreadling in Townlong Steppes)
	129564, -- Fiery Strike (Bataari Fire-Warrior in Kun-Lai Summit)
	125353, -- Rank Bite (turtles in Kun-Lai Summit; Townlong Steppes)
	128964, -- Rune of Suffering (Krasari Runekeeper in Krasarang Wilds)

	--[[ WARLORDS OF DRAENOR - RAID ]]

	--[[ WARLORDS OF DRAENOR - PARTY ]]

	--[[ WARLORDS OF DRAENOR - SOLO ]]
	170221, -- Elemental Fragment (conjured item)
	170466, -- Shadow Slash (Lady Temptessa in Shadowmoon Valley)

	--[[ PLAYERS ]]
	33786,  -- Cyclone (Druid)
	30213,  -- Legion Strike (Warlock Felguard)
	54680,  -- Monstrous Bite (Hunter Devilsaur)
	115625, -- Mortal Cleave (Warlock Wrathguard)
	12294,  -- Mortal Strike (Warior, Arms)
	8680,   -- Wound Poison (Rogue)

	--[[ PVP NPCs ]]
	76727,  -- Mortal Strike (Twilight Armsmaster in Grim Batol)
	112055, -- Orb of Power (Power Orb in Temple of Kotmogu)
	121164, -- Orb of Power (Power Orb in Temple of Kotmogu)
	121175, -- Orb of Power (Power Orb in Temple of Kotmogu)
	121176, -- Orb of Power (Power Orb in Temple of Kotmogu)
	121177, -- Orb of Power (Power Orb in Temple of Kotmogu)
	127959, -- Orb of Power (Power Orb in Temple of Kotmogu)

	--[[ VARIOUS NPCS ]]
	78841,  -- Aimed Shot
	43410,  -- Chop
	44475,  -- Magic Dampening Field
	22859,  -- Mortal Cleave
	32736,  -- Mortal Strike
	13737,  -- Mortal Strike
	15708,  -- Mortal Strike
	16856,  -- Mortal Strike
	17547,  -- Mortal Strike
	19643,  -- Mortal Strike
	24573,  -- Mortal Strike
	35054,  -- Mortal Strike
	38770,  -- Mortal Wound
	48137,  -- Mortal Wound
	32315,  -- Soul Strike
	7068,   -- Veil of Shadow
	69633,  -- Veil of Shadow
	36974,  -- Wound Poison

	--[[ UNKNOWN ]]
	161242, -- Caustic Energy WOD?
	166766, -- Crippling Blow WOD?
	164479, -- Festering Wound WOD?
	174439, -- Fierce Bludgeoning WOD?
	174564, -- Fungal Burst WOD?
	175624, -- Grievous Mortal Wounds WOD?
	173240, -- Grievous Strike WOD?
	171527, -- Infected Wound WOD?
	39595,  -- Mortal Cleave
	177147, -- Mortal Cleave WOD?
	61042,  -- Mortal Smash
	40220,  -- Mortal Strike
	120436, -- Mortal Strike
	164457, -- Mortal Strike WOD?
	164466, -- Mortal Strike WOD?
	172769, -- Mortal Strike WOD?
	177883, -- Mortal Strike WOD?
	135531, -- Reforged Soul
	133767, -- Serious Wound
	170567, -- Shadow Spike WOD?
	172941, -- Smash WOD?
	60084,  -- The Veil of Shadows
	115195, -- Toxic Shock
	68881,  -- Unstable Water Nova
	24674,  -- Veil of Shadow
	155586, -- Veil of Shadow WOD?
	174811, -- Void Expulsion WOD?
	136577, -- Wind Storm
	178050, -- Wound Poison WOD?
}

ns.PreventionDebuffs = {
	--[[ THE BURNING CRUSADE - RAID ]]
	41292,  -- Aura of Suffering (Essence of Suffering in Black Temple)
	30843,  -- Enfeeble (Prince Malchezaar in Karazhan)

	--[[ WRATH OF THE LICH KING - RAID ]]
	55593,  -- Necrotic Aura (Loatheb in Naxxramas)

	--[[ CATACLYSM - RAID ]]
	82170,  -- Corruption: Absolute (Cho'gall in The Bastion of Twilight)
	92787,  -- Engulfing Darkness (Maloriak in Blackwing Descent)
	82890,  -- Mortality (Chimaeron in Blackwing Descent
	85576,  -- Withering Winds (Anshal in Throne of the Four Winds)

	--[[ CATACLYSM - PARTY ]]
	76903,  -- Anti-Magic Prison (Void Seeker in Halls of Origination)

	--[[ CATACLYSM - SOLO ]]
	101497, -- Aura of Deth'spair (Deth'tilac in Molten Front)
	101340, -- Suffocating Prey (Kirix in Molten Front)

	--[[ MISTS OF PANDARIA - RAID ]]
	114078, -- HUGE, SHARP TEETH! (Darkmoon Rabbit in Darkmoon Island)
	148386, -- Black Ash (item on Timeless Isle)

	--[[ MISTS OF PANDARIA - PARTY]]
	127280, -- Viletongue Sting (Huntmaster S’thoc and Viletongue Skirmisher in A Brewing Storm)

	--[[ WARLORDS OF DRAENOR - SOLO ]]
	172624, -- Shrieking Winds (Kalandrios in Nagrand)
	176064, -- Sinister Spores (item)
	172622, -- Torrential Waters (Aborius in Nagrand)
	176059, -- Unleashed Mania (item)
	172618, -- Unrelenting Flames (Incerinatus in Nagrand)

	--[[ OTHER ]]
	172039, -- Luchador Costume (Day of the Dead holiday event costumes)

	--[[ UNKNOWN ]]
	145862, -- Banish WOD?
	160209, -- Cyclone WOD?
	84599,  -- Engulfed
	79335,  -- Frozen Solid
	159219, -- Necrotic Breath WOD?
	152773, -- Possession WOD?
	84597,  -- Rocked
	123648, -- Shock

}