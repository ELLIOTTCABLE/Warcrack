-- ----------------------------------------------------------------------------
-- RaidFrameIcons by Szandos
-- ----------------------------------------------------------------------------
RaidFrameIcons = LibStub( "AceAddon-3.0" ):NewAddon( "RaidFrameIcons", "AceEvent-3.0")
local debug = false
local icons = {}

function RaidFrameIcons.SetTextureAppearance (frame)
	local pad = 3
	local pos = RaidFrameIcons.db.profile.iconPosition
	local frameName = frame:GetName()
	if not icons[frameName] then return end
	local tex = icons[frameName].texture
	
	-- Set position relative to frame
	tex:ClearAllPoints()
	if pos == "TOPLEFT" then tex:SetPoint("TOPLEFT", pad, -pad) end
	if pos == "TOP" then tex:SetPoint("TOP", 0, -pad) end
	if pos == "TOPRIGHT" then tex:SetPoint("TOPRIGHT", -pad, -pad) end
	if pos == "LEFT" then tex:SetPoint("LEFT", pad, 0) end
	if pos == "CENTER" then tex:SetPoint("CENTER", 0, 0) end
	if pos == "RIGHT" then tex:SetPoint("RIGHT", -pad, 0) end
	if pos == "BOTTOMLEFT" then tex:SetPoint("BOTTOMLEFT", pad, pad) end
	if pos == "BOTTOM" then tex:SetPoint("BOTTOM", 0, pad) end
	if pos == "BOTTOMRIGHT" then tex:SetPoint("BOTTOMRIGHT", -pad, pad) end
	
	-- Set the icon size
	tex:SetWidth(RaidFrameIcons.db.profile.iconSize)
	tex:SetHeight(RaidFrameIcons.db.profile.iconSize)
end

function RaidFrameIcons.UpdateIcon(frame)
	local unit = frame.unit
	local frameName = frame:GetName()
	
	-- If fame doesn't point at anything, no need for an icon
	if not unit then return end
	RaidFrameIcons:dPrint ("Unit: "..unit)
	
	-- Get icon on unit
	local icon = GetRaidTargetIndex(unit)
	
	-- Initialize our storage and create teture
	if not icons[frameName] then -- No icon on this frame before, need a texture
		RaidFrameIcons:dPrint ("Creating texture")
		icons[frameName] = {}
		icons[frameName].texture = frame:CreateTexture(nil, "OVERLAY")
		RaidFrameIcons.SetTextureAppearance (frame)
	end
	
	-- Only change icon texture if the icon on the frame actually changed
	if icon ~= icons[frameName].icon then
		icons[frameName].icon = icon
		if icon == nil then 
			RaidFrameIcons:dPrint ("Icon removed")
			icons[frameName].texture:Hide()
		else
			RaidFrameIcons:dPrint ("Icon: "..icon)
			icons[frameName].texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..icon)
			icons[frameName].texture:Show()
		end
	end
end

function RaidFrameIcons:UpdateAllFrames()
	self:dPrint ("Raid Icon Changed")
	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", RaidFrameIcons.UpdateIcon)
end

-- Used to update everything that is affected by the configuration
function RaidFrameIcons:RefreshConfig()
	self:dPrint ("Refreshing Config")
	
	-- Set icon size and placement
	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", RaidFrameIcons.SetTextureAppearance)
end

function RaidFrameIcons:OnInitialize()
	-- Set up config pane
	self:SetupOptions()
	
	-- Register callbacks for profile switching
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	self:dPrint ("Initialized")
end

function RaidFrameIcons:OnEnable()
	if self.db.profile.enabled then
		-- Hook raid icon updates
		self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateAllFrames")
		self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateAllFrames")
	
		-- Make sure any icons already existing are shown
		RaidFrameIcons:UpdateAllFrames()
		self:dPrint ("Enabled")
	end
end

function RaidFrameIcons:OnDisable()
	-- Unhook raid icon updates
	self:UnregisterAllEvents()
	
	for frameName, _ in pairs(icons) do
		icons[frameName].icon = nil
		icons[frameName].texture:Hide()
	end
	self:dPrint ("Disabled")
end

function RaidFrameIcons:dPrint(s)
	if debug then
		DEFAULT_CHAT_FRAME:AddMessage("RaidFrameIcons: ".. tostring(s))
	end
end
