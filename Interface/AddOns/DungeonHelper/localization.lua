
-- CHANGES TO LOCALIZATION SHOULD BE MADE USING http://www.wowace.com/addons/Broker_FindGroup/localization/

local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("DungeonHelper", "enUS", true)

if L then
	L["Raid completed in"] = true
	L["Twilight"] = true
	
	L["Leave Party Dialog"] = true
	L["Show a leave party dialog at the end of a random dungeon."] = true
	
	L["End Message"] = true
	L["Start Message"] = true
	L["Sends a message to the party chat at the beginning of the dungeon."] = true
	L["Sends a message to the party chat at the end of the dungeon."] = true
	L["Clear the box to disable this."] = true
	L["hi"] = true
	L["thanks, bb"] = true
	
	L["Show Time"] = true 
	L["You need to have a Data Broker Display to see this Plugin."] = true  
	
	L["Play Invitation Sound"] = true
	L["Play the selected Sound when the group is ready."] = true
	L["Select Sound"] = true
	L["Play Bonus Sound"] = true
	L["Warning: Some of the sounds may depend on other addons."] = true
	L["Dungeon Helper: Bonus available!"] = true
	L["Watch"] = true
	L["Report To Chat"] = true
	L["Watch for Call To Arms (Bonus rewards) availability."] = true
	L["Call To Arms"] = true
	
	L["Hour"] = true
	L["Minute"] = true
	L["Second"] = true
	L["Hours"] = true
	L["Minutes"] = true
	L["Seconds"] = true
	L["Icon Size"] = true
	L["Zandalari"] = true
	L["Cata"] = true
	L["Show Timer Bar"] = true
	L["Remaining"] = true
	L["General"] = true
	L["Data Broker"] = true
	L["Play Alert"] = true
	L["Options"] = true
	L["Display Type"] = true

	L["Report Time to Party"] = true
	L["Dungeon completed in"] = true
	L["Completed in"] = true
	L["Hide Minimap Button"] = true

	L["Show Instance Name"] = true
	L["Short Text"] = true
	L["Teleport In/Out"] = true
	L["T"] = true
	L["H"] = true
	L["D"] = true
	L["Waiting for:"] = true
	L["My estimated wait time:"] = true
	L["Wait time as:"] = true
	L["Time"] = true
	L["Tank"] = true
	L["Healer"] = true
	L["DPS"] = true
	L["In Party"] = true
	L["Find Group"] = true
	L["Queued for: "] = true
	L["Click to open the dungeon finder."] = true
	L["Shift-Click to open the raid finder."] = true
	L["Ctrl-Click or Middle-Click Teleport."] = true
	L["Right-Click for options."] = true
end

local L = AceLocale:NewLocale("DungeonHelper", "deDE")
if L then 
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "Gruppe zusammenstellen..."
L["Call To Arms"] = "Ruf zu den Waffen"
L["Cata"] = "Cata"
L["Clear the box to disable this."] = "Text aus dem Feld löschen um keinen Spruch zu senden."
L["Click to open the dungeon finder."] = "Klicken, um den Dungeonfinder zu öffnen."
L["Completed in"] = "Abgeschlossen in"
L["Ctrl-Click or Middle-Click Teleport."] = "Strg-Klick oder Mittelklick für Teleport"
L["D"] = "DD"
L["Data Broker"] = "Data Broker"
L["Display Type"] = "Anzeige Art"
L["DPS"] = "DD"
L["Dungeon completed in"] = "Dungeon abgeschlossen in"
L["Dungeon Helper: Bonus available!"] = "Dungeon Helper: Bonus verfügbar!"
L["End Message"] = "Text beim verlassen"
L["Find Group"] = "Gruppe finden"
L["General"] = "Allgemein"
L["H"] = "H"
L["Healer"] = "Heiler"
L["hi"] = "hi"
L["Hide Minimap Button"] = "Minimap-Button verstecken"
L["Hour"] = "Stunde"
L["Hours"] = "Stunden"
L["Icon Size"] = "Icon Größe"
L["In Party"] = "In Gruppe"
L["Leave Party Dialog"] = "Gruppeverlassen Fenster"
L["Minute"] = "Minute"
L["Minutes"] = "Minuten"
L["My estimated wait time:"] = "Meine geschätzte Wartezeit: "
L["Options"] = "Optionen"
L["Play Alert"] = "Alarm abspielen"
L["Play Bonus Sound"] = "Bonus Sound"
L["Play Invitation Sound"] = "Sound bei Instanzeinladung"
L["Play the selected Sound when the group is ready."] = "Ausgewählten Sound bei einer Instanzeinladung abspielen."
L["Queued for: "] = "Angemeldet für: "
L["Raid completed in"] = "Schlachtzug kompletiert in"
L["Remaining"] = "Verbleibend"
L["Report Time to Party"] = "Berichte Zeit an Gruppe"
L["Report To Chat"] = "Chat-Benachrichtigung"
L["Right-Click for options."] = "Rechtsklick für Optionen"
L["Second"] = "Sekunde"
L["Seconds"] = "Sekunden"
L["Select Sound"] = "Sound auswählen"
L["Sends a message to the party chat at the beginning of the dungeon."] = "Text der beim beginn der Instanz in den Gruppenchat gesendet wird. "
L["Sends a message to the party chat at the end of the dungeon."] = "Text der beim verlassen der Instanz in den Gruppenchat gesendet wird. "
L["Shift-Click to open the raid finder."] = "Umschalt-Klick um das Schlachtzugsuchfenster zu öffnen."
L["Short Text"] = "Kurzform"
L["Show a leave party dialog at the end of a random dungeon."] = "Zeige das Gruppeverlassenfenster am Ende einer Zufallsinstanz."
L["Show Instance Name"] = "Instanznamen anzeigen"
L["Show Time"] = "Zeit anzeigen"
L["Show Timer Bar"] = "Timer anzeigen"
L["Show Wait Time"] = "Wartezeit anzeigen"
L["Start Message"] = "Begrüßungstext"
L["T"] = "T"
L["Tank"] = "Tank"
L["Teleport In/Out"] = "Rein/Rausporten"
L["thanks, bb"] = "danke, bb"
L["Time"] = "Zeit"
L["Waiting for:"] = "Warte auf: "
L["Wait time as:"] = "Wartezeit als: "
L["Warning: Some of the sounds may depend on other addons."] = "Achtung: Sounds können von anderen Addons abhängig sein."
L["Watch"] = "Beobachte"
L["Watch for Call To Arms (Bonus rewards) availability."] = "Beobachte Ruf zu den Waffen (Extra Belohnung) Verfügbarkeit."
L["You need to have a Data Broker Display to see this Plugin."] = "Du benötigst eine DataBroker-Anzeige um dieses Plugin zu sehen."
L["Zandalari"] = "Zandalari"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "frFR")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "Constitution du groupe..."
L["Call To Arms"] = "Appel aux armes" -- Needs review
L["Cata"] = "Cata" -- Needs review
L["Clear the box to disable this."] = "Ne mettez rien pour désactiver ceci." -- Needs review
L["Click to open the dungeon finder."] = "Cliquez pour ouvrir l'outil Donjons."
L["Completed in"] = "Terminé en" -- Needs review
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl-clic gauche ou clic central pour se téléporter." -- Needs review
L["D"] = "D"
L["Data Broker"] = "Data Broker" -- Needs review
L["Display Type"] = "Type d'affichage" -- Needs review
L["DPS"] = "DPS"
L["Dungeon completed in"] = "Donjon terminé en" -- Needs review
L["Dungeon Helper: Bonus available!"] = "Dungeon Helper : Bonus disponible !" -- Needs review
L["End Message"] = "Message de fin" -- Needs review
L["Find Group"] = "Trouver un groupe"
L["General"] = "Général" -- Needs review
L["H"] = "H"
L["Healer"] = "Soigneur"
L["hi"] = "salut" -- Needs review
L["Hide Minimap Button"] = "Cacher l'icône de la minicarte" -- Needs review
L["Hour"] = "Heure" -- Needs review
L["Hours"] = "Heures" -- Needs review
L["Icon Size"] = "Taille d'icône" -- Needs review
L["In Party"] = "En groupe"
L["Leave Party Dialog"] = "Dialogue de départ du groupe" -- Needs review
L["Minute"] = "Minute" -- Needs review
L["Minutes"] = "Minutes" -- Needs review
L["My estimated wait time:"] = "Mon temps d'attente estimé :"
L["Options"] = "Options" -- Needs review
L["Play Alert"] = "Jouer une alerte" -- Needs review
L["Play Bonus Sound"] = "Jouer son de bonus" -- Needs review
L["Play Invitation Sound"] = "Jouer son d'invitation" -- Needs review
L["Play the selected Sound when the group is ready."] = "Joue le son sélectionné quand le groupe est prêt." -- Needs review
L["Queued for: "] = "En file pour : "
L["Raid completed in"] = "Raid terminé en" -- Needs review
L["Remaining"] = "Restant" -- Needs review
L["Report Time to Party"] = "Indiquer la durée au groupe" -- Needs review
L["Report To Chat"] = "Rapporter dans la discussion" -- Needs review
L["Right-Click for options."] = "Clic droit pour les options." -- Needs review
L["Second"] = "Seconde" -- Needs review
L["Seconds"] = "Secondes" -- Needs review
L["Select Sound"] = "Choix du son" -- Needs review
L["Sends a message to the party chat at the beginning of the dungeon."] = "Envoie un message sur le canal Guilde au début du donjon." -- Needs review
L["Sends a message to the party chat at the end of the dungeon."] = "Envoie un message sur le canal Guilde à la fin du donjon." -- Needs review
L["Shift-Click to open the raid finder."] = "Shift-clic pour ouvrir la recherche de raid." -- Needs review
L["Short Text"] = "Texte court"
L["Show a leave party dialog at the end of a random dungeon."] = "Affiche une boîte de dialogue de départ du groupe à la fin d'un donjon aléatoire." -- Needs review
L["Show Instance Name"] = "Aff. nom de l'instance" -- Needs review
L["Show Time"] = "Afficher la durée" -- Needs review
L["Show Timer Bar"] = "Afficher une barre temporelle" -- Needs review
L["Show Wait Time"] = "Aff. tps d'attente" -- Needs review
L["Start Message"] = "Message de début" -- Needs review
L["T"] = "T"
L["Tank"] = "Tank"
L["Teleport In/Out"] = "Se téléporter à l'intérieur/à l'extérieur"
L["thanks, bb"] = "merci, a+" -- Needs review
L["Time"] = "Temps"
L["Waiting for:"] = "En attente depuis :"
L["Wait time as:"] = "Temps d'attente en tant que :"
L["Warning: Some of the sounds may depend on other addons."] = "Attention : certains des sons dépendent peut-être d'autres addons." -- Needs review
L["Watch"] = "Surveiller" -- Needs review
L["Watch for Call To Arms (Bonus rewards) availability."] = "Surveille la disponibilité de l'Appel aux armes (récompenses bonus)." -- Needs review
L["You need to have a Data Broker Display to see this Plugin."] = "Vous devez avoir un affichage Data Blocker pour voir ce plugin." -- Needs review
L["Zandalari"] = "Zandalari" -- Needs review

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "koKR")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "파티 구성 중..."
L["Call To Arms"] = "긴급 소집"
L["Cata"] = "대격변"
L["Clear the box to disable this."] = "기능을 사용하지 않으려면 선택 해제" -- Needs review
L["Click to open the dungeon finder."] = "클릭 던전 찾기 열기"
L["Completed in"] = "완료: "
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl 클릭 또는 마우스 가운데 클릭: 포탈"
L["D"] = "딜"
L["Data Broker"] = "데이터 브로커"
L["Display Type"] = "표시 형식"
L["DPS"] = "공격 담당"
L["Dungeon completed in"] = "던전 완료: "
L["Dungeon Helper: Bonus available!"] = "Dungeon Helper: 추가 보상 가능!"
L["End Message"] = "종료 메시지" -- Needs review
L["Find Group"] = "그룹 찾기"
L["General"] = "일반"
L["H"] = "힐"
L["Healer"] = "치유 담당"
L["hi"] = "안녕하세요" -- Needs review
L["Hide Minimap Button"] = "미니맵 버튼 숨김"
L["Hour"] = "시간"
L["Hours"] = "시간"
L["Icon Size"] = "아이콘 크기"
L["In Party"] = "파티 중"
L["Leave Party Dialog"] = "파티 떠나기 창" -- Needs review
L["Minute"] = "분"
L["Minutes"] = "분"
L["My estimated wait time:"] = "내 예상 대기 시간"
L["Options"] = "설정"
L["Play Alert"] = "시간 알림"
L["Play Bonus Sound"] = "추가 보상 가능 시 알림음 재생"
L["Play Invitation Sound"] = "파티 초대음 재생"
L["Play the selected Sound when the group is ready."] = "파티 준비 시 선택한 소리를 재생."
L["Queued for: "] = "유형:"
L["Raid completed in"] = "공격대 완료 " -- Needs review
L["Remaining"] = "남음"
L["Report Time to Party"] = "파티에 던전 완료 시간 알리기"
L["Report To Chat"] = "대화창에 표시"
L["Right-Click for options."] = "오른쪽 클릭: 설정"
L["Second"] = "초"
L["Seconds"] = "초"
L["Select Sound"] = "알림음 선택"
L["Sends a message to the party chat at the beginning of the dungeon."] = "인던 시작 시 파티창에 메시지 전송" -- Needs review
L["Sends a message to the party chat at the end of the dungeon."] = "인던 종료 후 파티창에 메시지 전송" -- Needs review
L["Shift-Click to open the raid finder."] = "Shift-클릭으로 공격대 찾기 창을 엽니다." -- Needs review
L["Short Text"] = "짧은 문자"
L["Show a leave party dialog at the end of a random dungeon."] = "무작위 던전이 끝나면 파티를 떠날 수 있는 창을 표시합니다." -- Needs review
L["Show Instance Name"] = "던전 이름 보기"
L["Show Time"] = "시간 보기" -- Needs review
L["Show Timer Bar"] = "시간 바 표시"
L["Show Wait Time"] = "대기 시간 보기"
L["Start Message"] = "시작 메시지" -- Needs review
L["T"] = "탱"
L["Tank"] = "방어 담당"
L["Teleport In/Out"] = "던전 안/밖으로 이동"
L["thanks, bb"] = "수고하셨습니다" -- Needs review
L["Time"] = "시간"
L["Waiting for:"] = "대기 시간:"
L["Wait time as:"] = "역할 별 대기 시간:"
L["Warning: Some of the sounds may depend on other addons."] = "경고: 몇가지 소리는 다른 애드온의 영향을 받습니다."
L["Watch"] = "알리기:" -- Needs review
L["Watch for Call To Arms (Bonus rewards) availability."] = "긴급 소집(추가 보상)이 가능할 때 알립니다." -- Needs review
L["You need to have a Data Broker Display to see this Plugin."] = "이 플러그인을 사용하려면 데이터 브로커 표시 애드온이 필요합니다."
L["Zandalari"] = "잔달라"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "zhTW")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "組成隊伍..."
L["Call To Arms"] = "戰爭的號角"
L["Cata"] = "浩劫與重生"
L["Clear the box to disable this."] = "清除此框停用該功能."
L["Click to open the dungeon finder."] = "點擊來開啟地城搜尋器。"
L["Completed in"] = "完成於"
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl+點擊 或 中鍵-點擊 傳送。"
L["D"] = "輸出"
L["Data Broker"] = "Data Broker"
L["Display Type"] = "顯示類型"
L["DPS"] = "傷害輸出"
L["Dungeon completed in"] = "地城完成於"
L["Dungeon Helper: Bonus available!"] = "地城助手：額外獎勵可用!"
L["End Message"] = "結束訊息"
L["Find Group"] = "尋找隊伍"
L["General"] = "一般"
L["H"] = "補"
L["Healer"] = "治療者"
L["hi"] = "你好"
L["Hide Minimap Button"] = "隱藏小地圖按鈕"
L["Hour"] = "小時"
L["Hours"] = "小時"
L["Icon Size"] = "圖示大小"
L["In Party"] = "在隊伍中"
L["Leave Party Dialog"] = "離開隊伍對話框"
L["Minute"] = "分"
L["Minutes"] = "分"
L["My estimated wait time:"] = "預計我的等待時間："
L["Options"] = "設定"
L["Play Alert"] = "播放警告"
L["Play Bonus Sound"] = "播放額外獎勵音效"
L["Play Invitation Sound"] = "播放邀請音效"
L["Play the selected Sound when the group is ready."] = "當隊伍準備好時播放選擇的音效。"
L["Queued for: "] = "排隊等待："
L["Raid completed in"] = "本次團隊副本用時"
L["Remaining"] = "剩餘"
L["Report Time to Party"] = "發佈時間到隊伍頻道"
L["Report To Chat"] = "發佈到聊天頻道"
L["Right-Click for options."] = "右鍵-點擊 開啟設定。"
L["Second"] = "秒"
L["Seconds"] = "秒"
L["Select Sound"] = "選擇音效"
L["Sends a message to the party chat at the beginning of the dungeon."] = "在地城開始時發送訊息到隊伍頻道。"
L["Sends a message to the party chat at the end of the dungeon."] = "在地城結束時發送訊息到隊伍頻道。"
L["Shift-Click to open the raid finder."] = "Shift+左鍵開啟團隊搜尋器"
L["Short Text"] = "簡短文字"
L["Show a leave party dialog at the end of a random dungeon."] = "在隨機地城結束時顯示離開隊伍對話框。"
L["Show Instance Name"] = "顯示地城名稱"
L["Show Time"] = "顯示時間"
L["Show Timer Bar"] = "顯示時間條"
L["Show Wait Time"] = "顯示等待時間"
L["Start Message"] = "開始訊息"
L["T"] = "坦"
L["Tank"] = "坦克"
L["Teleport In/Out"] = "傳送進/出"
L["thanks, bb"] = "謝謝，88"
L["Time"] = "計時"
L["Waiting for:"] = "已等待："
L["Wait time as:"] = "等待時間為："
L["Warning: Some of the sounds may depend on other addons."] = "警告：某些音效可能依賴於其他插件。"
L["Watch"] = "監視"
L["Watch for Call To Arms (Bonus rewards) availability."] = "監視戰爭的號角(額外獎勵)是否可用。"
L["You need to have a Data Broker Display to see this Plugin."] = "你必須要有Data Broker顯示插件才能看到該組件。"
L["Zandalari"] = "贊達拉"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "zhCN")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "队伍集结中..."
L["Call To Arms"] = "战斗的召唤"
L["Cata"] = "大地的裂变"
L["Clear the box to disable this."] = "清除该框体以禁用"
L["Click to open the dungeon finder."] = "点击后开启地下城查找器。"
L["Completed in"] = "完成用时"
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl-点击 或 中键-点击 传送"
L["D"] = "输出"
L["Data Broker"] = "Data Broker"
L["Display Type"] = "显示类型"
L["DPS"] = "伤害输出"
L["Dungeon completed in"] = "本次地下城用时"
L["Dungeon Helper: Bonus available!"] = "地下城助手:额外奖励可用!"
L["End Message"] = "结束信息"
L["Find Group"] = "寻找队伍"
L["General"] = "常规"
L["H"] = "奶"
L["Healer"] = "治疗"
L["hi"] = "大家好啊"
L["Hide Minimap Button"] = "隐藏小地图按钮"
L["Hour"] = "小时"
L["Hours"] = "小时"
L["Icon Size"] = "图标大小"
L["In Party"] = "在队伍中"
L["Leave Party Dialog"] = "离开小队对话框"
L["Minute"] = "分钟"
L["Minutes"] = "分钟"
L["My estimated wait time:"] = "预估等待时间:"
L["Options"] = "选项"
L["Play Alert"] = "播放警告"
L["Play Bonus Sound"] = "播放奖励音效"
L["Play Invitation Sound"] = "播放邀请音效"
L["Play the selected Sound when the group is ready."] = "当队伍准备就绪时播放选择的音效."
L["Queued for: "] = "排队等待:"
L["Raid completed in"] = "本次团队副本用时"
L["Remaining"] = "剩余"
L["Report Time to Party"] = "通告时间到队伍频道"
L["Report To Chat"] = "通告到聊天频道"
L["Right-Click for options."] = "右键-点击 打开选项"
L["Second"] = "秒"
L["Seconds"] = "秒"
L["Select Sound"] = "选择音效"
L["Sends a message to the party chat at the beginning of the dungeon."] = "在地下城开始时发送信息到小队频道。"
L["Sends a message to the party chat at the end of the dungeon."] = "在地下城结束时发送信息到小队频道。"
L["Shift-Click to open the raid finder."] = "Shift+左键打开地下城查找器"
L["Short Text"] = "简短的文字"
L["Show a leave party dialog at the end of a random dungeon."] = "随机地下城结束时显示离开小队对话框"
L["Show Instance Name"] = "显示地下城名称"
L["Show Time"] = "显示时间"
L["Show Timer Bar"] = "显示计时条"
L["Show Wait Time"] = "显示等待时间"
L["Start Message"] = "开始信息"
L["T"] = "坦"
L["Tank"] = "坦克"
L["Teleport In/Out"] = "传送进/出"
L["thanks, bb"] = "谢谢大家,( ^_^ )/~~拜拜"
L["Time"] = "计时"
L["Waiting for:"] = "已等待:"
L["Wait time as:"] = "（职责）等待时间:"
L["Warning: Some of the sounds may depend on other addons."] = "警告:部分音效可能依赖其他插件."
L["Watch"] = "监视"
L["Watch for Call To Arms (Bonus rewards) availability."] = "监视战斗的召唤(额外奖励)是否可用"
L["You need to have a Data Broker Display to see this Plugin."] = "你需要Data Broker显示插件来看到这个组件."
L["Zandalari"] = "赞达拉"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "ruRU")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "Формирование группы..."
L["Call To Arms"] = "Призыв к оружию"
L["Cata"] = "Ката"
L["Clear the box to disable this."] = "Очистите чтобы отключить."
L["Click to open the dungeon finder."] = "Нажмите, чтобы открыть поиск подземелий"
L["Completed in"] = "Пройдено за"
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl+клик или клик средней кнопкой для телепорта."
L["D"] = "Б"
L["Data Broker"] = "Data Broker"
L["Display Type"] = "Показать тип"
L["DPS"] = "УВС"
L["Dungeon completed in"] = "Подземелье пройдено за"
L["Dungeon Helper: Bonus available!"] = "Dungeon Helper: Бонус доступен!"
L["End Message"] = "Сообщение об окончании"
L["Find Group"] = "Поиск Группы"
L["General"] = "Общее"
L["H"] = "Л"
L["Healer"] = "Лекарь"
L["hi"] = "Привет всем!"
L["Hide Minimap Button"] = "Скрыть кнопку у миникарты"
L["Hour"] = "Час"
L["Hours"] = "Часов"
L["Icon Size"] = "Размер иконки"
L["In Party"] = "В Группе"
L["Leave Party Dialog"] = "Предложение покинуть группу"
L["Minute"] = "Минута"
L["Minutes"] = "Минут"
L["My estimated wait time:"] = "Моё время ожидания:"
L["Options"] = "Настройки"
L["Play Alert"] = "Проигрывать звук предупреждения"
L["Play Bonus Sound"] = "Проигрывать звук бонуса"
L["Play Invitation Sound"] = "Проигрывать звук приглашения"
L["Play the selected Sound when the group is ready."] = "Проигрывать выбранный звук, когда группа готова."
L["Queued for: "] = "В очереди:"
L["Raid completed in"] = "Рейд завершён за" -- Needs review
L["Remaining"] = "Осталось"
L["Report Time to Party"] = "Сказать время группе"
L["Report To Chat"] = "Вывести в чат"
L["Right-Click for options."] = "Правая кнопка мышки для настроек"
L["Second"] = "Секунда"
L["Seconds"] = "Секунд"
L["Select Sound"] = "Выбрать звук"
L["Sends a message to the party chat at the beginning of the dungeon."] = "Отсылает сообщение в групповой чат в начале подземелья."
L["Sends a message to the party chat at the end of the dungeon."] = "Отсылает сообщение в групповой чат в конце подземелья."
L["Shift-Click to open the raid finder."] = "Shift-ЛКМ чтобы открыть поиск рейда." -- Needs review
L["Short Text"] = "Короткий Текст"
L["Show a leave party dialog at the end of a random dungeon."] = "Показать предложение покинуть группу после прохождения рандом героика"
L["Show Instance Name"] = "Показывать название подземелья"
L["Show Time"] = "Показать время"
L["Show Timer Bar"] = "Показать полоску таймера"
L["Show Wait Time"] = "Показывать время ожидания"
L["Start Message"] = "Сообщение о начале"
L["T"] = "Т"
L["Tank"] = "Танк"
L["Teleport In/Out"] = "Перенестись в/из"
L["thanks, bb"] = "Всем спасибо, удачи!"
L["Time"] = "Время"
L["Waiting for:"] = "Ожидаем:"
L["Wait time as:"] = "Время ожидания:"
L["Warning: Some of the sounds may depend on other addons."] = "Предупреждение: Некоторые звуки могут быть зависимы от других аддонов."
L["Watch"] = "Следить"
L["Watch for Call To Arms (Bonus rewards) availability."] = "Следить за доступностью Призыва к оружию (бонусные награды)."
L["You need to have a Data Broker Display to see this Plugin."] = "Вам нужно иметь Data Broker Display чтобы видеть этот аддон."
L["Zandalari"] = "Зандалари"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "esES")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "Montando grupo..." -- Needs review
L["Call To Arms"] = "Llamada a las Armas" -- Needs review
L["Cata"] = "Cata" -- Needs review
L["Click to open the dungeon finder."] = "Click para abrir el buscador de mazmorras." -- Needs review
L["Completed in"] = "Completado en" -- Needs review
L["D"] = "D" -- Needs review
L["Data Broker"] = "Data Broker" -- Needs review
L["DPS"] = "Daño" -- Needs review
L["Dungeon completed in"] = "Mazmorra completada en" -- Needs review
L["Dungeon Helper: Bonus available!"] = "Ayudante de Mazmorra: ¡Bonus disponible!" -- Needs review
L["End Message"] = "Mensaje Final" -- Needs review
L["Find Group"] = "Buscar Grupo" -- Needs review
L["General"] = "General" -- Needs review
L["H"] = "S" -- Needs review
L["Healer"] = "Sanador" -- Needs review
L["hi"] = "hola" -- Needs review
L["Hide Minimap Button"] = "Ocultar Botón del Minimapa" -- Needs review
L["Hour"] = "Hora" -- Needs review
L["Hours"] = "Horas" -- Needs review
L["Icon Size"] = "Tamaño del Icono" -- Needs review
L["In Party"] = "En Grupo" -- Needs review
L["Minute"] = "Minuto" -- Needs review
L["Minutes"] = "Minutos" -- Needs review
L["My estimated wait time:"] = "Mi tiempo estimado de espera:" -- Needs review
L["Options"] = "Opciones" -- Needs review
L["Queued for: "] = "En cola para:" -- Needs review
L["Remaining"] = "Restante" -- Needs review
L["Report Time to Party"] = "Informar al grupo del tiempo" -- Needs review
L["Right-Click for options."] = "Click-Derecho para opciones." -- Needs review
L["Second"] = "Segundo" -- Needs review
L["Seconds"] = "Segundos" -- Needs review
L["Short Text"] = "Texto Corto" -- Needs review
L["Show Instance Name"] = "Mostrar Nombre de Instancia" -- Needs review
L["Show Time"] = "Mostrar Tiempo" -- Needs review
L["Show Timer Bar"] = "Mostrar Barra de Tiempo" -- Needs review
L["Show Wait Time"] = "Mostrar Tiempo de Espera" -- Needs review
L["Start Message"] = "Mensaje Inicial" -- Needs review
L["T"] = "T" -- Needs review
L["Tank"] = "Tanque" -- Needs review
L["Time"] = "Tiempo" -- Needs review
L["Waiting for:"] = "Esperando por:" -- Needs review
L["Wait time as:"] = "Tiempo de espera como:" -- Needs review
L["You need to have a Data Broker Display to see this Plugin."] = "Necesitas Data Broker Display para ver este Plugin." -- Needs review
L["Zandalari"] = "Zandalari" -- Needs review

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "esMX")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	
	return
end

local L = AceLocale:NewLocale("DungeonHelper", "ptBR")
if L then
	-- disable default party messages until localization is set
	L["hi"] = ""
	L["thanks, bb"] = ""
	L["Assembling group..."] = "Montando o grupo..."
L["Call To Arms"] = "Chamado às Armas"
L["Cata"] = "Cata"
L["Clear the box to disable this."] = "Limpe a caixa para desativar isto."
L["Click to open the dungeon finder."] = "Clique para abrir o Localizador de Masmorras"
L["Completed in"] = "Completada em:"
L["Ctrl-Click or Middle-Click Teleport."] = "<Ctrl+Botão esquerdo do mouse> ou <Botão do meio do mouse> para teleportar"
L["D"] = "D"
L["Data Broker"] = "Data Broker"
L["Display Type"] = "Mostrar o tipo"
L["DPS"] = "DANO"
L["Dungeon completed in"] = "Masmorra completada em:"
L["Dungeon Helper: Bonus available!"] = "Localizador de Masmorras: Bônus disponível!"
L["End Message"] = "Mensagem no final"
L["Find Group"] = "Procurando grupo"
L["General"] = "Geral"
L["H"] = "C"
L["Healer"] = "CURA"
L["hi"] = "Oi"
L["Hide Minimap Button"] = "Esconder o botão do Minimapa"
L["Hour"] = "Hora"
L["Hours"] = "Horas"
L["Icon Size"] = "Tamanho do ícone"
L["In Party"] = "Em grupo"
L["Leave Party Dialog"] = "Sair do grupo"
L["Minute"] = "Minuto"
L["Minutes"] = "Minutos"
L["My estimated wait time:"] = "Tempo estimado:"
L["Options"] = "Opções"
L["Play Alert"] = "Tocar alerta"
L["Play Bonus Sound"] = "Tocar som bônus"
L["Play Invitation Sound"] = "Tocar som quando for invitado"
L["Play the selected Sound when the group is ready."] = "Tocar o som selecionado quando o grupo estiver pronto"
L["Queued for: "] = "Na fila para:"
L["Raid completed in"] = "Raid completada em" -- Needs review
L["Remaining"] = "Remanescente"
L["Report Time to Party"] = "Falar o tempo para o grupo"
L["Report To Chat"] = "Reportar para o Chat"
L["Right-Click for options."] = "<Botão direito do mouse> opções"
L["Second"] = "Segundo"
L["Seconds"] = "Segundos"
L["Select Sound"] = "Selecionar som"
L["Sends a message to the party chat at the beginning of the dungeon."] = "Mandar uma mensagem para o grupo no começo da Masmorra."
L["Sends a message to the party chat at the end of the dungeon."] = "Mandar uma mensagem para o grupo no final da Masmorra."
L["Shift-Click to open the raid finder."] = "Shift+Clique para abrir o Localizador de Raides" -- Needs review
L["Short Text"] = "Texto curto"
L["Show a leave party dialog at the end of a random dungeon."] = "Mostrar Sair do grupo no final da Masmorra Aleatória."
L["Show Instance Name"] = "Mostrar nome da Masmorra"
L["Show Time"] = "Mostrar tempo"
L["Show Timer Bar"] = "Mostrar barra com o tempo"
L["Show Wait Time"] = "Mostrar tempo de espera:"
L["Start Message"] = "Mensagem no começo"
L["T"] = "T"
L["Tank"] = "TANQUE"
L["Teleport In/Out"] = "Teleportar para dentro/fora"
L["thanks, bb"] = "Obrigado"
L["Time"] = "Tempo"
L["Waiting for:"] = "Esperando por:"
L["Wait time as:"] = "Tempo de espera para:"
L["Warning: Some of the sounds may depend on other addons."] = "Cuidado: Alguns sons dependem de outros addons."
L["Watch"] = "Esperar"
L["Watch for Call To Arms (Bonus rewards) availability."] = "Esperar por Chamado às Armas (Recompensas) disponíveis."
L["You need to have a Data Broker Display to see this Plugin."] = "Você precisa ter um Data Broker Display para ver este plugin."
L["Zandalari"] = "Zandalari"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "itIT")
if L then
	
	return
end