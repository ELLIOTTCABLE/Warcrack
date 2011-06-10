--[[
	Name: GridStatusShield
	Revision: $Revision: 82146 $
	Developed by: Julith @ Perenolde-EU (billgatesgut@web.de)
	Description: Publishes the sremaining value of the players power word shield on a unit.
]]

--{{{ Libraries
--local ShieldLeft = LibStub:GetLibrary("LibShieldLeft-1.0", true)
--if not ShieldLeft then return end
local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusShield")

--}}}

local LOCALISATIONS = {
    ["zhTW"] = "可吸收.- (%d+) .-點傷害",
    ["ruRU"] = "поглотить.- (%d+) .-урона",
}

local SHIELD_AMOUNT_PATTERN = LOCALISATIONS[GetLocale()] or L["[aA]bsorbs.- (%d+) .-damage"]

local GridRoster = Grid:GetModule("GridRoster")
local GridStatusShield = Grid:GetModule("GridStatus"):NewModule("GridStatusShield")
GridStatusShield.menuName = L["Shield left"]


--{{{ AceDB defaults

GridStatusShield.defaultDB = {
	unitShieldLeft = {
		enable = true,
		priority = 90,
		color = { r = 1, g = 0, b = 0, a = 1 },
        aegisTolerance = 0.3,
        mark1Color = { r = 1, g = 0, b = 0, a = 1 },
        mark1Threshold = 500,
        mark2Color = { r = 1, g = 1, b = 0, a = 1 },
        mark2Threshold = 1000,
        useCombatLog = false,
	},
}

--}}}

local settings

--{{{ Options
local amountOptions = {
    ["useCombatLog"] = {
        type = "toggle",
        name = L["Use combat log"],
        desc = L["Uses the combat log to detect shields. This can be faster but is also be more inaccurate."],
        get = function()
            return settings.unitShieldLeft.useCombatLog
        end,
        set = function(_, v)
            GridStatusShield:UseCombatLog(v)
        end,
        order = 142,
    },
    ["mark1color"] = {
        type = "color",
        name = L["Low shield color"],
        desc = L["Color for shield amount below the low shield threshold."],
        order = 90,
        hasAlpha = true,
        get = function ()
                  local color = settings.unitShieldLeft.mark1Color
                  return color.r, color.g, color.b, color.a
              end,
        set = function (_, r, g, b, a)
                  local color = settings.unitShieldLeft.mark1Color
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["mark2color"] = {
        type = "color",
        name = L["Medium shield color"],
        desc = L["Color for shield amount below the medium shield threshold."],
        order = 90,
        hasAlpha = true,
        get = function ()
                  local color = settings.unitShieldLeft.mark2Color
                  return color.r, color.g, color.b, color.a
              end,
        set = function (_, r, g, b, a)
                  local color = settings.unitShieldLeft.mark2Color
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["mark1threshold"] = {
		type = "range",
		name = L["Low shield threshold"],
		desc = L["The threshold below which a shield is considered low."],
        max = 3000,
        min = 50,
        step = 1,
		get = function()
			return settings.unitShieldLeft.mark1Threshold
		end,
		set = function(_, v)
			settings.unitShieldLeft.mark1Threshold = v
		end,
	},
    ["mark2threshold"] = {
		type = "range",
		name = L["Medium shield threshold"],
		desc = L["The threshold below which a shield is considered medium."],
        max = 6000,
        min = 100,
        step = 1,
		get = function()
			return settings.unitShieldLeft.mark2Threshold
		end,
		set = function(_, v)
			settings.unitShieldLeft.mark2Threshold = v
		end,
	},
}
--}}}

local activeShields

function GridStatusShield:OnInitialize()
	self.super.OnInitialize(self)    
    
	self:RegisterStatus("unitShieldLeft", L["Shield left"], amountOptions, true)
    settings = GridStatusShield.db.profile
    settings.unitShieldLeft.useCombatLog = settings.unitShieldLeft.useCombatLog or false
end

function GridStatusShield:OnStatusEnable(status)
    if status == "unitShieldLeft" then
        self:RegisterMessage("Grid_UnitJoined")
        
        if settings.unitShieldLeft.useCombatLog then
            self:CombatLogParsing(true)
        else
            self:TooltipParsing(true)
        end
    end
end

function GridStatusShield:OnStatusDisable(status)
    if status == "unitShieldLeft" then
        self:UnregisterMessage("Grid_UnitJoined")
        
        if settings.unitShieldLeft.useCombatLog then
            self:CombatLogParsing(false)    
        else            
            self:TooltipParsing(false)
        end
    end
end

function GridStatusShield:CombatLogParsing(enable)
    if enable then
        activeShields = {}
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    else
        for guid, unitid in GridRoster:IterateRoster() do
            self:Clear(guid)
        end
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        activeShields = nil
    end
end

function GridStatusShield:TooltipParsing(enable)
    if enable then
        activeShields = {}
        if (not self.Tooltip) then
            self.Tooltip = CreateFrame("GameTooltip")
            self.Tooltip:SetOwner(UIParent, "ANCHOR_NONE")
            for i = 1, 5 do
                self["TooltipTextLeft" .. i] = self.Tooltip:CreateFontString()
                self["TooltipTextRight" .. i] = self.Tooltip:CreateFontString()
                self.Tooltip:AddFontStrings(self["TooltipTextLeft" .. i], self["TooltipTextRight" .. i])
            end
        end
        
        self:RegisterEvent("UNIT_AURA")
        
        for guid, unitid in GridRoster:IterateRoster() do
            self:UNIT_AURA(_, unitid)
        end
    else
        for guid, unitid in GridRoster:IterateRoster() do
            self:Clear(guid)
        end
        
        self:UnregisterEvent("UNIT_AURA")
        activeShields = nil
    end
end

function GridStatusShield:Reset()
    self.super.Reset(self)
    
    activeShields = {}
    
    if settings.unitShieldLeft.useCombatLog then
        for guid, unitid in GridRoster:IterateRoster() do
            self:Clear(guid)
        end
    else
        for guid, unitid in GridRoster:IterateRoster() do
            self:UNIT_AURA(_, unitid)
        end
    end
end


function GridStatusShield:UseCombatLog(useCombatLog)
    settings.unitShieldLeft.useCombatLog = useCombatLog
    if not settings.unitShieldLeft.enable then
        return
    end
    
    if settings.unitShieldLeft.useCombatLog == useCombatLog then
        return
    end
    
    if useCombatLog then
        self:TooltipParsing(false)
        self:CombatLogParsing(true)        
    else
        self:CombatLogParsing(false)
        self:TooltipParsing(true)
    end
    
    
end

function GridStatusShield:Print(msg)
    --print("GridStatusShield: "..msg)
end

function GridStatusShield:Grid_UnitJoined(_, unitGUID, unitid)
    self:Clear(unitGUID)
end


function GridStatusShield:Clear(unitGUID)
    self.core:SendStatusLost(unitGUID, "unitShieldLeft")
end

function GridStatusShield:FormatShieldText(amount)
	local shieldText
	if amount > 999 then
		shieldText = string.format("%.1fk", amount/1000.0)
	else
		shieldText = string.format("%3.0f", amount)
	end
	return shieldText
end

function GridStatusShield:SendShieldStatus(unitGUID, amount)
    local color = settings.unitShieldLeft.color
    if amount < settings.unitShieldLeft.mark1Threshold then
        color = settings.unitShieldLeft.mark1Color
    elseif amount < settings.unitShieldLeft.mark2Threshold then
        color = settings.unitShieldLeft.mark2Color
    end

    self.core:SendStatusGained(unitGUID, "unitShieldLeft",
                settings.unitShieldLeft.priority,
                nil,
                color,
                self:FormatShieldText(amount))
end



---------------------------
-- Tooltip based tracking--
---------------------------

-- caches if a buff with a certain id is a shield and if yes stores the tooltip line where the absorb value
-- is found
local shieldCache = {}

function GridStatusShield:ScanBuffToolTip(unit, buffIndex, id)
    local cacheEntry = shieldCache[id]
    if cacheEntry == nil then        
        self.Tooltip:SetUnitBuff(unit, buffIndex)
        
        -- find the tooltip line and determine absorb 
        local tooltipLine = self.TooltipTextLeft2
        local tooltipText = tooltipLine:GetText()
        if tooltipText then
            local _,_,shieldSize = string.find(tooltipText, SHIELD_AMOUNT_PATTERN)
            
            if shieldSize then
                shieldCache[id] = tooltipLine --cache line
                return tonumber(shieldSize)        
            end
        end
        tooltipLine = self.TooltipTextLeft3
        tooltipText = tooltipLine:GetText()
        if tooltipText then
            local _,_,shieldSize = string.find(tooltipText, SHIELD_AMOUNT_PATTERN)
            
            if shieldSize then
                shieldCache[id] = tooltipLine
                return tonumber(shieldSize)        
            end
        end
        shieldCache[id] = false --not a shield
    elseif cacheEntry then
        self.Tooltip:SetUnitBuff(unit, buffIndex)
        local tooltipLine = cacheEntry
        
        -- Determine absorb            
        local _,_,shieldSize = string.find(tooltipLine:GetText(), SHIELD_AMOUNT_PATTERN)

        -- although we had a cache hit it might be that there exist shields which do not always absorb things
        if shieldSize then
            return tonumber(shieldSize)
        end
    end
    
    return nil
end 

function GridStatusShield:UNIT_AURA(_, unit)
    local unitGUID = UnitGUID(unit)
    if not unitGUID then
        return
    end
    
    if not GridRoster:IsGUIDInRaid(unitGUID) then
        return
    end
    
    local sum = 0
    local i = 1
    local name, rank, icon, count, buffType, duration, expirationTime, source, isStealable, _, id = UnitBuff(unit, i)
    while name do        
        local absorb = self:ScanBuffToolTip(unit, i, id)
        --print(name..": "..tostring(absorb))
        if absorb and absorb > 0 then
            sum = sum + absorb
        end
        i = i + 1
        name, rank, icon, count, buffType, duration, expirationTime, source, isStealable, _, id  = UnitBuff(unit, i)
    end
    
    if (activeShields[unitGUID] or 0) ~= sum then
        activeShields[unitGUID] = sum
        if sum > 0 then
            self:SendShieldStatus(unitGUID, sum)
        else
            self:Clear(unitGUID)
        end
    end
end



-------------------------------
-- Combat log based tracking --
-------------------------------

local function getUnitShields(guid)
    local shields = activeShields[guid]
    if not shields then
        shields = {total = 0, count = 0}
        activeShields[guid] = shields
    end
    return shields
end

function GridStatusShield:UpdateShield(shieldId, shieldName, unitGUID, unitName, amount)
    local shields = getUnitShields(unitGUID)
    
    if shields[shieldId] and shields[shieldId] > 0 then
        shields.total = shields.total + (amount - shields[shieldId])
        shields[shieldId] = amount
    else
        shields[shieldId] = amount
        shields.total = shields.total + amount
        shields.count = shields.count + 1
    end
    
    self:SendShieldStatus(unitGUID, shields.total)
end

function GridStatusShield:RemoveShield(shieldId, shieldName, unitGUID, unitName, amount)
    local shields = getUnitShields(unitGUID)
    if shields[shieldId] then
        shields.total = shields.total - shields[shieldId]
        shields[shieldId] = nil
        shields.count = shields.count - 1
        
        if shields.count > 0 then
            self:SendShieldStatus(unitGUID, shields.total)
        else
            self:Clear(unitGUID)
        end
    end
end

function GridStatusShield:AuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)  
    if amount and amount > 0 then          
        self:UpdateShield(spellId, spellName, dstGUID, fullName, amount)
    end
end

function GridStatusShield:AuraRefresh(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)    
    if amount and amount > 0 then          
        self:UpdateShield(spellId, spellName, dstGUID, fullName, amount)
    end
end

function GridStatusShield:AuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)  
    self:RemoveShield(spellId, spellName, dstGUID, fullName, amount) 
end

function GridStatusShield:AuraBroken(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)    
    self:RemoveShield(spellId, spellName, dstGUID, fullName, amount)  
end

function GridStatusShield:AuraBrokenSpell(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)    
    self:RemoveShield(spellId, spellName, dstGUID, fullName, amount) 
end

local EventParse = {}
EventParse["SPELL_AURA_APPLIED"] = GridStatusShield.AuraApplied
EventParse["SPELL_AURA_REFRESH"] = GridStatusShield.AuraRefresh
EventParse["SPELL_AURA_REMOVED"] = GridStatusShield.AuraRemoved 
EventParse["SPELL_AURA_BROKEN"] = GridStatusShield.AuraBroken
EventParse["SPELL_AURA_BROKEN_SPELL"] = GridStatusShield.AuraBrokenSpell

function GridStatusShield:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)   
    if not GridRoster:IsGUIDInRaid(dstGUID) then
        return
    end
    
	local parsefunc = EventParse[eventtype]
	
    --print("Event: "..eventtype)
	if parsefunc then  
--        print(eventtype)
		parsefunc(self, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	end
end







function GridStatusShield:ShieldLeft_UpdateShield(event, unitGUID, unitName, shieldName, shieldValue, allValue)
    self:Print("Updating "..shieldName.." on "..unitName)

    self:SendShieldStatus(unitGUID, allValue)
end

function GridStatusShield:ShieldLeft_RefreshShield(event, unitGUID, unitName, shieldName, shieldValue, allValue)
    self:Print("Refreshing "..shieldName.." on "..unitName)

    self:SendShieldStatus(unitGUID, allValue)
end

function GridStatusShield:ShieldLeft_NewShield(event, unitGUID, unitName, shieldName, shieldValue, allValue)
    self:Print("New "..shieldName.." with "..allValue.." on "..unitName)

    self:SendShieldStatus(unitGUID, allValue)
end

function GridStatusShield:ShieldLeft_RemoveShield(event, unitGUID, unitName, shieldName, shieldValue, allValue, count)
    self:Print("Remove "..shieldName.." with "..allValue.." on "..unitName)
    if count > 0 then
        self:SendShieldStatus(unitGUID, allValue)
    else
        self.core:SendStatusLost(unitGUID, "unitShieldLeft")
    end
end

