-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2015 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
--
-- Wowhead scales
------------------------------------------------------------

local ScaleProviderName = "Wowhead"

function PawnWowheadScaleProvider_AddScales()




------------------------------------------------------------
-- Warrior
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"WarriorArms",
	PawnLocal.Wowhead.WarriorArms,
	"c79c6e",
	{
		["Strength"] = 100, ["CritRating"] = 49, ["Multistrike"] = 37, ["MasteryRating"] = 36, ["Versatility"] = 33, ["HasteRating"] = 32, ["Stamina"] = .1, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarriorFury",
	PawnLocal.Wowhead.WarriorFury,
	"c79c6e",
	{
		["Strength"] = 100, ["CritRating"] = 52, ["Multistrike"] = 50, ["MasteryRating"] = 45, ["HasteRating"] = 38, ["Versatility"] = 36, ["Stamina"] = .1, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarriorTank",
	PawnLocal.Wowhead.WarriorTank,
	"c79c6e",
	{
		["Stamina"] = 100, ["BonusArmor"] = 42, ["Armor"] = 39, ["Versatility"] = 18, ["Strength"] = 13, ["MasteryRating"] = 13, ["CritRating"] = 13, ["Multistrike"] = 6, ["HasteRating"] = 3, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

------------------------------------------------------------
-- Paladin
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"PaladinHoly",
	PawnLocal.Wowhead.PaladinHoly,
	"f58cba",
	{
		["Intellect"] = 100, ["CritRating"] = 76, ["Multistrike"] = 57, ["MasteryRating"] = 47, ["Versatility"] = 37, ["HasteRating"] = 28, ["Spirit"] = 18, ["Stamina"] = .1, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"PaladinTank",
	PawnLocal.Wowhead.PaladinTank,
	"f58cba",
	{
		["Stamina"] = 100, ["BonusArmor"] = 57, ["Armor"] = 39, ["Strength"] = 30, ["Versatility"] = 25, ["MasteryRating"] = 22, ["HasteRating"] = 19, ["CritRating"] = 15, ["Multistrike"] = 12, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"PaladinRetribution",
	PawnLocal.Wowhead.PaladinRetribution,
	"f58cba",
	{
		["Strength"] = 100, ["MasteryRating"] = 43, ["Multistrike"] = 40, ["CritRating"] = 35, ["Versatility"] = 34, ["HasteRating"] = 29, ["Stamina"] = .1, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	1 -- hide 1H upgrades
)

------------------------------------------------------------
-- Hunter
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"HunterBeastMastery",
	PawnLocal.Wowhead.HunterBeastMastery,
	"abd473",
	{
		["Agility"] = 100, ["Multistrike"] = 34, ["CritRating"] = 32, ["MasteryRating"] = 32, ["Versatility"] = 31, ["HasteRating"] = 28, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsShield"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsOffHand"] = -1000000, ["IsDagger"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["IsFist"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"HunterMarksman",
	PawnLocal.Wowhead.HunterMarksman,
	"abd473",
	{
		["Agility"] = 100, ["Multistrike"] = 38, ["CritRating"] = 33, ["Versatility"] = 32, ["MasteryRating"] = 26, ["HasteRating"] = 26, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsShield"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsOffHand"] = -1000000, ["IsDagger"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["IsFist"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"HunterSurvival",
	PawnLocal.Wowhead.HunterSurvival,
	"abd473",
	{
		["Agility"] = 100, ["Multistrike"] = 38, ["CritRating"] = 29, ["Versatility"] = 29, ["MasteryRating"] = 19, ["HasteRating"] = 18, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsShield"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsOffHand"] = -1000000, ["IsDagger"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["IsFist"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------
-- Rogue
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"RogueCombat",
	PawnLocal.Wowhead.RogueCombat,
	"fff569",
	{
		["Agility"] = 100, ["HasteRating"] = 36, ["Multistrike"] = 34, ["MasteryRating"] = 31, ["CritRating"] = 29, ["Versatility"] = 29, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["Is2HSword"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"RogueAssassination",
	PawnLocal.Wowhead.RogueAssassination,
	"fff569",
	{
		["Agility"] = 100, ["Multistrike"] = 34, ["CritRating"] = 32, ["MasteryRating"] = 32, ["Versatility"] = 28, ["HasteRating"] = 27, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["Is2HSword"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["IsSword"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"RogueSubtlety",
	PawnLocal.Wowhead.RogueSubtlety,
	"fff569",
	{
		["Agility"] = 100, ["Multistrike"] = 39, ["MasteryRating"] = 37, ["CritRating"] = 30, ["Versatility"] = 29, ["HasteRating"] = 28, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["Is2HSword"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

------------------------------------------------------------
-- Priest
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"PriestDiscipline",
	PawnLocal.Wowhead.PriestDiscipline,
	"e0e0e0",
	{
		["Intellect"] = 100, ["CritRating"] = 67, ["MasteryRating"] = 62, ["Multistrike"] = 48, ["Versatility"] = 38, ["HasteRating"] = 29, ["Spirit"] = 18, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HMace"] = -1000000, ["IsOffHand"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"PriestHoly",
	PawnLocal.Wowhead.PriestHoly,
	"e0e0e0",
	{
		["Intellect"] = 100, ["Multistrike"] = 66, ["MasteryRating"] = 56, ["CritRating"] = 47, ["Versatility"] = 36, ["HasteRating"] = 27, ["Spirit"] = 17, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HMace"] = -1000000, ["IsOffHand"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"PriestShadow",
	PawnLocal.Wowhead.PriestShadow,
	"e0e0e0",
	{
		["Intellect"] = 100, ["MasteryRating"] = 42, ["HasteRating"] = 40, ["CritRating"] = 36, ["Multistrike"] = 36, ["Versatility"] = 32, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HMace"] = -1000000, ["IsOffHand"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------
-- DK
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightBloodTank",
	PawnLocal.Wowhead.DeathKnightBloodTank,
	"ff4d6b",
	{
		["Stamina"] = 100, ["Armor"] = 60, ["BonusArmor"] = 57, ["Multistrike"] = 27, ["HasteRating"] = 25, ["Strength"] = 23, ["Versatility"] = 22, ["MasteryRating"] = 13, ["CritRating"] = 12, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightFrostDps",
	PawnLocal.Wowhead.DeathKnightFrostDps,
	"ff4d6b",
	{
		["Strength"] = 100, ["MasteryRating"] = 41, ["Multistrike"] = 34, ["Versatility"] = 31, ["CritRating"] = 27, ["HasteRating"] = 24, ["Stamina"] = .1, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightUnholyDps",
	PawnLocal.Wowhead.DeathKnightUnholyDps,
	"ff4d6b",
	{
		["Strength"] = 100, ["Multistrike"] = 45, ["MasteryRating"] = 44, ["CritRating"] = 34, ["Versatility"] = 31, ["HasteRating"] = 25, ["Stamina"] = .1, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	1 -- hide 1H upgrades
)

------------------------------------------------------------
-- Shaman
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"ShamanElemental",
	PawnLocal.Wowhead.ShamanElemental,
	"6e95ff",
	{
		["Intellect"] = 100, ["Multistrike"] = 41, ["CritRating"] = 37, ["HasteRating"] = 34, ["MasteryRating"] = 33, ["Versatility"] = 31, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"ShamanEnhancement",
	PawnLocal.Wowhead.ShamanEnhancement,
	"6e95ff",
	{
		["Agility"] = 100, ["Multistrike"] = 34, ["MasteryRating"] = 32, ["HasteRating"] = 31, ["CritRating"] = 30, ["Versatility"] = 29, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"ShamanRestoration",
	PawnLocal.Wowhead.ShamanRestoration,
	"6e95ff",
	{
		["Intellect"] = 100, ["CritRating"] = 67, ["MasteryRating"] = 57, ["Multistrike"] = 47, ["Versatility"] = 37, ["HasteRating"] = 28, ["Spirit"] = 18, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------
-- Mage
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"MageArcane",
	PawnLocal.Wowhead.MageArcane,
	"69ccf0",
	{
		["Intellect"] = 100, ["MasteryRating"] = 45, ["Multistrike"] = 38, ["HasteRating"] = 36, ["CritRating"] = 36, ["Versatility"] = 32, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"MageFire",
	PawnLocal.Wowhead.MageFire,
	"69ccf0",
	{
		["Intellect"] = 100, ["CritRating"] = 59, ["MasteryRating"] = 42, ["Multistrike"] = 39, ["HasteRating"] = 38, ["Versatility"] = 31, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"MageFrost",
	PawnLocal.Wowhead.MageFrost,
	"69ccf0",
	{
		["Intellect"] = 100, ["Multistrike"] = 47, ["CritRating"] = 37, ["Versatility"] = 35, ["HasteRating"] = 28, ["MasteryRating"] = 27, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------
-- Warlock
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"WarlockAffliction",
	PawnLocal.Wowhead.WarlockAffliction,
	"bca5ff",
	{
		["Intellect"] = 100, ["MasteryRating"] = 42, ["HasteRating"] = 38, ["CritRating"] = 35, ["Multistrike"] = 35, ["Versatility"] = 31, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarlockDemonology",
	PawnLocal.Wowhead.WarlockDemonology,
	"bca5ff",
	{
		["Intellect"] = 100, ["HasteRating"] = 43, ["CritRating"] = 38, ["Multistrike"] = 37, ["MasteryRating"] = 36, ["Versatility"] = 32, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarlockDestruction",
	PawnLocal.Wowhead.WarlockDestruction,
	"bca5ff",
	{
		["Intellect"] = 100, ["CritRating"] = 37, ["Multistrike"] = 36, ["HasteRating"] = 33, ["MasteryRating"] = 33, ["Versatility"] = 31, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------
-- Monk
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"MonkBrewmaster",
	PawnLocal.Wowhead.MonkBrewmaster,
	"00ff96",
	{
		["Stamina"] = 100, ["Armor"] = 90, ["BonusArmor"] = 60, ["MasteryRating"] = 32, ["Agility"] = 30, ["Versatility"] = 25, ["HasteRating"] = 20, ["CritRating"] = 17, ["Multistrike"] = 15, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"MonkMistweaver",
	PawnLocal.Wowhead.MonkMistweaver,
	"00ff96",
	{
		["Intellect"] = 100, ["Multistrike"] = 76, ["CritRating"] = 66, ["Versatility"] = 47, ["HasteRating"] = 36, ["MasteryRating"] = 27, ["Spirit"] = 17, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"MonkWindwalker",
	PawnLocal.Wowhead.MonkWindwalker,
	"00ff96",
	{
		["Agility"] = 100, ["Multistrike"] = 38, ["CritRating"] = 34, ["Versatility"] = 34, ["HasteRating"] = 30, ["MasteryRating"] = 12, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------
-- Druid
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"DruidBalance",
	PawnLocal.Wowhead.DruidBalance,
	"ff7d0a",
	{
		["Intellect"] = 100, ["CritRating"] = 38, ["MasteryRating"] = 38, ["HasteRating"] = 37, ["Multistrike"] = 37, ["Versatility"] = 30, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

PawnAddPluginScale(
	ScaleProviderName,
	"DruidFeralDps",
	PawnLocal.Wowhead.DruidFeralDps,
	"ff7d0a",
	{
		["Agility"] = 100, ["CritRating"] = 36, ["Multistrike"] = 34, ["HasteRating"] = 31, ["Versatility"] = 30, ["MasteryRating"] = 28, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"DruidFeralTank",
	PawnLocal.Wowhead.DruidFeralTank,
	"ff7d0a",
	{
		["Armor"] = 100, ["Stamina"] = 89, ["Multistrike"] = 61, ["BonusArmor"] = 41, ["MasteryRating"] = 28, ["Versatility"] = 23, ["Agility"] = 19, ["HasteRating"] = 8, ["CritRating"] = 5, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1, -- normalize values
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"DruidRestoration",
	PawnLocal.Wowhead.DruidRestoration,
	"ff7d0a",
	{
		["Intellect"] = 100, ["HasteRating"] = 51, ["MasteryRating"] = 46, ["Multistrike"] = 41, ["CritRating"] = 26, ["Versatility"] = 21, ["Spirit"] = 16, ["Stamina"] = .1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 16000
	},
	1 -- normalize values
)

------------------------------------------------------------

-- PawnWowheadScaleProviderOptions.LastAdded keeps track of the last time that we tried to automatically enable scales for this character.
if not PawnWowheadScaleProviderOptions then PawnWowheadScaleProviderOptions = { } end
if not PawnWowheadScaleProviderOptions.LastAdded then PawnWowheadScaleProviderOptions.LastAdded = 0 end

local _, Class = UnitClass("player")
if PawnWowheadScaleProviderOptions.LastClass ~= nil and Class ~= PawnWowheadScaleProviderOptions.LastClass then
	-- If the character has changed class since last time, let's start over.
	PawnSetAllScaleProviderScalesVisible(ScaleProviderName, false)
	PawnWowheadScaleProviderOptions.LastAdded = 0
end
PawnWowheadScaleProviderOptions.LastClass = Class

if PawnWowheadScaleProviderOptions.LastAdded < 1 then
	if Class == "WARRIOR" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarriorFury"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarriorTank"), true)
	elseif Class == "PALADIN" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PaladinHoly"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PaladinTank"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PaladinRetribution"), true)
	elseif Class == "HUNTER" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "HunterBeastMastery"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "HunterMarksman"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "HunterSurvival"), true)
	elseif Class == "ROGUE" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "RogueAssassination"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "RogueCombat"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "RogueSubtlety"), true)
	elseif Class == "PRIEST" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PriestDiscipline"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PriestHoly"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PriestShadow"), true)
	elseif Class == "DEATHKNIGHT" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DeathKnightBloodTank"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DeathKnightFrostDps"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DeathKnightUnholyDps"), true)
	elseif Class == "SHAMAN" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "ShamanElemental"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "ShamanEnhancement"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "ShamanRestoration"), true)
	elseif Class == "MAGE" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MageArcane"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MageFire"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MageFrost"), true)
	elseif Class == "WARLOCK" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarlockAffliction"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarlockDemonology"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarlockDestruction"), true)
	elseif Class == "DRUID" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidBalance"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidFeralDps"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidFeralTank"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidRestoration"), true)
	end
end

if PawnWowheadScaleProviderOptions.LastAdded < 2 then
	if Class == "WARRIOR" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarriorArms"), true)
	end
end

if PawnWowheadScaleProviderOptions.LastAdded < 3 then
	if Class == "MONK" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MonkBrewmaster"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MonkMistweaver"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MonkWindwalker"), true)
	end
end

-- Don't reenable those scales again after the user has disabled them previously.
PawnWowheadScaleProviderOptions.LastAdded = 3

-- After this function terminates there's no need for it anymore, so cause it to self-destruct to save memory.
PawnWowheadScaleProvider_AddScales = nil

end -- PawnWowheadScaleProvider_AddScales

------------------------------------------------------------

PawnAddPluginScaleProvider(ScaleProviderName, PawnLocal.Wowhead.Provider, PawnWowheadScaleProvider_AddScales)
