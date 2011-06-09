-- Broker_RaidSave: A simplified LibDataBroker "port" of FuBar_RaidSaveFu by Tristanian
-- based on the original code with permission of jokeyrhyme (jokeyrhyme@gmail.com)
-- all rights recognised
-- TW localization by launcelot

-- Zzzz, embeds & stuff, create DO etc...
local MODNAME = "BRRaidSave"
local FULLNAME = "Broker_RaidSave"

local BRRaidSave = LibStub( "AceAddon-3.0" ):NewAddon( MODNAME, "AceEvent-3.0" )
-- replaced with NewAddon call
-- local BRRaidSave = CreateFrame("Frame", "Broker_RaidSave")
local Abacus = LibStub("LibAbacus-3.0")
local QT = LibStub("LibQTip-1.0")
local L = LibStub:GetLibrary( "AceLocale-3.0" ):GetLocale( MODNAME )
--[[
local AceConfig 		= LibStub("AceConfig-3.0")
local AceConfigReg 		= LibStub("AceConfigRegistry-3.0")
local AceConfigDialog 	= LibStub("AceConfigDialog-3.0")
]]--


-- BRRaidSave:SetScript("OnEvent", function(_, event, ...)
-- 	BRRaidSave[event](BRRaidSave, ...)
-- end)

-- locals
local _G = getfenv(0)
_G[ MODNAME ] = BRRaidSave
local addon = BRRaidSave
local headings = {}
local tooltip = nil
local totaltime = 0
local returnarg = {}

-- Helper funcs
local function RemoveColorCode(label)
if not label then return end
local tmpstr, line, normalized = nil, nil, ""
line = string.gsub(label, "|r", "")
	while string.len(line) > 0 do
		local pos = string.find(line, "|cff", 1, true)
			if pos then
				tmpstr = string.sub(line,1,pos-1)
				line = string.sub(line,pos + 10)
			else
				tmpstr = line
				line = ""
			end
			normalized = normalized..tmpstr
	end
	normalized = string.gsub(normalized, "|", "")
	return normalized
end

local function ClickHandlerFunc(cell, arg1, button)
	-- Obligatory sanity checks
	if not arg1 or type(arg1)~= "table" then return end	
	if not arg1[1] or not arg1[2] or not arg1[3] or not arg1[4] or arg1[5] == nil then return end
	
	-- Handlers
	if button == "LeftButton" and not IsShiftKeyDown() then
		local iindex, instanceID, numofsaved = nil, nil, GetNumSavedInstances()
		for i = 1, numofsaved do
			instanceID = select(2, GetSavedInstanceInfo(i))
			if instanceID == arg1[3] then iindex = i break end
		end
		if iindex and arg1[5] == false then
			 SetSavedInstanceExtend(iindex, true)
		elseif iindex and arg1[5] == true then
			 SetSavedInstanceExtend(iindex, false)
		end
		RequestRaidInfo() -- trigger update
	elseif button == "LeftButton" and IsShiftKeyDown() then
		if ChatFrameEditBox:IsVisible() then
			local reportlabel = L["Instance"]..": "..RemoveColorCode(arg1[1])..", "..L["Difficulty"]..": "..RemoveColorCode(arg1[2])..", "..L["ID"]..": "..RemoveColorCode(arg1[3])..", "..L["Expires"]..": "..RemoveColorCode(arg1[4])
			ChatFrameEditBox:Insert(reportlabel)
		end
	end
end

-- Ace config table
local options = {
	name = "Broker RaidSave",
	type = "group",
	args = {
	confdesc = {
			order = 1,
			type = "description",
			name = L["Minimalistic LDB plugin that allows tracking of raid IDs across characters."].."\n",
			cmdHidden = true
		},
		 generalheader = {
		 order = 2,
		 type = "header",
		 name = L["General Options"],
		},
		nulloption = {
			order = 3,
			type = "description",
			name = " ",
			cmdHidden = true
		},		
			textWhenZero = {
				type = 'toggle', width = "full",
				name = L["Show text for no saved instances"],
				desc = L["Show the plugin text instead of number, when the character has no saved instances."],
				order = 5,
				get = function() return Broker_RaidSaveConfig.textwhenzero end,
				set = function(_,v)	Broker_RaidSaveConfig.textwhenzero = v
					addon:Update()
				end,
			},
			shortText = {
				type = 'toggle', width = "full",
				name = L["Short text"],
				desc = L["Only show the number of saved instances, in the format [Group]:[Raid]:[Expired]."],
				order = 6,
				get = function() return Broker_RaidSaveConfig.shorttext end,
				set = function(_,v)	Broker_RaidSaveConfig.shorttext = v
					addon:Update()
				end,
			},
			hidehint = {
				order = 7, type = "toggle", width = "full",
				name = L["Hide hint text"],
				desc = L["Hides the tooltip information/hint text."],
				get = function() return Broker_RaidSaveConfig.HideHint end,
				set = function(_,v) Broker_RaidSaveConfig.HideHint = v
				end,
			},
			sortinstancesbyname = {
				type = 'toggle',
				name = L["Sort by name"],
				desc = L["Sorts the instances on the tooltip, using the name of the instance as a reference."],
				order = 8,
				get = function() return Broker_RaidSaveConfig.sortbyinstancename end,
				set = function(_,v)
				Broker_RaidSaveConfig.sortbyinstancediff = false
				Broker_RaidSaveConfig.sortbyinstancename = v
				end,
			},
			instancesnameorder = {
			order = 9, type = "select",
			name = L["List Ordering"],
			desc = L["Order style for the saved instances list."],
			get = function() return Broker_RaidSaveConfig.instancenameorder end,
			set = function(_,v) Broker_RaidSaveConfig.instancenameorder = v end,
			values = {
				["asc"] = L["Ascending"],
				["desc"] = L["Descending"]
				},
			},
			sortinstancesbydifficulty = {
				type = 'toggle',
				name = L["Sort by difficulty"],
				desc = L["Sorts the instances on the tooltip, using the instance difficulty as a reference."],
				order = 10,
				get = function() return Broker_RaidSaveConfig.sortbyinstancediff end,
				set = function(_,v)
				Broker_RaidSaveConfig.sortbyinstancename = false
				Broker_RaidSaveConfig.sortbyinstancediff = v
				end,
				disabled = function() return not Broker_RaidSaveConfig.showdiff end,
			},
			instancesdifforder = {
			order = 11, type = "select",
			name = L["List Ordering"],
			desc = L["Order style for the saved instances list."],
			get = function() return Broker_RaidSaveConfig.instancedifforder end,
			set = function(_,v) Broker_RaidSaveConfig.instancedifforder = v end,
			values = {
				["asc"] = L["Ascending"],
				["desc"] = L["Descending"]
				},
			},
			showslider = {
				order = 12, type = "toggle",
				name = L["Enable scrolling"],
				desc = L["Activates and displays a scrolling slider bar, for the tooltip."],
				get = function() return Broker_RaidSaveConfig.ShowSlider end,
				set = function(_,v) Broker_RaidSaveConfig.ShowSlider = v
				end,
			},
			slidermaxheight = {
				order = 13, type = "range",
				name = L["Tooltip Maximum Height"],
				desc = L["Sets the tooltip maximum height, after which it will be scrollable."],
				min = 100, max = 2000, step = 5,
				get = function() return Broker_RaidSaveConfig.SliderMaxHeight end,
				set = function(_,v) 
				if v < 100 then v = 100 end
				if v > 2000 then v = 2000 end
				Broker_RaidSaveConfig.SliderMaxHeight = v end,
				disabled = function() return not Broker_RaidSaveConfig.ShowSlider end,
			},
			nulloption2 = {
			order = 14,
			type = "description",
			name = " ",
			cmdHidden = true
			},
			instanceheader = {
		 	order = 15,
		 	type = "header",
		 	name = L["Instance Information"],
			},
			nulloption3 = {
			order = 16,
			type = "description",
			name = " ",
			cmdHidden = true
			},
			showID = {
				type = 'toggle', width = "full",
				name = L["Show instance IDs"],
				desc = L["Show or hide the numeric instance IDs."],
				order = 17,
				get = function() return Broker_RaidSaveConfig.showid end,
				set = function(_,v)	Broker_RaidSaveConfig.showid = v					
				end,
			},			
			showDiff = {
				type = 'toggle', width = "full",
				name = L["Show instance difficulty mode"],
				desc = L["Adds a new column, indicating the dungeon or raid difficulty for the specific instance name and ID."],
				order = 18,
				get = function() return Broker_RaidSaveConfig.showdiff end,
				set = function(_,v)	Broker_RaidSaveConfig.showdiff = v
				if not Broker_RaidSaveConfig.showdiff and Broker_RaidSaveConfig.sortbyinstancediff then -- if not showing difficulty and we are sorting by it, sort by instance name instead
					Broker_RaidSaveConfig.sortbyinstancediff = false
					Broker_RaidSaveConfig.sortbyinstancename = true
				end
				end,
			},			
			showCooldown = {
				type = 'toggle',
				name = L["Show time remaining"],
				desc = L["Display the time the instance ID is still valid."],
				order = 19,
				get = function() return Broker_RaidSaveConfig.showcooldown end,
				set = function(_,v)	Broker_RaidSaveConfig.showcooldown = v
				end,
			},
			formatCooldown = {
			order = 20, type = "select",
			name = L["Remaining time format"],
			desc = L["Display style for the time until reset."],
			get = function() return Broker_RaidSaveConfig.formatcooldown end,
			set = function(_,v) Broker_RaidSaveConfig.formatcooldown = v end,
			values = {
				["Extended"] = L["Extended"],
				["Full"] = L["Full"],
				["Short"] = L["Short"],
				["Condensed"] = L["Condensed"]
				},
			},
			nulloption4 = {
			order = 21,
			type = "description",
			name = " ",
			cmdHidden = true
			},
			instanceExpirationheader = {
		 	order = 22,
		 	type = "header",
		 	name = L["Instance Expiration"],
			},
			nulloption5 = {
			order = 23,
			type = "description",
			name = " ",
			cmdHidden = true
			},
			showReset = {
			type = 'toggle', width = "full",
			name = L["Show instance expiration data"],
			desc = L["Display the date/time the instance ID expires."],
			order = 24,
			get = function() return Broker_RaidSaveConfig.showreset end,
			set = function(_,v)	Broker_RaidSaveConfig.showreset = v				
			end,
			},
			formatDayW = {
			type = 'toggle', width = "full",
			name = L["Show day in week"],
			desc = L["Display the name of the day of the week, for the instance expiration string."],
			order = 25,
			get = function() return Broker_RaidSaveConfig.formatdayw end,
			set = function(_,v)	Broker_RaidSaveConfig.formatdayw = v				
			end,
			},
			hideExpiredbutton = {
			type = 'toggle', width = "full",
			name = L["Hide expired instances from plugin text"],
			desc = L["Don't display instances with expired ID's on the plugin text."],
			order = 26,
			get = function() return Broker_RaidSaveConfig.hideexpiredbutton end,
			set = function(_,v)	Broker_RaidSaveConfig.hideexpiredbutton = v
			addon:Update()
			end,
			},
			hideExpiredTip = {
			type = 'toggle', width = "full",
			name = L["Hide expired instances from tooltip"],
			desc = L["Don't display instances with expired ID's on the tooltip."],
			order = 27,
			get = function() return Broker_RaidSaveConfig.hideexpiredtip end,
			set = function(_,v)	Broker_RaidSaveConfig.hideexpiredtip = v
			end,
			},
			formatDate = {
			order = 28, type = "select",
			name = L["Expiry date format"],
			desc = L["Display style for the date instance IDs expire."],
			get = function() return Broker_RaidSaveConfig.formatdate end,
			set = function(_,v) Broker_RaidSaveConfig.formatdate = v end,
			values = {
				["Chinese"] = L["Chinese"],
				["European"] = L["European"],
				["USAmerican"] = L["US/American"]
				},
			},
			formatTime = {
			order = 29, type = "select",
			name = L["Expiry time format"],
			desc = L["Display style for the time instance IDs expire."],
			get = function() return Broker_RaidSaveConfig.formattime end,
			set = function(_,v) Broker_RaidSaveConfig.formattime = v end,
			values = {
				["Show12"] = L["12-Hour"],
				["Show24"] = L["24-Hour"]
				},
			},			
	}
}

-- Add config to Blizzard menu
LibStub("AceConfig-3.0"):RegisterOptionsTable("Broker RaidSave", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Broker RaidSave")

local LDB = LibStub( "LibDataBroker-1.1" )
local launcher = LDB:NewDataObject( MODNAME, {
	type = "data source",
	text = " ",
	label = FULLNAME,
	-- icon = "Interface\\Addons\\Broker_Factions\\icon",
	icon = "Interface\\Addons\\Broker_RaidSave\\icon",
	OnClick = function(clickedframe, button)
				if tooltip then
					-- tooltip:SetScript("OnEnter", nil)
					-- tooltip:SetScript("OnLeave", nil)
					tooltip:Release(tooltip)
					tooltip = nil
				end
				if button == "RightButton" then
						InterfaceOptionsFrame_OpenToCategory("Broker RaidSave")
				elseif button == "LeftButton" then
					if RaidInfoFrame:IsVisible() then
						if FriendsFrame:IsVisible() then ToggleFriendsFrame(5) end
						RaidInfoFrame:Hide() -- this is really only needed if some addon has modified the Parent of RaidInfoFrame
					else
						if not FriendsFrame:IsVisible() or FriendsFrame.selectedTab ~= 5 then ToggleFriendsFrame(5) end
						RaidInfoFrame:Show()
					end
				end
	end,
	OnEnter = function ( self )
		local colnum = 1	
		local orientation = {}
		headings = {}
		headings[colnum] = _G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["Instance"].."|r  "
		orientation[colnum] = "LEFT"
		if Broker_RaidSaveConfig.showdiff then
			colnum = colnum + 1
			headings[colnum] = _G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["Difficulty"].."|r "
			orientation[colnum] = "CENTER"
		end
		if Broker_RaidSaveConfig.showid then				
			colnum = colnum + 1
			headings[colnum] = _G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["ID"].."|r  "
			orientation[colnum] = "CENTER"
		end
		if Broker_RaidSaveConfig.showcooldown then			
				colnum = colnum + 1
				headings[colnum] = _G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["Remaining"].."|r  "
				orientation[colnum] = "CENTER"
		end
		if Broker_RaidSaveConfig.showreset then		
			colnum = colnum + 1
			headings[colnum] = _G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["Expires"].."|r"		
			orientation[colnum] = "CENTER"
		end
		
		local maxentries = #orientation
	
	
		-- tooltip = QT:Acquire( "BRaidSaveTT", 5, "LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT" )
		tooltip = QT:Acquire("Broker_RaidSave", colnum, unpack(orientation, 1, maxentries))
		tooltip:EnableMouse()
		tooltip:SmartAnchorTo( self )
		tooltip:Clear()
		-- tooltip:SetScale( db.options.display.tipscale )
		tooltip:SetScale( 1 )
		tooltip:SetBackdropBorderColor(1, 1, 1, 1)
		addon:Drawtooltip()
		-- tooltip:SetAutoHideDelay( db.options.display.autoHideDelay, self )
		tooltip:SetAutoHideDelay( .1, self )
		tooltip:UpdateScrolling()
		tooltip:Show()
	end,
	OnLeave = function()
		-- apparently some LDB displays pitch a fit when your launcher
		-- has an onenter, but no onleave. Pshaw, I say.
		return
	end,
} )


function addon:Update()
	local player = Broker_RaidSaveConfig.realm[GetRealmName()].char[GetUnitName("player")]
	local instancenum
	if Broker_RaidSaveConfig.hideexpiredbutton then instancenum = player.numactive else instancenum = player.numsaved end
	if instancenum == 0 and Broker_RaidSaveConfig.textwhenzero then launcher.text = L["No Instances"] return end
	
	local labelgroup = _G["NORMAL_FONT_COLOR_CODE"].._G["GROUP"]..": ".."|r".."|cff68ccef"..string.format("%d", player.numgroup).."|r"
	local labelraid = _G["NORMAL_FONT_COLOR_CODE"].."  ".._G["RAID"]..": ".."|r".._G["GREEN_FONT_COLOR_CODE"]..string.format("%d", player.numraid).."|r"
	local labelexpired = _G["NORMAL_FONT_COLOR_CODE"].."  "..L["Expired: "].."|r".._G["RED_FONT_COLOR_CODE"]..string.format("%d", player.numsaved - player.numactive).."|r"
	
	if Broker_RaidSaveConfig.shorttext then
		if Broker_RaidSaveConfig.hideexpiredbutton then
			launcher.text = "|cff68ccef"..string.format("%d", player.numgroup).."|r".." : ".._G["GREEN_FONT_COLOR_CODE"]..string.format("%d", player.numraid).."|r"
		else
			launcher.text = "|cff68ccef"..string.format("%d", player.numgroup).."|r".." : ".._G["GREEN_FONT_COLOR_CODE"]..string.format("%d", player.numraid).."|r".." : ".._G["RED_FONT_COLOR_CODE"]..string.format("%d", player.numsaved - player.numactive).."|r"
		end
	else
		if Broker_RaidSaveConfig.hideexpiredbutton then labelexpired = "" end
		launcher.text = labelgroup..labelraid..labelexpired
	end
end

function addon:Drawtooltip()
local player = Broker_RaidSaveConfig.realm[GetRealmName()].char[GetUnitName("player")]
local savedinstances, templine

	local colcount = tooltip:GetColumnCount()	
	tooltip:AddLine("")
	tooltip:SetCell(1, 1, _G["HIGHLIGHT_FONT_COLOR_CODE"].."Broker RaidSave", nil, "CENTER", colcount)
	
	local k, v	
	for k, v in pairs(Broker_RaidSaveConfig.realm[GetRealmName()].char) do		
		if v.numsaved > 0 then
			local displaytable = {}
			for i = 1, v.numsaved do				
				if Broker_RaidSaveConfig.hideexpiredtip and (v.instance[i].expires == 0 or v.instance[i].expires < time()) then
				else
					local colnum = 1
					local display = {}
					-- set namestring
					local namestring = ""
					if v.instance[i].extended then
						namestring = "|cff0090ff"..v.instance[i].name.."|r"
					else
						namestring = _G["NORMAL_FONT_COLOR_CODE"]..v.instance[i].name.."|r"
					end
					-- set idstring
					local idstring = "|cff2ce390".."["..v.instance[i].id.."]".."|r"
					-- set cooldown string
					local cooldownstring = ""
					if Broker_RaidSaveConfig.formatcooldown == "Extended" then
						cooldownstring = Abacus:FormatDurationExtended(v.instance[i].expires - time())
					elseif Broker_RaidSaveConfig.formatcooldown == "Condensed" then
						cooldownstring = Abacus:FormatDurationCondensed(v.instance[i].expires - time())
					elseif Broker_RaidSaveConfig.formatcooldown == "Short" then
						cooldownstring = Abacus:FormatDurationShort(v.instance[i].expires - time())
					else -- Full style
						cooldownstring = SecondsToTime(v.instance[i].expires - time())
					end					
					if v.instance[i].expires - time() <= 86400 then --less than a day
						cooldownstring = _G["RED_FONT_COLOR_CODE"]..cooldownstring.."|r"
					else -- more than a day
						cooldownstring = _G["GREEN_FONT_COLOR_CODE"]..cooldownstring.."|r"
					end
					-- set expire string
					local expirestring = addon:FormatDate(v.instance[i].expires)
					expirestring = _G["NORMAL_FONT_COLOR_CODE"]..expirestring.." "..addon:FormatTime(v.instance[i].expires).."|r"
					-- set difficulty string
					local instancediffstring = ""
					if v.instance[i].israid ~= nil then
						instancediffstring = addon:GetDungeonDifficultyText(v.instance[i].difficulty, v.instance[i].israid)
					else
						instancediffstring = "|cffa0933d".._G["UNKNOWN"].."|r"
					end
					-- Desaturate label colors for expired instances
					if v.instance[i].expires == 0 or v.instance[i].expires < time() then
						namestring = _G["GRAY_FONT_COLOR_CODE"]..v.instance[i].name.."|r"
						idstring = _G["GRAY_FONT_COLOR_CODE"].."["..v.instance[i].id.."]".."|r"
						expirestring = _G["GRAY_FONT_COLOR_CODE"]..L["Expired"].."|r"
						cooldownstring = _G["GRAY_FONT_COLOR_CODE"]..L["Expired"].."|r"
						instancediffstring = _G["GRAY_FONT_COLOR_CODE"]..RemoveColorCode(instancediffstring).."|r"
					end
					-- set the columns
					display[1] = namestring.."  "
					if Broker_RaidSaveConfig.showdiff then
						colnum = colnum + 1
						display[colnum] = instancediffstring.." "
					end					
					if Broker_RaidSaveConfig.showid then
						colnum = colnum + 1
						display[colnum] = idstring.."  "
					end
					if Broker_RaidSaveConfig.showcooldown then							
							colnum = colnum + 1
							display[colnum] = cooldownstring.."  "
					end
					if Broker_RaidSaveConfig.showreset then							
							colnum = colnum + 1
							display[colnum] = expirestring
					end
					-- construct return table for currently logged on character only and insert it, into the display table
					-- Structure: returnarg = { <Instance Name>, <Diff>, <ID>, <Reset>, <Extended>}
				  -- Instance Name : color coded string
				  -- Diff : color coded string
				  -- ID : string
				  -- Reset : color coded string
				  -- Extended : boolean
					if v.name == player.name then
						returnarg = {} -- reusable table
						returnarg[1] = namestring
						returnarg[2] = instancediffstring
						returnarg[3] = v.instance[i].id
						returnarg[4] = expirestring
						returnarg[5] = v.instance[i].extended
						display[colnum + 1] = returnarg
					end
					table.insert(displaytable, display)					
				end
			end
			
			if #displaytable > 0 then
				
				-- handle sorting
				if Broker_RaidSaveConfig.sortbyinstancename then
					if Broker_RaidSaveConfig.instancenameorder == "desc" then
						table.sort(displaytable, function(a,b) return string.lower (RemoveColorCode(a[1])) < string.lower(RemoveColorCode(b[1])) end)
					else
						table.sort(displaytable, function(a,b) return string.lower (RemoveColorCode(a[1])) > string.lower(RemoveColorCode(b[1])) end)
					end
				elseif Broker_RaidSaveConfig.sortbyinstancediff and Broker_RaidSaveConfig.showdiff then
					if Broker_RaidSaveConfig.instancedifforder == "desc" then
						table.sort(displaytable, function(a,b) return string.lower(RemoveColorCode(a[2])) < string.lower(RemoveColorCode(b[2])) end)
					else
						table.sort(displaytable, function(a,b) return string.lower(RemoveColorCode(a[2])) > string.lower(RemoveColorCode(b[2])) end)
					end
				end
				
						savedinstances = true
					  tooltip:AddLine(" ")
					if v.name == player.name then
						tooltip:AddLine(addon:ClassColorise(v.class, v.name).." "..L["(Current)"])
					else						
						tooltip:AddLine(addon:ClassColorise(v.class, v.name))
					end										
					tooltip:AddLine(unpack(headings,1,colcount))
										
					for i = 1, #displaytable do						
						templine = tooltip:AddLine(unpack(displaytable[i],1,colcount))
						-- safeguard
						if displaytable[i][colcount + 1] then
							tooltip:SetCellScript(templine, 1, "OnMouseDown", ClickHandlerFunc , displaytable[i][colcount + 1])
						end
					end			
			end
		end
	end
	
	-- check to display something if no savedinstances exist at all
	if not savedinstances then
		templine = tooltip:AddLine("")
		tooltip:SetCell(templine, 1, _G["NORMAL_FONT_COLOR_CODE"]..L["No saved instances found."].."|r", nil, "CENTER", colcount)
	end
	
	-- Tooltip Hint
	if not Broker_RaidSaveConfig.HideHint then
		tooltip:AddLine(" ")
		templine = tooltip:AddLine("")
		tooltip:SetCell(templine, 1, L["|cffeda55fLeft Click|r |cff19ff19on plugin to toggle Blizzard's Raid Information frame."], nil, "LEFT", colcount)
		templine = tooltip:AddLine("")
		tooltip:SetCell(templine, 1, L["|cffeda55fLeft Click|r |cff19ff19on instance name to toggle ID extension."], nil, "LEFT", colcount)
		templine = tooltip:AddLine("")
		tooltip:SetCell(templine, 1, L["|cffeda55fRight Click|r |cff19ff19on plugin to open Configuration Menu."], nil, "LEFT", colcount)
		templine = tooltip:AddLine("")
		tooltip:SetCell(templine, 1, L["|cffeda55fShift+Left Click|r |cff19ff19to paste instance info into chat."], nil, "LEFT", colcount)
		templine = tooltip:AddLine("")
		tooltip:SetCell(templine, 1, L["|cff0090ffBlue|r |cff19ff19colored instance names, indicate|r |cff0090ffextended|r |cff19ff19IDs.|r"], nil, "LEFT", colcount)
	end
	
	if Broker_RaidSaveConfig.ShowSlider then
		tooltip:UpdateScrolling(Broker_RaidSaveConfig.SliderMaxHeight)	
	end
	
end

function addon:GetDungeonDifficultyText(setting, isRaid, withpar)
 	local par1, par2 = "", ""
 	if withpar then par1, par2 = "(", ")" end
 	local diffstr = "|cffffff9a"..par1.._G["UNKNOWN"]..par2.."|r"
 	if not setting then return diffstr end
	if isRaid then
	-- raids
	if not _G["RAID_DIFFICULTY"..tostring(setting)] then return diffstr end
	-- remove () chars from difficulty
	local tmpstr = string.gsub(_G["RAID_DIFFICULTY"..tostring(setting)], "%(", "")
	tmpstr = string.gsub(tmpstr, "%)", "")
		if setting == 3 or setting == 4 then
			diffstr = _G["RED_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		else
			diffstr = _G["GREEN_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		end
	else
	-- dungeons
	if not _G["DUNGEON_DIFFICULTY"..tostring(setting)] then return diffstr end
	-- remove () chars from difficulty
	local tmpstr = string.gsub(_G["DUNGEON_DIFFICULTY"..tostring(setting)], "%(", "")
	tmpstr = string.gsub(tmpstr, "%)", "")
		if setting == 2 or setting > 2 then
			diffstr = _G["RED_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		else
			diffstr = _G["GREEN_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		end
	end
	return diffstr
end

function addon:Refresh()	
	local player = Broker_RaidSaveConfig.realm[GetRealmName()].char[GetUnitName("player")]
	player.numsaved = GetNumSavedInstances()
	player.numactive, player.numgroup, player.numraid = 0, 0, 0
	player.instance = {}
	if player.numsaved == 0 then
	else
		local iname, iid, iexpires, idiff, ilocked, iextended, iidmostsig, iisraid, temp
		for i = 1, player.numsaved do
			iname, iid, iexpires, idiff, ilocked, iextended, iidmostsig, iisraid = GetSavedInstanceInfo(i)
			if iexpires > 0 then
				iexpires = iexpires + time()
				player.numactive = player.numactive + 1
				if iisraid == true then
					player.numraid = player.numraid + 1
				elseif iisraid == false then
					player.numgroup = player.numgroup + 1
				end
			end
			-- insert data into table
			temp = { name = iname, id = iid, idMostSig = iidmostsig, expires = iexpires, difficulty = idiff, locked = ilocked, extended = iextended, israid = iisraid }
			table.insert(player.instance, temp)
		end
	end
	self:Update()
	if tooltip and tooltip:IsVisible() then -- update tooltip if it exists and is visible
		tooltip:Clear()
		addon:Drawtooltip()
	end
end

function addon:GetDaysInMonth(year, month)
	local function is_leap_year(year)
		return year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)
	end
	return month == 2 and is_leap_year(year) and 29 or ("\31\28\31\30\31\30\31\31\30\31\30\31"):byte(month)
end

function addon:ClassColorise(class, targetstring)
	local colortable = _G["CUSTOM_CLASS_COLORS"] or _G["RAID_CLASS_COLORS"]
	local r = string.format("%x", math.floor(colortable[class].r * 255))
	if strlen(r) == 1 then
		r = "0"..r
	end
	local g = string.format("%x", math.floor(colortable[class].g * 255))
	if strlen(g) == 1 then
		g = "0"..g
	end
	local b = string.format("%x", math.floor(colortable[class].b * 255))
	if strlen(b) == 1 then
		b = "0"..b
	end
	return "|cff"..r..g..b..targetstring.."|r"
end

function addon:FormatDate(seconds)
if not seconds then return end
	local datestring = ""
	local daym = date("%d", seconds).."/"
	local month = date("%m", seconds).."/"
	local year = date("%Y", seconds).."/"
	
	if Broker_RaidSaveConfig.formatdayw then
		datestring = date("%a", seconds).." "
	end
	
	if Broker_RaidSaveConfig.formatdate == "USAmerican" then
		datestring = datestring..month..daym..year
	elseif Broker_RaidSaveConfig.formatdate == "European" then
		datestring = datestring..daym..month..year
	else -- Chinese
		datestring = datestring..year..month..daym
	end
	return strsub(datestring, 1, strlen(datestring) - 1)
end

function addon:FormatTime(seconds)
if not seconds then return end
	local timestring = ""
	if Broker_RaidSaveConfig.formattime == "Show12" then
		timestring = date("%I", seconds)..":"..date("%M", seconds).." "..date("%p", seconds)
	elseif Broker_RaidSaveConfig.formattime == "Show24" then
		timestring = date("%H", seconds)..":"..date("%M", seconds)
	end
	return timestring
end

function addon:UPDATE_INSTANCE_INFO()
  self:Refresh()
end

function addon:RAID_INSTANCE_WELCOME()
	RequestRaidInfo()
end

function addon:CHAT_MSG_SYSTEM(msg)
	if tostring(msg) == _G["INSTANCE_SAVED"] then
		RequestRaidInfo()
	end
end

function addon:OnEnable()
	if not Broker_RaidSaveConfig then
		-- initialize default configuration
		Broker_RaidSaveConfig = {
			realm = {},    
			textwhenzero = false,
			shorttext = false,
			showid = true,
			showdiff = true,
			showcooldown = true,
			formatcooldown = "Full",
			showreset = true,
			formatdate = "USAmerican",
			formattime = "Show24",
			formatdayw = false,
			sortbyinstancename = true,
			sortbyinstancediff = false,
			instancenameorder = "desc",
			instancedifforder = "desc",
			hideexpiredtip = false,
			hideexpiredbutton = false,
			SliderMaxHeight = 600,
			ShowSlider = true,
			HideHint = false
		}
	end

  	-- added config options for v2.0
  	if not Broker_RaidSaveConfig.HideHint then Broker_RaidSaveConfig.HideHint = false end
  	if not Broker_RaidSaveConfig.ShowSlider then Broker_RaidSaveConfig.ShowSlider = false end
  	if not Broker_RaidSaveConfig.SliderMaxHeight then Broker_RaidSaveConfig.SliderMaxHeight = 600 end
  	-- added config options for v1.7-v1.8
  	if not Broker_RaidSaveConfig.hideexpiredtip then Broker_RaidSaveConfig.hideexpiredtip = false end
  	if not Broker_RaidSaveConfig.hideexpiredbutton then Broker_RaidSaveConfig.hideexpiredbutton = false end
  	-- added config options for v1.4
  	if not Broker_RaidSaveConfig.sortbyinstancename then Broker_RaidSaveConfig.sortbyinstancename = false end
  	if not Broker_RaidSaveConfig.sortbyinstancediff then Broker_RaidSaveConfig.sortbyinstancediff = false end
  	if not Broker_RaidSaveConfig.instancenameorder then Broker_RaidSaveConfig.instancenameorder = "desc" end
  	if not Broker_RaidSaveConfig.instancedifforder then Broker_RaidSaveConfig.instancedifforder = "desc" end
	-- added config options for v1.2
	if not Broker_RaidSaveConfig.showdiff then Broker_RaidSaveConfig.showdiff = false end
	-- additional initialization
	if not Broker_RaidSaveConfig.realm[GetRealmName()] then
		Broker_RaidSaveConfig.realm[GetRealmName()] = { }
	end
	if not Broker_RaidSaveConfig.realm[GetRealmName()].char then
		Broker_RaidSaveConfig.realm[GetRealmName()].char = { }
	end
	if not Broker_RaidSaveConfig.realm[GetRealmName()].name then
		Broker_RaidSaveConfig.realm[GetRealmName()].name = GetRealmName()
	end
	if not Broker_RaidSaveConfig.realm[GetRealmName()].char[GetUnitName("player")] then
		Broker_RaidSaveConfig.realm[GetRealmName()].char[GetUnitName("player")] = { }
	end
	local player = Broker_RaidSaveConfig.realm[GetRealmName()].char[GetUnitName("player")]
	if not player.numsaved then
		player.numsaved = 0
	end
	if not player.instance then
		player.instance = { }
	end
	player.name = GetUnitName("player")
	player.class = strupper(select(2,UnitClass("player")))
	--workaround for DK class name to properly match global string entry for raid class colors
	player.class = string.gsub(player.class, " ", "")
	
		-- events registration
	addon:RegisterEvent("UPDATE_INSTANCE_INFO")
	addon:RegisterEvent("RAID_INSTANCE_WELCOME")
	addon:RegisterEvent("CHAT_MSG_SYSTEM")
end