--[[--------------------------------------------------------------------
	PhanxConfig-Slider
	Simple slider widget generator.
	Based on tekKonfig-Slider and AceGUI-3.0-Slider.
	Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber(("$Revision: 78 $"):match("%d+"))

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Slider", MINOR_VERSION)
if not lib then return end

local function OnEnter(self)
	local text = self:GetParent().desc
	if text then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(text, nil, nil, nil, nil, true)
	end
end

local function OnLeave()
	GameTooltip:Hide()
end

local function OnMouseWheel(self, delta)
	local step = self:GetValueStep() * delta
	local minValue, maxValue = self:GetMinMaxValues()
	if step > 0 then
		self:SetValue(min(self:GetValue() + step, maxValue))
	else
		self:SetValue(max(self:GetValue() + step, minValue))
	end
end

local function OnValueChanged(self)
	local parent = self:GetParent()
	local value = self:GetValue()

	if self.valueFactor then
		value = value / self.valueFactor
	end

	if parent.OnValueChanged then
		value = parent:OnValueChanged(value) or value
	end

	if parent.isPercent then
		parent.valueText:SetFormattedText("%.0f%%", value * 100)
	else
		parent.valueText:SetText(value)
	end
end

local function SetText(self, text)
	return self.valueText:SetText(text)
end

local function SetValue(self, value)
	if self.isPercent then
		self.valueText:SetFormattedText("%.0f%%", value * 100)
	else
		self.valueText:SetText(value)
	end

	if self.slider.valueFactor then
		value = value * self.slider.valueFactor
	end

	return self.slider:SetValue(value)
end

local sliderBG = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	edgeSize = 8, tile = true, tileSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}

function lib.CreateSlider(parent, name, lowvalue, highvalue, valuestep, percent, desc)
	assert( type(parent) == "table" and parent.CreateFontString, "PhanxConfig-Slider: Parent is not a valid frame!" )
	if type(name) ~= "string" then name = nil end
	if type(desc) ~= "string" then desc = nil end
	if type(lowvalue) ~= "number" then lowvalue = 0 end
	if type(highvalue) ~= "number" then highvalue = 100 end
	if type(valuestep) ~= "number" then valuestep = 1 end

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(186)
	frame:SetHeight(42)

	frame.desc = desc

	frame.bg = frame:CreateTexture(nil, "BACKGROUND")
	frame.bg:SetAllPoints(true)
	frame.bg:SetTexture(0, 0, 0, 0)

	local slider = CreateFrame("Slider", nil, frame)
	slider:SetPoint("BOTTOMLEFT", 3, 10)
	slider:SetPoint("BOTTOMRIGHT", -3, 10)
	slider:SetHeight(17)
	slider:SetHitRectInsets(0, 0, -10, -10)
	slider:SetOrientation("HORIZONTAL")
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	slider:SetBackdrop(sliderBG)

	local label = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	label:SetPoint("TOPLEFT", frame, 5, 0)
	label:SetPoint("TOPRIGHT", frame, -5, 0)
	label:SetJustifyH("LEFT")
	label:SetText(name)

	local low = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 0, 3)
	if percent then
		low:SetFormattedText("%.0f%%", lowvalue * 100)
	else
		low:SetText(lowvalue)
	end

	local high = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 0, 3)
	if percent then
		high:SetFormattedText("%.0f%%", highvalue * 100)
	else
		high:SetText(highvalue)
	end

	local value = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	value:SetPoint("TOP", slider, "BOTTOM", 0, 3)
	value:SetTextColor(1, 0.8, 0)

	local factor = 10 ^ math.max(string.len(tostring(valuestep):match("%.(%d+)") or ""),
		string.len(tostring(minvalue):match("%.(%d+)") or ""),
		string.len(tostring(maxvalue):match("%.(%d+)") or ""))
	if factor > 1 then
		slider.valueFactor = factor
		slider:SetMinMaxValues(lowvalue * factor, highvalue * factor)
		slider:SetValueStep(valuestep * factor)
	else
		slider:SetMinMaxValues(lowvalue, highvalue)
		slider:SetValueStep(valuestep)
	end

	slider:EnableMouseWheel(true)
	slider:SetScript("OnEnter", OnEnter)
	slider:SetScript("OnLeave", OnLeave)
	slider:SetScript("OnMouseWheel", OnMouseWheel)
	slider:SetScript("OnValueChanged", OnValueChanged)

	frame.slider = slider
	frame.labelText = label
	frame.lowText = low
	frame.highText = high
	frame.valueText = value

	frame.isPercent = percent

	frame.SetText = SetText
	frame.SetValue = SetValue

	return frame
end