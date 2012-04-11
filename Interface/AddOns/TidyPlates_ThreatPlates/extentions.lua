local Media = LibStub("LibSharedMedia-3.0")
local _, PlayerClass = UnitClass("player")
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Artwork\\"
local classColors = { 
SHAMAN 		= "2459FF", 
MAGE 		= "69CCF0",
WARLOCK 	= "9482C9",
HUNTER		= "ABD473",
ROGUE		= "FFF569",
PRIEST		= "FFFFFF",
DRUID 		= "FF7D0A",
DEATHKNIGHT = "C41F3B",
WARRIOR 	= "C79C6E",
PALADIN 	= "F58CBA",
}
-- Elite Art
local function UpdateEliteFrameArt(frame, unit)
	if (unit.isElite) and TidyPlatesThreat.db.profile.settings.options.showEliteIcon then
		frame.Icon:SetTexture(path.."icons\\elite\\"..TidyPlatesThreat.db.profile.eliteTheme)
		frame:Show()
	else
		frame:Hide()
	end
end	
local function CreateEliteFrameArt(parent)
	local db = TidyPlatesThreat.db.profile.settings.eliteIcon
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(db.scale)
	frame:SetWidth(db.scale)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateEliteFrameArt
	return frame
end
-- Target Art
local function UpdateTargetFrameArt(frame, unit)
	if UnitExists("target") and unit.isTarget then
		frame.Icon:SetTexture(path.."TP_Target")
		frame:Show()
	else
		frame:Hide()
	end
end
local function CreateTargetFrameArt(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(256)
	frame:SetHeight(64)	
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateTargetFrameArt
	return frame
end

-- Name Text
local function CreateNameText(frame)
	local db = TidyPlatesThreat.db.profile.settings
	local text = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
	text:SetText(nil)
	text:SetJustifyH(db.name.align)
	text:SetJustifyV(db.name.vertical)
	text:SetTextColor(1, 1, 1, 1)
	text:SetWidth(db.name.width)
	text:SetHeight(db.name.height)
	text:SetFont(Media:Fetch('font', db.name.typeface), db.name.size, db.name.flags)
	text:SetPoint("CENTER",frame,"CENTER", db.name.x, db.name.y)
	text:SetShadowOffset(1, -1)
	if db.name.shadow then text:SetShadowColor(0,0,0,1)
	else text:SetShadowColor(0,0,0,0) end
	frame.bars.health:RegisterEvent("CURSOR_UPDATE")
	return text
end
-- Combo Points
local comboWidgetPath = path.."widgets\\combo\\"
local COMBO_ART = { "1", "2", "3", "4", "5", }
local function UpdateComboPointFrame(frame, unit)
		local points 
		if UnitExists("target") and unit.isTarget then points = GetComboPoints("player", "target") end
		if points and points > 0 then 
			frame.Icon:SetTexture(comboWidgetPath..COMBO_ART[points]) 
			frame:Show()
		else frame:Hide() end	
end
local function CreateComboPointWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame:RegisterEvent("PLAYER_COMBO_POINTS")
	frame:SetScript("OnEvent", TidyPlates.Update)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateComboPointFrame
	return frame
end

local function OnInitialize(plate)
	db = TidyPlatesThreat.db.profile
	if not plate.widgets.TargetArt then 
		plate.widgets.TargetArt = CreateTargetFrameArt(plate)
		plate.widgets.TargetArt:SetFrameLevel(db.settings.targetArt.level)
	end
	if not plate.widgets.EliteArt then 
		plate.widgets.EliteArt = CreateEliteFrameArt(plate)
		plate.widgets.EliteArt:SetFrameLevel(db.settings.eliteIcon.level)
	end
	if not plate.widgets.NameText then 
		plate.widgets.NameText = CreateNameText(plate)
	end
	if not plate.widgets.ComboPoints then 
		plate.widgets.ComboPoints = CreateComboPointWidget(plate)
	end
	if not plate.widgets.ThreatWidget then
		plate.widgets.ThreatWidget = TidyPlatesWidgets.CreateThreatLineWidget(plate)
		plate.widgets.ThreatWidget:SetPoint("CENTER", plate, (db.threatWidget.x), db.threatWidget.y)
	end
	--plate.widgets.TotemIconWidget = TidyPlatesWidgets.CreateTotemIconWidget(plate)
	--plate.widgets.TotemIconWidget:SetFrameLevel(1)
	--plate.widgets.TotemIconWidget:SetPoint("CENTER", plate, (0), (30))
end



local function ThreatPlatesExtensions(plate, unit)
	local style = SetStyleThreatPlates(unit)
	local db = TidyPlatesThreat.db.profile.settings
	-- Target Art
	if not plate.widgets.TargetArt then OnInitialize(plate) end
	if db.showTarget then
		plate.widgets.TargetArt:Update(unit)
		plate.widgets.TargetArt:SetPoint("CENTER", plate, 0, 0)
	end	
	-- Elite Texture
	if not plate.widgets.EliteArt then OnInitialize(plate) end
	if db.options.showEliteIcon then
		plate.widgets.EliteArt:Update(unit)
		plate.widgets.EliteArt:SetPoint("CENTER",plate,(db.eliteIcon.anchor), (db.eliteIcon.x), (db.eliteIcon.y))
	end
	-- Name Text
	local c = db.name.color
	if db.options.showName then
		if not plate.widgets.NameText then OnInitialize(plate) end
		plate.widgets.NameText:SetText(unit.name)
		plate.widgets.NameText:SetFont((Media:Fetch('font', db.name.typeface)), db.name.size, db.name.flags)
		plate.widgets.NameText:SetPoint("CENTER", plate, "CENTER", db.name.x, db.name.y)
		plate.widgets.NameText:SetJustifyH(db.name.align)
		plate.widgets.NameText:SetJustifyV(db.name.vertical)
		plate.widgets.NameText:SetWidth(db.name.width)
		plate.widgets.NameText:SetHeight(db.name.height)
		plate.widgets.NameText:SetTextColor(c.r, c.g, c.b)
		plate.widgets.NameText:SetShadowOffset(1, -1)
		if db.name.shadow then 
			plate.widgets.NameText:SetShadowColor(0,0,0,1)
		else 
			plate.widgets.NameText:SetShadowColor(0,0,0,0) 
		end	
	else
	end
	-- Totem Icons
	--if not plate.widgets.TotemIconWidget then OnInitialize(plate) end
	--plate.widgets.TotemIconWidget:Update(unit)
	-- Threat Update
	if TidyPlatesThreat.db.profile.threatWidget.ON and unit.class == "UNKNOWN" then
		if not plate.widgets.ThreatWidget then OnInitialize(plate) end
		plate.widgets.ThreatWidget:Update(unit)
		plate.widgets.ThreatWidget:SetPoint("CENTER", plate, (TidyPlatesThreat.db.profile.threatWidget.x), TidyPlatesThreat.db.profile.threatWidget.y)
	end
	-- Combo Points
	if TidyPlatesThreat.db.profile.comboWidget.ON then
		if not plate.widgets.ComboPoints then OnInitialize(plate) end
		plate.widgets.ComboPoints:Update(unit)
		plate.widgets.ComboPoints:SetPoint("CENTER", plate, (TidyPlatesThreat.db.profile.comboWidget.x), TidyPlatesThreat.db.profile.comboWidget.y)
	end	
end

local setExtended = CreateFrame("Frame")
local themeEvent = {}

function themeEvent:ADDON_LOADED()
	if arg1 == "TidyPlates_ThreatPlates" then
		TidyPlatesThemeList["Threat Plates"].OnInitialize = OnInitialize
		TidyPlatesThemeList["Threat Plates"].OnUpdate = ThreatPlatesExtensions
	end
end

setExtended:SetScript("OnEvent", function(self, event) themeEvent[event]() end)
setExtended:RegisterEvent("ADDON_LOADED")