TidyPlatesThemeList["Graphite"] = {}
local theme = TidyPlatesThemeList["Graphite"]
local path = "Interface\\Addons\\TidyPlates_Graphite\\" 
local font = path.."Qlassik_TB.ttf"

local artwidth = 128
local artheight = 32
local barwidth = 194/2
local widthfactor = .75
local heightfactor = .75

local barheight = 16

theme.healthborder = {
	texture	= path.."Graphite2_GlassOverlay",
	width = artwidth*widthfactor,
	height = artheight*heightfactor,
	x = 0,
	y = 0,
}

theme.highlight = {
	texture	= path.."Graphite2_Mouseover",
	width = artwidth*widthfactor,
	height = artheight*heightfactor,
	x = 0,
	y = 0,
}

theme.target = {
	texture	= path.."Graphite2_Target",
	width = artwidth*widthfactor,
	height = artheight*heightfactor,
	x = 0,
	y = 0,
	show = true,
}

theme.healthbar = {
	texture 				= path.."Graphite2_StatusBar",
	width = barwidth*widthfactor,
	height = artheight*heightfactor,
	x = 0,
	y = 0,
}

theme.threatborder = {
	texture = path.."Graphite2_ThreatGlow",
	width = artwidth*widthfactor,
	height = artheight*heightfactor,
	x = 0,
	y = 0,
	show = false,
}

theme.castborder = {
	texture	= path.."HealthBorder",
	glowtexture 			= path.."HealthBorder",
	elitetexture = path.."HealthBorder",
	width = artwidth*widthfactor,
	height = artheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6,
}

theme.castbar = {
	texture 				= path.."StatusBar",
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
	typeface = font,
	-- size = 10, 
	show = false,
}

-- /run TidyPlatesThemeList["Graphite"].spellicon.x = 4

-- Test Cast Bar: 
--/run TestTidyPlatesCastBar("Boognish", 133)

theme.spelltext = {
	typeface = font,
	
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
	typeface = font,
	
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


theme.SetThreatColor = function(unit) return 1, 0, 0, 0 end


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