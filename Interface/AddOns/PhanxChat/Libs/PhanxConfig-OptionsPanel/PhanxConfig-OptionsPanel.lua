--[[--------------------------------------------------------------------
	PhanxConfig-OptionsPanel
	Simple options panel frame generator.
	Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber( string.match( "$Revision: 62 $", "%d+" ) )

local lib, oldminor = LibStub:NewLibrary( "PhanxConfig-OptionsPanel", MINOR_VERSION )
if not lib then return end

local function OptionsPanel_OnShow( self )
	if InCombatLockdown() then return end

	local target = self.parent or self.name

	local i = 1
	while true do
		local button = _G[ "InterfaceOptionsFrameAddOnsButton" .. i ]
		if not button then break end

		local element = button.element
		if element.name == target then
			if element.hasChildren and element.collapsed then
				_G[ "InterfaceOptionsFrameAddOnsButton" .. i .. "Toggle" ]:Click()
			end
			return
		end

		i = i + 1
	end
end

local function OptionsPanel_OnFirstShow( self )
	if type( self.runOnce ) == "function" then
		local success, err = pcall( self.runOnce, self )
		self.runOnce = nil
		if not success then error( err ) end
	end

	if type( self.refresh ) == "function" then
		self.refresh( self )
	end

	if self:IsShown() then
		OptionsPanel_OnShow( self )
	end
	self:SetScript( "OnShow", OptionsPanel_OnShow )
end

local function OptionsPanel_OnClose( self )
	if InCombatLockdown() then return end

	local target = self.parent or self.name

	local i = 1
	while true do
		local button = _G[ "InterfaceOptionsFrameAddOnsButton" .. i ]
		if not button then break end

		local element = button.element
		if element.name == target then
			if element.hasChildren and not element.collapsed then
				local selection = InterfaceOptionsFrameAddOns.selection
				if not selection or selection.parent ~= target then
					_G[ "InterfaceOptionsFrameAddOnsButton" .. i .. "Toggle" ]:Click()
				end
			end
			return
		end

		i = i + 1
	end
end

function lib.CreateOptionsPanel( name, parent, construct, refresh )
	assert( type( name ) == "string", "PhanxConfig-OptionsPanel: Name is not a string!" )
	if type( parent ) ~= "string" then parent = nil end
	if type( construct ) ~= "function" then construct = nil end
	if type( refresh ) ~= "function" then refresh = nil end

	local f = CreateFrame( "Frame", nil, InterfaceOptionsFramePanelContainer )
	f:Hide()

	f.name = name
	f.parent = parent
	f.refresh = refresh

	f.okay = OptionsPanel_OnClose
	f.cancel = OptionsPanel_OnClose

	f.runOnce = construct
	f:SetScript( "OnShow", OptionsPanel_OnFirstShow )

	InterfaceOptions_AddCategory( f, parent )

	return f
end