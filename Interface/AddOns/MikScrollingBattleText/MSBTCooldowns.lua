-------------------------------------------------------------------------------
-- Title: Mik's Scrolling Battle Text Cooldowns
-- Author: Mikord
-------------------------------------------------------------------------------

-- Create module and set its name.
local module = {}
local moduleName = "Cooldowns"
MikSBT[moduleName] = module


-------------------------------------------------------------------------------
-- Imports.
-------------------------------------------------------------------------------

-- Local references to various modules for faster access.
local MSBTProfiles = MikSBT.Profiles
local MSBTTriggers = MikSBT.Triggers

-- Local references to various functions for faster access.
local string_gsub = string.gsub
local string_find = string.find
local string_format = string.format
local GetSpellCooldown = GetSpellCooldown
local EraseTable = MikSBT.EraseTable
local GetSkillName = MikSBT.GetSkillName
local DisplayEvent = MikSBT.Animations.DisplayEvent
local HandleCooldowns = MSBTTriggers.HandleCooldowns


-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------

-- The minimum and maximum amount of time to delay between checking cooldowns.
local MIN_COOLDOWN_UPDATE_DELAY = 0.1
local MAX_COOLDOWN_UPDATE_DELAY = 1

-- Spell names.
local SPELLID_COLD_SNAP		= 11958
local SPELLID_MIND_FREEZE	= 47528
local SPELLID_PREPARATION	= 14185
local SPELLID_READINESS		= 23989

-- Death knight rune cooldown.
local RUNE_COOLDOWN = 10


-------------------------------------------------------------------------------
-- Private variables.
-------------------------------------------------------------------------------

-- Dynamically created frame for receiving events.
local eventFrame = CreateFrame("Frame")

-- Player's class.
local playerClass

-- Cooldown information.
local activeCooldowns = {player={}, pet={}}
local delayedCooldowns = {player={}, pet={}}
local resetAbilities = {}
local runeCooldownAbilities = {}
local cooldownSpellID = {}

-- Used for timing between updates.
local updateDelay = MIN_COOLDOWN_UPDATE_DELAY
local lastUpdate = 0


-------------------------------------------------------------------------------
-- Event handlers.
-------------------------------------------------------------------------------

-- ****************************************************************************
-- Called when the player successfully casts a spell.
-- ****************************************************************************
local function OnSpellCast(unitID, spellID)
 -- Ignore the cast if the spell name is excluded.
 local spellName = GetSpellInfo(spellID) or UNKNOWN
 if (MSBTProfiles.currentProfile.cooldownExclusions[spellName]) then return end

 -- An ability that resets cooldowns was cast.
 if (resetAbilities[spellID] and unitID == "player") then
  -- Remove active cooldowns that the game is now reporting inactive.
  for spellID, remainingDuration in pairs(activeCooldowns[unitID]) do
   local startTime, duration = GetSpellCooldown(spellID)
   if (duration <= 1.5 and remainingDuration > 1.5) then activeCooldowns[unitID][spellID] = nil end

   -- Force an update.
   updateDelay = MIN_COOLDOWN_UPDATE_DELAY
  end
 end

 -- Set the cooldown spell id to be checked on the next cooldown update event. 
 cooldownSpellID[unitID] = spellID
end


-- ****************************************************************************
-- Called when a spell cooldown is started.
-- ****************************************************************************
local function OnSpellUpdateCooldown(unitID)
 if (not delayedCooldowns[unitID] or not activeCooldowns[unitID]) then return end

 -- Start delayed cooldowns once they have been used.
 for spellID in pairs(delayedCooldowns[unitID]) do
  -- Check if the spell is enabled yet.
  local _, duration, enabled = GetSpellCooldown(spellID)
  if (enabled == 1) then
   -- Add the spell to the active cooldowns list if the cooldown is longer than the cooldown threshold.
   if (duration >= MSBTProfiles.currentProfile.cooldownThreshold) then
    activeCooldowns[unitID][spellID] = duration

    -- Force an update.
    updateDelay = MIN_COOLDOWN_UPDATE_DELAY

    -- Check if the event frame is not visible and make it visible so the OnUpdate events start firing.
    -- This is done to keep the number of OnUpdate events down to a minimum for better performance.
    if (not eventFrame:IsVisible()) then eventFrame:Show() end
   end

   -- Remove the spell from the delayed cooldowns list.
   delayedCooldowns[unitID][spellID] = nil
  end
 end

 -- Add the last successful spell to the active cooldowns if necessary.
 local cooldownID = cooldownSpellID[unitID]
 if (cooldownID) then
  -- Make sure the spell cooldown is enabled.
  local _, duration, enabled = GetSpellCooldown(cooldownID)
  if (enabled == 1) then
   -- XXX This is a hack to compensate for Blizzard's API reporting incorrect cooldown information for death knights.
   -- XXX Ignore cooldowns that are the same duration as a rune cooldown except for the abilities that truly have the same cooldown.
   if (playerClass == "DEATHKNIGHT" and duration == RUNE_COOLDOWN and unitID == "player" and not runeCooldownAbilities[cooldownID]) then duration = -1 end

   -- Add the spell to the active cooldowns list if the cooldown is longer than the cooldown threshold.
   if (duration >= MSBTProfiles.currentProfile.cooldownThreshold) then
    activeCooldowns[unitID][cooldownID] = duration

    -- Force an update.
    updateDelay = MIN_COOLDOWN_UPDATE_DELAY
  
    -- Check if the event frame is not visible and make it visible so the OnUpdate events start firing.
    -- This is done to keep the number of OnUpdate events down to a minimum for better performance.
    if (not eventFrame:IsVisible()) then eventFrame:Show() end
   end

  -- Spell cooldown is NOT enabled so add it to the delayed cooldowns list.
  else
   delayedCooldowns[unitID][cooldownID] = true
  end

  cooldownSpellID[unitID] = nil
 end -- cooldownID?
end


-- ****************************************************************************
-- Called when the OnUpdate event occurs.
-- ****************************************************************************
local function OnUpdate(frame, elapsed)
 -- Increment the amount of time passed since the last update.
 lastUpdate = lastUpdate + elapsed

 -- Check if it's time for an update.
 if (lastUpdate >= updateDelay) then
  -- Reset the update delay to the max value.
  updateDelay = MAX_COOLDOWN_UPDATE_DELAY

  -- Loop through all of the active cooldowns.
  local currentTime = GetTime()
  for unitID, cooldowns in pairs(activeCooldowns) do
   for spellID, remainingDuration in pairs(cooldowns) do
    -- Ensure the cooldown is still valid.
    local startTime, duration, enabled = GetSpellCooldown(spellID)
    if (startTime ~= nil) then
     -- Calculate the remaining cooldown.
     local cooldownRemaining = startTime + duration - currentTime

     -- XXX This is to compensate for Blizzard's API reporting incorrect cooldown information for pets that have been dismissed.
     -- XXX Use an internal timer for pet skills.
     -- XXX This will have to be updated if any skills are added that dynamically adjust pet cooldowns.
     if (unitID == "pet") then cooldownRemaining = remainingDuration - lastUpdate end

     -- Cooldown completed.
     if (cooldownRemaining <= 0) then
      local spellName = GetSpellInfo(spellID) or UNKNOWN
      local texture = GetSpellTexture(spellID)
      HandleCooldowns(unitID, spellID, spellName, texture)

      local eventSettings = MSBTProfiles.currentProfile.events.NOTIFICATION_COOLDOWN
      if (unitID == "pet") then eventSettings = MSBTProfiles.currentProfile.events.NOTIFICATION_PET_COOLDOWN end
      if (eventSettings and not eventSettings.disabled) then
       local message = eventSettings.message
       local formattedSkillName = string_format("|cFF%02x%02x%02x%s|r", eventSettings.skillColorR * 255, eventSettings.skillColorG * 255, eventSettings.skillColorB * 255, string_gsub(spellName, "%(.+%)%(%)$", ""))
       message = string_gsub(message, "%%e", formattedSkillName)
       DisplayEvent(eventSettings, message, texture)
      end

      -- Remove the cooldown from  active cooldowns.
      cooldowns[spellID] = nil

     -- Cooldown NOT completed.
     else
      cooldowns[spellID] = cooldownRemaining
      if (cooldownRemaining < updateDelay) then updateDelay = cooldownRemaining end
     end

    -- Cooldown is no longer valid.
    else
     cooldowns[spellID] = nil
    end
   end -- cooldowns
  end -- units

  -- Ensure the update delay isn't less than the min value.
  if (updateDelay < MIN_COOLDOWN_UPDATE_DELAY) then updateDelay = MIN_COOLDOWN_UPDATE_DELAY end

  -- Hide the event frame if there are no active cooldowns so the OnUpdate events stop firing.
  -- This is done to keep the number of OnUpdate events down to a minimum for better performance.
  local allInactive = true
  for unitID, cooldowns in pairs(activeCooldowns) do
   if (next(cooldowns)) then allInactive = false end
  end
  if (allInactive) then eventFrame:Hide() end

  -- Reset the time since last update.
  lastUpdate = 0
 end
end


-- ****************************************************************************
-- Successful spell casts.
-- ****************************************************************************
function eventFrame:UNIT_SPELLCAST_SUCCEEDED(unitID, spellName, spellRank, lineID, skillID)
  if (unitID == "player") then OnSpellCast("player", skillID) end
end


-- ****************************************************************************
-- Combat log event for detecting pet casts.
-- ****************************************************************************
function eventFrame:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, recipientGUID, recipientName, recipientFlags, recipientRaidFlags, skillID)
  if (event ~= "SPELL_CAST_SUCCESS") then return end
  if (sourceGUID == UnitGUID("pet")) then OnSpellCast("pet", skillID) end
end


-- ****************************************************************************
-- Called when spells cooldowns begin.
-- ****************************************************************************
function eventFrame:SPELL_UPDATE_COOLDOWN()
  OnSpellUpdateCooldown("player")
end


-- ****************************************************************************
-- Called when pet cooldowns begin.
-- ****************************************************************************
function eventFrame:PET_BAR_UPDATE_COOLDOWN()
  OnSpellUpdateCooldown("pet")
end


-- ****************************************************************************
-- Updates the registered events depending on active options.
-- ****************************************************************************
local function UpdateRegisteredEvents()
 -- Toggle the registered events for player cooldowns depending on enabled notifications and triggers.
 local doEnable = false
 if (not MSBTProfiles.currentProfile.events.NOTIFICATION_COOLDOWN.disabled or MSBTTriggers.categorizedTriggers["SKILL_COOLDOWN"]) then doEnable = true end
 local registerFunc = doEnable and "RegisterEvent" or "UnregisterEvent"
 eventFrame[registerFunc](eventFrame, "UNIT_SPELLCAST_SUCCEEDED")
 eventFrame[registerFunc](eventFrame, "SPELL_UPDATE_COOLDOWN")

 -- Toggle the registered events for pet cooldowns depending on enabled notifications and triggers.
 local doEnable = false
 if (not MSBTProfiles.currentProfile.events.NOTIFICATION_PET_COOLDOWN.disabled or MSBTTriggers.categorizedTriggers["PET_COOLDOWN"]) then doEnable = true end
 local registerFunc = doEnable and "RegisterEvent" or "UnregisterEvent"
 eventFrame[registerFunc](eventFrame, "COMBAT_LOG_EVENT_UNFILTERED")
 eventFrame[registerFunc](eventFrame, "PET_BAR_UPDATE_COOLDOWN")
end


-- ****************************************************************************
-- Enables the module.
-- ****************************************************************************
local function Enable()
 UpdateRegisteredEvents()
end


-- ****************************************************************************
-- Disables the module.
-- ****************************************************************************
local function Disable()
 -- Stop receiving updates.
 eventFrame:Hide()
 eventFrame:UnregisterAllEvents()

 -- Clear the active and delayed cooldowns.
 for unitID, cooldowns in pairs(activeCooldowns) do EraseTable(cooldowns) end
 for unitID, cooldowns in pairs(delayedCooldowns) do EraseTable(cooldowns) end
end


-------------------------------------------------------------------------------
-- Initialization.
-------------------------------------------------------------------------------

-- Setup event frame.
eventFrame:Hide()
eventFrame:SetScript("OnEvent", function (self, event, ...) if (self[event]) then self[event](self, ...) end end)
eventFrame:SetScript("OnUpdate", OnUpdate)

-- Get the player's class.
_, playerClass = UnitClass("player")

-- Specify the abilities that reset cooldowns.
resetAbilities[SPELLID_COLD_SNAP] = true
resetAbilities[SPELLID_PREPARATION] = true
resetAbilities[SPELLID_READINESS] = true
 
-- Set the death knight abilities that are the same as the rune cooldown.
runeCooldownAbilities[SPELLID_MIND_FREEZE] = true




-------------------------------------------------------------------------------
-- Module interface.
-------------------------------------------------------------------------------

-- Protected Functions.
module.Enable					= Enable
module.Disable					= Disable
module.UpdateRegisteredEvents	= UpdateRegisteredEvents