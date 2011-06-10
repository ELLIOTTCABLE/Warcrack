﻿--[[--------------------------------------------------------------------
	GridStatusHots.lua
----------------------------------------------------------------------]]

local _, GridStatusHots = ...

if not GridStatusHots.L then GridStatusHots.L = { } end

local L = setmetatable(GridStatusHots.L, {
	__index = function(t, k)
		t[k] = k
		return k
	end
})

--}}}

local GridRoster = Grid:GetModule("GridRoster")
local GridStatusHots = Grid:GetModule("GridStatus"):NewModule("GridStatusHots", "AceTimer-3.0")
local refreshTimer

GridStatusHots.menuName = L["My HoTs"];

local playerClass, englishClass = UnitClass("player")
local playerRace, englishRace = UnitRace("player")

local spellNameCache = {};
--Druid
spellNameCache.Lifebloom1 = GetSpellInfo(33763);
spellNameCache.Lifebloom2 = GetSpellInfo(94447);
spellNameCache.Regrowth = GetSpellInfo(8936);
spellNameCache.Rejuvenation = GetSpellInfo(774);
spellNameCache.WildGrowth = GetSpellInfo(48438);

--Paladin
spellNameCache.BeaconofLight = GetSpellInfo(53563);

--Priest
spellNameCache.Grace = GetSpellInfo(47930);
spellNameCache.HolyWordAspire = GetSpellInfo(88682);
spellNameCache.PrayerofMending = GetSpellInfo(33076);
spellNameCache.Renew = GetSpellInfo(139);
spellNameCache.PowerWordShield = GetSpellInfo(17);
spellNameCache.WeakenedSoul = GetSpellInfo(6788);

--Shaman
spellNameCache.Earthliving = GetSpellInfo(51945);
spellNameCache.EarthShield = GetSpellInfo(974);
spellNameCache.Riptide = GetSpellInfo(61295);

--Draenei
spellNameCache.GiftoftheNaaru = GetSpellInfo(28880);


GridStatusHots.extraOptions = {
}


--{{{ AceDB defaults
--
GridStatusHots.defaultDB = {
	alert_tothots = {
		text = L["Hots: Hot Count"],
		enable = true,
		lbeach = false,
		priority = 95,
		range = false,
		color = { r = 0, g = 1, b = 0, a = 1 },
	},

	--Druid
	alert_lifebl = {
		text = L["Hots: My Lifebloom"],
		enable = true,
		totshow = true,
		decshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_lifebl_stack = {
		text = L["Hots: My Lifebloom Stack Colored"],
		enable = true,
		totshow = true,
		decshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_regrow = {
		text = L["Hots: My Regrowth"],
		enable = true,
		totshow = true,
		priority = 97,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 1, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_rejuv = {
		text = L["Hots: My Rejuvenation"],
		enable = true,
		totshow = true,
		priority = 98,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 0, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_wgrowth = {
		text = L["Hots: My Wild Growth"],
		enable = true,
		totshow = true,
		priority = 96,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Paladin
	alert_beacon = {
		text = L["Hots: My Beacon of Light"],
		enable = true,
		priority = 96,
		range = false,
		threshold2 = 10,
		threshold3 = 5,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Priest
	alert_gracestack = {
		text = L["Hots: My Grace Stack"],
		enable = true,
		priority = 90,
		range = false,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_gracedurstack = {
		text = L["Hots: My Grace Duration + Stack"],
		enable = true,
		priority = 90,
		range = false,
		threshold2 = 5.5,
		threshold3 = 3,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_pom = {
		text = L["Hots: My Prayer of Mending"],
		enable = true,
		priority = 70,
		range = false,
		mine = false,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = .5, b = 0, a = 1 },
		color3 = { r = 1, g = 1, b = 0, a = 1 },
		color4 = { r = 0, g = 1, b = 1, a = 1 },
		color5 = { r = .5, g = 1, b = 0, a = 1 },
		color6 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_pomdur = {
		text = L["Hots: My Prayer of Mending - duration colored"],
		enable = true,
		priority = 70,
		range = false,
		mine = false,
		threshold2 = 6,
		threshold3 = 3,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_pws = {
		text = L["Hots: Power Word: Shield"],
		enable = true,
		wsshow = false,
		priority = 91,
		range = false,
		threshold2 = 10,
		threshold3 = 5,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_weakenedsoul = {
		text = L["Hots: Weakened Soul"],
		enable = true,
		priority = 92,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = .5, b = 0, a = 1 },
		color3 = { r = 1, g = 1, b = 0, a = 1 },
	},
	alert_renew = {
		text = L["Hots: My Renew"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_aspire = {
		text = L["Hots: My Holy Word: Aspire"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Shaman
	alert_earthliving = {
		text = L["Hots: My Earthliving"],
		enable = true,
		totshow = true,
		priority = 98,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_earthshield = {
		text = L["Hots: My Earth Shield"],
		enable = true,
		priority = 91,
		range = false,
		threshold2 = 2,
		threshold3 = 1,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = .5, b = 0, a = 1 },
		color3 = { r = 1, g = 1, b = 0, a = 1 },
		color4 = { r = 0, g = 1, b = 1, a = 1 },
		color5 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_riptide = {
		text = L["Hots: My Riptide"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Draenei
	alert_gift = {
		text = L["Hots: My Gift of the Naaru"],
		enable = true,
		totshow = true,
		priority = 91,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
}

local tothots_options = {
	["lbeach"] = {
		type = "toggle",
		name = L["Count Lifebloom as 1 HoT per stack"],
		desc = L["Check, if you want each stack of Lifebloom to count as 1 HoT"],
		get = function () return GridStatusHots.db.profile.alert_tothots.lbeach end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_tothots.lbeach = arg
		end,
	},
}

local renew_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_renew.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_renew.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_renew.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_renew.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_renew.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_renew.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_renew.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_renew.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_renew.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_renew.totshow = arg
		end,
	},
}

local aspire_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_aspire.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_aspire.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_aspire.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_aspire.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_aspire.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_aspire.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_aspire.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_aspire.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_aspire.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_aspire.totshow = arg
		end,
	},
}

local rejuv_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_rejuv.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_rejuv.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_rejuv.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_rejuv.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_rejuv.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_rejuv.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_rejuv.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_rejuv.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_rejuv.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_rejuv.totshow = arg
		end,
	},
}

local regrow_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_regrow.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_regrow.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_regrow.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_regrow.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_regrow.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_regrow.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_regrow.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_regrow.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_regrow.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_regrow.totshow = arg
		end,
	},
}

local lifebl_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_lifebl.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_lifebl.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_lifebl.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_lifebl.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_lifebl.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_lifebl.totshow = arg
		end,
	},
	["decshow"] = {
		type = "toggle",
		name = L["Show decimals"],
		desc = L["Check, if you want to see one decimal place for your Lifebloom(i.e. 7.1)"],
		get = function () return GridStatusHots.db.profile.alert_lifebl.decshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_lifebl.decshow = arg
		end,
	},
}

local lifebl_stack_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_lifebl_stack.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_lifebl_stack.totshow = arg
		end,
	},
	["decshow"] = {
		type = "toggle",
		name = L["Show decimals"],
		desc = L["Check, if you want to see one decimal place for your Lifebloom(i.e. 7.1)"],
		get = function () return GridStatusHots.db.profile.alert_lifebl_stack.decshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_lifebl_stack.decshow = arg
		end,
	},
}

local wgrowth_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_wgrowth.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_wgrowth.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_wgrowth.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_wgrowth.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_wgrowth.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_wgrowth.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_wgrowth.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_wgrowth.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_wgrowth.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_wgrowth.totshow = arg
		end,
	},
}

local riptide_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_riptide.threshold2
			end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_riptide.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_riptide.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_riptide.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_riptide.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_riptide.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_riptide.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_riptide.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_riptide.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_riptide.totshow = arg
		end,
	},
}

local pom_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color when player has two charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color when player has three charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color4"] = {
		type = "color",
		name = L["Color 4"],
		desc = L["Color when player has four charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color4
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color4
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color5"] = {
		type = "color",
		name = L["Color 5"],
		desc = L["Color when player has five charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color5
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color5
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color6"] = {
		type = "color",
		name = L["Color 6"],
		desc = L["Color when player has six charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color6
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color6
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["mine"] = {
		type = "toggle",
		name = L["Only mine"],
		desc = L["Only show my PoM"],
		order = 102,
		get = function () return GridStatusHots.db.profile.alert_pom.mine end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_pom.mine = arg
		end,
	},
}

local pomdur_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 20,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_pomdur.threshold2
		      end,
		set = function (_, v)
			       GridStatusHots.db.profile.alert_pomdur.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pomdur.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pomdur.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 20,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_pomdur.threshold3
		      end,
		set = function (_, v)
			       GridStatusHots.db.profile.alert_pomdur.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pomdur.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pomdur.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["mine"] = {
		type = "toggle",
		name = L["Only mine"],
		desc = L["Only show my PoM"],
		order = 102,
		get = function () return GridStatusHots.db.profile.alert_pom.mine end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_pom.mine = arg
		end,
	},
}

local pws_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 20,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_pws.threshold2
			end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_pws.threshold2 = v
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 20,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_pws.threshold3
			end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_pws.threshold3 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pws.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pws.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pws.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pws.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["wsshow"] = {
		type = "toggle",
		name = L["Combine Timers"],
		desc = L["Check, if you want to see the Weakened Soul Timer behind the Pw: Shield Timer(i.e. 13-5)"],
		order = 102,
		get = function () return GridStatusHots.db.profile.alert_pws.wsshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_pws.wsshow = arg
		end,
	},
}

local weakenedsoul_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_weakenedsoul.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_weakenedsoul.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_weakenedsoul.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_weakenedsoul.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_weakenedsoul.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_weakenedsoul.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_weakenedsoul.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_weakenedsoul.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}


local beacon_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 30,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_beacon.threshold2
			end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_beacon.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_beacon.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_beacon.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 30,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_beacon.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_beacon.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_beacon.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_beacon.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local earthliving_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_earthliving.threshold2
			end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_earthliving.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthliving.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthliving.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_earthliving.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_earthliving.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthliving.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthliving.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_earthliving.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_earthliving.totshow = arg
		end,
	},
}

local earthshield_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color when player has 2 charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color when player has 3 charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color4"] = {
		type = "color",
		name = L["Color 4"],
		desc = L["Color when player has 4 charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color4
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color4
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color5"] = {
		type = "color",
		name = L["Color 5"],
		desc = L["Color when player has 5 or more charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color5
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color5
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local gracestack_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color when player has two charges of grace."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracestack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracestack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color when player has three charges of grace."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracestack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracestack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local gracedurstack_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_gracedurstack.threshold2
		      end,
		set = function (_, v)
			       GridStatusHots.db.profile.alert_gracedurstack.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracedurstack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracedurstack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_gracedurstack.threshold3
		      end,
		set = function (_, v)
			       GridStatusHots.db.profile.alert_gracedurstack.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracedurstack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracedurstack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local gift_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_gift.threshold2
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_gift.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gift.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gift.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_gift.threshold3
		end,
		set = function (_, v)
			GridStatusHots.db.profile.alert_gift.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gift.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (_, r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gift.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_gift.totshow end,
		set = function (_, arg)
			GridStatusHots.db.profile.alert_gift.totshow = arg
		end,
	},
}

--}}}


function GridStatusHots:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatuses()
end

function GridStatusHots:OnEnable()
	refreshTimer = self:ScheduleRepeatingTimer("UpdateAllUnits", 0)
end

function GridStatusHots:Reset()
	self.super.Reset(self)

	self:UnregisterStatuses()
	self:RegisterStatuses()
	self:UpdateAllUnits()
end

function GridStatusHots:RegisterStatuses()
	self:RegisterStatus("alert_tothots", L["Hots: Hot Count"], tothots_options)
	if englishClass == "PRIEST" then
		self:RegisterStatus("alert_renew", L["Hots: My Renew"], renew_hotcolors)
		self:RegisterStatus("alert_aspire", L["Hots: My Holy Word: Aspire"], aspire_hotcolors)
        self:RegisterStatus("alert_pom", L["Hots: My Prayer of Mending"], pom_hotcolors)
        self:RegisterStatus("alert_pomdur", L["Hots: My Prayer of Mending - duration colored"], pomdur_hotcolors)
		self:RegisterStatus("alert_gracestack", L["Hots: My Grace Stack"], gracestack_hotcolors)
		self:RegisterStatus("alert_gracedurstack", L["Hots: My Grace Duration + Stack"], gracedurstack_hotcolors)
		self:RegisterStatus("alert_pws", L["Hots: Power Word: Shield"], pws_hotcolors)
        self:RegisterStatus("alert_weakenedsoul", L["Hots: Weakened Soul"], weakenedsoul_hotcolors)
	end
	if englishClass == "DRUID" then
		self:RegisterStatus("alert_rejuv", L["Hots: My Rejuvenation"], rejuv_hotcolors)
		self:RegisterStatus("alert_regrow", L["Hots: My Regrowth"], regrow_hotcolors)
		self:RegisterStatus("alert_lifebl", L["Hots: My Lifebloom"], lifebl_hotcolors)
		self:RegisterStatus("alert_lifebl_stack", L["Hots: My Lifebloom Stack Colored"], lifebl_stack_hotcolors)
		self:RegisterStatus("alert_wgrowth", L["Hots: My Wild Growth"], wgrowth_hotcolors)
	end
	if englishClass == "PALADIN" then
		self:RegisterStatus("alert_beacon", L["Hots: My Beacon of Light"], beacon_hotcolors)
	end
	if englishClass == "SHAMAN" then
		self:RegisterStatus("alert_riptide", L["Hots: My Riptide"], riptide_hotcolors)
		self:RegisterStatus("alert_earthliving", L["Hots: My Earthliving"], earthliving_hotcolors)
		self:RegisterStatus("alert_earthshield", L["Hots: My Earth Shield"], earthshield_hotcolors)
	end
	if englishRace == "Draenei" then
		self:RegisterStatus("alert_gift", L["Hots: My Gift of the Naaru"], gift_hotcolors)
	end
end

function GridStatusHots:UnregisterStatuses()
	self:UnregisterStatus("alert_tothots")
	if englishClass == "PRIEST" then
		self:UnregisterStatus("alert_renew")
		self:UnregisterStatus("alert_aspire")
        self:UnregisterStatus("alert_pom")
        self:UnregisterStatus("alert_pomdur")
		self:UnregisterStatus("alert_gracestack")
		self:UnregisterStatus("alert_gracedurstack")
		self:UnregisterStatus("alert_pws")
        self:UnregisterStatus("alert_weakenedsoul")
	end
	if englishClass == "DRUID" then
		self:UnregisterStatus("alert_rejuv")
		self:UnregisterStatus("alert_regrow")
		self:UnregisterStatus("alert_lifebl")
		self:UnregisterStatus("alert_lifebl_stack")
		self:UnregisterStatus("alert_wgrowth")
	end
	if englishClass == "PALADIN" then
		self:UnregisterStatus("alert_beacon")
	end
	if englishClass == "SHAMAN" then
		self:UnregisterStatus("alert_riptide")
		self:UnregisterStatus("alert_earthliving")
		self:UnregisterStatus("alert_earthshield")
	end
	if englishRace == "Draenei" then
		self:UnregisterStatus("alert_gift")
	end
end

function GridStatusHots:Grid_UnitJoined(guid, unitid)
	self:UpdateUnit(unitid)
end

function GridStatusHots:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
        UpdateUnit(self, guid, unitid)
	end
end

function UpdateUnit(self, guid, unitid)
	local total_hots, lbstack, pomstack, mypomstack, grastack, esstack = 0, 0, 0, 0, 0, 0;
	local asptime,retime,rjtime,rgtime,lbtime,wgtime,sltime,sstime,ritime,pomtime,mypomtime,pwstime,boltime,eltime,estime,gratime,gifttime
	local wstime

	local now = GetTime()
	-- Find number of hots per unit
	for i=1,999 do
		local bname,brank,btexture,bcount,btype,bdur,bexptime,bismine = UnitBuff(unitid, i)
		if not bname then break end

		local btime = bexptime - now
		if bname == spellNameCache["Renew"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then retime = btime end
		elseif bname == spellNameCache["HolyWordAspire"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then asptime = btime end
		elseif bname == spellNameCache["Regrowth"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then rgtime = btime end
		elseif bname == spellNameCache["Rejuvenation"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then rjtime = btime end
		elseif bname == spellNameCache["Lifebloom1"] or bname == spellNameCache["Lifebloom2"] then
			if self.db.profile.alert_tothots.lbeach then
				total_hots = total_hots + bcount;
			else
				total_hots = total_hots + 1;
			end
			if (bismine == "player" and btime) then
				lbtime = btime
				lbstack = bcount
			end
		elseif bname == spellNameCache["WildGrowth"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then wgtime = btime end
		elseif bname == spellNameCache["Riptide"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then ritime = btime end
		elseif bname == spellNameCache["PrayerofMending"] then
				pomtime = btime
				pomstack = bcount
			if bismine == "player"then
				mypomtime = btime
				mypomstack = bcount
			end
		elseif bname == spellNameCache["PowerWordShield"] then
			if btime then
				pwstime = btime
			end
		elseif bname == spellNameCache["BeaconofLight"] then
			if (bismine == "player" and btime) then boltime = btime end
		elseif bname == spellNameCache["Earthliving"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then eltime = btime end
		elseif bname == spellNameCache["EarthShield"] then
			if (bismine == "player" and btime) then
				estime = btime
				esstack = bcount
			end
		elseif bname == spellNameCache["Grace"] then
			if (bismine == "player" and btime) then
				gratime = btime
				grastack = bcount
			end
		elseif bname == spellNameCache["GiftoftheNaaru"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then gifttime = btime end
		end
	end

	-- Find debuffs
	for i=1,999 do
		local dbname,dbrank,dbtexture,dbcount,dbtype,dbdur,dbexptime,dbismine = UnitDebuff(unitid, i)
		if not dbname then break end

		local dbtime = dbexptime - now
		if dbname == spellNameCache["WeakenedSoul"] then
			if dbtime then
				wstime = dbtime
			end
		end
	end

	-- Set number of hots currently running on all units
	if total_hots > 0 and self.db.profile.alert_tothots.enable then
		local settings = self.db.profile.alert_tothots
		self.core:SendStatusGained(guid, "alert_tothots",
			settings.priority,
			(settings.range and 40),
			settings.color,
			tostring(total_hots)
		)
	else
		if self.core:GetCachedStatus(guid, "alert_tothots") then self.core:SendStatusLost(guid, "alert_tothots") end
	end

	--Renew
	if retime and self.db.profile.alert_renew.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_renew
		local hotcolor = settings.color
		if retime <= settings.threshold2 then hotcolor = settings.color2 end
		if retime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_renew",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", retime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_renew",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", retime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_renew") then self.core:SendStatusLost(guid, "alert_renew") end
	end

	--Holy Word: Aspire
	if asptime and self.db.profile.alert_aspire.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_aspire
		local hotcolor = settings.color
		if asptime <= settings.threshold2 then hotcolor = settings.color2 end
		if asptime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_aspire",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", asptime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_aspire",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", asptime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_aspire") then self.core:SendStatusLost(guid, "alert_aspire") end
	end

	--Regrowth
	if rgtime and self.db.profile.alert_regrow.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_regrow
		local hotcolor = settings.color
		if rgtime <= settings.threshold2 then hotcolor = settings.color2 end
		if rgtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_regrow",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", rgtime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_regrow",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", rgtime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_regrow") then self.core:SendStatusLost(guid, "alert_regrow") end
	end

	--Rejuv
	if rjtime and self.db.profile.alert_rejuv.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_rejuv
		local hotcolor = settings.color
		if rjtime <= settings.threshold2 then hotcolor = settings.color2 end
		if rjtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_rejuv",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", rjtime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_rejuv",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", rjtime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_rejuv") then self.core:SendStatusLost(guid, "alert_rejuv") end
	end

	--Lifebloom
	if lbtime and self.db.profile.alert_lifebl_stack.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_lifebl_stack
		local hotcolor = settings.color
		if lbstack == 2 then hotcolor = settings.color2 end
		if lbstack == 3 then hotcolor = settings.color3 end
		if settings.totshow then
			if settings.decshow then
				self.core:SendStatusGained(guid, "alert_lifebl_stack",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%.1f-%d", lbtime, total_hots)
				)
			else
				self.core:SendStatusGained(guid, "alert_lifebl_stack",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d-%d", lbtime, total_hots)
				)
			end
		else
			if settings.decshow then
				self.core:SendStatusGained(guid, "alert_lifebl_stack",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%.1f", lbtime)
				)
			else
				self.core:SendStatusGained(guid, "alert_lifebl_stack",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d", lbtime)
				)
			end
		end
	else
		if self.core:GetCachedStatus(guid, "alert_lifebl_stack") then self.core:SendStatusLost(guid, "alert_lifebl_stack") end
	end

	if lbtime and self.db.profile.alert_lifebl.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_lifebl
		local hotcolor = settings.color
		if lbtime <= settings.threshold2 then hotcolor = settings.color2 end
		if lbtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			if settings.decshow then
				self.core:SendStatusGained(guid, "alert_lifebl",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d-%.1f-%d", lbstack, lbtime, total_hots)
				)
			else
				self.core:SendStatusGained(guid, "alert_lifebl",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d-%d-%d", lbstack, lbtime, total_hots)
				)
			end
		else
			if settings.decshow then
				self.core:SendStatusGained(guid, "alert_lifebl",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d-%.1f", lbstack, lbtime)
				)
			else
				self.core:SendStatusGained(guid, "alert_lifebl",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d-%d", lbstack, lbtime)
				)
			end
		end
	else
		if self.core:GetCachedStatus(guid, "alert_lifebl") then self.core:SendStatusLost(guid, "alert_lifebl") end
	end

	--Wild Growth
	if wgtime and self.db.profile.alert_wgrowth.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_wgrowth
		local hotcolor = settings.color
		if wgtime <= settings.threshold2 then hotcolor = settings.color2 end
		if wgtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_wgrowth",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", wgtime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_wgrowth",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", wgtime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_wgrowth") then self.core:SendStatusLost(guid, "alert_wgrowth") end
	end

	--Riptide
	if ritime and self.db.profile.alert_riptide.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_riptide
		local hotcolor = settings.color
		if ritime <= settings.threshold2 then hotcolor = settings.color2 end
		if ritime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_riptide",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", ritime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_riptide",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", ritime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_riptide") then self.core:SendStatusLost(guid, "alert_riptide") end
	end

	-- Earth Shield
	if estime and self.db.profile.alert_earthshield.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_earthshield
		local hotcolor = settings.color
		if esstack == 2 then hotcolor = settings.color2 end
		if esstack == 3 then hotcolor = settings.color3 end
		if esstack == 4 then hotcolor = settings.color4 end
		if esstack > 4 then hotcolor = settings.color5 end
		self.core:SendStatusGained(guid, "alert_earthshield",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			tostring(esstack)
		)
	else
		if self.core:GetCachedStatus(guid, "alert_earthshield") then self.core:SendStatusLost(guid, "alert_earthshield") end
	end

	--Prayer of Mending
	if pomtime or mypomtime and self.db.profile.alert_pom.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_pom
		local hotcolor = settings.color
		if pomstack == 2 then hotcolor = settings.color2 end
		if pomstack == 3 then hotcolor = settings.color3 end
		if pomstack == 4 then hotcolor = settings.color4 end
		if pomstack == 5 then hotcolor = settings.color5 end
		if pomstack == 6 then hotcolor = settings.color6 end
		if mypomtime and self.db.profile.alert_pom.mine then
			self.core:SendStatusGained(guid, "alert_pom",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", mypomtime)
			)
		elseif pomtime and not self.db.profile.alert_pom.mine then
			self.core:SendStatusGained(guid, "alert_pom",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", pomtime)
			)
		else
			if self.core:GetCachedStatus(guid, "alert_pom") then self.core:SendStatusLost(guid, "alert_pom") end
		end
	else
		if self.core:GetCachedStatus(guid, "alert_pom") then self.core:SendStatusLost(guid, "alert_pom") end
	end

	if pomtime or mypomtime and self.db.profile.alert_pomdur.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_pomdur
		local hotcolor = settings.color
		if pomtime <= settings.threshold2 then hotcolor = settings.color2 end
		if pomtime <= settings.threshold3 then hotcolor = settings.color3 end
		if mypomtime and self.db.profile.alert_pom.mine then
			self.core:SendStatusGained(guid, "alert_pomdur",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(mypomstack)
			)
		elseif pomtime and not self.db.profile.alert_pom.mine then
			self.core:SendStatusGained(guid, "alert_pomdur",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(pomstack)
			)
		else
			if self.core:GetCachedStatus(guid, "alert_pomdur") then self.core:SendStatusLost(guid, "alert_pomdur") end
		end
	else
		if self.core:GetCachedStatus(guid, "alert_pomdur") then self.core:SendStatusLost(guid, "alert_pomdur") end
	end

	--Power Word: Shield
	if pwstime or wstime and self.db.profile.alert_pws.enable then
		if pwstime then
			-- Add self thrown countdown and status
			local settings = self.db.profile.alert_pws
			local hotcolor = settings.color
			if pwstime <= settings.threshold2 then hotcolor = settings.color2 end
			if pwstime <= settings.threshold3 then hotcolor = settings.color3 end
			if settings.wsshow and wstime then
				self.core:SendStatusGained(guid, "alert_pws",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d-%d", pwstime, wstime)
				)
			else
				self.core:SendStatusGained(guid, "alert_pws",
					settings.priority,
					(settings.range and 40),
					hotcolor,
					string.format("%d", pwstime)
				)
			end
		elseif self.db.profile.alert_pws.wsshow and wstime then
			-- Add self thrown countdown and status
			local settings = self.db.profile.alert_weakenedsoul
			local hotcolor = settings.color
			if wstime <= settings.threshold2 then hotcolor = settings.color2 end
			if wstime <= settings.threshold3 then hotcolor = settings.color3 end
			self.core:SendStatusGained(guid, "alert_pws",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", wstime)
			)
		else
			if self.core:GetCachedStatus(guid, "alert_pws") then self.core:SendStatusLost(guid, "alert_pws") end
		end
	else
		if self.core:GetCachedStatus(guid, "alert_pws") then self.core:SendStatusLost(guid, "alert_pws") end
	end

	--Weakened Soul
	if wstime and self.db.profile.alert_weakenedsoul.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_weakenedsoul
		local hotcolor = settings.color
		if wstime <= settings.threshold2 then hotcolor = settings.color2 end
		if wstime <= settings.threshold3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(guid, "alert_weakenedsoul",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			string.format("%d", wstime)
		)
	else
		if self.core:GetCachedStatus(guid, "alert_weakenedsoul") then self.core:SendStatusLost(guid, "alert_weakenedsoul") end
	end

	--Beacon of Light
	if boltime and self.db.profile.alert_beacon.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_beacon
		local hotcolor = settings.color
		if boltime <= settings.threshold2 then hotcolor = settings.color2 end
		if boltime <= settings.threshold3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(guid, "alert_beacon",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			string.format("%d", boltime)
		)
	else
		if self.core:GetCachedStatus(guid, "alert_beacon") then self.core:SendStatusLost(guid, "alert_beacon") end
	end

	--Earthliving
	if eltime and self.db.profile.alert_earthliving.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_earthliving
		local hotcolor = settings.color
		if eltime <= settings.threshold2 then hotcolor = settings.color2 end
		if eltime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_earthliving",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", eltime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_earthliving",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", eltime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_earthliving") then self.core:SendStatusLost(guid, "alert_earthliving") end
	end

	--Grace
	if gratime and (self.db.profile.alert_gracestack.enable or self.db.profile.alert_gracedurstack.enable) then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_gracestack
		local hotcolor = settings.color
		if grastack == 2 then hotcolor = settings.color2 end
		if grastack == 3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(guid, "alert_gracestack",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			string.format("%d", gratime)
		)

		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_gracedurstack
		local hotcolor = settings.color
		if gratime <= settings.threshold2 then hotcolor = settings.color2 end
		if gratime <= settings.threshold3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(guid, "alert_gracedurstack",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			string.format("%d-%d", gratime, grastack)
		)
	else
		if self.core:GetCachedStatus(guid, "alert_gracestack") then self.core:SendStatusLost(guid, "alert_gracestack") end
		if self.core:GetCachedStatus(guid, "alert_gracedurstack") then self.core:SendStatusLost(guid, "alert_gracedurstack") end
	end

	--Gift of the Naaru
	if gifttime and self.db.profile.alert_gift.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_gift
		local hotcolor = settings.color
		if gifttime <= settings.threshold2 then hotcolor = settings.color2 end
		if gifttime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(guid, "alert_gift",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%d", gifttime, total_hots)
			)
		else
			self.core:SendStatusGained(guid, "alert_gift",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d", gifttime)
			)
		end
	else
		if self.core:GetCachedStatus(guid, "alert_gift") then self.core:SendStatusLost(guid, "alert_gift") end
	end
end
