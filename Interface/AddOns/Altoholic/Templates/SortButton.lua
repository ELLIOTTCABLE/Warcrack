local addonName = "Altoholic"
local addon = _G[addonName]

local function _DrawArrow(self, ascending)
	if ascending then
		self:SetTexCoord(0, 0.5625, 1.0, 0)		-- arrow pointing up
	else
		self:SetTexCoord(0, 0.5625, 0, 1.0)		-- arrow pointing down
	end
	self:Show()
end

addon:RegisterClassExtensions("AltoSortButton", {
	Draw = _DrawArrow,
})
