if GetLocale() ~= "zhCN" then return end
local _, ns = ...
ns.L = {
	["Specialization Role"] = "职责",

	["Healer"] = "治疗",
	["Melee"] = "近战",
	["Ranged"] = "远程",
	["Tank"] = "坦克",

	["Role colors"] = "职责颜色",

	["Healer color"] = "治疗颜色",
	["Color for Healers."] = "治疗职业的颜色。",

	["Melee color"] = "近战颜色",
	["Color for Melee."] = "近战职业的颜色。",

	["Ranged color"] = "远程颜色",
	["Color for Ranged."] = "远程职业的颜色。",

	["Tank color"] = "坦克颜色",
	["Color for Tanks."] = "坦克职业的颜色。",

	["Role filter"] = "职责过滤",

	["Show on Healers."] = "显示治疗",
	["Show on Melee."] = "显示近战",
	["Show on Ranged."] = "显示远程",
	["Show on Tanks."] = "显示坦克",

	["Hide in combat"] = "战斗中隐藏",
	["Hide roles while in combat."] = "战斗中隐藏的职责。",

	["Assigned roles"] = "已分配职责",

	["Use assigned roles"] = "使用已分配职责",
	["Use assigned roles while talent info is unknown."] = "天赋信息已知时使用已分配职责。",

	["Assigned opacity"] = "已分配不透明度",
	["Opacity for assigned roles."] = "已分配职责的不透明度。",
}
