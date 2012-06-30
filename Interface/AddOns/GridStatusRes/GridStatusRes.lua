--[[--------------------------------------------------------------------
	GridStatusRes
	Adds resurrection and soulstone status to Grid.
	Written by DarthRahrek
	Maintained by Akkorian <akkorian@hotmail.com>
	http://www.wowinterface.com/downloads/info19214-GridStatusRes.html
	http://wow.curse.com/downloads/wow-addons/details/grid-status-res.aspx
----------------------------------------------------------------------]]

local ResComm = LibStub( "LibResComm-1.0", true )
if not ResComm then return end

------------------------------------------------------------------------

local L = setmetatable( { }, { __index = Grid.L } )

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L["Resurrection"] = "Wiederbelebung"
	L["Incoming resurrection"] = "Eingehende Wiederbelebung"
	L["Soulstone"] = "Seelenstein"
	L["Resurrected"] = "Wiederbelebt"
elseif LOCALE == "esES" or LOCALE == "esMX" then
	L["Resurrection"] = "Resurrección"
	L["Incoming resurrection"] = "Resurrección lanzado"
	L["Soulstone"] = "Piedra de alma"
	L["Resurrected"] = "Resucitado"
elseif LOCALE == "frFR" then
	L["Resurrection"] = "Résurrection"
	L["Incoming resurrection"] = "Résurrection entrante"
	L["Soulstone"] = "Pierre d'âme"
	L["Resurrected"] = "Ressuscité"
elseif LOCALE == "ptBR" then
	L["Resurrection"] = "Ressurreição"
	L["Incoming resurrection"] = "Ressurreição lançado"
	L["Soulstone"] = "Pedra da alma"
	L["Resurrected"] = "Ressuscitado"
elseif LOCALE == "ruRU" then
	L["Resurrection"] = "Воскрешение"
	L["Incoming resurrection"] = "Входящее воскрешение"
	L["Soulstone"] = "Камень души"
	L["Resurrected"] = "Воскрешен"
elseif LOCALE == "koKR" then
	L["Resurrection"] = "부활"
	L["Incoming resurrection"] = "부활 받음"
	L["Soulstone"] = "영혼석"
	L["Resurrected"] = "부활"
elseif LOCALE == "zhCN" then
	L["Resurrection"] = "复活"
	L["Incoming resurrection"] = "接受复活"
	L["Soulstone"] = "灵魂石"
	L["Resurrected"] = "已复活"
elseif LOCALE == "zhTW" then
	L["Resurrection"] = "復活"
	L["Incoming resurrection"] = "接受復活"
	L["Soulstone"] = "靈魂石"
	L["Resurrected"] = "已復活"
end

------------------------------------------------------------------------

local GridRoster = Grid:GetModule( "GridRoster" )

local GridStatusRes = Grid:NewStatusModule( "GridStatusRes", "AceBucket-3.0" )
GridStatusRes.menuName = L["Resurrection"]
GridStatusRes.defaultDB = {
	debug = false,
	alert_res = {
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		priority = 50,
		range = false,
		text = "+RES",
	},
	alert_ressed = {
		enable = true,
		color = { r = 0, g = 1, b = 0, a = 1 },
		priority = 51,
		range = false,
		text = "RES",
	},
	alert_ss = {
		enable = true,
		color = { r = 1, g = 0, b = 1, a = 1 },
		priority = 49,
		range = false,
		text = "SS",
	},
}

------------------------------------------------------------------------

local function GetOptionsForStatus( status )
	local status_name = status
	local options = {
		["text"] = {
			name = L["Text"],
			desc = L["Text to display on text indicators"],
			order = 50,
			type = "input", usage = L["<text>"],
			get = function()
				return GridStatusRes.db.profile[status_name].text
			end,
			set = function( _, v )
				GridStatusRes.db.profile[ status_name ].text = v
			end,
		},
	}
	return options
end

function GridStatusRes:PostInitialize()
	self:RegisterStatus( "alert_res", L["Incoming resurrection"], GetOptionsForStatus( "alert_res" ) )
	self:RegisterStatus( "alert_ressed", L["Resurrected"], GetOptionsForStatus( "alert_ressed" ) )
	self:RegisterStatus( "alert_ss", L["Soulstone"], GetOptionsForStatus( "alert_ss" ) )
end

function GridStatusRes:PostEnable()
	ResComm.RegisterCallback( self, "ResComm_ResStart" )
	ResComm.RegisterCallback( self, "ResComm_ResEnd" )
	ResComm.RegisterCallback( self, "ResComm_Ressed" )
	ResComm.RegisterCallback( self, "ResComm_ResExpired" )
	ResComm.RegisterCallback( self, "ResComm_CanRes" )

	self:RegisterBucketEvent( "UNIT_HEALTH", 0.1, "HealthChanged" )
end

function GridStatusRes:PostDisable()
	ResComm.UnregisterCallback( self, "ResComm_ResStart" )
	ResComm.UnregisterCallback( self, "ResComm_ResEnd" )
	ResComm.UnregisterCallback( self, "ResComm_Ressed" )
	ResComm.UnregisterCallback( self, "ResComm_ResExpired" )
	ResComm.UnregisterCallback( self, "ResComm_CanRes" )

	self:UnregisterBucketEvent( "UNIT_HEALTH" )
end

------------------------------------------------------------------------

local resIcons = {
	["RE"]  = [[Interface\Icons\INV_Jewelry_Talisman_06]],
	["SS"]  = [[Interface\Icons\INV_Misc_Orb_04]],
	["TN"]  = [[Interface\Icons\INV_Misc_Ticket_Tarot_TwistingNether_01]],
	[2008]  = [[Interface\Icons\Spell_Nature_Regenerate]],				-- Ancestral Spirit
	[20484] = [[Interface\Icons\Spell_Nature_Reincarnation]],			-- Rebirth
	[7328]  = [[Interface\Icons\Spell_Holy_Resurrection]],				-- Redemption
	[20608] = [[Interface\Icons\Spell_Shaman_ImprovedReincarnation]],	-- Reincarnation
	[2006]  = [[Interface\Icons\Spell_Holy_Resurrection]],				-- Resurrection
	[50769] = [[Interface\Icons\Ability_Druid_LunarGuidance]],			-- Revive
	[20707] = [[Interface\Icons\INV_Misc_Orb_04]], 						-- Soulstone
	[23701] = [[Interface\Icons\INV_Misc_Orb_04]], 						-- Twisting Nether
}

------------------------------------------------------------------------

function GridStatusRes:ResComm_ResStart( event, source, endTime, name )
	local settings = self.db.profile.alert_res
	if not settings.enable then return end

	local guid = GridRoster:GetGUIDByFullName( name )
	self:Debug( "ResComm_ResStart targetName", name, "guid", guid )
	self.core:SendStatusGained( guid, "alert_res",
		settings.priority,
		settings.range,
		settings.color,
		settings.text,
		nil,
		nil,
		resIcons[2006],
		GetTime(),
		endTime - GetTime()
	)
end

function GridStatusRes:ResComm_ResEnd( event, source, name )
	if name and not ResComm:IsUnitBeingRessed( name ) then
		local guid = GridRoster:GetGUIDByFullName( name )
		self:Debug( "ResComm_ResEnd targetName", name, "guid", guid )
		self.core:SendStatusLost( guid, "alert_res" )
	end
end

function GridStatusRes:ResComm_Ressed( event, name )
	local settings = self.db.profile.alert_ressed
	if not settings.enable then return end

	local guid = GridRoster:GetGUIDByFullName( name )
	self:Debug( "ResComm_ResStart ressed", name, "guid", guid )
	self.core:SendStatusGained( guid, "alert_ressed",
		settings.priority,
		settings.range,
		settings.color,
		settings.text,
		nil,
		nil,
		resIcons[2006],
		GetTime(),
		60
	)
end

function GridStatusRes:ResComm_ResExpired( event, name )
	self.core:SendStatusLost( name, "alert_ressed" )
end

function GridStatusRes:ResComm_CanRes( event, name, resType )
	local settings = self.db.profile.alert_ss
	if not settings.enable then return end

	local guid = GridRoster:GetGUIDByFullName( name )
	self:Debug( "ResComm_ResStart ressed", name, "guid", guid )
	self.core:SendStatusGained( guid, "alert_ss",
		settings.priority,
		settings.range,
		settings.color,
		settings.text,
		nil,
		nil,
		resIcons[ resType ] or resIcons["SS"],
		GetTime(),
		300
	)
end

function GridStatusRes:HealthChanged( units )
	for unit in pairs( units ) do
		if not UnitIsDead( unit ) then
			local guid = UnitGUID( unit )
			self.core:SendStatusLost( guid, "alert_res" )
			self.core:SendStatusLost( guid, "alert_ressed" )
			self.core:SendStatusLost( guid, "alert_ss" )
		end
	end
end