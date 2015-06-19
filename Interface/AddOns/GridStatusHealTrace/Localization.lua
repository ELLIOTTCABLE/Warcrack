--[[--------------------------------------------------------------------
	GridStatusHealTrace
	Shows in Grid who was healed by your multi-target heals.
	Copyright (c) 2010-2015 Akkorian <akkorian@hotmail.com>.
	Copyright (c) 2010-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info16608-GridStatusHealTrace.html
	http://www.curse.com/addons/wow/gridstatushealtrace
	https://github.com/Phanx/GridStatusHealTrace
----------------------------------------------------------------------]]

local _, ns = ...

local L = setmetatable({}, { __index = function(t, k)
	local v = tostring(k)
	t[k] = v
	return v
end })
ns.L = L

local LOCALE = GetLocale()

if LOCALE == "deDE" then
	L["Heal Trace"] = "Heilung verfolgen"
	L["Hold time"] = "Haltezeit"
	L["Show the status for this many seconds."] = "Zeigt den Status so lange wie hier konfiguriert an."
	L["Add new spell"] = "Zauber hinzufügen"
	L["Add another healing spell to trace."] = "Fügt einen weiteren Heilungszauber hinzu, um zu verfolgen."
	L["<spell name or spell ID>"] = "<namen oder ID des Heilungszauber>"
	L["Remove spell"] = "Zauber entfernen"
	L["Remove a spell from the trace list."] = "Entfernt einen Heilungszauber aus der Verfolgungsliste."
	L["Remove %s from the trace list."] = "Entfernt '%s' aus der Verfolgungsliste."
return end

if LOCALE == "esES" or LOCALE == "esMX" then
	L["Heal Trace"] = "Sanaciones seguidos"
	L["Hold time"] = "Tiempo de mostrado"
	L["Show the status for this many seconds."] = "Mostrar el estado por esta cantidad de segundos."
	L["Add new spell"] = "Añadir hechizo"
	L["Add another healing spell to trace."] = "Añadir otro hechizo de sanación para seguir."
	L["<spell name or spell ID>"] = "<nombre o ID de hechizo>"
	L["Remove spell"] = "Quitar hechizo"
	L["Remove a spell from the trace list."] = "Quitar un hechizo de la lista para seguir."
	L["Remove %s from the trace list."] = "Quitar %s de la lista para seguir."
return end

if LOCALE == "frFR" then
	L["Heal Trace"] = "Soins suivi"
	L["Hold time"] = "Temps de montrer"
	L["Show the status for this many seconds."] = "Afficher le statut de ce nombre de secondes."
	L["Add new spell"] = "Ajouter sort"
	L["Add another healing spell to trace."] = "Ajouter une autre sort de soins à suivre."
	L["<spell name or spell ID>"] = "<nom ou ID de sort>"
	L["Remove spell"] = "Supprimer sort"
	L["Remove a spell from the trace list."] = "Supprimer un sort de la liste à suivre."
	L["Remove %s from the trace list."] = "Supprimer %s de la liste à suivre."
return end

if LOCALE == "itIT" then
	L["Heal Trace"] = "Cure seguite"
	L["Hold time"] = "Momento di mostrare"
	L["Show the status for this many seconds."] = "Visualizza lo stato per questo molti secondi."
	L["Add new spell"] = "Aggiungi incantesimo"
	L["Add another healing spell to trace."] = "Aggiungere un altro incantesimo di cura da seguire."
	L["<spell name or spell ID>"] = "<nome o ID di incantesimo>"
	L["Remove spell"] = "Rimuovere incantesimo"
	L["Remove a spell from the trace list."] = "Rimuovere un incantesimo alla lista da seguire."
	L["Remove %s from the trace list."] = "Rimuovere %s alla lista da seguire."
return end

if LOCALE == "ptBR" then
	L["Heal Trace"] = "Curas seguidas"
	L["Hold time"] = "Tempo para mostrar"
	L["Show the status for this many seconds."] = "Mostrar o estado para isso muitos segundos."
	L["Add new spell"] = "Adicionar feitiço"
	L["Add another healing spell to trace."] = "Adicionar outra feitiço de cura para seguir."
	L["<spell name or spell ID>"] = "<nome ou ID de feitiço>"
	L["Remove spell"] = "Remover feitiço"
	L["Remove a spell from the trace list."] = "Remover um feitiço à lista para seguir."
	L["Remove %s from the trace list."] = "Remover %s à lista para seguir."
return end

if LOCALE == "ruRU" then -- Last updated 2013-08-10 by Tromboz @ CurseForge
	L["Heal Trace"] = "Спелл-лист исцеления"
	L["Hold time"] = "Время удержания"
	L["Show the status for this many seconds."] = "Показывать статус именно столько секунд."
	L["Add new spell"] = "Добавить новое заклинание"
	L["Add another healing spell to trace."] = "Добавить другое лечащее заклинание в спелл-лист."
	L["<spell name or spell ID>"] = "<название или ID заклинания>"
	L["Remove spell"] = "Убрать заклинание"
	L["Remove a spell from the trace list."] = "Убрать заклинание из спелл-листа."
	L["Remove %s from the trace list."] = "Убрать %s из спелл-листа."
return end

if LOCALE == "koKR" then -- Last updated 2011-12-12 by Sayclub @ CurseForge
	L["Heal Trace"] = "치유 추적"
	L["Hold time"] = "유지 시간"
	L["Show the status for this many seconds."] = "몇 초 동안 상태 창에 표시할지 설정합니다."
	L["Add new spell"] = "새로운 주문 추가"
	L["Add another healing spell to trace."] = "추적 목록에 치유 주문을 추가합니다."
	L["<spell name or spell ID>"] = "<주문 이름이나 주문 ID>"
	L["Remove spell"] = "주문 제거"
	L["Remove a spell from the trace list."] = "추적 목록에서 주문을 제거합니다."
	L["Remove %s from the trace list."] = "추적 목록에서 %s|1을;를; 제거합니다."
return end

if LOCALE == "zhCN" then -- Last updated 2012-12-05 by luomoon @ CurseForge
	L["Heal Trace"] = "治疗追踪"
	L["Hold time"] = "持续时间"
	L["Show the status for this many seconds."] = "显示状态的秒数"
	L["Add new spell"] = "添加新法术"
	L["Add another healing spell to trace."] = "添加另一个需要追踪的治疗法术"
	L["<spell name or spell ID>"] = "<法术名称或法术编号>"
	L["Remove spell"] = "移除法术"
	L["Remove a spell from the trace list."] = "从追踪列表上移除一个法术"
	L["Remove %s from the trace list."] = "将 %s 从追踪列表上移除"
return end

if LOCALE == "zhTW" then -- Last updated 2012-12-05 by luomoon @ CurseForge
	L["Heal Trace"] = "治療追蹤"
	L["Hold time"] = "持續時間"
	L["Show the status for this many seconds."] = "顯示狀態秒數"
	L["Add new spell"] = "添加新法術"
	L["Add another healing spell to trace."] = "添加另一個需要追蹤的法術"
	L["<spell name or spell ID>"] = "<法術名稱或法術編號>"
	L["Remove spell"] = "移除法術"
	L["Remove a spell from the trace list."] = "從追蹤列表移除法術"
	L["Remove %s from the trace list."] = "將 %s 從追蹤列表移除"
return end