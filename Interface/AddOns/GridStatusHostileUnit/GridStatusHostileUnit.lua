--[[
	Name: GridStatusHostileUnit
	Revision: $Revision: 82146 $
	Developed by: Julith @ Perenolde-EU (billgatesgut@web.de)
	Description: Publishes the state if a Unit is hostile to the player.

	Credits to oodyboo from WoWAce for the idea of this addon.
]]

local LOCALISATIONS = {
    ["enUS"] = {
        ["HostileUnit"] = "HostileUnit",
        ["hostile unit"] = "hostile unit",
    },
    ["frFR"] = {
        ["HostileUnit"] = "Unit\195\169 hostile",
        ["hostile unit"] = "Unit\195\169 hostile",

    },
    ["koKR"] = {
        ["HostileUnit"] = "적대적 유닛",
        ["hostile unit"] = "적대적 유닛",
    },
    ["ruRU"] = {
        ["HostileUnit"] = "Враждебный",
        ["hostile unit"] = "враждебный игрок",
    },
    ["zhTW"] = {
        ["HostileUnit"] = "敵對單位",
        ["hostile unit"] = "敵對單位",
    },
    ["zhCN"] = {
        ["HostileUnit"] = "敌对单位",
        ["hostile unit"] = "敌对单位",
    },
}

local L = LOCALISATIONS[GetLocale()] or LOCALISATIONS["enUS"]

local GridStatusHostileUnit = Grid:GetModule("GridStatus"):NewModule("GridStatusHostileUnit")
GridStatusHostileUnit.menuName = L["HostileUnit"]

--{{{ AceDB defaults

GridStatusHostileUnit.defaultDB = {
	unitIsHostile = {
		enable = true,
		priority = 90,
		color = { r = 1, g = 0, b = 0, a = 1 },
	},
	warningDisplayed = false,
}

--}}}

--{{{ Options
local amountOptions = {
}
--}}}

local playerIsHostile = false
local settings

function GridStatusHostileUnit:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("unitIsHostile", L["hostile unit"], amountOptions, true)
	settings = GridStatusHostileUnit.db.profile
end

function GridStatusHostileUnit:OnStatusEnable(status)
    if status == "unitIsHostile" then
	
        self:RegisterEvent("UNIT_AURA", "UNIT_AURA")
        self:RegisterMessage("Grid_UnitJoined")
        self:RegisterMessage("Grid_UnitChanged")
    end
end

function GridStatusHostileUnit:OnStatusDisable(status)
    if status == "unitIsHostile" then	
        self:UnregisterEvent("UNIT_AURA", "UNIT_AURA")
        self:UnregisterMessage("Grid_UnitJoined")
        self:UnregisterMessage("Grid_UnitChanged")
    end
end

function GridStatusHostileUnit:Grid_UnitJoined(_, unitGUID, unitid)
	self:Update(unitid)
end

function GridStatusHostileUnit:Grid_UnitChanged(_, unitGUID, unitid)
	self:Update(unitid)
end

function GridStatusHostileUnit:UNIT_AURA(_, unitid)
    self:Update(unitid)
end

function GridStatusHostileUnit:Update(unitid)
	if not unitid then
		return
	end

	local gridName = UnitGUID(unitid);

	--local hostile = UnitIsUnit("player", unitid.."target");
	local hostile = UnitCanAttack("player", unitid);

	if hostile then
		self.core:SendStatusGained(gridName, "unitIsHostile",
					settings.unitIsHostile.priority,
					nil,
					settings.unitIsHostile.color)
	else
		self.core:SendStatusLost(gridName, "unitIsHostile")
	end
end

