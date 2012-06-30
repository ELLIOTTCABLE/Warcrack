local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusControlPipes")

--local AceOO = AceLibrary("AceOO-2.0")

local GridRoster = Grid:GetModule("GridRoster")

local OO = AnotherStupidSmallOOLibraryEspeciallyJustAndOnlyForGridStatusControlPipes_GoodEhQuestionmark

local PipeGuard = OO.NewClass()


------------------------------------
--      General pipe guard        --
------------------------------------



function PipeGuard.prototype:init(pipe, id, db, options)
    self.options = options
    self.db = db
    self.pipe = pipe
end

function PipeGuard.prototype:Destroy()
end

function PipeGuard:RegisterGuardType(name, class)
    self.guardTypes = self.guardTypes or {}
    self.guardTypes[name] = class

    GridPipeClass:RegisterGuard(name, class)
end


------------------------------------
--             KeyGuard           --
------------------------------------

local KeyGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Key guard", KeyGuard)

BINDING_HEADER_PIPE_GUARDS = L["Grid status control pipes - guard keys"]
BINDING_NAME_guard_key_1 = L["Guard key "].."1"
BINDING_NAME_guard_key_2 = L["Guard key "].."2"

function KeyGuard.prototype:init(pipe, id, db, options)
    KeyGuard.super.prototype.init(self, pipe, id, db, options)
    self.db.key = self.db.key or 1
    self.db.isOpen = (self.db.isOpen) or (true and self.db.isOpen == nil)
    KeyGuard:RegisterWithKey(self, self.db.key)

    self.options.args = {
        ["key"] = {
            type = "select",
            name = L["Key"],
            desc = L["The key binding to use."],
            get = function ()
                return tostring(self.db.key)
                end,
            set = function(_, v)
                KeyGuard:UnregisterWithKey(self, self.db.key)
                self.db.key = tonumber(v)
                KeyGuard:RegisterWithKey(self, self.db.key)
            end,
            values = {["1"] = L["Guard key "].."1", ["2"] = L["Guard key "].."2"},
            order = 10,
        },
        ["key_binding"] = {
            type = "keybinding",
            name = L["Current binding"],
            desc = L["Sets the current binding for this key."],
            get = function() return GetBindingKey("guard_key_"..self.db.key) end,
            set = function(_, v)
                    local oldKey = GetBindingKey("guard_key_"..self.db.key)
                    local suc = SetBinding(v, "guard_key_"..self.db.key)
                    if suc then
                        if oldKey then SetBinding(oldKey) end
                        SaveBindings(2)
                    end
                  end,
            order = 12,
        },
    }
end

function KeyGuard.prototype:OnKeyUp()
    local gone = GetTime() - (self.keyDownTime or 0)
    if gone > 0.3 then
        self.db.isOpen = not self.db.isOpen
        self.pipe:UpdateAll()
    end
end

function KeyGuard.prototype:OnKeyDown()
    self.db.isOpen = not self.db.isOpen
    self.pipe:UpdateAll()

    self.keyDownTime = GetTime()
end

function KeyGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    return self.db.isOpen
end

function KeyGuard.prototype:Destroy()
    KeyGuard:UnregisterWithKey(self, self.db.key)
end

function KeyGuard:RegisterWithKey(guard, key)
    local keyGuards = self:RegisteredGuards(key)

    tinsert(keyGuards, guard)
end

function KeyGuard:RegisteredGuards(key)
    local reg = self.registry
    if not reg then
        reg = {}
        self.registry = reg
    end

    local keyGuards = reg[key]
    if not keyGuards then
        keyGuards = {}
        reg[key] = keyGuards
    end

    return keyGuards
end

function KeyGuard:UnregisterWithKey(guard, key)
    local keyGuards = self:RegisteredGuards(key)

    for i, handle in ipairs(keyGuards) do
        if guard == handle then
            tremove(keyGuards, i)
            break
        end
    end
end

function KeyGuard:GuardKeyDown(key)
    local keyGuards = self:RegisteredGuards(key)
    for i, handle in ipairs(keyGuards) do
        handle:OnKeyDown()
    end
end

function KeyGuard:GuardKeyUp(key)
    local keyGuards = self:RegisteredGuards(key)
    for i, handle in ipairs(keyGuards) do
        handle:OnKeyUp()
    end
end

function KeyGuard:GetName()
    return "Key guard"
end






------------------------------------
--          CombatGuard           --
------------------------------------

local AceEvent = LibStub:GetLibrary("AceEvent-3.0")

local CombatGuard = OO.NewClass(PipeGuard)

PipeGuard:RegisterGuardType("Combat guard", CombatGuard)

function CombatGuard.prototype:init(pipe, id, db, options)
    CombatGuard.super.prototype.init(self, pipe, id, db, options)

    AceEvent:Embed(self)
    
    self.db.inCombat = self.db.inCombat or false
    self.combat = false
    self.options.args = {
        ["mode"] = {
            type = "toggle",
            name = L["In combat piping"],
            desc = L["If enabled, the guard is open when in combat. Otherwise the guard is open out of combat."],
            get = function() return self.db.inCombat end,
            set = function(_, v) self.db.inCombat = v; self.pipe:UpdateAll() end,
        },
    }

    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function CombatGuard.prototype:PLAYER_REGEN_DISABLED()
    self.combat = true
    self.pipe:UpdateAll()
end

function CombatGuard.prototype:PLAYER_REGEN_ENABLED()
    self.combat = false
    self.pipe:UpdateAll()
end

function CombatGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    return self.combat == self.db.inCombat
end

function CombatGuard.prototype:Destroy()
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

function PipeGuard:GetName()
    return "Combat guard"
end


------------------------------------
--         RoleGuard         --
------------------------------------

local RoleGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Role guard", RoleGuard)

function RoleGuard.prototype:init(pipe, id, db, options)
    RoleGuard.super.prototype.init(self, pipe, id, db, options)
    
    AceEvent:Embed(self)

    local roles = {"TANK", "HEALER", "DAMAGER", "NONE"}

    self.db.pipeRole = self.db.pipeRole or {}

    for i, role in ipairs(roles) do
        self.options.args[role] = {
            type = "toggle",
            name = L[role],
            desc = L["Opens pipe for this role."],
            get = function() return self.db.pipeRole[role] end,
            set = function(_, v) self.db.pipeRole[role] = v; self.pipe:UpdateAll() end,
        }
    end

    self:RegisterEvent("PLAYER_ROLES_ASSIGNED")    
end

function RoleGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    local id = GridRoster:GetUnitidByGUID(guid)
    if not id then return true end

    local role = UnitGroupRolesAssigned(id)
    if not role then 
        role = "NONE" 
    end

    return self.db.pipeRole[role]
end

function RoleGuard.prototype:PLAYER_ROLES_ASSIGNED()
    self.pipe:UpdateAll()
end

function RoleGuard:GetName()
    return "Role guard"
end

------------------------------------
--         PercThresholdGuard         --
------------------------------------

local PercThresholdGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Threshold guard", PercThresholdGuard)

function PercThresholdGuard.prototype:init(pipe, id, db, options)
    PercThresholdGuard.super.prototype.init(self, pipe, id, db, options)

    self.db.thresh = self.db.thresh or 80
    self.db.status = self.db.status or "value"
    self.db.mode = self.db.mode or "below"

    if self.db.status == "duration" then
        pipe:StatusResending(true)
    end
    self.options.args = {
        ["status"] = {
            type = "select",
            name = L["Status"],
            desc = L["The status which should be thresholded."],
            get = function ()
                return self.db.status
                end,
            set = function(_, v)
                self.db.status = v
                if self.db.status == "duration" then
                    pipe:StatusResending(true)
                end
                self.pipe:UpdateAll()
            end,
            values = { ["value"] = L["Value"], ["duration"] = L["Duration"]},
            order = 10,
        },
        ["mode"] = {
            type = "select",
            name = L["Open when"],
            desc = L["Choose if the guard should be open if status is below or above the threshold."],
            get = function ()
                return self.db.mode
                end,
            set = function(_, v)
                self.db.mode = v
                self.pipe:UpdateAll()
            end,
            values = { ["above"] = L["above"], ["below"] = L["below"]},
            order = 11,
        },
        ["threshold"] = {
            type = "range",
            name = L["Threshold (in %)"],
            desc = L["Sets the threshold in percent when the guard should be open."],
            max = 100,
            min = 0,
            step = 1,
            get = function ()
                      return self.db.thresh
                  end,
            set = function (_, v)
                      self.db.thresh = v
                      self.pipe:UpdateAll()
                  end,
            order = 12,
        }
    }

end

function PercThresholdGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if (self.db.mode == "below") then
        if value and maxValue and self.db.status == "value" then
            return (value / maxValue * 100 < self.db.thresh)
        elseif start and duration and self.db.status == "duration" then
            return ((start + duration - GetTime()) / duration * 100 < self.db.thresh)
        end
    else
        if value and maxValue and self.db.status == "value" then
            return (value / maxValue * 100 > self.db.thresh)
        elseif start and duration and self.db.status == "duration" then
            return ((start + duration - GetTime()) / duration * 100 > self.db.thresh)
        end
    end
    return true
end


function PercThresholdGuard:GetName()
    return "Threshold guard"
end

------------------------------------
--         AbsThresholdGuard         --
------------------------------------

local AbsThresholdGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Absolut threshold guard", AbsThresholdGuard)

function AbsThresholdGuard.prototype:init(pipe, id, db, options)
    AbsThresholdGuard.super.prototype.init(self, pipe, id, db, options)

    self.db.thresh = tonumber(self.db.thresh) or 80
    self.db.status = self.db.status or "value"
    self.db.mode = self.db.mode or "below"
    if self.db.status == "duration" then
        pipe:StatusResending(true)
    end
    self.options.args = {
        ["status"] = {
            type = "select",
            name = L["Status"],
            desc = L["The status which should be thresholded."],
            get = function ()
                return self.db.status
                end,
            set = function(_, v)
                self.db.status = v
                if self.db.status == "duration" then
                    pipe:StatusResending(true)
                end
                self.pipe:UpdateAll()
            end,
            values = { ["value"] = L["Value"], ["duration"] = L["Duration"], ["stacks"] = L["Stacks"] },
            order = 10,
        },
        ["mode"] = {
            type = "select",
            name = L["Open when"],
            desc = L["Choose if the guard should be open if status is below or above the threshold."],
            get = function ()
                return self.db.mode
                end,
            set = function(_, v)
                self.db.mode = v
                self.pipe:UpdateAll()
            end,
            values = { ["above"] = L["above"], ["below"] = L["below"]},
            order = 11,
        },
        ["threshold"] = {
            type = "input",
            usage = L["<threshold (in seconds in case of duration)>"],
            name = L["Threshold"],
            desc = L["Sets the threshold when the guard should be open."],
            get = function ()
                return tostring(self.db.thresh)
                end,
            set = function(_, v)
                self.db.thresh = tonumber(v)
                self.pipe:UpdateAll()
            end,
            order = 12,
        },
    }

end

function AbsThresholdGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if (self.db.mode == "below") then
        if value and maxValue and self.db.status == "value" then
            return (value < self.db.thresh)
        elseif start and duration and self.db.status == "duration" then
            return ((start + duration - GetTime())  < self.db.thresh)
        elseif stack and self.db.status == "stacks" then
            return (stack  < self.db.thresh)
        end
    else
        if value and maxValue and self.db.status == "value" then
            return (value > self.db.thresh)
        elseif start and duration and self.db.status == "duration" then
            return (start + duration - GetTime())  > self.db.thresh
        elseif stack and self.db.status == "stacks" then
            return (stack  > self.db.thresh)
        end
    end
    return true
end


function AbsThresholdGuard:GetName()
    return "Absolut threshold guard"
end

------------------------------------
--         ClassGuard         --
------------------------------------

local ClassGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Class guard", ClassGuard)

function ClassGuard.prototype:init(pipe, id, db, options)
    ClassGuard.super.prototype.init(self, pipe, id, db, options)

    local classes = {
        [1] = "DRUID",
        [2] = "PRIEST",
        [3] = "WARRIOR",
        [4] = "ROGUE",
        [5] = "SHAMAN",
        [6] = "PALADIN",
        [7] = "MAGE",
        [8] = "WARLOCK",
        [9] = "DEATHKNIGHT",
        [10] = "HUNTER",
    }

    self.db.pipeClass = self.db.pipeClass or {}

    for i, class in ipairs(classes) do
        self.options.args[class] = {
            type = "toggle",
            name = L[class],
            desc = L["Opens pipe for this class."],
            get = function() return self.db.pipeClass[class] end,
            set = function(_, v) self.db.pipeClass[class] = v; self.pipe:UpdateAll() end,
        }
    end

end

function ClassGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    local id = GridRoster:GetUnitidByGUID(guid)
    if not id then return true end

    local _, class = UnitClass(id)
    if not class then return true end

    return self.db.pipeClass[class]
end


function ClassGuard:GetName()
    return "Class guard"
end

------------------------------------
--         PlayerGuard            --
------------------------------------

local PlayerGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Player guard", PlayerGuard)

local playerGUID = UnitGUID("player")

function PlayerGuard.prototype:init(pipe, id, db, options)
    PlayerGuard.super.prototype.init(self, pipe, id, db, options)

    self.db.PlayerOnly = self.db.PlayerOnly or true
    self.options.args = {
        ["mode"] = {
            type = "toggle",
            name = L["Player only piping"],
            desc = L["If enabled, the guard is open only for the player. Otherwise the guard is open for all units except the player."],
            get = function() return self.db.PlayerOnly end,
            set = function(_, v) self.db.PlayerOnly = v; self.pipe:UpdateAll() end,
        },
    }
end

function PlayerGuard.prototype:IsOpen(guid, ...)
    --print("is open "..tostring(guid).." vs player: "..tostring(self.PlayerGUID))
    assert(guid)
    return self.db.PlayerOnly == (playerGUID == guid)
    --[[
	if (not guid) then
		return true
	elseif (self.db.PlayerOnly) then
		return self.PlayerGUID == guid
	else
		return self.PlayerGUID ~= guid
	end]]
end


function PlayerGuard:GetName()
    return "Player guard"
end

------------------------------------
--           Aura Guard           --
------------------------------------

local AuraGuard = OO.NewClass(PipeGuard)
PipeGuard:RegisterGuardType("Aura guard", AuraGuard)

function AuraGuard.prototype:init(pipe, id, db, options)
    AuraGuard.super.prototype.init(self, pipe, id, db, options)

    self.db.auras = self.db.auras or {}

    self.options.args = {
        ["addaura"] = {
            type = "input",
            name = L["Add new aura"],
            desc = L["Adds a new aura to be filtered."],
            get = false,
            usage = L["<aura name>"],
            set = function(_, v) self:AddAura(v) end,
            order = 11
        }
    }

    for aura, _ in pairs(self.db.auras) do
        self:CreateOptions(aura)
    end
end

function AuraGuard.prototype:CreateOptions(aura)
    self.options.args[aura] = {
        type = "group",
        name = aura,
        desc = L["Options for aura: "]..aura,
        args = {
            ["remove"] = {
                type = "execute",
                name = L["Remove"],
                desc = L["Removes this aura."],
                func = function() return self:DeleteAura(aura) end,
                order = 11
            },
            ["enable"] = {
                type = "toggle",
                name = L["Enable"],
                desc = L["Toggle if this aura should be filtered."],
                order = 12,
                get = function ()
                          return self.db.auras[aura]
                      end,
                set = function (_, v)
                          self.db.auras[aura] = v
                          self.pipe:UpdateAll()
                      end,
            }
        },
    }
end

function AuraGuard.prototype:DeleteAura(aura)
    self.db.auras[aura] = nil
    self.options.args[aura] = nil
    self.pipe:UpdateAll()
end

function AuraGuard.prototype:AddAura(aura)
    if self.db.auras[aura] then return end
    self.db.auras[aura] = true

    self:CreateOptions(aura)
    self.pipe:UpdateAll()
end

function AuraGuard.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if not text or not texture then return true end

    local unit = GridRoster:GetUnitidByGUID(guid)
    for aura, v in pairs(self.db.auras) do
        if v then
            local name, _, icon = UnitBuff(unit, aura)
            if name and icon == texture then
                return false
            end
            name, _, icon = UnitDebuff(unit, aura)
            if name and icon == texture then
                return false
            end
        end
    end
    return true
end


function AuraGuard:GetName()
    return "Aura guard"
end

PipeGuardClass = PipeGuard
KeyGuardClass = KeyGuard
CombatGuardClass = CombatGuard