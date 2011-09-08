


local function GetRange(unitid)

end

local function CheckRanges(self)
	currentTime = GetTime()
	if currentTime < nextRangeCheckup then return end
	nextRangeCheckup = currentTime + updateFreq
	local group, size, index, unitid, inRange
	local estRange = nil
	-- Check Group Type
	if UnitInRaid("player") then group = "raid"; size = GetNumRaidMembers() - 1
	elseif UnitInParty("player") then group = "party"; size = GetNumPartyMembers()
	else group = nil end

	-- Cycle through Group
	if group then
		for index = 1, size do
			unitid = group..index	
			Ranges[UnitName(unitid)] = GetRange(unitid)
		end
	end
	
	--Ranges[UnitName("pet")] = GetRange("pet")		-- For testing
	
	-- Check Cache
	for name, range in pairs(Ranges) do 
		if range ~= RangesCache[name] then
			--print("Range Change")
			RangesCache[name] = range
			TidyPlates:Update()
		end
	end	
end

local usingRangeWidget = false
local function ActivateRangeWidget()
	if usingRangeWidget then 
		wipe(Ranges)
		if (UnitInRaid("player") or UnitInParty("player")) then 
			RangeWatcher:SetScript("OnUpdate", CheckRanges)
		else RangeWatcher:SetScript("OnUpdate", nil) end	
	end
end

RangeWatcher:SetScript("OnEvent", ActivateRangeWidget)
RangeWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
RangeWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")


---------------------------------------------------------------------------

-- Widget
local art = "Interface\\Addons\\TidyPlates\\Widgets\\RangeWidget\\RangeWidget"

local function UpdateHealerTrackWidget(self, unit, range)
		local unitrange, saferange
		saferange = range or self.Range
		if unit.reaction == "FRIENDLY" then --and unit.type == "PLAYER" then 
			unitrange = Ranges[unit.name] or 100
			--self.String:SetText(range) 
			if unitrange <= saferange then 
				self.Texture:Show()
				self.Texture:SetVertexColor(1,.25,0,.50)  -- Red
				--self.Texture:SetVertexColor(1,.1,0,.55)  -- Red
			--elseif unitrange == self.unitrange then 
			--	self.Texture:Show()
			--	self.Texture:SetVertexColor(1,.5,0,.25)
				--self.String:SetTextColor(1,.5,0)
			else self.Texture:Hide() end
			self:Show()
		else self:Hide() end
end

local function CreateHealerTrackWidget(parent)
	--if not usingRangeWidget then usingRangeWidget = true end
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(16); frame:SetHeight(16)
	-- Image
	frame.Texture = frame:CreateTexture(nil, "OVERLAY")
	frame.Texture:SetTexture(art)
	frame.Texture:SetPoint("CENTER")
	frame.Texture:SetWidth(128)
	frame.Texture:SetHeight(128)
	-- Vars and Mech
	frame.Range = 15
	frame:Hide()
	frame.Update = UpdateHealerTrackWidget
	return frame
end

TidyPlatesWidgets.CreateHealerTrackWidget = CreateHealerTrackWidget




			