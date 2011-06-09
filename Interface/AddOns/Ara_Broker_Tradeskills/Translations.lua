--[[

-- misc / UI
"Cooldowns",		"",
"|cff20ff20Ready!|r",	"",
"d",			"", -- abrev. for "day"
"h",			"", -- abrev. for "hour"
"m",			"", -- abrev. for "minute"
"s",			"", -- abrev. for "seconde"

"Hints",		"",
"Belongs to:",		"",
"Set an alias for \"%s\".\nLeave blank to reset.",	"",

"|cffff8020Click|r to craft.",	"",
"|cffff8020Right-Click|r to show CD in panel.",	"",
"|cffff8020Click|r to show CD in panel.",	"",
"|cffff8020Control+Click|r to set an alias.",	"",
"|cffff8020Click|r to toggle panel.",		"",
"|cffff8020Right-Click|r to scan for CDs.",	"",
"|cffff8020Middle-Click|r to remove from list.","",

"Include |cff20ff20Ready!|r CDs when scanning",	"",
"Show hints",			"",
"Colors",			"",
"Header",			"",
"Interactive skill name",	"",
"Last selected skill",		"",
"Informative skill name",	"",
"Player CD",			"",
"Other player CD",		"",
"Highlight",			"",

-- ADDED in r6:
"Show alt. skills",	"",

-- ADDED in r7-14:
"Remove an alt.",				"",
"|cff8080ff%s|r has been removed.",		"", -- %s: character's name
"Display number of Ready CD",			"",
"Shortcuts",					"",
"|cffff8040Click|r to create a shortcut.",	"",
"|cff8080ff%s|r|cffffff00 added to shortcuts.",	"", -- %s: tradeskill's name
"|cffff8020Right-Click|r to show in panel.",	"",

-- ADDED in r25:
"No link available. Open a character\ntradeskill panel to be able to access\nit from your other characters.", "",
"|cffff8020Shift+Click|r to link in chat.", "",

-- ADDED in r30:
"Tracking...",		"",

-- ADDED in r31:
-- previously "Show alt. primary skills only" but it's now in a submenu, and "show alt. skills" is implicite
"Primary only",			"",
"With a craft window only",	"",
"|cffff8020Shift+Click|r to craft all.", "",

-- ADDED in r32:
"Restore default colors",	"",
"Tooltip size",			"",
"Set tooltip scale.\nEnter a value between 70 and 200 (%%).", "",
"Invalid scale.\nShould be a number between 70 and 200%", "",
"Custom...",			"",

-- ADDED in r34:
"|cffff8020Click|r to track.",	"",
"Auto",	"",

-- ADDED in r35:
"|cffff4040Reagents!|r",	"",

-- ADDED in r37:
"Hints [|cffffffffBlock|r]",			"",
"|cffff8020Click|r to toggle panel.",		"",
"|cffff8020Right-Click|r to show config menu.",	"",
--"Silently open/close panels",			"",

-- ADDED in r38:
"Alt list break mode",	"",
"After 5th",		""

--]]

local _, L = ...

local function SetTranslations(...)
	for i=1, select("#",...), 2 do
		local k,v = select(i,...)
		L[k] = v
	end
end

SetTranslations(
	"Alchemy",		GetSpellInfo(2259),
	"Archaeology",		GetSpellInfo(78670),
	"Blacksmithing",	GetSpellInfo(2018),
	"Cooking",		GetSpellInfo(2550),
	"Enchanting",		GetSpellInfo(7411),
	"Engineering",		GetSpellInfo(4036),
	"First Aid",		GetSpellInfo(3273),
	"Fishing",		GetSpellInfo(7620),
	"Herbalism",		GetSpellInfo(13614),
	"Inscription",		GetSpellInfo(45357),
	"Jewelcrafting",	GetSpellInfo(25229),
	"Leatherworking",	GetSpellInfo(2108),
--	"Lockpicking",		GetSpellInfo(1809),
	"Mining",		GetSpellInfo(2575),
	"Runeforging",		GetSpellInfo(53428),
	"Skinning",		GetSpellInfo(8613),
	"Smelting",		GetSpellInfo(2656),
	"Tailoring",		(GetSpellInfo(3908))
)

local l = GetLocale()
if l == "frFR" then
	SetTranslations(
	-- Special case where names doesnt match (like Mining --> Smelting):
	-- The skill window display "Runeforger" whereas the spell returned by GetSpellInfo is "Runeforge".
	--	"SmeltingDN",		"Mining",	***SAMPLE***
		"RuneforgingDN",	"Runeforger",

		"Cooldowns",		nil,
		"|cff20ff20Ready!|r",	"|cff20ff20Prêt!|r",
		"d",			"j",

		"Hints",		"Notice",
		"Belongs to:",		"Appartient à:",
		"Set an alias for \"%s\".\nLeave blank to reset.", "Définissez un alias pour \"%s\".\nLaissez vide pour revenir au nom d'origine.",

		"|cffff8020Click|r to craft.",			"|cffff8020Click|r pour craft.",
		"|cffff8020Right-Click|r to show CD in panel.",	"|cffff8020Click-Droit|r affiche la page du CD.",
		"|cffff8020Click|r to show CD in panel.",	"|cffff8020Click|r pour aller au CD.",
		"|cffff8020Control+Click|r to set an alias.",	"|cffff8020Control+Click|r pour définir un alias.",
		"|cffff8020Click|r to toggle panel.",		"|cffff8020Click|r pour ouvrir/fermer le panneau.",
		"|cffff8020Right-Click|r to scan for CDs.",	"|cffff8020Click-Droit|r pour chercher des CDs.",
		"|cffff8020Middle-Click|r to remove from list.","|cffff8020Click-Molette|r pour retirer de la liste.",

		"Include |cff20ff20Ready!|r CDs when scanning",	"Inclure les CDs |cff20ff20Prêt!|r pendant la recherche",
		"Show hints",			"Afficher la notice",
		"Colors",			"Couleurs",
		"Header",			"En-tête de catégorie",
		"Interactive skill name",	"Nom de compétence interactive",
		"Last selected skill",		"Dernière compétence selectionnée",
		"Informative skill name",	"Nom de compétence passive",
		"Player CD",			"CD du personnage actuel",
		"Other player CD",		"CD d'un autre personnage",
		"Highlight",			"Surbrillance",

		-- ADDED in r6:
		"Show alt. skills",		"Afficher les compétences des rerolls.",
		-- ADDED in r7-14:
		"Remove an alt.",		"Supprimer les info d'un reroll.",
		"|cff8080ff%s|r has been removed.",		"|cff8080ff%s|r a été supprimé.",
		"Display number of Ready CD",			"Afficher le nombre de CD prêt.",
		"Shortcuts",					"Raccourcis",
		"|cffff8040Click|r to create a shortcut.",	"|cffff8040Click|r pour créer un raccourcis.",
		"|cff8080ff%s|r|cffffff00 added to shortcuts.",	"Raccourcis |cff8080ff%s|cffffff00 ajouté.",
		"|cffff8020Right-Click|r to show in panel.",	"|cffff8020Click-Droit|r pour y aller."
	)
--elseif l == "deDE" then
--	SetTranslations(
--	)
--elseif l == "zhCN" then
--	SetTranslations(  )
elseif l == "zhTW" then
-- weapon skills
	SetTranslations(
-- misc / UI
		"Cooldowns",		"冷卻狀態",
		"|cff20ff20Ready!|r",	"|cff20ff20已就緒!|r",
		"d",			"天",
		"h",			"時",
		"m",			"分",
		"s",			"秒",

		"Hints",		"提示",
		"Belongs to:",		"屬於",
		"Set an alias for \"%s\".\nLeave blank to reset.",	"為 \"%s\" 建立別名。\n留下空白恢復預設",

		"|cffff8020Click|r to craft.",			"|cffff8020點擊|r 製作此項目。",
		"|cffff8020Right-Click|r to show CD in panel.",	"|cffff8020右鍵|r 開啟技能窗口。",
		"|cffff8020Click|r to show CD in panel.",	"|cffff8020點擊|r 在面板視窗中顯示該項冷卻。",
		"|cffff8020Control+Click|r to set an alias.",	"|cffff8020Ctrl+點擊|r 建立別名。",
		"|cffff8020Click|r to toggle panel.",		"|cffff8020點擊|r 開啟技能視窗。",
		"|cffff8020Right-Click|r to scan for CDs.",	"|cffff8020右鍵|r 掃描冷卻時間。",
		"|cffff8020Middle-Click|r to remove from list.","|cffff8020中鍵|r 移除該項目。",
		"|cffff8020Shift+Click|r to link in chat.",	"|cffff8020Shift+點擊|r 建立專業技能連結。",

		"Include |cff20ff20Ready!|r CDs when scanning",	"當掃描時，包含|cff20ff20已就緒!|r的冷卻",
		"Show hints",			"提示訊息",
		"Colors",			"色彩",
		"Header",			"標題",
		"Interactive skill name",	"交易技能名稱",
		"Last selected skill",		"最後點選技能",
		"Informative skill name",	"武器技能名稱",
		"Player CD",			"當前玩家冷卻",
		"Other player CD",		"分身角色冷卻",
		"Highlight",			"高亮",

		-- ADDED in r6:
		"Show alt. skills",	"顯示分身專業技能",

		-- ADDED in r7-14:
		"Remove an alt.",				"移除分身",
		"|cff8080ff%s|r has been removed.",		"|cff8080ff%s|r 已移除", -- %s: character's name
		"Display number of Ready CD",			"冷卻計數顯示",
		"Shortcuts",					"製作捷徑",
		"|cffff8040Click|r to create a shortcut.",	"|cffff8040點擊|r 建立捷徑。",
		"|cff8080ff%s|r|cffffff00 added to shortcuts.",	"|cff8080ff%s|r|cffffff00 捷徑已增加。", -- %s: tradeskill's name
		"|cffff8020Right-Click|r to show in panel.",	"|cffff8020右鍵|r 開啟技能窗口。",

		-- ADDED in r25:
		"No link available. Open a character\ntradeskill panel to be able to access\nit from your other characters.",
		"失效連結。\n需要重新存取角色的交易技能。",

		-- ADDED in r30:
		"Tracking...",		"追蹤...",

		-- ADDED in r31:
		-- Previously "Show alt. primary skills only" but it's now in a submenu
		--	where "show alt. skills" is implicite.
		"Primary only",					"僅主要技能",
		"With a craft window only",			"僅可製造類別",
		"|cffff8020Shift+Click|r to craft all.",	"|cffff8020Shift+點擊|r 全部製造。"
	)
elseif l == "koKR" then
-- KOREA by shwy73
-- Modified by mrgyver(강호미인 of KR-윈드러너) for WotLK, 09.05.24
-- weapon skills
	SetTranslations(
-- misc / UI
		"Cooldowns",		"재사용 대기시간",
		"|cff20ff20Ready!|r",	"|cff20ff20준비 완료!|r",
		"d",			"일",
		"h",			"시간",
		"m",			"분",
		"s",			"초",

		"Hints",		"도움말",
		"Belongs to:",		"해당 캐릭터:",
		"Set an alias for \"%s\".\nLeave blank to reset.",	"\"%s\"에 대한 별칭 설정.\n빈 공백으로 초기화.",

		"|cffff8020Click|r to craft.",			"|cffff8020클릭|r 으로 만들기.",
		"|cffff8020Right-Click|r to show CD in panel.",	"|cffff8020우-클릭|r 으로 쿨다운 패널 보기.",
		"|cffff8020Click|r to show CD in panel.",	"|cffff8020클릭|r 으로 쿨다운 패널 보기.",
		"|cffff8020Control+Click|r to set an alias.",	"|cffff8020컨트롤-클릭|r 으로 별칭 설정",
		"|cffff8020Click|r to toggle panel.",		"|cffff8020클릭|r 으로 패널 토글.",
		"|cffff8020Right-Click|r to scan for CDs.",	"|cffff8020우-클릭|r 으로 쿨다운 스캔 하기.",
		"|cffff8020Middle-Click|r to remove from list.","|cffff8020중-클릭|r 으로 목록 제거.",

		"Include |cff20ff20Ready!|r CDs when scanning",	"쿨다운 스캐닝때 |cff20ff20준비 완료!|r 포함",
		"Show hints",			"도움말 보기",
		"Colors",			"색상",
		"Header",			"해더",
		"Interactive skill name",	"스킬 이름",
		"Last selected skill",		"마지막 선택 스킬",
		"Informative skill name",	"무기 스킬 이름",
		"Player CD",			"캐릭터 쿨다운",
		"Other player CD",		"다른 캐릭터 쿨다운",
		"Highlight",			"강조",

	-- ADDED in r6:
		"Show alt. skills",	"다른 케릭 전문(보조)기술 보기",

	-- ADDED in r7-14:
		"Remove an alt.",				"다른 케릭 제거하기",
		"|cff8080ff%s|r has been removed.",		"|cff8080ff%s|r 제거하기", -- %s: character's name
		"Display number of Ready CD",			"준비완료된 쿨다운의 갯수 표시",
		"Shortcuts",					"간단하게",
		"|cffff8040Click|r to create a shortcut.",	"|cffff8040클릭|r하면 간단하게 만들어 집니다.",
		"|cff8080ff%s|r|cffffff00 added to shortcuts.",	"|cff8080ff%s|r|cffffff00 간단하게 추가", -- %s: tradeskill's name
		"|cffff8020Right-Click|r to show in panel.",	"|cffff8020우-클릭|r으로 패널보기"
)
end