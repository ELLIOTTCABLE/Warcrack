------------------------------------------------------------------------
--	GridStatusHealTrace
--	Shows who was healed by your multi-target heals.
--	by Akkorian < akkorian@hotmail.com >
--  Maintained by Phanx < addons@phanx.net >
--	Inspired by GridStatusChainWho by Llyra
--	Copyright © 2010–2011 Akkorian. Some rights reserved. See LICENSE.txt for details.
--	http://www.wowinterface.com/downloads/info16608-GridStatusHealTrace.html
--	http://wow.curse.com/downloads/wow-addons/details/gridstatushealtrace.aspx
------------------------------------------------------------------------

local GridStatusHealTrace = Grid:NewStatusModule( "GridStatusHealTrace" )
local active, spellOrder, playerGUID, settings, spells = {}, {}

local L = setmetatable( {}, { __index = function( t, k )
	if not k then return "" end
	local v = tostring( k )
	t[ k ] = v
	return v
end } )

if GetLocale() == "esES" or GetLocale() == "esMX" then
	L["Heal Trace"] = "Sanaciones rastreados"
	L["Hold time"] = "Tiempo para mostrar"
	L["Show the status for this many seconds."] = "Mostrar el estado por estos segundos."
	L["Add new spell"] = "Añadir hechizo"
	L["Add another healing spell to trace."] = "Añadir un otro hechizo de sanación para rastrear."
	L["<spell name or spell ID>"] = "<nombre o ID de hechizo>"
	L["Remove spell"] = "Borrar hechizo"
	L["Remove a spell from the trace list."] = "Borrar un hechizo de la lista para rastrear."
	L["Remove %s from the trace list."] = "Borrar %s de la lista para rastrear."
elseif GetLocale() == "ptBR" then
	L["Heal Trace"] = "Curas rastreado"
	L["Hold time"] = "Tempo para mostrar"
	L["Show the status for this many seconds."] = "Mostrar o estado para isso muitos segundos."
	L["Add new spell"] = "Adicionar feitiço"
	L["Add another healing spell to trace."] = "Adicionar outra feitiço de cura para rastrear."
	L["<spell name or spell ID>"] = "<nome ou ID de feitiço>"
	L["Remove spell"] = "Remover feitiço"
	L["Remove a spell from the trace list."] = "Remover um feitiço à lista para rastrear."
	L["Remove %s from the trace list."] = "Remover %s à lista para rastrear."
end

------------------------------------------------------------------------

GridStatusHealTrace.defaultDB = {
	alert_healTrace = {
		color = { r = 0.8, g = 1.0, b = 0.2, a = 1 },
		enable = true,
		holdTime = 1,
		priority = 75,
		range = false,
		spells = {},
	}
}
for _, spellID in ipairs( {
	1064,  -- Chain Heal
	34861, -- Circle of Healing
	64844, -- Divine Hymn
	15237, -- Holy Nova
	85222, -- Light of Dawn
} ) do
	local name, _, icon = GetSpellInfo( spellID )
	GridStatusHealTrace.defaultDB.alert_healTrace.spells[ name ] = icon
end

------------------------------------------------------------------------

local hasAuraEditBox = type( LibStub("AceGUI-3.0").WidgetVersions["Aura_EditBox"] ) == "number"

local optionsForStatus = {
	holdTime = {
		order = -3, width = "double",
		name = L["Hold time"],
		desc = L["Show the status for this many seconds."],
		type = "range", min = 0.25, max = 5, step = 0.25,
		get = function()
			return GridStatusHealTrace.db.profile.alert_healTrace.holdTime
		end,
		set = function( _, v )
			GridStatusHealTrace.db.profile.alert_healTrace.holdTime = v
		end,
	},
	addSpell = {
		order = -2, width = "double",
		name = L["Add new spell"],
		desc = L["Add another healing spell to trace."],
		type = "input", usage = L["<spell name or spell ID>"],
		dialogControl = hasAuraEditBox and "Aura_EditBox" or nil,
		get = false,
		set = function( _, v )
			GridStatusHealTrace:AddSpell( string.trim( v ) )
		end,
	},
	removeSpell = {
		order = -1,
		name = L["Remove spell"],
		desc = L["Remove a spell from the trace list."],
		type = "group", dialogInline = true,
		args = {},
	},
}

------------------------------------------------------------------------

function GridStatusHealTrace:AddSpell( name, icon )
	local id = name:match( "(%d+)" )
	if id then
		local _
		name, _, icon = GetSpellInfo( tonumber( id ) )
	elseif type( icon ) ~= "string" then
		icon = nil
	end

	if not name then return end

	self.db.profile.alert_healTrace.spells[ name ] = icon or true

	optionsForStatus.removeSpell.args[ name ] = {
		name = string.format( "|T%s:0:0:0:0:32:32:2:30:2:30|t %s", icon or "", name ),
		desc = string.format( L["Remove %s from the trace list."], name ),
		type = "execute",
		func = function()
			self.db.profile.alert_healTrace.spells[ name ] = nil
			optionsForStatus.removeSpell.args[ name ] = nil
		end,
	}

	if not spellOrder[ name ] then
		spellOrder[ name ] = true
		spellOrder[ #spellOrder + 1 ] = name
		table.sort( spellOrder )
		for i = 1, #spellOrder do
			optionsForStatus.removeSpell.args[ spellOrder[ i ] ].order = i
		end
	end
end

------------------------------------------------------------------------

function GridStatusHealTrace:PostInitialize()
	self:RegisterStatus( "alert_healTrace", L["Heal Trace"], optionsForStatus, true )

	settings = self.db.profile.alert_healTrace
	spells = settings.spells

	for name, icon in pairs( spells ) do
		self:AddSpell( name, icon )
	end
end

function GridStatusHealTrace:PostEnable()
	playerGUID = UnitGUID( "player" )
end

function GridStatusHealTrace:OnStatusEnable( status )
	self:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED" )
end

function GridStatusHealTrace:OnStatusDisable( status )
	self:UnregisterAllEvents()
	self.core:SendStatusLostAllUnits( "alert_healTrace" )
end

function GridStatusHealTrace:PostReset()
	self.core:SendStatusLostAllUnits( "alert_healTrace" )

	settings = self.db.profile.alert_healTrace
	spells = settings.spells
	for name in pairs( optionsForStatus.removeSpell.args ) do
		if not spells[ name ] then
			optionsForStatus.removeSpell.args[ name ] = nil
		end
	end
	for name, icon in pairs( spells ) do
		if not optionsForStatus.removeSpell.args[ name ] then
			self:AddSpell( name, icon )
		end
	end
end

------------------------------------------------------------------------

local timerFrame = CreateFrame( "Frame" )
timerFrame:Hide()
timerFrame:SetScript( "OnUpdate", function( self, elapsed )
	local i = 0
	for destGUID, holdTime in pairs( active ) do
		holdTime = holdTime - elapsed
		if holdTime <= 0 then
			GridStatusHealTrace.core:SendStatusLost( destGUID, "alert_healTrace" )
			active[ destGUID ] = nil
		else
			active[ destGUID ] = holdTime
			i = i + 1
		end
	end
	if i == 0 then
		self:Hide()
	end
end )

function GridStatusHealTrace:COMBAT_LOG_EVENT_UNFILTERED( _, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellID, spellName )
	if sourceGUID ~= playerGUID or event ~= "SPELL_HEAL" or not spells[ spellName ] then return end

	local spellIcon = spells[ spellName ]
	if type( spellIcon ) == "boolean" then
		local _, _, icon = GetSpellInfo( spellID )
		optionsForStatus.removeSpell.args[ spellName ].icon = icon
		spells[ spellName ] = icon
		spellIcon = icon
	end

	self.core:SendStatusGained(destGUID, "alert_healTrace",
		settings.priority,
		settings.range,
		settings.color,
		spellName,
		nil,
		nil,
		spellIcon
	)

	active[ destGUID ] = settings.holdTime
	timerFrame:Show()
end