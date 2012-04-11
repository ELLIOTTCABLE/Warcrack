local Media = LibStub("LibSharedMedia-3.0")
local config = {}
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Artwork\\"
local font = "Interface\\Addons\\TidyPlates_ThreatPlates\\Fonts\\"
local setTheme = CreateFrame("Frame")
local eventlist = {}
function eventlist:ADDON_LOADED()
	if arg1 == "TidyPlates_ThreatPlates" then
		local db = TidyPlatesThreat.db.profile.settings
config.hitbox = {
	width = 124,
	height = 30,
}
config.frame = {
	emptyTexture =					path.."Empty",
	width = 124,
	height = 30,
	x = 0,
	y = 0,
	anchor = "CENTER",
}
config.threatborder = {
	texture =						path.."Empty",
	elitetexture =					path.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
}
config.healthborder = {
	texture = 						path.."Empty",
	glowtexture = 					path.."Empty",
	elitetexture = 					path.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
}
config.castborder = {
	texture =						path.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = -15,
	anchor = "CENTER",
}

config.castnostop = {
	texture =						path.."Empty",
	width = 256,
	height = 64,
	x = 0,
	y = -15,
	anchor = "CENTER",
}
--[[Bar Textures]]--
config.healthbar = {
	texture = 						path.."Empty",
	width = 120,
	height = 10,
	x = 0,
	y = 0,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}
config.castbar = {
	texture =						path.."Empty",
	width = 120,
	height = 10,
	x = 0,
	y = -15,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}
--[[TEXT]]--

config.name = {
	typeface =						Media:Fetch('font', db.name.typeface),
	size = db.name.size,
	width = db.name.width,
	height = db.name.height,
	x = db.name.x,
	y = db.name.y,
	align = db.name.align,
	anchor = "CENTER",
	vertical = db.name.vertical,
	shadow = true,
}
config.level = {
	typeface =						Media:Fetch('font', db.level.typeface),
	size = db.level.size,
	width = db.level.width,
	height = db.level.height,
	x = db.level.x,
	y = db.level.y,
	align = db.level.align,
	anchor = "CENTER",
	vertical = db.level.vertical,
	shadow = true,
}
config.specialText = {
	typeface =						Media:Fetch('font', db.specialText.typeface),
	size = db.specialText.size,
	width = db.specialText.width,
	height = db.specialText.height,
	x = db.specialText.x,
	y = db.specialText.y,
	align = db.specialText.align,
	anchor = "CENTER",
	vertical = db.specialText.vertical,
	shadow = true,
}
config.specialText2 = {
	typeface =						Media:Fetch('font', db.specialText2.typeface),
	size = db.specialText2.size,
	width = db.specialText2.width,
	height = db.specialText2.height,
	x = db.specialText2.x,
	y = db.specialText2.y,
	align = db.specialText2.align,
	anchor = "CENTER",
	vertical = db.specialText2.vertical,
	shadow = true,
}
--[[ICONS]]--
config.dangerskull = {
	width = (db.dangerskull.scale),
	height = (db.dangerskull.scale),
	x = (db.dangerskull.x),
	y = (db.dangerskull.y),
	anchor = (db.dangerskull.anchor),
}
config.specialArt = {
	width = (db.specialArt.scale),
	height = (db.specialArt.scale),
	x = (db.specialArt.x),
	y = (db.specialArt.y),
	anchor = (db.specialArt.anchor),
}
config.spellicon = {
	width = (db.spellicon.scale),
	height = (db.spellicon.scale),
	x = (db.spellicon.x),
	y = (db.spellicon.y),
	anchor = (db.spellicon.anchor),
}
config.raidicon = {
	width = (db.raidicon.scale),
	height = (db.raidicon.scale),
	x = (db.raidicon.x),
	y = (db.raidicon.y),
	anchor = (db.raidicon.anchor),
}
--[[OPTIONS]]--
config.threatcolor = {
	LOW = { r = 0, g = 0, b = 0, a = 0 },
	MEDIUM = { r = 0, g = 0, b = 0, a = 0 },
	HIGH = { r = 0, g = 0, b = 0, a = 0 },
}
config.options = {
	showLevel = false,
	showName = false,
	showSpecialArt = false,
	showSpecialText = false,
	showSpecialText2 = false,
	showSpecialText3 = false,
	showDangerSkull = false,
	showspellIcon = false,
	showNostopSpell = false,
	useCustomHealthbarColor = false,
}
TidyPlatesThemeList["Threat Plates"]["empty"] = {}
TidyPlatesThemeList["Threat Plates"]["empty"] = config
	end
end

setTheme:SetScript("OnEvent", function(self, event) eventlist[event]() end)
setTheme:RegisterEvent("ADDON_LOADED")
