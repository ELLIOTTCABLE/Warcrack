--[[
************************************************************************
Project				: Broker_Factions
Author				: torhal
Project Revision	: 3.2.6-release
Project Date		: 20111012085757

File				: Broker_Factions.lua
Commit Author		: zhinjio
Commit Revision		: 18
Commit Date			: 20110515000702
************************************************************************
Description	:
	Main addon file. 

TODO		:


CREDITS		: Taken over from Tristanian on WoWI. Based on ideas by Titan
Factions (Phanx) and FactionsFu (Elkano), Thanks to both of them
************************************************************************
(see bottom of file for changelog)
************************************************************************
--]]

local MODNAME = "BFactions"
local FULLNAME = "Broker_Factions"

local BFactions = LibStub( "AceAddon-3.0" ):NewAddon( MODNAME, "AceEvent-3.0" )
local L = LibStub:GetLibrary( "AceLocale-3.0" ):GetLocale( MODNAME )
local AceConfig 		= LibStub("AceConfig-3.0")
local AceConfigReg 		= LibStub("AceConfigRegistry-3.0")
local AceConfigDialog 	= LibStub("AceConfigDialog-3.0")

local addonversion = GetAddOnMetadata( FULLNAME, "Version" )
addonversion = string.gsub( addonversion, "@project.version@", " - Development" )
local addonauthor = "torhal"
local builddate = "20111012085757"

local _G = getfenv(0)
_G["BFactions"] = BFactions
local addon = BFactions
local db

local modularOptions = {}
local tooltip
local QT		= LibStub:GetLibrary( "LibQTip-1.0" )
local LDBIcon	= LibStub("LibDBIcon-1.0")

local standingTitle = {
	[1] = "|cff8b0000".._G["FACTION_STANDING_LABEL1"].."|r",	-- Hated
	[2] = "|cffff1919".._G["FACTION_STANDING_LABEL2"].."|r",	-- Hostile
	[3] = "|cffff8C00".._G["FACTION_STANDING_LABEL3"].."|r",	-- Unfriendly
	[4] = "|cffc0c0c0".._G["FACTION_STANDING_LABEL4"].."|r",	-- Neutral
	[5] = "|cffffffff".._G["FACTION_STANDING_LABEL5"].."|r",	-- Friendly
	[6] = "|cff19ff19".._G["FACTION_STANDING_LABEL6"].."|r",	-- Honored
	[7] = "|cff4169e1".._G["FACTION_STANDING_LABEL7"].."|r",	-- Revered
	[8] = "|cff9932cc".._G["FACTION_STANDING_LABEL8"].."|r",	-- Exalted
}
local gotSRep = false

--[[ old locals
local tt = nil
local isPEW = nil
local FactionID = {}
local FactionList = {}
local headers = {}
local FactionDataLabel = ""
local totaltime = 0
local returnarg = {} ]]-- end old locals
local startingRep = {}
local FactionIcon = "Interface\\Icons\\INV_Misc_TabardPVP_03"

function addon.Print( msg )
	local _, fh = DEFAULT_CHAT_FRAME:GetFont()
	fh = math.ceil( fh )
	local icon = "\124T" .. FactionIcon .. ":" .. fh .. "\124t"
	if ( msg ~= nil ) then
	   if( DEFAULT_CHAT_FRAME ) then
	      DEFAULT_CHAT_FRAME:AddMessage( icon .. " " .. MODNAME .. " : " .. msg, 0.6, 1.0, 1.0 )
	   end
	end
end

function addon.Debug( msg )
	if ( msg ~= nil ) then
		if ( db.options.display.debug ) then
			addon.Print( "DEBUG: " .. msg )
		end
	end
end

-- coloring functions for tooltip text
local function Red( text )		return "|cffff0000" .. text .. "|r" end
local function Orange( text )	return "|cffdea51c" .. text .. "|r" end
local function Yellow( text )	return "|cffffff00" .. text .. "|r" end
local function Green( text )	return "|cff00ff00" .. text .. "|r" end
local function White( text )	return "|cffffffff" .. text .. "|r" end
local function Cyan( text)		return "|cff00ffff" .. text .. "|r" end

local function BFactions_MouseHandler( cell, argString, button )
	local _, _, expand, entry = string.find( argString, '(%d+)~~~(%d+)' )
	addon.Debug( "expand=" .. expand .. " entry=" .. entry )
	expand = expand + 0
	entry = entry + 0
	if ( expand == 0 ) then
		CollapseFactionHeader( entry )
	elseif ( expand == 1 ) then
		ExpandFactionHeader( entry )
	else -- expand == 2
		local name = GetFactionInfo( entry )
		db.options.text.watchedFaction = name
	end
	addon.drawTooltip()
	tooltip:Show()
	addon.updateText()
end

function addon:drawTooltip()
	local plusIcon = "|TInterface\\MINIMAP\\UI-Minimap-ZoomInButton-Up:16:16:1:0|t"
	local minusIcon = "|TInterface\\MINIMAP\\UI-Minimap-ZoomOutButton-Up:16:16:1:0|t"
	local dbod = db.options.display

	tooltip:Hide()
	tooltip:Clear()

--	zoomicon name reptitle session raw percent remaining
	local t = {}
	local numCols = 3
	t[1] = "LEFT"
	t[2] = "LEFT"
	t[3] = "CENTER"
	if ( dbod.showSessionGains ) then numCols = numCols + 1; table.insert( t, "RIGHT" ) end
	if ( dbod.showRawValues ) then numCols = numCols + 1; table.insert( t, "RIGHT" ) end
	if ( dbod.showPercentage ) then numCols = numCols + 1; table.insert( t, "RIGHT" ) end
	if ( dbod.showRemainingRep ) then numCols = numCols + 1; table.insert( t, "RIGHT" ) end
	tooltip:SetColumnLayout( numCols, unpack( t ) )
	
	local headerTitle = FULLNAME
	local lineNum = tooltip:AddHeader( "b" )
	tooltip:SetCell( lineNum, 1, headerTitle, "CENTER", numCols )
	tooltip:AddLine( " " )
	t = nil; t = {}
	t[1] = " "
	t[2] = L["Faction"]
	t[3] = L["Rep"]
	local index = 4
	if ( dbod.showSessionGains ) then table.insert( t, L["Session"] ); index = index + 1 end
	if ( dbod.showRawValues ) then table.insert( t, L["Values"] ); index = index + 1 end
	if ( dbod.showPercentage ) then table.insert( t, " " ); index = index + 1  end
	if ( dbod.showRemainingRep ) then table.insert( t, L["Remaining"] ); index = index + 1 end
	tooltip:AddHeader( unpack( t ) )
	
	local numFactions = GetNumFactions()
	for i = 1, numFactions do
		t = nil; t = {}
		local showNums = true
		local cIcon = " "
		local sGain = " "
		local indent = ""
		local hideEntry = false
		local name, _, standingID, barMin, barMax, barValue, _, _,
			isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo( i )
		if ( isHeader == 1 ) then
			-- header
			if ( hasRep ~= 1 ) then
				showNums = false
			else
				if ( ( standingID == 8 ) and ( db.options.display.hideExalted == true ) ) then
					hideEntry = true
				end
			end
			if ( isChild == 1 ) then
				-- sub-group
				indent = Orange( "    " .. name ) 
			else
				indent = White( name )
			end
			if ( isCollapsed == 1 ) then
				if ( db.options.display.showCollapsedHeaders == false ) then
					hideEntry = true
				end
				cIcon = plusIcon
			else
				cIcon = minusIcon
			end
		else
			if ( isChild == 1 ) then
				-- sub-group
				indent = Yellow( "        " .. name ) 
			else
				indent = Yellow( "    " .. name )
			end
			if ( ( standingID == 8 ) and ( db.options.display.hideExalted == true ) ) then
				hideEntry = true
			end
		end
		if ( startingRep[ name ] ~= nil ) then
			local delta = barValue - startingRep[name]
			if ( delta ~= 0 ) then
				sGain = Cyan( "+" .. delta )
			end
		end
		if ( ( name ~= L["Inactive"] ) and
			 ( IsFactionInactive( i ) ~= 1 ) and
			 ( hideEntry == false ) ) then
			t[1] = cIcon
			t[2] = indent
			index = 3
			if ( showNums == true ) then
				t[3] = standingTitle[standingID]
				if ( dbod.showSessionGains ) then table.insert( t, sGain ); index = index + 1 end
				if ( dbod.showRawValues ) then
					local insVal = ( barValue - barMin ) .. " / " .. ( barMax - barMin )
					if ( barValue < 0 ) then
						insVal = Red( ( 0 - ( barMin - barValue ) ) .. " / " .. ( 0 - ( barMin - barMax ) ) )
					end
					table.insert( t, insVal )
					index = index + 1
				end
				if ( dbod.showPercentage ) then
					local numStr = math.floor( ( ( barValue - barMin ) / ( barMax - barMin ) ) * 100 ) .. "%"
					if ( barValue < 0 ) then
						numStr = math.floor( ( 0 - ( barMin - barValue ) ) / ( 0 - ( barMin - barMax ) ) * 100 ) .. "%"
					end
					table.insert( t, Yellow( numStr ) )
					index = index + 1
				end
				if ( dbod.showRemainingRep ) then
					if ( barValue < 0 ) then
						table.insert( t, Red( barMax - barValue ) )
					else
						table.insert( t, Green( barMax - barValue ) )
					end
					index = index + 1
				end
			else
				t[3] = " "
				if ( dbod.showSessionGains ) then table.insert( t, " " ); index = index + 1 end
				if ( dbod.showRawValues ) then	table.insert( t, " " ); index = index + 1 end
				if ( dbod.showPercentage ) then table.insert( t, " " ); index = index + 1 end
				if ( dbod.showRemainingRep ) then table.insert( t, " " ); index = index + 1 end
			end
			lineNum = tooltip:AddLine( unpack( t ) )
			addon.Debug( "cIcon = >>" .. cIcon .. "<<" )
			local args = ""
			if ( cIcon ~= " " ) then
				if ( cIcon == plusIcon ) then
					args = "1~~~" .. i 
				else
					args = "0~~~" .. i
				end
			else
				-- used for setting watched faction
				args = "2~~~" .. i
			end
			addon.Debug( "about to SetLineScript" )
			tooltip:SetLineScript( lineNum, "OnMouseDown", BFactions_MouseHandler, args )
		end
	end
	-- Tooltip hints
	lineNum = tooltip:AddLine( " " )
	lineNum = tooltip:AddLine( "c" )
	tooltip:SetCell( lineNum, 1, Green( L["Click header lines to expand/contract"] ), "LEFT", numCols )
	lineNum = tooltip:AddLine( "d" )
	tooltip:SetCell( lineNum, 1, Green( L["Left-click faction lines to set watched faction"] ), "LEFT", numCols )
	lineNum = tooltip:AddLine( "e" )
	tooltip:SetCell( lineNum, 1, Green( L["Right-click for Configuration"] ), "LEFT", numCols )
end

local LDB = LibStub( "LibDataBroker-1.1" )
local launcher = LDB:NewDataObject( MODNAME, {
	type = "data source",
	text = " ",
	label = FULLNAME,
	-- icon = "Interface\\Addons\\Broker_Factions\\icon",
	icon = FactionIcon,
	OnClick = function(clickedframe, button)
				if ( button == "RightButton" ) then
					if ( IsAltKeyDown() ) then
						-- tooltip:Show()
					else
						addon:ShowConfig()
					end
				else
					-- does nothing unless you're in the tooltip. handled elsewhere
				end
	end,
	OnEnter = function ( self )
		tooltip = QT:Acquire( "BFactionsTT", 5, "LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT" )
		tooltip:SetScale( db.options.display.tipscale )
		addon:drawTooltip()
		tooltip:SetAutoHideDelay( db.options.display.autoHideDelay, self )
		tooltip:EnableMouse()
		tooltip:SmartAnchorTo( self )
		tooltip:UpdateScrolling()
		tooltip:Show()
	end,
	OnLeave = function()
		-- apparently some LDB displays pitch a fit when your launcher
		-- has an onenter, but no onleave. Pshaw, I say.
		return
	end,
} )

function addon:GetStartingRep()
	addon.Debug( "In GetStartingRep" )
	if ( gotSRep == false ) then
		addon.Debug( "Getting SRep" )
		local numFactions = GetNumFactions()
		for i = 1, numFactions do
			local name, _, _, _, _, barValue = GetFactionInfo( i )
			if ( barValue ~= 0 ) then
				startingRep[ name ] = barValue
			end
		end
		gotSRep = true
	end
end

-- Stubs for functions triggered on events...
function addon:PLAYER_ENTERING_WORLD( ... )
	addon.Debug( "event: PLAYER_ENTERING_WORLD fired" )
	addon.GetStartingRep()
	-- old code
	-- isPEW = true	
	self:UnregisterEvent( "PLAYER_ENTERING_WORLD" )
	self.PLAYER_ENTERING_WORLD = nil
end

function addon:PLAYER_LOGIN( ... )
	addon.Debug( "event: PLAYER_LOGIN fired" )
	local factionGroup = UnitFactionGroup("player")
	if factionGroup == "Horde" then
		FactionIcon = "Interface\\Icons\\INV_Misc_TabardPVP_04"
	else
		FactionIcon = "Interface\\Icons\\INV_Misc_TabardPVP_03"
	end
	addon.GetStartingRep()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function addon:UPDATE_FACTION( ... )
	-- addon.Debug( "event: UPDATE_FACTION fired" )
	--[[ old code
	if isPEW then
		self:CancelAllTimers()
		self:ScheduleTimer(self.CheckCollapsed, 1)			
		isPEW = nil;
	end
	BRFaction:Update()
	]]--
	addon.GetStartingRep()
	addon.updateText()
end

function addon:CHAT_MSG_COMBAT_FACTION_CHANGE( ... )
	-- old argument was 'msg'
	addon.Debug( "event: CHAT_MSG_COMBAT_FACTION_CHANGE fired" )
	--[[ old code
	-- Auto-set faction to monitor, on reputation gains/losses
	if Broker_FactionsConfig.AutoSetOnGains then
		local faction = nil
		if not Broker_FactionsConfig.IgnoreNegativeGains then
		_,_,faction = string.find (msg, "^"..L["Reputation with (.*) decreased"])
		end
		if not faction then
			_,_,faction = string.find (msg, "^"..L["Reputation with (.*) increased"])
		end	
		-- safeguard/workaround for mixed locales, ManniAT's idea
		if faction then faction = string.gsub(faction, "^'(.*)'$", "%1") end
		if faction and faction ~= "" and faction ~= Broker_FactionsConfig.MonitoredFaction then
			if Broker_FactionsConfig.IgnoreExaltedGains then
			-- check for exalted faction
			local num = GetNumFactions()
				local name, standingID
					for i = 1, num do
						name = tostring(GetFactionInfo(i))
						standingID = select(3, GetFactionInfo(i))
							-- if we are exalted with faction we gained rep with, and IgnoreExalted is on, return with no update
							if name == faction and standingID == 8 then return end
					end
			end
						
			-- Unset UseBlizzMonitor
			Broker_FactionsConfig.UseBlizzMonitor = false
			Broker_FactionsConfig.MonitoredFaction = faction
			self:Update()
		end
	end
	]]-- end old code
	addon.updateText()
end

function addon:CHAT_MSG_SYSTEM( ... )
	-- old argument 'msg'
	addon.Debug( "event: CHAT_MSG_SYSTEM fired" )
	--[[ old code
	local rep, faction, i
	local repfound = nil
	_,_,rep,faction = string.find(msg, "^"..L["You are now (%a+) with (.*)%."])
	if not rep or not faction then return end
	if rep and faction then 
		faction = string.gsub(faction, "^'(.*)'$", "%1") 
		rep = string.gsub(rep, "^'(.*)'$", "%1")
	end
	-- safeguard/workaround for mixed locales, ManniAT's idea
	for i=1, 8 do
		if rep == _G["FACTION_STANDING_LABEL"..i] then
			repfound = true
			break
		end
	end
	if not repfound then
		local temprep = rep
		rep = faction
		faction = temprep
	end
	if rep and faction and BRFaction.FactionValues then
		if not BRFaction.FactionValues[faction] then
			self:ScheduleTimer("AddNewFaction", 1, faction)
		end		
	end
	]]-- end old code
	addon.GetStartingRep()
	addon.updateText()
end

function addon:ADDON_LOADED( event, a )
	self.Debug( "event: ADDON LOADED fired = " .. a )
	if ( a == "Broker_Factions" ) then
		-- This should really only be the backup if Addon Loader is in use
		-- the code would have been hit in P_E_W or P_L or some other event
		-- normally.
		addon.GetStartingRep()
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
end

function BFactions_upgradeDB()
	local olddb = BFactions.db.factionrealm[BFactions.me]
	-- This checks the current DB version the person has, and upgrades as necessary
	-- dbUpgrade template...
	if ( olddb.options.display.dbVersion == "1.0" ) then
		olddb.options.display.showPercentage = false
		olddb.options.display.showRawValues = true
		olddb.options.display.showSessionGains = false
		olddb.options.display.showRemainingRep = false
		olddb.options.display.showHintLines = true
		olddb.options.display.showCollapsedHeaders = true
		olddb.options.display.dbVersion = "1.1"
		addon.Print( string.format( L["Database upgraded to %s"], "1.1" ) )
	end
	if ( olddb.options.display.dbVersion == "1.1" ) then
		olddb.options.display.hideExalted = false
		olddb.options.display.dbVersion = "1.2"
		addon.Print( string.format( L["Database upgraded to %s"], "1.2" ) )
	end
	if ( olddb.options.display.dbVersion == "1.2" ) then
		olddb.options.text = nil
		olddb.options.text = {}
		olddb.options.text.showText = false
		olddb.options.text.showPercentage = false
		olddb.options.text.showRawValues = true
		olddb.options.text.showSessionGains = false
		olddb.options.text.showRemainingRep = false
		olddb.options.display.dbVersion = "1.3"
		addon.Print( string.format( L["Database upgraded to %s"], "1.3" ) )
	end
	if ( olddb.options.display.dbVersion == "1.3" ) then
		olddb.options.text.watchedFaction = ""
		olddb.options.display.dbVersion = "1.4"
		addon.Print( string.format( L["Database upgraded to %s"], "1.4" ) )
	end
	if ( olddb.options.display.dbVersion == "1.4" ) then
		-- cleanup mistake in db
		olddb.options.display.minimap_icon.showPercentage = nil
		olddb.options.display.minimap_icon.showSessionGains = nil
		olddb.options.display.minimap_icon.showCollapsedHeaders = nil
		olddb.options.display.minimap_icon.showRawValues = nil
		olddb.options.display.minimap_icon.showRemainingRep = nil
		olddb.options.display.minimap_icon.showHintLines = nil
		olddb.options.display.dbVersion = "1.5"
		addon.Print( string.format( L["Database upgraded to %s"], "1.5" ) )
	end
end

function addon:updateText()
	-- Faction [xxxx/yyyyy zz% (+600) {320}]
	local outString = ""
	local firstArg = false
	if ( ( db.options.text.watchedFaction ~= "" ) and ( db.options.text.showText == true ) ) then
		local numFactions = GetNumFactions()
		local foundFaction = false
		for i = 1, numFactions do
			local name, _, standingID, barMin, barMax, barValue, _, _,
				isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo( i )
			if ( name == db.options.text.watchedFaction ) then
				foundFaction = true
				outString = name
				if ( db.options.text.showRawValues == true ) then
					local insVal = White( ( barValue - barMin ) .. "/" .. ( barMax - barMin ) )
					if ( barValue < 0 ) then
						insVal = Red( ( 0 - ( barMin - barValue ) ) .. "/" .. ( 0 - ( barMin - barMax ) ) )
					end
					if ( firstArg == false ) then
						outString = outString .. " ["
						firstArg = true
					else
						outString = outString .. " "
					end
					outString = outString .. insVal
				end
				if ( db.options.text.showPercentage == true ) then
					local numStr = tonumber( math.floor( ( ( barValue - barMin ) / ( barMax - barMin ) ) * 100 ) ) .. "%"
					if ( barValue < 0 ) then
						numStr = tonumber( math.floor( ( 0 - ( barMin - barValue ) ) / ( 0 - ( barMin - barMax ) ) * 100 ) ) .. "%"
					end
					if ( firstArg == false ) then
						outString = outString .. " ["
						firstArg = true
					else
						outString = outString .. " "
					end
					outString = outString .. Yellow( numStr )
				end
				if ( db.options.text.showSessionGains == true ) then
					local sGain = ""
					if ( startingRep[ name ] ~= nil ) then
						local delta = barValue - startingRep[name]
						if ( delta ~= 0 ) then
							if ( delta > 0 ) then
								sGain = Cyan( "+" .. delta )
							end
						end
					end
					if ( sGain ~= "" ) then
						if ( firstArg == false ) then
							outString = outString .. " ["
							firstArg = true
						else
							outString = outString .. " "
						end
						outString = outString .. "(" .. sGain .. ")"
					end
				end
				if ( db.options.text.showRemainingRep == true ) then
					if ( firstArg == false ) then
						outString = outString .. " ["
						firstArg = true
					else
						outString = outString .. " "
					end
					if ( barValue < 0 ) then
						outString = outString .. "{" .. Red( tonumber( barMax - barValue ) ) .. "}"
					else
						outString = outString .. "{" .. Green( tonumber( barMax - barValue ) ) .. "}"
					end
				end
				if ( firstArg == true ) then
					outString = outString .. "]"
				end
			end
		end
		if ( foundFaction == true ) then
			launcher.text = outString
		else
			launcher.text = " "
		end
	else
		launcher.text = " "
	end
end

-- Stuff relating to the options menu(s)
local options = nil
local displayOptions = nil
local textOptions = nil

local function giveDisplay()
	if (not displayOptions) then
		displayOptions = {
			order = 3,
			type = "group",
			name = L["Display Options"],
			desc = L["DISPLAY_OPTIONS_DESC"],
			args = {
				header1 = {
					order	= 31,
					type	= "header",
					name	= L["Display Options"],
				},
				desc = {
					order	= 32,
					type	= "description",
					name	= L["DISPLAY_OPTIONS_DESC"],
				},
				tooltipscale = {
					order	= 41,
					type	= "range",
					name	= L["Tooltip Scale"],
					desc	= L["TOOLTIP_SCALE_DESC"],
					min		= .7,
					max		= 1.3,
					step	= .05,
					bigStep = .05,
					get		= function() return db.options.display.tipscale end,
					set		= function( info, v ) 
								db.options.display.tipscale = v
								tooltip:SetScale( v )
							  end,
				},
				header2 = {
					order	= 100,
					type	= "header",
					name	= L["Minimap Icon Options"],
				},
				desc2 = {
					order	= 101,
					type	= "description",
					name	= L["MINIMAP_OPTIONS_DESC"],
				},
				minimap_icon = {
					order	= 102,
					type	= "toggle",
					width	= "full",
					name	= L["Show Minimap Icon"],
					desc	= L["Draws the icon on the minimap."],
					get	= function()
							return not db.options.display.minimap_icon.hide
						  end,
					set	= function(info, value)
							db.options.display.minimap_icon.hide = not value
							  LDBIcon[value and "Show" or "Hide"](LDBIcon, MODNAME)
						  end,
				},
				header3 = {
					order	= 200,
					type	= "header",
					name	= L["Miscellaneous Display Options"],
				},
				desc3 = {
					order	= 201,
					type	= "description",
					name	= L["MISCDISPLAY_OPTIONS_DESC"],
				},
				debug = {
					order	= 202,
					type	= "toggle",
					name	= L["Display Debug"],
					desc	= L["DISPLAY_DEBUG_DESC"],
					get		= function() return db.options.display.debug end,
					set		= function() db.options.display.debug = not db.options.display.debug end,
				},
				autoHideDelay = {
					order	= 203,
					type	= "range",
					name	= L["Tooltip Auto-hide Delay"],
					desc	= L["TOOLTIP_DELAY_DESC"],
					min		= .1,
					max		= 2,
					step	= .1,
					bigStep = .1,
					get		= function() return db.options.display.autoHideDelay end,
					set		= function( info, v ) 
								db.options.display.autoHideDelay = v
							  end,
				},
				header4 = {
					order	= 300,
					type	= "header",
					name	= L["Tooltip Display Options"],
				},
				desc4 = {
					order	= 301,
					type	= "description",
					name	= L["TOOLTIPDISPLAY_OPTIONS_DESC"],
				},
				showpercentage = {
					order	= 302,
					type	= "toggle",
					name	= L["Show Percentage"],
					desc	= L["DISPLAY_SHOWPERC_DESC"],
					get		= function() return db.options.display.showPercentage end,
					set		= function() db.options.display.showPercentage = not db.options.display.showPercentage end,
				},
				showraw = {
					order	= 303,
					type	= "toggle",
					name	= L["Show Raw Values"],
					desc	= L["DISPLAY_SHOWRAW_DESC"],
					get		= function() return db.options.display.showRawValues end,
					set		= function() db.options.display.showRawValues = not db.options.display.showRawValues end,
				},
				showgains = {
					order	= 304,
					type	= "toggle",
					name	= L["Show Session Gains"],
					desc	= L["DISPLAY_SHOWGAINS_DESC"],
					get		= function() return db.options.display.showSessionGains end,
					set		= function() db.options.display.showSessionGains = not db.options.display.showSessionGains end,
				},
				showremain = {
					order	= 305,
					type	= "toggle",
					name	= L["Show Remaining"],
					desc	= L["DISPLAY_SHOWREMAIN_DESC"],
					get		= function() return db.options.display.showRemainingRep end,
					set		= function() db.options.display.showRemainingRep = not db.options.display.showRemainingRep end,
				},
				showhints = {
					order	= 306,
					type	= "toggle",
					name	= L["Show Hint Lines"],
					desc	= L["DISPLAY_SHOWHINTS_DESC"],
					get		= function() return db.options.display.showHintLines end,
					set		= function() db.options.display.showHintLines = not db.options.display.showHintLines end,
				},
				showcollapsed = {
					order	= 307,
					type	= "toggle",
					name	= L["Show Collapsed Headers"],
					desc	= L["DISPLAY_SHOWCOLLAPSED_DESC"],
					get		= function() return db.options.display.showCollapsedHeaders end,
					set		= function() db.options.display.showCollapsedHeaders = not db.options.display.showCollapsedHeaders end,
				},
				hideExalted = {
					order	= 308,
					type	= "toggle",
					name	= L["Hide Exalted Factions"],
					desc	= L["DISPLAY_HIDEEXALTED_DESC"],
					get		= function() return db.options.display.hideExalted end,
					set		= function() db.options.display.hideExalted = not db.options.display.hideExalted end,
				},
			},
		}
	end
	return displayOptions
end

local function giveText()
	if (not textOptions) then
		textOptions = {
			order = 4,
			type = "group",
			name = L["Text Options"],
			desc = L["TEXT_OPTIONS_DESC"],
			args = {
				header1 = {
					order	= 31,
					type	= "header",
					name	= L["Text Options"],
				},
				desc = {
					order	= 32,
					type	= "description",
					name	= L["TEXT_OPTIONS_DESC"],
				},
				showText = {
					order	= 301,
					type	= "toggle",
					name	= L["Show Text"],
					desc	= L["TEXT_SHOW_DESC"],
					get		= function() return db.options.text.showText end,
					set		= function()
								db.options.text.showText = not db.options.text.showText
								addon.updateText()
							  end,
				},
				showpercentage = {
					order	= 302,
					type	= "toggle",
					name	= L["Show Percentage"],
					desc	= L["TEXT_SHOWPERC_DESC"],
					get		= function() return db.options.text.showPercentage end,
					set		= function()
								db.options.text.showPercentage = not db.options.text.showPercentage
								addon.updateText()
							  end,
					disabled	= function()
						if ( db.options.text.showText ) then
							return false
						else
							return true
						end
					end,
				},
				showraw = {
					order	= 303,
					type	= "toggle",
					name	= L["Show Raw Values"],
					desc	= L["TEXT_SHOWRAW_DESC"],
					get		= function() return db.options.text.showRawValues end,
					set		= function()
								db.options.text.showRawValues = not db.options.text.showRawValues
								addon.updateText()
							  end,
					disabled	= function()
						if ( db.options.text.showText ) then
							return false
						else
							return true
						end
					end,
				},
				showgains = {
					order	= 304,
					type	= "toggle",
					name	= L["Show Session Gains"],
					desc	= L["TEXT_SHOWGAINS_DESC"],
					get		= function() return db.options.text.showSessionGains end,
					set		= function()
								db.options.text.showSessionGains = not db.options.text.showSessionGains
								addon.updateText()
							  end,
					disabled	= function()
						if ( db.options.text.showText ) then
							return false
						else
							return true
						end
					end,
				},
				showremain = {
					order	= 305,
					type	= "toggle",
					name	= L["Show Remaining"],
					desc	= L["TEXT_SHOWREMAIN_DESC"],
					get		= function() return db.options.text.showRemainingRep end,
					set		= function()
								db.options.text.showRemainingRep = not db.options.text.showRemainingRep
								addon.updateText()
							  end,
					disabled	= function()
						if ( db.options.text.showText ) then
							return false
						else
							return true
						end
					end,
				},
				watchFaction = {
					order	= 306,
					type	= "select",
					name	= L["Select Faction to Watch"],
					desc	= L["TEXT_FACTIONWATCH_DESC"],
					get		= function() return db.options.text.watchedFaction end,
					set		= function( info, value )
								db.options.text.watchedFaction = value
								addon.updateText()
							  end,
					values	= function()
								local numFactions = GetNumFactions()
								local t = {}
								for i = 1, numFactions do
									local name, _, standingID, barMin, barMax, barValue, _, _,
										isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo( i )
									if ( isHeader == nil ) then
										t[name] = name
									end
								end
								return t
							  end,
					disabled	= function()
									if ( db.options.text.showText ) then
										return false
									else
										return true
									end
								  end,
				},
			},
		}
	end
	return textOptions
end

local function fullOptions()
	if (not options) then
		options = {
			type = "group",
			name = MODNAME,
			args = {
				general = {
					order	= 1,
					type	= "group",
					name	= L["General Information"],
					desc	= L["GENERAL_INFO_DESC"],
					args	= {
						header1 = {
							order	= 11,
							type	= "header",
							name	= L["General Information"],
						},
						desc = {
							order	= 12,
							type	= "description",
							name	= L["GENERAL_INFO_DESC"],
						},
						author = {
							order	= 13,
							type	= "description",
							name	= L["Author : "] .. addonauthor .. "\n",
						},
						version = {
							order	= 14,
							type	= "description",
							name	= L["Version : "] .. addonversion .. "\n",
						},
						builddate = {
							order	= 15,
							type	= "description",
							name	= L["Build Date : "] .. builddate .. "\n",
						},
						dbversion = {
							order	= 15,
							type	= "description",
							name	= L["Database Version : "] .. db.options.display.dbVersion .. "\n",
						},
						translators = {
							order	= 16,
							type	= "description",
							name	= string.format( L["Helpful Translators (thank you) : %s"],
										"deDE:xevilgrin, koKR:next96, zhTW:zhTW\n" ),
						},
					},
				},
			},
		}
	end
	
	for k,v in pairs(modularOptions) do
		options.args[k] = (type(v) == "function") and v() or v
	end

	return options
end

function addon:SetupOptions()
	AceConfigReg:RegisterOptionsTable(MODNAME, fullOptions)
	addon.optionsFrame = AceConfigDialog:AddToBlizOptions(MODNAME, nil, nil, "general")

	-- Fill up our modular options...
	addon:RegisterModuleOptions("Display", giveDisplay(), L["Display Options"])
	addon:RegisterModuleOptions("Text", giveText(), L["Text Options"])
end

function addon:RegisterModuleOptions(name, optionsTable, displayName)
	modularOptions[name] = optionsTable
	addon.optionsFrame[name] = AceConfigDialog:AddToBlizOptions(MODNAME, displayName, MODNAME, name)
end

function addon:ShowConfig()
	-- Open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory( self.optionsFrame["Display"] )
end

function addon:OnInitialize()
	-- If there was frame creation stuff to do, it would go here
end

function addon:OnEnable()
    -- Called when the addon is loaded
	BFactions.me = UnitName( "player" )
	-- HitCrit.GUID = UnitGUID( "player" )
	-- HitCrit.level = UnitLevel( "player" )
	self.db = LibStub( "AceDB-3.0" ):New( "BFactions_DB", nil, "Default" )
	-- do we have any data yet; for this toon? If not, init its table
	if not ( self.db.factionrealm[BFactions.me] ) then
		self.db.factionrealm[BFactions.me] = {
			options = {
				display = {
					debug = false,
					tipscale = 1,
					dbVersion = "1.5",
					autoHideDelay = .1,
					minimap_icon = {
						hide = true,
					},
					showPercentage = false,
					showRawValues = true,
					showSessionGains = false,
					showRemainingRep = false,
					showHintLines = true,
					showCollapsedHeaders = true,
					hideExalted = false,
				},
				text = {
					showText = false,
					showPercentage = false,
					showRawValues = true,
					showSessionGains = false,
					showRemainingRep = false,
					watchedFaction = "",
				}
			},
		}
	else
		-- check if we need to upgrade the db
		BFactions_upgradeDB()
	end
	db = self.db.factionrealm[BFactions.me]

	addon.Debug( "In OnInit" )

	addon.SetupOptions()

	-- Event listeners
	addon:RegisterEvent("ADDON_LOADED")
	addon:RegisterEvent("PLAYER_ENTERING_WORLD")
	addon:RegisterEvent("PLAYER_LOGIN")
	addon:RegisterEvent("UPDATE_FACTION")
	addon:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	addon:RegisterEvent("CHAT_MSG_SYSTEM")

	-- libdbicon stuff
	if LDBIcon then
		LDBIcon:Register( MODNAME, launcher, db.options.display.minimap_icon )
	end
	
	addon.updateText()
end

--[[
************************************************************************
CHANGELOG:

Date : 5/1/11
	Initial workover of Tristanian's version
************************************************************************
]]--
