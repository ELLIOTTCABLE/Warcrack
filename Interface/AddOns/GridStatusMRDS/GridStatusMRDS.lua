------------------------------------------------------------------------------
-- GridStatusMRDS by Slaren
------------------------------------------------------------------------------

-- localization
local L

L = LibStub("AceLocale-3.0"):NewLocale("GridStatusMRDS", "enUS", true)
L["Most Recent Damage Source"] = true
L["Timeout (seconds)"] = true
L["The status will be cleared if the unit doesn't take damage after this time. Set to zero to disable."] = true
L["Abbreviate Skills"] = true
L["Abbreviates skill names"] = true
L["Clear status at max health"] = true
L["The status will be cleared when the unit is healed to full health"] = true
L["Use damage type color"] = true
L["The color will be choosen from the damage type instead using of the color configured here"] = true

L = LibStub("AceLocale-3.0"):NewLocale("GridStatusMRDS", "esES")
if L then
L["Most Recent Damage Source"] = "Fuente de daño más reciente"
L["Timeout (seconds)"] = "Temporizador (segundos)"
L["The status will be cleared if the unit doesn't take damage after this time. Set to zero to disable."] = "El estado sera desactivado si la unidad no recibe ningún daño despues de este tiempo. Para desactivarlo ponlo a cero."
L["Abbreviate Skills"] = "Abreviar nombres de habilidades"
L["Abbreviates skill names"] = "Abrevia los nombres de las habilidades"
L["Clear status at max health"] = "Desactivar el estado al máximo de vida"
L["The status will be cleared when the unit is healed to full health"] = "El estado será desactivado cuando la unidad vuelva a estar al máximo de vida"
L["Use damage type color"] = "Usar color del tipo de daño"
L["The color will be choosen from the damage type instead using of the color configured here"] = "En vez de usarse el color configurado aquí, se elegirá segun el tipo de daño"
end

L = LibStub("AceLocale-3.0"):GetLocale("GridStatusMRDS")
local QuickHealth = LibStub("LibQuickHealth-2.0", true)

-- gridstatus
GridStatusMRDS = Grid:GetModule("GridStatus"):NewModule("GridStatusMRDS", "AceTimer-3.0")
GridStatusMRDS.menuName = L["Most Recent Damage Source"]

-- config default
GridStatusMRDS.defaultDB = {
    alert_mrds = {
        enable = true,
        color = { r = 1, g = 1, b = 1, a = 1 },
        priority = 99,
        timeout = 5,
        abbreviate = true,
        clearfull = true,
        schoolcolors = true,
        range = false,
    }
}

GridStatusMRDS.options = false

-- additional options
local mrdsOptions = {
    ["schoolcolors"] = {
        type = 'toggle',
        name = L["Use damage type color"],
        desc = L["The color will be choosen from the damage type instead using of the color configured here"],
		get = function() return GridStatusMRDS.db.profile.alert_mrds.schoolcolors end,
		set = function (_, v) GridStatusMRDS.db.profile.alert_mrds.schoolcolors = v end,
	},
	["timeout"] = {
		name = L["Timeout (seconds)"],
		desc = L["The status will be cleared if the unit doesn't take damage after this time. Set to zero to disable."],
		type = 'range',
        min = 0,
        max = 60,
        step = 1,
		get = function() return GridStatusMRDS.db.profile.alert_mrds.timeout end,
		set = function (_, v) GridStatusMRDS.core:SendStatusLostAllUnits("alert_mrds") GridStatusMRDS.db.profile.alert_mrds.timeout = v end,
	},
	["abbreviations"] = {
        type = 'toggle',
        name = L["Abbreviate Skills"],
        desc = L["Abbreviates skill names"],
		get = function() return GridStatusMRDS.db.profile.alert_mrds.abbreviate end,
		set = function (_, v) GridStatusMRDS.db.profile.alert_mrds.abbreviate = v end,
	},
	["clearfull"] = {
        type = 'toggle',
        name = L["Clear status at max health"],
        desc = L["The status will be cleared when the unit is healed to full health"],
		get = function() return GridStatusMRDS.db.profile.alert_mrds.clearfull end,
		set = function (_, v) 
                    if GridStatusMRDS.db.profile.alert_mrds.clearfull then
                        QuickHealth.UnregisterCallback(GridStatusMRDS, "UnitHealthUpdated")
                    else
                        QuickHealth.RegisterCallback(GridStatusMRDS, "UnitHealthUpdated", "UnitHealthUpdated")
                        GridStatusMRDS.core:SendStatusLostAllUnits("alert_mrds")
                    end
                    GridStatusMRDS.db.profile.alert_mrds.clearfull = v
                end
	}
}

function GridStatusMRDS:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_mrds", L["Most Recent Damage Source"], mrdsOptions, true)
end

function GridStatusMRDS:OnStatusEnable(status)
	if status == "alert_mrds" then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self.timer = self:ScheduleRepeatingTimer("UpdateUnits", 0.5)
		if(GridStatusMRDS.db.profile.alert_mrds.clearfull) then
            if QuickHealth then
				QuickHealth.RegisterCallback(self, "UnitHealthUpdated", "UnitHealthUpdated")
			else
				self:RegisterEvent("UNIT_HEALTH")
			end
        end
	end
end

function GridStatusMRDS:OnStatusDisable(status)
	if status == "alert_mrds" then
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:CancelTimer(self.timer)
		
		if QuickHealth then			
			QuickHealth.UnregisterCallback(self, "UnitHealthUpdated")
		else
			self:UnregisterEvent("UNIT_HEALTH")
		end

		self.core:SendStatusLostAllUnits("alert_mrds")
	end
end

local unittimes = {}

function GridStatusMRDS:UpdateUnits()
    local ctime = GetTime()
    for k, v in pairs(unittimes) do
        if ctime >= v then
            self.core:SendStatusLost(k, "alert_mrds")
            unittimes[k] = nil
        end
    end
end

local function AbbreviateSkillName(skillName)
  if (string.find(skillName, "[%s%-]")) then
   skillName = string.gsub(skillName, "(%a)[%l%p]*[%s%-]*", "%1")
  end

  return skillName
end

local flagRaid = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID)
local flagPlayerPets = bit.bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_TYPE_PET)

function GridStatusMRDS:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
    local settings = self.db.profile.alert_mrds
	local text
	local color
	local school
	local icon = nil
	local spellId, envtype
    
	if bit.band(destFlags, flagRaid) > 0 and bit.band(destFlags, flagPlayerPets) > 0 then
		if(event == "SWING_DAMAGE") then -- autoattack dmg
		    _, _, school = ...
		    icon = "Interface\\Icons\\Ability_Warrior_OffensiveStance"
			text = sourceName
		elseif(event == "SPELL_PERIODIC_DAMAGE" or event == "SPELL_DAMAGE" or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD") then -- all kinds of spelldamage
            spellId, text, school = ...			
			 _, _, icon = GetSpellInfo(spellId)
			if settings.abbreviate then
                text = AbbreviateSkillName(text)
            end
		elseif(event == "ENVIRONMENTAL_DAMAGE") then -- environmental damage
            envtype, _, _, school = ...
			text = _G["STRING_ENVIRONMENTAL_DAMAGE_"..envtype] or envtype
        end
    end
    if text then
        if settings.schoolcolors then
            color = COMBATLOG_DEFAULT_COLORS.schoolColoring[school] or { a = 1.0, r = 1.00, g = 1.00, b = 1.00 }
        else
            color = settings.color
        end

        if settings.timeout > 0 then
            unittimes[destGUID] = GetTime() + settings.timeout
        end
        
        self.core:SendStatusGained(destGUID, "alert_mrds",
                    settings.priority,
                    (settings.range and 40),
                    color,
                    text,
                    0,      -- value
                    nil,    -- maxValue
                    icon,   -- icon
                    0,      -- start
                    0,      -- duration
                    0)      -- stack
                    
    end
end

function GridStatusMRDS:UNIT_HEALTH(event, unitid)
	self:UnitHealthUpdated("UNIT_HEALTH", unitid, UnitHealth(unitid), UnitHealthMax(unitid))
end

function GridStatusMRDS:UnitHealthUpdated(event, unitid, health, healthmax)
    if health >= healthmax then
        self.core:SendStatusLost(UnitGUID(unitid), "alert_mrds")
    end
end
