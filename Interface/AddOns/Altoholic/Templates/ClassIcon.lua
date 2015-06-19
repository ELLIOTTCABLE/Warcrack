local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"

local function _SetClassIcon(frame, class, faction)
	local icon = frame.Icon
	local border = frame.IconBorder
	
	if class and faction then
		local tc = CLASS_ICON_TCOORDS[class]
	
		icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])

		if faction == "Alliance" then
			border:SetVertexColor(0.1, 0.25, 1, 0.5)
		else
			border:SetVertexColor(1, 0, 0, 0.5)
		end
	else	-- no key ? display a question mark icon
		icon:SetTexture(ICON_PARTIAL)
		icon:SetTexCoord(0, 1, 0, 1)
		
		border:SetVertexColor(0, 1, 0, 0.5)
	end
	
	icon:SetWidth(33)
	icon:SetHeight(33)
	icon:SetAllPoints(frame)
	
	border:Show()
	frame:SetWidth(34)
	frame:SetHeight(34)
	frame:Show()
end

local function _DrawTooltip(frame, character)
	local name = DataStore:GetColoredCharacterName(character)
	if not name then return end

	local tt = AltoTooltip
	tt:SetOwner(frame, "ANCHOR_LEFT")
	tt:ClearLines();
	tt:AddDoubleLine(name, DataStore:GetColoredCharacterFaction(character))

	tt:AddLine(format("%s %s%s |r%s %s", 
		L["Level"], 
		colors.green,
		DataStore:GetCharacterLevel(character), 
		DataStore:GetCharacterRace(character),
		DataStore:GetCharacterClass(character)
	),1,1,1)

	local zone, subZone = DataStore:GetLocation(character)
	tt:AddLine(format("%s: %s%s |r(%s%s|r)", L["Zone"], colors.gold, zone, colors.gold, subZone),1,1,1)
	
	local restXP = DataStore:GetRestXP(character)
	if restXP and restXP > 0 then
		tt:AddLine(format("%s: %s%s", L["Rest XP"], colors.green, restXP),1,1,1)
	end
	
	tt:AddLine(format("Average iLevel: %s%.1f", colors.green, DataStore:GetAverageItemLevel(character)),1,1,1)

	if IsAddOnLoaded("DataStore_Achievements") then
		local numAchievements = DataStore:GetNumCompletedAchievements(character) or 0
		if numAchievements > 0 then
			tt:AddLine(format("%s: %s%s/%s", 
				ACHIEVEMENTS_COMPLETED, 
				colors.green, 
				DataStore:GetNumCompletedAchievements(character), 
				DataStore:GetNumAchievements(character)
			))
			tt:AddLine(format("%s: %s%s", ACHIEVEMENT_TITLE, colors.green, DataStore:GetNumAchievementPoints(character)))
		end
	end
	
	tt:Show()
end

addon:RegisterClassExtensions("AltoClassIcon", {
	SetClass = _SetClassIcon,
	DrawTooltip = _DrawTooltip,
})
