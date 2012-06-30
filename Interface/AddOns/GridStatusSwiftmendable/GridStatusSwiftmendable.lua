--[[
Interface: 4.0.0
Title: GridStatusSwiftmendable
Version: 1.0.0
Author: Kurohoshi (EU-Minahonda)
	
--INFO
	First things first: this isn't my original idea, GridStatusSwiftmendable is based on an addon called GridStatusSwiftmend,
	but, since it doesn't work now and it hadn't been updated in a while, I thought I'd upload this one.
	GridStatusSwiftmendable's mechanic has been written from 0, but I've looked into other grid modules to see how to create one.
	
	GridStatusSwiftmendable is designed to be a very lightweight and efficient addon that provides a Swiftmend feature to Grid, 
	this status will be shown when the unit has a Swiftmendable HoT (including the ones you didn't cast), you have Swiftmend out
	of CD, and the unit has a health deficit that can be modified.
--]]

local GridRoster = Grid:GetModule("GridRoster")
local GridStatusSwiftmendable = Grid:GetModule("GridStatus"):NewModule("GridStatusSwiftmendable", "AceTimer-3.0")

local Regrowth = GetSpellInfo(8936);
local Rejuvenation = GetSpellInfo(774);
local Swiftmend,_,SwiftmendIcon = GetSpellInfo(18562);

GridStatusSwiftmendable.options = false
GridStatusSwiftmendable.menuName = "Swifmendable";
GridStatusSwiftmendable.defaultDB = {
	alert_swiftmendable = {
		text = "Swiftmendable",
		enable = true,
		priority = 98,
		deficit = 12000,
		range = true,
		color = { r = 0, g = 0, b = 1, a = 1 },
	},
}

function GridStatusSwiftmendable:OnInitialize()	
	self.super.OnInitialize(self)	
	local smable_options = {
		deficit = {
			type = "range",
			name = "Health deficit",
			max = 30000,
			min = 0,
			step = 100,
			get = function () return GridStatusSwiftmendable.db.profile.alert_swiftmendable.deficit end,
			set = function (_, v) GridStatusSwiftmendable.db.profile.alert_swiftmendable.deficit = v; end,
		},
		text = {
			type = "input",
			name = "Text",
			get = function () return GridStatusSwiftmendable.db.profile.alert_swiftmendable.text end,
			set = function (_, v) GridStatusSwiftmendable.db.profile.alert_swiftmendable.text = v; end,
		},
	}
	self:RegisterStatus("alert_swiftmendable", "Swiftmendable", smable_options,true)
end
function GridStatusSwiftmendable:OnEnable()	self:ScheduleRepeatingTimer("UpdateAllUnits", 0) end
function GridStatusSwiftmendable:Reset() self.super.Reset(self)	self:UpdateAllUnits() end
function GridStatusSwiftmendable:UpdateAllUnits() for guid, unitid in GridRoster:IterateRoster() do self:UpdateUnit(guid, unitid) end end

function GridStatusSwiftmendable:UpdateUnit(guid, unitid)
	local cdst,cddur = GetSpellCooldown(Swiftmend)
	local gcdst,cddur = GetSpellCooldown(Rejuvenation)
	local deficit = UnitHealthMax(unitid) - UnitHealth(unitid) 

	if (cdst and (cdst+cddur==gcdst+cddur) and (UnitBuff(unitid, Rejuvenation) or UnitBuff(unitid, Regrowth)) and (deficit >= self.db.profile.alert_swiftmendable.deficit)) and self.db.profile.alert_swiftmendable.enable then 
		local alert = self.db.profile.alert_swiftmendable
		self.core:SendStatusGained(guid, "alert_swiftmendable",alert.priority,(alert.range and 40),alert.color,alert.text,nil,nil,SwiftmendIcon)
	elseif self.core:GetCachedStatus(guid, "alert_swiftmendable") then 
		self.core:SendStatusLost(guid, "alert_swiftmendable")  
	end
end

