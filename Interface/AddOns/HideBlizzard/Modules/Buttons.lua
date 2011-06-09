local Buttons = HideBlizzard:NewModule("Buttons")

local db
local defaults = {
	profile = {
		["battleground"] = nil,
		["calendar"] = nil,
		["chatbuttons"] = nil,
		["clock"] = nil,
		["lfg"] = nil,
		["mail"] = nil,
		["tracking"] = nil,
		["voice"] = nil,
		["world"] = nil,
		["zoom"] = nil,
	},
}

local options = nil
local function opt()
	if not options then
		options = {
			type = "group",
--			inline = true,
			name = "Buttons",
			desc = "Buttons module hides buttons connected to the chat and minimap frame",
			arg = "Buttons",
			get = function(info)
						local key = info[#info]
						return db[key]
					end,
			set = function(info, value)
						local key = info[#info]
						db[key] = value
						Buttons:UpdateView()
					end,
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = "|cff00ff66Enable Buttons|r",
--					descStyle = "inline",
--					desc = "Buttons module hides buttons connected to the chat and minimap frame",
					width = "full",
					get = function() return HideBlizzard:GetModuleEnabled("Buttons") end,
					set = function(info, value) HideBlizzard:SetModuleEnabled("Buttons", value) end,
				},
				spacer = {
					type = "description",
					order = 1.5,
					name = "",
				},
				battleground = {
					type = "toggle",
					order = 2,
					name = "Battleground",
					desc = "Hides the battleground queue button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				calendar = {
					type = "toggle",
					order = 3,
					name = "Calendar",
					desc = "Hides the calendar button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				chatbuttons = {
					type = "toggle",
					order = 4,
					name = "Chat Buttons",
					desc = "Hides the chat arrows on the chat frame",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				clock = {
					type = "toggle",
					order = 5,
					name = "Clock",
					desc = "Hides the clock on the minimap",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				lfg = {
					type = "toggle",
					order = 6,
					name = "Looking For Group (LFG)",
					desc = "Hides the looking for group (lfg) button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				mail = {
					type = "toggle",
					order = 7,
					name = "Mail",
					desc = "Hides the mail button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				tracking = {
					type = "toggle",
					order = 8,
					name = "Tracking",
					desc = "Hides the tracking button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				voice = {
					type = "toggle",
					order = 9,
					name = "Voice",
					desc = "Hides the voice button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				world = {
					type = "toggle",
					order = 10,
					name = "World Map",
					desc = "Hides the world map button",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
				zoom = {
					type = "toggle",
					order = 11,
					name = "Zoom",
					desc = "Hides both the zoom buttons",
	--					width = "full",
					disabled = function() return not Buttons:IsEnabled() end,
				},
			},
		}
		return options
	end
end

function Buttons:OnInitialize()
	self:SetEnabledState(HideBlizzard:GetModuleEnabled("Buttons"))
	self.db = HideBlizzard.db:RegisterNamespace("Buttons", defaults)
	db = self.db.profile

	HideBlizzard:RegisterModuleOptions("Buttons", opt, "Buttons")
end

function Buttons:OnEnable()
	self:UpdateView()
end

function Buttons:OnDisable()
	self:UpdateView()
end

function Buttons:UpdateView()
	db = self.db.profile

	if db.battleground == true then
		MiniMapBattlefieldFrame:Hide()
		MiniMapBattlefieldFrame:UnregisterAllEvents()
	else
		MiniMapBattlefieldFrame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	end

	if db.calendar == true then
		GameTimeFrame:Hide()
	else
		GameTimeFrame:Show()
	end

	if db.chatbuttons == true then
		FriendsMicroButton:Hide()
		ChatFrameMenuButton:Hide()
		for i =1, NUM_CHAT_WINDOWS do
			local up = _G["ChatFrame"..i.."ButtonFrame".."UpButton"]
			up:Hide()
			local down = _G["ChatFrame"..i.."ButtonFrame".."DownButton"]
			down:Hide()
			local bottom = _G["ChatFrame"..i.."ButtonFrame".."BottomButton"]
			bottom:Hide()

			_G["ChatFrame"..i.."ButtonFrame"]:Hide()
		end
	else
		FriendsMicroButton:Show()
		ChatFrameMenuButton:Show()
		for i =1, NUM_CHAT_WINDOWS do
			local up = _G["ChatFrame"..i.."ButtonFrame".."UpButton"]
			up:Show()
			local down = _G["ChatFrame"..i.."ButtonFrame".."DownButton"]
			down:Show()
			local bottom = _G["ChatFrame"..i.."ButtonFrame".."BottomButton"]
			bottom:Show()

			_G["ChatFrame"..i.."ButtonFrame"]:Show()
		end
	end

	if db.clock == true then
		TimeManagerClockButton:Hide()
		TimeManagerClockButton.Show = function() end
	else
		TimeManagerClockButton.Show = nil
		TimeManagerClockButton:Show()
	end

	if db.lfg == true then
		local mode = GetLFGMode()
		if mode == "queued" then
			MiniMapLFGFrame:Hide()
		end
	else
		local mode = GetLFGMode()
		if mode == "queued" then
			MiniMapLFGFrame:Show()
		end
	end

	if db.mail == true then
		if HasNewMail() then
			MiniMapMailFrame:Hide()
		end
	else
		if HasNewMail() then
			MiniMapMailFrame:Show()
		end
	end

	if db.tracking == true then
		MiniMapTracking:Hide()
		MiniMapTrackingButton:Hide()
	else
		MiniMapTracking:Show()
		MiniMapTrackingButton:Show()
	end

	if db.voice == true then
		MiniMapVoiceChatFrame:Hide()
		MiniMapVoiceChatFrame:UnregisterAllEvents()
	else
		MiniMapVoiceChat_Update()
	end

	if db.world == true then
		MiniMapWorldMapButton:Hide() 
	else
		MiniMapWorldMapButton:Show()
	end

	if db.zoom == true then
		MinimapZoomIn:Hide()
		MinimapZoomOut:Hide()
	else
		MinimapZoomIn:Show()
		MinimapZoomOut:Show()
	end
end
