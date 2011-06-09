--[[
##	Name: HideBlizzard
##	Author: Gendr
##	Description: Hides blizzard frames
##	License: All Rights Reserved
##
##	LATEST CHANGES(03/28/2011):
##	* Added 'Boss Frame' option to SpecialFrames module
##	* Fixed 'MultiCastBar' option
##	* Fixed 'Armored Man' option
##	* Fixed 'Hotkey' option
##	* Cleaned up SpecialFrames module options, merged options
##	* Many code cleanups
]]

HideBlizzard = LibStub("AceAddon-3.0"):NewAddon("HideBlizzard", "AceConsole-3.0", "AceEvent-3.0")
HideBlizzard:SetEnabledState(true)
HideBlizzard:SetDefaultModuleState(false)
HideBlizzard:SetDefaultModuleLibraries("AceEvent-3.0")

local MAJOR, MINOR = "HideBlizzard", 65
local RootVer = GetAddOnMetadata("HideBlizzard", "Version").."."..tonumber(MINOR)
local RootName = "|cff33ff99"..tostring(MAJOR).."|r "

local db
local defaults = {
	profile = {
		modules = {
			["ActionBar"] = false,
			["Buttons"] = false,
			["Pet"] = false,
			["Player"] = false,
			["SpecialFrames"] = false,
			["Target"] = false,
		},
	},
}

function HideBlizzard:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("HideBlizzardDB", defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "UpdateView")
	self.db.RegisterCallback(self, "OnProfileCopied", "UpdateView")
	self.db.RegisterCallback(self, "OnProfileReset", "UpdateView")
	db = self.db.profile

	local lastUpdate = 0
	local waitFrame = CreateFrame("Frame")
	waitFrame:SetScript("OnUpdate", function(self, elapsed)
		lastUpdate = lastUpdate + elapsed
		if(lastUpdate > 3) then
			if not db.Version then
				db.Version = RootVer
				print(RootName.."Welcome! Type /hb for options")
			elseif db.Version ~= RootVer then
					if db.Version:match("1.0.64") then
						print(RootName.."|cffFF3333Version 1.0.64 detected. SpecialFrames module has been reset!|r")
						 if HideBlizzard:GetModuleEnabled("SpecialFrames") then HideBlizzard:DisableModule("SpecialFrames"); HideBlizzard.db.profile.modules.SpecialFrames = nil
					end
				end
				db.Version = RootVer
				print(string.format(RootName.."Updated to version |cff00ff66%s|r Type /hb for options", db.Version))
			end
			lastUpdate = 0
			waitFrame:SetScript("OnUpdate", nil)
		end
	end)
	collectgarbage()
end

function HideBlizzard:OnEnable()
	self:RegisterOptions()
	collectgarbage()
end

function HideBlizzard:OnDisable()
	for k,v in self:IterateModules() do
		if self:GetModuleEnabled(k) then
			self:DisableModule(k)
		end
	end
	HideBlizzard:SetEnabledState(false)
end
-- @Mapster func
function HideBlizzard:GetModuleEnabled(module)
	return self.db.profile.modules[module]
end
-- @Mapster func
function HideBlizzard:SetModuleEnabled(module, value)
	local old = HideBlizzard.db.profile.modules[module]
	HideBlizzard.db.profile.modules[module] = value
	if old ~= value then
		if value then
			HideBlizzard:EnableModule(module)
		else
			HideBlizzard:DisableModule(module)
		end
	end
end
-- @Mapster func
function HideBlizzard:UpdateView()
	for k,v in self:IterateModules() do
		if self:GetModuleEnabled(k) and not v:IsEnabled() then
			self:EnableModule(k)
		elseif not self:GetModuleEnabled(k) and v:IsEnabled() then
			self:DisableModule(k)
		end
		if(type(v.UpdateView) == "function") then
			v:UpdateView()
		end
	end
end
