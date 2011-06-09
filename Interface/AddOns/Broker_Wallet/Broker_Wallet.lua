local LDB = LibStub:GetLibrary("LibDataBroker-1.1")

Wallet = LDB:NewDataObject( "Broker_Wallet", {
		type = "data source",
		icon = "Interface\\Icons\\Inv_Misc_Armorkit_18",
		text = "",
	} )

local frame = CreateFrame("Frame")
frame:RegisterEvent( "KNOWN_CURRENCY_TYPES_UPDATE", "LISTEN_CURRENCY_UPDATE" )
frame:RegisterEvent( "CURRENCY_DISPLAY_UPDATE", "LISTEN_CURRENCY_UPDATE" )
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function( ) Wallet:Update( ) end )

function Wallet:ADDON_LOADED( )
    Wallet:Update( )
end

function Wallet.OnClick( frame, button )
	_G.CharacterFrame_OnLoad(_G.CharacterFrame)
    ToggleCharacter("TokenFrame")
end

function Wallet.OnTooltipShow(tooltip)
	tooltip:AddLine("Broker_Wallet", 0,1,0, 0,1,0)
	local numTokenTypes = GetCurrencyListSize()
	if numTokenTypes == 0 then return end
	-- expand all token headers
	for j = numTokenTypes, 1, -1 do
		local _, isHeader, isExpanded = GetCurrencyListInfo( j )
		if isHeader and not isExpanded then
		ExpandCurrencyList( j, 1 )
		end
	end
	local numTokenTypes = GetCurrencyListSize( )
	for j = 1, numTokenTypes do
		local name, isHeader, isExpanded, isUnused, isWatched, count, currencyType, icon, item = GetCurrencyListInfo( j )
		if isHeader then
			tooltip:AddLine( " " )
			tooltip:AddLine( name )
		else
			tooltip:AddDoubleLine( name, count, 1, 1, 1, 1, 1, 1 )
		end
	end
	tooltip:AddLine( " " )
	tooltip:AddLine( " " )
	tooltip:AddLine("Click to toggle currency frame.", 0,1,0, 0,1,0)
	tooltip:AddLine("Track up to 3 tokens on the bar", 0,1,0, 0,1,0)
	tooltip:AddLine("using the default in-game tracker.", 0,1,0, 0,1,0)
end

function Wallet:Update( )
	self.text = ""
	
	local numTokenTypes = GetCurrencyListSize( )	
	if numTokenTypes == 0 then return end
	local name, isHeader, isExpanded, isUnused, isWatched, count, currencyType, icon	
	for i = numTokenTypes, 1, -1 do
		name, isHeader, isExpanded = GetCurrencyListInfo( i )
		if isHeader and not isExpanded then
			ExpandCurrencyList( i, 1 )
		end
	end
	local numTracked = 0
	numTokenTypes = GetCurrencyListSize( )
	local size = ( 0 ) + 1
	
	for i = 1, numTokenTypes do
		name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo( i )
		if not isHeader and isWatched then
			if extraCurrencyType == 1 then
				icon = [[Interface\PVPFrame\PVP-ArenaPoints-Icon]]
			elseif extraCurrencyType == 2 then
				local factionGroup = UnitFactionGroup( "player" )
				if factionGroup then
					icon = [[Interface\PVPFrame\PVP-Currency-]] .. factionGroup
				end
			end
			self.text = string.format( "%s |T%s:0|t %d", self.text, icon or [[Interface\Icons\Temp]], count or 0 )
		end
		self.text = string.trim( self.text )
	end
end

function Wallet.BackpackUpdate( )
    Wallet:Update( )
end

hooksecurefunc( "BackpackTokenFrame_Update", Wallet.BackpackUpdate)
