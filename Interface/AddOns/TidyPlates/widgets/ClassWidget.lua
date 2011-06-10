---------------
-- Class Widget
---------------
local classWidgetPath = "Interface\\Addons\\TidyPlates\\Widgets\\ClassWidget\\"

--[[
local ClassIconTable = {
	DEATHKNIGHT = "Interface\\Icons\\Spell_Deathknight_ClassIcon",
	DRUID = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
	WARLOCK = "Interface\\Icons\\Spell_Nature_FaerieFire",
	HUNTER = "Interface\\Icons\\INV_Weapon_Bow_07",
	MAGE = "Interface\\Icons\\INV_Staff_13",
	PRIEST = "Interface\\Icons\\INV_Staff_30",
	WARRIOR = "Interface\\Icons\\INV_Sword_27",
	SHAMAN = "Interface\\Icons\\Spell_Nature_BloodLust",
	PALADIN = "Interface\\AddOns\\addon\\UI-CharacterCreate-Classes_Paladin",
	ROGUE = "Interface\\AddOns\\addon\\UI-CharacterCreate-Classes_Rogue",
}
--]]


local function UpdateClassWidget(self, unit, showFriendly)
	local class
	if unit then


		if showFriendly and unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
			class = TidyPlatesUtility.GroupMembers.Class[unit.name]
		elseif unit.type == "PLAYER" then class = unit.class end

		if class and class ~= "UNKNOWN" then
			self.Icon:SetTexture(classWidgetPath..class) 
			self:Show()
		else self:Hide() end
	end
	
	--[[ Testing
	self.Icon:SetTexture(classWidgetPath.."WARRIOR") 
	self:Show()
	--]]
end

local function CreateClassWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(24); frame:SetHeight(24)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetPoint("CENTER",frame)
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateClassWidget
	return frame
end

TidyPlatesWidgets.CreateClassWidget = CreateClassWidget