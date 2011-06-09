local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local DARK_RED = "|cFFF00000"

local ICON_UNKNOWN = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_EXALTED = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local Factions = {
	-- Factions reference table, based on http://www.wowwiki.com/Factions
	{	-- [1]
		name = GetCategoryInfo(14864),	-- "Classic"
		{	-- [1]
			name = FACTION_ALLIANCE,
			{ name = BZ["Darnassus"], icon = "Achievement_Character_Nightelf_Female"	},
			{ name = BF["Exodar"], icon = "Achievement_Character_Draenei_Male" },
			{ name = BZ["Gnomeregan"], icon = "Achievement_Character_Gnome_Female" },
			{ name = BZ["Ironforge"], icon = "Achievement_Character_Dwarf_Male" },
			{ name = BF["Stormwind"], icon = "Achievement_Character_Human_Male" },
			{ name = BF["Gilneas"], icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0, bottom = 0.25 },
			{ name = BF["Alliance"], icon = "INV_BannerPVP_02" },
		},
		{	-- [2]
			name = FACTION_HORDE,
			{ name = BF["Darkspear Trolls"], icon = "Achievement_Character_Troll_Male" },
			{ name = BZ["Orgrimmar"], icon = "Achievement_Character_Orc_Male" },
			{ name = BZ["Thunder Bluff"], icon = "Achievement_Character_Tauren_Male" },
			{ name = BZ["Undercity"], icon = "Achievement_Character_Undead_Female" },
			{ name = BZ["Silvermoon City"], icon = "Achievement_Character_Bloodelf_Male" },
			{ name = BF["Bilgewater Cartel"], icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0.25, bottom = 0.5 },
			{ name = BF["Horde"], icon = "INV_BannerPVP_01" },
		},
		{	-- [3]
			name = L["Alliance Forces"],
			{ name = BF["The League of Arathor"], icon = "Achievement_BG_winAB" },
			{ name = BF["Silverwing Sentinels"], icon = "Achievement_BG_captureflag_WSG" },
			{ name = BF["Stormpike Guard"], icon = "Achievement_BG_winAV" },
		},
		{	-- [4]
			name = L["Horde Forces"],
			{ name = BF["The Defilers"], icon = "Achievement_BG_winAB" },
			{ name = BF["Warsong Outriders"], icon = "Achievement_BG_captureflag_WSG" },
			{ name = BF["Frostwolf Clan"], icon = "Achievement_BG_winAV" },
		},
		{	-- [5]
			name = L["Steamwheedle Cartel"],
			{ name = BZ["Booty Bay"], icon = "Achievement_Zone_Stranglethorn_01" },
			{ name = BZ["Everlook"], icon = "Achievement_Zone_Winterspring" },
			{ name = BZ["Gadgetzan"], icon = "Achievement_Zone_Tanaris_01" },
			{ name = BZ["Ratchet"], icon = "Achievement_Zone_Barrens_01" },
		},
		{	-- [6]
			name = OTHER,
			{ name = BF["Argent Dawn"], icon = "INV_Jewelry_Talisman_07" },
			{ name = BF["Bloodsail Buccaneers"], icon = "INV_Helmet_66" },
			{ name = BF["Brood of Nozdormu"], icon = "INV_Misc_Head_Dragon_Bronze" },
			{ name = BF["Cenarion Circle"], icon = "Achievement_Zone_Silithus_01" },
			{ name = BF["Darkmoon Faire"], icon = "INV_Misc_Ticket_Darkmoon_01" },
			{ name = BF["Gelkis Clan Centaur"], icon = "INV_Misc_Head_Centaur_01" },
			{ name = BF["Hydraxian Waterlords"], icon = "Spell_Frost_SummonWaterElemental_2" },
			{ name = BF["Magram Clan Centaur"], icon = "INV_Misc_Head_Centaur_01" },
			{ name = BF["Ravenholdt"], icon = "INV_ThrowingKnife_04" },
			{ name = BF["Shen'dralar"], icon = "Achievement_Zone_Feralas" },
			{ name = BF["Syndicate"], icon = "INV_Misc_ArmorKit_03" },
			{ name = BF["Thorium Brotherhood"], icon = "INV_Ingot_Thorium" },
			{ name = BF["Timbermaw Hold"], icon = "Achievement_Reputation_timbermaw" },
			{ name = BF["Tranquillien"], icon = "Achievement_Zone_Ghostlands" },
			{ name = BF["Wintersaber Trainers"], icon = "Ability_Mount_PinkTiger" },
			{ name = BF["Zandalar Tribe"], icon = "INV_Bijou_Green" },
		}
	},
	{	-- [2]
		name = GetCategoryInfo(14865),	-- "The Burning Crusade"
		{	-- [1]
			name = GetRealZoneText(530),	-- Outland
			{ name = BF["Ashtongue Deathsworn"], icon = "Achievement_Reputation_AshtongueDeathsworn" },
			{ name = BF["Cenarion Expedition"], icon = "Achievement_Reputation_GuardiansofCenarius" },
			{ name = BF["The Consortium"], icon = "INV_Enchant_ShardPrismaticLarge" },
			{ name = BF["Honor Hold"], icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },
			{ name = BF["Kurenai"], icon = "INV_Misc_Foot_Centaur" },
			{ name = BF["The Mag'har"], icon = "Achievement_Zone_Nagrand_01" },
			{ name = BF["Netherwing"], icon = "Ability_Mount_NetherdrakePurple" },
			{ name = BF["Ogri'la"], icon = "Achievement_Reputation_Ogre" },
			{ name = BF["Sporeggar"], icon = "INV_Mushroom_11" },
			{ name = BF["Thrallmar"], icon = "Spell_Misc_HellifrePVPThrallmarFavor" },
		},
		{	-- [2]
			name = BZ["Shattrath City"],
			{ name = BF["Lower City"], icon = "Achievement_Zone_Terrokar" },
			{ name = BF["Sha'tari Skyguard"], icon = "Ability_Hunter_Pet_NetherRay" },
			{ name = BF["Shattered Sun Offensive"], icon = "INV_Shield_48" },
			{ name = BF["The Aldor"], icon = "Achievement_Character_Draenei_Female" },
			{ name = BF["The Scryers"], icon = "Achievement_Character_Bloodelf_Female" },
			{ name = BF["The Sha'tar"], icon = "Achievement_Zone_Netherstorm_01" },
		},
		{	-- [3]
			name = OTHER,
			{ name = BF["Keepers of Time"], icon = "Achievement_Zone_HillsbradFoothills" },
			{ name = BF["The Scale of the Sands"], icon = "INV_Enchant_DustIllusion" },
			{ name = BF["The Violet Eye"], icon = "Spell_Holy_MindSooth" },
		}
	},
	{	-- [3]
		name = GetCategoryInfo(14866),	-- "Wrath of the Lich King"
		{	-- [1]
			name = GetRealZoneText(571),	-- Northrend
			{ name = BF["Argent Crusade"], icon = "Achievement_Reputation_ArgentCrusader" },
			{ name = BF["Kirin Tor"], icon = "Achievement_Reputation_KirinTor" },
			{ name = BF["The Kalu'ak"], icon = "Achievement_Reputation_Tuskarr" },
			{ name = BF["The Wyrmrest Accord"], icon = "Achievement_Reputation_WyrmrestTemple" },
			{ name = BF["Knights of the Ebon Blade"], icon = "Achievement_Reputation_KnightsoftheEbonBlade" },
			{ name = BF["The Sons of Hodir"], icon = "Achievement_Boss_Hodir_01" },
			{ name = BF["The Ashen Verdict"], icon = "Achievement_Reputation_ArgentCrusader" },
		},
		{	-- [2]
			name = BF["Alliance Vanguard"],
			{ name = BF["Alliance Vanguard"], icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },
			{ name = BF["Explorers' League"], icon = "Achievement_Zone_HowlingFjord_02" },
			{ name = BF["The Frostborn"], icon = "Achievement_Zone_StormPeaks_01" },
			{ name = BF["The Silver Covenant"], icon = "Achievement_Zone_CrystalSong_01" },
			{ name = BF["Valiance Expedition"], icon = "Achievement_Zone_BoreanTundra_01" },
		},
		{	-- [3]
			name = BF["Horde Expedition"],
			{ name = BF["Horde Expedition"], icon = "Spell_Misc_HellifrePVPThrallmarFavor" },
			{ name = BF["The Hand of Vengeance"], icon = "Achievement_Zone_HowlingFjord_02" },
			{ name = BF["The Sunreavers"], icon = "Achievement_Zone_CrystalSong_01" },
			{ name = BF["The Taunka"], icon = "Achievement_Zone_BoreanTundra_02" },
			{ name = BF["Warsong Offensive"], icon = "Achievement_Zone_BoreanTundra_03" },
		},
		{	-- [4]
			name = BZ["Sholazar Basin"],
			{ name = BF["Frenzyheart Tribe"], icon = "Ability_Mount_WhiteDireWolf" },
			{ name = BF["The Oracles"], icon = "Achievement_Reputation_MurlocOracle" },
		},
	},
	{	-- [4]
		name = GetCategoryInfo(15072),	-- "Cataclysm"
		{	-- [1]
			name = OTHER,
			{ name = BF["Guardians of Hyjal"], icon = "Achievement_Zone_mount hyjal" },
			{ name = BF["The Earthen Ring"], icon = "Spell_Nature_EarthElemental_Totem" },
			{ name = BF["Therazane"], icon = "inv_misc_tabard_therazane" },
			{ name = BF["Wildhammer Clan"], icon = "inv_misc_tabard_wildhammerclan" },
			{ name = BF["Ramkahen"], icon = "inv_misc_tabard_tolvir" },
			{ name = BF["Baradin's Wardens"], icon = "inv_misc_tabard_baradinwardens" },
			{ name = BF["Dragonmaw Clan"], icon = "inv_misc_tabard_dragonmawclan" },
			{ name = BF["Hellscream's Reach"], icon = "inv_misc_tabard_hellscream" },
		}
	},
	{	-- [5]
		name = GUILD,
		{	-- [1]
			name = GUILD,
		}
	},
}

local VertexColors = {
	[FACTION_STANDING_LABEL1] = { r = 0.4, g = 0.13, b = 0.13 },	-- hated
	[FACTION_STANDING_LABEL2] = { r = 0.5, g = 0.0, b = 0.0 },		-- hostile
	[FACTION_STANDING_LABEL3] = { r = 0.6, g = 0.4, b = 0.13 },		-- unfriendly
	[FACTION_STANDING_LABEL4] = { r = 0.6, g = 0.6, b = 0.0 },		-- neutral
	[FACTION_STANDING_LABEL5] = { r = 0.0, g = 0.6, b = 0.0 },		-- friendly
	-- [FACTION_STANDING_LABEL6] = { r = 0.0, g = 0.6, b = 0.4 },		-- honored
	-- [FACTION_STANDING_LABEL7] = { r = 0.0, g = 0.6, b = 0.6 },		-- revered
	[FACTION_STANDING_LABEL6] = { r = 0.0, g = 0.6, b = 0.6 },		-- honored
	[FACTION_STANDING_LABEL7] = { r = 0.9, g = 0.3, b = 0.9 },		-- revered
	[FACTION_STANDING_LABEL8] = { r = 1.0, g = 1.0, b = 1.0 },		-- exalted
}

local view
local isViewValid

local currentXPack = 1					-- default to wow classic
local currentFactionGroup = (UnitFactionGroup("player") == "Alliance") and 1 or 2	-- default to alliance or horde

local function BuildView()
	view = view or {}
	wipe(view)
	
	if currentXPack and currentFactionGroup then
		for index, faction in ipairs(Factions[currentXPack][currentFactionGroup]) do
			table.insert(view, faction)	-- insert the table pointer
		end

	else	-- all in one, add all factions
		for xPackIndex, xpack in ipairs(Factions) do		-- all xpacks
			for factionGroupIndex, factionGroup in ipairs(xpack) do 	-- all faction groups
				for index, faction in ipairs(factionGroup) do
					table.insert(view, faction)	-- insert the table pointer
				end
			end
		end
		
		table.sort(view, function(a,b) 	-- sort all factions alphabetically
			return a.name < b.name
		end)
	end
	
	isViewValid = true
end


addon.Reputations = {}

local ns = addon.Reputations		-- ns = namespace

local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function OnFactionChange(self, xpackIndex, factionGroupIndex)
	CloseDropDownMenus()

	currentXPack = xpackIndex
	currentFactionGroup = factionGroupIndex
	
	local factionGroup = Factions[currentXPack][currentFactionGroup]
	UIDropDownMenu_SetText(AltoholicFrameReputations_SelectFaction, factionGroup.name)
	
	isViewValid = nil
	ns:Update()
end

local lastRealm, lastAccount

local function OnGuildSelected(self)
	CloseDropDownMenus()
	
	currentXPack = 5
	currentFactionGroup = 1
	
	local realm, account = addon.Tabs.Characters:GetRealm()
	
	if not lastRealm or not lastAccount or lastRealm ~= realm or lastAccount ~= account then	-- realm/account changed ? rebuild view
		-- get the guilds on this realm/account
		local guilds = {}
		for guildName, guild in pairs(DataStore:GetGuilds(realm, account)) do
			if DataStore:GetGuildFaction(guildName, realm, account) == FACTION_ALLIANCE then
				guilds[guildName] = "inv_misc_tournaments_banner_human"
			else
				guilds[guildName] = "inv_misc_tournaments_banner_orc"
			end
		end
		
		-- clean the Factions table
		for k, v in ipairs(Factions[currentXPack][currentFactionGroup]) do	-- ipairs ! only touch the array part, leave the hash untouched
			Factions[currentXPack][currentFactionGroup][k] = nil
		end
		
		-- add them to the Factions table
		for k, v in pairs(guilds) do
			table.insert(Factions[currentXPack][currentFactionGroup], { name = k, icon = v } )
		end
	end
	
	lastRealm = realm
	lastAccount = account
	UIDropDownMenu_SetText(AltoholicFrameReputations_SelectFaction, GUILD)
	
	isViewValid = nil
	ns:Update()
end

local function OnAllInOneSelected(self)
	currentXPack = nil
	currentFactionGroup = nil
	UIDropDownMenu_SetText(AltoholicFrameReputations_SelectFaction, L["All-in-one"])
	isViewValid = nil
	ns:Update()
end

local function Reputations_UpdateEx(self, offset, entry, desc)
	if not isViewValid then
		BuildView()
	end
	
	local line
	local size = desc:GetSize()
	
	local DS = DataStore
	local realm, account = addon.Tabs.Characters:GetRealm()
	local character

	AltoholicTabCharactersStatus:SetText("")
	
	for i=1, desc.NumLines do
		line = i + offset
		if line <= size then
			local faction = view[line]
		
			_G[entry..i.."Name"]:SetText(WHITE .. faction.name)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 10 do	-- loop through the 10 alts
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				if faction.left then		-- if it's not a full texture, use tcoords
					itemTexture:SetTexture(faction.icon)
					itemTexture:SetTexCoord(faction.left, faction.right, faction.top, faction.bottom)
				else
					itemTexture:SetTexture("Interface\\Icons\\"..faction.icon)
					itemTexture:SetTexCoord(0, 1, 0, 1)
				end

				local status, rate
				
				character = addon:GetOption(format("Tabs.Characters.%s.%s.Column%d", account, realm, j))
				if character then	-- if there's an alt in this column..
					status, _, _, rate = DS:GetReputationInfo(character, faction.name)
				
					if status and rate then 
						local vc = VertexColors[status]
						
						local text
						if status == FACTION_STANDING_LABEL8 then
							itemTexture:SetDesaturated(0);
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 5, 0)
							text = ICON_EXALTED
						else
							itemTexture:SetDesaturated(1);
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", -5, 0)
							text = format("%2d", floor(rate)) .. "%"
						end
						itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
						
						local color = WHITE
						if status == FACTION_STANDING_LABEL1 or status == FACTION_STANDING_LABEL2 then
							color = DARK_RED
						end

						itemButton.key = character
						_G[itemName .. "Name"]:SetText(color..text)
					else
						itemTexture:SetVertexColor(0.3, 0.3, 0.3);	-- greyed out
						_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 5, 0)
						_G[itemName .. "Name"]:SetText(ICON_UNKNOWN)
						itemButton.key = nil
					end
					itemButton:Show()				
				else
					itemButton:Hide()
				end
			end
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		end
	end
end

local ReputationsScrollFrame_Desc = {
	NumLines = 8,
	LineHeight = 41,
	Frame = "AltoholicFrameReputations",
	GetSize = function() return #view end,
	Update = Reputations_UpdateEx,
}

function ns:DropDownFaction_Initialize(level)
	if not level then return end

	local info = UIDropDownMenu_CreateInfo()
	
	if level == 1 then
		for xpackIndex = 1, 4 do
			info.text = Factions[xpackIndex].name
			info.hasArrow = 1
			info.value = xpackIndex
			UIDropDownMenu_AddButton(info, level)
		end
		
		-- Guild factions
		info.text = GUILD
		info.hasArrow = nil
		info.func = OnGuildSelected
		UIDropDownMenu_AddButton(info, level)

		info.text = L["All-in-one"]
		info.hasArrow = nil
		info.func = OnAllInOneSelected
		UIDropDownMenu_AddButton(info, level)
		
		DDM_AddCloseMenu()
	
	elseif level == 2 then
		for factionGroupIndex, factionGroup in ipairs(Factions[UIDROPDOWNMENU_MENU_VALUE]) do
			info.text = factionGroup.name
			info.func = OnFactionChange
			info.arg1 = UIDROPDOWNMENU_MENU_VALUE
			info.arg2 = factionGroupIndex
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

function ns:Update()
	addon:ScrollFrameUpdate(ReputationsScrollFrame_Desc)
end

function ns:OnEnter(frame)
	local character = frame.key
	if not character then return end

	local faction = view[ frame:GetParent():GetID() ].name
	local status, currentLevel, maxLevel, rate = DataStore:GetReputationInfo(character, faction)
	if not status then return end
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(DataStore:GetColoredCharacterName(character) .. WHITE .. " @ " ..	TEAL .. faction,1,1,1);

	rate = format("%d", floor(rate)) .. "%"
	AltoTooltip:AddLine(format("%s: %d/%d (%s)", status, currentLevel, maxLevel, rate),1,1,1 )
				
	local bottom = DataStore:GetRawReputationInfo(character, faction)
	local suggestion = ns:GetSuggestion(faction, bottom)
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine("Suggestion: ",1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(format("%s = %s", ICON_UNKNOWN, UNKNOWN), 0.8, 0.13, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL1, 0.8, 0.13, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL2, 1.0, 0.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL3, 0.93, 0.4, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL4, 1.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL5, 0.0, 1.0, 0.0);
	-- AltoTooltip:AddLine(FACTION_STANDING_LABEL6, 0.0, 1.0, 0.53);
	-- AltoTooltip:AddLine(FACTION_STANDING_LABEL7, 0.0, 1.0, 0.8);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL6, 0.0, 1.0, 0.8);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL7, 1.0, 0.4, 1.0);
	AltoTooltip:AddLine(format("%s = %s", ICON_EXALTED, FACTION_STANDING_LABEL8), 1, 1, 1);
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Shift+Left click to link"]);
	AltoTooltip:Show();
end

function ns:OnClick(frame, button)
	local character = frame.key
	if not character then return end

	local faction = view[ frame:GetParent():GetID() ].name
	local status, currentLevel, maxLevel, rate = DataStore:GetReputationInfo(character, faction)
	if not status then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			chat:Insert(format(L["%s is %s with %s (%d/%d)"], DataStore:GetCharacterName(character), status, faction, currentLevel, maxLevel))
		end
	end	
end

function ns:GetSuggestion(faction, bottom)
	if not addon.FactionLeveling then return end
	
	local factionTable = addon.FactionLeveling[faction]
	if not factionTable then return end
	
	local levels = {}
	for k, _ in pairs(factionTable) do		-- get the levels for which we have a suggestion for this faction
		table.insert(levels, k)
	end
	table.sort(levels)	-- sort them, otherwise there's a risk of returning a suggestion for the wrong level
	
	-- at this point, levels may look like : { 0, 9000, 42000 }
	
	for _, level in ipairs(levels) do
		if bottom < level then	-- the suggestions are sorted by level, so whenever we're below, return the text
			return format("%s:\n%s", format(L["Up to %s"], DataStore:GetReputationLevelText(level)), factionTable[level] )
		end
	end
end
