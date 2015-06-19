local AddonName = "ChatsToMSBT"
local FriendlyAddonName = "Chats To MSBT"

C2MSBT.Config = {}
local Config = C2MSBT.Config

-- Config Panel Text Strings
Config.Text1={
Title = FriendlyAddonName,
TitleSub = "Change how the AddOn behaves by setting the options below",
Enable = "Enable The AddOn to function",
PerChar = "Save settings per character",
DisplayModes = "Display message mode in alert message",
Guild = "Put Guild chat into MSBT",
Party = "Put Party chat into MSBT",
Say = "Put Say chat into MSBT",
Whispers = "Put whispers into MSBT",
Raid = "Put Raid chat into MSBT",
BGs = "Put Instance chat into MSBT",
Chats = "Put other chat into MSBT",
Yell = "Put Yell chat into MSBT",
Emotes = "Put Emotes into MSBT",
}

Config.Text2={
Title = "Channel List",
TitleSub = "Select channels to copy to MSBT",
TitleSub2 = "Chans you are in  / Chans that will go to MSBT if you are in",
ChanBox = "Channel Name",
AddButton = "Add",
DeleteButton = "Delete",
}

Config.Text3={
Title = "Custom Output",
TitleSub = "Select custom MSBT frames for output",
Enable = "Enable custom MSBT outputs",
Guild = "Guild chats to a custom MSBT output",
Party = "Party chats to a custom MSBT output",
Raid = "Raid chats to a custom MSBT output",
BGs = "Battlegrounds to a custom MSBT output",
Chats = "Chats to a custom MSBT output",
Say = "Says to a custom MSBT output",
Whispers = "Whispers to a custom MSBT output", 
Yell = "Yells to a custom MSBT output",
Emotes = "Emotes to a custom MSBT output",
ChanList = {}, }

-- Local text colors
local yel = "|cFFFFFF00"
local wht = "|cFFFFFFFF"
local blu = "|cFF00FFFF"
local red = "|cFFFF0000"
local grn = "|cFF00FF00"
local res = "|r"

-- Bill's Utils
local Wait = BillsUtils.Wait
local ChkBox = BillsUtils.ChkBox
local ChkBoxSave = BillsUtils.ChkBoxSave
local CheckClick = BillsUtils.CheckClick
local SliderMW = BillsUtils.SliderMW

BillsUtils.Locals[#BillsUtils.Locals +1] = function () --function is called if/when a newer version of Bill's Utils loads after the addon is loaded
	Wait = BillsUtils.Wait
	ChkBox = BillsUtils.ChkBox
	ChkBoxSave = BillsUtils.ChkBoxSave
	CheckClick = BillsUtils.CheckClick
	SliderMW = BillsUtils.SliderMW
end


-- General Settings / functions
local X = 16 -- standard Horizontal Spacing
local Y = 35 -- standard Vertical spacing 26
local TxtY = 13


--Panel
Config.panel = CreateFrame( "Frame", AddonName.."Config1", UIParent )
local me = Config.panel
me:SetScript("OnLoad", function()
	me.init()
end)


me.name = FriendlyAddonName
	
-- Panel title
local Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" )
Title:SetPoint( "TOPLEFT", 16, -16 )
Title:SetText( Config.Text1.Title )
local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
SubText:SetPoint( "TOPLEFT", Title, "BOTTOMLEFT", 0, -8 )
SubText:SetPoint( "RIGHT", -32, 0 )
SubText:SetHeight( 32 )
SubText:SetJustifyH( "LEFT" )
SubText:SetJustifyV( "TOP" )
SubText:SetText( Config.Text1.TitleSub )

-- Check Boxes & Text
local last = SubText
local Command = {	"Enable", "PerChar", "DisplayModes", "Guild", "Party", "Say", "Whispers", "Raid", "BGs", "Chats", "Yell", "Emotes", }

for x = 1, #Command do
	me[ Command[x] ] = ChkBox( last , AddonName.."Cfg", Command[x] , me, CheckClick, Config.Text1 )
	last = me[ Command[x] ]
	end
	
--	End of frame



-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- X  Init / Reset the config panel to match current settings                                                     X
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--


me.Init = function(...)
	local Table = C2MSBT_Settings
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC
	end

	local me = Config.panel
	
	local Command = {	"Enable", "PerChar", "DisplayModes", "Guild", "Party", "Say", "Whispers", "Raid", "BGs", "Chats", "Yell", "Emotes", }
	for x = 1, #Command do
		me[Command[x]]:SetChecked(Table[Command[x]])
	end
	
	me.PerChar:SetChecked( C2MSBT_SettingsPC.PerChar )
end

-- Reset config panel and settings to DEFAULT
me.Reset = function(...)
	local cur = C2MSBT_Settings
	local def = C2MSBT_Settings_Defaults
	
	if C2MSBT_SettingsPC.PerChar then
		cur = C2MSBT_SettingsPC
		def = C2MSBT_SettingsPC_Defaults
	end

	local Command = {	"Enable", "PerChar", "DisplayModes", "Guild", "Party", "Say", "Whispers", "Raid", "BGs", "Chats", "Yell", "Emotes", }
	for x = 1, #Command do
		cur[Command[x]] = def[Command[x]]
	end
	
	C2MSBT_SettingsPC.PerChar = C2MSBT_SettingsPC_Defaults.PerChar
	
	me.Init()
end



me.refresh = function(self)
	me.Init()
end

me.default = function (self)
	me.Reset()
end

me.cancel = function (self)
	me.Init()
end

-- Save settings from config panel
me.okay = function(self)
	ChkBoxSave( Config.panel, "PerChar", C2MSBT_SettingsPC )
	local Table = C2MSBT_Settings
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC
	end
	local Command = {	"Enable", "DisplayModes", "Guild", "Party", "Say", "Whispers", "Raid", "BGs", "Chats", "Yell", "Emotes", }
	for x = 1, #Command do
		ChkBoxSave( Config.panel, Command[x], Table)
	end
		
	C2MSBT.EventManager()
end

-- Register the config panel
InterfaceOptions_AddCategory( me )

-- ****************************************************************************
-- * Channel List Daughter Panel                                              *
-- ****************************************************************************

--Panel
Config.panel2 = CreateFrame( "Frame", AddonName.."Config2", UIParent )
local me = Config.panel2
me.InChan = {}
me.ListenChan = {}

me.name = Config.Text2.Title
me.parent = Config.panel.name


me.ChanBoxUpdate = function( Caller, count)
	if Caller == "ListenChan" then
		local ChanList = C2MSBT_Settings.ChanList
		if C2MSBT_SettingsPC.PerChar then
			ChanList = C2MSBT_SettingsPC.ChanList
		end
		
		local maxcount = #ChanList
		local slider = me.slider:GetValue()
		if count + slider > maxcount then
			me.ChanBox:SetText("")
		else
			me.ChanBox:SetText(ChanList[count + slider])
		end
	elseif Caller == "InChan" then
		local ChanList = { GetChannelList() }
		local maxcount = #ChanList / 2
		if count > maxcount then
			me.ChanBox:SetText("")
		else
			me.ChanBox:SetText(ChanList[count * 2])
		end
	end
end


me.ChanDisplayUpdate = function()
	local ChanList = C2MSBT_Settings.ChanList
	if C2MSBT_SettingsPC.PerChar then
		ChanList = C2MSBT_SettingsPC.ChanList
	end
	local maxcount = #ChanList
	local slider = me.slider:GetValue()

	for x = 1 , 10 do
		if x + slider > maxcount then
			me.ListenChan[x]:SetText( " " )
		else
			me.ListenChan[x]:SetText( ChanList[x + slider] )
		end
	end
	me.slider:SetMinMaxValues( 0, (maxcount > 10 and maxcount - 10) or 1 )
	
	local InChanList = { GetChannelList() }
	local InChanListMax = #InChanList /2

	for x = 1, 10 do
		if x > InChanListMax then
			me.InChan[x]:SetText( " " )
		else
			me.InChan[x]:SetText( InChanList[x*2] )
		end
	end
end


	-- Pane title
local Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" )
Title:SetPoint( "TOPLEFT", 16, -16 )
Title:SetText( Config.Text2.Title )
local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
SubText:SetPoint( "TOPLEFT", Title, "BOTTOMLEFT", 0, -8 )
SubText:SetPoint( "RIGHT", -32, 0 )
SubText:SetHeight( 32 )
SubText:SetJustifyH( "LEFT" )
SubText:SetJustifyV( "TOP" )
SubText:SetText( Config.Text2.TitleSub  )
local SubText2 = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
SubText2:SetPoint( "TOPLEFT", TitleSub, "BOTTOMLEFT", 0, -8 )
SubText2:SetPoint( "RIGHT", -32, 0 )
SubText2:SetHeight( 32 )
SubText2:SetJustifyH( "LEFT" )
SubText2:SetJustifyV( "TOP" )
SubText2:SetText( Config.Text2.TitleSub2  )
	
local last = me
local width = 150 

for x = 1, 10 do
	me.InChan[x] = CreateFrame("Button", AddonName.."InChanListButton"..tostring(x), me, "UIPanelButtonTemplate" )
	if last == me then
		me.InChan[x]:SetPoint("TOPLEFT", last, "TOPLEFT", 20, -60 )
	else
		me.InChan[x]:SetPoint("TOPLEFT", last, "BOTTOMLEFT" )
	end
	me.InChan[x]:SetSize( width , 20)
	me.InChan[x]:SetText( " " )
	me.InChan[x].count = x
	me.InChan[x]:SetScript("OnClick", function(self, button, down)
		if (button ~= "LeftButton") then
			return
		end
		PlaySound( "GAMEGENERICBUTTONPRESS" )
		me.ChanBoxUpdate( "InChan", self.count )
		return
	end)
	last = me.InChan[x]

	me.ListenChan[x] = CreateFrame("Button", AddonName.."ListenChanListButton"..tostring(x), me, "UIPanelButtonTemplate" )
	me.ListenChan[x]:SetPoint("TOPLEFT", last, "TOPRIGHT", 20, 0 )
	me.ListenChan[x]:SetSize( width , 20)
	me.ListenChan[x]:SetText( " " )
	me.ListenChan[x].count = x
	me.ListenChan[x]:SetScript("OnClick", function(self, button, down)
		if (button ~= "LeftButton") then
			return
		end
		PlaySound( "GAMEGENERICBUTTONPRESS" )
		me.ChanBoxUpdate( "ListenChan", self.count )
		return
	end)
end


me.slider = CreateFrame( "Slider", AddonName.."ChanListSlider", me, "OptionsSliderTemplate" )
me.slider:SetMinMaxValues( 0, 1 )
me.slider:SetOrientation("VERTICAL")
me.slider:SetPoint("TOPLEFT", me.ListenChan[1] ,"TOPRIGHT", 5 , 0)
me.slider:SetPoint("BOTTOMLEFT", me.ListenChan[10] ,"BOTTOMRIGHT", 5 , 0)
me.slider:SetValueStep( 1 )
me.slider:SetWidth( 16 )	
me.slider:SetScript( "OnValueChanged", function( self )
	PlaySound( "GAMEGENERICBUTTONPRESS" )
	me.ChanDisplayUpdate()
end)
getglobal(me.slider:GetName() .. 'Low'):SetText( " " )
getglobal(me.slider:GetName() .. 'High'):SetText( " " )
me.slider:SetScript("OnMouseWheel", function(self, delta)
	SliderMW(self, -delta)
end)

me.ChanBox = CreateFrame( "EditBox", AddonName.."ChanEditbox", me, "InputBoxTemplate" )
me.ChanBox:SetFontObject("ChatFontNormal")
me.ChanBox:SetTextInsets(0, 0, 3, 3)
me.ChanBox:SetPoint("BOTTOMLEFT", me , "BOTTOMLEFT", 30 , 50 )
me.ChanBox:SetPoint("RIGHT", -32, 0)
me.ChanBox:SetHeight(19)
me.ChanBox:SetWidth(50)
me.ChanBox:SetAutoFocus(false)
me.ChanBox:SetMaxLetters( 254 )
me.ChanBox:SetScript("OnEnterPressed" , function(self)
	self:ClearFocus()
end)
me.ChanBox:SetScript("OnEscapePressed", function(self)
	self:SetText( "" )
	self:ClearFocus()
end)

me.ChanBox.Text = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
me.ChanBox.Text:SetPoint( "BOTTOMLEFT", me.ChanBox , "BOTTOMLEFT", 0 , Y/4 )
me.ChanBox.Text:SetPoint( "RIGHT", -32, 0 )
me.ChanBox.Text:SetHeight( 32 )
me.ChanBox.Text:SetJustifyH( "LEFT" )
me.ChanBox.Text:SetJustifyV( "TOP" )
me.ChanBox.Text:SetText( Config.Text2.ChanBox )

me.AddButton = CreateFrame("Button", AddonName.."ChanListAddButton", me, "UIPanelButtonTemplate" )
me.AddButton:SetPoint("BOTTOMLEFT", me, "BOTTOMLEFT", 20 , 20 )
me.AddButton:SetSize( 150, 25)
me.AddButton:SetText(Config.Text2.AddButton)
me.AddButton:SetScript("OnClick", function(self, button, down)
	if (button ~= "LeftButton") then
		return
	end
	PlaySound( "GAMEGENERICBUTTONPRESS" )
	C2MSBT.Channel("add", me.ChanBox:GetText() )
	me.ChanBox:SetText("")
	me.ChanBox:ClearFocus()
	me.ChanDisplayUpdate()
	return
end)

me.DeleteButton = CreateFrame("Button", AddonName.."ChanListDeleteButton", me, "UIPanelButtonTemplate" )
me.DeleteButton:SetPoint("BOTTOMRIGHT", me, "BOTTOMRIGHT", -20 , 20 )
me.DeleteButton:SetSize( 150, 25)
me.DeleteButton:SetText("Delete")
me.DeleteButton:SetScript("OnClick", function(self, button, down)
	if (button ~= "LeftButton") then
		return
	end
	PlaySound( "GAMEGENERICBUTTONPRESS" )
	C2MSBT.Channel("rem", me.ChanBox:GetText() )
	me.ChanBox:SetText("")
	me.ChanBox:ClearFocus()
	me.ChanDisplayUpdate()
	return
end)

me.refresh= function( self )
	me.slider:SetValue(0)
	me.ChanDisplayUpdate()
end


InterfaceOptions_AddCategory( me )

-- ****************************************************************************
-- * Custom Channel Output Daughter Panel        (Panel Strings #3)           *
-- ****************************************************************************

--Panel
Config.panel3 = CreateFrame( "Frame", AddonName.."Config3", UIParent )
local me = Config.panel3

me.name = Config.Text3.Title
me.parent = Config.panel.name

-- Pane title
local Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" )
Title:SetPoint( "TOPLEFT", 16, -16 )
Title:SetText( Config.Text3.Title )
local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
SubText:SetPoint( "TOPLEFT", Title, "BOTTOMLEFT", 0, -8 )
SubText:SetPoint( "RIGHT", -32, 0 )
SubText:SetHeight( 32 )
SubText:SetJustifyH( "LEFT" )
SubText:SetJustifyV( "TOP" )
SubText:SetText( Config.Text3.TitleSub )

local last = SubText

-- local functions
local items = {}
local level = 1

local function OnClick(self)
	UIDropDownMenu_SetSelectedID( UIDROPDOWNMENU_OPEN_MENU, self:GetID())
end

local function initialize(self, level)
	local info = UIDropDownMenu_CreateInfo()
	
	local count = 0
	local selected = 0
	local Key = {}
	local name = self:GetName()
	local Command = string.sub( name, 18 , -5)
	local Table = C2MSBT_Settings
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC
	end
	
	for scrollAreaKey, scrollAreaName in MikSBT.IterateScrollAreas()  do
		count = count + 1
		info = UIDropDownMenu_CreateInfo()
		info.text = scrollAreaName
		info.value = scrollAreaKey
		info.func = OnClick
		if Table.CustomOutput.Enable and Table.CustomOutput[Command] then
			if Table.CustomOutputFrame[ Command ] == info.text then
				info.checked = true
				selected = count
			elseif Table.CustomOutputFrame[ Command ] == "" then
				if info.text == "Notification" then
					info.checked = true
					selected = count
				end
			end
		else
			if info.text == "Notification" then
				info.checked = true
				selected = count
			end
		end
		UIDropDownMenu_AddButton(info, level)
		Key[scrollAreaName] = scrollAreaKey
	end
	UIDropDownMenu_SetSelectedID( UIDROPDOWNMENU_INIT_MENU , selected ) 
end

-- Check Boxes & Text & Menu
local Table = C2MSBT_Settings
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC
	end
local Command = {	"Enable", "Guild", "Party", "Say", "Whispers", "Raid", "BGs", "Chats", "Yell", "Emotes", }
for x = 1, #Command do
	me[ Command[x] ] = ChkBox( last , AddonName.."CustChkBox", Command[x], me, CheckClick, Config.Text3 )
	if x > 1 then
		me[ Command[x] ].Menu = CreateFrame("Button", AddonName.."CustChan"..Command[x].."Menu", me, "UIDropDownMenuTemplate")
		me[ Command[x] ].Menu.displayMode = "MENU"
		me[ Command[x] ].Menu:ClearAllPoints()
		me[ Command[x] ].Menu:SetPoint("BOTTOMLEFT", me[ Command[x] ], "BOTTOMRIGHT", 215, 0)
		UIDropDownMenu_Initialize(me[ Command[x] ].Menu, initialize)
		UIDropDownMenu_SetWidth(me[ Command[x] ].Menu, 100);
		UIDropDownMenu_SetButtonWidth(me[ Command[x] ].Menu, 124)
		UIDropDownMenu_JustifyText(me[ Command[x] ].Menu, "LEFT")
	end
	
	last = me[ Command[x] ]
end


me.Init = function(...)
	local Table = C2MSBT_Settings.CustomOutput
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC.CustomOutput
	end

	local Command = { "Enable", "Guild", "Party", "BGs", "Raid", "Say", "Whispers", "Yell", "Emotes", "Chats" }
	
	for x = 1, #Command do
		me[ Command[x] ]:SetChecked( Table[ Command[x]] )
	end
end

-- Reset config panel and settings to DEFAULT
me.Reset = function(...)
	local cur = C2MSBT_Settings
	local def = C2MSBT_Settings_Defaults
	
	if C2MSBT_SettingsPC.PerChar then
		cur = C2MSBT_SettingsPC
		def = C2MSBT_SettingsPC_Defaults.CustomOutput
	end
	
	cur.CustomOutput.Enable = def.CustomOutput.Enable
	local Mode = {"CustomOutput", "CustomOutputFrame" }
	local Command = {"Guild", "Party", "BGs", "Raid", "Say", "Whispers", "Yell", "Emotes", "Chats"}
	for y = 1, #Mode do
		for x = 1, #Command do
			cur[Mode][Command] = def[Mode][Command]
			
		end
	end
	for x = 1, #Command do
		ToggleDropDownMenu( nil, nil, me[Command[x]].Menu ) 
		ToggleDropDownMenu( nil, nil, me[Command[x]].Menu )
	end
		
	me.Init()
end

me.refresh = function(self)
	me.Init()
end

me.default = function (self)
	me.Reset()
end

me.cancel = function (self)
	me.Init()
end

-- Save settings from config panel
local DropMenuSave = function( Panel, Command, Table, Var )
	if Var == nil then
		Var = Command
	end
	
	local MenuText = UIDropDownMenu_GetText(Panel[Command].Menu) 
	local SavedText = Table[Var]
	
	if SavedText == MenuText or (SavedText == "" and MenuText == "Notification") then
		return
	end
	Table[Var] = MenuText
	return
end

me.okay = function(self)
	local Table = C2MSBT_Settings.CustomOutput
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC.CustomOutput
	end
	
	local Command = {"Enable", "Guild", "Party", "BGs", "Raid", "Say", "Whispers", "Yell", "Emotes", "Chats"}
	
	for x = 1, #Command do
		ChkBoxSave( Config.panel3, Command[x], Table, Command[x])
	end
	
	local Table = C2MSBT_Settings.CustomOutputFrame
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC.CustomOutputFrame
	end
	
	local Command = {"Guild", "Party", "BGs", "Raid", "Say", "Whispers", "Yell", "Emotes", "Chats"}
	for x = 1, #Command do
		DropMenuSave( me, Command[x], Table)
	end
	
end


--	End of frame
InterfaceOptions_AddCategory( me )

