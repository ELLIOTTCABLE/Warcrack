-- -------------------------------------------------------------------------- --
-- GridIndicatorSidePlus by kunda                                             --
-- -------------------------------------------------------------------------- --

local L = GridIndicatorSidePlus_Locales

local Grid = Grid

local GridFrame = Grid:GetModule("GridFrame")
local GridIndicatorSidePlus = GridFrame:NewModule("GridIndicatorSidePlus", "AceEvent-3.0")

local configMode = false

GridIndicatorSidePlus.defaultDB = {
	SidePlusSpace = 8,
	SidePlusSize = 5,
	SidePlusOriginalSize = true,
	SidePlusOffset = 1,
}

local options = {--GridIndicatorSidePlus.options = {
	type = "group",
	--inline = true,
	icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-TRBL",
	name = L["Side Plus"],
	desc = L["Options for Side Plus."],
	order = -0.561,--460,
	args = {
		["configuration"] = {
			type = "toggle",
			name = L["Configuration Mode"],
			desc = L["Shows all Side Plus indicators."],
			order = 10,
			get = function() return configMode end,
			set = function(_, v) 
				configMode = v
				GridFrame:WithAllFrames(function(f) GridIndicatorSidePlus:GridIndicatorSidePlusConfig(f) end)
			end
		},
		["header1"] = {
			type = "header",
			order = 15,
			width = "full",
			name = "",
		},
		["sideplusspace"] = {
			type = "range",
			name = L["Side Plus Space"],
			desc = L["Adjust the space between the Side Plus indicators."],
			order = 20,
			min = 0,
			max = 20,
			step = 1,
			get = function() return GridIndicatorSidePlus.db.profile.SidePlusSpace end,
			set = function(_, v)
				GridIndicatorSidePlus.db.profile.SidePlusSpace = v
				GridFrame:WithAllFrames(function(f) GridIndicatorSidePlus.SetCornerSize(f, v) end)
			end,
		},
		["sideplusoffset"] = {
			type = "range",
			name = L["Side Plus Offset"],
			desc = L["Adjust the offset for the Side Plus indicators."],
			order = 30,
			min = -10,
			max = 10,
			step = 1,
			get = function() return GridIndicatorSidePlus.db.profile.SidePlusOffset end,
			set = function(_, v)
				GridIndicatorSidePlus.db.profile.SidePlusOffset = v
				GridFrame:WithAllFrames(function(f) GridIndicatorSidePlus.SetCornerSize(f, v) end)
			end,
		},
		["sideplusoriginalsize"] = {
			type = "toggle",
			name = L["Same size as Grid standard"],
			desc = L["If enabled, the size of the Side Plus indicator is adjustable with the standard Grid corner option. If deactivated, you can set an individual size for the Side Plus indicators."],
			order = 40,
			width = "full",
			get = function() return GridIndicatorSidePlus.db.profile.SidePlusOriginalSize end,
			set = function(_, v)
				GridIndicatorSidePlus.db.profile.SidePlusOriginalSize = v
				GridFrame:WithAllFrames(function(f) GridIndicatorSidePlus.SetCornerSize(f, v) end)
			end,
		},
		["sideplussize"] = {
			type = "range",
			name = L["Side Plus Size"],
			desc = L["Adjust the size of the Side Plus indicators."],
			order = 50,
			disabled = function() return GridIndicatorSidePlus.db.profile.SidePlusOriginalSize end,
			min = 3,
			max = 20,
			step = 1,
			get = function() return GridIndicatorSidePlus.db.profile.SidePlusSize end,
			set = function(_, v)
				GridIndicatorSidePlus.db.profile.SidePlusSize = v
				GridFrame:WithAllFrames(function(f) GridIndicatorSidePlus.SetCornerSize(f, v) end)
			end,
		}
	}
}
Grid.options.args["GridIndicatorSidePlus"] = options

local indicators = GridFrame.prototype.indicators
table.insert(indicators, { type = "sidePlusTleft",   order = 15.1, name = L["Top Side (left)"] })
table.insert(indicators, { type = "sidePlusTcenter", order = 15.2, name = L["Top Side (center)"] })
table.insert(indicators, { type = "sidePlusTright",  order = 15.3, name = L["Top Side (right)"] })
table.insert(indicators, { type = "sidePlusBleft",   order = 16.1, name = L["Bottom Side (left)"] })
table.insert(indicators, { type = "sidePlusBcenter", order = 16.2, name = L["Bottom Side (center)"] })
table.insert(indicators, { type = "sidePlusBright",  order = 16.3, name = L["Bottom Side (right)"] })
table.insert(indicators, { type = "sidePlusLtop",    order = 17.1, name = L["Left Side (top)"] })
table.insert(indicators, { type = "sidePlusLcenter", order = 17.2, name = L["Left Side (center)"] })
table.insert(indicators, { type = "sidePlusLbottom", order = 17.3, name = L["Left Side (bottom)"] })
table.insert(indicators, { type = "sidePlusRtop",    order = 18.1, name = L["Right Side (top)"] })
table.insert(indicators, { type = "sidePlusRcenter", order = 18.2, name = L["Right Side (center)"] })
table.insert(indicators, { type = "sidePlusRbottom", order = 18.3, name = L["Right Side (bottom)"] })

local statusmap = GridFrame.db.profile.statusmap
if not statusmap["sidePlusTleft"] then
	statusmap["sidePlusTleft"] = {}
	statusmap["sidePlusTcenter"] = {}
	statusmap["sidePlusTright"] = {}
	statusmap["sidePlusBleft"] = {}
	statusmap["sidePlusBcenter"] = {}
	statusmap["sidePlusBright"] = {}
	statusmap["sidePlusLtop"] = {}
	statusmap["sidePlusLcenter"] = {}
	statusmap["sidePlusLbottom"] = {}
	statusmap["sidePlusRtop"] = {}
	statusmap["sidePlusRcenter"] = {}
	statusmap["sidePlusRbottom"] = {}
end

function GridIndicatorSidePlus:OnInitialize()
	GridFrame:RegisterModule(self.moduleName, self)
	
	-- hack for better indicator menu
	hooksecurefunc(GridFrame, "UpdateOptionsMenu", self.CleanOptionsMenu)
	self:CleanOptionsMenu()

	hooksecurefunc(GridFrame.prototype, "ClearIndicator", self.ClearIndicator)
	hooksecurefunc(GridFrame.prototype, "CreateIndicator", self.CreateIndicator)
	hooksecurefunc(GridFrame.prototype, "SetIndicator", self.SetIndicator)
	hooksecurefunc(GridFrame.prototype, "SetCornerSize", self.SetCornerSize)
end

function GridIndicatorSidePlus:OnEnable()
	self:RegisterMessage("Grid_Enabled", "DisableConfigMode")
	self:RegisterMessage("Grid_Disabled", "DisableConfigMode")
end

function GridIndicatorSidePlus:OnDisable()
	configMode = false
	self:UnregisterMessage("Grid_Enabled")
	self:UnregisterMessage("Grid_Disabled")
end

function GridIndicatorSidePlus:Reset()
end

function GridIndicatorSidePlus:DisableConfigMode()
	configMode = false
end

function GridIndicatorSidePlus:CleanOptionsMenu()
	if not Grid.options.args.Indicators.args.sidePlusTleft then return end
	if not GridIndicatorSidePlus:IsEnabled() then return end

	Grid.options.args.Indicators.args.sideplusT = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-T",
		name = L["Top Side"],
		desc = L["Options for Top Side indicators."],
		order = 16.1,
		args = {
			["sidePlusTleft"]   = Grid.options.args.Indicators.args.sidePlusTleft,
			["sidePlusTcenter"] = Grid.options.args.Indicators.args.sidePlusTcenter,
			["sidePlusTright"]  = Grid.options.args.Indicators.args.sidePlusTright
		}
	}
	Grid.options.args.Indicators.args.sideplusT.args.sidePlusTleft.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Tleft"
	Grid.options.args.Indicators.args.sideplusT.args.sidePlusTcenter.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Tcenter"
	Grid.options.args.Indicators.args.sideplusT.args.sidePlusTright.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Tright"

	Grid.options.args.Indicators.args.sidePlusTleft = nil
	Grid.options.args.Indicators.args.sidePlusTcenter = nil
	Grid.options.args.Indicators.args.sidePlusTright = nil

	Grid.options.args.Indicators.args.sideplusB = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-B",
		name = L["Bottom Side"],
		desc = L["Options for Bottom Side indicators."],
		order = 17.1,
		args = {
			["sidePlusBleft"]   = Grid.options.args.Indicators.args.sidePlusBleft,
			["sidePlusBcenter"] = Grid.options.args.Indicators.args.sidePlusBcenter,
			["sidePlusBright"]  = Grid.options.args.Indicators.args.sidePlusBright
		}
	}
	Grid.options.args.Indicators.args.sideplusB.args.sidePlusBleft.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Bleft"
	Grid.options.args.Indicators.args.sideplusB.args.sidePlusBcenter.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Bcenter"
	Grid.options.args.Indicators.args.sideplusB.args.sidePlusBright.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Bright"

	Grid.options.args.Indicators.args.sidePlusBleft = nil
	Grid.options.args.Indicators.args.sidePlusBcenter = nil
	Grid.options.args.Indicators.args.sidePlusBright = nil

	Grid.options.args.Indicators.args.sideplusL = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-L",
		name = L["Left Side"],
		desc = L["Options for Left Side indicators."],
		order = 18.1,
		args = {
			["sidePlusLtop"]    = Grid.options.args.Indicators.args.sidePlusLtop,
			["sidePlusLcenter"] = Grid.options.args.Indicators.args.sidePlusLcenter,
			["sidePlusLbottom"] = Grid.options.args.Indicators.args.sidePlusLbottom
		}
	}
	Grid.options.args.Indicators.args.sideplusL.args.sidePlusLtop.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Ltop"
	Grid.options.args.Indicators.args.sideplusL.args.sidePlusLcenter.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Lcenter"
	Grid.options.args.Indicators.args.sideplusL.args.sidePlusLbottom.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Lbottom"

	Grid.options.args.Indicators.args.sidePlusLtop = nil
	Grid.options.args.Indicators.args.sidePlusLcenter = nil
	Grid.options.args.Indicators.args.sidePlusLbottom = nil

	Grid.options.args.Indicators.args.sideplusR = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-R",
		name = L["Right Side"],
		desc = L["Options for Right Side indicators."],
		order = 19.1,
		args = {
			["sidePlusRtop"]    = Grid.options.args.Indicators.args.sidePlusRtop,
			["sidePlusRcenter"] = Grid.options.args.Indicators.args.sidePlusRcenter,
			["sidePlusRbottom"] = Grid.options.args.Indicators.args.sidePlusRbottom
		}
	}
	Grid.options.args.Indicators.args.sideplusR.args.sidePlusRtop.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Rtop"
	Grid.options.args.Indicators.args.sideplusR.args.sidePlusRcenter.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Rcenter"
	Grid.options.args.Indicators.args.sideplusR.args.sidePlusRbottom.icon = "Interface\\AddOns\\GridIndicatorSidePlus\\GridIndicatorSidePlus-icon-Rbottom"

	Grid.options.args.Indicators.args.sidePlusRtop = nil
	Grid.options.args.Indicators.args.sidePlusRcenter = nil
	Grid.options.args.Indicators.args.sidePlusRbottom = nil
end

function GridIndicatorSidePlus:GridIndicatorSidePlusConfig(frame)
	if configMode then
		self.SetIndicator(frame, "sidePlusTleft",   {r=0.89, g=0.57, b=0.27, a=1})
		self.SetIndicator(frame, "sidePlusTcenter", {r=0.31, g=0.62, b=0.86, a=1})
		self.SetIndicator(frame, "sidePlusTright",  {r=0.74, g=0.34, b=0.49, a=1})
		self.SetIndicator(frame, "sidePlusBleft",   {r=0.12, g=0.46, b=0.97, a=1})
		self.SetIndicator(frame, "sidePlusBcenter", {r=0.77, g=0.02, b=0.24, a=1})
		self.SetIndicator(frame, "sidePlusBright",  {r=0.17, g=0.65, b=0.33, a=1})
		self.SetIndicator(frame, "sidePlusLtop",    {r=0.56, g=0.74, b=0.81, a=1})
		self.SetIndicator(frame, "sidePlusLcenter", {r=0.87, g=0.71, b=0.06, a=1})
		self.SetIndicator(frame, "sidePlusLbottom", {r=0.29, g=0.83, b=0.36, a=1})
		self.SetIndicator(frame, "sidePlusRtop",    {r=0.59, g=0.31, b=0.40, a=1})
		self.SetIndicator(frame, "sidePlusRcenter", {r=0.42, g=0.77, b=0.11, a=1})
		self.SetIndicator(frame, "sidePlusRbottom", {r=0.33, g=0.65, b=0.37, a=1})
	else
		self.ClearIndicator(frame, "sidePlusTleft")
		self.ClearIndicator(frame, "sidePlusTcenter")
		self.ClearIndicator(frame, "sidePlusTright")
		self.ClearIndicator(frame, "sidePlusBleft")
		self.ClearIndicator(frame, "sidePlusBcenter")
		self.ClearIndicator(frame, "sidePlusBright")
		self.ClearIndicator(frame, "sidePlusLtop")
		self.ClearIndicator(frame, "sidePlusLcenter")
		self.ClearIndicator(frame, "sidePlusLbottom")
		self.ClearIndicator(frame, "sidePlusRtop")
		self.ClearIndicator(frame, "sidePlusRcenter")
		self.ClearIndicator(frame, "sidePlusRbottom")
		GridFrame:UpdateAllFrames()
	end
end

function GridIndicatorSidePlus.CreateIndicator(f, indicator)
	local wh = GridIndicatorSidePlus.db.profile.SidePlusSize
	local space = GridIndicatorSidePlus.db.profile.SidePlusSpace
	local offset = GridIndicatorSidePlus.db.profile.SidePlusOffset
	if GridIndicatorSidePlus.db.profile.SidePlusOriginalSize then
		wh = GridFrame.db.profile.cornerSize
	end
	if indicator == "sidePlusTleft" then
		f.sidePlusTleft:SetPoint("TOP", f, "TOP", -space, offset*-1)
		f.sidePlusTleft:SetWidth(wh)
		f.sidePlusTleft:SetHeight(wh)
	elseif indicator == "sidePlusTcenter" then
		f.sidePlusTcenter:SetPoint("TOP", f, "TOP", 0, offset*-1)
		f.sidePlusTcenter:SetWidth(wh)
		f.sidePlusTcenter:SetHeight(wh)
	elseif indicator == "sidePlusTright" then
		f.sidePlusTright:SetPoint("TOP", f, "TOP", space, offset*-1)
		f.sidePlusTright:SetWidth(wh)
		f.sidePlusTright:SetHeight(wh)
	elseif indicator == "sidePlusBleft" then
		f.sidePlusBleft:SetPoint("BOTTOM", f, "BOTTOM", -space, offset)
		f.sidePlusBleft:SetWidth(wh)
		f.sidePlusBleft:SetHeight(wh)
	elseif indicator == "sidePlusBcenter" then
		f.sidePlusBcenter:SetPoint("BOTTOM", f, "BOTTOM", 0, offset)
		f.sidePlusBcenter:SetWidth(wh)
		f.sidePlusBcenter:SetHeight(wh)
	elseif indicator == "sidePlusBright" then
		f.sidePlusBright:SetPoint("BOTTOM", f, "BOTTOM", space, offset)
		f.sidePlusBright:SetWidth(wh)
		f.sidePlusBright:SetHeight(wh)
	elseif indicator == "sidePlusLtop" then
		f.sidePlusLtop:SetPoint("LEFT", f, "LEFT", offset, space)
		f.sidePlusLtop:SetWidth(wh)
		f.sidePlusLtop:SetHeight(wh)
	elseif indicator == "sidePlusLcenter" then
		f.sidePlusLcenter:SetPoint("LEFT", f, "LEFT", offset, 0)
		f.sidePlusLcenter:SetWidth(wh)
		f.sidePlusLcenter:SetHeight(wh)
	elseif indicator == "sidePlusLbottom" then
		f.sidePlusLbottom:SetPoint("LEFT", f, "LEFT", offset, -space)
		f.sidePlusLbottom:SetWidth(wh)
		f.sidePlusLbottom:SetHeight(wh)
	elseif indicator == "sidePlusRtop" then
		f.sidePlusRtop:SetPoint("RIGHT", f, "RIGHT", offset*-1, space)
		f.sidePlusRtop:SetWidth(wh)
		f.sidePlusRtop:SetHeight(wh)
	elseif indicator == "sidePlusRcenter" then
		f.sidePlusRcenter:SetPoint("RIGHT", f, "RIGHT", offset*-1, 0)
		f.sidePlusRcenter:SetWidth(wh)
		f.sidePlusRcenter:SetHeight(wh)
	elseif indicator == "sidePlusRbottom" then
		f.sidePlusRbottom:SetPoint("RIGHT", f, "RIGHT", offset*-1, -space)
		f.sidePlusRbottom:SetWidth(wh)
		f.sidePlusRbottom:SetHeight(wh)
	end
end

function GridIndicatorSidePlus.SetIndicator(frame, indicator, color, text, value, maxValue, texture, start, duration, stack)
	if indicator == "sidePlusTleft"
	or indicator == "sidePlusTcenter"
	or indicator == "sidePlusTright"
	or indicator == "sidePlusBleft"
	or indicator == "sidePlusBcenter"
	or indicator == "sidePlusBright"
	or indicator == "sidePlusLtop"
	or indicator == "sidePlusLcenter"
	or indicator == "sidePlusLbottom"
	or indicator == "sidePlusRtop"
	or indicator == "sidePlusRcenter"
	or indicator == "sidePlusRbottom"
	then
		if not frame[indicator] then
			frame.CreateIndicator(frame, indicator)
		end
		if not color then color = { r = 1, g = 1, b = 1, a = 1 } end
		frame[indicator]:SetBackdropColor(color.r, color.g, color.b, color.a)
		frame[indicator]:Show()
	end
end

function GridIndicatorSidePlus.ClearIndicator(frame, indicator)
	if indicator == "sidePlusTleft"
	or indicator == "sidePlusTcenter"
	or indicator == "sidePlusTright"
	or indicator == "sidePlusBleft"
	or indicator == "sidePlusBcenter"
	or indicator == "sidePlusBright"
	or indicator == "sidePlusLtop"
	or indicator == "sidePlusLcenter"
	or indicator == "sidePlusLbottom"
	or indicator == "sidePlusRtop"
	or indicator == "sidePlusRcenter"
	or indicator == "sidePlusRbottom"
	then
		if frame[indicator] then
			frame[indicator]:SetBackdropColor(1, 1, 1, 1)
			frame[indicator]:Hide()
		end
	end
end

function GridIndicatorSidePlus.SetCornerSize(f, size)
	local wh = GridIndicatorSidePlus.db.profile.SidePlusSize
	local space = GridIndicatorSidePlus.db.profile.SidePlusSpace
	local offset = GridIndicatorSidePlus.db.profile.SidePlusOffset
	if GridIndicatorSidePlus.db.profile.SidePlusOriginalSize then
		wh = GridFrame.db.profile.cornerSize
	end
	if f.sidePlusTleft then
		f.sidePlusTleft:SetPoint("TOP", f, "TOP", -space, offset*-1)
		f.sidePlusTleft:SetWidth(wh)
		f.sidePlusTleft:SetHeight(wh)
	end
	if f.sidePlusTcenter then
		f.sidePlusTcenter:SetPoint("TOP", f, "TOP", 0, offset*-1)
		f.sidePlusTcenter:SetWidth(wh)
		f.sidePlusTcenter:SetHeight(wh)
	end
	if f.sidePlusTright then
		f.sidePlusTright:SetPoint("TOP", f, "TOP", space, offset*-1)
		f.sidePlusTright:SetWidth(wh)
		f.sidePlusTright:SetHeight(wh)
	end
	if f.sidePlusBleft then
		f.sidePlusBleft:SetPoint("BOTTOM", f, "BOTTOM", -space, offset)
		f.sidePlusBleft:SetWidth(wh)
		f.sidePlusBleft:SetHeight(wh)
	end
	if f.sidePlusBcenter then
		f.sidePlusBcenter:SetPoint("BOTTOM", f, "BOTTOM", 0, offset)
		f.sidePlusBcenter:SetWidth(wh)
		f.sidePlusBcenter:SetHeight(wh)
	end
	if f.sidePlusBright then
		f.sidePlusBright:SetPoint("BOTTOM", f, "BOTTOM", space, offset)
		f.sidePlusBright:SetWidth(wh)
		f.sidePlusBright:SetHeight(wh)
	end
	if f.sidePlusLtop then
		f.sidePlusLtop:SetPoint("LEFT", f, "LEFT", offset, space)
		f.sidePlusLtop:SetWidth(wh)
		f.sidePlusLtop:SetHeight(wh)
	end
	if f.sidePlusLcenter then
		f.sidePlusLcenter:SetPoint("LEFT", f, "LEFT", offset, 0)
		f.sidePlusLcenter:SetWidth(wh)
		f.sidePlusLcenter:SetHeight(wh)
	end
	if f.sidePlusLbottom then
		f.sidePlusLbottom:SetPoint("LEFT", f, "LEFT", offset, -space)
		f.sidePlusLbottom:SetWidth(wh)
		f.sidePlusLbottom:SetHeight(wh)
	end
	if f.sidePlusRtop then
		f.sidePlusRtop:SetPoint("RIGHT", f, "RIGHT", offset*-1, space)
		f.sidePlusRtop:SetWidth(wh)
		f.sidePlusRtop:SetHeight(wh)
	end
	if f.sidePlusRcenter then
		f.sidePlusRcenter:SetPoint("RIGHT", f, "RIGHT", offset*-1, 0)
		f.sidePlusRcenter:SetWidth(wh)
		f.sidePlusRcenter:SetHeight(wh)
	end
	if f.sidePlusRbottom then
		f.sidePlusRbottom:SetPoint("RIGHT", f, "RIGHT", offset*-1, -space)
		f.sidePlusRbottom:SetWidth(wh)
		f.sidePlusRbottom:SetHeight(wh)
	end
end