local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

local options, moduleOptions = nil, {}
local function opt()
	if not options then
		options = {
			type = "group",
			name = "HideBlizzard",
			childGroups = "tab",
			get = function() get(info)
						local key = info[#info] 
						return HideBlizzard.db.profile[key]
					end,
			set = function() set(info, value)
						local key = info[#info]
						HideBlizzard.db.profile[key] = value
						HideBlizzard:UpdateView()
					end,
			args = {
				header = {
					type = "description",
					name = " |cffFF3333Version: |r"..GetAddOnMetadata("HideBlizzard", "X-Curse-Packaged-Version"),
					order = 1,
					fontSize = "medium",
					width = "full",
				},
				space = {
					type = "description",
					name = "",
					order = 2,
					width = "full",
				},
				reset = {
					type = "execute",
					name = "reset global database",
					order = -1,
					confirm = true,
					func = function() 
						wipe(HideBlizzardDB)
						print("|cff33ff99HideBlizzard|r Database has been reset! Changes will take effect when you next login")
					end,
				},
			},
		}
		options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(HideBlizzard.db)
		options.args.profiles.order = -1
		for k,v in pairs(moduleOptions) do
			options.args[k] = type(v) == "function" and v() or v
		end
	end
	return options
end

local o = {
	type = "group",
	args = {
		oc = {
			type = "group",
			name = "HideBlizzard_Blizzard",
			args = {
				occ = {
					type = "execute",
					name = "Standalone Options",
					order = 1,
					desc = "Open options!",
					func = function()
						HideUIPanel(InterfaceOptionsFrame)
						HideUIPanel(GameMenuFrame)
						AceConfigDialog:Open("HideBlizzard")
					end,
				},
			},
		},
	},
}

function HideBlizzard:RegisterOptions()
	-- Ace3
	AceConfigRegistry:RegisterOptionsTable("HideBlizzard", opt)
	-- Blizzard
	AceConfigRegistry:RegisterOptionsTable("HideBlizzard_Blizzard", o)
	AceConfigDialog:AddToBlizOptions("HideBlizzard_Blizzard", nil, nil, "oc")

	local function open()
		AceConfigDialog:Open("HideBlizzard")
	end
	self:RegisterChatCommand("hb", open)
	self:RegisterChatCommand("hideblizz", open)
	self:RegisterChatCommand("hideblizzard", open)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", function()
		if(InCombatLockdown()) then
			AceConfigDialog:Close("HideBlizzard")
		end
	end)
end

function HideBlizzard:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
end
