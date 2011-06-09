
DataStore_TalentsDB = {
	["profileKeys"] = {
		["Battlecollie - Ysondre"] = "Battlecollie - Ysondre",
	},
	["global"] = {
		["Characters"] = {
			["Default.Ysondre.Battlecollie"] = {
				["Glyphs"] = {
					2147929115, -- [1]
					3859223757, -- [2]
					3851883549, -- [3]
					2115423211, -- [4]
					3878098173, -- [5]
					2225523683, -- [6]
					5956417567, -- [7]
					2199309391, -- [8]
					2208746439, -- [9]
					5964806187, -- [10]
					3842446349, -- [11]
					3885439909, -- [12]
					2157366323, -- [13]
					3852932125, -- [14]
					2225523683, -- [15]
					2248592407, -- [16]
					5940688879, -- [17]
					2191969295, -- [18]
				},
				["ActiveTalents"] = 1,
				["lastUpdate"] = 1307639116,
				["GlyphList"] = {
					11, -- [1]
					11338, -- [2]
					4090, -- [3]
					11354, -- [4]
					4138, -- [5]
					4314, -- [6]
					11370, -- [7]
					4202, -- [8]
					4218, -- [9]
					4234, -- [10]
					4266, -- [11]
					4298, -- [12]
					4186, -- [13]
					13, -- [14]
					4028, -- [15]
					11420, -- [16]
					4044, -- [17]
					11404, -- [18]
					4060, -- [19]
					4076, -- [20]
					4108, -- [21]
					4124, -- [22]
					4156, -- [23]
					4348, -- [24]
					4172, -- [25]
					4252, -- [26]
					4284, -- [27]
					4332, -- [28]
					11388, -- [29]
					15, -- [30]
					7342, -- [31]
					7374, -- [32]
					7358, -- [33]
					7390, -- [34]
					7406, -- [35]
					7422, -- [36]
				},
				["TalentTrees"] = {
					["Discipline|2"] = 28,
					["Discipline|1"] = 1687431982514,
					["Holy|1"] = 48,
					["Shadow|2"] = 1951698807691,
				},
				["Class"] = "PRIEST",
			},
		},
		["Reference"] = {
			["GlyphNames"] = {
				[708] = "Dispersion",
				[710] = "Penance",
				[712] = "Divine Accuracy",
				[251] = "Circle of Healing",
				[252] = "Dispel Magic",
				[253] = "Fade",
				[254] = "Fear Ward",
				[255] = "Flash Heal",
				[256] = "Holy Nova",
				[257] = "Inner Fire",
				[258] = "Lightwell",
				[259] = "Mass Dispel",
				[260] = "Psychic Horror",
				[261] = "Shadow Word: Pain",
				[262] = "Power Word: Barrier",
				[263] = "Power Word: Shield",
				[264] = "Prayer of Healing",
				[265] = "Psychic Scream",
				[266] = "Renew",
				[267] = "Scourge Imprisonment",
				[268] = "Shadow Word: Death",
				[269] = "Mind Flay",
				[270] = "Smite",
				[460] = "Fortitude",
				[461] = "Shackle Undead",
				[462] = "Shadow Protection",
				[463] = "Shadowfiend",
				[459] = "Levitate",
				[271] = "Prayer of Mending",
				[458] = "Fading",
				[713] = "Desperation",
				[711] = "Spirit Tap",
				[709] = "Guardian Spirit",
			},
		},
	},
}
DataStore_TalentsRefDB = {
	["profileKeys"] = {
		["Battlecollie - Ysondre"] = "Battlecollie - Ysondre",
	},
	["global"] = {
		["PRIEST"] = {
			["Locale"] = "enUS",
			["Trees"] = {
				["Discipline"] = {
					["prereqs"] = {
						[5] = "2|1",
						[15] = "3|1",
						[21] = "5|2",
					},
					["background"] = "PriestDiscipline",
					["icon"] = "Spell_Holy_PowerWordShield",
					["talents"] = {
						"10736|Improved Power Word: Shield|Spell_Holy_PowerWordShield|1|1|2", -- [1]
						"8577|Twin Disciplines|Spell_Holy_SealOfVengeance|1|2|3", -- [2]
						"8595|Mental Agility|Ability_Hibernation|1|3|3", -- [3]
						"8593|Evangelism|Spell_Holy_DivineIllumination|2|1|2", -- [4]
						"11608|Archangel|ability_priest_archangel|2|2|1", -- [5]
						"8581|Inner Sanctum|Spell_Holy_InnerFire|2|3|3", -- [6]
						"8607|Soul Warding|ability_priest_soulwarding|2|4|2", -- [7]
						"11224|Renewed Hope|Spell_Holy_HolyProtection|3|1|2", -- [8]
						"8611|Power Infusion|Spell_Holy_PowerInfusion|3|2|1", -- [9]
						"11812|Atonement|ability_priest_atonement|3|3|2", -- [10]
						"8591|Inner Focus|Spell_Frost_WindWalkOn|3|4|1", -- [11]
						"8617|Rapture|Spell_Holy_Rapture|4|2|3", -- [12]
						"11523|Borrowed Time|Spell_Holy_BorrowedTime|4|3|2", -- [13]
						"8605|Reflective Shield|ability_priest_reflectiveshield|4|4|2", -- [14]
						"11813|Strength of Soul|Spell_Holy_AshesToAshes|5|1|2", -- [15]
						"8609|Divine Aegis|Spell_Holy_DevineAegis|5|2|3", -- [16]
						"8623|Pain Suppression|Spell_Holy_PainSupression|5|3|1", -- [17]
						"12183|Train of Thought|Ability_Mage_StudentOfTheMind|5|4|2", -- [18]
						"8621|Focused Will|ability_priest_focusedwill|6|1|2", -- [19]
						"8625|Grace|Spell_Holy_HopeAndGrace|6|3|2", -- [20]
						"8603|Power Word: Barrier|spell_holy_powerwordbarrier|7|2|1", -- [21]
					},
				},
				["Holy"] = {
					["prereqs"] = {
						[11] = "3|1",
						[7] = "1|1",
						[15] = "3|2",
						[19] = "5|2",
						[16] = "5|2",
					},
					["background"] = "PriestHoly",
					["icon"] = "Spell_Holy_GuardianSpirit",
					["talents"] = {
						"10746|Improved Renew|Spell_Holy_Renew|1|1|2", -- [1]
						"9553|Empowered Healing|Spell_Holy_GreaterHeal|1|2|3", -- [2]
						"9549|Divine Fury|Spell_Holy_SealOfWrath|1|3|3", -- [3]
						"11669|Desperate Prayer|Spell_Holy_Restoration|2|2|1", -- [4]
						"11765|Surge of Light|Spell_Holy_SurgeOfLight|2|3|2", -- [5]
						"9561|Inspiration|Spell_Holy_LayOnHands|2|4|2", -- [6]
						"9593|Divine Touch|Ability_Paladin_InfusionofLight|3|1|2", -- [7]
						"9577|Holy Concentration|Spell_Holy_Fanaticism|3|2|2", -- [8]
						"11666|Lightwell|Spell_Holy_SummonLightwell|3|3|1", -- [9]
						"12184|Tome of Light|INV_Misc_Book_07|3|4|2", -- [10]
						"14738|Rapid Renewal|Ability_Paladin_BlessedMending|4|1|1", -- [11]
						"11670|Spirit of Redemption|INV_Enchant_EssenceEternalLarge|4|3|1", -- [12]
						"9573|Serendipity|Spell_Holy_Serendipity|4|4|2", -- [13]
						"9587|Body and Soul|Spell_Holy_SymbolOfHope|5|1|2", -- [14]
						"11667|Chakra|priest_icon_chakra|5|2|1", -- [15]
						"11755|Revelations|ability_priest_bindingprayers|5|3|1", -- [16]
						"11672|Blessed Resilience|Spell_Holy_BlessedResillience|5|4|2", -- [17]
						"9597|Test of Faith|Spell_Holy_TestOfFaith|6|1|3", -- [18]
						"11668|State of Mind|Spell_Arcane_MindMastery|6|2|2", -- [19]
						"9595|Circle of Healing|Spell_Holy_CircleOfRenewal|6|3|1", -- [20]
						"9601|Guardian Spirit|Spell_Holy_GuardianSpirit|7|2|1", -- [21]
					},
				},
				["Shadow"] = {
					["prereqs"] = {
						[11] = "2|1",
						[13] = "4|2",
						[16] = "4|2",
						[19] = "5|2",
					},
					["background"] = "PriestShadow",
					["icon"] = "Spell_Shadow_ShadowWordPain",
					["talents"] = {
						"9032|Darkness|ability_priest_darkness|1|1|3", -- [1]
						"9036|Improved Shadow Word: Pain|Spell_Shadow_ShadowWordPain|1|2|2", -- [2]
						"9046|Veiled Shadows|Spell_Magic_LesserInvisibilty|1|3|2", -- [3]
						"9040|Improved Psychic Scream|Spell_Shadow_PsychicScream|2|1|2", -- [4]
						"9042|Improved Mind Blast|Spell_Shadow_UnholyFrenzy|2|2|3", -- [5]
						"9062|Improved Devouring Plague|Spell_Shadow_DevouringPlague.|2|3|2", -- [6]
						"11673|Twisted Faith|Spell_Shadow_MindTwisting|2|4|2", -- [7]
						"9064|Shadowform|Spell_Shadow_Shadowform|3|2|1", -- [8]
						"9068|Phantasm|Spell_Shadow_TwistedFaith|3|3|2", -- [9]
						"11606|Harnessed Shadows|INV_Misc_Orb_04|3|4|2", -- [10]
						"9052|Silence|ability_priest_silence|4|1|1", -- [11]
						"9054|Vampiric Embrace|Spell_Shadow_UnsummonBuilding|4|2|1", -- [12]
						"11778|Masochism|Spell_Shadow_Misery|4|3|2", -- [13]
						"9060|Mind Melt|Spell_Shadow_Skull|4|4|2", -- [14]
						"9076|Pain and Suffering|Spell_Shadow_PainAndSuffering|5|1|2", -- [15]
						"9074|Vampiric Touch|Spell_Holy_Stoicism|5|2|1", -- [16]
						"11663|Paralysis|Ability_Rogue_MasterOfSubtlety|5|3|2", -- [17]
						"9072|Psychic Horror|Spell_Shadow_PsychicHorrors|6|1|1", -- [18]
						"11605|Sin and Punishment|Spell_Holy_PrayerofShadowProtection|6|2|2", -- [19]
						"9070|Shadowy Apparition|ability_priest_shadowyapparition|6|3|3", -- [20]
						"9080|Dispersion|Spell_Shadow_Dispersion|7|2|1", -- [21]
					},
				},
			},
			["Version"] = 14007,
			["Order"] = "Discipline,Holy,Shadow",
		},
	},
}
