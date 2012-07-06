
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
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonCharge", -- [3]
						"AutoBarButtonER", -- [4]
						"AutoBarButtonStance", -- [5]
					},
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["WARRIOR"] = true,
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
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
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
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonAura", -- [2]
						"AutoBarButtonER", -- [3]
						"AutoBarButtonSeal", -- [4]
						"AutoBarButtonClassBuff", -- [5]
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
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
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
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonER",
					["noPopup"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonSeal"] = {
					["barKey"] = "AutoBarClassBarPaladin",
					["buttonClass"] = "AutoBarButtonSeal",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonSeal",
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
			},
		},
		["Shaman"] = {
			["barList"] = {
				["AutoBarClassBarShaman"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["SHAMAN"] = true,
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
						"AutoBarButtonTravel", -- [1]
						"AutoBarButtonShields", -- [2]
						"AutoBarButtonTotemAir", -- [3]
						"AutoBarButtonClassPets2", -- [4]
						"AutoBarButtonTotemFire", -- [5]
						"AutoBarButtonClassPet", -- [6]
						"AutoBarButtonTotemEarth", -- [7]
						"AutoBarButtonER", -- [8]
						"AutoBarButtonTotemWater", -- [9]
						"AutoBarButtonClassBuff", -- [10]
						"AutoBarButtonClassPets3", -- [11]
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
				["AutoBarButtonShields"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonShields",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonShields",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonTotemFire"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonTotemFire",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTotemFire",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonTotemAir"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonTotemAir",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTotemAir",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonTotemEarth"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonTotemEarth",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTotemEarth",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonTotemWater"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonTotemWater",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTotemWater",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonER",
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
				},
				["AutoBarButtonClassPets2"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonClassPets2",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets2",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonTravel"] = {
					["barKey"] = "AutoBarClassBarShaman",
					["buttonClass"] = "AutoBarButtonTravel",
					["defaultButtonIndex"] = 3,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTravel",
					["noPopup"] = true,
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
					["frameStrata"] = "LOW",
					["posY"] = 280,
					["scale"] = 1,
					["popupDirection"] = "1",
					["padding"] = 0,
					["dockShiftX"] = 0,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonStealth", -- [2]
						"AutoBarButtonPickLock", -- [3]
						"AutoBarButtonER", -- [4]
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
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
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
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["MAGE"] = true,
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
					["alpha"] = 1,
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["posY"] = 280,
					["WARLOCK"] = true,
					["scale"] = 1,
					["popupDirection"] = "1",
					["padding"] = 0,
					["dockShiftX"] = 0,
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
					["frameStrata"] = "LOW",
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["DEATHKNIGHT"] = true,
					["posY"] = 280,
					["popupDirection"] = "1",
					["scale"] = 1,
					["padding"] = 0,
					["dockShiftX"] = 0,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonClassPets2", -- [3]
						"AutoBarButtonClassPet", -- [4]
						"AutoBarButtonER", -- [5]
						"AutoBarButtonClassPets3", -- [6]
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
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
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
					["alpha"] = 1,
					["frameStrata"] = "LOW",
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["PRIEST"] = true,
					["posY"] = 280,
					["popupDirection"] = "1",
					["scale"] = 1,
					["padding"] = 0,
					["dockShiftX"] = 0,
					["buttonKeys"] = {
						"AutoBarButtonShields", -- [1]
						"AutoBarButtonClassBuff", -- [2]
						"AutoBarButtonClassPets2", -- [3]
						"AutoBarButtonClassPet", -- [4]
						"AutoBarButtonER", -- [5]
						"AutoBarButtonClassPets3", -- [6]
						"AutoBarButtonDebuff", -- [7]
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
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
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
					["frameStrata"] = "LOW",
					["posY"] = 280,
					["scale"] = 1,
					["popupDirection"] = "1",
					["padding"] = 0,
					["dockShiftX"] = 0,
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
					["defaultButtonIndex"] = 4,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonBoomkinTree",
					["noPopup"] = true,
				},
				["AutoBarButtonBear"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonBear",
					["defaultButtonIndex"] = 1,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonBear",
					["noPopup"] = true,
				},
				["AutoBarButtonCat"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonCat",
					["defaultButtonIndex"] = 2,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonCat",
					["noPopup"] = true,
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
					["defaultButtonIndex"] = 3,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonTravel",
					["noPopup"] = true,
				},
				["AutoBarButtonClassPets3"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassPets3",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPets3",
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonCharge"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonCharge",
					["arrangeOnUse"] = true,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonCharge",
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
					["defaultButtonIndex"] = "*",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonER",
					["noPopup"] = true,
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
					["defaultButtonIndex"] = 5,
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonPowerShift",
					["noPopup"] = true,
				},
			},
		},
	},
	["account"] = {
		["customCategoriesVersion"] = 3,
		["barList"] = {
			["AutoBarCustomBarCustom1"] = {
				["popupDirection"] = "1",
				["fadeOut"] = false,
				["buttonHeight"] = 36,
				["PALADIN"] = true,
				["scale"] = 1,
				["rows"] = 1,
				["isCustomBar"] = true,
				["HUNTER"] = true,
				["dockShiftY"] = 0,
				["buttonKeys"] = {
				},
				["alignButtons"] = "3",
				["posX"] = 300,
				["MAGE"] = true,
				["DRUID"] = true,
				["posY"] = 360,
				["hide"] = true,
				["DEATHKNIGHT"] = true,
				["WARLOCK"] = true,
				["columns"] = 32,
				["PRIEST"] = true,
				["frameStrata"] = "LOW",
				["buttonWidth"] = 36,
				["alpha"] = 1,
				["desc"] = "Custom1",
				["collapseButtons"] = true,
				["ROGUE"] = true,
				["name"] = "Custom1",
				["enabled"] = true,
				["WARRIOR"] = true,
				["padding"] = 0,
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
				["buttonHeight"] = 36,
				["alignButtons"] = "7",
				["posX"] = 1310.962470697705,
				["fadeOut"] = false,
				["DRUID"] = true,
				["ROGUE"] = true,
				["hide"] = false,
				["DEATHKNIGHT"] = true,
				["posY"] = -14.67675016023031,
				["columns"] = 2,
				["PALADIN"] = true,
				["enabled"] = true,
				["alpha"] = 1,
				["frameStrata"] = "LOW",
				["PRIEST"] = true,
				["collapseButtons"] = true,
				["buttonWidth"] = 36,
				["WARLOCK"] = true,
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
					"AutoBarButtonGuildSpell", -- [10]
				},
				["scale"] = 1,
				["padding"] = 6,
				["dockShiftX"] = 0,
				["popupDirection"] = "2",
			},
			["AutoBarClassBarBasic"] = {
				["popupDirection"] = "1",
				["fadeOut"] = false,
				["ROGUE"] = true,
				["MAGE"] = true,
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
				["posX"] = 180.1999001967633,
				["SHAMAN"] = true,
				["DRUID"] = true,
				["HUNTER"] = true,
				["enabled"] = true,
				["DEATHKNIGHT"] = true,
				["columns"] = 23,
				["posY"] = 79.9042011535812,
				["WARRIOR"] = true,
				["buttonHeight"] = 36,
				["alpha"] = 1,
				["frameStrata"] = "HIGH",
				["buttonWidth"] = 36,
				["collapseButtons"] = true,
				["PRIEST"] = true,
				["WARLOCK"] = true,
				["PALADIN"] = true,
				["alignButtons"] = "3",
				["padding"] = 6,
				["dockShiftX"] = 0,
				["scale"] = 1,
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
				["buttonKey"] = "AutoBarButtonTrinket2",
				["targeted"] = 14,
				["equipped"] = 14,
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
			["AutoBarButtonTrinket1"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonTrinket1",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonTrinket1",
				["targeted"] = 13,
				["equipped"] = 13,
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
			["AutoBarButtonCooldownStoneMana"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneMana",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneMana",
				["defaultButtonIndex"] = 11,
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
			["AutoBarButtonCooldownPotionHealth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionHealth",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionHealth",
				["defaultButtonIndex"] = 6,
			},
			["AutoBarButtonFishing"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonFishing",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFishing",
				["defaultButtonIndex"] = 4,
			},
			["AutoBarButtonCooldownPotionMana"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionMana",
				["shuffle"] = true,
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionMana",
				["defaultButtonIndex"] = 7,
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
		},
		["keySeed"] = 2,
		["customCategories"] = {
		},
		["selfCastRightClick"] = false,
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
		["Fraycollie - Nordrassil"] = {
			["buttonDataList"] = {
				["AutoBarButtonCrafting"] = {
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
		["Summoneer - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "Felsteed",
					["groundMount"] = "Felsteed",
					["flyingMount"] = "Felsteed",
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
		["Fraycollie - Hyjal"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
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
		["Warmongrel - Ysondre"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Elliottcable - Hyjal"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Wattlecollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
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
		["Battlecollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonQuest"] = {
				},
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "X-53 Touring Rocket",
					["flyingMount"] = "X-53 Touring Rocket",
					["groundMount"] = "X-53 Touring Rocket",
				},
				["AutoBarButtonPets"] = {
					["arrangeOnUse"] = "Kirin Tor Familiar",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Collierape - Smolderthorn"] = {
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
		["Armscollie - Akama"] = {
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
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "Running Wild",
				},
				["AutoBarButtonPets"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Snuffleupaga - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
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
		["Fraycollie - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
					["arrangeOnUse"] = "X-53 Touring Rocket",
					["flyingMount"] = "X-53 Touring Rocket",
					["groundMount"] = "X-53 Touring Rocket",
				},
				["AutoBarButtonPets"] = {
					["arrangeOnUse"] = "Kirin Tor Familiar",
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
		["Github - Smolderthorn"] = {
			["buttonDataList"] = {
				["AutoBarButtonMount"] = {
				},
			},
			["barList"] = {
			},
			["buttonList"] = {
			},
		},
	},
}
