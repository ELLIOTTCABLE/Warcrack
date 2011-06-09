local Pet = HideBlizzard:NewModule("Pet")

local db
local defaults = {
	profile = {
		["petactionbar"] = nil,
		["petcastbar"] = nil,
		["pethappyframe"] = nil,
		["petunitframe"] = nil,
	},
}

local options = nil
local function opt()
	if not options then
		options = {
			type = "group",
--			inline = true,
			name = "Pet",
			desc = "Pet module hides pet related frames",
			arg = "Pet",
			get = function(info)
						local key = info[#info]
						return db[key]
					end,
			set = function(info, value)
						local key = info[#info]
						db[key] = value
						Pet:UpdateView()
					end,
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = "|cff00ff66Enable Pet|r",
--					descStyle = "inline",
--					desc = "Pet module hides pet related frames",
					width = "full",
					get = function() return HideBlizzard:GetModuleEnabled("Pet") end,
					set = function(info, value) HideBlizzard:SetModuleEnabled("Pet", value) end,
				},
				spacer = {
					type = "description",
					order = 1.5,
					name = "",
				},
				petactionbar = {
					type = "toggle",
					order = 2,
					name = "Pet Action Bar",
					desc = "Hides the pet action bar",
	--					width = "full",
					disabled = function() return not Pet:IsEnabled() end,
				},
				petcastbar = {
					type = "toggle",
					order = 3,
					name = "Pet Cast Bar",
					desc = "Hides the pet casting bar",
	--					width = "full",
					disabled = function() return not Pet:IsEnabled() end,
				},
				pethappyframe = {
					type = "toggle",
					order = 4,
					name = "Pet Happiness Frame",
					desc = "Hides the pet happiness frame",
	--					width = "full",
					disabled = function() return not Pet:IsEnabled() or db.petunitframe end,
				},
				petunitframe = {
					type = "toggle",
					order = 5,
					name = "Pet Unit Frame",
					desc = "Hides the pet unit frame",
	--					width = "full",
					disabled = function() return not Pet:IsEnabled() end,
				},
			},
		}
		return options
	end
end

function Pet:OnInitialize()
	self:SetEnabledState(HideBlizzard:GetModuleEnabled("Pet"))
	self.db = HideBlizzard.db:RegisterNamespace("Pet", defaults)
	db = self.db.profile

	HideBlizzard:RegisterModuleOptions("Pet", opt, "Pet")
end

function Pet:OnEnable()
	self:UpdateView()
end

function Pet:OnDisable()
	self:UpdateView()
end

function Pet:UpdateView()
	db = self.db.profile

	if db.petactionbar == true then
		PetActionBarFrame:Hide()
		PetActionBarFrame:UnregisterAllEvents()
		PetActionBarFrame.Show = function() end
	else
		if UnitExists("pet") then
			PetActionBarFrame.Show = nil
			PetActionBarFrame:Show()
		end
		PetActionBarFrame:RegisterEvent("PLAYER_CONTROL_LOST")
		PetActionBarFrame:RegisterEvent("PLAYER_CONTROL_GAINED")
		PetActionBarFrame:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
		PetActionBarFrame:RegisterEvent("UNIT_PET")
		PetActionBarFrame:RegisterEvent("UNIT_FLAGS")
		PetActionBarFrame:RegisterEvent("UNIT_AURA")
		PetActionBarFrame:RegisterEvent("PET_BAR_UPDATE")
		PetActionBarFrame:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
		PetActionBarFrame:RegisterEvent("PET_BAR_SHOWGRID")
		PetActionBarFrame:RegisterEvent("PET_BAR_HIDEGRID")
		PetActionBarFrame:RegisterEvent("PET_BAR_HIDE")
	end

	if db.petcastbar == true then
		PetCastingBarFrame:Hide()
		PetCastingBarFrame:UnregisterAllEvents()
	else
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_START")
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
		PetCastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
		PetCastingBarFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		PetCastingBarFrame:RegisterEvent("UNIT_PET")
	end

	if db.pethappyframe == true then
		PetFrameHappiness:Hide()
		PetFrameHappiness.Show = function() end
	else
		if UnitExists("pet") then
			PetFrameHappiness.Show = nil
		end
		PetFrame:RegisterEvent("UNIT_HAPPINESS")
		PetFrame:RegisterEvent("PET_UI_UPDATE")
	end

	if db.petunitframe == true then
		PetFrame:Hide()
		PetFrame:UnregisterAllEvents()
		PetFrame.Show = function() end
	else
		if UnitExists("pet") then
			PetFrame.Show = nil
			PetFrame:Show()
		end
		PetFrame:RegisterEvent("UNIT_PET")
		PetFrame:RegisterEvent("UNIT_COMBAT")
		PetFrame:RegisterEvent("UNIT_AURA")
		PetFrame:RegisterEvent("PET_ATTACK_START")
		PetFrame:RegisterEvent("PET_ATTACK_STOP")
		PetFrame:RegisterEvent("UNIT_HAPPINESS")
		PetFrame:RegisterEvent("PET_UI_UPDATE")
		PetFrame:RegisterEvent("PET_RENAMEABLE")
	end
end
