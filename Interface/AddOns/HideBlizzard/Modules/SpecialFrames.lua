local SpecialFrames = HideBlizzard:NewModule("SpecialFrames", "AceHook-3.0")

local db
local defaults = {
	profile = {
		["achievement"] = nil,
		["boss"] = nil,
		["dungeon"] = nil,
		["minimap"] = nil,
		["mirrorbar"] = nil,
		["party"] = nil,
		["phase"] = nil,
--		["compactraid"] = nil,
		["tooltip"] = nil,
		["sysmessage"] = nil,
		["infomessage"] = nil,
		["errormessage"] = nil,
		["zonetext"] = nil,
		["subzonetext"] = nil,
	},
}

local options = nil
local function opt()
	if not options then
		options = {
			type = "group",
--			inline = true,
			name = "SpecialFrames",
			desc = "SpecialFrames module hides frames not linked to the other modules",
			arg = "SpecialFrames",
			get = function(info)
						local key = info[#info]
						return db[key]
					end,
			set = function(info, value)
						local key = info[#info]
						db[key] = value
						SpecialFrames:UpdateView()
					end,
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = "|cff00ff66Enable SpecialFrames|r",
--					descStyle = "inline",
--					desc = "SpecialFrames module hides frames not linked to the other modules",
					width = "full",
					get = function() return HideBlizzard:GetModuleEnabled("SpecialFrames") end,
					set = function(info, value) HideBlizzard:SetModuleEnabled("SpecialFrames", value) end,
				},
				spacer = {
					type = "description",
					order = 1.5,
					name = "",
				},
				alerts = {
					order = 1,
					type = "group",
					name = "Alert Frames",
					args = {
						achievement = {
							order = 1,
							type = "toggle",
							name = "Achievement Frame",
							desc = "Hides the achievement alert frame",
		--					width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
						dungeon = {
							order = 2,
							type = "toggle",
							name = "Dungeon Frame",
							desc = "Hides the dungeon completion alert frame",
			--					width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
					},
				},
				minimap = {
					order = 2,
					type = "toggle",
					name = "Minimap",
					desc = "Hides the minimap",
	--					width = "full",
					disabled = function() return not SpecialFrames:IsEnabled() end,
				},
				mirrorbar = {
					order = 3,
					type = "toggle",
					name = "Mirror Bar",
					desc = "Hides the mirror (breath/fatigue) bar at top of screen",
	--				width = "full",
					disabled = function() return not SpecialFrames:IsEnabled() end,
				},
				tooltip = {
					order = 4,
					type = "toggle",
					name = "Tooltip",
					desc = "Hides the tooltip frame",
	--					width = "full",
					disabled = function() return not SpecialFrames:IsEnabled() end,
				},
				partyopt = {
					order = 5,
					type = "group",
					name = "Party/Raid",
					args = {
						boss = {
							order = 3,
							type = "toggle",
							name = "Boss Frame",
							desc = "Hides the boss frame on right side of screen",
			--					width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
--[[						compactraid = {
							order = 1,
							type = "toggle",
							name = "Compact Raid Frame",
							desc = "Hides the compact raid frame box on left side of screen",
			--					width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},]]
						party = {
							order = 2,
							type = "toggle",
							name = "Party",
							desc = "Hides the party frames",
			--					width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
						phase = {
							order = 3,
							type = "toggle",
							name = "Phasing Icon",
							desc = "Hides the phasing icon when in a party",
			--				width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
					},
				},
				messages = {
					order = 6,
					type = "group",
					name = "Messages",
					args = {
						sysmessage = {
							type = "toggle",
							order = 1,
							name = "System Message",
							desc = "Hides all the system message(yellow) text at the top of the screen",
	--							width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
						infomessage = {
							type = "toggle",
							order = 2,
							name = "Info Message",
							desc = "Hides all the notification(yellow) text at the top of the screen",
	--							width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
						errormessage = {
							type = "toggle",
							order = 3,
							name = "Error Message",
							desc = "Hides all the error(red) text at the top of the screen",
	--							width = "full",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
						subzonetext = {
							type = "toggle",
							order = 4,
							name = "Subzone Text",
							desc = "Hides the subzone text in middle of the screen",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
						zonetext = {
							type = "toggle",
							order = 5,
							name = "Zone Text",
							desc = "Hides the zone text in middle of the screen",
							disabled = function() return not SpecialFrames:IsEnabled() end,
						},
					},
				},
			},
		}
		return options
	end
end

function SpecialFrames:OnInitialize()
	self:SetEnabledState(HideBlizzard:GetModuleEnabled("SpecialFrames"))
	self.db = HideBlizzard.db:RegisterNamespace("SpecialFrames", defaults)
	db = self.db.profile

	HideBlizzard:RegisterModuleOptions("SpecialFrames", opt, "SpecialFrames")
end

function SpecialFrames:OnEnable()
	self:UpdateView()
end

function SpecialFrames:OnDisable()
	self:UpdateView()
end

function SpecialFrames:UpdateView()
	db = self.db.profile

	if db.achievement == true then
		for i=1, MAX_ACHIEVEMENT_ALERTS do
			local af = _G["AchievementAlertFrame"..i]
			if af then
				af:Hide()
				af:UnregisterAllEvents()
				af.Show = function() end
			end
		end
	else
		for i=1, MAX_ACHIEVEMENT_ALERTS do
			local af = _G["AchievementAlertFrame"..i]
			if af then
				af.Show = nil
				af:RegisterEvent("ACHIEVEMENT_EARNED")
			end
		end
	end
	if db.dungeon == true then
		DungeonCompletionAlertFrame1:Hide()
		DungeonCompletionAlertFrame1:UnregisterAllEvents()
		DungeonCompletionAlertFrame1.Show = function() end
	else
		DungeonCompletionAlertFrame1.Show = nil
		DungeonCompletionAlertFrame1:RegisterEvent("LFG_COMPLETION_REWARD")
	end

	if db.minimap == true then
		MinimapCluster:Hide()
		MinimapCluster.Show = function() end
	else
		MinimapCluster.Show = nil
		MinimapCluster:Show()
	end

	if db.mirrorbar == true then
		for i=1, MIRRORTIMER_NUMTIMERS do
			local timer = _G["MirrorTimer"..i]
			timer:UnregisterAllEvents()
			timer:Hide()
			timer.Show = function() end
		end
		UIParent:UnregisterEvent("MIRROR_TIMER_START")
	else
		for i=1, MIRRORTIMER_NUMTIMERS do
			local timer = _G["MirrorTimer"..i]
			timer.Show = nil
			timer:RegisterEvent("MIRROR_TIMER_STOP")
			timer:RegisterEvent("MIRROR_TIMER_PAUSE")
			timer:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
		UIParent:RegisterEvent("MIRROR_TIMER_START")
	end

	local function hook(tooltip)
		local tooltips = {GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip}
		for i=1, #tooltips do
			tooltips[i]:Hide()
		end
	end

	local function unhook(tooltip)
		local tooltips = {GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip}
		for i=1, #tooltips do
			tooltips[i]:Show()
		end
	end

	if db.tooltip == true then
		self:SecureHook("GameTooltip_SetDefaultAnchor", hook)
	else
		self:Unhook("GameTooltip_SetDefaultAnchor", unhook)
	end

	if db.boss == true then
		for i=1, MAX_BOSS_FRAMES do
			local bf = _G["Boss"..i.."TargetFrame"]
			bf:Hide()
			bf.Show = function() end
		end
	else
		for i=1, MAX_BOSS_FRAMES do
			local bf = _G["Boss"..i.."TargetFrame"]
			bf.Show = nil
		end
	end--[[
	if db.compactraid == true then
		if _G.CompactRaidFrameManager:IsVisible() then
			CompactRaidFrameManager:Hide()
			CompactRaidFrameManager.Show = function() end
			CompactRaidFrameContainer:Show()
			for i=1, NUM_RAID_GROUPS do
				local raid = _G["CompactRaidGroup"..i]
				if not raid:IsVisible() then
					raid:Show()
				end
			end
			UIParent:RegisterEvent("RAID_ROSTER_UPDATE")
		end
	else
		if(GetNumRaidMembers() ~= 0) then
			CompactRaidFrameManager.Show = nil
			CompactRaidFrameManager:Show()
			CompactRaidFrameContainer:Show()
			for i=1, NUM_RAID_GROUPS do
				local raid = _G["CompactRaidGroup"..i]
				if not raid:IsVisible() then
					raid:Show()
				end
			end
			UIParent:RegisterEvent("RAID_ROSTER_UPDATE")
		end
	end]]
	if db.party == true then
		for i=1, MAX_PARTY_MEMBERS do
			local party = _G["PartyMemberFrame"..i]
			party:Hide()
			party:UnregisterAllEvents()
			party.Show = function() end
			if(GetCVar("showPartyBackground", 1)) then
				SetCVar("showPartyBackground", 0)
			end
		end
		UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")
	else
		for i=1, MAX_PARTY_MEMBERS do
			local party = _G["PartyMemberFrame"..i]
			if(GetPartyMember(i)) then
				party.Show = nil
				party:Show()
				party:RegisterEvent("PLAYER_ENTERING_WORLD")
				party:RegisterEvent("PARTY_MEMBERS_CHANGED")
				party:RegisterEvent("PARTY_LEADER_CHANGED")
				party:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
				party:RegisterEvent("MUTELIST_UPDATE")
				party:RegisterEvent("IGNORELIST_UPDATE")
				party:RegisterEvent("UNIT_FACTION")
				party:RegisterEvent("UNIT_AURA")
				party:RegisterEvent("UNIT_PET")
				party:RegisterEvent("VOICE_START")
				party:RegisterEvent("VOICE_STOP")
				party:RegisterEvent("VARIABLES_LOADED")
				party:RegisterEvent("VOICE_STATUS_UPDATE")
				party:RegisterEvent("READY_CHECK")
				party:RegisterEvent("READY_CHECK_CONFIRM")
				party:RegisterEvent("READY_CHECK_FINISHED")
				party:RegisterEvent("UNIT_ENTERED_VEHICLE")
				party:RegisterEvent("UNIT_EXITED_VEHICLE")
				party:RegisterEvent("UNIT_HEALTH")
				party:RegisterEvent("UNIT_CONNECTION")
				party:RegisterEvent("PARTY_MEMBER_ENABLE")
				party:RegisterEvent("PARTY_MEMBER_DISABLE")
				party:RegisterEvent("UNIT_PHASE")
				UnitFrame_OnEvent("PARTY_MEMBERS_CHANGED")
			end
		end
		UIParent:RegisterEvent("RAID_ROSTER_UPDATE")
	end
	if db.phase == true then
		for i=1, MAX_PARTY_MEMBERS do
			if(GetPartyMember(i)) then
				local icon = _G["PartyMemberFrame"..i.."PhasingIcon"]
				icon:Hide()
				icon.Show = function() end
			end
		end
	else
		for i=1, MAX_PARTY_MEMBERS do
			if(GetPartyMember(i)) then
				local icon = _G["PartyMemberFrame"..i.."PhasingIcon"]
				icon.Show = nil
				icon:Show()
			end
		end
	end

	if db.sysmessage == true then
		UIErrorsFrame:UnregisterEvent("SYSMSG")
	else
		UIErrorsFrame:RegisterEvent("SYSMSG")
	end
	if db.infomessage == true then
		UIErrorsFrame:UnregisterEvent("UI_INFO_MESSAGE")
	else
		UIErrorsFrame:RegisterEvent("UI_INFO_MESSAGE")
	end
	if db.errormessage == true then
		UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	else
		UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
	end
	if db.zonetext == true then
		ZoneTextFrame:UnregisterAllEvents()
		ZoneTextFrame:Hide()
	else
		ZoneTextFrame:RegisterEvent("ZONE_CHANGED")
		ZoneTextFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
		ZoneTextFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	end
	if db.subzonetext == true then
		SubZoneTextFrame:UnregisterAllEvents()
		SubZoneTextFrame:Hide()
	else
		SubZoneTextFrame:RegisterEvent("ZONE_CHANGED")
		SubZoneTextFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
		SubZoneTextFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	end
end
