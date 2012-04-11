TidyPlatesThreat = LibStub("AceAddon-3.0"):NewAddon("TidyPlatesThreat", "AceConsole-3.0", "AceEvent-3.0")

local Media = LibStub("LibSharedMedia-3.0")
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Artwork\\"
local _, PlayerClass = UnitClass("player")
local Active = function() return GetActiveTalentGroup() end
local RAID_CLASS_COLOR = { 
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
local tankRole = "|cff00ff00tanking|r"
local dpsRole = "|cffff0000dpsing / healing|r"

--[[Auto Settings]]--
SetCVar("threatWarning", 3)
SetCVar("nameplateShowEnemies", 1)
SetCVar("ShowClassColorInNameplate", 1)

--[[Set MultiStyle]]--
if not TidyPlatesThemeList then TidyPlatesThemeList = {} end
TidyPlatesThemeList["Threat Plates"] = {}

-- Callback Functions

function TidyPlatesThreat:UpdateTheme()
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

-- Dual Spec Functions
currentSpec = {}

function currentRoleBool(number)
	currentSpec[1] = TidyPlatesThreat.db.char.spec.primary
	currentSpec[2] = TidyPlatesThreat.db.char.spec.secondary
	if currentSpec[number] then return currentSpec[number] end
end

function setSpecTank(number)
	local specIs = {}
	specIs[1] = "primary"
	specIs[2] = "secondary"
	TidyPlatesThreat.db.char.spec[specIs[number]] = true
end

function setSpecDPS(number)
	local specIs = {}
	specIs[1] = "primary"
	specIs[2] = "secondary"
	TidyPlatesThreat.db.char.spec[specIs[number]] = false
end

function dualSpec() --Staggered till after called
	currentSpec[3] = ""
	if Active() == 1 then
		currentSpec[3] = "primary"
	elseif Active() == 2 then
		currentSpec[3] = "secondary"
	else 
		currentSpec[3] = "unknown"
	end
	return currentSpec[3]
end

function roleText() --Staggered till after called
	if Active() == 1 then
		if TidyPlatesThreat.db.char.spec.primary then
			return tankRole
		else
			return dpsRole
		end
	elseif Active() == 2 then
		if TidyPlatesThreat.db.char.spec.secondary then
			return tankRole
		else
			return dpsRole
		end
	end
end

function specName()
	local Spec = TidyPlatesThreat.db.char.specName
	local t = TidyPlatesThreat.db.char.specInfo[Active()]
	local spentTotal = t[1] + t[2] + t[3]
	if t[1] > t[2] and t[1] > t[3] then
		return Spec[1]
	elseif t[2] > t[1] and t[2] > t[3] then
		return Spec[2]
	elseif t[3] > t[1] and t[3] > t[2] then
		return Spec[3]
	else
		if spentTotal < 1 then
			return "Undetermined"
		end
		return ""
	end		
end


-- Unit Classification
local function UnitType(unit)
	local unitRank
	if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
		unitRank = "Boss"
	elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
		unitRank = "Elite"
	elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE"))then
		unitRank = "Normal"
	elseif unit.reaction == "NEUTRAL" then
		unitRank = "Neutral"
	end
	return unitRank
end

--[[Options and Default Settings]]--
function TidyPlatesThreat:OnInitialize()
	local defaults 	= {
		char = {
			welcome = false,
			specInfo = {
				[1] = {
					[1] = 0,
					[2] = 0,
					[3] = 0
				},
				[2] = {
					[1] = 0,
					[2] = 0,
					[3] = 0
				},
			},
			threat = {
				tanking = true,
			},
			spec = {
				primary = true,
				secondary = false
			},
			specName = {
				[1] = nil,
				[2] = nil,
				[3] = nil
			},
		},
		profile = {
			theme = "default",
			classTheme = "default",
			eliteTheme = "default",
			OldSetting = true,
			blizzFade = {
				toggle  = true,
				amount = 0
			},
			healthColorChange = {
				toggle = false,
			},
			customColor = {
				toggle = false,
			},
			allowClass = {
				toggle = false,
			},
			aHPbarColor = {
				r = 0,
				g = 1,
				b = 0
			},
			bHPbarColor = {
				r = 1,
				g = 0,
				b = 0
			},
			fHPbarColor = {
				r = 1,
				g = 1, 
				b = 1
			},
			nHPbarColor = {
				r = 1,
				g = 1, 
				b = 1
			},
			HPbarColor = {
				r = 1,
				g = 1, 
				b = 1
			},
			text = {
				amount = true,
				deficit = false,
				full = false,
				max = false,
				percent = true,
				truncate = true		
			},
			threatWidget = {
				ON = false,
				x = 0,
				y = 26,
				style = 1
			},
			comboWidget = {
				ON = false,
				x = 0,
				y = -8
			},
			settings = {
				offsetx = 0,
				offsety = 0,
				showTarget = true,
				options = {
					showLevel = true,
					showName = true,
					showSpecialText = true,
					showSpecialText2 = true,
					showSpecialArt = true,
					showDangerSkull = true,
					showEliteIcon = true,
				},
				healthbar = {
					texture = "ThreatPlatesBar"
				},
				castbar = {
					texture = "ThreatPlatesBar"
				},
				name = {
					typeface = "Accidental Presidency",
					width = 116,
					height = 14,
					size = 14,
					x = 0,
					y = 13,
					align = "CENTER",
					vertical = "CENTER",
					shadow = true,
					flags = "NONE",
					color = {
						r = 1,
						g = 1,
						b = 1					
					},
				},
				level = {
					typeface = "Accidental Presidency",
					size = 12,
					width = 20,
					height = 14,
					x = 50,
					y = 0,
					align = "RIGHT",
					vertical = "TOP",
					shadow = true,
					flags = "NONE",
				},
				specialText = {
					typeface = "Accidental Presidency",
					size = 12,
					width = 110,
					height = 14,
					x = 0,
					y = 1,
					align = "CENTER",
					vertical = "CENTER",
					shadow = true,
					flags = "NONE",
				},
				specialText2 = {
					typeface = "Accidental Presidency",
					size = 12,
					width = 110,
					height = 14,
					x = 0,
					y = -13,
					align = "CENTER",
					vertical = "CENTER",
					shadow = true,
					flags = "NONE",
				},
				raidicon = {
					scale = 20,
					x = 0,
					y = 27,
					anchor = "CENTER"
				},
				spellicon = {
					scale = 20,
					x = 75,
					y = -7,
					anchor = "CENTER",
				},
				specialArt = {
					scale = 22,
					x = -74,
					y = -7,
					anchor = "CENTER"
				},
				dangerskull = {
					scale = 16,
					x = 55,
					y = 0,
					anchor = "CENTER"
				},
				eliteIcon = {
					scale = 15,
					x = 64,
					y = 9,
					anchor = "CENTER",
					level = 2
				},
				targetArt = {
					level = 1
				},
				normal = {
					threatcolor = {
						LOW = {
							r = 1,
							g = 1,
							b = 1,
							a = 1
						},
						MEDIUM = { 
							r = 1, 
							g = 1, 
							b = 0, 
							a = 1
						},
						HIGH = { 
							r = 1,
							g = 0, 
							b = 0, 
							a = 1
						},
					},
				},
				dps = {
					threatcolor = {
						LOW = {
							r = 0,
							g = 1,
							b = 0,
							a = 1
						},
						MEDIUM = { 
							r = 1, 
							g = 1, 
							b = 0, 
							a = 1
						},
						HIGH = { 
							r = 1,
							g = 0, 
							b = 0, 
							a = 1
						},
					},
				},
				tank = {
					threatcolor = {
						LOW = {
							r = 1,
							g = 0,
							b = 0,
							a = 1
						},
						MEDIUM = { 
							r = 1, 
							g = 1, 
							b = 0, 
							a = 1
						},
						HIGH = { 
							r = 0,
							g = 1, 
							b = 0, 
							a = 1
						},
					},
				},
			},
			threat = {
				ON = true,
				marked = false,
				nonCombat = false,
				useType = true,
				useScale = true,
				useAlpha = true,
				useHPColor = false,
				scaleType = {
					["Normal"] = -0.2,
					["Elite"] = 0,
					["Boss"] = 0.2
				},
				toggle = {
					["Boss"]	= true,
					["Elite"]	= true,
					["Normal"]	= true,
					["Neutral"]	= true
				},
				dps = {
					scale = {
						LOW 		= 0.8,
						MEDIUM		= 0.9,
						HIGH 		= 1.25
					},
					alpha = {
						LOW 		= 1,
						MEDIUM		= 1,
						HIGH 		= 1
					},
				},
				tank = {
					scale = {
						LOW 		= 1.25,
						MEDIUM		= 0.9,
						HIGH 		= 0.8
					},
					alpha = {
						LOW 		= 1,
						MEDIUM		= 0.85,
						HIGH 		= 0.75
					},
				},
				marked = {
					alpha = false,
					art = false,
					scale = false					
				},
			},
			nameplate = {
				toggle = {
					["Boss"]	= true,
					["Elite"]	= true,
					["Normal"]	= true,
					["Neutral"]	= true
				},
				scale = {
					["Boss"]	= 1.1,
					["Elite"]	= 1.04,
					["Normal"]	= 1,
					["Neutral"]	= 0.9,
					["Marked"] 	= 1
				},
				alpha = {
					["Boss"]	= 1,
					["Elite"]	= 1,
					["Normal"]	= 1,
					["Neutral"]	= 1,
					["Marked"] 	= 1
				},
			},
		}
    }
	local db = LibStub('AceDB-3.0'):New('ThreatPlates3DB', defaults, 'Default')
	self.db = db
	local RegisterCallback = db.RegisterCallback
	RegisterCallback(self, 'OnProfileChanged', 'UpdateTheme')
	RegisterCallback(self, 'OnProfileCopied', 'UpdateTheme')
	RegisterCallback(self, 'OnProfileReset', 'UpdateTheme')
	
	self:RegisterOptions()
end
--[[TPTP Tank Toggle Command]]--
function toggleDPS()
	setSpecDPS(Active())
	TidyPlatesThreat.db.char.threat.tanking = false
	TidyPlatesThreat.db.profile.threat.ON = true
	print("-->>|cffff0000DPS Plates Enabled|r<<--")
	print("|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"..dualSpec().."|r spec and are now in your |cffff0000dpsing / healing|r role.")
	TidyPlates:ForceUpdate()
end
function toggleTANK()
	setSpecTank(Active())	
	TidyPlatesThreat.db.char.threat.tanking = true
	TidyPlatesThreat.db.profile.threat.ON = true
	print("-->>|cff00ff00Tank Plates Enabled|r<<--")
	print("|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"..dualSpec().."|r spec and are now in your |cff00ff00tanking|r role.")
	TidyPlates:ForceUpdate()
end
local function TPTPDPS()
	toggleDPS()
end
SLASH_TPTPDPS1 = "/tptpdps"
SlashCmdList["TPTPDPS"] = TPTPDPS
local function TPTPTANK()
	toggleTANK()
end
SLASH_TPTPTANK1 = "/tptptank"
SlashCmdList["TPTPTANK"] = TPTPTANK
local function TPTPTOGGLE()
	TidyPlatesThreat.db.char.threat.tanking = not TidyPlatesThreat.db.char.threat.tanking
	if TidyPlatesThreat.db.char.threat.tanking then 
		toggleTANK()
	else
		toggleDPS()
	end
end
SLASH_TPTPTOGGLE1 = "/tptptoggle"
SlashCmdList["TPTPTOGGLE"] = TPTPTOGGLE
local function TPTPOVERLAP()
	SetCVar("nameplateAllowOverlap",abs(GetCVar("nameplateAllowOverlap")-1))
	if GetCVar("nameplateAllowOverlap") == "1" then
		print("-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--")
	else
		print("-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--")
	end
end
SLASH_TPTPOVERLAP1 = "/tptpol"
SlashCmdList["TPTPOVERLAP"] = TPTPOVERLAP
function SetStyleThreatPlates(unit)
	db = TidyPlatesThreat.db.profile
	local T = UnitType(unit)
	if unit.reaction == "HOSTILE" or unit.reaction == "NEUTRAL" then
		if db.nameplate.toggle[T] then
			if db.threat.toggle[T] and db.threat.ON and unit.class == "UNKNOWN" and InCombatLockdown() then
				if db.threat.nonCombat then 
					if unit.isInCombat or (unit.health < unit.healthmax) then
						if TidyPlatesThreat.db.char.threat.tanking then
							return "tank"
						else
							return "dps"
						end
					else
						return "normal"
					end
				else
					if TidyPlatesThreat.db.char.threat.tanking then
						return "tank"
					else
						return "dps"
					end
				end
			else 
				return "normal"
			end
		else
			return "empty"
		end
	elseif unit.reaction == "FRIENDLY" then
		if db.nameplate.toggle[T] then
			return "normal"
		else
			return "empty"
		end
	else 
		return "empty"
	end
end
local Truncate = function(value)
	if TidyPlatesThreat.db.profile.text.truncate then
		if value >= 1e6 then
			return format('%.1fm', value / 1e6)
		elseif value >= 1e4 then
			return format('%.1fk', value / 1e3)
		else
			return value
		end
	else 
		return value
	end
end
local function SetSpecialText(unit)
	local HpPct
	local HpAmt
	local HpMax
	if TidyPlatesThreat.db.profile.text.percent then
		if (TidyPlatesThreat.db.profile.text.amount or TidyPlatesThreat.db.profile.text.max) then
			if TidyPlatesThreat.db.profile.text.deficit and not TidyPlatesThreat.db.profile.text.max and unit.health == unit.healthmax then
				HpPct = floor(100*(unit.health / unit.healthmax)).."%"
			else
				HpPct = " - "..floor(100*(unit.health / unit.healthmax)).."%"
			end
		else
			HpPct = floor(100*(unit.health / unit.healthmax)).."%"
		end
	else
		HpPct = ""
	end
	if TidyPlatesThreat.db.profile.text.amount then
		if TidyPlatesThreat.db.profile.text.deficit then
			if (unit.health == unit.healthmax) then
				HpAmt = ""
			else
				HpAmt = "-"..Truncate(unit.healthmax - unit.health)
			end
		else
			HpAmt = Truncate(unit.health)
		end
	else HpAmt = ""
	end
	if TidyPlatesThreat.db.profile.text.max then
		if TidyPlatesThreat.db.profile.text.amount then
			if TidyPlatesThreat.db.profile.text.deficit and unit.health == unit.healthmax then
				HpMax = Truncate (unit.healthmax)
			else
				HpMax = " / "..Truncate(unit.healthmax)
			end
		else 
			HpMax = Truncate(unit.healthmax)
		end
	else 
		HpMax = ""
	end
	if TidyPlatesThreat.db.profile.settings.options.showSpecialText then
		if (unit.health / unit.healthmax) < 1 then
			return HpAmt..HpMax..HpPct
		else
			if TidyPlatesThreat.db.profile.text.full then
				return HpAmt..HpMax..HpPct
			else 
				return ""
			end
		end
	else 
		return ""
	end
end
local function SetSpecialText2(unit)
	local spellname
	if unit.isCasting then 
		spellname = UnitCastingInfo("target") or UnitChannelInfo("target")
		return spellname
	else return ""
	end
end
local function SetSpecialArt(unit)
	local db = TidyPlatesThreat.db.profile
	local threatLevel 
	local style = SetStyleThreatPlates(unit)
	if TidyPlatesThreat.db.char.threat.tanking then
		threatLevel = unit.threatSituation
	else
		if unit.threatSituation == "HIGH" then
			threatLevel = "LOW"
		elseif unit.threatSituation == "LOW" then
			threatLevel = "HIGH"
		elseif unit.threatSituation == "MEDIUM" then
			threatLevel = "MEDIUM"
		end
	end
	if ((style == "dps") or (style == "tank")) and InCombatLockdown() and unit.class == "UNKNOWN" then
		if unit.isMarked and db.threat.marked.art then
			return nil
		else
			if db.theme ~= "none" then
				return path..db.theme.."\\"..threatLevel
			else
				return nil
			end		
		end
	elseif unit.class and (unit.class ~= "UNKNOWN") then
		return path..db.classTheme.."\\"..unit.class
	else
		return nil
	end
end
-- UnitType Threat Scaling
local function TypeScale(unit)
	local db = TidyPlatesThreat.db.profile.threat
	local T = UnitType(unit)
	if db.useType then
		if T == "Neutral" then
			return db.scaleType["Normal"]
		elseif T == "Normal" or T == "Elite" or T == "Boss" then
			return db.scaleType[T]
		end
	else
		return 0
	end
end
local function SetScale(unit)
	local db = TidyPlatesThreat.db.profile
	local T = UnitType(unit)
	local style = SetStyleThreatPlates(unit)
	if style == "normal" then
		return db.nameplate.scale[T]
	elseif (style == "tank" or style == "dps") and db.threat.useScale then
		if unit.isMarked and db.threat.marked.scale then
			return db.nameplate.scale["Marked"]
		else
			return ( db.threat[style].scale[unit.threatSituation] + (TypeScale(unit)))
		end
	else 
		return (db.nameplate.scale[T] or 1)
	end
end
local function SetAlpha(unit)
	local db = TidyPlatesThreat.db.profile
	local T = UnitType(unit)
	local style = SetStyleThreatPlates(unit)
	local nonTargetAlpha
	if not unit.isTarget and db.blizzFade.toggle and UnitExists("target") then
		nonTargetAlpha = db.blizzFade.amount
	else
		nonTargetAlpha = 0
	end
	if style == "normal" then
		return (TidyPlatesThreat.db.profile.nameplate.alpha[T] + nonTargetAlpha), db.blizzFade.toggle
	elseif style == "empty" then
		return 0, db.blizzFade.toggle
	elseif ((style == "tank" or style == "dps") and db.threat.useAlpha) then
		if unit.isMarked and TidyPlatesThreat.db.profile.threat.marked.alpha then
			return (TidyPlatesThreat.db.profile.nameplate.alpha["Marked"] + nonTargetAlpha), db.blizzFade.toggle
		else
			return (TidyPlatesThreat.db.profile.threat[style].alpha[unit.threatSituation] + nonTargetAlpha), db.blizzFade.toggle
		end
	else 
		return ((TidyPlatesThreat.db.profile.nameplate.alpha[T] + nonTargetAlpha) or 1), db.blizzFade.toggle
	end
end
local function SetHealthBarColor(unit)
	local db = TidyPlatesThreat.db.profile
	local style = SetStyleThreatPlates(unit)
	if ((( style == "tank") or (style == "dps")) and db.threat.useHPColor and InCombatLockdown()) then
		local T = db.settings[style].threatcolor[unit.threatSituation]
		return T.r, T.g, T.b
	else
		if db.healthColorChange.toggle then
			local pct = unit.health / unit.healthmax
			return (1-pct),(pct), 0
		elseif db.customColor.toggle then
			if unit.reaction == "FRIENDLY" then
				local d = db.fHPbarColor
				return d.r, d.g, d.b
			elseif unit.reaction == "NEUTRAL" then
				local n = db.nHPbarColor
				return n.r, n.g, n.b
			else
				local c = db.HPbarColor
				if unit.class and (unit.class == "UNKNOWN") then
					return c.r, c.g, c.b
				elseif unit.class and (unit.class ~= "UNKNOWN") and db.allowClass.toggle then
					return c.r, c.g, c.b
				else 
					return unit.red, unit.green, unit.blue
				end
			end
		else
			return unit.red, unit.green, unit.blue
		end
	end
end
------------
-- EVENTS --
------------
function specInfo()
	for i=1, GetNumTalentGroups() do
		for z=1, GetNumTalentTabs() do
			name, iconTexture, pointsSpent, background, previewPointsSpent = GetTalentTabInfo(z, false, false, i)
			TidyPlatesThreat.db.char.specInfo[i][z] = pointsSpent
			TidyPlatesThreat.db.char.specName[z] = name
		end
	end
end
local function SetToThreatPlates()
	TidyPlatesOptions.primary = "Threat Plates"
	TidyPlatesOptions.secondary = "Threat Plates"
	ReloadUI()
end
function TidyPlatesThreat:StartUp()
	specInfo()
	local t = self.db.char.specInfo[Active()]
-- Welcome
	local Welcome = "|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"..RAID_CLASS_COLOR[PlayerClass]..specName().." "..UnitClass("player")..": "..t[1].."/"..t[2].."/"..t[3].."|r|cff89F559.|r\n"
-- Body
	local NotTank = Welcome.."|cff89f559Your dual spec's have been set to |r"..dpsRole.."|cff89f559.|r"
	local CurrentlyDPS = Welcome.."|cff89f559You are currently in your "..dpsRole.."|cff89f559 role.|r"
	local CurrentlyTank = Welcome.."|cff89f559You are currently in your "..tankRole.."|cff89f559 role.|r"
	local Undetermined = Welcome.."|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"
-- End
	local Conclusion = "|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"
-- Welcome Setup / Display
	if not self.db.char.welcome then
		self.db.char.welcome = true
		if ((TidyPlatesOptions.primary ~= "Threat Plates") and (TidyPlatesOptions.secondary ~= "Threat Plates")) then
			local spec = dualSpec()
			StaticPopupDialogs["SetToThreatPlates"] = {
				text = GetAddOnMetadata("TidyPlates_ThreatPlates", "title")..":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options.", 
				button1 = "Yes", 
				button2 = "Cancel",
				button3 = "No",
				timeout = 0,
				whileDead = 1, 
				hideOnEscape = 1, 
				OnAccept = function() SetToThreatPlates() end,
				OnAlt = function() 
					InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
				end,
				OnCancel = function() 
					return print("-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--")
				end,
			}
			StaticPopup_Show("SetToThreatPlates")
		end
		if PlayerClass == "SHAMAN" 
			or PlayerClass == "MAGE" 
			or PlayerClass == "HUNTER" 
			or PlayerClass == "ROGUE" 
			or PlayerClass == "PRIEST" 
			or PlayerClass == "WARLOCK" then
			print(NotTank)
			for i=1, GetNumTalentGroups() do
				setSpecDPS(i)
			end
		elseif PlayerClass == "WARRIOR" then
			if t[3] > t[2] and t[3] > t[1] then -- Detects protection spec
				print(CurrentlyTank)
			else
				print(CurrentlyDPS)
			end
			for i=1, GetNumTalentGroups() do
				z = self.db.char.specInfo[i] 
				if z[3] > z[2] and z[3] > z[1] then -- Detects protection spec
					setSpecTank(i)
				else
					setSpecDPS(i)
				end
			end
		elseif PlayerClass == "PALADIN" then
			if t[2] > t[1] and t[2] > t[3] then -- Detects protection spec
				print(CurrentlyTank)
			else
				print(CurrentlyDPS)
			end
			for i=1, GetNumTalentGroups() do
				z = self.db.char.specInfo[i] 
				if z[2] > z[1] and z[2] > z[3] then -- Detects protection spec
					setSpecTank(i)
				else
					setSpecDPS(i)
				end
			end
		elseif PlayerClass == "DRUID" then
			if (t[2] > t[1]) and (t[2] > t[3]) then
				print(Undetermined)
			else
				print(CurrentlyDPS)
			end
			for i=1, GetNumTalentGroups() do
				z = self.db.char.specInfo[i] 
				if z[2] > z[1] and z[2] > z[3] then -- Detects feral spec
					setSpecTank(i)
				else
					setSpecDPS(i)
				end
			end
		elseif PlayerClass == "DEATHKNIGHT"	then 
			print(Undetermined)
		else
			print(Welcome)
		end
	print(Conclusion)
	self.db.char.threat.tanking = currentRoleBool(Active()) -- Aligns tanking role with current spec on log in, post setup.
	end
end
--[[Events]]--
local setThreatPlates = CreateFrame("Frame")
local eventlist = {}
function TidyPlatesThreat:PlayerLoginSetup()
	if event == "PLAYER_ALIVE" then
		TidyPlatesThreat:StartUp()
	elseif event == "PLAYER_LOGIN" then
		self.db.char.threat.tanking = currentRoleBool(Active()) -- Aligns tanking role with current spec on log in.
		if self.db.char.welcome and ((TidyPlatesOptions.primary == "Threat Plates") or (TidyPlatesOptions.secondary == "Threat Plates")) then
			print("|cff89f559Threat Plates:|r Welcome back |cff"..RAID_CLASS_COLOR[PlayerClass]..UnitName("player").."|r!!")
		else
		end
	else		
	end
end
setThreatPlates:SetScript("OnEvent", function(self, event) TidyPlatesThreat:PlayerLoginSetup() end)
setThreatPlates:RegisterEvent("PLAYER_ALIVE")
setThreatPlates:RegisterEvent("PLAYER_LOGIN")
-- Dual Spec Talent Change
local setDualSpec = CreateFrame('Frame')
setDualSpec:RegisterEvent('PLAYER_ENTERING_WORLD')
setDualSpec:RegisterEvent('PLAYER_LEAVING_WORLD')
setDualSpec:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
    elseif event == "PLAYER_LEAVING_WORLD" then
        self:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
    elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
		local t = TidyPlatesThreat.db.char.specInfo[Active()]
		TidyPlatesThreat.db.char.threat.tanking = currentRoleBool(Active())
		if ((TidyPlatesOptions.primary == "Threat Plates") or (TidyPlatesOptions.secondary == "Threat Plates")) then
		print("|cff89F559Threat Plates|r: Player spec change detected: |cff"..RAID_CLASS_COLOR[PlayerClass]..specName()..": ("..t[1].."/"..t[2].."/"..t[3]..")|r, you are now in your |cff89F559"..dualSpec().."|r spec and are now in your "..roleText().." role.")
		end
		TidyPlates:ForceUpdate()
    end
end)
-- Set Theme
local setTheme = CreateFrame("Frame")
local themeEvent = {}
function setTheme:ADDON_LOADED()
	if arg1 == "TidyPlates_ThreatPlates" then
		local setup = {
			SetStyle = SetStyleThreatPlates,
			SetScale = SetScale,
			SetAlpha = SetAlpha,
			SetSpecialText = SetSpecialText,
			SetSpecialText2 = SetSpecialText2,
			SetSpecialArt = SetSpecialArt,
			SetHealthbarColor = SetHealthBarColor,
		}
		--print("Threat Plates Loaded")
		TidyPlatesThemeList["Threat Plates"] = setup
	end
end
-- Auto Threat Glows Enable
function SetThreatGlows()
	if TidyPlatesThreat.db.profile.threat.ON and (GetCVar("threatWarning") ~= 3) then
		SetCVar("threatWarning", 3)
	elseif not TidyPlatesThreat.db.profile.threat.ON and (GetCVar("threatWarning") ~= 0) then
		SetCVar("threatWarning", 0)
	end
end
setTheme:SetScript("OnEvent", function(self, event) setTheme[event]() end)
setTheme:RegisterEvent("ADDON_LOADED")
-- Auto Hide
local setBGDisableGlows = CreateFrame("Frame")
local combatState = {}
function combatState:PLAYER_REGEN_ENABLED()
	SetThreatGlows()
end
function combatState:PLAYER_REGEN_DISABLED()
	SetThreatGlows()
end
setBGDisableGlows:SetScript("OnEvent", function(self, event) combatState[event]() end)
setBGDisableGlows:RegisterEvent("PLAYER_REGEN_ENABLED")
setBGDisableGlows:RegisterEvent("PLAYER_REGEN_DISABLED")
-- Arena / BG Auto Disable
local setBGDisable = CreateFrame("Frame")
local events = {}
function events:PLAYER_ENTERING_WORLD()
	self = TidyPlatesThreat.db.profile
	local inInstance, iType = IsInInstance()
	if iType == "arena" or iType == "pvp" then
		self.threat.ON = false
	elseif iType == "party" or iType == "raid" or iType == "none" then
		self.threat.ON = self.OldSetting	
	end
end
setBGDisable:SetScript("OnEvent", function(self, event) events[event]() end)
setBGDisable:RegisterEvent("PLAYER_ENTERING_WORLD")

