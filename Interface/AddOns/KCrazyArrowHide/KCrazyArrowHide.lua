--[[ 
v1.21	10/15/2014	- Updated the TOC for v6
v1.2	10/4/2014	- Updated the TOC for v5.4
					- Added option to restore defaults.
					- Added option to not hide the crazy arrow when mounted. 
v1.1	7/3/2013	- Updated the TOC for v5.3
					- Added "Sleep" option.  When combat ends the crazy arrow will Sleep x seconds before restoring.
v1.02	9/22/2012	- Added check for dependent addon TomTom.
v1.01	9/1/2012	- Updated the TOC for v5.04
v1.0	6/25/2012	- For public consumption.
 ]]

--define local vars and defaults
local DependentsLoaded = false
local LastUpdate = 0
local UpdateInterval = 1
local Alarm = nil

local function SetDefaults() --saved settings
	KCrazyArrowHide_Settings = {
		["Version"] = tonumber(GetAddOnMetadata("KCrazyArrowHide", "Version")),
		["Enabled"] = true,
		["Sleep"] = 4,
		["HideMounted"] = false
	}
end
SetDefaults()

local function print(Msg)
	if Msg == nil then Msg = ""; end
	DEFAULT_CHAT_FRAME:AddMessage("CAH: " .. tostring(Msg))
end

function KCrazyArrowHideFrame_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" and select(1,...) == "KCrazyArrowHide" then
		--vars loaded from saved settings
		--check ver of settings and upgrade if needed
		if KCrazyArrowHide_Settings.Version == nil then KCrazyArrowHide_Settings.Version = 0; end	--in case the setting did not exist
		if KCrazyArrowHide_Settings.Version < tonumber(GetAddOnMetadata("KCrazyArrowHide", "Version")) then
			--upgrade older version settings
			local OldVerOptions = KCrazyArrowHide_Settings	 --save loaded settings
			SetDefaults()	 --load default settings again
			for k,v in pairs(OldVerOptions) do
				if OldVerOptions[k] ~= nil then
					KCrazyArrowHide_Settings[k] = OldVerOptions[k]
				end
			end
			KCrazyArrowHide_Settings.Version = tonumber(GetAddOnMetadata("KCrazyArrowHide", "Version"))	--reset correct version number
		end
	end
	if event == "ADDON_LOADED" and select(1,...) == "TomTom" then
		DependentsLoaded = true
	end
	if DependentsLoaded and KCrazyArrowHide_Settings.Enabled then
		if event == "PLAYER_REGEN_ENABLED" then
			if IsMounted() then
				Alarm = GetTime()
			else
				Alarm = GetTime() + KCrazyArrowHide_Settings.Sleep
			end
		elseif event == "PLAYER_REGEN_DISABLED" then
			if IsMounted() and KCrazyArrowHide_Settings.HideMounted then
				Alarm = nil
				TomTomCrazyArrow:Hide()
			end
		end
	end
end

function KCrazyArrowHideFrame_OnUpdate(self, elapsed, ...)
	if Alarm and DependentsLoaded and KCrazyArrowHide_Settings.Enabled then
		if Alarm then
			if GetTime() > Alarm then
				TomTomCrazyArrow:Show()
				Alarm = nil
			end
		end
	end
end

function KCrazyArrowHide_Command(Msg, Editbox)
	if Msg then Msg=strlower(Msg); end
	if Msg == "" or Msg == "help" or Msg == "?" then
		print("Use /KCAH | /CAH [on/off/mnton/mntoff/show/hide/#/defaults/help].")
		if Msg == "" then
			if KCrazyArrowHide_Settings.Enabled then
				print("Crazy Arrow Hide is currently enabled.")
			else
				print("Crazy Arrow Hide is currently disabled.")
			end
			print("Sleep value is "..KCrazyArrowHide_Settings.Sleep..".")
			if KCrazyArrowHide_Settings.HideMounted == true then
				print("Hide when mounted is currently enabled.")
			else
				print("Hide when mounted is currently disabled.")
			end
		elseif Msg == "help" or Msg == "?" then
			print("v"..KCrazyArrowHide_Settings.Version)
			print("On/off to enable or disable automatic hiding.")
			print("Show/hide to manually show or hide the Crazy Arrow.")
			print("Mnton/mntoff to enable or disable arrow hiding when mounted.")
			print("# (a number in seconds) to set the delay out of combat to show the Crazy Arrow.")
			print("Default to reset settings.")
			print("Example: /kcah on")
		end
	elseif tonumber(Msg) ~= nil then
		KCrazyArrowHide_Settings.Sleep = tonumber(Msg)
		print("Sleep set to "..tostring(KCrazyArrowHide_Settings.Sleep))
	elseif Msg == "on" or Msg == "enable" then
		KCrazyArrowHide_Settings.Enabled = true
		print("Crazy Arrow Hide is now on.")
	elseif Msg == "off" or Msg == "disable" then
		if DependentsLoaded and not TomTomCrazyArrow:IsVisible() then TomTomCrazyArrow:Show(); end
		KCrazyArrowHide_Settings.Enabled = false
		print("Crazy Arrow Hide is now off.")
	elseif Msg == "show" and DependentsLoaded then
		TomTomCrazyArrow:Show()
		print("Show the Crazy Arrow.")
	elseif Msg == "hide" and DependentsLoaded then
		TomTomCrazyArrow:Hide()
		print("Hide the Crazy Arrow.")
	elseif Msg == "mnton" then
		KCrazyArrowHide_Settings.HideMounted = true
		print("Hide when mounted enabled.")
	elseif Msg == "mntoff" then
		KCrazyArrowHide_Settings.HideMounted = false
		print("Hide when mounted disabled.")
	elseif Msg == "default" or Msg == "defaults" or Msg == "reset" then
		SetDefaults()
		print("Defaults restored.")
	end
	if DependentsLoaded == false then
		print("NOTICE: Required addon TomTom is not loaded.")
	end
end

--Create an anonymous blank frame
local KCrazyArrowHideFrame = CreateFrame("Frame")
KCrazyArrowHideFrame:RegisterEvent("ADDON_LOADED")
KCrazyArrowHideFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
KCrazyArrowHideFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
KCrazyArrowHideFrame:SetScript("OnEvent", KCrazyArrowHideFrame_OnEvent)
KCrazyArrowHideFrame:SetScript("OnUpdate", KCrazyArrowHideFrame_OnUpdate)

--setup slash command feature
SlashCmdList["KCrazyArrowHide"]=KCrazyArrowHide_Command
SLASH_KCrazyArrowHide1, SLASH_KCrazyArrowHide2="/KCAH","/CAH"
print("Crazy Arrow Hide v"..tostring(KCrazyArrowHide_Settings.Version))