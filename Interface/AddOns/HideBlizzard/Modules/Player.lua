local Player = HideBlizzard:NewModule("Player")

local db
local defaults = {
	profile = {
		["armoredman"] = nil,
		["aura"] = nil,
		["druidmanabar"] = nil,
		["eclipsebar"] = nil,
		["playercastbar"] = nil,
		["playerunitframe"] = nil,
		["powerbar"] = nil,
		["runeframe"] = nil,
		["shardframe"] = nil,
		["totemframe"] = nil,
	},
}

local options = nil
local function opt()
	if not options then
		options = {
			type = "group",
--			inline = true,
			name = "Player",
			desc = "Player module hides player related frames",
			arg = "Player",
			get = function(info)
						local key = info[#info]
						return db[key]
					end,
			set = function(info, value)
						local key = info[#info]
						db[key] = value
						Player:UpdateView()
					end,
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = "|cff00ff66Enable Player|r",
--					descStyle = "inline",
--					desc = "Player module hides player related frames",
					width = "full",
					get = function() return HideBlizzard:GetModuleEnabled("Player") end,
					set = function(info, value) HideBlizzard:SetModuleEnabled("Player", value) end,
				},
				spacer = {
					type = "description",
					order = 1.5,
					name = "",
				},
				armoredman = {
					type = "toggle",
					order = 2,
					name = "Armored Man",
					desc = "Hides the armored man under the minimap",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				aura = {
					type = "toggle",
					order = 3,
					name = "Aura",
					desc = "Hides the buff and debuff frame",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				druidmanabar = {
					type = "toggle",
					order = 4,
					name = "Druid Mana Bar",
					desc = "Hides the druid mana bar when you shapeshift",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				eclipsebar = {
					type = "toggle",
					order = 5,
					name = "Eclipse Bar",
					desc = "Hides the druid eclipse bar",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				playercastbar = {
					type = "toggle",
					order = 6,
					name = "Player Cast Bar",
					desc = "Hides the player cast bar",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				playerunitframe = {
					type = "toggle",
					order = 7,
					name = "Player Unit Frame",
					desc = "Hides the player unit frame",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				powerbar = {
					type = "toggle",
					order = 8,
					name = "Power Bar",
					desc = "Hides the paladin power bar",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				runeframe = {
					type = "toggle",
					order = 9,
					name = "Rune Frame",
					desc = "Hides the rune frame",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				shardframe = {
					type = "toggle",
					order = 10,
					name = "Shard Frame",
					desc = "Hides the shard frame",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
				totemframe = {
					type = "toggle",
					order = 11,
					name = "Totem Frame",
					desc = "Hides the totem frame",
	--					width = "full",
					disabled = function() return not Player:IsEnabled() end,
				},
			},
		}
		return options
	end
end

function Player:OnInitialize()
	self:SetEnabledState(HideBlizzard:GetModuleEnabled("Player"))
	self.db = HideBlizzard.db:RegisterNamespace("Player", defaults)
	db = self.db.profile

	HideBlizzard:RegisterModuleOptions("Player", opt, "Player")
end

function Player:OnEnable()
	self:UpdateView()
end

function Player:OnDisable()
	self:UpdateView()
end

function Player:UpdateView()
	db = self.db.profile

	local class = UnitClass("player")

	if db.armoredman == true then
		DurabilityFrame:Hide() 
		DurabilityFrame.Show = function() end
	else
		DurabilityFrame.Show = nil
		DurabilityFrame:Show()
	end

	if db.aura == true then
		BuffFrame:UnregisterAllEvents()
		BuffFrame:Hide()
	else
		BuffFrame:Show()
		BuffFrame:RegisterEvent("UNIT_AURA")
		BuffFrame_Update()
	end

	if db.druidmanabar == true then
		for shapeshiftIndex=1, GetNumShapeshiftForms() do
			local active = GetShapeshiftFormInfo(shapeshiftIndex)
			if active then
				PlayerFrameAlternateManaBar:Hide()
				PlayerFrameAlternateManaBar:UnregisterAllEvents()
				PlayerFrameAlternateManaBar.Show = function() end
			else
				PlayerFrameAlternateManaBar:Hide()
				PlayerFrameAlternateManaBar:UnregisterAllEvents()
				PlayerFrameAlternateManaBar.Show = function() end
			end
		end
	else
		for shapeshiftIndex=1, GetNumShapeshiftForms() do
			local active = GetShapeshiftFormInfo(shapeshiftIndex)
			if active then
				PlayerFrameAlternateManaBar.Show = nil
				PlayerFrameAlternateManaBar:Show()
				PlayerFrameAlternateManaBar:RegisterEvent("UNIT_POWER")
				PlayerFrameAlternateManaBar:RegisterEvent("UNIT_MAXPOWER")
				PlayerFrameAlternateManaBar:RegisterEvent("PLAYER_ENTERING_WORLD")
				PlayerFrameAlternateManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
				AlternatePowerBar_UpdateValue(PlayerFrameAlternateManaBar)
				AlternatePowerBar_UpdateMaxValues(PlayerFrameAlternateManaBar)
				AlternatePowerBar_UpdatePowerType(PlayerFrameAlternateManaBar)
			else
				PlayerFrameAlternateManaBar:Hide()
				PlayerFrameAlternateManaBar.Show = function() end
			end
		end
	end

	if db.eclipsebar == true then
		if (class == "DRUID") and GetPrimaryTalentTree() == 1 then
			EclipseBar:Hide()
			EclipseBar:UnregisterAllEvents()
			EclipseBar.Show = function() end
		end
	else
		if (class == "DRUID") and GetPrimaryTalentTree() == 1 then
			EclipseBar.Show = nil
			EclipseBar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
			EclipseBar:RegisterEvent("PLAYER_TALENT_UPDATE")
			EclipseBar:RegisterEvent("CVAR_UPDATE")
			EclipseBar:RegisterEvent("UNIT_AURA")
			EclipseBar:RegisterEvent("ECLIPSE_DIRECTION_CHANGE")
		end
	end

	if db.playercastbar == true then
		CastingBarFrame:UnregisterAllEvents()
	else
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_START")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
		CastingBarFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	end

	if db.playerunitframe == true then
		PlayerFrame:Hide()
		PlayerFrame:UnregisterAllEvents()
		PlayerFrame.Show = function() end
		PlayerFrame:RegisterEvent('UNIT_ENTERING_VEHICLE')
		PlayerFrame:RegisterEvent('UNIT_ENTERED_VEHICLE')
		PlayerFrame:RegisterEvent('UNIT_EXITING_VEHICLE')
		PlayerFrame:RegisterEvent('UNIT_EXITED_VEHICLE')
	else
		PlayerFrame.Show = nil
		PlayerFrame:Show()
		PlayerFrame:RegisterEvent("UNIT_LEVEL")
		PlayerFrame:RegisterEvent("UNIT_COMBAT")
		PlayerFrame:RegisterEvent("UNIT_FACTION")
		PlayerFrame:RegisterEvent("UNIT_MAXPOWER")
		PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
		PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
		PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
		PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
		PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
		PlayerFrame:RegisterEvent("VOICE_START")
		PlayerFrame:RegisterEvent("VOICE_STOP")
		PlayerFrame:RegisterEvent("RAID_ROSTER_UPDATE")
		PlayerFrame:RegisterEvent("READY_CHECK")
		PlayerFrame:RegisterEvent("READY_CHECK_CONFIRM")
		PlayerFrame:RegisterEvent("READY_CHECK_FINISHED")
		PlayerFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_ENTERING_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_EXITING_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
		PlayerFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
		PlayerFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
		PlayerFrame:RegisterEvent("PLAYTIME_CHANGED")
	end

	if db.powerbar == true then
		if (class == "PALADIN") then
			PaladinPowerBar:Hide()
			PaladinPowerBar:UnregisterAllEvents()
			PaladinPowerBar.Show = function() end
		end
	else
		if (class == "PALADIN") then
			PaladinPowerBar.Show = nil
			PaladinPowerBar:Show()
			PaladinPowerBar:RegisterEvent("UNIT_POWER")
			PaladinPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")
			PaladinPowerBar:RegisterEvent("UNIT_DISPLAYPOWER")
		end
	end

	if db.runeframe == true then
		if (class == "DEATHKNIGHT") then
			RuneFrame:Hide()
			RuneFrame:UnregisterAllEvents()
		end
	else
		if (class == "DEATHKNIGHT") then
			RuneFrame:Show()
			RuneFrame:RegisterEvent("RUNE_POWER_UPDATE")
			RuneFrame:RegisterEvent("RUNE_TYPE_UPDATE")
			RuneFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
	end

	if db.shardframe == true then
		for i=1, SHARD_BAR_NUM_SHARDS do
			local shard = _G["ShardBarFrameShard"..i]
			shard:Hide()
			shard:UnregisterAllEvents()
			shard.Show = function() end
		end
	else
		for i=1, SHARD_BAR_NUM_SHARDS do
			local shard = _G["ShardBarFrameShard"..i]
			shard.Show = nil
			shard:Show()
			ShardBarFrame:RegisterEvent("PLAYER_LEVEL_UP")
			ShardBarFrame:RegisterEvent("UNIT_POWER")
			ShardBarFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
			ShardBarFrame:RegisterEvent("UNIT_DISPLAYPOWER")
		end
	end

	-- shaman: hide
	-- deathknight: if no pet-show; hide both
	if db.totemframe == true then
		if (class == "SHAMAN") then
			for i=1, MAX_TOTEMS do
				local totem = _G["TotemFrameTotem"..i]
				totem:Hide()
				totem:UnregisterAllEvents()
				totem.Show = function() end
			end
		elseif (class == "DEATHKNIGHT") then
			if(GetPrimaryTalentTree() == 3) then
				for i=1, MAX_TOTEMS do
					local totem = _G["TotemFrameTotem"..i]
					totem.Show = nil
					totem:RegisterEvent("PLAYER_TOTEM_UPDATE")
					totem:RegisterEvent("PLAYER_ENTERING_WORLD")
					totem:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
					totem:RegisterEvent("PLAYER_TALENT_UPDATE")
					totem:RegisterForClicks("RightButtonUp")
				end
			end
		else
			for i=1, MAX_TOTEMS do
				local totem = _G["TotemFrameTotem"..i]
				totem:Hide()
				totem:UnregisterAllEvents()
				totem.Show = function() end
			end
		end
	else
		-- shaman: show
		-- deathknight: if no pet-show; show sham..hide dk
		if (class == "SHAMAN") then
			for i=1, MAX_TOTEMS do
				local totem = _G["TotemFrameTotem"..i]
				totem.Show = nil
				totem:RegisterEvent("PLAYER_TOTEM_UPDATE")
				totem:RegisterEvent("PLAYER_ENTERING_WORLD")
				totem:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
				totem:RegisterEvent("PLAYER_TALENT_UPDATE")
				totem:RegisterForClicks("RightButtonUp")
			end
		elseif (class == "DEATHKNIGHT") then
			 if(GetPrimaryTalentTree() == 3) then
				for i=1, MAX_TOTEMS do
					local totem = _G["TotemFrameTotem"..i]
					totem.Show = nil
					totem:RegisterEvent("PLAYER_TOTEM_UPDATE")
					totem:RegisterEvent("PLAYER_ENTERING_WORLD")
					totem:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
					totem:RegisterEvent("PLAYER_TALENT_UPDATE")
					totem:RegisterForClicks("RightButtonUp")
				end
			end
		else
			for i=1, MAX_TOTEMS do
				local totem = _G["TotemFrameTotem"..i]
				totem.Show = nil
				totem:RegisterEvent("PLAYER_TOTEM_UPDATE")
				totem:RegisterEvent("PLAYER_ENTERING_WORLD")
				totem:RegisterForClicks("RightButtonUp")
			end
		end
	end
end
