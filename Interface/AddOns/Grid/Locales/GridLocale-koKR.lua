--[[--------------------------------------------------------------------
	Grid Localization
	koKR | Korean | 한국어
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "디버그"
L["Debugging"] = "디버깅"
L["Hide minimap icon"] = "미니맵 아이콘 숨김"
L["Module debugging menu."] = "모듈 디버깅 메뉴를 설정합니다."
L["Toggle debugging for %s."] = "%s|1을;를; 위해 디버깅을 사용합니다."

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "글꼴 외각선을 조정합니다."
L["Adjust the font settings"] = "글꼴 설정을 조정합니다."
L["Adjust the font size."] = "글꼴 크기를 조정합니다."
L["Adjust the height of each unit's frame."] = "각 유닛의 창 높이를 조정합니다."
L["Adjust the size of the border indicators."] = "테두리 지시기의 크기를 조정합니다."
L["Adjust the size of the center icon's border."] = "중앙 아이콘의 테두리 크기를 조정합니다."
L["Adjust the size of the center icon."] = "중앙 아이콘의 크기를 조정합니다."
L["Adjust the size of the corner indicators."] = "모서리 지시기의 크기를 조정합니다."
L["Adjust the texture of each unit's frame."] = "각 유닛의 창 무늬를 조정합니다."
L["Adjust the width of each unit's frame."] = "각 유닛의 창 너비를 조정합니다."
L["Always"] = "항상"
L["Bar Options"] = "바 옵션"
L["Border"] = "테두리"
L["Border Size"] = "테두리 크기"
L["Bottom Left Corner"] = "좌측 하단 모서리"
L["Bottom Right Corner"] = "우측 하단 모서리"
L["Center Icon"] = "중앙 아이콘"
L["Center Text"] = "중앙 문자"
L["Center Text 2"] = "중앙 문자 2"
L["Center Text Length"] = "중앙 문자 길이"
L["Corner Size"] = "모서리 크기"
L["Enable %s"] = "%s|1을;를; 사용"
L["Enable %s indicator"] = "%s 지시기 사용"
L["Enable Mouseover Highlight"] = "마우스오버 강조 사용"
L["Font"] = "글꼴"
L["Font Outline"] = "글꼴 외각선"
L["Font Shadow"] = "글꼴 그림자"
L["Font Size"] = "글꼴 크기"
L["Frame"] = "창"
L["Frame Alpha"] = "창 투명도"
L["Frame Height"] = "창 높이"
L["Frame Texture"] = "창 무늬"
L["Frame Width"] = "창 너비"
L["Healing Bar"] = "치유 바"
L["Healing Bar Opacity"] = "치유 바 투명도"
L["Health Bar"] = "생명력 바"
L["Health Bar Color"] = "생명력 바 색상"
L["Horizontal"] = "가로"
L["Icon Border Size"] = "아이콘 테두리 크기"
L["Icon Cooldown Frame"] = "아이콘 재사용 창"
L["Icon Options"] = "아이콘 옵션"
L["Icon Size"] = "아이콘 크기"
L["Icon Stack Text"] = "아이콘 중첩 문자"
L["Indicators"] = "지시기"
L["Invert Bar Color"] = "바 색상 반대로"
L["Never"] = "안함"
L["None"] = "없음"
L["Number of characters to show on Center Text indicator."] = "중앙 문자 지시기 위에 표시할 캐릭터의 숫자를 설정합니다."
L["OOC"] = "비전투"
L["Options for %s indicator."] = "%s 지시기를 위한 옵션 설정합니다."
L["Options for GridFrame."] = "각 유닛 창의 표시를 위한 옵션을 설정합니다."
L["Options for assigning statuses to indicators."] = "지시기를 위한 옵션을 설정합니다."
L["Options related to bar indicators."] = "바 지시기 관련 옵션을 설정합니다."
L["Options related to icon indicators."] = "아이콘 지시기 관련 옵션을 설정합니다."
L["Options related to text indicators."] = "문자 지시기 관련 옵션을 설정합니다."
L["Orientation of Frame"] = "프레임의 방향"
L["Orientation of Text"] = "문자의 방향"
L["Set frame orientation."] = "생명력 결손량의 프레임 방향을 설정합니다."
L["Set frame text orientation."] = "프레임 문자의 방향을 설정합니다."
L["Sets the opacity of the healing bar."] = "치유 바의 투명도를 설정합니다."
L["Show Tooltip"] = "툴팁 표시"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "유닛 툴팁을 표시합니다. '항상', '안함' 또는 '비전투'을 선택합니다."
L["Statuses"] = "상태"
L["Swap foreground/background colors on bars."] = "바 위의 전경/배경 색상을 변경합니다."
L["Text Options"] = "문자 옵션"
L["Thick"] = "두껍게"
L["Thin"] = "얇게"
L["Throttle Updates"] = "조절판 업데이트"
L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = "그룹 변경에 대한 업데이트 시간(초)를 설정합니다."
L["Toggle center icon's cooldown frame."] = "중앙 아이콘에 재사용 창을 표시합니다."
L["Toggle center icon's stack count text."] = "중앙 아이콘에 중첩 갯수 문자를 표시합니다."
L["Toggle mouseover highlight."] = "마우스오버 강조를 사용합니다."
L["Toggle status display."] = "상태 표시 사용"
L["Toggle the %s indicator."] = "%s 지시기를 사용합니다."
L["Toggle the font drop shadow effect."] = "글꼴에 그림자 효과를 사용합니다."
L["Top Left Corner"] = "좌측 상단 모서리"
L["Top Right Corner"] = "우측 상단 모서리"
L["Vertical"] = "세로"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "10인 배치"
L["25 Player Raid Layout"] = "25인 공격대 배치"
L["Adjust Grid scale."] = "Grid 크기를 조정합니다."
L["Adjust background color and alpha."] = "배경의 색상과 투명도를 조정합니다."
L["Adjust border color and alpha."] = "테두리의 색상과 투명도를 조정합니다."
L["Adjust frame padding."] = "창 패팅을 조정합니다."
L["Adjust frame spacing."] = "창 간격을 조정합니다."
L["Advanced"] = "고급"
L["Advanced options."] = "고급 옵션을 설정합니다."
L["Allows mouse click through the Grid Frame."] = "배치 창 위의 마우스 클릭을 허락합니다."
L["Alt-Click to permanantly hide this tab."] = "영구적으로 Alt-클릭으로 이 탭을 숨깁니다."
L["Arena Layout"] = "투기장 배치"
L["Background color"] = "배경 색상"
L["Battleground Layout"] = "전장 배치"
L["Beast"] = "야수형"
L["Border Texture"] = "테두리 무늬"
L["Border color"] = "테두리 색상"
L["Bottom"] = "하단"
L["Bottom Left"] = "좌측 하단"
L["Bottom Right"] = "우측 하단"
L["By Creature Type"] = "창조물의 타입에 의해"
L["By Owner Class"] = "소환자의 직업에 의해"
L["Center"] = "중앙"
L["Choose the layout border texture."] = "배치 테두리의 무늬를 선택합니다."
L["Clamped to screen"] = "화면에 고정"
L["Class colors"] = "직업 색상"
L["Click through the Grid Frame"] = "창을 통해 클릭"
L["Color for %s."] = "%s 색상"
L["Color of pet unit creature types."] = "소환수 유닛 타입 색상을 설정합니다."
L["Color of player unit classes."] = "플레이어들의 유닛 색상을 설정합니다."
L["Color of unknown units or pets."] = "알수없는 유닛이나 소환수의 색상을 설정합니다."
L["Color options for class and pets."] = "직업과 소환수의 색상 옵션을 설정합니다."
L["Colors"] = "색상"
L["Creature type colors"] = "소환수 타입 색상"
L["Demon"] = "악마형"
L["Do not show the tab when Grid is unlocked."] = "Grid가 잠금 해제될 때 탭을 표시하지 않습니다."
L["Drag this tab to move Grid."] = "Grid를 이동시키려면 이 탭을 드래그합니다."
L["Dragonkin"] = "용족"
L["Elemental"] = "정령"
L["Fallback colors"] = "대체 색상"
L["Frame lock"] = "창 잠금"
L["Group Anchor"] = "그룹 위치"
L["Hide tab"] = "탭 숨김"
L["Horizontal groups"] = "그룹 정렬"
L["Humanoid"] = "인간형"
L["Layout"] = "배치"
L["Layout Anchor"] = "배치 위치"
L["Left"] = "좌측"
L["Lock Grid to hide this tab."] = "이 탭을 숨기려면 Grid를 잠급니다."
L["Locks/unlocks the grid for movement."] = "배치 창을 잠그거나 이동시킵니다."
L["Not specified"] = "알 수 없음"
L["Options for GridLayout."] = "배치 창과 그룹 배치를 위한 옵션을 설정합니다."
L["Padding"] = "패팅"
L["Party Layout"] = "파티 배치"
L["Pet color"] = "소환수 색상"
L["Pet coloring"] = "소환수 채색"
L["Reset Position"] = "위치 초기화"
L["Resets the layout frame's position and anchor."] = "배경 창의 위치와 앵커를 기본값으로 되돌립니다."
L["Right"] = "우측"
L["Scale"] = "크기"
L["Select which layout to use when in a 10 player raid."] = "10인 공격대시 사용할 배치를 선택합니다."
L["Select which layout to use when in a 25 player raid."] = "25인 공격대시 사용할 배치를 선택합니다."
L["Select which layout to use when in a battleground."] = "전장에서 사용할 배치를 선택합니다."
L["Select which layout to use when in a party."] = "파티시 사용할 배치를 선택합니다."
L["Select which layout to use when in an arena."] = "투기장에서 사용할 배치를 선택합니다."
L["Select which layout to use when not in a party."] = "솔로잉시 사용할 배치를 선택합니다."
L["Set the color of pet units."] = "소환수 유닛의 색상을 설정합니다."
L["Set the coloring strategy of pet units."] = "소환수의 유닛 채색 방법을 설정합니다."
L["Sets where Grid is anchored relative to the screen."] = "Grid의 화면 위치를 설정합니다."
L["Sets where groups are anchored relative to the layout frame."] = "그룹 배치 창의 위치를 설정합니다."
L["Show Frame"] = "창 표시"
L["Solo Layout"] = "솔로잉 배치"
L["Spacing"] = "간격"
L["Switch between horizontal/vertical groups."] = "그룹 표시 방법을 가로/세로로 변경합니다."
L["The color of unknown pets."] = "알수없는 소환수의 색상을 설정합니다."
L["The color of unknown units."] = "알수없는 유닛의 색상을 설정합니다."
L["Toggle whether to permit movement out of screen."] = "화면 밖으로 창이 나가지 않도록 사용합니다."
L["Top"] = "상단"
L["Top Left"] = "좌측 상단"
L["Top Right"] = "우측 상단"
L["Undead"] = "언데드"
L["Unknown Pet"] = "알수없는 소환수"
L["Unknown Unit"] = "알수없는 유닛"
L["Using Fallback color"] = "사용자의 색상에 의해"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "10인 직업별"
L["By Class 10 w/Pets"] = "10인 직업별, 소환수"
L["By Class 25"] = "25인 직업별"
L["By Class 25 w/Pets"] = "25인 직업별, 소환수"
L["By Group 10"] = "10인 공격대"
L["By Group 10 w/Pets"] = "10인 공격대, 소환수"
L["By Group 15"] = "15인 공격대"
L["By Group 15 w/Pets"] = "15인 공격대, 소환수"
L["By Group 25"] = "25인 공격대"
L["By Group 25 w/Pets"] = "25인 공격대, 소환수"
L["By Group 25 w/Tanks"] = "25인 공격대, 방어전담"
L["By Group 40"] = "40인 공격대"
L["By Group 40 w/Pets"] = "40인 공격대, 소환수"
L["By Group 5"] = "5인 공격대"
L["By Group 5 w/Pets"] = "5인 공격대, 소환수"
L["None"] = "없음"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "창을 잠그려면 왼쪽 버튼을 클릭하십시오."
L["Right-Click to open the options menu."] = "옵션 메뉴을 열려면 오른쪽 버튼을 클릭하십시오."

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "색상"
L["Color for %s"] = "%s 색상"
L["Enable"] = "사용"
L["Options for %s."] = "%s|1을;를; 위한 옵션을 설정합니다."
L["Priority"] = "우선 순위"
L["Priority for %s"] = "%s|1을;를; 위한 우선 순위"
L["Range filter"] = "범위 필터"
L["Range filter for %s"] = "%s|1을;를; 위한 거리 필터"
L["Reset class colors"] = "직업 색상 초기화"
L["Reset class colors to defaults."] = "직업 색상을 기본값으로 되돌립니다."
L["Status"] = "상태"
L["Status: %s"] = "상태: %s"
L["Text"] = "문자"
L["Text to display on text indicators"] = "문자 지시기 위에 표시할 문자."

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "어그로"
L["Aggro alert"] = "어그로 경고"
L["Aggro color"] = "어그로 색상"
L["Color for Aggro."] = "어그로일 때 색상"
L["Color for High Threat."] = "위협 수준 높을 때 색상"
L["Color for Tanking."] = "방어전담일 때 색상"
L["High"] = "높음"
L["High Threat color"] = "위협 수준 높음 색상"
L["Show more detailed threat levels."] = "상세한 위협 수준을 표시합니다."
L["Tank"] = "방전"
L["Tanking color"] = "방어전담 색상"
L["Threat"] = "위협 수준"

------------------------------------------------------------------------
--	GridStatusAuras

L["<buff name>"] = "<버프 이름>"
L["<debuff name>"] = "<디버프 이름>"
L["Add new Buff"] = "새로운 버프 추가"
L["Add new Debuff"] = "새로운 디버프 추가"
L["Adds a new buff to the status module"] = "상태 모듈에 새로운 버프를 추가합니다."
L["Adds a new debuff to the status module"] = "상태 모듈에 새로운 디버프를 추가합니다."
L["Auras"] = "효과"
L["Buff: %s"] = "버프: %s"
L["Class Filter"] = "직업 필터"
L["Curse"] = "저주"
L["Debuff type: %s"] = "디버프 타입: %s"
L["Debuff: %s"] = "디버프: %s"
L["Delete (De)buff"] = "(디)버프 삭제"
L["Deletes an existing debuff from the status module"] = "기존의 디버프를 상태 모듈에서 삭제합니다."
L["Disease"] = "질병"
L["Display status only if the buff is not active."] = "버프가 사라졌을 경우에만 상태에 표시합니다."
L["Display status only if the buff was cast by you."] = "당신이 버프를 시전했을 경우에만 상태에 표시합니다."
L["Ghost"] = "유령"
L["Magic"] = "마법"
L["Poison"] = "독"
L["Remove %s from the menu"] = "메뉴에서 %s|1을;를; 제거합니다."
L["Show duration"] = "지속시간 표시"
L["Show if mine"] = "내것 표시"
L["Show if missing"] = "사라짐 표시"
L["Show on %s."] = "%s 표시"
L["Show status for the selected classes."] = "선택된 직업을 위해 상태에 표시합니다."
L["Show the time remaining, for use with the center icon cooldown."] = "중앙 아이콘에 남은 시간의 재사용 대기시간을 표시합니다."

------------------------------------------------------------------------
--	GridStatusHeals

L["Heals"] = "치유"
L["Ignore Self"] = "자신 무시"
L["Ignore heals cast by you."] = "자신의 치유 시전은 무시합니다."
L["Incoming heals"] = "치유 받음"
L["Minimum Value"] = "최소값"
L["Only show incoming heals greater than this amount."] = "받는 치유가 이 값보다 클 경우만 표시합니다."

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "직업에 기준을 둔 결손 색상을 사용합니다."
L["Color health based on class."] = "직업에 기준을 둔 생명력 색상을 사용합니다."
L["DEAD"] = "죽음"
L["Death warning"] = "죽음 경고"
L["FD"] = "죽척"
L["Feign Death warning"] = "죽은척하기 경고"
L["Health"] = "생명력"
L["Health deficit"] = "결손 생명력"
L["Health threshold"] = "생명력 수치"
L["Low HP"] = "생명력 낮음"
L["Low HP threshold"] = "생명력 낮음 수치"
L["Low HP warning"] = "생명력 낮음 경고"
L["Offline"] = "오프라인"
L["Offline warning"] = "오프라인 경고"
L["Only show deficit above % damage."] = "결손량을 표시할 백분율을 설정합니다."
L["Set the HP % for the low HP warning."] = "생명력 낮음 경고를 위한 백분율을 설정합니다."
L["Show dead as full health"] = "죽은후 모든 생명력 표시"
L["Treat dead units as being full health."] = "죽은 플레이어들의 전체 생명력을 표시합니다."
L["Unit health"] = "유닛 생명력"
L["Use class color"] = "직업 색상 사용"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "마나 낮음"
L["Low Mana warning"] = "마나 낮음 경고"
L["Mana"] = "마나"
L["Mana threshold"] = "마나 수치"
L["Set the percentage for the low mana warning."] = "마나 낮음 경고를 위한 백분율을 설정합니다."

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "직업별 색상"
L["Unit Name"] = "유닛 이름"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "사정거리"
L["Range"] = "거리"
L["Range check frequency"] = "거리 체크 빈도"
L["Seconds between range checks"] = "거리 체크의 시간(초)를 설정합니다."

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "?"
L["AFK"] = "자리비움"
L["AFK color"] = "자리비움 색상"
L["Color for AFK."] = "자리비움 상태일 때 색상"
L["Color for Not Ready."] = "전투 준비가 되지 않았을 때 색상"
L["Color for Ready."] = "전투 준비가 되었을 때 색상"
L["Color for Waiting."] = "대기 상태일 때 색상"
L["Delay"] = "지연"
L["Not Ready color"] = "준비되지 않음 색상"
L["R"] = "R"
L["Ready Check"] = "전투 준비"
L["Ready color"] = "준비됨 색상"
L["Set the delay until ready check results are cleared."] = "전투 준비 체크 결과를 표시합니다."
L["Waiting color"] = "대기 색상"
L["X"] = "X"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "대상"
L["Your Target"] = "당신의 대상"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "운전"
L["In Vehicle"] = "탈것"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "대화중"
L["Voice Chat"] = "음성 대화"
