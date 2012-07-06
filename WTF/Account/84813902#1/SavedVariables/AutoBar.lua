
AutoBarDB = {
	["classes"] = {
		["Mage"] = {
			["barList"] = {
				["AutoBarClassBarMage"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 300,
					["hide"] = false,
					["enabled"] = true,
					["columns"] = 10,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonStealth", -- [2]
						"AutoBarButtonClassBuff", -- [3]
						"AutoBarButtonConjure", -- [4]
						"AutoBarButtonClassPets2", -- [5]
						"AutoBarButtonClassPet", -- [6]
						"AutoBarButtonER", -- [7]
						"AutoBarButtonClassPets3", -- [8]
						"AutoBarButtonDebuff", -- [9]
					},
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["MAGE"] = true,
					["posY"] = 280,
					["scale"] = 1,
					["popupDirection"] = "1",
					["padding"] = 0,
					["dockShiftX"] = 0,
					["frameStrata"] = "LOW",
				},
			},
			["buttonList"] = {
				["AutoBarButtonBuffWeapon2"] = {
					["barKey"] = "AutoBarClassBarBasic",
					["buttonClass"] = "AutoBarButtonBuffWeapon",
					["invertButtons"] = true,
					["arrangeOnUse"] = true,
					["enabled"] = false,
					["buttonKey"] = "AutoBarButtonBuffWeapon2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonShields"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonStealth"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonStealth",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonStealth",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonDebuff"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonDebuff",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonDebuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonConjure"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonConjure",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonConjure",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonER",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets2"] = {
					["barKey"] = "AutoBarClassBarMage",
					["buttonClass"] = "AutoBarButtonClassPets2",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets2",
					["defaultButtonIndex"] = "*",
				},
			},
		},
	},
	["chars"] = {
		["Mochaa - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["SetBest"] = nil --[[ skipped inline function ]],
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
	},
	["account"] = {
		["customCategoriesVersion"] = 3,
		["barList"] = {
			["AutoBarClassBarBasic"] = {
				["popupDirection"] = "1",
				["fadeOut"] = false,
				["PALADIN"] = true,
				["buttonHeight"] = 36,
				["rows"] = 1,
				["dockShiftY"] = 0,
				["buttonKeys"] = {
					"AutoBarButtonHearth", -- [1]
					"AutoBarButtonMount", -- [2]
					"AutoBarButtonBandages", -- [3]
					"AutoBarButtonHeal", -- [4]
					"AutoBarButtonRecovery", -- [5]
					"AutoBarButtonCooldownPotionHealth", -- [6]
					"AutoBarButtonCooldownPotionMana", -- [7]
					"AutoBarButtonCooldownPotionRejuvenation", -- [8]
					"AutoBarButtonCooldownPotionCombat", -- [9]
					"AutoBarButtonCooldownStoneHealth", -- [10]
					"AutoBarButtonCooldownStoneMana", -- [11]
					"AutoBarButtonCooldownStoneCombat", -- [12]
					"AutoBarButtonCooldownDrums", -- [13]
					"AutoBarButtonFood", -- [14]
					"AutoBarButtonWater", -- [15]
					"AutoBarButtonWaterBuff", -- [16]
					"AutoBarButtonFoodBuff", -- [17]
					"AutoBarButtonFoodCombo", -- [18]
					"AutoBarButtonBuff", -- [19]
					"AutoBarButtonBuffWeapon1", -- [20]
					"AutoBarButtonElixirBattle", -- [21]
					"AutoBarButtonElixirGuardian", -- [22]
					"AutoBarButtonElixirBoth", -- [23]
					"AutoBarButtonTrack", -- [24]
					"AutoBarButtonCrafting", -- [25]
					"AutoBarButtonQuest", -- [26]
					"AutoBarButtonTrinket1", -- [27]
					"AutoBarButtonTrinket2", -- [28]
					"AutoBarButtonBuffWeapon2", -- [29]
				},
				["alignButtons"] = "3",
				["posX"] = 300,
				["WARRIOR"] = true,
				["DRUID"] = true,
				["DEATHKNIGHT"] = true,
				["hide"] = false,
				["enabled"] = true,
				["SHAMAN"] = true,
				["columns"] = 32,
				["ROGUE"] = true,
				["PRIEST"] = true,
				["MAGE"] = true,
				["alpha"] = 1,
				["buttonWidth"] = 36,
				["collapseButtons"] = true,
				["HUNTER"] = true,
				["WARLOCK"] = true,
				["posY"] = 200,
				["scale"] = 1,
				["padding"] = 0,
				["dockShiftX"] = 0,
				["frameStrata"] = "LOW",
			},
			["AutoBarClassBarExtras"] = {
				["popupDirection"] = "1",
				["fadeOut"] = false,
				["PALADIN"] = true,
				["buttonHeight"] = 36,
				["rows"] = 1,
				["dockShiftY"] = 0,
				["buttonKeys"] = {
					"AutoBarButtonSpeed", -- [1]
					"AutoBarButtonFreeAction", -- [2]
					"AutoBarButtonExplosive", -- [3]
					"AutoBarButtonFishing", -- [4]
					"AutoBarButtonPets", -- [5]
					"AutoBarButtonBattleStandards", -- [6]
					"AutoBarButtonOpenable", -- [7]
					"AutoBarButtonMiscFun", -- [8]
					"AutoBarButtonGuildSpell", -- [9]
					"AutoBarButtonRotationDrums", -- [10]
				},
				["alignButtons"] = "3",
				["posX"] = 300,
				["WARRIOR"] = true,
				["DRUID"] = true,
				["DEATHKNIGHT"] = true,
				["hide"] = false,
				["enabled"] = true,
				["SHAMAN"] = true,
				["columns"] = 9,
				["ROGUE"] = true,
				["PRIEST"] = true,
				["MAGE"] = true,
				["alpha"] = 1,
				["buttonWidth"] = 36,
				["collapseButtons"] = true,
				["HUNTER"] = true,
				["WARLOCK"] = true,
				["posY"] = 360,
				["scale"] = 1,
				["padding"] = 0,
				["dockShiftX"] = 0,
				["frameStrata"] = "LOW",
			},
		},
		["ldbIcon"] = {
		},
		["dbVersion"] = 1,
		["keySeed"] = 1,
		["customCategories"] = {
		},
		["buttonList"] = {
			["AutoBarButtonHeal"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonHeal",
				["enabled"] = false,
				["buttonKey"] = "AutoBarButtonHeal",
				["defaultButtonIndex"] = 4,
			},
			["AutoBarButtonBuff"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBuff",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBuff",
				["defaultButtonIndex"] = 18,
			},
			["AutoBarButtonBuffWeapon1"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBuffWeapon",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBuffWeapon1",
				["defaultButtonIndex"] = 19,
			},
			["AutoBarButtonCooldownPotionCombat"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionCombat",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionCombat",
				["defaultButtonIndex"] = 9,
			},
			["AutoBarButtonCooldownStoneHealth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneHealth",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneHealth",
				["defaultButtonIndex"] = 10,
			},
			["AutoBarButtonWater"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonWater",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonWater",
				["defaultButtonIndex"] = "AutoBarButtonFood",
			},
			["AutoBarButtonCooldownDrums"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownDrums",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownDrums",
				["defaultButtonIndex"] = 14,
			},
			["AutoBarButtonMount"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonMount",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonMount",
				["defaultButtonIndex"] = 2,
			},
			["AutoBarButtonFoodBuff"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFoodBuff",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFoodBuff",
				["defaultButtonIndex"] = 16,
			},
			["AutoBarButtonFood"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFood",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFood",
				["defaultButtonIndex"] = 15,
			},
			["AutoBarButtonCrafting"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCrafting",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCrafting",
				["defaultButtonIndex"] = 24,
			},
			["AutoBarButtonWaterBuff"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonWaterBuff",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonWaterBuff",
				["defaultButtonIndex"] = "AutoBarButtonWater",
			},
			["AutoBarButtonElixirBoth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonElixirBoth",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonElixirBoth",
				["defaultButtonIndex"] = 22,
			},
			["AutoBarButtonElixirBattle"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonElixirBattle",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonElixirBattle",
				["defaultButtonIndex"] = 20,
			},
			["AutoBarButtonFreeAction"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonFreeAction",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFreeAction",
				["defaultButtonIndex"] = 2,
			},
			["AutoBarButtonCooldownPotionRejuvenation"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionRejuvenation",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionRejuvenation",
				["defaultButtonIndex"] = 8,
			},
			["AutoBarButtonPets"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonPets",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonPets",
				["defaultButtonIndex"] = 5,
			},
			["AutoBarButtonOpenable"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonOpenable",
				["enabled"] = true,
				["drag"] = true,
				["buttonKey"] = "AutoBarButtonOpenable",
				["defaultButtonIndex"] = 7,
			},
			["AutoBarButtonHearth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonHearth",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonHearth",
				["defaultButtonIndex"] = 1,
			},
			["AutoBarButtonTrinket2"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonTrinket2",
				["equipped"] = 14,
				["enabled"] = true,
				["targeted"] = 14,
				["buttonKey"] = "AutoBarButtonTrinket2",
				["defaultButtonIndex"] = 27,
			},
			["AutoBarButtonQuest"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonQuest",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonQuest",
				["defaultButtonIndex"] = 25,
			},
			["AutoBarButtonExplosive"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonExplosive",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonExplosive",
				["defaultButtonIndex"] = 3,
			},
			["AutoBarButtonRecovery"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonRecovery",
				["enabled"] = false,
				["buttonKey"] = "AutoBarButtonRecovery",
				["defaultButtonIndex"] = 5,
			},
			["AutoBarButtonElixirGuardian"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonElixirGuardian",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonElixirGuardian",
				["defaultButtonIndex"] = 21,
			},
			["AutoBarButtonGuildSpell"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonGuildSpell",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonGuildSpell",
				["defaultButtonIndex"] = 9,
			},
			["AutoBarButtonBandages"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBandages",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBandages",
				["defaultButtonIndex"] = 3,
			},
			["AutoBarButtonMiscFun"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonMiscFun",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonMiscFun",
				["defaultButtonIndex"] = 8,
			},
			["AutoBarButtonBattleStandards"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonBattleStandards",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBattleStandards",
				["defaultButtonIndex"] = 6,
			},
			["AutoBarButtonCooldownStoneMana"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneMana",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneMana",
				["defaultButtonIndex"] = 11,
			},
			["AutoBarButtonCooldownPotionMana"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionMana",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionMana",
				["defaultButtonIndex"] = 7,
			},
			["AutoBarButtonFishing"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonFishing",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFishing",
				["defaultButtonIndex"] = 4,
			},
			["AutoBarButtonCooldownPotionHealth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionHealth",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionHealth",
				["defaultButtonIndex"] = 6,
			},
			["AutoBarButtonCooldownStoneCombat"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneCombat",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneCombat",
				["defaultButtonIndex"] = 12,
			},
			["AutoBarButtonSpeed"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonSpeed",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonSpeed",
				["defaultButtonIndex"] = 1,
			},
			["AutoBarButtonFoodCombo"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFoodCombo",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFoodCombo",
				["defaultButtonIndex"] = 17,
			},
			["AutoBarButtonRotationDrums"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonRotationDrums",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonRotationDrums",
				["defaultButtonIndex"] = 13,
			},
			["AutoBarButtonTrinket1"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonTrinket1",
				["equipped"] = 13,
				["enabled"] = true,
				["targeted"] = 13,
				["buttonKey"] = "AutoBarButtonTrinket1",
				["defaultButtonIndex"] = 26,
			},
			["AutoBarButtonTrack"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonTrack",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonTrack",
				["defaultButtonIndex"] = 23,
			},
		},
	},
}
