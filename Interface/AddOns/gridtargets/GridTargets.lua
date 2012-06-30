--[[
	Name: GridTargets
	Revision: $Revision: 82146 $
	Developed by: Julith @ Perenolde-EU (billgatesgut@web.de)
]]

--{{{ Libraries

local L = LibStub("AceLocale-3.0"):GetLocale("GridTargets")
local GUIDColors = LibGUIDColors
if not GUIDColors then error("Could not find LibGUIDColors") end
--}}}

local GridStatus = Grid:GetModule("GridStatus")
local GridRoster = Grid:GetModule("GridRoster")

GridTargets = GridStatus:NewModule("GridTargets", "AceTimer-3.0")
GridTargets.menuName = L["GridTargets"]


--{{{ AceDB defaults

local BY_COLOR = 1
local BY_THREAT = 2
local BY_ID = 3

GridTargets.defaultDB = {
	mobHealth = {
		enable = true,
		priority = 90,
		color = { r = 0.5, g = 0.5, b = 0.5, a = 1 },
        threatColor = {
            [3] = { r = 0, g = 1, b = 0, a = 1 },
            [2] = { r = 0.5, g = 0.5, b = 0, a = 1 },
            [1] = { r = 1, g = 0, b = 0, a = 1 },
        },
        useThreatColor = true,
        colorMode = BY_THREAT,
        ignoreSelf = true,
        ignoreTanks = true,
	},
    mobTarget = {
		enable = true,
		priority = 90,
		color = { r = 1, g = 0, b = 0, a = 1 },
        useClassColor = true,
        ignoreSelf = true,
        ignoreTanks = true,
	},
    mobTargetIndik = {
		enable = true,
		priority = 90,
		color = { r = 1, g = 0.7, b = 0, a = 1 },
	},
    mobCast = {
        enable = true,
        priority = 90,
        color = { r = 1, g = 0, b = 0, a = 1 },
        onlySpecial = false,
        specialCasts = {},
    },
    updateInterval = 0.1
}

--}}}


local function getstatuscolor(status)
    if status == 0 then status = 1 end
    local color = GridTargets.db.profile.mobHealth.threatColor[status]
    return color.r, color.g, color.b, color.a
end

local function setstatuscolor(status, r, g, b, a)
    local color = GridTargets.db.profile.mobHealth.threatColor[status]
    color.r = r
    color.g = g
    color.b = b
    color.a = a or 1
end

--{{{ Options
local options = {
    ["tankingColor"] = {
        type = "color",
        name = L["Tanking"],
        desc = L["Color for Tanking."],
        order = 87,
        hasAlpha = true,
        get = function () return getstatuscolor(3) end,
        set = function (_, r, g, b, a) setstatuscolor(3, r, g, b, a) end,
    },
    ["almostLostColor"] = {
        type = "color",
        name = L["Almost lost"],
        desc = L["Color for still tanking but almost lost."],
        order = 88,
        hasAlpha = true,
        get = function () return getstatuscolor(2) end,
        set = function (_, r, g, b, a) setstatuscolor(2, r, g, b, a) end,
    },
    ["lostColor"] = {
        type = "color",
        name = L["Lost aggro"],
        desc = L["Color for not tanking."],
        order = 89,
        hasAlpha = true,
        get = function () return getstatuscolor(1) end,
        set = function (r, g, b, a) setstatuscolor(1, r, g, b, a) end,
    },
    ["useThreatColor"] = {
		type = "toggle",
		name = L["Use threat color"],
		desc = L["Color health based on your threat on the mob."],
		get = function ()
			      return GridTargets.db.profile.mobHealth.colorMode == BY_THREAT
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobHealth.colorMode = v and BY_THREAT or BY_COLOR
			      GridTargets:GMUpdate()
		      end,
	},
    ["colorById"] = {
		type = "toggle",
		name = L["Color by mob ID"],
		desc = L["Color health based on the mobs id. This tries to give every mob a distinct color."],
		get = function ()
			      return GridTargets.db.profile.mobHealth.colorMode == BY_ID
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobHealth.colorMode = v and BY_ID or BY_COLOR
			      GridTargets:GMUpdate()
		      end,
	},
    ["ignoreSelf"] = {
		type = "toggle",
		name = L["Ignore self"],
		desc = L["Does not display if you are the target"],
		get = function ()
			      return GridTargets.db.profile.mobHealth.ignoreSelf
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobHealth.ignoreSelf = v
			      GridTargets:GMUpdate()
		      end,
	},
    ["ignoreTanks"] = {
		type = "toggle",
		name = L["Ignore tanks"],
		desc = L["Does not display if a tank is the target (needs oRA)."],
		get = function ()
			      return GridTargets.db.profile.mobHealth.ignoreTanks
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobHealth.ignoreTanks = v
			      GridTargets:GMUpdate()
		      end,
	},
}

local targetOptions = {
    ["useClassColors"] = {
		type = "toggle",
		name = L["Use class color"],
		desc = L["Color target based on class."],
		get = function ()
			      return GridTargets.db.profile.mobTarget.useClassColor
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobTarget.useClassColor = v
			      GridTargets:GMUpdate()
		      end,
	},
    ["ignoreSelf"] = {
		type = "toggle",
		name = L["Ignore self"],
		desc = L["Does not display if you are the target"],
		get = function ()
			      return GridTargets.db.profile.mobTarget.ignoreSelf
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobTarget.ignoreSelf = v
			      GridTargets:GMUpdate()
		      end,
	},
    ["ignoreTanks"] = {
		type = "toggle",
		name = L["Ignore tanks"],
		desc = L["Does not display if a tank is the target (needs oRA)."],
		get = function ()
			      return GridTargets.db.profile.mobTarget.ignoreTanks
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobTarget.ignoreTanks = v
			      GridTargets:GMUpdate()
		      end,
	},
}

local castOptions = {
    onlySpecial = {
		type = "toggle",
		name = L["Show only special casts"],
		desc = L["If enabled only the special casts listed below are displayed."],
		get = function ()
			      return GridTargets.db.profile.mobCast.onlySpecial
		      end,
		set = function (_, v)
			      GridTargets.db.profile.mobCast.onlySpecial = v
		      end,
	},
    addCast = {
        type = "input",
        name = L["Add special cast"],
        desc = L["Adds the cast with the passed name to the list of special casts."],
        get = function() return "" end,
        set = function(_, v) GridTargets:NewSpecialCast(v) end,
        usage = L["<cast name>"],
        order = 182,
    },
    remove = {
        type = "group",
        name = L["Remove"],
        desc = L["Remove casts from the list of special casts."],
        args = {},
    },
    
}
--}}}

local settings

local TargetedByLib = {
    targeter = {},
    targets = {},
}

function TargetedByLib:reset()
    self.targeter = {}
    self.targets = {}
end

function TargetedByLib:removeTargeter(target, targeter)
    local targeterList = self.targeter[target]
    
    if targeterList then
        if targeterList[targeter] then
            assert(targeterList.count > 0, "Targeter count was zero when a targetter was removed...")
            targeterList[targeter] = nil
            --print("removed targeter - count before: "..targeterList.count)
            targeterList.count = targeterList.count - 1  
            
            if not GridRoster:IsGUIDInRaid(targeter) then
                assert(targeterList.oorCount > 0, "Targeter out of raid count was zero when a OOR targetter was removed...")
                targeterList.oorCount = targeterList.oorCount - 1  

                if targeterList.oorCount == 0 and GridRoster:IsGUIDInRaid(target) then
                    GridTargets.core:SendStatusLost(target, "mobTargetIndik")
                end
            end
            
            if targeterList.count == 0 and not GridRoster:IsGUIDInRaid(target) then
                self:changedTarget(target, nil)
            end
        end
    end
end

function TargetedByLib:addTargeter(target, targeter)
    local targeterList = self.targeter[target]
    
    if not targeterList then
        targeterList = {count = 0, oorCount = 0}
        self.targeter[target] = targeterList
    end
    
    if not targeterList[targeter] then
        targeterList[targeter] = true
        
        if not GridRoster:IsGUIDInRaid(targeter) and targeter ~= UnitGUID("player") then
            --print(targeter.." -> "..target)
            
            if targeterList.oorCount == 0 and GridRoster:IsGUIDInRaid(target) then        
                GridTargets.core:SendStatusGained(target, "mobTargetIndik",
                                settings.mobTargetIndik.priority,
                                nil,
                                settings.mobTargetIndik.color)
            end
            targeterList.oorCount = targeterList.oorCount + 1
        end
        
        --print("added targeter - count before: "..targeterList.count)
        targeterList.count = targeterList.count + 1            
    end
end

function TargetedByLib:changedTarget(targeter, target)
    local oldTarget = self.targets[targeter]
    
    
    if oldTarget == target then
        return
    end
    --print(targeter.." targets "..(target or "nil"))
    
    if oldTarget then
        self:removeTargeter(oldTarget, targeter)
    end
    
    if target then
        self:addTargeter(target, targeter)
    end
    
    self.targets[targeter] = target
end

function GridTargets:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("mobHealth", L["mob health"], options, true)
    self:RegisterStatus("mobTarget", L["mob target"], targetOptions, true)
    self:RegisterStatus("mobTargetIndik", L["mob target indikator"], {}, true)
    self:RegisterStatus("mobCast", L["mob cast"], castOptions, true)
    settings = GridTargets.db.profile
    
    castOptions = GridStatus.options.args["mobCast"].args
    for cast, enabled in pairs(settings.mobCast.specialCasts) do
        self:AddSpecialCast(cast)
    end

end

function GridTargets:OnEnable()
    self:RegisterEvent("UNIT_TARGET", "UNIT_TARGET")
    self:RegisterMessage("Grid_UnitJoined")
	self:RegisterMessage("Grid_UnitLeft")

    self:RegisterEvent("UNIT_SPELLCAST_START", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_STOP", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_DELAYED", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UPDATE_CAST")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UPDATE_CAST")

    self.gmTimer = self:ScheduleRepeatingTimer("GMUpdate", settings.updateInterval)
end

function GridTargets:OnStatusDisable(status)
    for guid, unitid in GridRoster:IterateRoster() do
        self.core:SendStatusLost(guid, status)
    end
    
    if status == "mobTargetIndik" then
        TargetedByLib:reset()
    end
end

function GridTargets:Grid_UnitJoined(_, unitGUID, unitid)
	self:Update(unitid)
end

function GridTargets:Grid_UnitLeft(_, unitGUID)
    TargetedByLib:changedTarget(unitGUID, nil)
end

function isEnemy(unitid)
    return UnitExists(unitid) and UnitCanAttack("player", unitid) and not UnitIsDead(unitid)
end

local TARGET = setmetatable({}, {
    __index = function(t, i)
        local target = string.format("%starget", i)
		rawset(t, i, target)
		return target
	end,
    })

function GridTargets:UpdateMobHealth(unitid, guid, target)
    if not settings.mobHealth.enable then
        return
    end
    
    if not isEnemy(target) then
        self.core:SendStatusLost(guid, "mobHealth")
        return
    end
    
    local status = UnitThreatSituation("player", target)
    
    if not status or (settings.mobHealth.ignoreSelf and status == 3) then
        self.core:SendStatusLost(guid, "mobHealth")
    else
        if settings.mobHealth.ignoreTanks and oRA and oRA.maintanktable then
            for k, name in pairs(oRA.maintanktable) do
--~                 if not UnitGUID(name) then
--~                     print("Invalid unit "..tostring(name))
--~                 end
                if name and name ~= "" and UnitGUID(name) then
                    --print("Tank name: "..name)
                    local tmp = UnitThreatSituation(name, target)
                    if tmp and tmp == 3 then
                        self.core:SendStatusLost(guid, "mobHealth")
                        return
                    end
                end
            end
        end
        
        local tmpColor = {}
        if settings.mobHealth.colorMode == BY_THREAT and status then
            tmpColor.r, tmpColor.g, tmpColor.b, tmpColor.a = getstatuscolor(status)
        elseif settings.mobHealth.colorMode == BY_ID then
            tmpColor = GUIDColors:GetUnitColor(target)
        else
            tmpColor = settings.mobHealth.color
        end
        
        local health = UnitHealth(target)
        local maxHealth = UnitHealthMax(target)
        
        self.core:SendStatusGained(guid, "mobHealth",
                        settings.mobHealth.priority,
                        nil,
                        tmpColor,
                        nil,
                        health, maxHealth)
    end
end

function GridTargets:RemoveSpecialCast(castName)
    castOptions[castName] = nil
    castOptions.remove.args[castName] = nil
    settings.mobCast.specialCasts[castName] = nil
end

function GridTargets:NewSpecialCast(castName)
    settings.mobCast.specialCasts[castName] = true
    self:AddSpecialCast(castName)
end

function GridTargets:AddSpecialCast(castName)
    castOptions[castName] = {
        type = "toggle",
        name = castName,
        desc = castName,
        get = function()
            return settings.mobCast.specialCasts[castName]
            end,
        set = function(_, v)
            settings.mobCast.specialCasts[castName] = v
        end,
        order = 250,
    }
    castOptions.remove.args[castName] = {
        type = "execute",
        name = castName,
        desc = L["Removes this cast."],
        func = function() self:RemoveSpecialCast(castName) end,
        order = 1,
    }
end

function GridTargets:UpdateMobCast(unitid, guid, target)
    if not settings.mobCast.enable then
        return 
    end
    

    if not isEnemy(target) then
        self.core:SendStatusLost(guid, "mobCast")
        return
    end
 
    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(target)

    if not spell then
        spell, rank, displayName, icon, endTime, startTime, isTradeSkill, castID, interrupt = UnitChannelInfo(target)
    end

    local isSpecial = spell and settings.mobCast.specialCasts[spell]
    
    if spell and (isSpecial or not settings.mobCast.onlySpecial) then
        local tmpColor = settings.mobCast.color
        if not isSpecial then       
            tmpColor = GUIDColors:GetUnitColor(target)
        end
        self.core:SendStatusGained(guid, "mobCast",
                        settings.mobCast.priority,
                        nil,
                        tmpColor,
                        spell,
                        abs(GetTime()*1000 - startTime), abs(endTime - startTime),
                        icon)
    else
        self.core:SendStatusLost(guid, "mobCast")
    end
end

function GridTargets:UpdateMobTarget(unitid, guid, target)
    if not settings.mobTarget.enable then
        return 
    end
    
    if not isEnemy(target) then
        self.core:SendStatusLost(guid, "mobTarget")
        return
    end
    
    local targetsTarget = TARGET[target]
    
    if not UnitExists(targetsTarget) or settings.mobTarget.ignoreSelf and UnitIsUnit("player", targetsTarget) then
        self.core:SendStatusLost(guid, "mobTarget")        
        return
    end
    
    if oRA and oRA.maintanktable and settings.mobTarget.ignoreTanks then
        for k, name in pairs(oRA.maintanktable) do
--~             if not UnitName(name) then
--~                 print("Invalid unit "..tostring(name))
--~             end
            if name and UnitIsUnit(name, targetsTarget) then
                self.core:SendStatusLost(guid, "mobTarget")        
                return
            end
        end
    end

    local name = UnitName(targetsTarget)
    local ttGuid = UnitGUID(targetsTarget)

    self.core:SendStatusGained(guid, "mobTarget",
				    settings.mobTarget.priority,
				    nil,
				    (settings.mobTarget.useClassColor and
                     self.core:UnitColor(ttGuid) or
                     settings.mobTarget.color),
                    name)
end

function GridTargets:UpdateMobTargetIndikator(unitid, guid, target)
    if not settings.mobTargetIndik.enable then
        return 
    end
    
    local tGuid = UnitGUID(target)
    
    TargetedByLib:changedTarget(guid, tGuid)
    
    if not isEnemy(target) then
        return
    end
    
    local targetsTarget = TARGET[target]
    local ttGuid = UnitGUID(targetsTarget)
    
    TargetedByLib:changedTarget(tGuid, ttGuid)
end


function GridTargets:Update(unitid)

    local guid = UnitGUID(unitid)    
    if not GridRoster:IsGUIDInRaid(guid) then return end
    
    local target = TARGET[unitid]
    
    self:UpdateMobHealth(unitid, guid, target)
    self:UpdateMobCast(unitid, guid, target)
    self:UpdateMobTarget(unitid, guid, target)
    self:UpdateMobTargetIndikator(unitid, guid, target)
end

function GridTargets:Reset()
    self.super.Reset(self)
    TargetedByLib:reset()
    self:GMUpdate()
end

function GridTargets:GMUpdate()
    for guid, unitid in GridRoster:IterateRoster() do
		self:Update(unitid)
	end
end

function GridTargets:UNIT_TARGET(_, unitid)
    self:Update(unitid)
end

local TARGETER = setmetatable({}, {
    __index = function(t, i)
        local unit = i:lower()
        local targeter
        if unit == "target" then
            targeter = "player"
        else
            targeter = select(3, unit:find("(.+)target"))
        end

        if not targeter then
            targeter = ""
        end

		rawset(t, i, targeter)
		return targeter
	end,
    })

function GridTargets:UPDATE_CAST(_, unitid)
    if not isEnemy(unitid) then return end
    
    local playerid = TARGETER[unitid]
    
    if playerid and playerid ~= "" then
        local guid = UnitGUID(playerid)    
        if not GridRoster:IsGUIDInRaid(guid) then return end
        
        self:UpdateMobHealth(playerid, guid, unitid)
        self:UpdateMobCast(playerid, guid, unitid)
    end
end
