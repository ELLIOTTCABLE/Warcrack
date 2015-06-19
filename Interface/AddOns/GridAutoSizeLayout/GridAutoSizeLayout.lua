local _, addonTable = ...
local L = addonTable.L

local select = select

local IsInRaid = IsInRaid
local GetNumGroupMembers = GetNumGroupMembers
local GetRaidRosterInfo = GetRaidRosterInfo

GridAutoSizeLayout = Grid:NewModule("GridAutoSizeLayout", "AceBucket-3.0")
local GridAutoSizeLayout = GridAutoSizeLayout
local GridLayout = Grid:GetModule("GridLayout")

local function getDynamicLayouts()
  local layout = {}
  local petlayout = {}
  local raidSize = GetNumGroupMembers()
  local currentGroups = {}
  for i = 1, NUM_RAID_GROUPS, 1 do
    currentGroups[i] = false;
  end
  if IsInRaid() then
    for i = 1, raidSize do
      local group = select(3, GetRaidRosterInfo(i))
      currentGroups[group] = true
    end
    local group = 1
    for i = 1, NUM_RAID_GROUPS, 1 do
      if (currentGroups[i]) then
        layout[group] = {
          groupFilter = ""..i,
        }
        petlayout[group] = {
          groupFilter = ""..i,
        }
        group = group + 1
      end
    end
    local groupString = ""
    local first = true
    for i = 1, NUM_RAID_GROUPS, 1 do
      if (currentGroups[i]) then
        if (first) then
          groupString = groupString..i
          first = false
        else
          groupString = groupString..','..i
        end
      end
    end
    petlayout[group]  = {
      groupFilter = groupString,
      isPetGroup = true,
      unitsPerColumn = 5,
      maxColumns = group - 1,
    }
  else
    layout[1] = {
      showParty = true,
      showRaid = false,
      sortMethod = "INDEX",
    }
    petlayout[1] = {
      showParty = true,
      showRaid = false,
      sortMethod = "INDEX",
    }
    petlayout[2] = {
      showParty = true,
      showRaid = false,
      sortMethod = "INDEX",

      isPetGroup = true,
      unitsPerColumn = 5,
      maxColumns = 5,
    }
  end

  return layout, petlayout
end

function GridAutoSizeLayout:OnInitialize()
	self.super.OnInitialize(self)
end

function GridAutoSizeLayout:OnEnable()
  self.super.OnEnable(self)
  
  -- self:RegisterMessage("Grid_RosterUpdated", "UpdateLayout")
  self:RegisterBucketEvent("GROUP_ROSTER_UPDATE", 0.1, "UpdateLayout")
  self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateLayout")
end

function GridAutoSizeLayout:OnDisable()
  self:UnregisterAllEvents()
end

function GridAutoSizeLayout:UpdateLayout()
  local currentLayout = GridLayout.db.profile.layout
  if currentLayout ~= L["LAYOUT_NAME"] and currentLayout ~= L["LAYOUT_NAME_PETS"] then
    return
  end
  -- Generate both in case someone wants to swap between the two for some reason
  local layout, petlayout = getDynamicLayouts()
  GridLayout:AddLayout(L["LAYOUT_NAME"], layout)
  GridLayout:AddLayout(L["LAYOUT_NAME_PETS"], petlayout)
  GridLayout:ReloadLayout()
end

-- Empty layouts since grid sends Grid_RosterUpdated on UI load. If current
-- layout is set to something else and then you reload UI and then set layout
-- to Auto, will not update until another Grid_RosterUpdated is sent. This is
-- a limitation of grid as there is no way to be notified that a layout has 
-- been switched to.

GridLayout:AddLayout(L["LAYOUT_NAME"], {})
GridLayout:AddLayout(L["LAYOUT_NAME_PETS"], {})