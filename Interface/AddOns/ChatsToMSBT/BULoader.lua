-- ****************************************************************************
-- * Addon Specific Settings                                                  *
-- * Nothing to change here anymore                                           *
-- ****************************************************************************
local AddonName, _ = ...


-- ****************************************************************************
-- * Library Settings                                                         *
-- ****************************************************************************

local Version = "2014-10-15"


-- ****************************************************************************
-- * Bill's Utils loader                                                      *
-- ****************************************************************************
local HigherVersion = false
local Ver = {string.split("-", Version)}

if type( BillsUtils ) ~= "table" then
	BillsUtils = {}
	BillsUtils.LoadedBy = {}
	BillsUtils.LoadedBy[1] = AddonName
	BillsUtils.Locals = {}
	HigherVersion = true
else
	BillsUtils.LoadedBy[#BillsUtils.LoadedBy +1] = AddonName
	local ThisVersion = tonumber( Ver[1]..Ver[2]..Ver[3] )
	local LoadedVersion = tonumber(BillsUtils.Version[1]..BillsUtils.Version[2]..BillsUtils.Version[3])
	
	if ThisVersion > LoadedVersion then
		HigherVersion = true
	end
end

if HigherVersion then

	local BU = BillsUtils
	BU.Version = { string.split("-", Version) }
	BU.AddonName = AddonName
	
	local on = true
	local off = false
	local X = 16 -- standard Horizontal Spacing
	local Y = 35 -- standard Vertical spacing 26
	local TxtY = 13

-- Wait/Delay function
	local waitTable = {}
	local waitFrame = nil

	BU.Wait = function(delay, func, ...)
		if(type(delay)~="number" or type(func)~="function") then
			return false
		end
	
		if(waitFrame == nil) then
			waitFrame = CreateFrame("Frame","WaitFrame", UIParent)
			waitFrame:SetScript("onUpdate",function (self,elapse)
				local count = #waitTable
				local i = 1;
				while(i<=count) do
					local waitRecord = tremove(waitTable,i)
					local d = tremove(waitRecord,1)
					local f = tremove(waitRecord,1)
					local p = tremove(waitRecord,1)
					if(d>elapse) then
						tinsert(waitTable,i,{d-elapse,f,p})
						i = i + 1
					else
						count = count - 1
						f(unpack(p))
					end
				end
			end)
		end
		tinsert(waitTable,{delay,func,{...}})
		return true
	end

-- Add Meta Tables to Variables
	BU.addOptionMt = function(options, defaults)
		setmetatable(options, {__index = defaults})
		for i, v in pairs(options) do
			if type(v) == "table" and not getmetatable(v) then
				BU.addOptionMt(v, defaults[i])
			end
		end
	end
	
-- Return Colored status
	BU.StatColor = function( stat, dual, ... )
		local msg, postfix
		if select( "#", ... ) > 0 then
			local args = {...}
			postfix = "|cFF888888"
			for x = 1, #args do
				postfix = postfix.."["..args[x].."]"
			end
		end
		local vtype = type( stat )
		if vtype == "boolean" then
			if dual and stat then
				msg = "|cFF00FF00[*ON*]|cFFFF0000[off]"
			elseif dual and not(stat) then
				 msg = "|cFF00FF00[on]|cFFFF0000[*OFF*]"
			elseif stat then
				msg = "|cFF00FF00[ON]"
			else
				msg = "|cFFFF0000[OFF]"
			end
		elseif vtype == "number" then
			if stat == 0 then
				msg = "|cFFFF0000[0] (DISABLED)"
			elseif stat > 0 then
				msg = string.format("|cFF00FF00[%i] second(s)", stat)
			end
		end
		if msg and postfix then
			return msg..postfix
		elseif msg then
			return msg
		end
		return stat 
	end

-- Return the color code for passed class (In Caps)
	BU.CCC = function(class)
		if class == nil or not(RAID_CLASS_COLORS[class]) then
			return ("|cFF%02X%02X%02X"):format( 187, 187, 187)
		end
		return ("|c%s"):format( RAID_CLASS_COLORS[class].colorStr )
	end

-- String Join print
	BU.SJprint = function(...)
		print( string.join(" ", ...))
	end
	
-- Sorts 2 tables where x in both tables are related
	BU.LinkedSort = function( main, linked )
		if #main == 0 or #linked == 0 then
			return false
		end
		if #main ~= #linked then
			return false
		end
	
		local sorted
		repeat
			sorted = true
			for x = #main -1, 1, -1 do
				if main[x] > main[x+1] then
					main[x], main[x+1] = main[x+1], main[x]
					linked[x], linked[x+1] = linked[x+1], linked[x]
					sorted = false
				end
			end
		until sorted	
	end

-- First Letter Capitalizer
	BU.FLCap = function( word )
		if type( word ) ~= "string" then
			return word
		end
		if string.len( word ) == 1 then
			return string.upper(word)
		end
		
		return (string.upper(string.sub(word, 1, 1))..string.sub(word, 2))
	end
	
-- ****************************************************************************
-- * Cmd Line Utils                                                           *
-- ****************************************************************************

local States = { ["on"] = true,	  ["yes"] = true, 	["true"] = true,	["1"] = true,
				 ["off"] = false, ["no"] = false,	["false"] = false, 	["0"] = false,
				}

-- Checks CmdLine switches against variable and changes var if needed true/false on/off
	BU.OptSaveTF = function( Table, Key, Value)
		local BoolVal
	
		if type(Value) == "string" and type(States[Value]) == "boolean" then
			BoolVal = States[Value]
		elseif type(Value) == "boolean" then
			BoolVal = Value
		else
			return
		end
		
		if Table[Key] ~= BoolVal then
			Table[ Key ] = BoolVal
		end
	end

-- Checks CmdLine switches against variable and changes var if needed  and value in range
	BU.OptSaveVal = function( Table, Key, Value, Min, Max)
		local Saved = Table[ Key ]
		local vtype = type(Value)
		
		if vtype == "nil" then
			return
		elseif vtype == "string" then
			Value = tonumber(Value)
		end
	
		if Value ~= Saved then
			if Value >= Min and Value <= Max then
				Table[ Key ] = Value
			end
		end
	end

-- ****************************************************************************
-- * Check Box Utils                                                          *
-- ****************************************************************************

	BU.ChkBox = function( Last, Prefix, Name, Parent, Click, TextOrTable, TextName, OffsetX, OffsetY )
		local box, text
		if type(TextOrTable) == "string" then
			text = TextOrTable
		elseif type(TextName) == "nil" then
			text = TextOrTable[Name]
		else
			text = TextOrTable[TextName]
		end
		
		box = CreateFrame( "CheckButton", Prefix..Name.."Checkbox", Parent, "InterfaceOptionsCheckButtonTemplate" )
		
		if OffsetX and OffsetY then
			box:SetPoint("TOPLEFT", Parent, "TOPLEFT", OffsetX, OffsetY)
		elseif Last == Parent then
			box:SetPoint("TOPLEFT", Last ,"TOPLEFT", X*1.25 , -Y/2 )
		else
			box:SetPoint("TOPLEFT", Last ,"TOPLEFT", 0, -Y )
		end
		
		box:SetSize( 26, 26 )
		box:SetScript( "OnClick", Click )
	
		_G[Prefix..Name.."CheckboxText"]:SetText( text )
	
		return box
	end

	BU.CheckClick = function()
		PlaySound( "GAMEGENERICBUTTONPRESS" )
	end

-- Checks checkboxes against variable and adjusts variable if needed
	BU.ChkBoxSave = function( Panel, Box, Table, Key)
		if Key == nil then
			Key = Box
		end
		if Panel[ Box ]:GetChecked() ~= Table[Key] then
			Table[ Key ] = Panel[ Box ]:GetChecked()
		end
	end
	
-- Radio Boxes
	BU.Radio = function( last, Prefix, Name, parent, TextOrTable, TextName, count, ButtonTextTable )
		local text
		if type(TextOrTable) == "string" then
			text = TextOrTable
		elseif type(TextName) == "nil" then
			text = TextOrTable[Name]
		else
			text = TextOrTable[TextName]
		end
		
		local radio = parent:CreateFontString( nil, "ARTWORK", "GameFontHighlight" )
		if last == parent then
			radio:SetPoint( "TOPLEFT", last, "TOPLEFT", 10, 0 )
		else
			radio:SetPoint( "TOPLEFT", last, "BOTTOMLEFT", 0, -10 )
		end
		
		radio:SetHeight( 32 )
		radio:SetJustifyH( "LEFT" )
		radio:SetJustifyV( "MIDDLE" )
		radio:SetText( text )
		
		radio.count = count
			
		for x = 1, count do
			radio[x] = CreateFrame( "CheckButton", Prefix..Name.."RadioCheckbox"..x, parent, "InterfaceOptionsCheckButtonTemplate") --"UIRadioButtonTemplate" )
			local button = radio[x]
			button:SetNormalTexture("Interface\\Buttons\\UI-RadioButton" )
			button:GetNormalTexture():SetTexCoord( 0, 0.25, 0, 1 )
			button:SetHighlightTexture("Interface\\Buttons\\UI-RadioButton", "ADD")
			button:GetHighlightTexture():SetTexCoord( 0.5, 0.75, 0, 1)
			button:SetCheckedTexture("Interface\\Buttons\\UI-RadioButton")
			button:GetCheckedTexture():SetTexCoord( 0.25, 0.5, 0, 1)
			button:SetHitRectInsets(0,0,0,0)
			
			button.container = radio
			button.Iam = x
			_G[Prefix..Name.."RadioCheckbox"..x.."Text"]:SetText( ButtonTextTable[x] ) 
			if x == 1 then
				button:SetPoint( "TOPLEFT", radio, "BOTTOMLEFT", 0, -10 )
			else
				button:SetPoint( "LEFT", _G[ radio[x-1]:GetName().."Text"], "RIGHT", 10, 0 )
				button:SetPoint( "TOP", radio[x - 1], "TOP")
			end
			
			button:SetScript("OnClick", function(self)
				local count = 1
				local container = self.container
				local Iam = self.Iam
				while container[count] do
					container[count]:SetChecked(count == Iam)
					count = count + 1
				end
				PlaySound( "GAMEGENERICBUTTONPRESS" )
			end)
			
			
			
		end

		return radio
	end

-- ****************************************************************************
-- * Slider Utils                                                             *
-- ****************************************************************************

	BU.Slider = function( Last , Prefix, Name, Parent, SliderMW , TextOrTable, min, max, step )
		local slider, text
		if type(TextOrTable) == "string" then
			text = TextOrTable
		else
			text = TextOrTable[Name]
		end
		slider = CreateFrame( "Slider", Prefix..Name.."Slider", Parent, "OptionsSliderTemplate" )
		slider:SetMinMaxValues( min, max )
		slider:SetOrientation("HORIZONTAL")
		slider:SetPoint("TOPLEFT", Last ,"TOPLEFT", 0 , -Y * 1.25)
		slider:SetValueStep( step )
		slider:SetWidth( 240 )
		slider:SetHeight( 16 )
		slider:SetObeyStepOnDrag(true)
		slider:SetScript( "OnValueChanged", function( self, value )
			self.Val:SetNumber( self:GetValue() )
			PlaySound( "GAMEGENERICBUTTONPRESS" )
		end)

		getglobal(slider:GetName() .. 'Low'):SetText(tostring(min))
		getglobal(slider:GetName() .. 'High'):SetText(tostring(max))
		getglobal(slider:GetName() .. 'Text'):SetText( text ); --Sets the "title" text (top-centre of slider).
	
		slider:SetScript("OnMouseWheel", function(self, delta)
			SliderMW(self, delta)
		end)
		return slider
	end

	BU.SliderEditBox = function( Slider , Prefix, Name, Parent )
		local Val
		Val=CreateFrame("EditBox", Prefix..Name.."Value", Parent, "InputBoxTemplate")
		Val:SetFontObject("ChatFontNormal")
		Val:SetTextInsets(0, 0, 3, 3)
		Val:SetPoint("BOTTOMLEFT", Slider , "BOTTOMRIGHT", X , -8)
		Val:SetHeight(19)
		Val:SetWidth(40)
		Val:SetNumeric(true)
		Val:SetAutoFocus(false)
		Val:SetMaxLetters( 4 )
		Val.Owner = Slider
		Val:SetScript("OnEnterPressed" , function(self)
			local min, max = self.Owner:GetMinMaxValues()
			local val = self:GetNumber()
			if val >= min and val <= max then
				if val ~= self.Owner:GetValue() then
					self.Owner:SetValue(val)
				end
			else
				self:SetNumber(self.Owner:GetValue())
			end
			self:ClearFocus()
		end)
		Val:SetScript("OnEscapePressed", function(self)
			self:SetNumber( self.Owner:GetValue() )
			self:ClearFocus()
		end)
		return Val
	end

-- Checks Slider against variable and changes var if needed
	BU.SliderSave = function( Panel, Slider, Table, Key)
		if type(Key) ~= "string" then
			Key = Slider
		end
		if Panel[Slider]:GetValue() ~= Table[Key] then
			Table[Key] = Panel[Slider]:GetValue()
		end
	end

-- Mousewheel control for sliders
	BU.SliderMW = function(self, delta)
		local minimum, maximum = self:GetMinMaxValues()
		local step = self:GetValueStep()
		local value = self:GetValue()
		if IsShiftKeyDown() then
			step = step + 5
		end
	
		if (delta < 0) then 
			self:SetValue( math.max(value - step, minimum) )
		elseif (delta > 0) then
			self:SetValue( math.min(value + step, maximum) )
		end
	end

-- ****************************************************************************
-- * Edit Box Utils                                                           *
-- ****************************************************************************

	BU.EditBox = function( Last, Prefix, Name, Parent, Table, Key, TextTable, TTKey )
		if TTKey == nil then
			TTKey = Key
		end
	
		local EBox
		EBox = CreateFrame( "EditBox", Prefix..Name.."Editbox", Parent, "InputBoxTemplate" )
		EBox:SetFontObject("ChatFontNormal")
		EBox:SetTextInsets(0, 0, 3, 3)
		EBox:SetPoint("TOPLEFT", Last , "TOPLEFT", 0 ,-Y*2 )
		EBox:SetPoint("RIGHT", -32, 0)
		EBox:SetHeight(19)
		EBox:SetWidth(50)
		EBox:SetAutoFocus(false)
		EBox:SetMaxLetters( 254 )
		EBox:SetScript("OnEnterPressed" , function(self)
			self:ClearFocus()
		end)
		EBox:SetScript("OnEditFocusGained", function(self)
			if self:IsNumeric() then
				self.OldValue = self:GetNumber()
			else
				self.OldValue = self:GetText()
			end
			self:HighlightText()
		end)
		EBox:SetScript("OnEscapePressed", function(self)
			self:SetCursorPosition( 0 )
			if self:IsNumeric() then
				self:SetNumber( self.OldValue )
			else
				self:SetText( self.OldValue )
			end
			self:ClearFocus()
		end)
		EBox:SetScript("OnTabPressed", function(self)
			self:Insert("    ")
		end)
	
		EBox.Text = Parent:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
		EBox.Text:SetPoint( "BOTTOMLEFT", EBox , "BOTTOMLEFT", 0 , Y/4 )
		EBox.Text:SetPoint( "RIGHT", -32, 0 )
		EBox.Text:SetHeight( 32 )
		EBox.Text:SetJustifyH( "LEFT" )
		EBox.Text:SetJustifyV( "TOP" )
		EBox.Text:SetText( TextTable[ TTKey ] )
		return EBox
	end

-- ****************************************************************************
-- * Faction Detection Functions                                              *
-- ****************************************************************************

-- Faction tooltip settings
	local guidCache = {}
    local uTip = CreateFrame("GameTooltip", "uTip", UIParent, "GameTooltipTemplate")
    uTip:SetOwner( WorldFrame, "ANCHOR_NONE") 

-- Faction Check (returns true if player and compared GUID are same faction)
	BU.SameFaction = function( GUID )
		if IsPlayerNeutral() then
			return true
		end
		local _, myFaction = UnitFactionGroup('player')
		return myFaction == BU.FactionByGUID(GUID)
	end

-- Returns a faction from a given GUID for a player character
	BU.FactionByGUID = function(GUID)
    	if not( GUID ) then
    		return false
    	elseif guidCache[GUID] then
			return guidCache[GUID]
		elseif IsPlayerNeutral() then
			return "Neutral"
		end
    	
		uTip:ClearLines()
		uTip:SetHyperlink('unit:'..GUID)
		
		if not(string.find(GUID, "Player-") ) then
			return "Not a player character"
		end
		
		local _, _, _, CompRace = GetPlayerInfoByGUID( GUID )
		
		if CompRace ~= "Pandaren" then -- Non Panda Scan
			local Alliance = { ["Worgen"] = true, ["Draenei"] = true, ["Dwarf"] = true, ["Gnome"] = true, ["Human"] = true, ["NightElf"] = true }
			guidCache[GUID] = Alliance[CompRace] and FACTION_ALLIANCE or FACTION_HORDE
			
		else -- Panda Scan
		
			local tipName, numLines = "uTipTextLeft", uTip:NumLines()
			local faction = _G[tipName..tostring(numLines)]:GetText() == PVP and _G[tipName..tostring(numLines-1)]:GetText() or _G[tipName..tostring(numLines)]:GetText()
			if faction ~= FACTION_ALLIANCE and faction ~= FACTION_HORDE then
				--panda's level is too high compared to ours so just invert our faction 
				local _, myFaction = UnitFactionGroup('player')
				faction = myFaction == FACTION_ALLIANCE and FACTION_HORDE or FACTION_ALLIANCE
			end
			guidCache[GUID] = faction
		end
		
       return guidCache[GUID]
    end

-- ****************************************************************************
-- * Connected Realm Functions and data                                       *
-- ****************************************************************************
	
-- List of currently connected realms in WoW as of 8/20/14
	BU.connectedRealmList = {
		{"Aegwynn", "Bonechewer", "Daggerspine", "Gurubashi", "Hakkar"}, 
		{"Agamaggan", "Archimonde", "Jaedenar", "The Underbog"},
		{"Aggramar", "Fizzcrank"},
		{"Akama", "Dragonmaw", "Mug'thol"},
		{"Alleria", "Khadgar"},
		{"Alexstrasza", "Terokkar"},
		{"Altar of Storms", "Anetheron", "Magtheridon", "Ysondre"},
		{"Alterac Mountains", "Balnazzar", "Gorgonnash", "The Forgotten Coast", "Warsong"},
		{"Andorhal", "Scilla", "Ursin" ,"Zuluhed"},
		{"Antonidas", "Uldum"},
		{"Anub’arak", "Chromaggus", "Chrushridge", "Garithos", "Nathrezim", "Smolderthorn"},
		{"Anvilmar", "Undermine"},
		{"Arygos", "Llane"},
		{"Auchindoun", "Cho'gall", "Laughing Skull"},
		{"Azgalor", "Azshara", "Destromath", "Thunderlord"},
		{"Azjol-Nerub", "Khaz Modan"},
		{"Azuremyst", "Staghelm"},
		{"Black Dragonflight", "Gul'dan", "Skullcrusher"},
		{"Blackhand", "Galakrond"},
		{"Blackwater Raiders", "Shadow Council"},
		{"Blackwing Lair", "Dethecus", "Detheroc", "Lethon", "Haomarush"},
		{"Bladefist", "Kul Tiras"},
		{"Blade's Edge", "Thunderhorn"},
		{"Blood Furnace", "Mannaroth", "Nazjatar"},
		{"Bloodscalp", "Boulderfist", "Dunemaul", "Maiev", "Stonemaul"},
		{"Borean Tundra", "Shadowsong"},
		{"Bronzebeard", "Shandris"},
		{"Burning Blade", "Lightning's Blade", "Onyxia"},
		{"Cairne", "Perenolde"},
		{"Dawnbringer", "Madoran"},
		{"Darrowmere", "Windrunner"},
		{"Dath'Remar", "Khaz'goroth"},
		{"Deathwing", "Executus", "Kalecgos", "Shattered Halls"},
		{"Dentarg", "Whisperwind"},
		{"Doomhammer", "Baelgun"},
		{"Draenor", "Echo Isles"},
		{"Draka", "Suramar"},
		{"Drak’Tharon", "Firetree", "Malorne", "Rivendare", "Spirestone", "Stormscale"},
		{"Drak'thul", "Skywall"},
		{"Dreadmaul", "Thaurissan"},
		{"Drenden", "Arathor"},
		{"Duskwood", "Bloodhoof"},
		{"Eitrigg", "Shu'halo"},
		{"Eldre’Thalas", "Korialstrasz"},
		{"Eonar", "Velen"},
		{"Eredar", "Gorefiend", "Spinebreaker", "Wildhammer"},
		{"Exodar", "Medivh"},
		{"Farstriders", "Silver Hand", "Thorium Brotherhood"},
		{"Fenris", "Dragonblight"},
		{"Frostmane", "Ner'zhul", "Tortheldrin"},
		{"Frostwolf", "Vashj"},
		{"Ghostlands", "Kael'thas"},
		{"Gilneas", "Elune"},
		{"Gnomeregan", "Moonrunner"},
		{"Grizzly Hills", "Lothar"},
		{"Gundrak", "Jubei'Thos"},
		{"Hellscream", "Zangarmarsh"},
		{"Hydraxis", "Terenas"},
		{"Icecrown", "Malygos"},
		{"Kargath", "Norgannon"},
		{"Kilrogg", "Winterhoof"},
		{"Kirin Tor", "Sentinels", "Steamwheedle Cartel"},
		{"Lightninghoof", "Maelstrom", "The Venture Co"},
		{"Malfurion", "Trollbane"},
		{"Misha", "Rexxar"},
		{"Mok'Nathal", "Silvermoon"},
		{"Nagrand", "Caelestrasz"},
		{"Nazgrel", "Nesingwary", "Vek'nilash"},
		{"Nordrassil", "Muradin"},
		{"Quel'dorei", "Sen'jin"},
		{"Ravenholdt", "Twisting Nether"},
		{"Runetotem", "Uther"},
		{"Scarlet Crusade", "Feathermoon"},
		{"Shattered Hand", "Coilfang", "Dark Iron", "Dalvengyr", "Demon Soul"},
		{"Sisters of Elune", "Cenarion Circle"}, 
		{"Tanaris", "Greymane"},
		{"The Scryers", "Argent Dawn"},
		{"Uldaman", "Ravencrest"},
		{"Ysera", "Durotan"}
	}
	
	-- returns list of realms connected to passed realm or false if not connected or error
	BU.RealmGroup = function(realm)
		if not(realm) then return false end
		local list = BU.connectedRealmList
		for x = 1, x < #list do
			for y = 1, #list[x] do
				if realm == list[x][y] then
					return list[x]
				end
			end
		end
		return false	
	end
	
	-- returns true if both passed realms are connected or false if not (or error)
	BU.SameRealmGroup = function(realm1, realm2)
		if not(realm1) or not(realm2) then return false end
		local list = BU.RealmGroup(realm1)
		for x = 1, x < #list do
			if realm2 == list[x] then
				return true
			end
		end
		return false
	end	


-- ****************************************************************************
-- * Misc Functions                                                           *
-- ****************************************************************************

-- PvP Zone Check (returns true if in battleground or designated PvP zone (Tol Barad, Wintersgrasp)
	BU.IsPvPZone = function()
		local inInstance, instanceType = IsInInstance()
		if inInstance then 
			if instanceType == "pvp" or instanceType == "arena" then 
				return true
			end
			return false
		end
		
		local zone = GetRealZoneText()
		local WPvP = false
		if zone == "Wintergrasp" then --WorldPVPArea 1 is Wintergrasp
			WPvP = 1
		elseif zone == "Tol Barad" then --WorldPVPArea 2 is Tol Barad
			WPvP = 2
		end
		
		if WPvP then
			local pvpID, localizedName, isActive, canQueue, startTime, canEnter = GetWorldPVPAreaInfo(WPvP)
			if isActive then
				return true
			end
		end
		return false
	end

-- returns a word based on gender of person passed and the male word variant	
	BU.GenderWord = function( unit, maleWord, GUID)
	-- 					maleWord		unknown,	male, 		female
		local words = { ["his"] = {		"their",	"his", 		"her" },
						["him"] = {		"them", 	"him", 		"her" },
						["himself"] = {	"themself",	"himself", 	"herself" },
						["he"] = {		"it", 		"he", 		"she" },
						["man"] = {		"it",		"man", 		"woman" }, 
						["male"] = {	"it", 		"male", 	"female" },
						["his'"] = {	"its",		"his",		"hers" },
		}
		
		if not(words[maleWord]) then
			return maleWord
		end

		-- WoW sexes = 1(unknown) 2(male) 3(female)
		local sex = 1
		if GUID ~= nil then
			_, _, _, _, sex = GetPlayerInfoByGUID(GUID)
		elseif UnitExists( unit ) then
			sex = UnitSex( unit )
		end
		
		return words[maleWord][sex]
	end

-- Frame Event Registration Toggler
	BU.EventToggle = function( Frame, Table, Key, Event, Enable )
		if type(Enable) ~= "boolean" then
			Enable = true
		end
		
		if not(Enable) then
			if Frame:IsEventRegistered(Event) then
				Frame:UnregisterEvent( Event )
			end
			return
		end
		
		if type(Table) == "table" then
			if Frame:IsEventRegistered(Event) ~= Table[Key] then
				if Table[Key] then
					Frame:RegisterEvent( Event )
				else
					Frame:UnregisterEvent( Event )
				end
			end
		else
			if Frame:IsEventRegistered(Event) ~= Key then
				if Key then
					Frame:RegisterEvent( Event )
				else
					Frame:UnregisterEvent( Event )
				end
			end
		end
	end
	
-- Slash Command
	SLASH_BILLSUTILS1 = "/billsutils"
	SlashCmdList["BILLSUTILS"] = function(msg)
		local cmd,arg = string.split(" ", msg)
		
		print("|cFF00FF00 Bill's Utils v"..BillsUtils.Version[1].."-"..BillsUtils.Version[2].."-"..BillsUtils.Version[3].."  was loaded by "..BillsUtils.AddonName.."|r")
		print("|cFF00FF00 Bill's Utils is being used by "..#BillsUtils.LoadedBy.." add ons. ("..#BillsUtils.Locals.." properly registered files and unknown others)")
		print("|cFF00FF00 Bill's Utils is used and registered by: |r")
		for x = 1, #BillsUtils.LoadedBy do
			print("|cFF00FF00   "..BillsUtils.LoadedBy[x].."|r")
		end
	end
	
-- ****************************************************************************
-- * Update locals if Higher version has been loaded                          *
-- ****************************************************************************
	if #BillsUtils.Locals > 0 then
		for x = 1, #BillsUtils.Locals do
			BillsUtils.Locals[x]()
		end
	end
	


-- End of HigherVersion check
end



   