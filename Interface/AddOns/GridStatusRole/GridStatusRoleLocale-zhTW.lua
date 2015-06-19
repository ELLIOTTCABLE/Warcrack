if GetLocale() ~= "zhTW" then return end
local _, ns = ...
ns.L = {
	["Specialization Role"] = "職責",

	["Healer"] = "治療",
	["Melee"] = "近戰",
	["Ranged"] = "遠程",
	["Tank"] = "坦克",

	["Role colors"] = "職責顏色",

	["Healer color"] = "治療顏色",
	["Color for Healers."] = "治療職業的顏色。",

	["Melee color"] = "近戰顏色",
	["Color for Melee."] = "近戰職業的顏色。",

	["Ranged color"] = "遠程顏色",
	["Color for Ranged."] = "遠程職業的顏色。",

	["Tank color"] = "坦克顏色",
	["Color for Tanks."] = "坦克職業的顏色。",

	["Role filter"] = "職責過濾",

	["Show on Healers."] = "顯示治療",
	["Show on Melee."] = "顯示近戰",
	["Show on Ranged."] = "顯示遠程",
	["Show on Tanks."] = "顯示坦克",

	["Hide in combat"] = "戰鬥中隱藏",
	["Hide roles while in combat."] = "戰鬥中隱藏的職責。",

	["Assigned roles"] = "已分配職責",

	["Use assigned roles"] = "使用已分配職責",
	["Use assigned roles while talent info is unknown."] = "天賦訊息已知時使用已分配職責。",

	["Assigned opacity"] = "已分配不透明度",
	["Opacity for assigned roles."] = "已分配職責的不透明度。",
}
