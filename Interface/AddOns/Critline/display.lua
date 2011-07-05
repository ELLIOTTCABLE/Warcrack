local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates

local width, height = 128, 22

local trees = {
	dmg  = L["Damage"],
	heal = L["Healing"],
	pet  = L["Pet"],
}


local function onDragStart(self)
	self.owner:StartMoving()
end

local function onDragStop(self)
	local owner = self.owner
	owner:StopMovingOrSizing()
	local pos = owner.profile.pos
	pos.point, pos.x, pos.y = select(3, owner:GetPoint())
end

local function onEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	addon:ShowTooltip(self.tree)
	if not self.owner.profile.locked then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["Drag to move"], GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	end
	GameTooltip:Show()
end

local backdrop = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	insets = {left = -1, right = -1, top = -1, bottom = -1},
}

local function createDisplay(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameStrata("LOW")
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetPoint("LEFT", 4, 0)
	frame:SetPoint("RIGHT", -4, 0)
	frame:SetBackdrop(backdrop)
	frame:SetScript("OnDragStart", onDragStart)
	frame:SetScript("OnDragStop", onDragStop)
	frame:SetScript("OnEnter", onEnter)
	frame:SetScript("OnLeave", GameTooltip_Hide)
	
	frame.owner = parent
	
	local text = frame:CreateFontString(nil, nil, "GameFontHighlightSmall")
	text:SetPoint("CENTER", frame, "RIGHT", -50, 0)
	frame.text = text
	
	local icon = frame:CreateTexture(nil, "OVERLAY")
	icon:SetSize(20, 20)
	icon:SetPoint("LEFT", 2, 0)
	frame.icon = icon
	
	local label = frame:CreateFontString(nil, nil, "GameFontHighlightSmall")
	label:SetPoint("LEFT", 4, 0)
	frame.label = label
	
	return frame
end


local display = CreateFrame("Frame", nil, UIParent)
addon.display = display
display:SetMovable(true)
display:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 12,
})
display:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
display.trees = {}


Critline.SlashCmdHandlers["reset"] = function()
	display:ClearAllPoints()
	display:SetPoint("CENTER")
end


for k, treeName in pairs(trees) do
	local frame = createDisplay(display)
	frame.icon:SetTexture(addon.icons[k])
	frame.label:SetText(treeName..":")
	frame.tree = k
	display.trees[k] = frame
end

display.trees.dmg:SetPoint("TOP", 0, -4)


local config = templates:CreateConfigFrame("Display", addonName, true)

local options = {
	db = {},
	{
		text = L["Show"],
		tooltipText = L["Show summary frame."],
		setting = "show",
		func = function(self)
			display:UpdateLayout()
		end,
	},
	{
		text = L["Locked"],
		tooltipText = L["Lock summary frame."],
		setting = "locked",
		func = function(self)
			local btn = not self:GetChecked() and "LeftButton"
			for _, tree in pairs(display.trees) do
				tree:RegisterForDrag(btn)
			end
		end,
	},
	{
		text = L["Show icons"],
		tooltipText = L["Enable to show icon indicators instead of text."],
		setting = "icons",
		func = function(self)
			local checked = self:GetChecked()
			width = checked and 128 or 152
			height = checked and 22 or 16
			for _, tree in pairs(display.trees) do
				if checked then
					tree.icon:Show()
					tree.label:Hide()
				else
					tree.icon:Hide()
					tree.label:Show()
				end
				tree:SetHeight(height)
			end
			display:UpdateLayout()
		end,
	},
}

for i, v in ipairs(options) do
	local btn = templates:CreateCheckButton(config, v)
	if i == 1 then
		btn:SetPoint("TOPLEFT", config.title, "BOTTOMLEFT", -2, -16)
	else
		btn:SetPoint("TOP", options[i - 1], "BOTTOM", 0, -8)
	end
	btn.module = display
	local btns = options[btn.db]
	btns[#btns + 1] = btn
	options[i] = btn
end


local sliders = {}

sliders[1] = templates:CreateSlider(config, {
	text = L["Scale"],
	tooltipText = L["Sets the scale of the display."],
	minValue = 0.5,
	maxValue = 2,
	valueStep = 0.05,
	minText = "50%",
	maxText = "200%",
	func = function(self)
		local value = self:GetValue()
		self.value:SetFormattedText("%.0f%%", value * 100)
		local os = display:GetScale()
		display:SetScale(value)
		local point, relativeTo, relativePoint, xOffset, yOffset = display:GetPoint()
		display:SetPoint(point, relativeTo, relativePoint, (xOffset * os / value), (yOffset * os / value))
		display.profile.scale = value
	end,
})
sliders[1]:SetPoint("TOPLEFT", options[#options], "BOTTOMLEFT", 4, -24)

sliders[2] = templates:CreateSlider(config, {
	text = L["Alpha"],
	tooltipText = L["Sets the opacity of the display."],
	minValue = 0,
	maxValue = 1,
	valueStep = 0.05,
	minText = "0%",
	maxText = "100%",
	func = function(self)
		local value = self:GetValue()
		self.value:SetFormattedText("%.0f%%", value * 100)
		display:SetAlpha(value)
		display.profile.alpha = value
	end,
})
sliders[2]:SetPoint("TOP", sliders[1], "BOTTOM", 0, -32)


local function swatchFunc(self, r, g, b)
	display.trees[self.setting]:SetBackdropColor(r, g, b)
end

local colorButtons = {}

for i, v in ipairs({"dmg", "heal", "pet"}) do
	local btn = templates:CreateColorButton(config)
	if i == 1 then
		btn:SetPoint("TOPLEFT", config.title, "BOTTOM", 0, -21)
	else
		btn:SetPoint("TOP", colorButtons[i - 1], "BOTTOM", 0, -18)
	end
	btn:SetText(trees[v])
	btn.setting = v
	btn.func = swatchFunc
	btn.opacityFunc = opacityFunc
	colorButtons[i] = btn
end

local defaults = {
	profile = {
		show = true,
		locked = false,
		icons = true,
		scale = 1,
		alpha = 1,
		colors = {
			dmg  = {r = 0, g = 0, b = 0},
			heal = {r = 0, g = 0, b = 0},
			pet  = {r = 0, g = 0, b = 0},
		},
		pos = {
			point = "CENTER",
		},
	}
}

function display:AddonLoaded()
	self.db = addon.db:RegisterNamespace("display", defaults)
	addon.RegisterCallback(self, "SettingsLoaded")
	addon.RegisterCallback(self, "OnNewTopRecord", "UpdateRecords")
end

addon.RegisterCallback(display, "AddonLoaded")


function display:SettingsLoaded()
	self.profile = self.db.profile
	
	for _, btn in ipairs(options.db) do
		btn:LoadSetting()
	end
	
	local colors = self.profile.colors
	for _, btn in ipairs(colorButtons) do
		local color = colors[btn.setting]
		local r, g, b = color.r, color.g, color.b
		btn:func(r, g, b)
		btn.swatch:SetVertexColor(r, g, b)
		btn.color = color
	end
	
	-- restore stored position
	local pos = self.profile.pos
	self:ClearAllPoints()
	self:SetPoint(pos.point, pos.x, pos.y)
	
	local scale = self.profile.scale
	-- need to set scale separately first to ensure proper behaviour in scale-friendly repositioning
	self:SetScale(scale)
	sliders[1]:SetValue(scale)
	
	sliders[2]:SetValue(self.profile.alpha)
end


function display:UpdateRecords(event, tree)
	if tree then
		local normal, crit = addon:GetHighest(tree)
		self.trees[tree].text:SetFormattedText("%8s / %-8s", addon:ShortenNumber(normal), addon:ShortenNumber(crit))
	else
		for k in pairs(trees) do
			self:UpdateRecords(nil, k)
		end
	end
end


function display:UpdateTree(tree)
	if addon.percharDB.profile[tree] then
		self.trees[tree]:Show()
	else
		self.trees[tree]:Hide()
	end
	self:UpdateLayout()
end


function display:Toggle()
	local show = not self.profile.show
	self.profile.show = show
	options[1]:SetChecked(show)
	self:UpdateLayout()
end


-- rearrange display buttons when any of them is shown or hidden
function display:UpdateLayout()
	local trees = self.trees
	local dmg = trees.dmg
	local heal = trees.heal
	local pet = trees.pet
	
	if heal:IsShown() then
		if dmg:IsShown() then
			heal:SetPoint("TOP", dmg, "BOTTOM", 0, -2)
		else
			heal:SetPoint("TOP", 0, -4)
		end
	end
	if pet:IsShown() then
		if heal:IsShown() then
			pet:SetPoint("TOP", heal, "BOTTOM", 0, -2)
		elseif dmg:IsShown() then
			pet:SetPoint("TOP", dmg, "BOTTOM", 0, -2)
		else
			pet:SetPoint("TOP", 0, -4)
		end
	end
	
	local n = 0
	
	if dmg:IsShown() then
		n = n + 1
	end
	if heal:IsShown() then
		n = n + 1
	end
	if pet:IsShown() then
		n = n + 1
	end
	
	self:SetSize(width, n * (height + 2) + 6)
	
	-- hide the entire frame if it turns out none of the individual frames are shown
	if n == 0 or not self.profile.show then
		self:Hide()
	else
		self:Show()
	end
end