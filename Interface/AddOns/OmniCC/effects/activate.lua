--[[
	activate.lua
		mimics the default effect that shows up when an ability "procs"
--]]

local Classy = LibStub('Classy-1.0')
local L = OMNICC_LOCALS

local hooked = {}
local active = {}

OmniCC:RegisterEffect({
  id = 'activate',
  name = L.Activate,
  desc = L.ActivateTip,
  Run = function(self, cooldown)
    local button = cooldown:GetParent()
    if button then
      ActionButton_ShowOverlayGlow(button)
      active[button] = true

      local overlay = button.overlay
      if not hooked[overlay] then
        overlay.animIn:HookScript('OnFinished', function()
          if active[button] then
            ActionButton_HideOverlayGlow(button)
            active[button] = nil
          end
        end)
        
        hooked[overlay] = true
      end
		end
  end
})