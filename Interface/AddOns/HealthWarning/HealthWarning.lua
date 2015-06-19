-- HealthWarning
-- By Szandos
-- Flashes the edges of the screen when you get low on health
	
-- Create a frame to hold the text and texture
local f = CreateFrame("ScrollingMessageFrame", "HealthWarningFrame", UIParent)
f:SetFrameStrata("BACKGROUND")
f:SetAllPoints() 
f:Hide()
local flashing = false

-- Create a texture for the flash effect
local t = f:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\FullScreenTextures\\LowHealth")
t:SetBlendMode("ADD")
t:SetAllPoints(f)
f.texture = t

-- Animation for the flashing
local HealthWarningFrameAnimationGroup = HealthWarningFrame:CreateAnimationGroup()
local faderOut = HealthWarningFrameAnimationGroup:CreateAnimation("Alpha")
faderOut:SetChange(-1)
faderOut:SetDuration(0.3)
faderOut:SetOrder(1)
local faderIn = HealthWarningFrameAnimationGroup:CreateAnimation("Alpha")
faderIn:SetChange(1)
faderIn:SetDuration(0.3)
faderIn:SetOrder(2)
HealthWarningFrameAnimationGroup:SetScript("OnFinished", function(self) self:Play() end)
HealthWarningFrameAnimationGroup:Play()

-- Frame to catch events
local HealthWarning_eventFrame = CreateFrame("Frame", nil, UIParent)
HealthWarning_eventFrame:RegisterEvent("VARIABLES_LOADED")
HealthWarning_eventFrame:RegisterEvent("UNIT_HEALTH")
HealthWarning_eventFrame:SetScript("OnEvent",function(self,event,...) self[event](self,event,...);end)

-- FontString for message
local fs = f:CreateFontString(nil, "ARTWORK", "SystemFont_Shadow_Huge3")
fs:SetAllPoints()
fs:SetJustifyH("CENTER")
fs:SetJustifyV("MIDDLE")
fs:SetTextColor(0.9,0,0)

-- UNIT_HEALTH: Show warning
function HealthWarning_eventFrame:UNIT_HEALTH(_, arg1)
	if arg1 == "player" then
		if UnitIsDeadOrGhost("player") then
			if flashing then -- Stop flashing the screen if we are dead
				flashing = false
				f:Hide()
			end
		else
			local lowHealth = (UnitHealth("player")/UnitHealthMax("player") < HealthWarningDB["threshold"] / 100) -- Are we below the threshold
			if lowHealth and not flashing then
				flashing = true
				f:Show() -- Start flashing the screen
				if HealthWarningDB["text"] then fs:SetText("Low Health!!!") end
				if HealthWarningDB["sound"] then PlaySoundFile("Sound\\interface\\RaidWarning.ogg") end
			elseif not lowHealth and flashing then
				flashing = false
				f:Hide()
				fs:SetText("")
			end
		end
	end
end

-- VARIABLE_LOADED: Prepare SavedVariables
function HealthWarning_eventFrame:VARIABLES_LOADED()
	if (not HealthWarningDB) then
		HealthWarningDB = {}
		HealthWarningDB["threshold"] = 20
		HealthWarningDB["sound"] = true
		HealthWarningDB["text"] = true
	end
	if (not HealthWarningDB["threshold"]) then -- For backwards compatibility
		HealthWarningDB["threshold"] = HealthWarningDB["treshold"]
	end
end

-- Create slash command
SLASH_HEALTHWARNING1 = "/healthwarning"
SLASH_HEALTHWARNING2 = "/hw"
local color = "|cff00ffff"

-- Handle slash commands
function SlashCmdList.HEALTHWARNING(msg)
	local command, rest = msg:match("^(%S*)%s*(.-)$")
	if command == "threshold" then
		local newThreshold = tonumber(rest)
		if not newThreshold or newThreshold < 0 or newThreshold > 100 then
			DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Usage:")
			DEFAULT_CHAT_FRAME:AddMessage(color.."/hw threshold <number> - Sets the warning threshold in percent")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Example: \"/hw threshold 20\" - Sets the threshold to 20% health")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Current threshold: "..HealthWarningDB["threshold"].."%")
		else
			DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
			DEFAULT_CHAT_FRAME:AddMessage(color.."New threshold set to "..newThreshold.."%")
			HealthWarningDB["threshold"] = newThreshold
		end
	elseif command == "text" then
		if HealthWarningDB["text"] then
			HealthWarningDB["text"] = false
			DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Text warning is now off")
		else 
			HealthWarningDB["text"] = true
			DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Text warning is now on")
		end
	elseif command == "sound" then
		if HealthWarningDB["sound"] then
			HealthWarningDB["sound"] = false
			DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Warning sound is now off")
		else 
			HealthWarningDB["sound"] = true
			DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
			DEFAULT_CHAT_FRAME:AddMessage(color.."Warning sound is now on")
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(color.."HealthWarning by Szandos")
		DEFAULT_CHAT_FRAME:AddMessage(color.."Version: "..GetAddOnMetadata("HealthWarning", "Version"))
		DEFAULT_CHAT_FRAME:AddMessage(color.."Usage:")
		DEFAULT_CHAT_FRAME:AddMessage(color.."/hw threshold <number> - Sets the warning threshold in percent")
		DEFAULT_CHAT_FRAME:AddMessage(color.."/hw text - Toggles text warning on/off")
		DEFAULT_CHAT_FRAME:AddMessage(color.."/hw sound - Toggles sound warning on/off")
	end
end