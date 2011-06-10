--[[
GridIndicatorIconBar - icon indicator for Grid
Copyright 2009-2010 Adirelle (adirelle@tagada-team.net)
All rights reserved.
]]

local addonName, ns = ...

local GridL = Grid.L
local L = setmetatable({}, {__index = function(t,k)
	local value = k
	if k then
		value = GridL[tostring(k)] or tostring(k)
		t[k] = value
	end
	return value
end})
ns.L = L

-- %Localization: gridindicatoriconbar
-- THE END OF THE FILE IS UPDATED BY A SCRIPT
-- ANY CHANGE BELOW THESES LINES WILL BE LOST
-- CHANGES SHOULD BE MADE USING http://www.wowace.com/addons/gridindicatoriconbar/localization/

-- @noloc[[

------------------------ enUS ------------------------


-- GridIndicatorIconBar.lua
L["Adjust the number of icons per row."] = true
L["Adjust the number of icons to display."] = true
L["Adjust the offset between the bar and the unit frame along the x-axis."] = true
L["Adjust the offset between the bar and the unit frame along the y-axis."] = true
L["Adjust the opacity of the icon bar. 100% is fully opaque; 10% is almost transparent."] = true
L["Adjust the scale of the icon bar."] = true
L["Adjust the size of the space between the icons."] = true
L["Bar anchoring point"] = true
L["Bottom left"] = true
L["Bottom right"] = true
L["Bottom"] = true
L["Center"] = true
L["Check this box to have the icon flashes when there is less than 3 seconds left."] = true
L["Enable test mode. In test mode, every defined icon are shown."] = true
L["Flashing icons"] = true
L["Icon #%d"] = true
L["Icon Bar"] = true
L["Icon borders"] = true
L["Icon opacity"] = true
L["Icon scale"] = true
L["Icon spacing"] = true
L["Left"] = true
L["Number of icons per row"] = true
L["Number of icons"] = true
L["Options for Icon Bar indicators."] = true
L["Right"] = true
L["Select icons that should display their border."] = true
L["Select the point of the unit frame the icon bar is anchored to."] = true
L["Select which point of the bar is anchored to the unit frame."] = true
L["Test mode"] = true
L["Top Left"] = true
L["Top right"] = true
L["Top"] = true
L["Unit frame attaching point"] = true
L["X-axis offset"] = true
L["Y-axis offset"] = true


------------------------ frFR ------------------------
local locale = GetLocale()
if locale == 'frFR' then
L["Adjust the number of icons per row."] = "Ajuste le nombre d'icônes par rangée."
L["Adjust the number of icons to display."] = "Ajuste le nombre d'icônes à afficher."
L["Adjust the offset between the bar and the unit frame along the x-axis."] = "Ajuste le décalage entre la barre d'icônes et la barre d'unité le long de l'axe X."
L["Adjust the offset between the bar and the unit frame along the y-axis."] = "Ajuste le décalage entre la barre d'icônes et la barre d'unité le long de l'axe Y."
L["Adjust the opacity of the icon bar. 100% is fully opaque; 10% is almost transparent."] = "Ajuste l'opacité de la barre d'icônes ; totalement opaque à 100% et quasiment transparent à 10%."
L["Adjust the scale of the icon bar."] = "Ajuste l'échelle de la barre d'icônes."
L["Adjust the size of the space between the icons."] = "Ajuste la taille de l'espace entre les icônes."
L["Bar anchoring point"] = "Point d'ancrage de la barre."
L["Bottom"] = "Bas"
L["Bottom left"] = "Bas Gauche"
L["Bottom right"] = "Bas droit"
L["Center"] = "Centre"
L["Check this box to have the icon flashes when there is less than 3 seconds left."] = "Cocher cette option pour que les icônes clignotent lorsqu'il reste moins de 3 secondes."
L["Enable test mode. In test mode, every defined icon are shown."] = "Active le mode de test ; dans ce mode, tous les icônes sont affichés."
L["Flashing icons"] = "Icônes clignotantes"
L["Icon #%d"] = "Icône n°%d"
L["Icon Bar"] = "Barre d'icônes"
L["Icon borders"] = "Bords"
L["Icon opacity"] = "Opacité"
L["Icon scale"] = "Echelle"
L["Icon spacing"] = "Espacement des icônes"
L["Left"] = "Gauche"
L["Number of icons"] = "Nombre d'icônes"
L["Number of icons per row"] = "Nombre d'icônes par rangée"
L["Options for Icon Bar indicators."] = "Options de la barre d'icônes."
L["Right"] = "Droite"
L["Select icons that should display their border."] = "Sélectionne les icônes dont le bord est affiché."
L["Select the point of the unit frame the icon bar is anchored to."] = "Sélectionne le point de la cellule auquel est ancrée la barre d'icône."
L["Select which point of the bar is anchored to the unit frame."] = "Sélectionne le point de la barre qui est ancré à la cellule."
L["Test mode"] = "Mode de test"
L["Top"] = "Haut"
L["Top Left"] = "Haut gauche"
L["Top right"] = "Haut droite"
L["Unit frame attaching point"] = "Point d'ancrage à la cellule"
L["X-axis offset"] = "Décalage en X"
L["Y-axis offset"] = "Décalage en Y"

------------------------ deDE ------------------------
-- no translation

------------------------ esMX ------------------------
-- no translation

------------------------ ruRU ------------------------
-- no translation

------------------------ esES ------------------------
-- no translation

------------------------ zhTW ------------------------
-- no translation

------------------------ zhCN ------------------------
-- no translation

------------------------ koKR ------------------------
-- no translation
end

-- @noloc]]

-- Replace remaining true values by their key
for k,v in pairs(L) do if v == true then L[k] = k end end
