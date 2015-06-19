-- my custom locale file - more streamlined than AceLocale and no lib dependency

-- To help with missing translations please go here:
-- http://www.wowace.com/addons/skada_friendlyfire/localization/

local addonName, vars = ...
local Ld, La = {}, {}
local locale = GAME_LOCALE or GetLocale()

vars.L = setmetatable({},{
    __index = function(t, s) return La[s] or Ld[s] or rawget(t,s) or s end
})

Ld["Friendly Fire"] = "Friendly Fire"
Ld["Ignore class abilities"] = "Ignore class abilities"
Ld["Ignore damage from other class abilities, such as Unholy Frenzy"] = "Ignore damage from other class abilities, such as Unholy Frenzy"
Ld["Ignore defensive damage"] = "Ignore defensive damage"
Ld["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = "Ignore delayed damage from defensive abilities, such as Monk Stagger"
Ld["List of damaging spells"] = "List of damaging spells"
Ld["List of players damaged"] = "List of players damaged"
Ld["spells"] = "spells"
Ld["targets"] = "targets"


if locale == "frFR" then do end
-- La["Friendly Fire"] = ""
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
-- La["List of damaging spells"] = ""
-- La["List of players damaged"] = ""
-- La["spells"] = ""
-- La["targets"] = ""

elseif locale == "deDE" then do end
La["Friendly Fire"] = "Eigenbeschuss"
La["Ignore class abilities"] = "Ignoriere Klassenfähigkeiten"
La["Ignore damage from other class abilities, such as Unholy Frenzy"] = "Ignoriere Schaden von anderen Klassenfähigkeiten, z.B. Unheilige Raserei"
La["Ignore defensive damage"] = "Ignoriere defensiven Schaden"
La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = "Ignoriere verzögerten Schaden von defensiven Fähigkeiten, z.B. Staffeln eines Mönches"
La["List of damaging spells"] = "Liste der Schadenszauber"
La["List of players damaged"] = "Liste der Spieler"
La["spells"] = "Zauber"
La["targets"] = "Ziele"

elseif locale == "koKR" then do end
-- La["Friendly Fire"] = ""
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
-- La["List of damaging spells"] = ""
-- La["List of players damaged"] = ""
-- La["spells"] = ""
-- La["targets"] = ""

elseif locale == "esMX" then do end
-- La["Friendly Fire"] = ""
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
-- La["List of damaging spells"] = ""
-- La["List of players damaged"] = ""
-- La["spells"] = ""
-- La["targets"] = ""

elseif locale == "ruRU" then do end
La["Friendly Fire"] = "Урон от дружественных игроков" -- Needs review
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
La["List of damaging spells"] = "Список заклинаний, которые нанесли урон" -- Needs review
La["List of players damaged"] = "Список поврежденных игроков" -- Needs review
La["spells"] = "Заклинания" -- Needs review
La["targets"] = "Цели" -- Needs review

elseif locale == "zhCN" then do end
La["Friendly Fire"] = "队友误伤" -- Needs review
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
La["List of damaging spells"] = "伤害法术列表" -- Needs review
La["List of players damaged"] = "伤害玩家列表" -- Needs review
La["spells"] = "法术" -- Needs review
La["targets"] = "目标" -- Needs review

elseif locale == "esES" then do end
La["Friendly Fire"] = "Fuego Amigo"
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
La["List of damaging spells"] = "Lista de hechizos dañinos"
La["List of players damaged"] = "Lista de jugadores dañados"
La["spells"] = "hechizos"
La["targets"] = "objetivos"

elseif locale == "zhTW" then do end
La["Friendly Fire"] = "隊友誤傷"
La["Ignore class abilities"] = "忽略職業技能"
La["Ignore damage from other class abilities, such as Unholy Frenzy"] = "忽略其他職業技能的傷害，如邪惡狂熱"
La["Ignore defensive damage"] = "忽略防禦的傷害"
La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = "忽略因防禦技能而延後的傷害，如武僧的醉仙緩勁"
La["List of damaging spells"] = "傷害法術列表"
La["List of players damaged"] = "傷害玩家列表"
La["spells"] = "法術"
La["targets"] = "目標"

elseif locale == "ptBR" then do end
-- La["Friendly Fire"] = ""
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
-- La["List of damaging spells"] = ""
-- La["List of players damaged"] = ""
-- La["spells"] = ""
-- La["targets"] = ""

elseif locale == "itIT" then do end
-- La["Friendly Fire"] = ""
-- La["Ignore class abilities"] = ""
-- La["Ignore damage from other class abilities, such as Unholy Frenzy"] = ""
-- La["Ignore defensive damage"] = ""
-- La["Ignore delayed damage from defensive abilities, such as Monk Stagger"] = ""
-- La["List of damaging spells"] = ""
-- La["List of players damaged"] = ""
-- La["spells"] = ""
-- La["targets"] = ""

end
