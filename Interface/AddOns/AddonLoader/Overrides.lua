local frame = CreateFrame("Frame", nil, UIParent)
frame.name = "Addon Loader"
frame:Hide()

frame:SetScript("OnShow", function(frame)

	local dropdown, editbox, reset

	local currentAddon
	for k, v in pairs(AddonLoader.conditiontexts) do
		currentAddon = k
	end

	local function updatereset()
		if AddonLoader.originals[currentAddon] ~= AddonLoader.conditiontexts[currentAddon] then
			reset:Show()
		else
			reset:Hide()
		end
	end

	local function focuslost()
		local text = editbox:GetText()
		if text ~= AddonLoader.originals[currentAddon] then
			AddonLoaderSV.overrides[currentAddon] = text
			AddonLoader.conditiontexts[currentAddon] = text
		else
			AddonLoaderSV.overrides[currentAddon] = nil
		end
		updatereset()
	end

	local function dropdown_onclick(self)
		focuslost() -- save values
		currentAddon = self.value
		updatereset()
		UIDropDownMenu_SetSelectedValue(dropdown, currentAddon)
		editbox:SetText(AddonLoader.conditiontexts[currentAddon])
	end

	local sorted = {}
	local function initdropdown()
		local addonCount = 0
		local info = UIDropDownMenu_CreateInfo()
		local checked
		wipe(sorted)
		for k, v in pairs(AddonLoader.conditiontexts) do
			table.insert(sorted, k)
		end
		table.sort(sorted)
		for _, addon in ipairs(sorted) do
			if addon == currentAddon then
				checked = 1
			else
				checked = nil
			end
			if AddonLoader.conditiontexts[addon] ~= AddonLoader.originals[addon] then
				info.colorCode="|cFFFFFFFF"
			else
				info.colorCode="|cFF666666"
			end
			info.text = addon
			info.func = dropdown_onclick
			info.value = addon
			info.checked = checked
			UIDropDownMenu_AddButton(info)
		end
	end

	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -15)
	title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 10, -45)
	title:SetJustifyH("LEFT")
	title:SetJustifyV("TOP")
	title:SetText("AddonLoader")

	local check = CreateFrame("CheckButton", "AddonLoaderCheckButton", frame, "UICheckButtonTemplate")
	check:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -50)
	check:SetWidth(24)
	check:SetHeight(24)
	check:SetChecked(AddonLoaderSV.silent)
	AddonLoaderCheckButtonText:SetText(AddonLoader.L.hideloading)
	AddonLoaderCheckButtonText:SetPoint("LEFT", check, "RIGHT")
	check:SetScript("OnClick", function()
		AddonLoaderSV.silent = not AddonLoaderSV.silent
		check:SetChecked(AddonLoaderSV.silent)
	end)

	local explain = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	explain:SetTextColor(1,1,1)
	explain:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -80)
	explain:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -80)
	explain:SetJustifyH("LEFT")
	explain:SetJustifyV("TOP")
	explain:SetHeight(60)
	explain:SetText(AddonLoader.L.explain)

	local dropdownlabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	dropdownlabel:SetPoint("TOPLEFT", explain, "BOTTOMLEFT", 0, -10)
	dropdownlabel:SetText("AddOn")
	dropdownlabel:SetHeight(15)
	dropdownlabel:SetWidth(50)

	dropdown = CreateFrame("Frame", "AddonLoaderDropDown", frame, "UIDropDownMenuTemplate")
	dropdown:EnableMouse(true)
	dropdown:SetPoint("TOPLEFT", dropdownlabel, "TOPRIGHT")
	UIDropDownMenu_Initialize(dropdown, initdropdown)
	UIDropDownMenu_SetSelectedValue(dropdown, currentAddon)
	UIDropDownMenu_SetWidth(dropdown, 160)
	UIDropDownMenu_JustifyText(dropdown, "LEFT")
	AddonLoaderDropDownLeft:SetHeight(50)
	AddonLoaderDropDownMiddle:SetHeight(50)
	AddonLoaderDropDownRight:SetHeight(50)
	AddonLoaderDropDownButton:SetPoint("TOPRIGHT", AddonLoaderDropDownRight, "TOPRIGHT", -16, -12)

	reset =  CreateFrame("Button","AddonLoaderResetButton",frame,"UIPanelButtonTemplate")
	reset:SetText(AddonLoader.L.reset)
	reset:SetWidth(80)
	reset:SetPoint("TOPLEFT", dropdown, "TOPRIGHT", 0, 5)
	reset:SetScript("OnClick", function()
		AddonLoaderSV.overrides[currentAddon] = nil
		AddonLoader.conditiontexts[currentAddon] = AddonLoader.originals[currentAddon]
		editbox:SetText(AddonLoader.originals[currentAddon])
		updatereset()
	end)
	updatereset()

	editbox = CreateFrame("EditBox", "AddonLoaderEditBox", frame)
	editbox:SetPoint("TOP", dropdown, "BOTTOM")
	editbox:SetPoint("LEFT", 5, 0)
	editbox:SetPoint("BOTTOMRIGHT", -5, 5)
	editbox:SetFontObject(GameFontNormal)
	editbox:SetTextColor(.8,.8,.8)
	editbox:SetTextInsets(8,8,8,8)
	editbox:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	editbox:SetBackdropColor(.1,.1,.1,.3)
	editbox:SetBackdropBorderColor(.5,.5,.5)
	editbox:SetMultiLine(true)
	editbox:SetAutoFocus(false)
	editbox:SetText(AddonLoader.conditiontexts[currentAddon] or "")
	editbox:SetScript("OnEditFocusLost", focuslost)
	editbox:SetScript("OnEscapePressed", editbox.ClearFocus)

	frame:SetScript("OnShow", nil)
end )

InterfaceOptions_AddCategory(frame)

SLASH_ADDONLOADER1 = "/addonloader"
SlashCmdList.ADDONLOADER = function() InterfaceOptionsFrame_OpenToCategory(frame) end
