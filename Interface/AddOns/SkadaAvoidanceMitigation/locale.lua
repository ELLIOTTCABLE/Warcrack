-- my custom locale file - more streamlined than AceLocale and no lib dependency

-- To help with missing translations please go here:
-- http://www.wowace.com/addons/skadaavoidancemitigation/localization/

local addonName, vars = ...
local Ld, La = {}, {}
local locale = GAME_LOCALE or GetLocale()

vars.L = setmetatable({},{
    __index = function(t, s) return La[s] or Ld[s] or rawget(t,s) or s end
})

Ld["Average"] = "Average"
Ld["Avoidance and mitigation"] = "Avoidance and mitigation"
Ld["incoming attack breakdown"] = "incoming attack breakdown"


if locale == "frFR" then do end
La["Average"] = "Moyenne" -- Needs review
La["Avoidance and mitigation"] = "Évitement et l'atténuation" -- Needs review
La["incoming attack breakdown"] = "Répartition attaque entrante" -- Needs review

elseif locale == "deDE" then do end
La["Average"] = "Durchschnitt"
La["Avoidance and mitigation"] = "Vermeidung und Verminderung"
La["incoming attack breakdown"] = "eingehende Angriffe Übersicht"

elseif locale == "koKR" then do end
La["Average"] = "평균" -- Needs review
La["Avoidance and mitigation"] = "회피 및 완화" -- Needs review
La["incoming attack breakdown"] = "들어오는 공격 분석" -- Needs review

elseif locale == "esMX" then do end
La["Average"] = "Promedio" -- Needs review
La["Avoidance and mitigation"] = "Prevención y mitigación" -- Needs review
La["incoming attack breakdown"] = "desglose ataque entrante" -- Needs review

elseif locale == "ruRU" then do end
La["Average"] = "средний" -- Needs review
La["Avoidance and mitigation"] = "Предотвращение и смягчение последствий" -- Needs review
La["incoming attack breakdown"] = "входящих пробоя атаки" -- Needs review

elseif locale == "zhCN" then do end
La["Average"] = "平均" -- Needs review
La["Avoidance and mitigation"] = "避免和减轻" -- Needs review
La["incoming attack breakdown"] = "的攻击故障" -- Needs review

elseif locale == "esES" then do end
La["Average"] = "Promedio" -- Needs review
La["Avoidance and mitigation"] = "Prevención y mitigación" -- Needs review
La["incoming attack breakdown"] = "desglose ataque entrante" -- Needs review

elseif locale == "zhTW" then do end
La["Average"] = "平均"
La["Avoidance and mitigation"] = "閃避和減傷"
La["incoming attack breakdown"] = "受到攻擊的分類"

elseif locale == "ptBR" then do end
La["Average"] = "Média" -- Needs review
La["Avoidance and mitigation"] = "Prevenção e mitigação" -- Needs review
La["incoming attack breakdown"] = "quebra ataque de entrada" -- Needs review

elseif locale == "itIT" then do end
La["Average"] = "Media" -- Needs review
La["Avoidance and mitigation"] = "Prevenzione e mitigazione" -- Needs review
La["incoming attack breakdown"] = "attacco ripartizione in arrivo" -- Needs review

end
