--[[
GridIndicatorIconBar - icon indicator for Grid
Copyright 2009-2010 Adirelle (adirelle@tagada-team.net)
All rights reserved.
]]

local _, ns = ...
local L = ns.L

local Grid = Grid
local GridFrame = Grid:GetModule('GridFrame')

local media = LibStub("LibSharedMedia-3.0", true)
local borderBackdrop = {
	edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
	insets = {left = 2, right = 2, top = 2, bottom = 2},
}

local MAX_ICON_COUNT = 9

local mod = GridFrame:NewModule("GridIndicatorIconBar", Grid.modulePrototype)
_G.GridIndicatorIconBar = mod

--------------------------------------------------------------------------------
-- Default settings
--------------------------------------------------------------------------------

mod.defaultDB = {
	scale = 1,
	opacity = 1,
	count = 4,
	rowSize = 9,
	spacing = 4,
	anchorPoint = "CENTER",
	attachPoint = "CENTER",
	xOffset = 0,
	yOffset = 0,
	flash = true,
	borders = { ['*'] = false },
}

--------------------------------------------------------------------------------
-- Shoehorn into GridFrame indicators and statusmap
--------------------------------------------------------------------------------

local GetIconIndex, GetIconIndicator
do
	local iconIndicators = {}
	local iconIndexes = {}

	function GetIconIndex(indicator)
		return iconIndexes[tostring(indicator)]
	end

	function GetIconIndicator(index)
		return iconIndicators[tonumber(index) or false]
	end

	local indicators = GridFrame.prototype.indicators
	local statusmap = GridFrame.db.profile.statusmap
	for index = 1, MAX_ICON_COUNT do
		local indicator = 'baricon'..index
		iconIndicators[index] = indicator
		iconIndexes[indicator] = index
		table.insert(indicators, { type = indicator, order = 20 + index, name = format(L["Icon #%d"], index) })
		statusmap[indicator] = statusmap[indicator] or {}
	end
end

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

local borderIconList = {}

do
	local anchorPoints = {
		TOPLEFT = L["Top Left"],
		TOP = L["Top"],
		TOPRIGHT = L["Top right"],
		RIGHT = L["Right"],
		BOTTOMRIGHT = L["Bottom right"],
		BOTTOM = L["Bottom"],
		BOTTOMLEFT = L["Bottom left"],
		LEFT = L["Left"],
		CENTER = L["Center"]
	}
	local UpdateIconBarTestMode = function(frame) return mod:UpdateIconBarTestMode(frame) end

	local options = {
		type = "group",
		name = L["Icon Bar"],
		desc = L["Options for Icon Bar indicators."],
		order = 600,
		get = function(info)
			return mod.db.profile[info[#info]]
		end,
		set = function(info, value)
			mod.db.profile[info[#info]] = value
			mod:LayoutAllIconBars()
		end,
		args = {
			testMode = {
				type = "toggle",
				name = L['Test mode'],
				desc = L['Enable test mode. In test mode, every defined icon are shown.'],
				order = 1,
				get = function() return mod.testMode end,
				set = function(info, value)
					mod.testMode = value
					GridFrame:WithAllFrames(UpdateIconBarTestMode)
				end
			},
			count = {
				type = "range",
				name = L['Number of icons'],
				desc = L['Adjust the number of icons to display.'],
				order = 5,
				min = 1,
				max = 9,
				step = 1,
				set = function(info, value)
					mod.db.profile.count = value
					mod:UpdateIconCount()
				end,
			},
			rowSize = {
				type = "range",
				name = L["Number of icons per row"],
				desc = L["Adjust the number of icons per row."],
				min = 1,
				max = MAX_ICON_COUNT;
				step = 1,
				order = 10,
			},
			scale = {
				type = "range",
				name = L["Icon scale"],
				desc = L["Adjust the scale of the icon bar."],
				order = 10,
				min = 0.50,
				max = 1.50,
				step = 0.05,
				isPercent = true,
			},
			opacity = {
				type = "range",
				name = L["Icon opacity"],
				desc = L["Adjust the opacity of the icon bar. 100% is fully opaque; 10% is almost transparent."],
				order = 15,
				min = 0.10,
				max = 1.00,
				step = 0.05,
				isPercent = true,
			},
			spacing = {
				type = "range",
				name = L["Icon spacing"],
				desc = L["Adjust the size of the space between the icons."],
				order = 20,
				min = 0,
				max = 30,
				step = 1,
			},
			anchorPoint = {
				type = "select",
				name = L["Bar anchoring point"],
				desc = L["Select which point of the bar is anchored to the unit frame."],
				order = 35,
				values = anchorPoints,
			},
			attachPoint = {
				type = "select",
				name = L["Unit frame attaching point"],
				desc = L["Select the point of the unit frame the icon bar is anchored to."],
				order = 36,
				values = anchorPoints,
			},
			xOffset = {
				type = "range",
				name = L["X-axis offset"],
				desc = L["Adjust the offset between the bar and the unit frame along the x-axis."],
				order = 40,
				min = -150,
				max = 150,
				step = 1,
			},
			yOffset = {
				type = "range",
				name = L["Y-axis offset"],
				desc = L["Adjust the offset between the bar and the unit frame along the y-axis."],
				order = 50,
				min = -150,
				max = 150,
				step = 1,
			},
			flash = {
				type = 'toggle',
				name = L['Flashing icons'],
				desc = L['Check this box to have the icon flashes when there is less than 3 seconds left.'],
				order = 55,
			},
			borders = {
				type = "multiselect",
				name = L["Icon borders"],
				desc = L["Select icons that should display their border."],
				order = 60,
				values = borderIconList,
				set = function(info, key, value)
					mod.db.profile.borders[key] = value
					mod:LayoutAllIconBars()
				end,
				get = function(info, key)
					return mod.db.profile.borders[key]
				end,
			},
		}
	}

	Grid.options.args[L["Icon Bar"]] = options
end

--------------------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------------------

function mod:OnInitialize()
	Grid.modulePrototype.OnInitialize(self)
	hooksecurefunc(GridFrame, "UpdateOptionsForIndicator", self.UpdateOptionsForIndicator)
	for name, func in pairs(self.framePrototype) do
		if GridFrame.prototype[name] then
			hooksecurefunc(GridFrame.prototype, name, func)
		else
			GridFrame.prototype[name] = func
		end
	end
	GridFrame:RegisterModule(self.moduleName, self)
end

function mod:OnEnable()
	Grid.modulePrototype.OnEnable(self)
	self:UpdateIconCount()
end

--------------------------------------------------------------------------------
-- Proper methods
--------------------------------------------------------------------------------

function mod:UpdateIconCount()
	wipe(borderIconList)
	for index = 1, self.db.profile.count do
		borderIconList[index] = format(L['Icon #%d'], index)
	end
	self:LayoutAllIconBars()
end

do
	local function QueueForLayout(frame)
		mod:QueueForLayout(frame)
	end

	function mod:LayoutAllIconBars()
		GridFrame:WithAllFrames(QueueForLayout)
	end
end
	
function mod:LayoutIconBar(frame)
	local db = self.db.profile
	local iconBar = frame.IconBar
	local iconSize = GridFrame.db.profile.iconSize
	local spacing = db.spacing / db.scale
	local columnCount = math.min(db.count, db.rowSize)
	local rowCount = math.ceil(db.count / columnCount)
	iconBar:SetScale(db.scale)
	iconBar:SetAlpha(db.opacity)
	iconBar:SetWidth(columnCount * iconSize + (columnCount - 1) * spacing)
	iconBar:SetHeight(rowCount * iconSize + (rowCount - 1) * spacing)
	iconBar:ClearAllPoints()
	iconBar:SetPoint(db.anchorPoint, frame, db.attachPoint, db.xOffset, db.yOffset)
end

function mod:CreateIconBar(frame)
	self:Debug('Creating icon bar for', frame:GetName())
	local iconBar = CreateFrame("Frame", nil, frame)
	frame.IconBar = iconBar
	self:LayoutIconBar(frame)
	return iconBar
end

function mod:LayoutIcon(frame, icon)
	local db = self.db.profile
	local index = icon.index
	local iconSize = GridFrame.db.profile.iconSize
	local spacing = db.spacing / db.scale
	local column = (index - 1) % db.rowSize
	local row = math.floor((index - 1) / db.rowSize)
	icon:SetWidth(iconSize)
	icon:SetHeight(iconSize)
	icon:ClearAllPoints()
	icon:SetPoint("TOPLEFT", frame.IconBar, "TOPLEFT", (iconSize + spacing) * column, - (iconSize + spacing) * row)
	local backdrop = icon.border:GetBackdrop()
	local borderSize = GridFrame.db.profile.iconBorderSize
	backdrop.edgeSize = borderSize
	backdrop.insets.left = borderSize
	backdrop.insets.right = borderSize
	backdrop.insets.top = borderSize
	backdrop.insets.bottom = borderSize
	icon.border:SetWidth(iconSize)
	icon.border:SetHeight(iconSize)
	local r, g, b, a = icon.border:GetBackdropBorderColor()
	icon.border:SetBackdrop(backdrop)
	if borderSize == 0 then
	   icon.border:SetBackdropBorderColor(0, 0, 0, 0)
	else
	  icon.border:SetBackdropBorderColor(r, g, b, a)
	end
	icon.border:SetWidth(iconSize + borderSize * 2)
	icon.border:SetHeight(iconSize + borderSize * 2)
	if index > self.db.profile.count then
		icon:Hide()
	end
end

function mod:CreateIcon(frame, index)
	local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT

	if not frame.IconBar then
		frame.IconBar = self:CreateIconBar(frame)
	end

	local icon = CreateFrame("Frame", nil, frame.IconBar)
	icon:SetFrameLevel(5)
	icon:Hide()
	icon.index = index

	local texture = icon:CreateTexture(nil, "OVERLAY")
	texture:SetAllPoints(icon)
	texture:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	texture:SetTexture(1,1,1,0)
	icon.texture = texture

	local cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
	cooldown:SetAllPoints(texture)
	cooldown:SetReverse(true)
	icon.cooldown = cooldown

	-- create icon background/border
	local border = CreateFrame("Frame", nil, icon)
	border:SetPoint("CENTER", icon, "CENTER")
	border:SetBackdrop(borderBackdrop)
	border:SetBackdropBorderColor(1,1,1,1)
	border:SetBackdropColor(0, 0, 0, 0)
	border:SetFrameLevel(5)
	border:Hide()
	icon.border = border

	local stackFrame = CreateFrame("Frame", nil, icon)
	stackFrame:SetFrameLevel(cooldown:GetFrameLevel()+1)
	stackFrame:SetAllPoints(icon)
	local stackText = stackFrame:CreateFontString(nil, "OVERLAY")
	stackText:SetFont(font, GridFrame.db.profile.fontSize, "OUTLINE")
	stackText:SetShadowColor(0,0,0,0)
	stackText:SetPoint("BOTTOMRIGHT", icon, 2, 0)
	stackText:SetJustifyH("RIGHT")
	stackText:SetJustifyV("BOTTOM")
	icon.stackText = stackText

	self:LayoutIcon(frame, icon)

	return icon
end

do
	local layoutHandler
	local queue = {}

	local function LayoutHandler_OnUpdate(self)
		for frame in pairs(queue) do
			mod:LayoutIconBar(frame)
			for index, icon in mod:IterateBarIcons(frame) do
				mod:LayoutIcon(frame, icon)
			end
			if mod.testMode then
				mod:UpdateIconBarTestMode(frame)
			end
		end
		wipe(queue)
		self:Hide()
	end

	function mod:QueueForLayout(frame)
		if not frame.IconBar then return end
		if not layoutHandler then
			layoutHandler = CreateFrame("Frame")
			layoutHandler:SetScript('OnUpdate', LayoutHandler_OnUpdate)
		end
		queue[frame] = true
		layoutHandler:Show()
	end
end

do
	local function iconIterator(frame, index)
		while index < MAX_ICON_COUNT do
			index = index + 1
			local icon = frame[GetIconIndicator(index)]
			if icon then
				return index, icon
			end
		end
	end

	function mod:IterateBarIcons(frame)
		return iconIterator, frame, 0
	end
end

local testColor = { r=1, g=1, b=1, a=1 }

function mod:UpdateIconBarTestMode(frame)
	local num = self.db.profile.count
	if self.testMode then
		local now = GetTime()
		for index = 1, num do
			testColor.r = 0.5 + 0.5 * math.cos(index/num * 2 * math.pi)
			testColor.g = 0.5 + 0.5 * math.cos((index/num+0.33) * 2 * math.pi)
			testColor.b = 0.5 + 0.5 * math.cos((index/num+0.66) * 2 * math.pi)
			frame:SetIndicator(GetIconIndicator(index), testColor, tostring(index), index, num, GetMacroIconInfo(index), now, index*3 + 1, index % 4)
		end
	else
		for index = 1, num do
			frame:ClearIndicator(GetIconIndicator(index))
		end
	end
end

--------------------------------------------------------------------------------
-- Hooks
--------------------------------------------------------------------------------

function mod.UpdateOptionsForIndicator(GridFrame, indicator, name, order)
	local index = GetIconIndex(indicator)
	if not index then return end
	if index > mod.db.profile.count then
		Grid.options.args["Indicators"].args[indicator] = nil
	end
end

mod.framePrototype = {}

local function OnUpdateFlash(self)
	local timeLeft = self.expiration - GetTime()
	if timeLeft <= 0 then
		self:SetAlpha(1.0)
		self:SetScript('OnUpdate', nil)
	elseif timeLeft < 4.5 then
		local f = (timeLeft % 1.5) / 1.5
		if f > 0.5 then
			f = 1 - f
		end
		self:SetAlpha(1 - 1.6 * f)
	end
end

function mod.framePrototype.SetIndicator(frame, indicator, color, text, value, maxValue, texture, start, duration, stack)
	local index = GetIconIndex(indicator)
	if not index then return end
	local hasColor = type(color) == "table" and not color.ignore
	local icon = frame[indicator]
	if not texture and not hasColor then
		if icon then
			icon:Hide()
		end
		return
	end
	if not icon then
		icon = mod:CreateIcon(frame, index)
		frame[indicator] = icon
	end

	if texture then
		local tex, border = icon.texture, icon.border
		if type(texture) == "table" then
			tex:SetTexture(texture.r, texture.g, texture.b, texture.a)
		else
			tex:SetTexture(texture)
		end

		if hasColor then
			if GridFrame.db.profile.iconBorderSize > 0 and mod.db.profile.borders[index] then
				border:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
				border:Show()
			else
				border:Hide()
			end
			tex:SetAlpha(color.a)
		else
			border:Hide()
			tex:SetAlpha(1.0)
		end
	else
		icon.texture:SetTexture(color.r, color.g, color.b, color.a)
		icon.border:Hide()
	end

	local expiration = type(duration) == "number" and type(start) == "number" and start > 0 and duration > 0 and (start + duration) or 0
	if expiration > GetTime() and GridFrame.db.profile.enableIconCooldown then
		icon.cooldown:SetCooldown(start, duration)
		icon.cooldown:Show()
	else
		icon.cooldown:Hide()
	end

	icon:SetAlpha(1.0)
	if expiration > GetTime() and mod.db.profile.flash then
		icon.expiration = expiration
		icon:SetScript('OnUpdate', OnUpdateFlash)
	else
		icon.expiration = nil
		icon:SetScript('OnUpdate', nil)
	end

	if tonumber(stack) and tonumber(stack) > 1 and GridFrame.db.profile.enableIconStackText then
		icon.stackText:SetText(stack)
		icon.stackText:Show()
	else
		icon.stackText:Hide()
	end

	icon:Show()
end

function mod.framePrototype.ClearIndicator(frame, indicator)
	local index = GetIconIndex(indicator)
	if not index then return end
	local icon = frame[indicator]
	if not icon or mod.testMode then return end
	icon.texture:SetTexture(1,1,1,0)
	icon.cooldown:Hide()
	icon.stackText:Hide()
	icon:SetAlpha(1)
	icon:Hide()
end

function mod.framePrototype.SetIconSize(frame)
	mod:QueueForLayout(frame)
end

function mod.framePrototype.SetFrameFont(frame, font, fontSize)
	for index, icon in mod:IterateBarIcons(frame) do
		icon.stackText:SetFont(font, fontSize, "OUTLINE")
	end
end
