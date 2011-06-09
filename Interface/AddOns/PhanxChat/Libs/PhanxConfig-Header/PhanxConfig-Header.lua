--[[--------------------------------------------------------------------
	PhanxConfig-Header
	Simple options panel header generator.
	Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber( string.match( "$Revision: 29 $", "%d+" ) )

local lib, oldminor = LibStub:NewLibrary( "PhanxConfig-Header", MINOR_VERSION )
if not lib then return end

function lib.CreateHeader( parent, titleText, notesText, noPrefix )
	assert( type(parent) == "table" and parent.CreateFontString, "Parent is not a valid frame!" )
	if type(titleText) ~= "string" then name = nil end
	if type(notesText) ~= "string" then desc = nil end

	if not titleText then
		titleText = parent.name
	end
	if titleText and not noPrefix and parent.parent then
		titleText = string.format( "%s - %s", parent.parent, titleText )
	end

	local title = parent:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" )
	title:SetPoint( "TOPLEFT", 16, -16 )
	title:SetPoint( "TOPRIGHT", -16, -16 )
	title:SetJustifyH( "LEFT" )
	title:SetText( titleText )

	local notes = parent:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" )
	notes:SetPoint( "TOPLEFT", title, "BOTTOMLEFT", 0, -8 )
	notes:SetPoint( "TOPRIGHT", title, 0, -8 )
	notes:SetHeight( 32 )
	notes:SetJustifyH( "LEFT" )
	notes:SetJustifyV( "TOP" )
	notes:SetNonSpaceWrap( true )
	notes:SetText( notesText )

	return title, notes
end