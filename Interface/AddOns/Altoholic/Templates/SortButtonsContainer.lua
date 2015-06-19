local addonName = "Altoholic"
local addon = _G[addonName]

local function _SetButton(self, id, title, width, func)
	local button = self["Sort"..id]

	if not title then		-- no title ? hide the button
		button:Hide()
		return
	end
	
	button:SetText(title)
	button:SetWidth(width)
	button.func = func
	button:Show()	
end

addon:RegisterClassExtensions("AltoSortButtonsContainer", {
	SetButton = _SetButton,
})
