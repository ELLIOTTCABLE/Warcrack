--[[
**********************************************************************
LibMagicUtil-1.0 is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

LibMagicUtil is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with LibMagicUtil.  If not, see <http://www.gnu.org/licenses/>.
**********************************************************************

To use this addon, embed it in your addon using the normal Ace-method
or manually like this:

  LibStub("LibMagicUtil-1.0"):Embed(MyAddon)

After embedding you will be able to use the following methods:

]]

local MAJOR = "LibMagicUtil-1.0"
local MINOR = tonumber("18") or tonumber(("$Revision: 11 $"):match("(%d+)"))

local lib = LibStub:NewLibrary(MAJOR, MINOR)
local media = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("LibMagicUtil-1.0", false)

if not lib then return end

local embeddables = {
   "GetConfigTemplate", "_GetColorOpt", "_SetColorOpt", "_SetOption", "_GetOption",
   "_HideOption", "_DisableTiling", "FixBackdrop", "_SetBackgroundOption" 
}

lib.optionTemplates = lib.optionTemplates or {}
lib.embeddedAddons = lib.embeddedAddons or {}

local optionTemplates = lib.optionTemplates
local embeddedAddons = lib.embeddedAddons

function lib:GetConfigTemplate(config, get, set)
   assert(self ~= lib, "GetConfigTemplate can only be called when embedded.")
   assert(optionTemplates[config] ~= nil, "Unknown config template: "..config)

   local template = {}
   for key, val in pairs(optionTemplates[config]) do
      if key == "args" then
	 local a = {}
	 for akey, aval in pairs(val) do
	    a[akey] = aval
	 end
	 template.args = a
      else
	 template[key] = val
      end
   end
   template.handler = self
   if get then template.get = get end
   if set then template.set = set end
   return template
end

function lib:Embed(addon)
   for _,key in ipairs(embeddables) do
      addon[key] = lib[key]
   end
   embeddedAddons[addon] = true
end

local function GetConfigHash(mod)
   local db = mod.db
   if db then
      if db.profile then
	 return db.profile
      else
	 return db
      end
   elseif mod.GetConfigTable then
      return mod:GetConfigTable()
   end
   assert(db ~= nil, "Couldn't find config hash.")
end

function lib:_SetColorOpt(arg, r, g, b, a)
   local color = arg[#arg]
   local data = GetConfigHash(self).backdropColors
   assert(data ~= nil, "Didn't find the required config data: self.db.profile.backdropColors")
   data[color][1] = r
   data[color][2] = g
   data[color][3] = b
   data[color][4] = a
   if self.OnOptionChanged then
      self:OnOptionChanged(color, data[color], info)
   end
   self:FixBackdrop()
end

function lib:_GetColorOpt(arg)
   local color = arg[#arg]
   return unpack(GetConfigHash(self).backdropColors[color])
end

-- If the current database has 'nil' for this option, hide it
-- All options need to have a default even if it's false 
function lib:_HideOption(info)
   return GetConfigHash(self)[info[#info]] == nil
end


function lib:_SetOption(info, val)
   local var = info[#info]
   GetConfigHash(self)[info[#info]] = val
   if self.OnOptionChanged then
      self:OnOptionChanged(var, val, info)
   end
end

function lib:_GetOption(info)
   return GetConfigHash(self)[info[#info]]
end

function lib:_DisableTiling(info)
   return not GetConfigHash(self).tile 
end

function lib:FixBackdrop()   
   local bgFrame = self.frame:GetBackdrop()
   local db = GetConfigHash(self)
   if not bgFrame then
      bgFrame = {
	 insets = {left = 1, right = 1, top = 1, bottom = 1}
      }
   end

   local edge = 0
   local inset = 0
   if db.border ~= "None" then
      edge = db.edgeSize
      inset = db.edgeSize / 4
   end
   bgFrame.edgeSize = edge
   bgFrame.insets.left   = inset
   bgFrame.insets.right  = inset
   bgFrame.insets.top    = inset
   bgFrame.insets.bottom = inset

   bgFrame.tile = db.tile
   bgFrame.tileSize = db.tileSize

   bgFrame.edgeFile = media:Fetch("border", db.border)
   bgFrame.bgFile = media:Fetch("background", db.background)

   self.frame:SetBackdrop(bgFrame)
   self.frame:SetBackdropColor(unpack(db.backdropColors.backgroundColor))
   self.frame:SetBackdropBorderColor(unpack(db.backdropColors.borderColor))
end

function lib:_SetBackgroundOption(...)
   self:_SetOption(...)
   self:FixBackdrop()
end

-- Config template for a frame background
optionTemplates.background = {
   type = "group",
   name = L["Background Frame"],
   set = "_SetOption",
   get = "_GetOption",
   args = {
      background = {
	 type = "select",
	 dialogControl = "LSM30_Background",
	 name = L["Background Texture"],
	 desc = L["The background texture used for the background frame."], 
	 order = 20,
	 values = AceGUIWidgetLSMlists.background,
	 set = "_SetBackgroundOption", 
      },
      backgroundColor = {
	 type = "color",
	 name = L["Background Color"],
	 hasAlpha = true,
	 set = "_SetColorOpt",
	 get = "_GetColorOpt",
	 order = 30,
      },
      spacer1 = {
	 type = "description",
	 width = "full",
	 name = "",
	 order = 35,
	 set = "_SetBackgroundOption", 
      },
      border = {
	 type = "select",
	 dialogControl = "LSM30_Border",
	 name = L["Border Texture"],
	 desc = L["The border texture used for the background frame."],
	 order = 40,
	 values = AceGUIWidgetLSMlists.border, 
	 set = "_SetBackgroundOption", 
      },
      borderColor = {
	 type = "color",
	 name = L["Border color"],
	 hasAlpha = true,
	 set = "_SetColorOpt",
	 get = "_GetColorOpt",
	 order = 50,
      },
      spacer2 = {
	 type = "description",
	 width = "full",
	 name = "",
	 order = 55,
      },
      edgeSize = {
	 type = "range",
	 name = L["Edge size"],
	 desc = L["Width of the border."],
	 min = 1, max = 50, step = 0.1,
	 set = "_SetBackgroundOption",
	 order = 60, 
      },
      padding = {
	 type = "range",
	 name = L["Padding"],
	 desc = L["Number of pixels to insert between the background frame edge and the content."],
	 min = 0, max = 50, step = 0.1,
	 order = 70, 
      },
      tile = {
	 type = "toggle",
	 name = L["Tile Background"],
	 desc = L["Whether or not to tile the background texture."],
	 order = 100,
	 set = "_SetBackgroundOption", 
	 order = 90, 
      },
      tileSize = {
	 type = "range",
	 name = L["Tile Size"],
	 desc = L["The size in pixels of the background tiles."],
	 min = 1, max = 200, step = 0.1, 
	 order = 110,
	 disabled = "_DisableTiling",
	 set = "_SetBackgroundOption", 
	 order = 100,
      },
   }
}

optionTemplates.barsize = {
   type = "group",
   name = L["Bar Size"],
   get = "_GetOption",
   set = "_SetOption",
   args = {
      maxbars  = {
	 type = "range",
	 min = 1, max = 100, step = 1,
	 name = L["Maximum number of bars"],
	 width="full",
	 order = 0,
	 hidden = "_HideOption", 
      },
      height = {
	 type = "range",
	 name = L["Bar Height"],
	 width = "full",
	 min = 1, max = 50, step = 1,
      }, 
      width = {
	 type = "range",
	 name = L["Bar Width"],
	 width = "full",
	 min = 1, max = 500, step = 1,
      }, 
      scale = {
	 type = "range",
	 name = L["Bar Scale"],
	 width = "full",
	 min = 0.01, max = 5, step = 0.005,
      }, 
      spacing = {
	 type = "range",
	 name = L["Bar Spacing"],
	 desc = L["The space in pixels between each bar."],
	 width = "full",
	 min = 0, max = 40, step = 0.05,
	 hidden = "_HideOption", 
      }, 
   }
}

-- upgrade
for addon in pairs(embeddedAddons) do
   lib:Embed(addon)
end
