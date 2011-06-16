-- addon constants
local MODNAME   = "TomTomPing"
local FULLNAME  = "TomTomPing"
local SHORTNAME = "TTP"
local DIRNAME   = "TomTomPing"

-- setup libs
local LibStub   = LibStub
local LDB       = LibStub:GetLibrary("LibDataBroker-1.1")

-- tooltip library
local QT        = LibStub:GetLibrary("LibQTip-1.0")

-- get translations
local L         = LibStub:GetLibrary("AceLocale-3.0"):GetLocale( MODNAME )

-- config libraries
local AceConfig       = LibStub:GetLibrary("AceConfig-3.0")
local AceConfigReg    = LibStub:GetLibrary("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0")

-- astrolabe
local Astrolabe
if(DongleStub) then Astrolabe = DongleStub("Astrolabe-0.4") end

-- binding descriptions
BINDING_HEADER_TOM_TOM_PING            = MODNAME
BINDING_NAME_TOMTOMPING_TARGET         = L["Target as destination"]
BINDING_NAME_TOMTOMPING_STICK          = L["(Un)Stick current destination"]
BINDING_NAME_TOMTOMPING_PING           = L["Ping your position"]
BINDING_NAME_TOMTOMPING_CLEAR          = L["Release CrazyArrow"]
BINDING_NAME_TOMTOMPING_SELF_WAYPOINT  = L["Set waypoint on current position"]
BINDING_NAME_TOMTOMPING_CLEAR_WAYPOINT = L["Clear waypoint"]

local GetPlayerFacing, GetPlayerMapPosition, GetMouseFocus, SecureButton_GetModifiedUnit, UnitIsUnit =
	GetPlayerFacing, GetPlayerMapPosition, GetMouseFocus, SecureButton_GetModifiedUnit, UnitIsUnit

local cos, sin, rad, atan2 = math.cos, math.sin, math.rad, math.atan2
local sqrt, abs, floor = math.sqrt, math.abs, math.floor
local gsub, strsub = gsub, strsub

local SQRT2 = sqrt(2)
local PI    = math.pi
local TWOPI = PI * 2
local FRAD  = 180 / PI
local CRAD  = FRAD / 10

-- utilities
local function Debug( msg )
	if ( debug and msg ~= nil and DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage( MODNAME .. " (dbg): " .. msg, 0.6, 1.0, 1.0 )
	end
end
local function Output( msg )
	if ( msg ~= nil and DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage( MODNAME..": "..msg, 0.6, 1.0, 1.0 )
	end
end

local function Red( text )       return "|cffff0000" .. text .. "|r" end
local function Green( text )     return "|cff00ff00" .. text .. "|r" end
local function Yellow( text )    return "|cffffff00" .. text .. "|r" end
local function Magenta( text )   return "|cffff00ff" .. text .. "|r" end
local function White( text )     return "|cffffffff" .. text .. "|r" end
local function Brownish( text )  return "|cffeda55f" .. text .. "|r" end

local function GetArgs(str, pattern)
   local ret = {}
   local pos=0
   
   while true do
     local word
     _, pos, word=string.find(str, pattern, pos+1)
	 
     if not word then
       break
     end
	 
     word = string.lower(word)
     table.insert(ret, word)
   end
   
   return ret
end

-- addon and locals
TomTomPing = LibStub:GetLibrary("AceAddon-3.0"):NewAddon(MODNAME, "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

local tooltip

local function CreateTooltip( self )
	tooltip = QT:Acquire( MODNAME.."TT", 2 )
	tooltip:Hide()
	tooltip:Clear()
	tooltip:SetScale(1)
		
	TomTomPing:DrawTooltip()

	tooltip:SmartAnchorTo( self )
	tooltip:Show()
end

local function RemoveTooltip()
	if tooltip then
		tooltip:Hide()
		QT:Release(tooltip)
		tooltip = nil
	end
end

-- broker object
local dataobj  = LDB:NewDataObject(MODNAME, {
	type	= "data source",
	icon	= "Interface\\Addons\\"..DIRNAME.."\\ping.tga",
	label	= MODNAME,
	text	= SHORTNAME,
	OnClick = function(clickedframe, button) 
		TomTomPing:OnClick(button) 
	end,
	OnEnter = function ( self )
		CreateTooltip(self)
	end,
	OnLeave = function()
		RemoveTooltip()
	end,
	OnUpdate = function()
		if TomTomPing.db.profile.Destination == "mouseoverclick" then
			TomTomPing:SetDestination()
		end
	end
})

--  minimap button
do
	local dragMode = nil
	
	local function moveButton(self)
		if dragMode == "free" then
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", x, y)
		else
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			centerX, centerY = abs(x), abs(y)
			centerX, centerY = (centerX / sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
			centerX = x < 0 and -centerX or centerX
			centerY = y < 0 and -centerY or centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", centerX, centerY)
		end
	end

	local mm_button = CreateFrame("Button", MODNAME .. "_MinimapButton", Minimap)
	mm_button:SetHeight(32)
	mm_button:SetWidth(32)
	mm_button:SetFrameStrata("HIGH")
	mm_button:SetPoint("CENTER", -77.44, -20.06)
	mm_button:SetMovable(true)
	mm_button:SetUserPlaced(true)
	mm_button:EnableMouse(true)
	mm_button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	mm_button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	
	local icon = mm_button:CreateTexture(mm_button:GetName() .. "Icon", "HIGH")
	icon:SetTexture("Interface\\Addons\\"..DIRNAME.."\\ping.tga")
	icon:SetTexCoord(0, 1, 0, 1)
	icon:SetWidth(16)
	icon:SetHeight(16)
	icon:SetPoint("TOPLEFT", mm_button, "TOPLEFT", 8, -7)
	
	local overlay = mm_button:CreateTexture(mm_button:GetName() .. "Overlay", "OVERLAY")
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetWidth(53)
	overlay:SetHeight(53)
	overlay:SetPoint("TOPLEFT", mm_button, "TOPLEFT")
	
	mm_button:SetScript("OnClick", function(self, button)
		TomTomPing:OnClick(button)
	end)
	
	mm_button:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and IsControlKeyDown() then
			dragMode = "free"
			self:SetScript("OnUpdate", moveButton)
		elseif IsShiftKeyDown() then
			dragMode = nil
			self:SetScript("OnUpdate", moveButton)
		end
	end)
	
	mm_button:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
	end)

	mm_button:SetScript("OnEnter", function(self)
		CreateTooltip(self)
	end)
	
	mm_button:SetScript("OnLeave", function(self)
		RemoveTooltip()
	end)

	mm_button:Hide()

	function TomTomPing:ShowMinimapButton(show)
		if show then
			mm_button:Show()
		else
			mm_button:Hide()
		end
	end
end

-- invisible dummy frame for OnUpdate (only used when target tracking is "mouseover*")
do
	local mm_dummy = CreateFrame("Frame", MODNAME .. "_Dummy", UIParent)
	mm_dummy:SetHeight(1)
	mm_dummy:SetWidth(1)
	mm_dummy:SetFrameStrata("BACKGROUND")
	mm_dummy:SetPoint("TOPLEFT", 0, 0)
	mm_dummy:Show()

	function TomTomPing:ActivateOnUpdate(active)
		if active then
			mm_dummy:SetScript("OnUpdate", function() TomTomPing:SetDestination() end)
		else
			mm_dummy:SetScript("OnUpdate", nil)
		end
	end
end

-- LOCAL VARIABLES
local options = {}
local defaults = {
	profile = {
        Ping 			= true,
        Messages		= true,
        DBM				= true,
        Minimap			= false,
        HideHint		= false,
		Destination		= "none",
		RangeCheck		= false,
		ShowNoDest		= false,
        ArrivalRange	= 1,
        Duration        = 10,
		RangePrecision	= 1,
		TimePrecision	= 1,
	},
	global = {
		ZoneDimensions = {}
	}
}

-- bookkeeping for targeting type 
-- (needed to achieve ordered combobox, named option value and translated display value)
local destType = {
	val2txt = {
		none			= L["None"], 
		target			= L["Target"], 
		focus			= L["Focus"], 
		mouseover		= L["Mouseover"], 
		mouseoverclick	= L["Mouseover-Click"], 
		waypoint		= L["Waypoint"], 
	},
	opt2txt = {
		[0]           	= L["None"], 
		[1]				= L["Target"], 
		[2]				= L["Focus"], 
		[3]				= L["Mouseover"], 
		[4]				= L["Mouseover-Click"], 
		[5]				= L["Waypoint"], 
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

-- reference spell for range test
local ttp_HealSpells = { 
	["DRUID"]   = GetSpellInfo(5185)  or "Healing Touch",
	["PRIEST"]  = GetSpellInfo(2061)  or "Flash Heal",
	["PALADIN"] = GetSpellInfo(19750) or "Flash of Light",
	["SHAMAN"]  = GetSpellInfo(8004)  or "Lesser Healing Wave"
}
local ttp_RezSpells = { 
	["DRUID"]   = GetSpellInfo(20484) or "Rebirth",
	["PRIEST"]  = GetSpellInfo(2006)  or "Resurrection",
	["PALADIN"] = GetSpellInfo(7328)  or "Redemption",
	["SHAMAN"]  = GetSpellInfo(2008)  or "Ancestral Spirit"
}

-- scaling data
local MinimapSize = {
	indoor = {
		[0] = 300, -- scale
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}

-- tomtom data
local ttp_bTomTomOK       = false
local ttp_sTomTomErrorMsg = ""

-- label data
local compass = "NW---N---NE---E---SE---S---SW---W---NW---N---NE---E---"

-- player data
local ttp_sPlayerClass
local ttp_sPlayerName
local ttp_bPlayerIsHealer = false
local ttp_iHealSpellName
local ttp_iRezSpellName

-- destination data
local ttp_sDestUnit
local ttp_sDestName
local ttp_Distance
local ttp_bSticky        = false
local ttp_bRunAway       = false

-- ping data
local ttp_sPingerName

-- arrow data
local ttp_bCAPingActive  = false
local ttp_sLastArrowText = ""
local ttp_bShowDownArrow = false
local ttp_bArrowWasNorm  = true
local ttp_iClrCount      = 0
local ttp_iAlertHue      = 0
local ttp_bAlertPulseOn  = true

-- location data
local ttp_bIndoors       = false
local ttp_DungeonLvl     = nil
local ttp_ActMap         = nil

-- waypoints
local ttp_Waypoint       = {}

-- map name to raid/party unit
local ttp_Name2Unit      = {}

-- reference point for map measurement
local ttp_RefPoint       = nil

-- infrastructure functions
function TomTomPing:SetupOptions()	
    options = {
		handler = TomTomPing,
		type = 'group',
		args = {
			--messages = {
			--	type = 'toggle',
			--	name = L["Messages"],
			--	desc = L["Listen to remote TTP messages"],
			--	get  = function() return TomTomPing.db.profile.Messages end,
			--	set  = function()
			--		TomTomPing:ToggleMessages() 
			--	end,
			--	order = 1
			--},
			--dbm = {
			--	type = 'toggle',
			--	name = L["DBM"],
			--	desc = L["Use Deadly Boss Mods"],
			--	get  = function() return TomTomPing.db.profile.DBM end,
			--	set  = function()
			--		TomTomPing.db.profile.DBM = not TomTomPing.db.profile.DBM
			--		TomTomPing:Refresh() 
			--	end,
			--	order = 2
			--},
			minimap = {
				type = 'toggle',
				name = L["Minimap Button"],
				desc = L["Show Minimap Button"],
				get  = function() return TomTomPing.db.profile.Minimap end,
				set  = function()
					TomTomPing.db.profile.Minimap = not TomTomPing.db.profile.Minimap
					
					TomTomPing:ShowMinimapButton(TomTomPing.db.profile.Minimap)
				end,
				order = 3
			},
			hint = {
				type = 'toggle',
				name = L["Hide Hint"],
				desc = L["Hide usage hint in tooltip"],
				get  = function() return TomTomPing.db.profile.HideHint end,
				set  = function()
					TomTomPing.db.profile.HideHint = not TomTomPing.db.profile.HideHint
				end,
				order = 4
			},
			keyhint = {
				type = "description",
				name = L["Also check the key bindings!"],
				order = 5
			},
			arrow = {
				type = 'group',
				name = L["Arrow"],
				desc = L["Arrow Display Settings"],
				order = 10,
				args = {
					timeprec = {
						type = 'range',
						name = L["Time Precision"],
						desc = L["Positions after decimal point"],
						get  = function() return TomTomPing.db.profile.TimePrecision end,
						set  = function(info, v)
							TomTomPing.db.profile.TimePrecision = v
							TomTomPing:Refresh() 
						end,
						min = 0,
						max = 2,
						step = 1,
						bigStep = 1,
						order = 101
					},
					rangeprec = {
						type = 'range',
						name = L["Range Precision"],
						desc = L["Positions after decimal point"],
						get  = function() return TomTomPing.db.profile.RangePrecision end,
						set  = function(info, v)
							TomTomPing.db.profile.RangePrecision = v 
							TomTomPing:Refresh() 
						end,
						min = 0,
						max = 2,
						step = 1,
						bigStep = 1,
						order = 102
					},
				},
			},
			ping = {
				type = 'group',
				name = L["Ping"],
				desc = L["Ping Settings"],
				order = 20,
				args = {
					ping = {
						type = 'toggle',
						name = L["Activate Ping"],
						desc = L["Show arrow on ping"],
						get  = function() return TomTomPing.db.profile.Ping end,
						set  = function()
							TomTomPing:TogglePing() 
							TomTomPing:Refresh() 
						end,
						order = 201
					},
					duration = {
						type = 'range',
						name = L["Duration"],
						desc = L["Duration before fade out"],
						get  = function() return TomTomPing.db.profile.Duration end,
						set  = function(info, v)
							TomTomPing.db.profile.Duration = v
							TomTomPing:Refresh() 
						end,
						min = 0,
						max = 60,
						step = 1,
						bigStep = 1,
						order = 202
					},
					range = {
						type = 'range',
						name = L["Arrival Range"],
						desc = L["Fade out when within distance"],
						get  = function() return TomTomPing.db.profile.ArrivalRange end,
						set  = function(info, v)
							TomTomPing.db.profile.ArrivalRange = v
							TomTomPing:Refresh() 
						end,
						min = 0,
						max = 100,
						step = 1,
						bigStep = 1,
						order = 203
					},
				},
			},
			targeting = {
				type = 'group',
				name = L["Targeting"],
				desc = L["Target Settings"],
				order = 30,
				args = {
					destination = {
						type = 'select',
						name = L["Destination"],
						desc = L["Select destination"],
						get = function() return destType.val2opt[self.db.profile.Destination] end,	
						set = function(info, key) 
							TomTomPing:SetDestinationType(destType.opt2val[key])
							TomTomPing:Refresh() 
						end,
						values = destType.opt2txt,
						order = 301,
					},
					rangecheck = {
						type = 'toggle',
						name = L["Range Check"],
						desc = L["Range check for healing"],
						get  = function() return TomTomPing.db.profile.RangeCheck end,
						set  = function()
							TomTomPing.db.profile.RangeCheck = not TomTomPing.db.profile.RangeCheck 
							TomTomPing:Refresh() 
						end,
						order = 302,
					},
					shownodest = {
						type = 'toggle',
						name = L["Show Empty Destination"],
						desc = L["Show arrow when no destination is set"],
						get  = function() return TomTomPing.db.profile.ShowNoDest end,
						set  = function()
							TomTomPing.db.profile.ShowNoDest = not TomTomPing.db.profile.ShowNoDest
							TomTomPing:Refresh() 
						end,
						order = 303,
					},
				},
			},
		},
	}
end

function TomTomPing:OnInitialize()
	self.db = LibStub:GetLibrary("AceDB-3.0"):New(MODNAME.."_DB", defaults, "Default")
	self:SetupOptions()

	-- profile support
	options.args.profile = LibStub:GetLibrary("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied",  "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset",   "OnProfileChanged")

	AceConfigReg:RegisterOptionsTable(FULLNAME, options)
	AceConfigDialog:AddToBlizOptions(FULLNAME)

	self:RegisterChatCommand("tomtomping", "ChatCommand")
    self:RegisterChatCommand("ttp",        "ChatCommand")
end

function TomTomPing:OnEnable()
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "ZoneChanged")
	self:RegisterEvent("ZONE_CHANGED", "ZoneChanged")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChanged")
	
	if TomTomPing.db.profile.Ping then
		self:RegisterEvent("MINIMAP_PING", "OnEventPing")
	end
	if TomTomPing.db.profile.Messages then
		--self:RegisterEvent("CHAT_MSG_ADDON", "AddonChatMSG")
	end
	if TomTomPing.db.profile.Destination == "target" then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "SetDestination")
	elseif TomTomPing.db.profile.Destination == "focus" then
		self:RegisterEvent("PLAYER_FOCUS_CHANGED", "SetDestination")
	elseif TomTomPing.db.profile.Destination == "mouseover" then
	    -- unfortunately UPDATE_MOUSEOVER_UNIT only works to a distance of about 120 yards
		--self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "SetDestination")
		TomTomPing:ActivateOnUpdate(true)
	elseif TomTomPing.db.profile.Destination == "mouseoverclick" then
		TomTomPing:ActivateOnUpdate(true)
	end

	self:RegisterEvent("PARTY_CONVERTED_TO_RAID", "UpdateRaidUnits")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateRaidUnits")
	
	TomTomPing:ShowMinimapButton(TomTomPing.db.profile.Minimap)
	
	TomTomPing:SetupPlayer()
	TomTomPing:UpdateRaidUnits()
	
	TomTomPing:CheckTomTom()
	TomTomPing:ZoneChanged()
	
	self:ScheduleRepeatingTimer("UpdateLabel", 0.1)
end

function TomTomPing:OnDisable()
	self:UnregisterEvent("ZONE_CHANGED_INDOORS")
	self:UnregisterEvent("ZONE_CHANGED")
	
	if TomTomPing.db.profile.Ping then
		self:UnregisterEvent("MINIMAP_PING")
	end
	if TomTomPing.db.profile.Messages then
		--self:UnregisterEvent("CHAT_MSG_ADDON"")
	end

	if TomTomPing.db.profile.Destination == "target" then
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	elseif TomTomPing.db.profile.Destination == "focus" then
		self:UnregisterEvent("PLAYER_FOCUS_CHANGED")
	elseif TomTomPing.db.profile.Destination == "mouseover" then
		-- self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		TomTomPing:ActivateOnUpdate(false)
	elseif TomTomPing.db.profile.Destination == "mouseoverclick" then
		TomTomPing:ActivateOnUpdate(false)
	end

	self:UnregisterEvent("PARTY_CONVERTED_TO_RAID")
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
end

function TomTomPing:OnProfileChanged(event, database, newProfileKey)
	self.db.profile = database.profile
	
	self:Refresh()
end

function TomTomPing:Refresh()
	TomTomPing:PointNow()
end

function TomTomPing:UpdateLabel()
	local facing = GetPlayerFacing()
	local i = floor( facing * CRAD )	
	local label = strsub(compass, (36-i)+1, (36-i)+11)
	
	if i == 5 then
		label = gsub(label, "NW[-][-][-]N", "NW---"..Yellow("N"), 1)
	else
		label = gsub(label, "N[-]", Yellow("N").."-", 1)
	end

	dataobj.text = label
end

function TomTomPing:DrawTooltip()
	local colcount = tooltip:GetColumnCount()	

	-- module header
	local lineNum = tooltip:AddHeader( " " )
	tooltip:SetCell( lineNum, 1, White( FULLNAME ), "CENTER", tooltip:GetColumnCount() )
	tooltip:AddLine( " " )
	
	local dest = "none"
	local dist = "--"
	local type = destType.val2txt[self.db.profile.Destination]
	local ping = "--"
	
	if ttp_bSticky then
		dest = TomTomPing:ColorizeUnit(ttp_sDestName)
		dist = ttp_Distance
		type = "Sticky"
	elseif self.db.profile.Destination == "waypoint" then
		if ttp_Waypoint.x then
			dest = TomTomPing:PrecisionTxt(ttp_Waypoint.x, 2) .. ", " .. TomTomPing:PrecisionTxt(ttp_Waypoint.y, 2)
			dist = ttp_Distance
		end
	else -- if self.db.profile.Destination ~= "none" then
		if ttp_sDestName then
			dest = TomTomPing:ColorizeUnit(ttp_sDestName)
			dist = ttp_Distance
		end
	end
	
	if ttp_sPingerName then
		ping = TomTomPing:ColorizeUnit(ttp_sPingerName)
	end

	lineNum = tooltip:AddLine( " " )
	tooltip:SetCell( lineNum, 1, L["Destination"] .. ":",    "LEFT" )
	tooltip:SetCell( lineNum, 2, dest,  "LEFT" )

	lineNum = tooltip:AddLine( " " )
	tooltip:SetCell( lineNum, 1, L["Type"] .. ":",    "LEFT" )
	tooltip:SetCell( lineNum, 2, type,  "LEFT" )

	lineNum = tooltip:AddLine( " " )
	tooltip:SetCell( lineNum, 1, L["Distance"] .. ":",    "LEFT" )
	tooltip:SetCell( lineNum, 2, dist,  "LEFT" )
	
	tooltip:AddLine( " " )
	
	lineNum = tooltip:AddLine( " " )
	tooltip:SetCell( lineNum, 1, L["Last Ping"] .. ":",    "LEFT" )
	tooltip:SetCell( lineNum, 2, ping,  "LEFT" )

	-- And a hint to show options
	if not self.db.profile.HideHint then
		tooltip:AddLine( " " )

		lineNum = tooltip:AddLine( " " )		
		tooltip:SetCell( lineNum, 1, Brownish( L["Left-Click"] .. ": " ),        nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Set target as destination"] ), nil, "LEFT" )

		lineNum = tooltip:AddLine( " " )
		tooltip:SetCell( lineNum, 1, Brownish( L["Right-Click"] .. ": " ), nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Open options menu"] ),   nil, "LEFT" )
 
		lineNum = tooltip:AddLine( " " )
		tooltip:SetCell( lineNum, 1, Brownish( L["Ctrl-Left-Click"] .. ": " ),  nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Stick/unstick destination"] ), nil, "LEFT" )

		lineNum = tooltip:AddLine( " " )
		tooltip:SetCell( lineNum, 1, Brownish( L["Ctrl-Right-Click"] .. ": " ), nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Release arrow"] ),            nil, "LEFT" )

		lineNum = tooltip:AddLine( " " )
		tooltip:SetCell( lineNum, 1, Brownish( L["Shift-Left-Click"] .. ": " ), nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Ping at current location"] ), nil, "LEFT" )

		lineNum = tooltip:AddLine( " " )
		tooltip:SetCell( lineNum, 1, Brownish( L["Alt-Left-Click"] .. ": " ),           nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Set waypoint at current location"] ), nil, "LEFT" )

		lineNum = tooltip:AddLine( " " )
		tooltip:SetCell( lineNum, 1, Brownish( L["Alt-Right-Click"] .. ": " ), nil, "LEFT" )
		tooltip:SetCell( lineNum, 2, Yellow  ( L["Clear waypoint"] ),          nil, "LEFT" )
	end
end

function TomTomPing:ChatCommand(input)
	if not ttp_bTomTomOK then 
		TomTomPing:TomTomError()
	end
		
    if input then  
		args = GetArgs(input, "^ *([^%s]+) *")
		
		TomTomPing:TriggerAction(args[1])
	else
		TomTomPing:TriggerAction("help")
	end
	
end

function TomTomPing:OnClick(button)
    if ( button == "RightButton" ) then 
		if IsShiftKeyDown() then
			-- unused
		elseif IsControlKeyDown() then
			-- release arrow
			TomTomPing:TriggerAction("clear")
		elseif IsAltKeyDown() then
			-- clear waypoint
			TomTomPing:TriggerAction("waypointclear")
		else
			-- open options menu
			TomTomPing:TriggerAction("menu")
		end
	elseif ( button == "LeftButton" ) then 
		if IsShiftKeyDown() then
			-- ping at self
			TomTomPing:TriggerAction("ping")
		elseif IsControlKeyDown() then
			-- (un)stick destination
			TomTomPing:TriggerAction("stick")
		elseif IsAltKeyDown() then
			-- set waypoint at self
			TomTomPing:TriggerAction("waypointself")
		else
			-- target as destination
			TomTomPing:TriggerAction("target")
		end
	end
end

function TomTomPing:TriggerAction(action)
	if action == "target" then
		-- target as destination
		ttp_sDestName = UnitName("target")
		ttp_sDestUnit = TomTomPing:GetRaidUnitByName(ttp_sDestName)
		if TomTomPing.db.profile.Destination == "waypoint" or
		   TomTomPing.db.profile.Destination == "mouseover" then
			if ttp_sDestUnit then
				ttp_bSticky = true
			end
		end
		TomTomPing:Refresh()
	elseif action == "stick" then
		-- (un)stick destination
		TomTomPing:ToggleSticky()
	elseif action == "clear" then
		-- release arrow
		TomTomPing:Release()
	elseif action == "ping" then
		-- ping at self
		TomTomPing:Ping()
	elseif action == "waypointself" or action == "waypoint" or action == "way" then
		-- set waypoint at self
		TomTomPing:SetWaypointOnSelf()
	elseif action == "waypointclear" or action == "wpclear" or action == "wayclear" then
		-- clear waypoint
		TomTomPing:ClearWaypoint()
	elseif action == "measure" then
		-- init map size measurement
		TomTomPing:Measure()
	elseif action == "menu" then
		-- open options menu
		InterfaceOptionsFrame_OpenToCategory(FULLNAME)
	elseif action == "version" then
		-- print version information
		TomTomPing:PrintVersionInfo()
	else -- if action == "help" then
		-- display help
		Output(L["Usage:"])
		Output(L["/tomtomping arg"])
		Output(L["/ttp arg"])
		Output(L["Args:"])
		Output(L["target - use current target as arrow target"])
		Output(L["stick - make current arrow target sticky"])
		Output(L["clear - release the crazy arrow"])
		Output(L["ping - ping on self"])
		Output(L["waypoint - set waypoint on self"])
		Output(L["wpclear - clear waypoint"])
		Output(L["measure - init map size measurement (Move at least 20 yards!)"])
		Output(L["version - display version information"])
		Output(L["menu - display options menu"])
		Output(L["help - display this help"])
	end
end

-- setup functions
function TomTomPing:CheckTomTom()
    if IsAddOnLoaded("TomTom") then		
        local TomTomRev = 001
		
        TomTomVersion = GetAddOnMetadata("TomTom", "X-Curse-Packaged-Version")
        if not TomTomVersion then
            TomTomVersion = GetAddOnMetadata("TomTom", "Version")
        end
        if TomTomVersion then
            numx = strfind(TomTomVersion, '%d')
            if numx > 0 then
                TomTomRev = tonumber(strsub(TomTomVersion, numx, numx + 2))
                Output(L["Found TomTom: "] .. TomTomVersion)
            end
        end
        if TomTomRev < 216 then
			ttp_bTomTomOK = false
			ttp_sTomTomErrorMsg = L["+++ TomTom outdated +++\nYou have to install TomTom Version 216\nor higher to run TomTomPing\nYours is: "] .. tostring(TomTomRev)
			TomTomPing:TomTomError()
        else
			ttp_bTomTomOK = true
            Output(L["TomTom OK"])
        end 
    else
		ttp_bTomTomOK = false
		ttp_sTomTomErrorMsg = L["+++ TomTom missing +++\nYou have to install TomTom to run TomTomPing!"]
		TomTomPing:TomTomError()
    end  
end

function TomTomPing:TomTomError()
    Output(ttp_sTomTomErrorMsg)
end

function TomTomPing:SetupPlayer()
	_, ttp_sPlayerClass = UnitClass("player")
	ttp_sPlayerName     = UnitName("player")
	
	if ttp_sPlayerClass == "DRUID" or 
	   ttp_sPlayerClass == "PRIEST" or
	   ttp_sPlayerClass == "PALADIN" or 
	   ttp_sPlayerClass == "SHAMAN" then 
		ttp_bPlayerIsHealer = true
		ttp_iHealSpellName = ttp_HealSpells[ttp_sPlayerClass]
		ttp_iRezSpellName  = ttp_RezSpells[ttp_sPlayerClass]
	end
end

-- settings
function TomTomPing:TogglePing()	
	TomTomPing.db.profile.Ping = not TomTomPing.db.profile.Ping
	
	if TomTomPing.db.profile.Ping then
		self:RegisterEvent("MINIMAP_PING", "OnEventPing")
	else
		self:UnregisterEvent("MINIMAP_PING")
	end	
end

function TomTomPing:ToggleMessages()	
	TomTomPing.db.profile.Messages = not TomTomPing.db.profile.Messages
	
	if TomTomPing.db.profile.Messages then
		self:RegisterEvent("CHAT_MSG_ADDON", "AddonChatMSG")
	else
		self:UnregisterEvent("CHAT_MSG_ADDON")
	end	
end

function TomTomPing:SetDestinationType(dest)
	if TomTomPing.db.profile.Destination == dest then
		return
	end
	
	if TomTomPing.db.profile.Destination == "target" then
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	elseif TomTomPing.db.profile.Destination == "focus" then
		self:UnregisterEvent("PLAYER_FOCUS_CHANGED")
	elseif TomTomPing.db.profile.Destination == "mouseover" then
	    -- unfortunately UPDATE_MOUSEOVER_UNIT only works to a distance of about 120 yards
		-- self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		TomTomPing:ActivateOnUpdate(false)
	elseif TomTomPing.db.profile.Destination == "mouseoverclick" then
		TomTomPing:ActivateOnUpdate(false)
	end

	TomTomPing.db.profile.Destination = dest
	
	if TomTomPing.db.profile.Destination == "target" then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "SetDestination")
	elseif TomTomPing.db.profile.Destination == "focus" then
		self:RegisterEvent("PLAYER_FOCUS_CHANGED", "SetDestination")
	elseif TomTomPing.db.profile.Destination == "mouseover" then
		-- self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "SetDestination")
		TomTomPing:ActivateOnUpdate(true)
	elseif TomTomPing.db.profile.Destination == "mouseoverclick" then
		TomTomPing:ActivateOnUpdate(true)
	end
	
	TomTomPing:SetDestination()
end

-- event callbacks
function TomTomPing:ZoneChanged()
	local lastCont, lastZone = GetCurrentMapContinent(), GetCurrentMapZone()
	
	SetMapToCurrentZone()
	
    ttp_ActMap     = GetMapInfo()
    ttp_DungeonLvl = GetCurrentMapDungeonLevel()

	--set map zoom back to what it was before
	SetMapZoom(lastCont, lastZone)

    TomTomPing:CheckIndoors()

	ttp_RefPoint = nil

	TomTomPing:Refresh()
end

function TomTomPing:UpdateRaidUnits()
	ttp_Name2Unit = {}
	
	if GetNumRaidMembers() > 0 then
		for i = 1, 40, 1 do
			local unit = "raid"..i
			local name = UnitName(unit)
			
			if name then
				ttp_Name2Unit[name] = unit
			end
		end
	elseif GetNumPartyMembers() > 0 then
		for i = 1, 4, 1 do
			local unit = "party"..i
			local name = UnitName(unit)
			
			if name then
				ttp_Name2Unit[name] = unit
			end
		end
	end

	ttp_Name2Unit[ttp_sPlayerName] = "player"
	
	ttp_sDestUnit = TomTomPing:GetRaidUnitByName(ttp_sDestName)

	TomTomPing:Refresh()
end

function TomTomPing:SetDestination()
	if ttp_bSticky then
		return
	end
	
	local unit = nil
	local name = nil
	local down = IsMouseButtonDown()
	
	if strsub(TomTomPing.db.profile.Destination, 1, 9) == "mouseover" then
		if TomTomPing.db.profile.Destination ~= "mouseoverclick" or down then
			unit = TomTomPing:GetMouseOverUnit()
		end
	else
		unit = TomTomPing.db.profile.Destination
	end

	if TomTomPing:UnitIsValid(unit) then
		name = UnitName(unit)
	end
	
	unit = TomTomPing:GetRaidUnitByName(name)
	
	-- mouseover* refreshes OnUpdate, make sure we keep the work low
	if TomTomPing.db.profile.Destination ~= "mouseoverclick" or down then
		if unit ~= ttp_sDestUnit then
			ttp_sDestUnit = unit
			ttp_sDestName = name
	
			TomTomPing:Refresh() 
		end
	end
end

-- user functions
function TomTomPing:ToggleSticky()
	-- if there is no destination we don't make it sticky
	if not ttp_bSticky and not ttp_sDestUnit then
		return
	end

	ttp_bSticky = not ttp_bSticky
	
	TomTomPing:SetDestination()
	
	TomTomPing:Refresh()
end

function TomTomPing:Release()
    ttp_bCAPingActive = false
	ttp_sDestName = nil
	ttp_sDestUnit = nil
	ttp_bSticky   = false
    TomTomPing:ReleaseCrazyArrow()
end

function TomTomPing:Ping()
    Minimap:PingLocation(0, 0)
end

function TomTomPing:Measure()
    local c, z, x, y = Astrolabe:GetCurrentPlayerPosition()
	
	if x == nil or y == nil then
		Output(L["No map coordinates present for this instance! Aborting measurement."])
		return
	end
	
	ttp_RefPoint = {}
	
	ttp_RefPoint.c = c
	ttp_RefPoint.z = z 
	ttp_RefPoint.x = x
	ttp_RefPoint.y = y
	
    TomTomPing:Ping()
end

function TomTomPing:SetWaypointOnSelf()
    ttp_Waypoint["c"], ttp_Waypoint["z"], ttp_Waypoint["x"], ttp_Waypoint["y"] = Astrolabe:GetCurrentPlayerPosition()
	
    if ttp_Waypoint["c"] == nil or ttp_Waypoint["z"] == nil then 
		ttp_Waypoint["c"] = -1
		ttp_Waypoint["z"] =  0
	end
	
    ttp_Waypoint["map"] = ttp_ActMap
    ttp_Waypoint["lvl"] = ttp_DungeonLvl

	TomTomPing:Refresh()
end

function TomTomPing:ClearWaypoint()
    ttp_Waypoint = {}

	TomTomPing:Refresh()
end

function TomTomPing:PrintVersionInfo()
    Output(L["Version"] .. " " .. White(GetAddOnMetadata(MODNAME, "Version")))
end

-- auxillary functions	
function TomTomPing:PrecisionTxt(input, digits)
    return string.format("%." .. digits .. "f", input) 
end

function TomTomPing:CheckIndoors()
	local curZoom = Minimap:GetZoom()
	
	if ( GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") ) then
		if ( curZoom < 2 ) then 
			Minimap:SetZoom(curZoom + 1)
		else 
			Minimap:SetZoom(curZoom - 1)
		end
	end
	
	if ( GetCVar("minimapZoom")+0 == Minimap:GetZoom() ) then 
		ttp_bIndoors = false
    else 
		ttp_bIndoors = true
	end
	
	Minimap:SetZoom(curZoom)
	
	return ttp_bIndoors
end

function TomTomPing:UnitIsValid(unit)
    return UnitInRaid(unit) or UnitInParty(unit)
end

function TomTomPing:GetRaidUnitByName(name)
	return ttp_Name2Unit[name] or nil
end

function TomTomPing:ColorizeUnit(unit)
	if UnitIsPlayer(unit) and UnitIsFriend("player", unit) then
		local _, class = UnitClass(unit)
		local color = RAID_CLASS_COLORS[class]
		return "|cff" .. string.format("%02x%02x%02x", color.r*255, color.g*255, color.b*255) .. unit .. "|r"
	else
		return Red(unit)
	end
end

function TomTomPing:GetMouseOverUnit()
	local frame = GetMouseFocus()
	if frame then
		local unit = SecureButton_GetModifiedUnit(frame)
		
		if unit and TomTomPing:UnitIsValid(unit) then
			return unit
		end
	end
	
	return nil
end

-- pointing functions
function TomTomPing:OnEventPing(event, unit) 
    ttp_sPingerName = UnitName(unit)
	
    if not ttp_sPingerName then 
		return
	end
	
	-- somebody else pinged and messed up our measurement
    if ttp_sPingerName ~= ttp_sPlayerName then 
		ttp_RefPoint = nil
	end
	
	if not ttp_bTomTomOK then
		return
	end

    if TomTom:CrazyArrowIsHijacked() then 
		TomTomPing:ReleaseCrazyArrow()
	end
	
    totalelapsed = 0
    local minirotate = GetCVar("rotateMinimap") ~= "0"

    if not TomTom:CrazyArrowIsHijacked() then
        TomTomPing:PrepareHijack()
		-- hijack
		TomTom:HijackCrazyArrow( function(self, elapsed)
			ttp_bCAPingActive = true
			totalelapsed = totalelapsed + elapsed
			if totalelapsed > TomTomPing.db.profile.Duration then
				ttp_bCAPingActive = false
				TomTomPing:ReleaseCrazyArrow()
				TomTomPing:Refresh()
				return
			end
		
			local facing
			if minirotate then 
				facing = 0
			else 
				facing = GetPlayerFacing() 
			end
		
			local dx, dy = Minimap:GetPingPosition()
		
			local angle = atan2(dx, dy)
		
			if angle < 0 then 
				angle = angle * -1
			else
				angle = TWOPI - angle
			end
		
			dirx = angle - facing 
		
			local dist     = sqrt(dx * dx + dy * dy)
			local zoom     = Minimap:GetZoom()		
			local realdist = dist * TomTomPing:GetMinimapSize(zoom)
		
			-- measure map if requested
			if ttp_RefPoint and realdist > 20 then
				TomTomPing:CalculateMapSize()
			end

			if realdist > TomTomPing.db.profile.ArrivalRange then 
				TomTomPing:SetCrazyArrowColor(dirx)
			else 
				TomTom:SetCrazyArrowColor(0, 1, 0)
			end

			TomTomPing:CrazyArrowShowNorm(realdist > TomTomPing.db.profile.ArrivalRange, dirx)
		
			realdist = TomTomPing:PrecisionTxt(realdist, TomTomPing.db.profile.RangePrecision) .. " " .. L["yards"]
        
			local comment = TomTomPing:PrecisionTxt(totalelapsed, TomTomPing.db.profile.TimePrecision) .. L["s"]
		
			TomTom:SetCrazyArrowTitle(L["Ping: "] .. ttp_sPingerName, realdist, comment)
			
		end)  
		-- hijack end

    end   
end 

function TomTomPing:PointNow()
    local tarC = {}

	if not ttp_bTomTomOK or ttp_bCAPingActive then
		return
	end
	
    if TomTom:CrazyArrowIsHijacked() then 
		TomTomPing:ReleaseCrazyArrow()
	end

	if TomTomPing.db.profile.Destination == "waypoint" then
		if not ttp_Waypoint.x then
			return
		end
	else
		if ttp_sDestUnit == nil then
			if not TomTomPing.db.profile.ShowNoDest or TomTomPing.db.profile.Destination == "none" then
				return
			end
		end
	end
	
    if not TomTom:CrazyArrowIsHijacked() then                       
        TomTomPing:PrepareHijack()
		-- hijack
        TomTom:HijackCrazyArrow(function(self, elapsed)
			local bHealRange = true
			local plC = {}
			plC.c, plC.z, plC.x, plC.y = Astrolabe:GetCurrentPlayerPosition()
			if (plC.c == nil ) or (plC.z == nil ) then 
				plC.c = -1
				plC.z = 0
			end

			local CA_Text = destType.val2txt[TomTomPing.db.profile.Destination]
			
			if ttp_bSticky then
				CA_Text = L["Sticky"]
			end
		
			local bDestIsWay = TomTomPing.db.profile.Destination == "waypoint"

			if not ttp_bSticky and bDestIsWay == true then
				tarC    = ttp_Waypoint
			else
				if ttp_sDestUnit ~= nil then
					CA_Text = CA_Text .. ": " .. ttp_sDestName

					tarC.c, tarC.z, tarC.x, tarC.y = Astrolabe:GetUnitPosition( ttp_sDestUnit, false )
					if not tarC.c or not tarC.z then 
						tarC.c = -1
						tarC.z = 0
					end
				
					bHealRange = TomTomPing:HealRange(ttp_sDestUnit)
				else 
					tarC.x = nil
					tarC.y = nil
					CA_Text = L["no target"]
					
					if not TomTomPing.db.profile.ShowNoDest or TomTomPing.db.profile.Destination == "none" then
						TomTomPing:ReleaseCrazyArrow()
					end

				end
			end

			if ( (not tarC.x or not tarC.y or not plC.x or not plC.y) or (tarC.x == 0 and tarC.y == 0) ) then
				TomTomCrazyArrow:SetAlpha(0.5)
				TomTomPing:ErrorArrow(CA_Text, L["no coords"], "")
				return
			else 
				TomTomCrazyArrow:SetAlpha(1)
			end
        
			local bAstro = (plC.c >= 0 and plC.z >= 0 and tarC.c >= 0 and tarC.z >= 0) 
			local realdist, dx, dy, bRangeCalc = TomTomPing:GetDistance(bAstro, plC, tarC)
			if not bAstro then
				if bDestIsWay == true then
					if ttp_ActMap ~= ttp_Waypoint["map"] or ttp_DungeonLvl ~= ttp_Waypoint["lvl"] then 
						TomTomPing:ErrorArrow(CA_Text, L["no coords"], L["other zone"])
						return
					end
				end       
			end
              		
			local angle = atan2(dx, -dy)
			if angle > 0 then 
				angle = TWOPI - angle
			else 
				angle = -angle
			end
                   
			local direction = angle - GetPlayerFacing()
			local CA_DisplayRange
			local bCAShowUp

			bCAShowUp = realdist > TomTomPing.db.profile.ArrivalRange or not bRangeCalc
			CA_DisplayRange = realdist
			if bHealRange then 
				if realdist > TomTomPing.db.profile.ArrivalRange then 
					TomTomPing:SetCrazyArrowColor(direction)
				else 
					TomTom:SetCrazyArrowColor(0, 1, 0)
				end
			else 
				TomTomPing:SetCrazyArrowOutRangeColor(direction) 
			end
			TomTomPing:CrazyArrowShowNorm(bCAShowUp, direction)

			local CA_Comment =  ""

			if bRangeCalc then 
				local speed = GetUnitSpeed("player")
			
				if speed > 0 then 
					CA_Comment = TomTomPing:PrecisionTxt(realdist / speed, TomTomPing.db.profile.TimePrecision) .. L["s"]
				else 
					CA_Comment = "***"
				end

				CA_DisplayRange = TomTomPing:PrecisionTxt(CA_DisplayRange, TomTomPing.db.profile.RangePrecision) .. " " .. L["yards"]
			else
				CA_Comment = L["NO RANGE DATA FOUND\nType '/ttp measure' and then move 20 yards"] 
			end
		
			ttp_Distance = CA_DisplayRange
		
			TomTom:SetCrazyArrowTitle(CA_Text, CA_DisplayRange, CA_Comment)
		end) 
		-- hijack end
    end        
end

-- distance related functions
function TomTomPing:GetMinimapSize(zoom)
	if ttp_bIndoors then
		return MinimapSize["indoor"][zoom]
	else
		return MinimapSize["outdoor"][zoom]
	end
end

function TomTomPing:GetDistance(bAstro, plC, tarC)
    if (bAstro) then
        local realdist, dx, dy = Astrolabe:ComputeDistance( plC.c, plC.z, plC.x, plC.y, tarC.c, tarC.z, tarC.x, tarC.y )
        
        return realdist, dx, dy, true
    else
		local xDim, yDim = TomTomPing:GetMapDimensions()
		
        local dx = (tarC.x - plC.x) * xDim
        local dy = (tarC.y - plC.y) * yDim
		
        local realdist = sqrt(dx * dx + dy * dy)
		
		return realdist, dx, dy, yDim ~= 1.0
    end   
    
end

function TomTomPing:GetMapDimensions()
	local xDim, yDim = 1.5, 1.0
	
	if ttp_ZoneDimensions[ttp_ActMap] or TomTomPing.db.global.ZoneDimensions[ttp_ActMap] then
		if ttp_ZoneDimensions[ttp_ActMap] and ttp_ZoneDimensions[ttp_ActMap][ttp_DungeonLvl] then
			xDim = ttp_ZoneDimensions[ttp_ActMap][ttp_DungeonLvl][1]
			yDim = ttp_ZoneDimensions[ttp_ActMap][ttp_DungeonLvl][2]
		elseif TomTomPing.db.global.ZoneDimensions[ttp_ActMap] and TomTomPing.db.global.ZoneDimensions[ttp_ActMap][ttp_DungeonLvl] then
			xDim = TomTomPing.db.global.ZoneDimensions[ttp_ActMap][ttp_DungeonLvl][1]
			yDim = TomTomPing.db.global.ZoneDimensions[ttp_ActMap][ttp_DungeonLvl][2]
		end
	end
	
    return xDim, yDim
end

-- dist(travelled) = (coord_stop(minimap) - coord_start(minimap)) * dimension(minimap)
-- dimension(map)  = dist(travelled) / (coord_stop(map) - coord_start(map))
function TomTomPing:CalculateMapSize()
    if not ttp_RefPoint then 
		Output(L["No reference point set. Please retry measurement."])
		return
	end
	
	-- current minimap ping position 
	-- we started out at ping on self (0, 0) 
	-- distance in terms of minimap coords
    local dx_mini, dy_mini = Minimap:GetPingPosition()
	
    local c, z, x, y = Astrolabe:GetCurrentPlayerPosition()
	
	-- distance in terms of global coords
    local dx_glob = ttp_RefPoint.x - x
    local dy_glob = ttp_RefPoint.y - y
	
    if dx_mini == 0 and dy_mini == 0 then 
        Output(L["No range calculation. You have to move first!"])
        return
    end
	
    local xDim, yDim
    local minimapsize = TomTomPing:GetMinimapSize( Minimap:GetZoom() )
	
	-- calculate map dimension
	-- we use the direction we travelled farther
	if abs(dx_mini) > abs(dy_mini) then
		xDim = abs((dx_mini * minimapsize)/dx_glob) 
		-- adjust aspect ratio
		yDim = xDim / 1.5
	else
		yDim = abs((dy_mini * minimapsize)/dy_glob)
		-- adjust aspect ratio
		xDim = yDim * 1.5
	end
	
	-- save calculated dimensions
	if not TomTomPing.db.global.ZoneDimensions[ttp_ActMap] then
		TomTomPing.db.global.ZoneDimensions[ttp_ActMap] = {}
	end
	
	TomTomPing.db.global.ZoneDimensions[ttp_ActMap][ttp_DungeonLvl] = { xDim, yDim }
	
	Output(string.format(L["Map dimensions stored for %s[%i]: x, y = %f, %f"], ttp_ActMap, ttp_DungeonLvl, xDim, yDim) )
	
	-- reset reference point
	ttp_RefPoint = nil
end

function TomTomPing:HealRange(target)
    if not TomTomPing.db.profile.RangeCheck or not ttp_bPlayerIsHealer then 
		return true
	end
	
    local iSpellName = ttp_iHealSpellName
	
    if UnitIsDead(target) then 
		iSpellID = ttp_iRezSpellName
	end
	
    if IsSpellInRange(iSpellName, target) == 1 then 
		return true
    else 
		return false
    end
end

-- Crazy Arrow functions
function TomTomPing:PrepareHijack()
    ttp_sLastArrowText = TomTomCrazyArrow.title:GetText()
	
    if(strfind(TomTomCrazyArrow.arrow:GetTexture(), "UP")) then 
		ttp_bArrowWasNorm = false
    else 
		ttp_bArrowWasNorm = true
	end
	
    ttp_bShowDownArrow = true
    TomTomPing:CrazyArrowShowNorm(true)
end

function TomTomPing:CrazyArrowShowNorm(show_norm, angle)
	local cell
	if not show_norm then
		if not ttp_bShowDownArrow then
			TomTomCrazyArrow.arrow:SetHeight(70)
			TomTomCrazyArrow.arrow:SetWidth(53)
			TomTomCrazyArrow.arrow:SetTexture("Interface\\AddOns\\TomTom\\Images\\Arrow-UP")
			ttp_bShowDownArrow = true
		end
		
		ttp_iClrCount = ttp_iClrCount + 1
		if ttp_iClrCount >= 55 then
			ttp_iClrCount = 0
		end
		
		cell = ttp_iClrCount
		local column = cell % 9
		local row = floor(cell / 9)
		local xstart = (column * 53) / 512
		local ystart = (row * 70) / 512
		local xend = ((column + 1) * 53) / 512
		local yend = ((row + 1) * 70) / 512
		
		TomTomCrazyArrow.arrow:SetTexCoord(xstart, xend, ystart, yend)
	else
		if ttp_bShowDownArrow then
			TomTomCrazyArrow.arrow:SetHeight(56)
			TomTomCrazyArrow.arrow:SetWidth(42)
			TomTomCrazyArrow.arrow:SetTexture("Interface\\AddOns\\TomTom\\Images\\Arrow")
			ttp_bShowDownArrow = false
		end
		
		if not angle then 
			angle = 0 
		end
		cell = floor(angle / TWOPI * 108 + 0.5) % 108
		local column = cell % 9
		local row = floor(cell / 9)
		local xstart = (column * 56) / 512
		local ystart = (row * 42) / 512
		local xend = ((column + 1) * 56) / 512
		local yend = ((row + 1) * 42) / 512
		
		TomTomCrazyArrow.arrow:SetTexCoord(xstart, xend, ystart, yend)		
	end
end

function TomTomPing:SetCrazyArrowColor(dirx)
	local perc = abs((PI - abs(dirx)) / PI)
    local g = 1
    local r = 0
	
    if perc > 0.5 then
      g = 1
      r = perc * -2 + 2
    else
      r = 1
      g = perc * 2
    end
	
    TomTom:SetCrazyArrowColor(r, g, 0)
end

function TomTomPing:SetCrazyArrowOutRangeColor(dirx)
	local perc = abs((PI - abs(dirx)) / PI)
    local g = 0
    local r = 0
    local b = 1
	
    r = perc * -2 + 2
    TomTom:SetCrazyArrowColor(r, g, b)
end

function TomTomPing:SetCrazyArrowAlertColor()
    if ttp_bAlertPulseOn then
        if ttp_iAlertHue <= 1 then 
			ttp_iAlertHue = ttp_iAlertHue + 0.1
        else 
			ttp_bAlertPulseOn = false
		end
    else
        if ttp_iAlertHue >= 0 then 
			ttp_iAlertHue = ttp_iAlertHue - 0.1
        else 
			ttp_bAlertPulseOn = true
		end
    end
	
    TomTom:SetCrazyArrowColor(1, ttp_iAlertHue, 0)
end

function TomTomPing:ErrorArrow(line1, line2, line3)
    TomTom:SetCrazyArrowColor(0.5, 0.5, 0.5)
    TomTomPing:CrazyArrowShowNorm(false)
    TomTom:SetCrazyArrowTitle(line1, line2, line3)
end

function TomTomPing:ReleaseCrazyArrow()
    ttp_bShowDownArrow = ttp_bArrowWasNorm
    TomTomPing:CrazyArrowShowNorm(ttp_bArrowWasNorm)
	
    TomTomCrazyArrow.title:SetText(ttp_sLastArrowText)
    TomTom:ReleaseCrazyArrow()
end

