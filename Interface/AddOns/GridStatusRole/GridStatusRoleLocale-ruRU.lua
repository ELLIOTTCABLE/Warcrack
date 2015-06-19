if GetLocale() ~= "ruRU" then return end
local _, ns = ...
ns.L = {
	["Specialization Role"] = "Роль",

	["Healer"] = "Лекарь",
	["Melee"] = "Ближний бой",
	["Ranged"] = "Дальний бой",
	["Tank"] = "Танк",

	["Healer color"] = "Цвет лекаря",
	["Color for Healers."] = "Цвет для лекаря.",

	["Melee color"] = "Цвет ближнего боя",
	["Color for Melee."] = "Цвет для бойца ближнего боя.",

	["Ranged color"] = "Цвет дальнего боя",
	["Color for Ranged."] = "Цвет для бойца дальнего боя.",

	["Tank color"] = "Цвет танка",
	["Color for Tanks."] = "Цвет для танка.",

	["Role filter"] = "Фильтр роли",
	["Show status for the selected roles."] = "Отображать статус для выбранных ролей.",

	["Show on Healers."] = "Отображать лекарей.",
	["Show on Melee."] = "Отображать бойцов ближнего боя.",
	["Show on Ranged."] = "Отображать бойцов дальноего боя.",
	["Show on Tanks."] = "Отображать танков.",

	["Hide in combat"] = "Скрывать в бою",
	["Hide roles while in combat."] = "Скрывать роли во время боя.",
}
