-- ----------------------------------------------------------------------------
-- Raid Frame Indicators by Szandos
-- ----------------------------------------------------------------------------
Indicators = LibStub( "AceAddon-3.0" ):NewAddon( "Indicators", "AceTimer-3.0" )
local media = LibStub:GetLibrary("LibSharedMedia-3.0")
local debug = true
local f = {} -- Indicators for the frames
local playerName

-- Hide buff/debuff icons
local function HideBuffs(frame)
	if frame.optionTable.displayBuffs then -- Normal frame
		if not Indicators.db.profile.showBuffs then
			CompactUnitFrame_HideAllBuffs(frame)
		end
	end
end
hooksecurefunc("CompactUnitFrame_UpdateBuffs", HideBuffs)

local function HideDebuffs(frame)
	if frame.optionTable.displayBuffs then -- Normal frame
		if not Indicators.db.profile.showDebuffs then
			CompactUnitFrame_HideAllDebuffs(frame)
		end
	end
end
hooksecurefunc("CompactUnitFrame_UpdateDebuffs", HideDebuffs)

local function HideDispelDebuffs(frame)
	if frame.optionTable.displayBuffs then -- Normal frame
		if not Indicators.db.profile.showDispelDebuffs then
			CompactUnitFrame_HideAllDispelDebuffs(frame)
		end
	end
end
hooksecurefunc("CompactUnitFrame_UpdateDispellableDebuffs", HideDispelDebuffs)

-- Create the FontStrings used for indicators
function Indicators.CreateIndicator(frame)
	local unit = frame.unit
	local frameName = frame:GetName()
	--dPrint ("Creating a new indicator for unit: "..unit.." Frame: "..frameName)
	f[frameName] = {}
	
	-- Create indicators
	local pad = 2
	for i = 1, 9 do
		f[frameName][i] = {}
		f[frameName][i].text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		f[frameName][i].icon = frame:CreateTexture(nil, "OVERLAY")
		if i == 1 then 
			f[frameName][i].text:SetPoint("TOPLEFT", frame, "TOPLEFT", pad, -pad)
			f[frameName][i].icon:SetPoint("TOPLEFT", frame, "TOPLEFT", pad, -pad)
		end
		if i == 2 then 
			f[frameName][i].text:SetPoint("TOP", frame, "TOP", 0, -pad) 
			f[frameName][i].icon:SetPoint("TOP", frame, "TOP", 0, -pad) 
		end
		if i == 3 then 
			f[frameName][i].text:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -pad, -pad) 
			f[frameName][i].icon:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -pad, -pad) 
		end
		if i == 4 then 
			f[frameName][i].text:SetPoint("LEFT", frame, "LEFT", pad, 0) 
			f[frameName][i].icon:SetPoint("LEFT", frame, "LEFT", pad, 0) 
		end
		if i == 5 then 
			f[frameName][i].text:SetPoint("CENTER", frame, "CENTER", 0, 0) 
			f[frameName][i].icon:SetPoint("CENTER", frame, "CENTER", 0, 0) 
		end
		if i == 6 then 
			f[frameName][i].text:SetPoint("RIGHT", frame, "RIGHT", -pad, 0) 
			f[frameName][i].icon:SetPoint("RIGHT", frame, "RIGHT", -pad, 0) 
		end
		if i == 7 then 
			f[frameName][i].text:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", pad, pad) 
			f[frameName][i].icon:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", pad, pad) 
		end
		if i == 8 then 
			f[frameName][i].text:SetPoint("BOTTOM", frame, "BOTTOM", 0, pad) 
			f[frameName][i].icon:SetPoint("BOTTOM", frame, "BOTTOM", 0, pad) 
		end
		if i == 9 then 
			f[frameName][i].text:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -pad, pad) 
			f[frameName][i].icon:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -pad, pad) 
		end
	end
	
	-- Set appearance
	Indicators.SetIndicatorAppearance(frame)
end

-- Set the appearance of the FontStrings
function Indicators.SetIndicatorAppearance(frame)
	local unit = frame.unit
	local frameName = frame:GetName()
	
	-- Check if the frame is poiting at anything
	if not unit then return end
	if not f[frameName] then return end
	
	local font = media and media:Fetch('font', Indicators.db.profile.indicatorFont) or STANDARD_TEXT_FONT
	
	--dPrint ("SetIndicatorAppearance")
	for i = 1, 9 do
		f[frameName][i].text:SetFont(font, Indicators.db.profile["size"..i], "OUTLINE")
		f[frameName][i].text:SetTextColor(Indicators.db.profile["color"..i].r, Indicators.db.profile["color"..i].g, Indicators.db.profile["color"..i].b, Indicators.db.profile["color"..i].a)
		f[frameName][i].icon:SetWidth(Indicators.db.profile["iconSize"..i])
		f[frameName][i].icon:SetHeight(Indicators.db.profile["iconSize"..i])
		if Indicators.db.profile["showIcon"..i] then 
			f[frameName][i].icon:Show()
		else
			f[frameName][i].icon:Hide()
		end
	end
end

-- Update all indicators
function Indicators:UpdateAllIndicators()
	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", Indicators.UpdateIndicatorFrame)
end

-- Check the indicators on a frame and update the times on them
function Indicators.UpdateIndicatorFrame(frame)
	local currentTime = GetTime()
	local unit = frame.unit
	local frameName = frame:GetName()
	
	-- Check if the frame is pointing at anything
	if not unit then return end
	
	-- Check if the indicator frame exists, else create it
	if not f[frameName] then
		Indicators.CreateIndicator(frame)
	end

	-- Get all unit buffs
	local unitAuras = {}
	local auraName, icon, count, expirationTime, castBy, debuffType, spellId
	local i = 1
	while true do
		auraName, _, icon, count, _, _, expirationTime, castBy, _, _, spellId = UnitBuff(unit, i)
		if not spellId then break end
		if (not unitAuras[spellId]) or castBy == "player" then	-- Overwrite other players buffs if we found same one cast by ourselves
			unitAuras[spellId] = {}
			unitAuras[spellId].count = count
			unitAuras[spellId].expirationTime = expirationTime
			unitAuras[spellId].castBy = castBy
			unitAuras[spellId].icon = icon
			unitAuras[auraName] = spellId -- Store reverse lookup to make finding auras based on names easier
			--dPrint ("Name: "..auraName.." ID: "..spellId.." Stack: "..count)
		end
		i = i + 1
	end

	-- Get all unit debuffs
	i = 1
	while true do
		auraName, _, icon, count, debuffType, _, expirationTime, castBy, _, _, spellId  = UnitDebuff(unit, i)
		if not spellId then break end
		unitAuras[spellId] = {}
		unitAuras[spellId].count = count
		unitAuras[spellId].expirationTime = expirationTime
		unitAuras[spellId].castBy = castBy
		unitAuras[spellId].icon = icon
		unitAuras[spellId].auraName = auraName -- DEBUG
		unitAuras[auraName] = spellId -- Store reverse lookup to make finding auras based on names easier
		if debuffType then -- Catch Poison/Curse/Magic/Disease
			unitAuras[debuffType] = spellId -- Store reverse lookup to make finding auras based on names easier
		end
		--if auraName == "Deep Corruption" then
		--	dPrint (" ID: "..spellId.." Stack: "..count)
		--end
		i = i + 1
	end
	
	-- Loop over the indicators and see if we get a hit
	local remainingTime, remainingTimeAsText, showIndicator
	for i = 1, 9 do
		remainingTimeAsText = ""
		icon = ""
		filter = ""
		showIndicator = true
		
		-- If we only are to show the indicator on me, then don't bother if I'm not the unit
		if Indicators.db.profile["me"..i] then 
			local uName, uRealm
			uName, uRealm = UnitName(unit)
			if uName ~= playerName or uRealm ~= nil then
				showIndicator = false
			end
		end
		if showIndicator then
			-- Parse the aura string
			for w in string.gmatch(Indicators.db.profile["auras"..i], "[^\n]+") do -- Grab each line
				local aura = nil
				auraName = string.gsub(w, "^%s*(.-)%s*$", "%1") -- Strip any whitespaces
				-- Check if the aura exist
				if tonumber(auraName) then  -- Use spell id
					aura = unitAuras[tonumber(auraName)]
 				else -- Use spell name
					if unitAuras[auraName] then aura = unitAuras[unitAuras[auraName]] end
				end
				if aura then
					--if aura.auraName == "Deep Corruption" then
					--	dPrint ("DEBUG ID: "..auraName.." Stack: "..aura.count)
					--end
					count = aura.count
					expirationTime = aura.expirationTime
					castBy = aura.castBy
					-- If we only are to show spells cast by me, make sure the spell is
					if (not Indicators.db.profile["mine"..i]) or (Indicators.db.profile["mine"..i] and castBy == "player") then 
						-- Set icon
						icon = aura.icon
						if expirationTime == 0 then -- No expiration time = permanent
							if not Indicators.db.profile["showIcon"..i] then
								remainingTimeAsText = "■" -- Only show the blob if we don't show the icon
							end
						else
							if Indicators.db.profile["showText"..i] then
								-- Pretty formating of the remaining time text
								remainingTime = expirationTime - currentTime
								if remainingTime > 60 then 
									remainingTimeAsText = ceil(remainingTime / 60).."m" -- Show minutes without seconds
								elseif remainingTime > 10 or not Indicators.db.profile["showDecimals"..i] then 
									remainingTimeAsText = string.format("%d", floor(remainingTime*10+0.5)/10) -- Show seconds without decimals
								else
									remainingTimeAsText = string.format("%.1f", floor(remainingTime*10+0.5)/10) -- Show seconds with one decimal
								end
							else
								remainingTimeAsText = ""
							end
							
						end
						
						-- Add stack count
						if Indicators.db.profile["stack"..i] and count > 0 then
							if Indicators.db.profile["showText"..i] and expirationTime > 0 then
								remainingTimeAsText = count.."-"..remainingTimeAsText
							else
								remainingTimeAsText = count
							end
						end
							
						-- Set color
						if Indicators.db.profile["stackColor"..i] then
							if count == 1 then 
								f[frameName][i].text:SetTextColor(1,0,0,1)
							elseif count == 2 then 
								f[frameName][i].text:SetTextColor(1,1,0,1)
							else
								f[frameName][i].text:SetTextColor(0,1,0,1) 
							end
						elseif Indicators.db.profile["colorByTime"..i] then
							if remainingTime < 3 then 
								f[frameName][i].text:SetTextColor(1,0,0,1) 
							elseif remainingTime < 5 then 
								f[frameName][i].text:SetTextColor(1,1,0,1) 
							end
						end
						
						--dPrint ("Found aura: "..auraName..", Time: "..remainingTimeAsText..", Icon: "..icon..", spellId: "..spellId)
						break -- We found a match, so no need to continue the for loop
					end
				end
			end
	
			-- Reverse indicator if we only want to show when missing
			if Indicators.db.profile["missing"..i] then
				icon = ""
				if expirationTime then 
					remainingTimeAsText = ""
				else
					remainingTimeAsText = "■" 
				end
			end	
		end
		
		-- Show the text
		f[frameName][i].text:SetText(remainingTimeAsText)
		
		-- Show the icon
		f[frameName][i].icon:SetTexture(icon)
	end
end

-- Used to update everything that is affected by the configuration
function Indicators:RefreshConfig()
	-- Set the appearance of the indicators
	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", Indicators.SetIndicatorAppearance)
	
	-- Show/hide default icons
	CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", function (frame)
		HideDebuffs(frame)
		HideDispelDebuffs(frame)
		HideBuffs(frame)
	end)
end

function Indicators:OnInitialize()
	-- Set up config pane
	self:SetupOptions()
	
	-- Get the player name
	playerName = UnitName("player")
	
	-- Register callbacks for profile switching
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	--dPrint ("Initialized")
end

function Indicators:OnEnable()
	if self.db.profile.enabled then
		-- Start update
		self.updateTimer = self:ScheduleRepeatingTimer("UpdateAllIndicators", 0.1)
		--dPrint ("Enabled")
	end
end

function Indicators:OnDisable()
	-- Stop update
	self:CancelAllTimers()
	
	-- Hide all indicators
	for frameName, _ in pairs(f) do
		for i = 1, 9 do
			f[frameName][i].text:SetText("")
			f[frameName][i].icon:SetTexture("")
		end
	end
	--dPrint ("Disabled")
end

function dPrint(s)
	if debug then
		DEFAULT_CHAT_FRAME:AddMessage("Indicators: ".. tostring(s))
	end
end
