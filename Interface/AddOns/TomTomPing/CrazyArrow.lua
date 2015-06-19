local _G = _G

-- addon name and namespace
local ADDON, NS = ...

local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON)

-- the CrazyArrow module
local CrazyArrow = Addon:NewModule("CrazyArrow")

-- local functions
local GetPlayerFacing = _G.GetPlayerFacing
local GetUnitSpeed    = _G.GetUnitSpeed

local cos, sin, rad, atan2 = math.cos, math.sin, math.rad, math.atan2
local sqrt, abs, floor = math.sqrt, math.abs, math.floor

local pairs   = pairs
local tinsert = table.insert

-- aux variables
local _

-- setup libs
local LibStub   = LibStub

-- translations
local L = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

-- constants
local PI         = math.pi
local TWOPI      = PI * 2
local FRAD       = 180 / PI
local CRAD       = FRAD / 10
local HALF_PI    = PI / 2
local ONE_DIV_PI = 1 / PI

local CELL_FACTOR   = 1 / TWOPI * 108
local COL_FACTOR    = 56 / 512
local ROW_FACTOR    = 42 / 512
local COL_FACTOR_UP = 53 / 512
local ROW_FACTOR_UP = 70 / 512

-- module data
local moduleData = {
	tomtomOk       = false,
	errorMsg       = "",
	-- arrow data
	pingActive     = false,
	lastArrowText  = "",
	arrowIsNormal  = false,
	arrowWasNormal = true,
	clrCount       = 0,
	alertHue       = 0,
	alertPulseOn   = true,
}

local status = {}

-- module handling
function CrazyArrow:OnInitialize()	
	-- create the minimap button
	self:Setup()
end

function CrazyArrow:OnEnable()
    if IsAddOnLoaded("TomTom") then		
        local TomTomRev = 001
		
        local TomTomVersion = GetAddOnMetadata("TomTom", "X-Curse-Packaged-Version")
        if not TomTomVersion then
            TomTomVersion = GetAddOnMetadata("TomTom", "Version")
        end
		
        if TomTomVersion then
            numx = TomTomVersion:find('%d')
            if numx > 0 then
                TomTomRev = tonumber(TomTomVersion:sub(numx, numx + 2))
            end
        end
		
        if TomTomRev < 216 then
			moduleData.tomtomOk = false
			moduleData.errorMsg = L["+++ TomTom outdated +++\nYou have to install TomTom Version 216\nor higher to run Addon\nYours is: "] .. tostring(TomTomRev)
        else
			moduleData.tomtomOk = true
        end 
    else
		moduleData.tomtomOk = false
		moduleData.errorMsg = L["+++ TomTom missing +++\nYou have to install TomTom to run Addon!"]
    end
	
	if not self:IsOk() then
		Addon:Output(self:GetErrorMsg())
	end
end

function CrazyArrow:OnDisable()
	-- empty
end

function CrazyArrow:Setup()
end

function CrazyArrow:IsOk()
	return moduleData.tomtomOk
end

function CrazyArrow:GetErrorMsg()
	return moduleData.errorMsg
end

-- utility functions
function CrazyArrow:Ping()
	if not self:IsEnabled() then
		return
	end
	
	if not self:IsOk() then
		Addon:Output(self:GetErrorMsg())
		return
	end

    if TomTom:CrazyArrowIsHijacked() then 
		self:Release()
	end
	
    local totalElapsed  = 0

    if not TomTom:CrazyArrowIsHijacked() then
        self:PrepareHijack()
		-- hijack
		TomTom:HijackCrazyArrow( function(self, elapsed)
			moduleData.pingActive = true
			
			totalElapsed  = totalElapsed + elapsed
			
			local direction, distance = Addon:GetDirectionToPing()
					
			local arrived = distance and distance <= Addon:GetSetting("ArrivalRange") and Addon:GetSetting("Release")
		
			if not direction or totalElapsed > Addon:GetSetting("Duration") or arrived then
				CrazyArrow:Release()
				Addon:Refresh()
				return
			end
		
			-- measure map if requested
			if Addon.refPoint and distance > 20 then
				Addon:CalculateMapSize()
			end
			
			if distance > Addon:GetSetting("ArrivalRange") then 
				CrazyArrow:SetDirectionColor(direction)
			else
				CrazyArrow:SetColor(0, 1, 0)
			end
			
			CrazyArrow:UpdateTexture(distance > Addon:GetSetting("ArrivalRange"), direction)
		
			local displayName     = L["Ping: "] .. (Addon.pingerName or L["unknown"])
			local displayDistance = NS:PrecisionTxt(distance, Addon:GetSetting("RangePrecision")) .. " " .. L["yards"]
			local displayTime     = NS:PrecisionTxt(totalElapsed, Addon:GetSetting("TimePrecision")) .. L["s"]
		
			TomTom:SetCrazyArrowTitle(displayName, displayDistance, displayTime)		
		end)  
		-- hijack end
    end   
end 

function CrazyArrow:Point()
	if not self:IsEnabled() then
		return
	end
	
	if not self:IsOk() then
		Addon:Output(self:GetErrorMsg())
		return
	end
	
	if moduleData.pingActive then
		return
	end
	
	local destination = Addon:GetSetting("Destination")
	
	if not sticky and destination == "waypoint" then
		if not Addon:ValidCoords(Addon.waypoint) then
			return
		end
	elseif Addon.destinationUnit == nil then
		if not Addon:GetSetting("ShowNoDest") or destination == "none" then
			return
		end
	end
	
    if TomTom:CrazyArrowIsHijacked() then 
		self:Release()
	end
	
    local totalElapsed = 0
	
    if not TomTom:CrazyArrowIsHijacked() then                       
        self:PrepareHijack()
		
		-- hijack
        TomTom:HijackCrazyArrow(function(self, elapsed)
			totalElapsed  = totalElapsed + elapsed
			
			local inHealRange        = true
			local destination        = Addon:GetSetting("Destination")
			local displayDestination = L[destination]
			local sticky             = Addon:GetSticky()
			
			if sticky then
				displayDestination = L["Sticky"]
			end
			
			if not sticky and destination == "waypoint" then
				if not Addon:ValidCoords(Addon.waypoint) then
					CrazyArrow:Release()
					return
				end
			else
				local unit = Addon.destinationUnit
				if unit then
					displayDestination = displayDestination .. ": " .. Addon.destinationName

					inHealRange = Addon:InHealRange(unit)
				else 					
					if not Addon:GetSetting("ShowNoDest") or destination == "none" then
						CrazyArrow:Release()
						return
					end

					displayDestination = displayDestination .. ": " .. L["no target"]
				end
			end

			status.errorCode = nil
			
			local direction, distance = Addon:GetDirectionToDestination(status)
			
			if status.errorCode then
				local line1 = L["no data"]
				local line2 = ""
			
				if status.errorCode == Addon.NO_PATH then
					line1 = L["no path"]
					line2 = L["other zone"]
				elseif status.errorCode == Addon.MISSING_DATA then
					line1 = L["missing map data"]
					line2 = L["Type '/ttp measure' and then move 20 yards"]
				elseif status.errorCode == Addon.INVALID_COORDS then
					line1 = L["no coords"]
				end
			
				TomTomCrazyArrow:SetAlpha(0.5)
				CrazyArrow:ShowInactiveArrow(displayDestination, line1, line2)
				
				return
			end
			
			TomTomCrazyArrow:SetAlpha(1)
			
			local normal = distance > Addon:GetSetting("ArrivalRange")

			if inHealRange then 
				if normal then 
					CrazyArrow:SetDirectionColor(direction)
				else 
					CrazyArrow:SetColor(0, 1, 0)
				end
			else 
				CrazyArrow:SetOutOfRangeColor(direction) 
			end
			
			CrazyArrow:UpdateTexture(normal, direction)

			local speed = GetUnitSpeed("player")
			
			local displayRange   = NS:PrecisionTxt(distance, Addon:GetSetting("RangePrecision")) .. " " .. L["yards"]
			local displayArrival = speed > 0 and NS:PrecisionTxt(distance / speed, Addon:GetSetting("TimePrecision")) .. L["s"] or "***"
		
			TomTom:SetCrazyArrowTitle(displayDestination, displayRange, displayArrival)
		end) 
		-- hijack end
    end        
end

-- arrow functions
function CrazyArrow:PrepareHijack()
    moduleData.lastArrowText = TomTomCrazyArrow.title:GetText()
	
    if string.find(TomTomCrazyArrow.arrow:GetTexture() or "", "UP") then 
		moduleData.arrowWasNormal = false
    else 
		moduleData.arrowWasNormal = true
	end
	
    moduleData.arrowIsNormal = moduleData.arrowWasNormal
end

function CrazyArrow:Release()
    self:UpdateTexture(moduleData.arrowWasNormal)
	
	moduleData.pingActive = false
	
    TomTomCrazyArrow.title:SetText(moduleData.lastArrowText)
    TomTom:ReleaseCrazyArrow()	
end

function CrazyArrow:UpdateTexture(showNorm, angle)
	if showNorm then
		if not moduleData.arrowIsNormal then
			TomTomCrazyArrow.arrow:SetHeight(56)
			TomTomCrazyArrow.arrow:SetWidth(42)
			TomTomCrazyArrow.arrow:SetTexture("Interface\\AddOns\\TomTom\\Images\\Arrow")
			moduleData.arrowIsNormal = true
		end
		
		if not angle then 
			angle = 0 
		end
		
		local cell = floor(angle * CELL_FACTOR) % 108
		local column = cell % 9
		local row = floor(cell / 9)
		
		local left   = column * COL_FACTOR
		local right  = left + COL_FACTOR
		local top    = row * ROW_FACTOR
		local bottom = top + ROW_FACTOR
		
		TomTomCrazyArrow.arrow:SetTexCoord(left, right, top, bottom)		
	else
		if moduleData.arrowIsNormal then
			TomTomCrazyArrow.arrow:SetHeight(70)
			TomTomCrazyArrow.arrow:SetWidth(53)
			TomTomCrazyArrow.arrow:SetTexture("Interface\\AddOns\\TomTom\\Images\\Arrow-UP")
			moduleData.arrowIsNormal = false
		end
		
		moduleData.clrCount = moduleData.clrCount + 1
		if moduleData.clrCount >= 55 then
			moduleData.clrCount = 0
		end
		
		local cell = moduleData.clrCount
		local column = cell % 9
		local row = floor(cell / 9)
		
		local left   = column * COL_FACTOR_UP
		local right  = left + COL_FACTOR_UP
		local top    = row * ROW_FACTOR_UP
		local bottom = top + ROW_FACTOR_UP
		
		TomTomCrazyArrow.arrow:SetTexCoord(left, right, top, bottom)
	end
end

function CrazyArrow:ShowInactiveArrow(line1, line2, line3)
    self:SetColor(0.5, 0.5, 0.5)
    self:UpdateTexture(false)
    TomTom:SetCrazyArrowTitle(line1, line2, line3)
end

function CrazyArrow:SetColor(r, g, b)
    TomTom:SetCrazyArrowColor(r, g, b)
end

function CrazyArrow:SetDirectionColor(direction)
	local perc = abs(PI - abs(direction)) * ONE_DIV_PI
    local g = 1
    local r = 0
	
    if perc > 0.5 then
      g = 1
      r = perc * -2 + 2
    else
      r = 1
      g = perc * 2
    end
	
    self:SetColor(r, g, 0)
end

function CrazyArrow:SetOutOfRangeColor(direction)
	local perc = abs(PI - abs(direction)) * ONE_DIV_PI
    local r = perc * -2 + 2
	
    self:SetColor(r, 0, 1)
end

function CrazyArrow:SetAlertColor()
    if moduleData.alertPulseOn then
        if moduleData.alertHue <= 1 then 
			moduleData.alertHue = alertHue + 0.1
        else 
			moduleData.alertPulseOn = false
		end
    else
        if moduleData.alertHue >= 0 then 
			moduleData.alertHue = alertHue - 0.1
        else 
			moduleData.alertPulseOn = true
		end
    end
	
    self:SetColor(1, alertHue, 0)
end

-- test
function CrazyArrow:Debug(msg)
	Addon:Debug("(CrazyArrow) " .. msg)
end
