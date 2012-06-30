--[[--------------------------------------------------------------------
	PhanxConfig-EditBox
	Simple text input widget generator.
	Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber( string.match( "$Revision: 29 $", "%d+" ) )

local lib, oldminor = LibStub:NewLibrary( "PhanxConfig-EditBox", MINOR_VERSION )
if not lib then return end

lib.editboxes = lib.editboxes or { }

if not PhanxConfigEditBoxInsertLink then
	hooksecurefunc( "ChatEdit_InsertLink", function( ... ) return _G.PhanxConfigEditBoxInsertLink( ... ) end )
end

function PhanxConfigEditBoxInsertLink( link )
	for i = 1, #lib.editboxes do
		local editbox = lib.editboxes[ i ]
		if editbox and editbox:IsVisible() and editbox:HasFocus() then
			editbox:Insert( link )
			return true
		end
	end
end

local function OnEnter( self )
	local text = self:GetParent().desc
	if text then
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
		GameTooltip:SetText( text, nil, nil, nil, nil, true )
	end
end

local function OnLeave()
	GameTooltip:Hide()
end

local function OnEditFocusGained( self ) -- print("OnEditFocusGained")
	local text = self:GetText()
	self.currText, self.origText = text, text
	self:HighlightText()
end

local function OnEditFocusLost( self ) -- print("OnEditFocusLost")
	self:SetText(self.origText or "")
	self.currText, self.origText = nil, nil
end

local function OnTextChanged( self )
	if not self:HasFocus() then return end

	local text = self:GetText()
	if text:len() == 0 then text = nil end -- experimental

	local parent = self:GetParent()
	if parent.OnTextChanged and text ~= self.currText then
		parent:OnTextChanged( text )
		self.currText = text
	end
end

local function OnEnterPressed( self ) -- print("OnEnterPressed")
	local text = self:GetText()
	if text:len() == 0 then text = nil end -- experimental
	self:ClearFocus()

	local parent = self:GetParent()
	if parent.OnValueChanged then
		parent:OnValueChanged( text )
	end
end

local function OnEscapePressed( self ) -- print("OnEscapePressed")
	self:ClearFocus()
end

local function OnReceiveDrag( self )
	local type, id, info = GetCursorInfo()
	if type == "item" then
		self:SetText( info )
		OnEnterPressed( self )
		ClearCursor()
	elseif type == "spell" then
		local name = GetSpellInfo( id, info )
		self:SetText( name )
		OnEnterPressed( self )
		ClearCursor()
	end
end

local function SetText( self, text )
	return self.editbox:SetText( text )
end

function lib.CreateEditBox( parent, name, desc, maxLetters )
	assert( type(parent) == "table" and parent.CreateFontString, "PhanxConfig-EditBox: Parent is not a valid frame!" )
	if type(name) ~= "string" then name = nil end
	if type(desc) ~= "string" then desc = nil end
	if type(maxLetters) ~= "number" then maxLetters = nil end

	local frame = CreateFrame( "Frame", nil, parent )
	frame:SetWidth( 144 )
	frame:SetHeight( 42 )

--	local bg = frame:CreateTexture(nil, "BACKGROUND")
--	bg:SetAllPoints(frame)
--	bg:SetTexture(0, 0, 0)
--	frame.bg = bg

	local editbox = CreateFrame( "EditBox", nil, frame )
	editbox:SetPoint( "LEFT", 5, 0 )
	editbox:SetPoint( "RIGHT", -5, 0 )
	editbox:SetHeight( 19 )
	editbox:EnableMouse( true )
	editbox:SetAutoFocus( false )
	editbox:SetFontObject( ChatFontNormal )
	editbox:SetMaxLetters( maxLetters or 256 )
	editbox:SetTextInsets( 0, 0, 3, 3 )
	editbox:SetScript( "OnEnter", OnEnter )
	editbox:SetScript( "OnLeave", OnLeave )
	editbox:SetScript( "OnEditFocusGained", OnEditFocusGained )
	editbox:SetScript( "OnTextChanged", OnTextChanged )
	editbox:SetScript( "OnEnterPressed", OnEnterPressed )
	editbox:SetScript( "OnTabPressed", OnEnterPressed )
	editbox:SetScript( "OnEscapePressed", OnEscapePressed )
	editbox:SetScript( "OnEditFocusLost", OnEditFocusLost )
	editbox:SetScript( "OnReceiveDrag", OnReceiveDrag )
	lib.editboxes[ #lib.editboxes + 1 ] = editbox
	frame.editbox = editbox

	editbox.bgLeft = editbox:CreateTexture( nil, "BACKGROUND" )
	editbox.bgLeft:SetPoint( "LEFT", 0, 0 )
	editbox.bgLeft:SetSize( 8, 20 )
	editbox.bgLeft:SetTexture( [[Interface\Common\Common-Input-Border]] )
	editbox.bgLeft:SetTexCoord( 0, 0.0625, 0, 0.625 )

	editbox.bgRight = editbox:CreateTexture( nil, "BACKGROUND" )
	editbox.bgRight:SetPoint( "RIGHT", 0, 0 )
	editbox.bgRight:SetSize( 8, 20 )
	editbox.bgRight:SetTexture( [[Interface\Common\Common-Input-Border]] )
	editbox.bgRight:SetTexCoord( 0.9375, 1, 0, 0.625 )

	editbox.bgMiddle = editbox:CreateTexture( nil, "BACKGROUND" )
	editbox.bgMiddle:SetPoint( "LEFT", editbox.bgLeft, "RIGHT" )
	editbox.bgMiddle:SetPoint( "RIGHT", editbox.bgRight, "LEFT" )
	editbox.bgMiddle:SetSize( 10, 20 )
	editbox.bgMiddle:SetTexture( [[Interface\Common\Common-Input-Border]] )
	editbox.bgMiddle:SetTexCoord( 0.0625, 0.9375, 0, 0.625 )

	local label = editbox:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
	label:SetPoint( "BOTTOMLEFT", editbox, "TOPLEFT" )
	label:SetPoint( "BOTTOMRIGHT", editbox, "TOPRIGHT" )
	label:SetJustifyH( "LEFT" )
	label:SetText( name )
	frame.label = label

	frame.desc = desc
	frame.SetText = SetText

	return frame
end