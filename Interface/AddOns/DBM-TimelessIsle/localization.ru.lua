if GetLocale() ~= "ruRU" then return end
local L

L = DBM:GetModLocalization("IsleTimeless")

L:SetGeneralLocalization({
	name = "Мир: Вневременной остров"
})

L:SetWarningLocalization({
	specWarnShip	= "Корабль призван!"
})

L:SetOptionLocalization({
	specWarnShip	= "Спец-предупреждение когда призывается Корабль",
	StrictFilter	= "Фильтровать касты от всех мобов кроме текущей цели/фокуса"
})

L:SetMiscLocalization({
	shipSummon		= "Hahahahaha!"
})