TidyPlatesData.UnitDescriptions = {}
TidyPlatesData.UnitClass = {}

local UnitCacheMonitor

local function UpdateUnitInfo(frame, event, ...)
	local name, class, level, description, _, unitadded
	
	if UnitIsPlayer( "mouseover" ) then
		name = UnitName("mouseover")
		description = GetGuildInfo("mouseover")
		_, class = UnitClass("mouseover")
		
		if TidyPlatesData.UnitClass[name] ~= class then 
			unitadded = true
			TidyPlatesData.UnitClass[name] = class
		end
		
	elseif GameTooltipTextLeft1:GetText() == UnitName("mouseover") then
		--print(GameTooltipTextLeft1:GetText(), GameTooltipTextLeft2:GetText(), GameTooltipTextLeft3:GetText(), GameTooltipTextLeft4:GetText(), GameTooltipTextLeft5:GetText())
		
		name = GameTooltipTextLeft1:GetText()
		description = GameTooltipTextLeft2:GetText()
		if description then
			_, level = strsplit( " ", description )
			if tonumber(level) or level == "??" then
				description = nil
			end
			
		end
	
	end

	if TidyPlatesData.UnitDescriptions[name] ~= description then 
		unitadded = true
		TidyPlatesData.UnitDescriptions[name] = description
	end
	
	if unitadded then TidyPlates:RequestDelegateUpdate() end
end

local function Enable()
	if not UnitCacheMonitor then UnitCacheMonitor = CreateFrame("Frame") end
	UnitCacheMonitor:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	UnitCacheMonitor:SetScript("OnEvent", UpdateUnitInfo)
	
	if not TidyPlatesData.UnitDescriptions then TidyPlatesData.UnitDescriptions = {} end
	if not TidyPlatesData.UnitClass then TidyPlatesData.UnitClass = {} end
end

local function Disable() 
	if UnitCacheMonitor then
		UnitCacheMonitor:SetScript("OnEvent", nil)
		UnitCacheMonitor:UnregisterAllEvents()
		UnitCacheMonitor = nil
	end
end

TidyPlatesUtility.EnableUnitCache = Enable
TidyPlatesUtility.DisableUnitCache = Disable


--[[

/run TidyPlatesUtility.EnableUnitCache()

local isPlayer = UnitIsPlayer( "mouseover" )
local reaction = UnitReaction( "mouseover", "player" ) -- 4 is neutral

if not isPlayer then
	DocsScanningTooltip:ClearLines()
	DocsScanningTooltip:SetUnit( "mouseover" )
	local text = DocsScanningTooltipTextLeft3:GetText()
	
	if text then
		_, text = strsplit( " ", text )
		
		if text=="??" or tonumber( text ) then
			global.npcList[name] = DocsScanningTooltipTextLeft2:GetText()
		else
			global.npcList[name] = "NONE"
		end
	else
		global.npcList[name] = "NONE"
	end
	
	if UnitClassification( "mouseover" )=="worldboss" then collectUnitInfo( "mouseover" ) end
else
	collectUnitInfo( "mouseover" )
end
--]]

