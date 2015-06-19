if GetLocale() ~= "koKR" then return end
local _, ns = ...
ns.L = {
	["Specialization Role"] = "역할",

	["Healer"] = "힐러",
	["Melee"] = "근접",
	["Ranged"] = "캐스터",
	["Tank"] = "탱커",

	["Healer color"] = "힐러 색상",
	["Color for Healers."] = "힐러 색상입니다.",

	["Melee color"] = "근접 색상",
	["Color for Melee."] = "근접 색상입니다.",

	["Ranged color"] = "캐스터 색상",
	["Color for Ranged."] = "캐스터 색상입니다.",

	["Tank color"] = "탱커 색상",
	["Color for Tanks."] = "탱커 색상입니다.",

	["Role filter"] = "역활 필터",
	["Show status for the selected roles."] = "선택된 역할을 상태 창에 표시합니다.",

	["Show on Healers."] = "힐러 계열을 표시합니다.",
	["Show on Melee."] = "근접 계열을 표시합니다.",
	["Show on Ranged."] = "캐스터 계열을 표시합니다.",
	["Show on Tanks."] = "탱커 계열을 표시합니다.",

	["Hide in combat"] = "전투 중 숨김",
	["Hide roles while in combat."] = "전투 중에는 역할을 숨깁니다.",
}
