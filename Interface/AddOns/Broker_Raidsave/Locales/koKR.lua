--[[
************************************************************************
Project				: Broker_RaidSave
Author				: zhinjio
Project Revision	: 2.1.1-beta
Project Date		: 20110529084318

File				: Locales\koKR.lua
Commit Author		: zhinjio
Commit Revision		: 2
Commit Date			: 20110529065627
************************************************************************
Description	:
	Korean translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BRRaidSave"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "koKR" )
if not L then return end

L["(Current)"] = "(현재)"
L["(Updating...)"] = "(업데이트중...)"
L["12-Hour"] = "12시간제"
L["24-Hour"] = "24시간제"
-- L["Activates and displays a scrolling slider bar, for the tooltip."] = "Activates and displays a scrolling slider bar, for the tooltip."
L["Adds a new column, indicating the dungeon or raid difficulty for the specific instance name and ID."] = "새로운 구분 추가, 특정한 던전명 및 ID를 위한 던전 또는 공격대의 난이도를 표시합니다."
L["Ascending"] = "오름차순"
L["Chinese"] = "동양식"
L["Condensed"] = "요약 표시"
L["Descending"] = "내림차순"
L["Difficulty"] = "난이도"
L["Display style for the date instance IDs expire."] = "던전 ID 만료 날짜의 표시 형식을 설정합니다."
L["Display style for the time instance IDs expire."] = "던전 ID 만료 시간의 표시 형식을 설정합니다."
L["Display style for the time until reset."] = "초기화까지 남은 시간의 표시 형식을 지정합니다."
L["Display the date/time the instance ID expires."] = "던전 ID 만료 날짜와 시간을 표시합니다."
L["Display the name of the day of the week, for the instance expiration string."] = "던전 만료 날짜의 요일을 표시합니다."
L["Display the time the instance ID is still valid."] = "던전 ID가 아직 유효한 시간을 표시합니다."
L["Don't display instances with expired ID's on the plugin text."] = "플러그인 문구 상 만료된 ID와 던전을 표시하지 않습니다."
L["Don't display instances with expired ID's on the tooltip."] = "툴팁에 만료된 ID와 함께 던전을 표시하지 않습니다."
-- L["Enable scrolling"] = "Enable scrolling"
L["European"] = "유럽식"
L["Expired"] = "만료됨"
L["Expired: "] = "만료: "
L["Expires"] = "만료"
L["Expiry date format"] = "만료 날짜 형식"
L["Expiry time format"] = "만료 시간 형식"
L["Extended"] = "확장 표시"
L["Full"] = "정식 표시"
L["General Options"] = "일반 설정"
L["Hide expired instances from plugin text"] = "플러그인 문구에서 만료된 던전 숨김"
L["Hide expired instances from tooltip"] = "툴팁에서 만료된 던전 숨김"
-- L["Hide hint text"] = "Hide hint text"
-- L["Hides the tooltip information/hint text."] = "Hides the tooltip information/hint text."
L["ID"] = "ID"
L["Instance"] = "던전"
L["Instance Expiration"] = "만료 정보"
L["Instance Information"] = "던전 정보"
L["List Ordering"] = "목록 불러오는증"
L["Minimalistic LDB plugin that allows tracking of raid IDs across characters."] = "LDB창에 캐릭터별 귀속 던전 정보를 표시합니다."
L["No Instances"] = "귀속 던전 없음"
L["No saved instances found."] = "귀속된 던전이 없음."
-- L["Only show the number of saved instances, in the format [Group]:[Raid]:[Expired]."] = "Only show the number of saved instances, in the format [Group]:[Raid]:[Expired]."
L["Order style for the saved instances list."] = "귀속 던전 목록에 대한 불러오기 형태."
L["Remaining"] = "남은 시간"
L["Remaining time format"] = "남은 시간 표시 형식"
-- L["Sets the tooltip maximum height, after which it will be scrollable."] = "Sets the tooltip maximum height, after which it will be scrollable."
L["Short"] = "약식 표시"
L["Short text"] = "약식 표시"
L["Show day in week"] = "일주일 단위로 보기"
L["Show instance IDs"] = "던전 ID 표시"
L["Show instance difficulty mode"] = "던전 난이도 표시"
L["Show instance expiration data"] = "던전 만료 정보 표시"
L["Show or hide the numeric instance IDs."] = "귀속된 던전 ID를 표시 또는 숨깁니다."
L["Show text for no saved instances"] = "귀속된 던전 없음에 대한 문구 표시"
L["Show the plugin text instead of number, when the character has no saved instances."] = "귀속된 던전이 없는 캐릭터라면, 숫자 대신 플러그인 문구를 표시합니다."
L["Show time remaining"] = "남은 시간 표시"
L["Sort by difficulty"] = "난이도별 정렬"
L["Sort by name"] = "이름별 정렬"
L["Sorts the instances on the tooltip, using the instance difficulty as a reference."] = "던전의 난이도를 참조하여 툴팁 상 던전을 정렬합니다."
L["Sorts the instances on the tooltip, using the name of the instance as a reference."] = "던전의 이름을 참조하여 툴팁 상 던전을 정렬합니다."
-- L["Tooltip Maximum Height"] = "Tooltip Maximum Height"
L["US/American"] = "미국식"
-- L["|cff0090ffBlue|r |cff19ff19colored instance names, indicate|r |cff0090ffextended|r |cff19ff19IDs.|r"] = "|cff0090ffBlue|r |cff19ff19colored instance names, indicate|r |cff0090ffextended|r |cff19ff19IDs.|r"
-- L["|cffeda55fLeft Click|r |cff19ff19on instance name to toggle ID extension."] = "|cffeda55fLeft Click|r |cff19ff19on instance name to toggle ID extension."
L["|cffeda55fLeft Click|r |cff19ff19on plugin to toggle Blizzard's Raid Information frame."] = "|cffeda55f좌-클릭|r |cff19ff19플러그인에 대한 블리자드 공격대 정보 창 표시/표시안함."
L["|cffeda55fRight Click|r |cff19ff19on plugin to open Configuration Menu."] = "|cffeda55f우-클릭|r |cff19ff19플러그인에 대한 설정 메뉴 열기."
-- L["|cffeda55fShift+Left Click|r |cff19ff19to paste instance info into chat."] = "|cffeda55fShift+Left Click|r |cff19ff19to paste instance info into chat."


--[[
************************************************************************
CHANGELOG:

Date : 05/29/11
	initial version
************************************************************************
]]--