--[[
************************************************************************
Project				: Broker_Factions
Author				: zhinjio
Project Revision	: 3.2.5-release
Project Date		: 20110515000702

File				: Locales\koKR.lua
Commit Author		: zhinjio
Commit Revision		: 4
Commit Date			: 20110503035214
************************************************************************
Description	:
	Korean translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BFactions"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "koKR" )
if not L then return end

L["%s to go"] = "%s 남음"
L["Activates and displays a scrolling slider bar, for the tooltip."] = "툴팁을 위한 스크롤 슬라이드바를 표시하고 활성화합니다."
L["Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."] = "축소된 진영의 항목에 '+' 꼬리표 접미사를 표시합니다(축소된 항목 표시를 한 경우)."
L["Appends faction standing, to the button label."] = "버튼 표시에 진영 관계를 추가합니다."
L["Appends percentage values to the button label."] = "버튼 표시에 퍼센트 값을 추가합니다."
L["Appends raw numbers in the form of (xxx/xxxx), to the button label."] = "버튼 표시에 평판 숫자를 (xxx/xxxx) 형식으로 추가합니다."
L["Appends remaining reputation to reach the next standing, to the button label."] = "버튼 표시에 다음 관계 갱신까지 남은 평판을 추가합니다."
L["Appends session reputation gains in the form of [xxx], to the button label."] = "버튼 표시에 평판 얻은 증감량을 [xxx] 형식으로 추가합니다."
L["Author : "] = "제작자:" -- Needs review
L["Auto faction watch on reputation gains"] = "자동으로 평판을 얻은 진영 보기"
L["Automatically sets the faction watched on the button/block to the last faction you gained reputation with."] = "자동적으로 당신이 마지막으로 획득한 평판의 진영으로 버튼/블럭에 보여주도록 설정합니다."
L["Build Date : "] = "만든 날:" -- Needs review
L["Button"] = "버튼"
L["Change color of percentages/raw numbers/'to go' according to faction reputation standing."] = "진영의 평판 관계에 따라 퍼센트/평판 숫자/남은 평판의 색상이 변합니다."
-- L["Click header lines to expand/contract"] = "Click header lines to expand/contract"
L["Colorize faction statistics"] = "진영 통계 자료 색상화"
L["Ctrl+Left Click"] = "Ctrl+좌-클릭"
-- L["DISPLAY_DEBUG_DESC"] = "Checked to display DEBUG information"
-- L["DISPLAY_HIDEEXALTED_DESC"] = "Check to hide Exalted factions in the tooltip"
-- L["DISPLAY_OPTIONS_DESC"] = "Options that change the way data is displayed in the tooltip"
-- L["DISPLAY_SHOWCOLLAPSED_DESC"] = "Check to display collapsed headers"
L["DISPLAY_SHOWGAINS_DESC"] = "선택하면 현재 접속에서 얻은 평판을 표시합니다." -- Needs review
L["DISPLAY_SHOWHINTS_DESC"] = "선택하면 툴팁 도움말을 표시합니다." -- Needs review
L["DISPLAY_SHOWPERC_DESC"] = "선택하면 백분율로 표시합니다." -- Needs review
-- L["DISPLAY_SHOWRAW_DESC"] = "Check to display raw values"
-- L["DISPLAY_SHOWREMAIN_DESC"] = "Check to display remaining rep to next level"
L["Database Version : "] = "데이터베이스 버전:" -- Needs review
L["Database upgraded to %s"] = "데이터베이스가 %s로 버전업 되었습니다." -- Needs review
L["Display Debug"] = "표시 디버그" -- Needs review
L["Display Options"] = "표시 설정" -- Needs review
L["Draws the icon on the minimap."] = "미니맵에 아이콘을 표시합니다." -- Needs review
L["Enable Scrolling"] = "스크롤 사용"
L["Exalted"] = "확고한 동맹" -- Needs review
L["Faction"] = "진영"
L["Faction Monitoring"] = "진영 모니터링"
L["Faction index not yet initialized !"] = "진영 목차가 아직 초기화되지 않았습니다!"
L["Friendly"] = "우호적" -- Needs review
L["GENERAL_INFO_DESC"] = "버전 및 제작자 정보" -- Needs review
L["General"] = "일반"
L["General Information"] = "일반 정보" -- Needs review
-- L["Hated"] = "Hated"
L["Helpful Translators (thank you) : %s"] = "도움을 준 번역자: %s" -- Needs review
L["Hidden Faction"] = "숨겨진 진영"
L["Hide Exalted Factions"] = "확고한 동맹 진영 숨김"
L["Hide Hint Text"] = "도움말 숨김" -- Needs review
L["Hide Monitored Faction"] = "모니터된 진영 숨김"
L["Hides faction text from the button."] = "버튼에서 진영 문구를 숨깁니다."
L["Hides factions with Exalted standing, from the tooltip."] = "툴팁에서 확고한 동맹 관계의 진영을 숨깁니다."
L["Hides the tooltip information/hint text."] = "툴팁에 도움말을 숨깁니다." -- Needs review
-- L["Honored"] = "Honored"
-- L["Hostile"] = "Hostile"
L["Ignore Exalted factions"] = "확고한 동맹 진영 무시"
L["Ignore negative reputation gains"] = "적대적인 평판 얻기 무시"
L["Inactive"] = "비활성" -- Needs review
L["Inactive Faction"] = "비활성 진영"
L["Inserts a new tooltip column, showing faction standing."] = "새로 툴팁에 분류하여 진영 관계를 보이게 삽입합니다."
L["Inserts a new tooltip column, showing remaining reputation to reach the next standing."] = "새로 툴팁에 분류하여 다음 관계 갱신까지 남은 평판을 보이게 삽입합니다."
L["Inserts a new tooltip column, showing reputation percentage values."] = "새로 툴팁에 분류하여 평판 퍼센트 값을 보이게 삽입합니다."
L["Inserts a new tooltip column, showing reputation raw numbers in the form of 'xxx/xxxx'."] = "새로 툴팁에 분류하여 평판 숫자를 'xxx/xxxx' 형식으로 보이게 삽입합니다."
L["Inserts a new tooltip column, showing session reputation gains in the form of 'xxx'."] = "툴팁에 평판을 얻은 증감량을 'xxx' 형식으로 보이게 삽입합니다."
L["Left Click"] = "왼쪽 클릭" -- Needs review
-- L["Left-click faction lines to set watched faction"] = "Left-click faction lines to set watched faction"
L["MINIMAP_OPTIONS_DESC"] = "미니맵 아이콘에 관한 설정입니다." -- Needs review
L["MISCDISPLAY_OPTIONS_DESC"] = "기타 설정" -- Needs review
L["Minimalistic LDB plugin that allows simple faction reputation monitoring."] = "간단히 진영 평판을 모니터링 해주는 조그만 LDB 플러그인 입니다."
L["Minimap Icon Options"] = "미니맵 아이콘 설정" -- Needs review
L["Miscellaneous Display Options"] = "기타 표시 설정" -- Needs review
L["Move the slider to adjust scaling for the tooltip."] = "슬라이더를 이동하여 툴팁의 크기를 조절합니다."
L["Neutral"] = "중립적" -- Needs review
L["No Faction"] = "진영 없음"
L["Raw"] = "평판"
-- L["Remaining"] = "Remaining"
L["Rep"] = "평판" -- Needs review
L["Reputation with (.*) decreased"] = "(.+)에 대한 평판이 (%d+)만큼 하락했습니다."
L["Reputation with (.*) increased"] = "(.+)에 대한 평판이 (%d+)만큼 상승했습니다."
L["Reset Session Gains"] = "얻은 증감량 초기화"
L["Resets the reputation session gain counters."] = "평판을 얻은 증감량 숫자를 초기화합니다."
-- L["Revered"] = "Revered"
L["Right Click"] = "오른쪽 클릭" -- Needs review
-- L["Right-click for Configuration"] = "Right-click for Configuration"
-- L["Select Faction to Watch"] = "Select Faction to Watch"
L["Select a faction to watch on the button/block."] = "버튼/블럭에 보여질 진영을 선택하세요."
L["Session"] = "증감"
L["Sets the faction watched on the button/block to the faction set in the character's reputation tab."] = "케릭터의 평판창에 설정한 진영을 버튼/블럭에 진영을 표시되도록 설정합니다."
L["Sets the tooltip maximum height, after which it will be scrollable."] = "툴팁을 최대 높이로 설정하며, 나중에 이것은 스크롤되어질 것입니다."
L["Shift+Left Click"] = "Shift+좌-클릭"
L["Show Collapsed Header Suffix"] = "축소된 항목에 접미사 표시"
L["Show Collapsed Headers"] = "축소된 항목 표시"
L["Show Hint Lines"] = "도움말 표시" -- Needs review
L["Show Minimap Icon"] = "미니맵 아이콘 표시" -- Needs review
L["Show Percentage"] = "백분율 표시" -- Needs review
L["Show Percentages"] = "퍼센트 보기"
L["Show Raw Numbers"] = "평판 숫자 보기"
-- L["Show Raw Values"] = "Show Raw Values"
-- L["Show Remaining"] = "Show Remaining"
L["Show Reputation To Go"] = "남은 평판 보기"
L["Show Session Gains"] = "얻은 증감량 보기"
L["Show Standing"] = "관계 보기"
-- L["Show Text"] = "Show Text"
L["Status"] = "상태"
-- L["TEXT_FACTIONWATCH_DESC"] = "Select the faction to display on the LDB Display"
-- L["TEXT_OPTIONS_DESC"] = "Options regarding the text on the LDB Display"
-- L["TEXT_SHOWGAINS_DESC"] = "Check to show session gains on the LDB Display"
-- L["TEXT_SHOWPERC_DESC"] = "Check to show percentage on the LDB Display"
-- L["TEXT_SHOWRAW_DESC"] = "Check to show raw values on the LDB Display"
-- L["TEXT_SHOWREMAIN_DESC"] = "Check to show remaining reputation on the LDB Display"
-- L["TEXT_SHOW_DESC"] = "Check to show text on the LDB Display"
-- L["TOOLTIPDISPLAY_OPTIONS_DESC"] = "Options regarding what is displayed in the tooltip"
L["TOOLTIP_DELAY_DESC"] = "툴팁에서 마우스를 뗄 때 툴팁이 사라지는 시간을 변경합니다." -- Needs review
L["TOOLTIP_SCALE_DESC"] = "툴팁의 크기를 슬라이드로 변경합니다." -- Needs review
-- L["Text Options"] = "Text Options"
L["To Go"] = "남음"
L["Toggles display of collapsed faction headers (normally hidden), on the tooltip."] = "툴팁에 (순리적으로 숨겨진) 축소된 진영의 항목을 표시/표시 안함."
L["Tooltip"] = "툴팁"
L["Tooltip Auto-hide Delay"] = "툴팁 자동숨김 지연시간" -- Needs review
L["Tooltip Display Options"] = "툴팁 표시 설정" -- Needs review
L["Tooltip Maximum Height"] = "툴팁 최대 높이"
L["Tooltip Scale"] = "툴팁 크기"
L["Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."] = "이 설정을 사용하면 당신이 확고한 동맹이 되었을 때 더이상 해당 진영으로 자동 전환이 되지 않을 것입니다."
L["Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."] = "이 설정을 사용하면 적대적인 평판을 얻었을 때 버튼/블럭이 자동 전환되는 것을 방지합니다."
-- L["Unfriendly"] = "Unfriendly"
L["Unknown Faction"] = "알 수 없는 진영"
L["Use Blizzard's faction watch"] = "블리자드 진영 표시 사용"
-- L["Values"] = "Values"
L["Version : "] = "버전:" -- Needs review
L["You are now (%a+) with (.*)%."] = "(.+)에 대해 (.+) 평판이 되었습니다."
-- L["on faction header to expand or collapse it."] = "on faction header to expand or collapse it."
-- L["on faction name to watch on the button/block."] = "on faction name to watch on the button/block."
-- L["on plugin to open Blizzard's Reputation tab."] = "on plugin to open Blizzard's Reputation tab."
-- L["on plugin to open Configuration Menu."] = "on plugin to open Configuration Menu."
L["to paste Reputation info into chat."] = "대화창에 평판 정보 붙여넣기."
L["to toggle Reputation bar watch."] = "경험치바에 표시/표시 안함."


--[[
************************************************************************
CHANGELOG:

Date : 04/05/11
	initial version
************************************************************************
]]--