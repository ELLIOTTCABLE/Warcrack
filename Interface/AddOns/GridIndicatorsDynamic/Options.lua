local AddonName = ...
local Grid = Grid
local GridFrame = Grid:GetModule("GridFrame")
local Media = LibStub("LibSharedMedia-3.0")
local AceGUI = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local GridIndicatorsDynamic = Grid:NewModule(AddonName)
GridIndicatorsDynamic.defaultDB = {
	settings = {
		textId = 1,
		iconId = 1,
		boxId = 1,
	},
}

local options

local function UpdateIndicatorName(info, value)
	local id = info[#info - 1]
	GridIndicatorsDynamic.db.profile[id].name = value
	options.args[id].name = value
	Grid.options.args.GridIndicator.args[id].name = value
	GridFrame:UpdateOptionsForIndicator(id, value)
end

local function DeleteIndicator(info)
	local id = info[#info - 1]
	GridIndicatorsDynamic.db.profile[id] = nil
	options.args[id] = nil
	GridFrame.db.profile.statusmap[id] = nil
	Grid.options.args.GridIndicator.args[id] = nil
	for _, f in pairs(GridFrame.registeredFrames) do
		f:ClearIndicator(id)
	end
end

local function GetAnchorMenu()
	return {
		name = "Layout Anchor",
		desc = "Sets where this indicator is anchored relative to the frame.",
		order = 5,
		width = "double",
		type = "select",
		values = {
			CENTER      = "Center",
			TOP         = "Top",
			BOTTOM      = "Bottom",
			LEFT        = "Left",
			RIGHT       = "Right",
			TOPLEFT     = "Top Left",
			TOPRIGHT    = "Top Right",
			BOTTOMLEFT  = "Bottom Left",
			BOTTOMRIGHT = "Bottom Right",
		},
	}
end

local function GetDefaultTextOptionMenu()
	return {
		name = "New Dynamic Text",
		desc = "Configure this text",
		order = 300,
		type = "group",
		args = {
			name = {
				name = "Name",
				order = 1,
				type = "input",
				set = UpdateIndicatorName
			},
			delete = {
				name = "Delete",
				order = 2,
				type = "execute",
				func = DeleteIndicator
			},
			anchor = GetAnchorMenu(),
			offsetX = {
				name = "Offset X",
				desc = "Adjust the X offset",
				order = 10,
				type = "range", min = -100, max = 100, step = 1,
			},
			offsetY = {
				name = "Offset Y",
				desc = "Adjust the Y offset",
				order = 11,
				type = "range", min = -100, max = 100, step = 1,
			},
			font = {
				name = "Font",
				desc = "Adjust the font settings",
				order = 20, width = "double",
				type = "select",
				values = Media:HashTable("font"),
				dialogControl = "LSM30_Font",
			},
			fontSize = {
				name = "Font Size",
				desc = "Adjust the font size.",
				order = 21, width = "double",
				type = "range", min = 6, max = 24, step = 1,
			},
			fontOutline = {
				name = "Font Outline",
				desc = "Adjust the font outline.",
				order = 30, width = "double",
				type = "select",
				values = {
					NONE = "None",
					OUTLINE = "Thin",
					THICKOUTLINE = "Thick",
				},
			},
			fontShadow = {
				name = "Font Shadow",
				desc = "Toggle the font drop shadow effect.",
				order = 40, width = "double",
				type = "toggle",
			},
			textlength = {
				name = "Text Length",
				desc = "Number of characters to show on the text indicators.",
				order = 50, width = "double",
				type = "range", min = 1, max = 12, step = 1,
			},
			frameLevel = {
				name = "Frame level",
				desc = "If you have overlapping indicators this determines which gets rendered on top.",
				order = 60, width = "double",
				type = "range", min = -1, max = 10, step = 1,
			},
		},
	}
end

local function GetDefaultIconOptionMenu()
	return {
		name = "New Dynamic Icon",
		desc = "Configure this icon.",
		order = 300,
		type = "group",
		args = {
			name = {
				name = "Name",
				order = 1,
				type = "input",
				set = UpdateIndicatorName
			},
			delete = {
				name = "Delete",
				order = 2,
				type = "execute",
				func = DeleteIndicator
			},
			anchor = GetAnchorMenu(),
			offsetX = {
				name = "Offset X",
				desc = "Adjust the X offset",
				order = 20,
				type = "range", min = -100, max = 100, step = 1,
			},
			offsetY = {
				name = "Offset Y",
				desc = "Adjust the Y offset",
				order = 21,
				type = "range", min = -100, max = 100, step = 1,
			},
			iconSize = {
				name = "Icon Size",
				desc = "Adjust the size of the icons.",
				order = 30, width = "double",
				type = "range", min = 5, max = 50, step = 1,
			},
			iconBorderSize = {
				name = "Icon Border Size",
				desc = "Adjust the size of the center icon's borders.",
				order = 31, width = "double",
				type = "range", min = 0, max = 9, step = 1,
			},
			enableIconCooldown = {
				name = "Enable Icon Cooldown Frame",
				desc = "Toggle center icon's cooldown frame.",
				order = 40, width = "double",
				type = "toggle",
			},
			enableIconStackText = {
				name = "Enable Icon Stack Text",
				desc = "Toggle center icon's stack count text.",
				order = 50, width = "double",
				type = "toggle",
			},
			stackFontSize = {
				name = "Icon Stack Text Font Size",
				desc = "Adjust the font size of the icon stack text.",
				order = 51, width = "double",
				type = "range", min = 4, max = 24, step = 1,
			},
			stackOffsetX = {
				name = "Icon Stack Text Offset X",
				desc = "Adjust the position of the icon stack text.",
				order = 60, width = "normal",
				type = "range", softMin = -20, softMax = 20, step = 1,
			},
			stackOffsetY = {
				name = "Icon Stack Text Offset Y",
				desc = "Adjust the position of the icon stack text.",
				order = 61, width = "normal",
				type = "range", softMin = -20, softMax = 20, step = 1,
			},
			frameLevel = {
				name = "Frame level",
				desc = "If you have overlapping indicators this determines which gets rendered on top.",
				order = 70, width = "double",
				type = "range", min = -1, max = 10, step = 1,
			},
		},
	}
end

local function GetDefaultBoxOptionMenu()
	return {
		name = "New Dynamic Box",
		desc = "Configure this box",
		order = 300,
		type = "group",
		args = {
			name = {
				name = "Name",
				order = 1,
				type = "input",
				set = UpdateIndicatorName
			},
			delete = {
				name = "Delete",
				order = 2,
				type = "execute",
				func = DeleteIndicator
			},
			anchor = GetAnchorMenu(),
			offsetX = {
				name = "Offset X",
				desc = "Adjust the X offset",
				order = 20,
				type = "range", min = -100, max = 100, step = 1,
			},
			offsetY = {
				name = "Offset Y",
				desc = "Adjust the Y offset",
				order = 21,
				type = "range", min = -100, max = 100, step = 1,
			},
			size = {
				name = "Size",
				desc = "Adjust the size.",
				order = 30, width = "double",
				type = "range", min = 1, max = 24, step = 1,
			},
			frameLevel = {
				name = "Frame level",
				desc = "If you have overlapping indicators this determines which gets rendered on top.",
				order = 70, width = "double",
				type = "range", min = -1, max = 10, step = 1,
			},
		},
	}
end

local function NewIconIndicator()
	GridIndicatorsDynamic.db.profile.settings.iconId = GridIndicatorsDynamic.db.profile.settings.iconId + 1
	local id = "gid_icon_" .. GridIndicatorsDynamic.db.profile.settings.iconId
	GridIndicatorsDynamic.db.profile[id] = {
		anchor = "CENTER",
		offsetX = 0,
		offsetY = 0,
		iconSize = 12,
		iconBorderSize = 0,
		enableIconStackText = true,
		enableIconCooldown = true,
		stackFontSize = 7,
		stackOffsetX = 4,
		stackOffsetY = -2,
		frameLevel = 1,
	}
	options.args[id] = GetDefaultIconOptionMenu()
	GridIndicatorsDynamic:Icon_RegisterIndicator(id, options.args[id].name)
	GridFrame:UpdateOptionsForIndicator(id, options.args[id].name)
	AceConfigDialog:SelectGroup("Grid", "GridIndicatorsDynamic", id)
end

local function NewTextIndicator()
	GridIndicatorsDynamic.db.profile.settings.textId = GridIndicatorsDynamic.db.profile.settings.textId + 1
	local id = "gid_text_" .. GridIndicatorsDynamic.db.profile.settings.textId
	GridIndicatorsDynamic.db.profile[id] = {
		anchor = "CENTER",
		offsetX = 0,
		offsetY = 0,
		font = "Friz Quadrata TT",
		fontSize = 8,
		fontOutline = "THIN",
		fontShadow = false,
		textlength = 6,
		frameLevel = 1,
	}
	options.args[id] = GetDefaultTextOptionMenu()
	GridIndicatorsDynamic:Text_RegisterIndicator(id, options.args[id].name)
	GridFrame:UpdateOptionsForIndicator(id, options.args[id].name)
	AceConfigDialog:SelectGroup("Grid", "GridIndicatorsDynamic", id)
end

local function NewBoxIndicator()
	GridIndicatorsDynamic.db.profile.settings.boxId = GridIndicatorsDynamic.db.profile.settings.boxId + 1
	local id = "gid_box_" .. GridIndicatorsDynamic.db.profile.settings.boxId
	GridIndicatorsDynamic.db.profile[id] = {
		anchor = "CENTER",
		size = 8,
		offsetX = 0,
		offsetY = 0,
		anchor = "TOPRIGHT",
		frameLevel = 1,
	}
	options.args[id] = GetDefaultBoxOptionMenu()
	GridIndicatorsDynamic:Box_RegisterIndicator(id, options.args[id].name)
	GridFrame:UpdateOptionsForIndicator(id, options.args[id].name)
	AceConfigDialog:SelectGroup("Grid", "GridIndicatorsDynamic", id)
end

function GridIndicatorsDynamic:Reset()
	for k, v in pairs(Grid.options.args.GridIndicator.args) do
		if string.match(k, "gid_") then
			options.args[k] = nil
			GridFrame.indicators[k] = nil
			Grid.options.args.GridIndicator.args[k] = nil
		end
	end
	options = {
		name = "Dynamic Indicators",
		order = 1000,
		type = "group",
		set = function(info, value)
			GridIndicatorsDynamic.db.profile[info[#info - 1]][info[#info]] = value
			GridFrame:UpdateAllFrames()
		end,
		get = function(info)
			return GridIndicatorsDynamic.db.profile[info[#info - 1]][info[#info]]
		end,
		args = {
			newText = {
				name = "New Text Indicator",
				order = 1,
				type = "execute",
				func = NewTextIndicator,
			},
			newIcon = {
				name = "New Icon Indicator",
				order = 2,
				type = "execute",
				func = NewIconIndicator,
			},
			newBox = {
				name = "New Box Indicator",
				order = 3,
				type = "execute",
				func = NewBoxIndicator,
			},
		}
	}
	for k, v in pairs(GridIndicatorsDynamic.db.profile) do
		if string.match(k, "gid_icon_") then
			v.frameLevel = v.frameLevel or 1 -- remove somewhere in the future
			options.args[k] = GetDefaultIconOptionMenu()
			GridIndicatorsDynamic:Icon_RegisterIndicator(k, v.name or options.args[k].name)
		elseif string.match(k, "gid_text_") then
			v.frameLevel = v.frameLevel or 1 -- remove somewhere in the future
			options.args[k] = GetDefaultTextOptionMenu()
			GridIndicatorsDynamic:Text_RegisterIndicator(k, v.name or options.args[k].name)
		elseif string.match(k, "gid_box_") then
			v.frameLevel = v.frameLevel or 1 -- remove somewhere in the future
			options.args[k] = GetDefaultBoxOptionMenu()
			GridIndicatorsDynamic:Box_RegisterIndicator(k, v.name or options.args[k].name)
		end
		if v.name then
			options.args[k].name = v.name
		end
	end
	Grid.options.args["GridIndicatorsDynamic"] = options
	GridFrame:UpdateOptionsMenu()
	AceGUI:NotifyChange("Grid")
end

function GridIndicatorsDynamic:OnInitialize()
    if not self.db then
		self.db = Grid.db:RegisterNamespace(self.moduleName, { profile = self.defaultDB or { } })
	end
	self:Reset()
end