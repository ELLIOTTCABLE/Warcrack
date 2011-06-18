
AutoBarDB = {
	["classes"] = {
		["Warrior"] = {
			["barList"] = {
				["AutoBarClassBarWarrior"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 300,
					["hide"] = false,
					["enabled"] = false,
					["columns"] = 10,
					["alpha"] = 1,
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["WARRIOR"] = true,
					["posY"] = 280,
					["popupDirection"] = "1",
					["scale"] = 1,
					["padding"] = 0,
					["dockShiftX"] = 0,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonCharge", -- [3]
						"AutoBarButtonER", -- [4]
						"AutoBarButtonStance", -- [5]
					},
				},
			},
			["buttonList"] = {
				["AutoBarButtonBuffWeapon2"] = {
					["barKey"] = "AutoBarClassBarBasic",
					["buttonClass"] = "AutoBarButtonBuffWeapon",
					["invertButtons"] = true,
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonBuffWeapon2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonStance"] = {
					["barKey"] = "AutoBarClassBarWarrior",
					["buttonClass"] = "AutoBarButtonStance",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonStance",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonShields"] = {
					["barKey"] = "AutoBarClassBarWarrior",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonCharge"] = {
					["barKey"] = "AutoBarClassBarWarrior",
					["buttonClass"] = "AutoBarButtonCharge",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonCharge",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarWarrior",
					["buttonClass"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarWarrior",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
			},
		},
		["Paladin"] = {
			["barList"] = {
				["AutoBarClassBarPaladin"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["PALADIN"] = true,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 300,
					["hide"] = false,
					["enabled"] = true,
					["columns"] = 10,
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["frameStrata"] = "LOW",
					["posY"] = 280,
					["scale"] = 1,
					["popupDirection"] = "1",
					["padding"] = 0,
					["dockShiftX"] = 0,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonAura", -- [2]
						"AutoBarButtonER", -- [3]
						"AutoBarButtonSeal", -- [4]
						"AutoBarButtonClassBuff", -- [5]
					},
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
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
				},
				["AutoBarButtonSeal"] = {
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonSeal",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonSeal",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonAura"] = {
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonAura",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonAura",
					["defaultButtonIndex"] = "*",
				},
			},
		},
		["Druid"] = {
			["barList"] = {
				["AutoBarClassBarDruid"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 300,
					["DRUID"] = true,
					["hide"] = false,
					["enabled"] = false,
					["columns"] = 10,
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["buttonKeys"] = {
						"AutoBarButtonBear", -- [1]
						"AutoBarButtonCat", -- [2]
						"AutoBarButtonTravel", -- [3]
						"AutoBarButtonBoomkinTree", -- [4]
						"AutoBarButtonPowerShift", -- [5]
						"AutoBarButtonShields", -- [6]
						"AutoBarButtonStealth", -- [7]
						"AutoBarButtonDebuff", -- [8]
						"AutoBarButtonClassPets2", -- [9]
						"AutoBarButtonClassPet", -- [10]
						"AutoBarButtonCharge", -- [11]
						"AutoBarButtonER", -- [12]
						"AutoBarButtonClassBuff", -- [13]
						"AutoBarButtonClassPets3", -- [14]
					},
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
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonStealth"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonStealth",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonStealth",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonBoomkinTree"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonBoomkinTree",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonBoomkinTree",
					["defaultButtonIndex"] = 4,
				},
				["AutoBarButtonBear"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonBear",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonBear",
					["defaultButtonIndex"] = 1,
				},
				["AutoBarButtonCat"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonCat",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonCat",
					["defaultButtonIndex"] = 2,
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonDebuff"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonDebuff",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonDebuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonTravel"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonTravel",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTravel",
					["defaultButtonIndex"] = 3,
				},
				["AutoBarButtonCharge"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonCharge",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonCharge",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonER",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets2"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassPets2",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonPowerShift"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonPowerShift",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonPowerShift",
					["defaultButtonIndex"] = 5,
				},
			},
		},
		["Rogue"] = {
			["barList"] = {
				["AutoBarClassBarRogue"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["ROGUE"] = true,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 300,
					["hide"] = false,
					["enabled"] = true,
					["columns"] = 10,
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonStealth", -- [2]
						"AutoBarButtonPickLock", -- [3]
						"AutoBarButtonER", -- [4]
					},
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
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonBuffWeapon2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonPickLock"] = {
					["barKey"] = "AutoBarClassBarRogue",
					["buttonClass"] = "AutoBarButtonPickLock",
					["enabled"] = true,
					["arrangeOnUse"] = true,
					["targeted"] = "Lockpicking",
					["buttonKey"] = "AutoBarButtonPickLock",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonShields"] = {
					["barKey"] = "AutoBarClassBarRogue",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonStealth"] = {
					["barKey"] = "AutoBarClassBarRogue",
					["buttonClass"] = "AutoBarButtonStealth",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonStealth",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarRogue",
					["buttonClass"] = "AutoBarButtonER",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
				},
			},
		},
		["Death Knight"] = {
			["barList"] = {
				["AutoBarClassBarDeathKnight"] = {
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
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonClassPets2", -- [3]
						"AutoBarButtonClassPet", -- [4]
						"AutoBarButtonER", -- [5]
						"AutoBarButtonClassPets3", -- [6]
					},
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["DEATHKNIGHT"] = true,
					["posY"] = 280,
					["scale"] = 1,
					["popupDirection"] = "1",
					["padding"] = 0,
					["dockShiftX"] = 0,
					["alpha"] = 1,
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
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarDeathKnight",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonShields"] = {
					["barKey"] = "AutoBarClassBarDeathKnight",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarDeathKnight",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarDeathKnight",
					["buttonClass"] = "AutoBarButtonER",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets2"] = {
					["barKey"] = "AutoBarClassBarDeathKnight",
					["buttonClass"] = "AutoBarButtonClassPets2",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarDeathKnight",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
			},
		},
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
					["enabled"] = false,
					["columns"] = 10,
					["alpha"] = 1,
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["MAGE"] = true,
					["posY"] = 280,
					["popupDirection"] = "1",
					["scale"] = 1,
					["padding"] = 0,
					["dockShiftX"] = 0,
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
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
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
		["Priest"] = {
			["barList"] = {
				["AutoBarClassBarPriest"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 300,
					["hide"] = false,
					["enabled"] = false,
					["columns"] = 10,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonClassPets2", -- [3]
						"AutoBarButtonClassPet", -- [4]
						"AutoBarButtonER", -- [5]
						"AutoBarButtonClassPets3", -- [6]
						"AutoBarButtonDebuff", -- [7]
					},
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["PRIEST"] = true,
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
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonShields"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonDebuff"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonDebuff",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonDebuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonER",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets2"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonClassPets2",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarPriest",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
			},
		},
		["Warlock"] = {
			["barList"] = {
				["AutoBarClassBarWarlock"] = {
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
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonDebuff", -- [3]
						"AutoBarButtonConjure", -- [4]
						"AutoBarButtonClassPets2", -- [5]
						"AutoBarButtonClassPet", -- [6]
						"AutoBarButtonWarlockStones", -- [7]
						"AutoBarButtonClassPets3", -- [8]
					},
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["posY"] = 280,
					["WARLOCK"] = true,
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
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonWarlockStones"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonWarlockStones",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonWarlockStones",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonDebuff"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonDebuff",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonDebuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonConjure"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonConjure",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonConjure",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets2"] = {
					["barKey"] = "AutoBarClassBarWarlock",
					["buttonClass"] = "AutoBarButtonClassPets2",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets2",
					["defaultButtonIndex"] = "*",
				},
			},
		},
	},
	["chars"] = {
		["Warcollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Summoneer - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "Felsteed",
					["groundMount"] = "Felsteed",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Melancollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonCrafting"] = {
					["arrangeOnUse"] = "Survey",
				},
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "Winged Guardian",
					["flyingMount"] = "Winged Guardian",
					["groundMount"] = "Winged Guardian",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Combatcollie - The Underbog"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Nocollie - Smolderthorn"] = {
			["buttonDataList"] = {
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Fraycollie - The Underbog"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "X-53 Touring Rocket",
					["flyingMount"] = "X-53 Touring Rocket",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Fraycollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonPets"] = {
					["arrangeOnUse"] = "Kirin Tor Familiar",
				},
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "X-53 Touring Rocket",
					["flyingMount"] = "X-53 Touring Rocket",
					["groundMount"] = "X-53 Touring Rocket",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Othercollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Hoarcollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonPets"] = {
					["arrangeOnUse"] = "Cenarion Hatchling",
				},
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Summoneer - Ysondre"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["groundMount"] = "Felsteed",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Warcollie - Darkspear"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "Winged Guardian",
					["groundMount"] = "Winged Guardian",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Battlecollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonPets"] = {
					["arrangeOnUse"] = "Kirin Tor Familiar",
				},
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "X-53 Touring Rocket",
					["flyingMount"] = "X-53 Touring Rocket",
					["SetBest"] = nil --[[ skipped inline function ]],
					["groundMount"] = "X-53 Touring Rocket",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Battlecollie - Ysondre"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["flyingMount"] = "Black War Bear",
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
				["HUNTER"] = true,
				["WARRIOR"] = true,
				["PALADIN"] = true,
				["MAGE"] = true,
				["rows"] = 1,
				["dockShiftY"] = 0,
				["scale"] = 1,
				["alignButtons"] = "3",
				["posX"] = 356.3152264107339,
				["popupDirection"] = "1",
				["DRUID"] = true,
				["DEATHKNIGHT"] = true,
				["hide"] = false,
				["enabled"] = true,
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
				["posY"] = 65.99593114206345,
				["buttonHeight"] = 36,
				["ROGUE"] = true,
				["buttonWidth"] = 36,
				["alpha"] = 1,
				["PRIEST"] = true,
				["collapseButtons"] = true,
				["frameStrata"] = "LOW",
				["WARLOCK"] = true,
				["fadeOut"] = false,
				["columns"] = 23,
				["padding"] = 6,
				["dockShiftX"] = 0,
				["SHAMAN"] = true,
			},
			["AutoBarClassBarExtras"] = {
				["HUNTER"] = true,
				["WARRIOR"] = true,
				["SHAMAN"] = true,
				["MAGE"] = true,
				["rows"] = 3,
				["dockShiftY"] = 0,
				["popupDirection"] = "2",
				["alignButtons"] = "7",
				["posX"] = 1310.962470697705,
				["fadeOut"] = false,
				["DRUID"] = true,
				["ROGUE"] = true,
				["hide"] = false,
				["DEATHKNIGHT"] = true,
				["scale"] = 1,
				["posY"] = -14.67675016023031,
				["buttonKeys"] = {
					"AutoBarButtonSpeed", -- [1]
					"AutoBarButtonFreeAction", -- [2]
					"AutoBarButtonExplosive", -- [3]
					"AutoBarButtonFishing", -- [4]
					"AutoBarButtonPets", -- [5]
					"AutoBarButtonBattleStandards", -- [6]
					"AutoBarButtonOpenable", -- [7]
					"AutoBarButtonMiscFun", -- [8]
					"AutoBarButtonRotationDrums", -- [9]
				},
				["enabled"] = true,
				["buttonWidth"] = 36,
				["alpha"] = 1,
				["PRIEST"] = true,
				["collapseButtons"] = true,
				["frameStrata"] = "LOW",
				["WARLOCK"] = true,
				["PALADIN"] = true,
				["columns"] = 2,
				["padding"] = 6,
				["dockShiftX"] = 0,
				["buttonHeight"] = 36,
			},
		},
		["ldbIcon"] = {
		},
		["dbVersion"] = 1,
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
				["enabled"] = true,
				["equipped"] = 14,
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
			["AutoBarButtonBandages"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBandages",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBandages",
				["defaultButtonIndex"] = 3,
			},
			["AutoBarButtonBattleStandards"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonBattleStandards",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBattleStandards",
				["defaultButtonIndex"] = 6,
			},
			["AutoBarButtonMiscFun"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonMiscFun",
				["arrangeOnUse"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonMiscFun",
				["defaultButtonIndex"] = 8,
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
			["AutoBarButtonRotationDrums"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonRotationDrums",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonRotationDrums",
				["defaultButtonIndex"] = 13,
			},
			["AutoBarButtonFoodCombo"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFoodCombo",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFoodCombo",
				["defaultButtonIndex"] = 17,
			},
			["AutoBarButtonSpeed"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonSpeed",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonSpeed",
				["defaultButtonIndex"] = 1,
			},
			["AutoBarButtonTrinket1"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonTrinket1",
				["enabled"] = true,
				["equipped"] = 13,
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
		["keySeed"] = 1,
		["customCategories"] = {
		},
		["selfCastRightClick"] = false,
	},
}
