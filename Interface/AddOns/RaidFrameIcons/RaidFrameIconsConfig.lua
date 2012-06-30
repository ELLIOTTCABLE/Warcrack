local Defaults = {}

function CreateDefaults ()
	Defaults.profile = {
		iconSize = 10,
		iconPosition = "CENTER",
		enabled = true,
	}
end

local Options = {}
function CreateOptions ()
	Options = {
		type = 'group',
		childGroups = 'tree',
		get = function(item) return RaidFrameIcons.db.profile[item[#item]] end,
		set = function(item, value) RaidFrameIcons.db.profile[item[#item]] = value; RaidFrameIcons:RefreshConfig() end,
		args  = {
			iconSize = {
				type = 'range',
				name = "Icon Size",
				desc = "The size of the raid icons",
				min = 1,
				max = 40,
				step = 1,
				order = 10,
			},
			iconPosition = {
				type = "select",
				name = "Icon Position",
				desc = "Position of the raid icon relative to the frame",
				order = 20,
				values = { ["TOPLEFT"] = "Top Left", ["TOP"] = "Top", ["TOPRIGHT"] = "Top Right" ,
						["LEFT"] = "Left", ["CENTER"] = "Center", ["RIGHT"] = "Right",
						["BOTTOMLEFT"] = "Bottom Left", ["BOTTOM"] = "Bottom", ["BOTTOMRIGHT"] = "Bottom Right"},
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable indicators",
				order = 25,
				set = function(item, value) 
					RaidFrameIcons.db.profile[item[#item]] = value
					if value == true then 
						RaidFrameIcons:OnEnable() 
					else
						RaidFrameIcons:OnDisable()
					end
				end,
			}
		}
	}
end

local SlashCommands = {
        type    = "group",
	args  = {
		enable = {
			type = "execute",
			name = "enable",
			desc = "Enable RaidFrameIcons",
			func = function() RaidFrameIcons.db.profile.enabled = true; RaidFrameIcons:OnEnable() end,
		},
		disable = {
			type = "execute",
			name = "disable",
			desc = "Disable RaidFrameIcons",
			func = function() RaidFrameIcons.db.profile.enabled = false; RaidFrameIcons:OnDisable() end,
		},
		config = {
			type = "execute",
			name = "config",
			desc = "Show config",
			func = function() RaidFrameIcons:ShowConfig() end,
		},
	}
}

function RaidFrameIcons:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.Profile)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.RaidFrameIcons)
end

function RaidFrameIcons:SetupOptions()
 	-- Set up defaults
	CreateDefaults()
	self.db = LibStub("AceDB-3.0"):New("RaidFrameIconsDB", Defaults)
	
	-- Profile handling
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	
	-- Get the config up
	CreateOptions()
	local config = LibStub("AceConfig-3.0")
	config:RegisterOptionsTable("Raid Frame Icons", Options)
	config:RegisterOptionsTable("Raid Frame Icons Profiles", profiles)
	
	-- Register slash commands
	config:RegisterOptionsTable("Raid Frame Icons Options", SlashCommands, {"RaidFrameIcons"})
	
	-- Add to Blizz option pane
	local dialog = LibStub("AceConfigDialog-3.0")
	self.optionsFrames = {}
	self.optionsFrames.RaidFrameIcons = dialog:AddToBlizOptions("Raid Frame Icons","Raid Frame Icons")
	self.optionsFrames.Profile = dialog:AddToBlizOptions("Raid Frame Icons Profiles","Profiles", "Raid Frame Icons")
end