
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
					["barcolor"] = {
						["b"] = 0.4235294117647059,
						["g"] = 0.4235294117647059,
						["r"] = 0.4235294117647059,
					},
					["returnaftercombat"] = true,
					["barfont"] = "Friz Quadrata TT",
					["modeincombat"] = "Threat",
					["background"] = {
						["borderthickness"] = 18.5,
						["height"] = 119,
						["bordertexture"] = "Blizzard Tooltip",
						["margin"] = 7,
						["texture"] = "Blizzard Dialog Background",
					},
					["barfontsize"] = 12,
					["set"] = "total",
					["barwidth"] = 325,
					["reversegrowth"] = true,
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
						["b"] = 0.07450980392156863,
						["g"] = 0,
						["r"] = 0.7529411764705882,
					},
					["barheight"] = 16,
					["bartexture"] = "Minimalist",
					["mode"] = "Absorbs and healing",
				}, -- [1]
			},
			["feed"] = "Damage: Raid DPS",
			["columns"] = {
				["Threat_TPS"] = true,
			},
			["hidedisables"] = false,
			["setstokeep"] = 30,
		},
	},
}
