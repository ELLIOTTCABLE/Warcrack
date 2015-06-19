-- Quester Locale
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/quester/localization/

local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local L = LibStub("AceLocale-3.0"):NewLocale("Quester", "enUS", true, debug)
L["Always show objective percentage values on progress bars"] = true
L["Behavior Configuration"] = true
L["Configure the sounds you want to hear with the toggles below."] = true
L["Difficulty Coloring"] = true
L["Enable the coloring of quests according to their difficulty in NPC and Item tooltips."] = true
L["Enable the coloring of quests according to their difficulty in the quest tracker."] = true
L["Enable the coloring of quests according to their difficulty on NPC Gossip frames."] = true
L["Gossip frames"] = true
L["Highlight most valuable reward"] = true
L["Highlight the reward with the highest vendor value when completing a quest."] = true
L["Job's Done!"] = true
L["Lock the Objective Tracker in place"] = true
L["More Work?!"] = true
L["Note: Changing this option may require your UI to be reloaded to take full effect."] = true
L["Peasant"] = true
L["Peon"] = true
L["Progress Output"] = true
L["Quest Tracker"] = true
L["Reset Position"] = true
L["Reset the position of the Objective Tracker to the default."] = true
L["Select the set of sounds to use."] = true
L["Show Quest Level"] = true
L["Sound Configuration"] = true
L["Sound Set"] = true
L["Toggle if completing a quest should automatically remove it from the tracker."] = true
L["Toggle if quest levels are shown in various parts of the UI."] = true
L["Toggle playing the 'Job's Done!' sound after completing a quest."] = true
L["Toggle playing the 'More Work?!' sound after completing an objective."] = true
L["Toggling this option may require a UI reload to fully take effect."] = true
L["Tooltips"] = true
L["Unlock Quest Tracker position"] = true
L["Unlock the position of the Objective Tracker, allowing it to be moved by clicking and dragging its header."] = true
L["Un-track complete quests"] = true
L["You can select where you want progress messages displayed using the options below."] = true
L["You can unlock it again in the options"] = true


L = LibStub("AceLocale-3.0"):NewLocale("Quester", "deDE")
if L then
L["Highlight most valuable reward"] = "Wertvollste Questbelohnung hervorheben" -- Needs review
L["Highlight the reward with the highest vendor value when completing a quest."] = "Hebt bei Questabschluss die Belohnung mit dem höchsten Verkaufswert hervor." -- Needs review
L["Note: Changing this option may require your UI to be reloaded to take full effect."] = "Bevor ein Ändern dieser Option wirksam wird, könnte ein Neustart (oder UI reload) nötig sein" -- Needs review
L["Peasant"] = "Arbeiter" -- Needs review
L["Peon"] = "Peon" -- Needs review
L["Select the set of sounds to use."] = "Wählt das zu verwendende Soundset aus." -- Needs review
L["Show Quest Level"] = "Quest-Level anzeigen" -- Needs review
L["Sound Set"] = "Soundset" -- Needs review
L["Toggle if quest levels are shown in various parts of the UI."] = "Fügt an einigen Stellen des Spieles die Quest-Level hinzu." -- Needs review
L["You can select where you want progress messages displayed using the options below."] = "Mit der untenstehenden Auswahl bestimmt ihr, wo Fortschritts-Nachrichten angezeigt werden." -- Needs review

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "esES")
if L then

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "esMX")
if L then

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "frFR")
if L then
L["Always show objective percentage values on progress bars"] = "Toujours afficher le pourcentage sur les barres de progression" -- Needs review
L["Behavior Configuration"] = "Configuration du comportement"
L["Configure the sounds you want to hear with the toggles below."] = "Configurez les sons que vous souhaitez entendre avec les options ci-dessous."
L["Difficulty Coloring"] = "Coloration de la difficulté"
L["Enable the coloring of quests according to their difficulty in NPC and Item tooltips."] = "Active la coloration des quêtes selon leur difficulté dans les bulles d'aide des objets et de PNJs."
L["Enable the coloring of quests according to their difficulty in the quest tracker."] = "Active la coloration des quêtes selon leur difficulté dans le suivi des quêtes."
L["Enable the coloring of quests according to their difficulty on NPC Gossip frames."] = "Active la coloration des quêtes selon leur difficulté dans les fenêtres de conversation des PNJs."
L["Gossip frames"] = "Fenêtres de conversation"
L["Highlight most valuable reward"] = "Mettre en évidence la récompense la plus profitable"
L["Highlight the reward with the highest vendor value when completing a quest."] = "Met en évidence la récompense ayant la plus haute valeur de revente aux marchands."
L["Job's Done!"] = "Travail terminé !"
L["Lock the Objective Tracker in place"] = "Verrouiller le suivi des objectifs à sa place actuelle"
L["More Work?!"] = "Encore du travail ?!"
L["Note: Changing this option may require your UI to be reloaded to take full effect."] = "Note : modifier cette option peut nécessiter de recharger votre IU afin qu'elle prenne effet."
L["Peasant"] = "Paysan"
L["Peon"] = "Péon"
L["Progress Output"] = "Sortie de la progression"
L["Quest Tracker"] = "Suivi de quêtes"
L["Reset Position"] = "RàZ de la position"
L["Reset the position of the Objective Tracker to the default."] = "Réinitialise la position du suivi des objectifs."
L["Select the set of sounds to use."] = "Sélectionner l'ensemble de sons à utiliser."
L["Show Quest Level"] = "Afficher le niveau des quêtes"
L["Sound Configuration"] = "Configuration du son"
L["Sound Set"] = "Ensemble de sons"
L["Toggle if completing a quest should automatically remove it from the tracker."] = "Enlève ou non automatiquement une quête quand elle est terminée."
L["Toggle if quest levels are shown in various parts of the UI."] = "Affiche ou non le niveau des quêtes dans divers endroits de l'IU."
L["Toggle playing the 'Job's Done!' sound after completing a quest."] = "Joue ou non le son 'Travail terminé !' après avoir terminé une quête."
L["Toggle playing the 'More Work?!' sound after completing an objective."] = "Joue ou non le son 'Encore du travail ?!' après avoir terminé un objectif."
L["Toggling this option may require a UI reload to fully take effect."] = "La modification de cette option peut nécessiter de recharger votre IU afin qu'elle prenne effet." -- Needs review
L["Tooltips"] = "Bulles d'aide"
L["Unlock Quest Tracker position"] = "Déverrouiller la position du suivi des quêtes"
L["Unlock the position of the Objective Tracker, allowing it to be moved by clicking and dragging its header."] = "Déverrouille la position du suivi des objectifs, vous permettant de le déplacer en cliquant et en glissant son en-tête."
L["Un-track complete quests"] = "Ne plus suivre les quêtes terminées"
L["You can select where you want progress messages displayed using the options below."] = "Vous pouvez choisir où les messages de progression sont affichés via les options ci-dessous."
L["You can unlock it again in the options"] = "Vous pouvez le déverrouiller à nouveau dans les options."

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "itIT")
if L then

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "koKR")
if L then
L["Always show objective percentage values on progress bars"] = "진행 바에 목표달성률 표시" -- Needs review
L["Behavior Configuration"] = "일반 설정"
L["Configure the sounds you want to hear with the toggles below."] = "선택한 소리로 변경합니다."
L["Difficulty Coloring"] = "난이도 색상" -- Needs review
L["Enable the coloring of quests according to their difficulty in NPC and Item tooltips."] = "NPC와 아이템 툴팁에 퀘스트의 난이도에 따른 색상을 표시합니다." -- Needs review
L["Enable the coloring of quests according to their difficulty in the quest tracker."] = "퀘스트 추적기에 난이도에 따른 색상을 표시합니다." -- Needs review
L["Enable the coloring of quests according to their difficulty on NPC Gossip frames."] = "NPC 대화 창에 퀘스트 난이도에 따른 색상을 표시합니다." -- Needs review
L["Gossip frames"] = "NPC 대화 창" -- Needs review
L["Highlight most valuable reward"] = "아이템 보상 강조"
L["Highlight the reward with the highest vendor value when completing a quest."] = "퀘스트를 완료할 때 상점 가격이 가장 비싼 아이템을 강조합니다."
L["Job's Done!"] = "퀘스트 완료"
L["Lock the Objective Tracker in place"] = "퀘스트 추적기를 현재 위치에 고정합니다." -- Needs review
L["More Work?!"] = "퀘스트 목표 완료"
L["Note: Changing this option may require your UI to be reloaded to take full effect."] = "이 설정을 적용하려면 UI를 재시작해야 합니다."
L["Peasant"] = "피센트"
L["Peon"] = "피온"
L["Progress Output"] = "진행 상황 표시"
L["Quest Tracker"] = "퀘스트 추적기" -- Needs review
L["Reset Position"] = "위치 초기화" -- Needs review
L["Reset the position of the Objective Tracker to the default."] = "퀘스트 추적기의 위치를 초기화 합니다." -- Needs review
L["Select the set of sounds to use."] = "사용하려는 소리 구성을 선택합니다."
L["Show Quest Level"] = "퀘스트 레벨 표시"
L["Sound Configuration"] = "소리 설정"
L["Sound Set"] = "소리 구성"
L["Toggle if completing a quest should automatically remove it from the tracker."] = "완료된 퀘스트를 자동으로 추적기에서 표시하지 않습니다."
L["Toggle if quest levels are shown in various parts of the UI."] = "퀘스트가 표시되는 곳에 퀘스트의 레벨을 표시합니다."
L["Toggle playing the 'Job's Done!' sound after completing a quest."] = "퀘스트가 완료되면 'Job's Done!' 소리를 들을 수 있습니다."
L["Toggle playing the 'More Work?!' sound after completing an objective."] = "퀘스트 목표가 완료되면 'More Work?!' 소리를 들을 수 있습니다."
L["Toggling this option may require a UI reload to fully take effect."] = "이 설정은 UI를 재시작해야 적용됩니다." -- Needs review
L["Tooltips"] = "툴팁" -- Needs review
L["Unlock Quest Tracker position"] = "퀘스트 추적기 이동 해제" -- Needs review
L["Unlock the position of the Objective Tracker, allowing it to be moved by clicking and dragging its header."] = "퀘스트 추적기를 이동할 수 있습니다. 퀘스트 제목을 드래그하여 이동할 수 있습니다." -- Needs review
L["Un-track complete quests"] = "완료된 퀘스트 숨김"
L["You can select where you want progress messages displayed using the options below."] = "퀘스트의 진행 상황 메시지를 아래에 선택한 곳으로 표시합니다."
L["You can unlock it again in the options"] = "이 설정을 다시 해제할 수 있습니다." -- Needs review

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "ptBR")
if L then

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "ruRU")
if L then

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "zhCN")
if L then
L["Behavior Configuration"] = "性能配置" -- Needs review
L["Configure the sounds you want to hear with the toggles below."] = "配置你想听到下面的切换的声音" -- Needs review
L["Difficulty Coloring"] = "难度着色" -- Needs review
L["Enable the coloring of quests according to their difficulty in NPC and Item tooltips."] = "允许在NPC及物品提示处对任务难度进行着色" -- Needs review
L["Enable the coloring of quests according to their difficulty in the quest tracker."] = "允许在任务追踪器中对任务难度进行着色" -- Needs review
L["Enable the coloring of quests according to their difficulty on NPC Gossip frames."] = "允许在NPC闲聊对话框中对任务难度进行着色" -- Needs review
L["Gossip frames"] = "闲聊框体" -- Needs review
L["Highlight most valuable reward"] = "高亮最有价值的奖励" -- Needs review
L["Highlight the reward with the highest vendor value when completing a quest."] = "当完成任务时，将卖店价最高的物品高亮显示。" -- Needs review
L["Job's Done!"] = "工作完成" -- Needs review
L["More Work?!"] = "更多工作？" -- Needs review
L["Note: Changing this option may require your UI to be reloaded to take full effect."] = "注意：更改此项设定可能需要重载用户界面才能生效" -- Needs review
L["Peasant"] = "农夫" -- Needs review
L["Peon"] = "苦工" -- Needs review
L["Progress Output"] = "进程输出" -- Needs review
L["Quest Tracker"] = "任务追踪器" -- Needs review
L["Select the set of sounds to use."] = "选择使用的语音组" -- Needs review
L["Show Quest Level"] = "显示任务等级" -- Needs review
L["Sound Configuration"] = "声音配置" -- Needs review
L["Sound Set"] = "语音组" -- Needs review
L["Toggle if completing a quest should automatically remove it from the tracker."] = "切换当完成某项任务时是否自动从跟踪列表中移除" -- Needs review
L["Toggle if quest levels are shown in various parts of the UI."] = "切换是否在多个界面位置显示任务等级" -- Needs review
L["Toggle playing the 'Job's Done!' sound after completing a quest."] = "切换当完成某项任务时是否播放“工作完成”语音" -- Needs review
L["Toggle playing the 'More Work?!' sound after completing an objective."] = "切换当完成某项任务目标时是否播放“更多工作”语音" -- Needs review
L["Tooltips"] = "提示" -- Needs review
L["Un-track complete quests"] = "不追踪已完成任务" -- Needs review
L["You can select where you want progress messages displayed using the options below."] = "你可以在下面的列表中选择任务进程报告的输出位置。" -- Needs review

end

L = LibStub("AceLocale-3.0"):NewLocale("Quester", "zhTW")
if L then
L["Always show objective percentage values on progress bars"] = "始終顯示目標進度條的百分比" -- Needs review
L["Behavior Configuration"] = "行為設定" -- Needs review
L["Configure the sounds you want to hear with the toggles below."] = "在下面切換你想聽到的聲音。" -- Needs review
L["Difficulty Coloring"] = "難度著色" -- Needs review
L["Enable the coloring of quests according to their difficulty in NPC and Item tooltips."] = "根據任務難度對NPC與物品提示啟用著色。" -- Needs review
L["Enable the coloring of quests according to their difficulty in the quest tracker."] = "根據任務難度對任務追蹤器啟用著色。" -- Needs review
L["Enable the coloring of quests according to their difficulty on NPC Gossip frames."] = "根據任務難度對NPC對話框架啟用著色。" -- Needs review
L["Gossip frames"] = "對話框架" -- Needs review
L["Highlight most valuable reward"] = "高亮最有價值的獎賞"
L["Highlight the reward with the highest vendor value when completing a quest."] = "當完成一個任務時，高亮顯示販售價值最高的獎賞。"
L["Job's Done!"] = "工作完成！"
L["Lock the Objective Tracker in place"] = "鎖定任務追蹤器位置" -- Needs review
L["More Work?!"] = "更多工作？" -- Needs review
L["Note: Changing this option may require your UI to be reloaded to take full effect."] = "注意：更改此選項可能需要重新加載您的插件才能完全發揮效用。" -- Needs review
L["Peasant"] = "農夫"
L["Peon"] = "苦工"
L["Progress Output"] = "進度輸出"
L["Quest Tracker"] = "任務追蹤器" -- Needs review
L["Reset Position"] = "重置位置" -- Needs review
L["Reset the position of the Objective Tracker to the default."] = "重置任務追蹤器為預設位置。" -- Needs review
L["Select the set of sounds to use."] = "選擇要使用的音效設置。"
L["Show Quest Level"] = "顯示任務等級" -- Needs review
L["Sound Configuration"] = "聲音設定" -- Needs review
L["Sound Set"] = "音效設置"
L["Toggle if completing a quest should automatically remove it from the tracker."] = "切換是否在任務完成時自動自追蹤器移除。" -- Needs review
L["Toggle if quest levels are shown in various parts of the UI."] = "切換是否在用戶介面各處示任務等級。" -- Needs review
L["Toggle playing the 'Job's Done!' sound after completing a quest."] = "切換是否在完成任務後播放「工作完成！」音效。" -- Needs review
L["Toggle playing the 'More Work?!' sound after completing an objective."] = "切換是否在完成任務目標後播放「更多工作？」音效。" -- Needs review
L["Toggling this option may require a UI reload to fully take effect."] = "切換此選項可能需要重新載入UI方能完全生效。" -- Needs review
L["Tooltips"] = "工具提示" -- Needs review
L["Unlock Quest Tracker position"] = "解鎖任務追蹤器位置" -- Needs review
L["Unlock the position of the Objective Tracker, allowing it to be moved by clicking and dragging its header."] = "解鎖任務追蹤器的位置，使其能夠透過拖曳標題而被移動。" -- Needs review
L["Un-track complete quests"] = "不追蹤已完成任務"
L["You can select where you want progress messages displayed using the options below."] = "您可以使用以下的選項選擇您要顯示進度訊息的地方。"
L["You can unlock it again in the options"] = "您可以在選項內再次解鎖" -- Needs review

end
