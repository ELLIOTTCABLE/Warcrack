
SkadaDB = {
	["profileKeys"] = {
		["Battlecollie - Ysondre"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["modules"] = {
				["threatsound"] = true,
				["notankwarnings"] = true,
				["threatraw"] = false,
				["threatflash"] = true,
				["threatsoundname"] = "Fel Nova",
			},
			["windows"] = {
				{
					["point"] = "BOTTOMLEFT",
					["scale"] = 1,
					["reversegrowth"] = true,
					["barfontsize"] = 12,
					["barcolor"] = {
						["r"] = 0.4235294117647059,
						["g"] = 0.4235294117647059,
						["b"] = 0.4235294117647059,
					},
					["background"] = {
						["borderthickness"] = 18.5,
						["height"] = 119,
						["bordertexture"] = "Blizzard Tooltip",
						["margin"] = 7,
						["texture"] = "Blizzard Dialog Background",
					},
					["bartexture"] = "Minimalist",
					["barwidth"] = 325,
					["mode"] = "Threat",
					["y"] = 164.1379699707031,
					["x"] = 0,
					["title"] = {
						["font"] = "Friz Quadrata TT",
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0.3600000143051147,
						},
						["menubutton"] = false,
						["texture"] = "Armory",
					},
					["baraltcolor"] = {
						["r"] = 0.7529411764705882,
						["g"] = 0,
						["b"] = 0.07450980392156863,
					},
					["barheight"] = 16,
					["returnaftercombat"] = true,
					["barfont"] = "Friz Quadrata TT",
				}, -- [1]
			},
			["feed"] = "Damage: Raid DPS",
			["total"] = {
				["absorbTotal"] = 1392,
				["dispells"] = 0,
				["absorbs"] = 1392,
				["ccbreaks"] = 0,
				["time"] = 0,
				["interrupts"] = 0,
				["damage"] = 0,
				["players"] = {
					{
						["class"] = "PRIEST",
						["absorbTotal"] = 1392,
						["dispells"] = 0,
						["absorbs"] = {
							["Battlecollie"] = 1392,
						},
						["healingspells"] = {
						},
						["overhealing"] = 0,
						["interrupts"] = 0,
						["damaged"] = {
						},
						["id"] = "0x05000000043503AF",
						["maxhp"] = 13150,
						["damage"] = 0,
						["damagespells"] = {
						},
						["deaths"] = {
						},
						["damagetaken"] = 5366,
						["power"] = {
						},
						["totalabsorbs"] = 1392,
						["healing"] = 0,
						["time"] = 3,
						["damagetakenspells"] = {
							["Attack"] = {
								["id"] = 6603,
								["name"] = "Attack",
								["damage"] = 5366,
							},
						},
						["healed"] = {
						},
						["name"] = "Battlecollie",
						["uptime"] = 0,
						["absorbSpells"] = {
							["Power Word: Shield"] = {
								["min"] = 0,
								["max"] = 763,
								["name"] = "Power Word: Shield",
								["critical"] = 0,
								["id"] = 17,
								["healing"] = 1392,
								["overhealing"] = 0,
								["hits"] = 2,
							},
						},
						["ccbreaks"] = 0,
						["deathlog"] = {
							{
								["ts"] = 1307707882.048,
								["amount"] = -574,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [1]
							{
								["ts"] = 1307707831.11,
								["amount"] = -626,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [2]
							{
								["ts"] = 1307707802.3,
								["amount"] = -796,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [3]
							{
								["ts"] = 1307707682.372,
								["amount"] = -746,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [4]
							{
								["ts"] = 1307707647.477,
								["amount"] = -639,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13053,
							}, -- [5]
							{
								["ts"] = 1307707640.217,
								["amount"] = -547,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [6]
							{
								["ts"] = 1307706836.888,
								["amount"] = -669,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [7]
							{
								["ts"] = 1307706511.607,
								["amount"] = -769,
								["spellname"] = "Sifreldar Storm Maiden's Attack",
								["spellid"] = 6603,
								["hp"] = 13150,
							}, -- [8]
						},
						["auras"] = {
						},
						["absorbed"] = {
							["Battlecollie"] = {
								["amount"] = 1392,
								["class"] = "PRIEST",
							},
						},
					}, -- [1]
				},
				["deaths"] = 0,
				["mobs"] = {
				},
				["mobtaken"] = 0,
				["healing"] = 0,
				["power"] = {
				},
				["name"] = "Total",
				["overhealing"] = 0,
				["damagetaken"] = 5366,
				["starttime"] = 1307706507,
				["last_action"] = 1307706507,
				["mobdone"] = 0,
			},
			["columns"] = {
				["Threat_TPS"] = true,
			},
			["hidedisables"] = false,
			["setstokeep"] = 30,
		},
	},
}
