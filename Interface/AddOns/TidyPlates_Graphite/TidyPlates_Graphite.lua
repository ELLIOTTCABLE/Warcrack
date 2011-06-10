TidyPlatesThemeList["Graphite"] = {}
local theme = TidyPlatesThemeList["Graphite"]
local path = "Interface\\Addons\\TidyPlates_Graphite" 

local artwidth = 128
local borderheight = 16
local barheight = 16
local widthfactor = .6
local heightfactor = .8


theme.healthborder = {
	texture	= path.."\\HealthBorder",
	glowtexture 			= path.."\\Mouseover",
	elitetexture = path.."\\HealthBorder",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	x = 0,
	y = 0,
}

theme.highlight = {
	texture	= path.."\\Mouseover",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	x = 0,
	y = 0,
}

theme.healthbar = {
	texture 				= path.."\\StatusBar",
	width = 98*widthfactor,
	--width = 96*widthfactor,
	height = barheight*heightfactor,
	x = 0,
	y = 0,
}

theme.threatborder = {
	texture = path.."\\Empty",
	elitetexture = path.."\\Empty",
}

theme.castborder = {
	texture	= path.."\\HealthBorder",
	glowtexture 			= path.."\\HealthBorder",
	elitetexture = path.."\\HealthBorder",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6,
}

theme.castbar = {
	texture 				= path.."\\StatusBar",
	width = 96*widthfactor,
	height = barheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6,
}

--[[
theme.spellicon = {
	height = 12,
	width = 12,
	x = 0,
	y = -7,
	show = true,
}
--]]

theme.spellicon = {
	height = 12,
	width = 12,
	x = -38,
	y = -4,
	show = true,
}


theme.name = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = 7,	-- For OVER the bar
	--y = -7,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = true,
	show = true,
}

-- /run TidyPlatesThemeList["Graphite"].spellicon.x = 4

-- Test Cast Bar: 
--/run TestTidyPlatesCastBar("Boognish", 133)

theme.spelltext = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = -16,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = false,
	show = true,
}

theme.level = {
	show = false,
}

theme.customtext = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = 7,	-- For OVER the bar
	--y = -7,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = true,
	show = false,
}



theme.raidicon = {
	width = 18,
	height = 18,
	x = 0,
	y = 0,
	anchor = "LEFT",
}

theme.frame = {
	x = 0,
	y = 11,
}

theme.hitbox = {
	width = 100,
	height = 35,
}

theme.skullicon = {
	show = false,
}


local function SpellText(unit)
	local spellname
	if unit.isCasting then 
		spellname = UnitCastingInfo("target") or UnitChannelInfo("target")
		return spellname
	else return "" end
end

-- Hex Colors
local OrangeHexColor = "|cFFfc551b"
local PaleBlueHexColor = "|cFF5cb8ff"

local BlueHexColor = "|cFF3cA8ff"	-- 3c A8 ff		-- 60 168 255
--local GreenHexColor = "|cFF3cee35"
local GreenHexColor = "|cFF60E025"	-- 60 E0 25		-- 96 224 37
--local RedHexColor = "|cFFFF0000"
local RedHexColor = "|cFFFF3320"	-- FF 33 20		-- 255 51 32
local GoldHexColor = "|cFFfcb41b"	-- fc b4 1b		-- 252 180 27

---------------------------------------
-- Name Text Color
---------------------------------------
local NameReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 60/255, g = 168/255, b = 255/255,},
		["NPC"] = {r = 96/255, g = 224/255, b = 37/255,},
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 255/255, g = 51/255, b = 32/255,},
		["NPC"] = {r = 255/255, g = 51/255, b = 32/255,},
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 252/255, g = 180/255, b = 27/255,},
	},
}

local function SetNameColorDelegate(unit)
	local color = NameReactionColors[unit.reaction][unit.type]
	if color then 
		return color.r, color.g, color.b
	else 
		return unit.red, unit.green, unit.blue 
	end
end

theme.SetNameColor = SetNameColorDelegate


local dec2hex = {
	["0"] = "0",
	["1"] = "1",
	["2"] = "2",
	["3"] = "3",
	["4"] = "4",
	["5"] = "5",
	["6"] = "6",
	["7"] = "7",
	["8"] = "8",
	["9"] = "9",
	["10"] = "A",
	["11"] = "B",
	["12"] = "C",
	["13"] = "D",
	["14"] = "E",
	["15"] = "F"
}
	
local function FracToHex(frac)
	local val1, val2 = floor((frac*255)/16), floor(mod(frac*255, 16))
	local str = dec2hex[tostring(val1)]..dec2hex[tostring(val2)]
	return str
end

local function NameTextDelegate(unit)
	if unit.reaction == "HOSTILE" then
		return RedHexColor..unit.name
	elseif unit.reaction == "FRIENDLY" then
		if unit.type == "NPC" then	return GreenHexColor..unit.name
		else return BlueHexColor..unit.name end
	elseif unit.reaction == "NEUTRAL" then
		return GoldHexColor..unit.name
	else return unit.name end
	--[[
	if InCombatLockdown() then
		if unit.reaction == "FRIENDLY" then
			return GreenHexColor..unit.name
		elseif unit.threatSituation == "HIGH" then
			return OrangeHexColor..unit.name
		elseif unit.threatSituation == "MEDIUM" then
			return GoldHexColor..unit.name
		else
			return PaleBlueHexColor..unit.name
		end
	else return unit.name end
	--]]
end

-- RGB Colors
local BlueColor = {0, 123/256, 1}

local function HealthColorDelegate(unit)
	local r, g, b = unit.red, unit.green, unit.blue
	r=(r*.5)+.5
	g=(g*.5)+.5
	b=(b*.5)+.5
	--return unpack(BlueColor)
	return r,g,b
end

theme.SetCustomText = NameTextDelegate


local function HealthColorDelegate(unit)
	local r, g, b = unit.red, unit.green, unit.blue
	if unit.isTarget or (not UnitExists("target")) then
		return r, g, b
	else
		r=(r*.5)
		g=(g*.5)
		b=(b*.5)
		--return unpack(BlueColor)
		return r,g,b
	end
	

end

--theme.SetHealthbarColor = HealthColorDelegate

local function SetScaleDelegate(unit)
	return 1.2
end

theme.SetScale = SetScaleDelegate