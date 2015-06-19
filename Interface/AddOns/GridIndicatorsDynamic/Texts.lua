local AddonName = ...
local Grid = Grid
local GridFrame = Grid:GetModule("GridFrame")
local GridIndicatorsDynamic = Grid:GetModule(AddonName)
local Media = LibStub("LibSharedMedia-3.0")

local strsub = string.utf8sub or string.sub

local function New(frame)
	local textFrame = CreateFrame("Frame", nil, frame)
	textFrame.text = textFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	textFrame.text:SetAllPoints()
	return textFrame
end

local function Reset(self)
	local profile = GridIndicatorsDynamic.db.profile[self.__id]
	if not profile then
		return
	end
	local font = Media:Fetch("font", profile.font) or STANDARD_TEXT_FONT

	local bar = self.__owner.indicators.bar

	self:SetParent(bar)
	self:SetFrameLevel(bar:GetFrameLevel() + profile.frameLevel)
	self.text:SetFont(font, profile.fontSize, profile.fontOutline)

	if profile.fontShadow then
		self.text:SetShadowOffset(1, -1)
	else
		self.text:SetShadowOffset(0, 0)
	end

	if profile.invertBarColor and profile.invertTextColor then
		self.text:SetShadowColor(1, 1, 1)
	else
		self.text:SetShadowColor(0, 0, 0)
	end
	
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", 0, 0)
	self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", 0, 0)
	self.text:ClearAllPoints()
	self.text:SetPoint(profile.anchor, profile.offsetX, profile.offsetY)
end

local function SetStatus(self, color, text, value, maxValue, texture, texCoords, stack, start, duration)
	local profile = GridIndicatorsDynamic.db.profile[self.__id]

	if not text or text == "" then
		return self.text:SetText("")
	end

	self.text:SetText(strsub(text, 1, profile.textlength))

	if color then
		if profile.invertBarColor and profile.invertTextColor then
			self.text:SetTextColor(color.r * 0.2, color.g * 0.2, color.b * 0.2, color.a or 1)
		else
			self.text:SetTextColor(color.r, color.g, color.b, color.a or 1)
		end
	end
end

local function Clear(self)
	self.text:SetText("")
end

function GridIndicatorsDynamic:Text_RegisterIndicator(id, name)
	GridFrame:RegisterIndicator(id, name,
		New,
		Reset,
		SetStatus,
		Clear
	)
end