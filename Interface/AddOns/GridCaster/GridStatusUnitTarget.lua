
---------------------------------------------------------------

-- UNIT TARGET   (checked)

---------------------------------------------------------------
local GridStatus = Grid:GetModule("GridStatus")
local GridRoster = Grid:GetModule("GridRoster")

local GridStatusUnitTarget = GridStatus:NewModule("GridStatusUnitTarget")
GridStatusUnitTarget.menuName = "Unit's Target"

GridStatusUnitTarget.defaultDB = {
	debug = false,
	unit_target = {
		text =  "Unit's Target",
		enable = true,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 99,
		range = false,

	},
}




local UnitTargetOptions = {
    ["color"] = {
        type = "color",
        name = "Target Color",
        desc = "Color for Unit's Target.",
        order = 87,
        hasAlpha = true,
		get = function()
			local s = GridStatusUnitTarget.db.profile.unit_target.color
			return s.r, s.g, s.b, s.a
		end,
		set = function(r,g,b,a)
			local s = GridStatusUnitTarget.db.profile.unit_target.color
			s.r, s.g, s.b, s.a = r, g, b, a
		end
    },


}

GridStatusUnitTarget.options = false


function GridStatusUnitTarget:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit(unitid)
	end
end

function GridStatusUnitTarget:UpdateUnit(event, unitid)

	--DEFAULT_CHAT_FRAME:AddMessage("update unit")

   	if not unitid then return end
  	if (not UnitIsUnit("player", unitid)) and (not UnitInParty(unitid)) and (not UnitInRaid(unitid)) then return end

	local settings = GridStatusUnitTarget.db.profile.unit_target

	if settings.enable then
	
		local guid = UnitGUID(unitid)
		local name = UnitName(unitid.."target") or ""

		GridStatusUnitTarget.core:SendStatusGained(guid, "unit_target",
											  settings.priority,
											  nil,
											  (settings.color),
											  name)
	else
		self.core:SendStatusLostAllUnits("unit_target")
	end

end


function GridStatusUnitTarget:OnInitialize()

	self.super.OnInitialize(self)
	self:RegisterStatus("unit_target", "Unit's Target", UnitTargetOptions, true)

end

function GridStatusUnitTarget:OnStatusEnable(status)
	if status == "unit_target" then
		self:RegisterEvent("UNIT_TARGET", "UpdateUnit")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
		self:UpdateAllUnits()
	end
end

function GridStatusUnitTarget:OnStatusDisable(status)
	if status == "unit_target" then
		self:UnregisterEvent("UNIT_TARGET")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self.core:SendStatusLostAllUnits("unit_target")
	end
end