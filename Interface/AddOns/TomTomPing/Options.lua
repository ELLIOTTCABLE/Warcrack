local _G = _G

-- addon name and namespace
local ADDON, NS = ...

local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON)

-- the Options module
local Options = Addon:NewModule("Options")

-- internal event handling
Options.callbacks = LibStub("CallbackHandler-1.0"):New(Options)

-- local functions
local pairs   = pairs
local tinsert = table.insert

local _

local LibStub   = LibStub

-- config libraries
local AceConfig 		= LibStub:GetLibrary("AceConfig-3.0")
local AceConfigReg 		= LibStub:GetLibrary("AceConfigRegistry-3.0")
local AceConfigDialog	= LibStub:GetLibrary("AceConfigDialog-3.0")

-- translations
local L = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

-- local variables
local defaults = {
	profile = {
        Ping 			= true,
        Minimap			= false,
        HideHint		= false,
		Destination		= "none",
		RangeCheck		= false,
		ShowNoDest		= false,
        ArrivalRange	= 1,
        Duration        = 10,
		RangePrecision	= 1,
		TimePrecision	= 1,
        Release			= false,
		MouseButton     = nil,
		InCombat        = "always",
		OutOfCombat     = "always",
		WhenTargetAlive = "always",
		WhenTargetDead  = "always",
		InRange         = "always",
		OutOfRange      = "always",
		UnitIsPlayer    = "never",
		UnitIsPet       = "never",
        Compass			= true,
		Icon			= "compass",
	},
	global = {
		ZoneDimensions = {}
	}
}

-- bookkeeping for targeting type 
-- (needed to achieve ordered combobox, named option value and translated display value)
local destType = {
	opt2txt = {
		[0]           	= L["none"], 
		[1]				= L["target"], 
		[2]				= L["focus"], 
		[3]				= L["mouseover"], 
		[4]				= L["mouseoverclick"], 
		[5]				= L["waypoint"], 
	},
	opt2val = {
		[0]				= "none", 
		[1]				= "target", 
		[2]				= "focus", 
		[3]				= "mouseover", 
		[4]				= "mouseoverclick", 
		[5]				= "waypoint", 
	},
	val2opt = {
		none			= 0, 
		target			= 1, 
		focus			= 2, 
		mouseover		= 3, 
		mouseoverclick	= 4, 
		waypoint		= 5, 
	}
}

local modificators = {
	opt2txt = {
		[0]					= L["never"], 
		[1]					= L["always"], 
		[2]					= L["alt"], 
		[3]					= L["ctrl"], 
		[4]					= L["shift"], 
		[5]					= L["alt-ctrl"], 
		[6]					= L["alt-shift"], 
		[7]					= L["ctrl-shift"], 
		[8]					= L["alt-ctrl-shift"], 
	},
	opt2val = {
		[0]					= "never", 
		[1]					= "always", 
		[2]					= "alt", 
		[3]					= "ctrl", 
		[4]					= "shift", 
		[5]					= "alt-ctrl", 
		[6]					= "alt-shift", 
		[7]					= "ctrl-shift", 
		[8]					= "alt-ctrl-shift", 
	},
	val2opt = {
		["never"]			= 0, 
		["always"]			= 1, 
		["alt"]				= 2, 
		["ctrl"]			= 3, 
		["shift"]			= 4, 
		["alt-ctrl"]		= 5, 
		["alt-shift"]		= 6, 
		["ctrl-shift"]		= 7, 
		["alt-ctrl-shift"]	= 8, 
	}
}

local mouseButtons = {
	opt2txt = {
		[0]           	= L["AnyButton"], 
		[1]				= L["LeftButton"], 
		[2]				= L["RightButton"], 
		[3]				= L["MiddleButton"], 
		[4]				= L["Button4"], 
		[5]				= L["Button5"], 
	},
	opt2val = {
		[0]				= "AnyButton", 
		[1]				= "LeftButton", 
		[2]				= "RightButton", 
		[3]				= "MiddleButton", 
		[4]				= "Button4", 
		[5]				= "Button5", 
	},
	val2opt = {
		AnyButton		= 0, 
		LeftButton		= 1, 
		RightButton		= 2, 
		MiddleButton	= 3, 
		Button4			= 4, 
		Button5			= 5, 
	}
}

local compassIcons = {
	opt2txt = {
		[0]     = L["arrow"], 
		[1]		= L["compass"], 
	},
	opt2val = {
		[0]		= "arrow", 
		[1]		= "compass", 
	},
	val2opt = {
		arrow	= 0, 
		compass	= 1, 
	}
}

-- module handling
function Options:OnInitialize()
	-- options
	self.options = {}
	
	-- options
	self.db = LibStub:GetLibrary("AceDB-3.0"):New(Addon.MODNAME.."_DB", defaults, "Default")
		
	self:Setup()
		
	-- profile support
	self.options.args.profile = LibStub:GetLibrary("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied",  "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset",   "OnProfileChanged")

	AceConfigReg:RegisterOptionsTable(Addon.FULLNAME, self.options)
	AceConfigDialog:AddToBlizOptions(Addon.FULLNAME)
end

function Options:OnEnable()
	-- empty
end

function Options:OnDisable()
	-- empty
end

function Options:OnProfileChanged(event, database, newProfileKey)
	self.db.profile = database.profile
	
	Addon:OnOptionsReloaded()
end

function Options:Setup()	
    self.options = {
		handler = Options,
		type = 'group',
		args = {
			minimap = {
				type = 'toggle',
				name = L["Minimap Button"],
				desc = L["Show Minimap Button"],
				get  = function() return self:GetSetting("Minimap") end,
				set  = function()
					self:ToggleSetting("Minimap")
				end,
				order = 1,
			},
			hint = {
				type = 'toggle',
				name = L["Hide Hint"],
				desc = L["Hide usage hint in tooltip"],
				get  = function() return self:GetSetting("HideHint") end,
				set  = function()
					self:ToggleSetting("HideHint") 
				end,
				order = 2,
			},
			keyHint = {
				type = "description",
				name = L["Also check the key bindings!"],
				order = 3,
			},
			arrow = {
				type = 'group',
				name = L["Arrow"],
				desc = L["Arrow Display Settings"],
				order = 4,
				args = {
					timeprec = {
						type = 'range',
						name = L["Time Precision"],
						desc = L["Positions after decimal point"],
						get = function() return self:GetSetting("TimePrecision") end,
						set = function(info, value) 
							self:SetSetting("TimePrecision", value)
						end,
						min = 0,
						max = 2,
						step = 1,
						bigStep = 1,
						order = 1,
					},
					rangeprec = {
						type = 'range',
						name = L["Range Precision"],
						desc = L["Positions after decimal point"],
						get = function() return self:GetSetting("RangePrecision") end,
						set = function(info, value) 
							self:SetSetting("RangePrecision", value)
						end,
						min = 0,
						max = 2,
						step = 1,
						bigStep = 1,
						order = 2,
					},
				},
			},
			ping = {
				type = 'group',
				name = L["Ping"],
				desc = L["Ping Settings"],
				order = 5,
				args = {
					ping = {
						type = 'toggle',
						name = L["Activate Ping"],
						desc = L["Show arrow on ping"],
						get  = function() return self:GetSetting("Ping") end,
						set  = function()
							self:ToggleSetting("Ping")
						end,
						order = 1,
					},
					release = {
						type = 'toggle',
						name = L["Hide on arrival"],
						desc = L["Hide arrow when within distance"],
						get  = function() return self:GetSetting("Release") end,
						set  = function()
							self:ToggleSetting("Release")
						end,
						order = 2,
					},
					duration = {
						type = 'range',
						name = L["Duration"],
						desc = L["Duration before fade out"],
						get = function() return self:GetSetting("Duration") end,
						set = function(info, value) 
							self:SetSetting("Duration", value)
						end,
						min = 0,
						max = 60,
						step = 1,
						bigStep = 1,
						order = 3,
					},
					range = {
						type = 'range',
						name = L["Arrival Range"],
						desc = L["Arrow points down to indicate arrival when within this distance"],
						get = function() return self:GetSetting("ArrivalRange") end,
						set = function(info, value) 
							self:SetSetting("ArrivalRange", value)
						end,
						min = 0,
						max = 100,
						step = 1,
						bigStep = 1,
						order = 4,
					},
				},
			},
			targeting = {
				type = 'group',
				name = L["Targeting"],
				desc = L["Target Settings"],
				order = 6,
				args = {
					destination = {
						type = 'select',
						name = L["Destination"],
						desc = L["Select destination"],
						get = function() return destType.val2opt[self:GetSetting("Destination")] end,
						set = function(info, value) 
							self:SetSetting("Destination", destType.opt2val[value])
						end,
						values = destType.opt2txt,
						order = 1,
					},
					rangeCheck = {
						type = 'toggle',
						name = L["Range Check"],
						desc = L["Range check for healing"],
						get  = function() return self:GetSetting("RangeCheck") end,
						set  = function()
							self:ToggleSetting("RangeCheck")
						end,
						order = 2,
					},
					showNoDest = {
						type = 'toggle',
						name = L["Show Empty Destination"],
						desc = L["Show arrow when no destination is set"],
						get  = function() return self:GetSetting("ShowNoDest") end,
						set  = function()
							self:ToggleSetting("ShowNoDest")
						end,
						order = 3,
					},
					mouseButton = {
						type = 'group',
						name = L["Mouse Button"],
						desc = L["Select mouse button to use for mouseover-click setting."],
						order = 4,
						args = {
							mouseButton = {
								type = 'select',
								name = L["Mouse Button"],
								desc = L["Select mouse button to use for mouseover-click setting."],
								get = function() return mouseButtons.val2opt[self:GetSetting("MouseButton") or "AnyButton"] end,
								set = function(info, value)
									local button = mouseButtons.opt2val[value]
									
									if value == 0 then
										button = nil
									end
									
									self:SetSetting("MouseButton", button)
								end,
								values = mouseButtons.opt2txt,
								order = 1,
							},
						},
					},
					modificators = {
						type = 'group',
						name = L["Modificator keys"],
						desc = L["Modificator keys for mouse-over settings."],
						order = 5,
						args = {
							modInCombat = {
								type = 'select',
								name = L["In Combat"],
								desc = L["Show mouse-over target in combat."],
								get = function() return modificators.val2opt[self:GetSetting("InCombat")] end,
								set = function(info, value) 
									self:SetSetting("InCombat", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 1,
							},
							modOutOfCombat = {
								type = 'select',
								name = L["Out of Combat"],
								desc = L["Show mouse-over target out of combat."],
								get = function() return modificators.val2opt[self:GetSetting("OutOfCombat")] end,
								set = function(info, value) 
									self:SetSetting("OutOfCombat", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 2,
							},
							modWhenTargetAlive = {
								type = 'select',
								name = L["Target Alive"],
								desc = L["Show mouse-over target when target is alive."],
								get = function() return modificators.val2opt[self:GetSetting("WhenTargetAlive")] end,
								set = function(info, value) 
									self:SetSetting("WhenTargetAlive", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 3,
							},
							modWhenTargetDead = {
								type = 'select',
								name = L["Target Dead"],
								desc = L["Show mouse-over target when target is dead."],
								get = function() return modificators.val2opt[self:GetSetting("WhenTargetDead")] end,
								set = function(info, value) 
									self:SetSetting("WhenTargetDead", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 4,
							},
							modInRange = {
								type = 'select',
								name = L["In Range"],
								desc = L["Show mouse-over target when target is in healing range."],
								get = function() return modificators.val2opt[self:GetSetting("InRange")] end,
								set = function(info, value) 
									self:SetSetting("InRange", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 5,
							},
							modOutOfRange = {
								type = 'select',
								name = L["Out of Range"],
								desc = L["Show mouse-over target when target is out of healing range."],
								get = function() return modificators.val2opt[self:GetSetting("OutOfRange")] end,
								set = function(info, value) 
									self:SetSetting("OutOfRange", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 6,
							},
							modUnitIsPlayer = {
								type = 'select',
								name = L["Unit is Player"],
								desc = L["Show mouse-over target when target is yourself."],
								get = function() return modificators.val2opt[self:GetSetting("UnitIsPlayer")] end,
								set = function(info, value) 
									self:SetSetting("UnitIsPlayer", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 7,
							},
							modUnitIsPet = {
								type = 'select',
								name = L["Unit is Pet"],
								desc = L["Show mouse-over target when target is pet."],
								get = function() return modificators.val2opt[self:GetSetting("UnitIsPet")] end,
								set = function(info, value) 
									self:SetSetting("UnitIsPet", modificators.opt2val[value])
								end,
								values = modificators.opt2txt,
								order = 8,
							},
						},
					},
				},
			},
			icon = {
				type = 'group',
				name = L["Icon"],
				desc = L["Icon Settings"],
				order = 5,
				args = {
					compass = {
						type = 'toggle',
						name = L["Compass"],
						desc = L["Use compass icon that shows player direction."],
						get  = function() return self:GetSetting("Compass") end,
						set  = function()
							self:ToggleSetting("Compass")
						end,
						order = 1,
					},
					icon = {
						type = 'select',
						name = L["Compass Icon"],
						desc = L["Select Compass Icon"],
						get = function() return compassIcons.val2opt[self:GetSetting("Icon")] end,
						set = function(info, value) 
							self:SetSetting("Icon", compassIcons.opt2val[value])
						end,
						values = compassIcons.opt2txt,
						order = 2,
					},
				},
			},
		},
	}
end

-- settings
function Options:GetSetting(option)
	return self.db.profile[option]
end

function Options:SetSetting(option, value)
	local current = self:GetSetting(option)

	if current == value then
		return
	end
	
	self.db.profile[option] = value

	-- fire event when setting changed
	self.callbacks:Fire(ADDON .. "_SETTING_CHANGED", option, value, current)
end

function Options:ToggleSetting(option)
	self:SetSetting(option, not self:GetSetting(option) and true or false)
end

function Options:ToggleSettingTrueNil(option)
	self:SetSetting(option, not self:GetSetting(option) and true or nil)
end

-- zone measurements
function Options:GetZoneDimensions(map, level)
	local width, height
	
	if self.db.global.ZoneDimensions[map] and self.db.global.ZoneDimensions[map][level] then
		width  = self.db.global.ZoneDimensions[map][level][1]
		height = self.db.global.ZoneDimensions[map][level][2]
	end	
	
    return width, height
end

function Options:SetZoneDimensions(map, level, xDim, yDim)
	if not self.db.global.ZoneDimensions[map] then
		self.db.global.ZoneDimensions[map] = {}
	end

	if not self.db.global.ZoneDimensions[map][level] then
		self.db.global.ZoneDimensions[map][level] = {}
	end
	
	self.db.global.ZoneDimensions[map][level][1] = xDim
	self.db.global.ZoneDimensions[map][level][2] = yDim
end

function Options:HasZoneDimensions(map, level)
	return self.db.global.ZoneDimensions[map] and self.db.global.ZoneDimensions[map][level] and true or false
end

-- utilities
function Options:IterateDestinations()
	return pairs(destType.val2opt)
end

-- test
function Options:Debug(msg)
	Addon:Debug("(Options) " .. msg)
end
