--[[
local Emphasize = Grid:GetModule("GridStatus"):GetModule("GridStatusEmphasize")
local GridStatusEmphasize_BigWigs = Emphasize:NewModule("GridStatusEmphasize_BigWigs", "AceEvent-3.0")

GridStatusEmphasize_BigWigs.defaultDB = {
	flashnshake = true,
	super_emphasize = true,
}

local options = {
	["flashnshake"] = {
		type = "toggle",
		name = "Flash Grid on Flash and Shake",
		desc = "Flash Grid on Flash and Shake",
		get = function () return GridStatusEmphasize_BigWigs.db.profile.flashnshake end,
		set = function (_, v) GridStatusEmphasize_BigWigs.db.profile.flashnshake = v end,
	},
	["superemphasize"] = {
		type = "toggle",
		name = "Flash Grid on Super Emphasize",
		desc = "Flash Grid on Super Emphasize",
		get = function () return GridStatusEmphasize_BigWigs.db.profile.super_emphasize end,
		set = function (_, v) GridStatusEmphasize_BigWigs.db.profile.super_emphasize = v end,
	},
}

local settings

function GridStatusEmphasize_BigWigs:OnInitialize()
	self.super.OnInitialize(self)

   self:RegisterOptions("Big Wigs", options)
   settings = self.db.profile

   self:RegisterEvent("ADDON_LOADED")
end

function GridStatusEmphasize_BigWigs:ADDON_LOADED(_, modname)
	if modname == "BigWigs_Core" then
		self:InitializeBigWigs()
	end
end

function GridStatusEmphasize_BigWigs:InitializeBigWigs()
	local bwplugin = BigWigs:NewPlugin("GridStatusEmphasize_BigWigs_plugin")	

	function bwplugin:OnPluginEnable()
		self:RegisterMessage("BigWigs_FlashShake")
		self:RegisterMessage("BigWigs_SuperEmphasizeStart")
	end

	function bwplugin:BigWigs_FlashShake()
		if settings.flashnshake then
			Emphasize:Flash()
		end
	end

	function bwplugin:BigWigs_SuperEmphasizeStart()
		if settings.super_emphasize then
			Emphasize:Flash()
		end
	end
end
]]