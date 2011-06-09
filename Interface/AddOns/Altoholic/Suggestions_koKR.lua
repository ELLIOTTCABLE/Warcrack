﻿local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

if GetLocale() ~= "koKR" then return end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {

	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "50 까지: 리넨 두루마리" },
		{ 70, "70 까지: 리넨 가방" },
		{ 75, "75 까지: 질긴 리넨 단망토" },
		{ 105, "105 까지: 양모 두루마리" },
		{ 110, "110 까지: 회색 양모 셔츠"},
		{ 125, "125 까지: 이중 양모 어깨보호구" },
		{ 145, "145 까지: 비단 두루마리" },
		{ 160, "160 까지: 감청색 비단 두건" },
		{ 170, "170 까지: 비단 머리띠" },
		{ 175, "175 까지: 흰색 정장 셔츠" },
		{ 185, "185 까지: 마법 두루마리" },
		{ 205, "205 까지: 심홍색 비단 조끼" },
		{ 215, "215 까지: 심홍색 비단 바지" },
		{ 220, "220 까지: 검은 마법매듭 다리보호구\n또는 검은 마법매듭 조끼" },
		{ 230, "230 까지: 검은 마법매듭 장갑" },
		{ 250, "250 까지: 검은 마법매듭 머리띠\n또는 검은 마법매듭 어깨보호구" },
		{ 260, "260 까지: 룬무늬 두루마리" },
		{ 275, "275 까지: 룬무늬 허리띠" },
		{ 280, "280 까지: 룬매듭 가방" },
		{ 300, "300 까지: 룬매듭 장갑" },
		{ 325, "325 까지: 황천매듭 두루마리\n|cFFFFD700팔지 말 것, 향후 사용" },
		{ 340, "340 까지: 마력 깃든 황천매듭 두루마리\n|cFFFFD700팔지 말 것, 향후 사용" },
		{ 350, "350 까지: 황천매듭 장화\n|cFFFFD700마력 추출해서 신비한 수정 가루" },
		{ 375, "375 까지: 서리매듭 두루마리" },
		{ 380, "380 까지: 서리장식 장화" },
		{ 395, "395 까지: 서리장식 두건" },
		{ 405, "405 까지: 그늘매듭 두건" },
		{ 410, "410 까지: 그늘매듭 손목보호구" },
		{ 415, "415 까지: 그늘매듭 장갑" },
		{ 425, "425 까지: 서리매듭 가방" },
		{ 450, "450 까지: 잿불비단 두루마리" },
		{ 475, "475 까지: 기술 올릴 수 있는 것 아무거나" },
		{ 500, "500 까지: 상급자의 마법실타래와 다른 low-mats 도안" },
		{ 515, "515 까지: 칼날 자수" },
		{ 525, "525 까지: 각종 꿈, 기술 올릴 수 있는 것 아무거나" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "35 까지: 작은 방어구 키트" },
		{ 55, "55 까지: 얇은 경화 가죽" },
		{ 85, "85 까지: 새김무늬 가죽 장갑" },
		{ 100, "100 까지: 고급 가죽 허리띠" },
		{ 120, "120 까지: 일반 경화 가죽" },
		{ 125, "125 까지: 고급 가죽 허리띠" },
		{ 150, "150 까지: 암색 가죽 허리띠" },
		{ 160, "160 까지: 질긴 경화 가죽" },
		{ 170, "170 까지: 고급 방어구 키트" },
		{ 180, "180 까지: 거무스름한 가죽 다리보호구\n또는 수호 바지" },
		{ 195, "195 까지: 야만전사의 어깨보호구" },
		{ 205, "205 까지: 거무스름한 팔보호구" },
		{ 220, "220 까지: 두꺼운 방어구 키트" },
		{ 225, "225 까지: 밤하늘 머리띠" },
		{ 250, "250 까지: 선택한 전문화에 따라\n(원소)밤하늘 머리띠/튜닉/바지\n(용비늘)단단한 전갈 흉갑/장갑\n(전통)거북 껍질 세트" },
		{ 260, "260 까지: 밤하늘 장화" },
		{ 270, "270 까지: 악의의 가죽 건틀릿" },
		{ 285, "285 까지: 악의의 가죽 팔보호구" },
		{ 300, "300 까지: 악의의 가죽 머리띠" },
		{ 310, "310 까지: 톱니매듭 가죽" },
		{ 320, "320 까지: 야생의 드레나이 장갑" },
		{ 325, "325 까지: 두꺼운 드레나이 장화" },
		{ 335, "335 까지: 질긴톱니매듭가죽\n|cFFFFD700팔지 말 것, 향후 사용" },
		{ 340, "340 까지: 두꺼운 드레나이 조끼" },
		{ 350, "350 까지: 지옥껍질 흉갑" },
		{ 375, "375 까지: 북풍 방어구 키트" },
		{ 385, "385 까지: 북극의 장화" },
		{ 395, "395 까지: 북극의 허리띠" },
		{ 400, "400 까지: 북극의 손목보호구" },
		{ 405, "405 까지: 네루비안 다리 방어구 키트" },
		{ 410, "410 까지: 어두운 여러가지 흉갑 또는 다리보호구들" },
		{ 425, "425 까지: 여러가지 모피 안감\n전문기술 가방들" },
		{ 450, "450 까지: 필요한 것 위주로\n점수 얻을 수 있는 모든 것" }
	},
	[BI["Engineering"]] = {
		{ 40, "40 까지: 천연 화약" },
		{ 50, "50 까지: 구리 나사 한 줌" },
		{ 51, "만능 스패너 하나 제작" },
		{ 65, "65 까지: 구리관" },
		{ 75, "75 까지: 조잡한 붐스틱" },
		{ 95, "95 까지: 굵은 화약" },
		{ 105, "105 까지: 은 접지" },
		{ 120, "120 까지: 청동관" },
		{ 125, "125 까지: 소형 청동 폭탄" },
		{ 145, "145 까지: 강한 화약" },
		{ 150, "150 까지: 대형 청동 폭탄" },
		{ 175, "175 까지: 푸른, 녹색, 또는 붉은 폭죽" },
		{ 176, "자동회전 초정밀조율기 하나 제작" },
		{ 190, "190 까지: 조밀한 화약" },
		{ 195, "195 까지: 대형 철제 폭탄" },
		{ 205, "205 까지: 미스릴관" },
		{ 210, "210 까지: 유동성 제동장치" },
		{ 225, "225 까지: 고강도 미스릴 산탄" },
		{ 235, "235 까지: 미스릴 형틀" },
		{ 245, "245 까지: 고폭탄" },
		{ 250, "250 까지: 미스릴 회전탄" },
		{ 260, "260 까지: 강도 높은 화약" },
		{ 290, "290 까지: 토륨 부품" },
		{ 300, "300 까지: 토륨관\n또는 토륨 탄환 (더 저렴)" },
		{ 310, "310 까지: 지옥무쇠 형틀,\n지옥무쇠 나사 한 줌,\n 그리고 원소 화약\n향후 제작을 위해 모두 보관" },
		{ 320, "320 까지: 지옥무쇠 폭탄" },
		{ 335, "335 까지: 지옥무쇠 머스킷총" },
		{ 350, "350 까지: 백색 조명탄" },
		{ 375, "375 까지: 코발트 파편 폭탄" },
		{ 430, "430 까지: 마나, 치유 주사 도구\n오랫동안 필요하게 될 것임" },
		{ 435, "435 까지: 마나 주사 도구" },
		{ 450, "450 까지: 필요한 것 위주로,\n점수 얻을 수 있는 모든 것" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "20 까지: 가느다른 구리 철사" },
		{ 30, "30 까지: 조잡한 돌 조각상" },
		{ 50, "50 까지: 호안석 고리" },
		{ 75, "75 까지: 청동 장식" },
		{ 80, "80 까지: 순 청동 반지" },
		{ 90, "90 까지: 세련된 은 반지" },
		{ 110, "110 까지: 힘의 은 반지" },
		{ 120, "120 까지: 단단한 돌 조각상" },
		{ 150, "150 까지: 보호의 태마노 팬던트\n또는 황금 용 반지" },
		{ 180, "180 까지: 미스릴 장식" },
		{ 200, "200 까지: 글자가 새겨진 진은 반지" },
		{ 210, "210 까지: 신속한 치유의 황수정 반지" },
		{ 225, "225 까지: 남옥 인장 반지" },
		{ 250, "250 까지: 토륨 장식" },
		{ 255, "255 까지: 파괴의 붉은 반지" },
		{ 265, "265 까지: 치유의 진은 반지" },
		{ 275, "275 까지: 간결한 오팔 반지" },
		{ 285, "285 까지: 사파이어 인장 반지" },
		{ 290, "290 까지: 다이아몬드 정신집중 반지" },
		{ 300, "300 까지: 에메랄드 사자 반지" },
		{ 310, "310 까지: 각종 녹색 등급 보석" },
		{ 315, "315 까지: 피의 지옥무쇠 반지\n또는 각종 녹색 등급 보석" },
		{ 320, "320 까지: 각종 녹색 등급 보석" },
		{ 325, "325 까지: 하늘월장석 반지" },
		{ 335, "335 까지: 수은 아다만타이트 (향후 필요)\n또는 각종 녹색 등급 보석" },
		{ 350, "350 까지: 무거운 아다만타이트 반지" },
		{ 355, "355 까지: 각종 파란색 등급 보석" },
		{ 360, "360 까지: 각종 월드 드랍 제조법, 예:\n생명의 루비 펜던트\n또는 두꺼운 지옥강철 목걸이" },
		{ 365, "365 까지: 비전 보호의 반지\n샤타르 평판 - 우호적" },
		{ 375, "375 까지: 다이아몬드들 변환\n월드 드랍 (파란색 등급)\n샤타르 - 매우 우호, 스랄마 - 우호적" },
		{ 400, "400 까지: 각종 녹색 등급 보석" },
		{ 420, "420 까지: 암흑력의 반지" },
		{ 450, "450 까지: 얼어붙은 프리즘" },
		{ 475, "475 까지: Prospect Ore for Gems" },
		{ 525, "525 까지: 보석세공 일일퀘스트에서 얻은 제조법" }
	},
	[BI["Enchanting"]] = {
		{ 2, "2 까지: 룬문자 구리마법막대" },
		{ 75, "75 까지: 손목보호구 마법부여 - 최하급 생명력" },
		{ 85, "85 까지: 손목보호구 마법부여 - 최하급 회피" },
		{ 100, "100 까지: 손목보호구 마법부여 - 최하급 체력" },
		{ 101, "룬문자 은마법막대 하나 제작" },
		{ 105, "105 까지: 손목보호구 마법부여 - 최하급 체력" },
		{ 120, "120 까지: 상급 마술봉" },
		{ 130, "130 까지: 방패 마법부여 - 최하급 체력" },
		{ 150, "150 까지: 손목보호구 마법부여 - 하급 체력" },
		{ 151, "룬문자 금마법막대 하나 제작" },
		{ 160, "160 까지: 손목보호구 마법부여 - 하급 체력" },
		{ 165, "165 까지: 방패 마법부여 - 하급 체력" },
		{ 180, "180 까지: 손목보호구 마법부여 - 정신력" },
		{ 200, "200 까지: 손목보호구 마법부여 - 힘" },
		{ 201, "룬문자 진은마법막대 하나 제작" },
		{ 205, "205 까지: 손목보호구 마법부여 - 힘" },
		{ 225, "225 까지: 망토 마법부여 - 상급 보호" },
		{ 235, "235 까지: 장갑 마법부여 - 민첩성" },
		{ 245, "245 까지: 가슴보호구 마법부여 - 최상급 생명력" },
		{ 250, "250 까지: 손목보호구 마법부여 - 상급 힘" },
		{ 270, "270 까지: 하급 마나 오일\n주문식은 실리더스에서 판매" },
		{ 290, "290 까지: 방패 마법부여 - 상급 체력\n또는 장화 마법부여 - 상급 체력" },
		{ 291, "룬문자 아케이나이트막대 하나 제작" },
		{ 300, "300 까지: 망토 마법부여 - 최상급 보호" },
		{ 301, "룬문자 지옥무쇠막대 하나 제작" },
		{ 305, "305 까지: 망토 마법부여 - 최상급 보호" },
		{ 315, "315 까지: 손목보호구 마법부여 - 맹공" },
		{ 325, "325 까지: 망토 마법부여 - 일급 방어도\nor 장갑 마법부여 - 맹공" },
		{ 335, "335 까지: 가슴보호구 마법부여 - 일급 정신력" },
		{ 340, "340 까지: 방패 마법부여 - 일급 체력" },
		{ 345, "345 까지: 최상급 마술사 오일\n재료가 있다면 350 까지" },
		{ 350, "350 까지: 장갑 마법부여 - 일급 힘" },
		{ 351, "룬문자 아다만다이트 막대 하나 제작" },
		{ 360, "360 까지: 장갑 마법부여 - 일급 힘" },
		{ 370, "370 까지: 장갑 마법부여 - 주문 적중\n세나리온 원정대 - 매우 우호적" },
		{ 375, "375 까지: 반지 마법부여 - 치유 마법 강화\n샤타르 - 매우 우호적" },
		{ 376, "룬문자 이터늄 마법막대 하나 제작" },
		{ 380, "380 까지: 가슴보호구 마법부여 - 최상급 능력치" },
		{ 390, "390 까지: 무기 마법부여 - 상급 근력" },
		{ 425, "룬문자 티타늄 마법막대 하나 제작" },
		{ 450, "450 까지: 기술 올릴 수 있는 것 아무거나" },
		{ 475, "475 까지: Disenenchant 모든 초록색" },
		{ 515, "룬문자 엘레멘티움 마법막대 하나 제작" },
		{ 525, "525 까지: Trade in Shards for Recipes" }
	},
	[BI["Blacksmithing"]] = {	
		{ 25, "25 까지: 조잡한 숫돌" },
		{ 45, "45 까지: 조잡한 연마석" },
		{ 75, "75 까지: 구리 사슬 허리띠" },
		{ 80, "80 까지: 일반 연마석" },
		{ 100, "100 까지: 구리 룬문자 허리띠" },
		{ 105, "105 까지: 은마법막대" },
		{ 125, "125 까지: 청동 다리보호구" },
		{ 150, "150 까지: 단단한 연마석" },
		{ 155, "155 까지: 금마법막대" },
		{ 165, "165 까지: 녹색 철제 다리보호구" },
		{ 185, "185 까지: 녹색 철제 팔보호구" },
		{ 200, "200 까지: 황금 미늘 팔보호구" },
		{ 210, "210 까지: 견고한 연마석" },
		{ 215, "215 까지: 황금 미늘 팔보호구" },
		{ 235, "235 까지: 강철 판금 투구\n또는 미스릴 미늘 팔보호구 (더 저렴)\n제조법은 맹금의 봉우리(얼) 또는 스토나드(호)" },
		{ 250, "250 까지: 미스릴 코이프\n또는 미스릴 박차 (더 저렴)" },
		{ 260, "260 까지: 강도 톺은 숫돌" },
		{ 270, "270 까지: 토륨 허리띠 또는 팔보호구 (더 저렴)\n대지로 벼려낸 다리보호구(갑옷전문)\n대지로 벼려낸 검(검전문)\n불꽃으로 벼려낸 망치(둔기전문)\n하늘로 벼려낸 도끼(도끼전문)" },
		{ 295, "295 까지: 황제의 판금 팔보호구" },
		{ 300, "300 까지: 황제의 판금 장화" },
		{ 305, "305 까지: 지옥의 숫돌" },
		{ 320, "320 까지: 지옥무쇠 허리띠" },
		{ 325, "325 까지: 지옥무쇠 장화" },
		{ 330, "330 까지: 하급 수호의 룬" },
		{ 335, "335 까지: 지옥무쇠 흉갑" },
		{ 340, "340 까지: 아다만타이트 클레버\n샤트라, 실버문, 엑소다르에서 판매" },
		{ 345, "345 까지: 하급 수호의 보호막\n와일드해머 성채와 스랄마에서 판매" },
		{ 350, "350 까지: 아다만타이트 클레버" },
		{ 360, "360 까지: 아다만타이트 무게추\n세나리온 원정대 - 우호적 필요" },
		{ 370, "370 까지: 지옥강철 장갑 (아키나이 납골당)\n화염파멸 장갑 (알도르 사제회 - 우호적 필요)\n마력 깃든 아다만타이트 허리띠 (점술가 길드 - 약간 우호적)" },
		{ 375, "375 까지: 지옥강철 장갑 (아키나이 납골당)\n화염파멸 흉갑 (알도르 사제회 - 매우 우호 필요)\n마력 깃든 아다만타이트 허리띠 (점술가 길드 - 약간 우호적)" },
		{ 385, "385 까지: 코발트 건틀럿" },
		{ 393, "393 까지: 가시 박힌 코발트 어깨보호구\n또는 흉갑" },
		{ 395, "395 까지: 가시 박힌 코발트 건틀럿" },
		{ 400, "400 까지: 가시 박힌 코발트 허리띠" },
		{ 410, "410 까지: 가시 박힌 코발트 팔보호구" },
		{ 415, "415 까지: 달궈진 사로나이트 어깨보호구" },
		{ 420, "420 까지: 달궈진 사로나이트 팔보호구" },
		{ 430, "430 까지: 위압의 손보호대" },
		{ 445, "445 까지: 위압의 다리보호구" },
		{ 450, "450 까지: 각종 에픽" },
		{ 500, "500 까지: Any skill-up will do" },
		{ 525, "525 까지: Farm Ore for Recipes in 황혼의 고원" }
	},
	[BI["Alchemy"]] = {	
		{ 60, "60 까지: 최하급 치유 물약" },
		{ 110, "110 까지: 하급 치유 물약" },
		{ 140, "140 까지: 치유 물약" },
		{ 155, "155 까지: 하급 마나 물약" },
		{ 185, "185 까지: 상급 치유 물약" },
		{ 210, "210 까지: 민첩의 비약" },
		{ 215, "215 까지: 상급 방어의 비약" },
		{ 230, "230 까지: 최상급 치유 물약" },
		{ 250, "250 까지: 언데드 감지의 비약" },
		{ 265, "265 까지: 상급 민첩의 비약" },
		{ 285, "285 까지: 최상급 마나 물약" },
		{ 300, "300 까지: 일급 치유 물약" },
		{ 315, "315 까지: 신속 치유 물약\n또는 일급 마나 물약" },
		{ 350, "350 까지: 미친 연금술사의 물약\n335에 노란색으로 변하지만 싸게 만듬" },
		{ 375, "375 까지: 일급 숙면의 물약\nSold in Allerian Stronghold (A)\nor Thunderlord Stronghold (H)" }
	},
	[L["Mining"]] = {
		{ 65, "65 까지: 구리 채광\n모든 시작 지역에서 가능" },
		{ 125, "125 까지: 주석, 은, Incendicite, 하급 혈석 채광\n\nMine Incendicite at Thelgen Rock (저습지)\n125 까지 쉽게 향상" },
		{ 175, "175 까지: 철, 금 채광\n잊혀진 땅, 잿빛 골짜기, 황야의 땅, 아라시 고원,\n알터랙 산맥, 가시덤불 골짜기, 슬픔의 늪" },
		{ 250, "250 까지: 미스릴, 진은 채광\n저주받은 땅, 이글거리는 협곡, 황야의 땅, 동부 내륙지,\n서부 역병지대, 아즈샤라, 여명의 설원, 악령의 숲, 돌발톱 산맥, 타나리스" },
		{ 300, "300 까지: 토륨 채광\n운고로 분화구, 아즈샤라, 여명의 설원, 저주받은 땅\n이글거리는 협곡, 불타는 평원, 동부 역병지대, 서부 역병지대" },
		{ 330, "330 까지: 지옥무쇠 채광\n지옥불 반도, 장가르 습지대" },
		{ 375, "375 까지: 지옥무쇠, 아다만타이트 채광\n테로카르 숲, 나그란드\n기본적으로 아웃랜드에 있는 모든 곳" },
		{ 400, "400 까지: 코발트 채광" },
		{ 425, "450 까지: 사로나이트 채광" },
		{ 475, "475 까지: 흑요암 채광" },
		{ 500, "500 까지: 엘레멘티움 채광" },
		{ 525, "525 까지: Smelt Hardened 엘레멘티움, 황철석 채광" }
	},
	[L["Herbalism"]] = {
		{ 50, "50 까지: 은엽수, 평온초 채집\n모든 시작 지역에서 가능" },
		{ 70, "70 까지: 마법초, 뱀뿌리 채집\n불모의 땅, 서부 몰락지대, 은빛소나무 숲, 모단 호수" },
		{ 100, "100 까지: 찔레가시 채집\n은빛소나무 숲, 그늘숲, 어둠의 해안,\n모단 호수, 붉은마루 산맥" },
		{ 115, "115 까지: 생채기풀 채집\n잿빛 골짜기, 돌발톱 산맥, 남부 불모의 땅\n모단 호수, 붉은마루 산맥" },
		{ 125, "125 까지: 야생 철쭉 채집\n돌발톱 산맥, 아라시 고원, 가시덤불 골짜기\n남부 불모의 땅, 버섯구름 봉우리" },
		{ 160, "160 까지: 왕꽃잎풀 채집\n잿빛 골짜기, 돌발톱 산맥, 저습지,\n언덕마루 구릉지, 슬픔의 늪" },
		{ 185, "185 까지: 미명초 채집\n슬픔의 늪" },
		{ 205, "205 까지: 카드가의 수염 채집\n동부 내륙지, 아라시 고원, 슬픔의 늪" },
		{ 230, "230 까지: 화염초 채집\n이글거리는 협곡, 저주받은 땅, 타나리스" },
		{ 250, "250 까지: 태양풀 채집\n악령의 숲, 페랄라스, 아즈샤라\n동부 내륙지" },
		{ 270, "270 까지: 그롬의 피 채집\n악령의 숲, 저주받은 땅,\nMannoroc Coven in 잊혀진 땅" },
		{ 285, "285 까지: 꿈풀 채집\n운고로 분화구, 아즈샤라" },
		{ 300, "300 까지: 역병초 채집\n동부 및 서부 역병지대, 악령의 숲\nor Icecaps in 여명의 설원" },
		{ 330, "330 까지: 지옥풀 채집\n지옥불 반도, 장가르 습지대" },
		{ 375, "375 까지: 아웃랜드에 있는 아무 약초\n주로 장가르 습지대와 테로카르 숲" }
	},
	[L["Skinning"]] = {
		{ 525, "525 까지: 현재 숙련도 나누기 5\n 한 레벨의 몹 무두질" }
	},

	-- source: http://www.elsprofessions.com/inscription/leveling.html
	[L["Inscription"]] = {
		{ 18, "18 까지: 상아 잉크" },
		{ 35, "35 까지: 지능 또는 정신력, 체력 두루마리" },
		{ 50, "50 까지: 달빛 잉크\n보조 문양 연구를 위해 보관" },
		{ 75, "75 까지: 귀환의 두루마리, 방어구 피지" },
		{ 79, "79 까지: 한밤 잉크" },
		{ 80, "80 까지: 보조 문양 연구" },
		{ 85, "85 까지: 문양: 기습, 얼음 회오리\n회복, ..." },
		{ 87, "87 까지: 사냥꾼의 잉크" },
		{ 90, "90 까지: 문양: 부패, 화염 충격\n신속한 돌진, 천벌" },
		{ 100, "100 까지: 문양: 얼음 갑옷, 심판의 망치\n독사 쐐기" },
		{ 104, "104 까지: 사자의 잉크" },
		{ 105, "105 까지: 문양: 신비한 사격, 신비한 폭발" },
		{ 110, "110 까지: 문양: 절개, 성스러운 빛, 소실" },
		{ 115, "115 까지: 문양: 불꽃 회오리, 생명력 집중,\n분쇄" },
		{ 120, "120 까지: 문양: 신비한 화살, 치유의 손길" },
		{ 125, "125 까지: 문양: 약점 노출\n순간 치유, 심판" },
		{ 130, "130 까지: 새벽별 잉크" },
		{ 135, "135 까지: 문양: 점멸\n제물의 덫, 달빛 섬광" },
		{ 140, "140 까지: 문양: 신앙\n목조르기, 내면의 열정" },
		{ 142, "142 까지: 문양: 방어구 가르기\n임프, 번개 화살" },
		{ 150, "150 까지: 이상한 카드" },
		{ 155, "155 까지: 비취불꽃 잉크" },
		{ 160, "160 까지: 체력의 두루마리 III" },
		{ 165, "165 까지: 문양: 후려치기, 소생" },
		{ 170, "170 까지: 문양: 어둠의 화살\n용암 채찍" },
		{ 175, "175 까지: 문양: 제압" },
		{ 177, "177 까지: 제왕의 잉크" },
		{ 183, "183 까지: 민첩성의 두루마리 III" },
		{ 185, "185 까지: 문양: 정화\n어둠의 권능: 고통" },
		{ 190, "190 까지: 문양: 곤충 떼\n냉기 충격, 기절시키기" },
		{ 192, "192 까지: 문양: 복수\n보이드워커" },
		{ 200, "200 까지: 신비한 카드" },
		{ 204, "204 까지: 하늘빛 잉크" },
		{ 210, "210 까지: 방어구 피지 II" },
		{ 215, "215 까지: 문양: 성스러운 일격, 사악한 일격" },
		{ 220, "220 까지: 문양: 불타는 고통\n치유의 토템" },
		{ 225, "225 까지: 문양: 별빛 섬광\n야만적인 모욕" },
		{ 227, "227 까지: 불꽃 잉크" },
		{ 230, "230 까지: 민첩성의 두루마리 IV" },
		{ 235, "235 까지: 문양: 마법 무효화" },
		{ 250, "250 까지: 무기 피지 II" },
		{ 255, "255 까지: 체력의 두루마리 V" },
		{ 260, "260 까지: 정신력의 두루마리 V" },
		{ 265, "265 까지: 문양: 얼음의 덫, 칼날 발톱" },
		{ 270, "270 까지: 문양: 퇴마술, 뼈의 보호막" },
		{ 275, "275 까지: 문양: 공포의 수호물, 냉기의 일격" },
		{ 285, "285 까지: 하늘의 잉크" },
		{ 295, "295 까지: 문양: 마무리 일격\n전력 질주, 죽음의 손아귀" },
		{ 300, "300 까지: 정신력의 두루마리 VI" },
		{ 304, "304 까지: 에테르 잉크" },
		{ 305, "305 까지: 문양: 역병의 일격\n대지생명의 무기, 빛의 섬광" },
		{ 310, "310 까지: 문양: 교란" },
		{ 315, "315 까지: 문양: 갈퀴 발톱, 룬 전환" },
		{ 320, "320 까지: 문양: 신성한 폭발, 속사" },
		{ 325, "325 까지: 문양: 피의 일격, 휩쓸기 일격" },
		{ 327, "327 까지: 어둠불꽃 잉크" },
		{ 330, "330 까지: 문양: 마법사 갑옷, 서큐버스" },
		{ 335, "335 까지: 문양: 스컬지의 일격, 질풍의 무기" },
		{ 340, "340 까지: 문양: 신비한 마법 강화, 지휘의 문장" },
		{ 345, "345 까지: 문양: 매복, 죽음의 일격" },
		{ 350, "350 까지: 문양: 소용돌이" },
		{ 360, "360 까지: 문양: 정신의 채찍, 추방" },
		{ 365, "365 까지: 지능의 두루마리 VII" },
		{ 370, "370 까지: 힘의 두루마리 VII" },
		{ 375, "375 까지: 민첩성의 두루마리 VII" },
		{ 380, "380 까지: 문양: 집중, 질식시키기" },
		{ 400, "400 까지: 노스렌드 문양 연구" },
		{ 450, "450 까지: 희귀 다크문 카드" }
	},

	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 75, "75 까지: 15 레벨 까지" },
		{ 125, "125 까지: 25 레벨 까지" },
		{ 175, "175 까지: 35 레벨 까지" },
		{ 200, "250 까지: 40 레벨 까지" },
		{ 225, "225 까지: 45 레벨 까지" },
		{ 275, "275 까지: 55 레벨 까지" },
		{ 300, "300 까지: 60 레벨 까지" },
		{ 325, "325 까지: 65 레벨 까지" },
		{ 375, "375 까지: 70 레벨 까지" },
		{ 400, "400 까지: 80 레벨 까지" },
		{ 425, "425 까지: 85 레벨 까지" }
	},
	
	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "40 까지: 리넨 붕대" },
		{ 80, "80 까지: 두꺼운 리넨 붕대\n50 에 중급" },
		{ 115, "115 까지: 양모 붕대" },
		{ 150, "150 까지: 두꺼운 양모 붕대" },
		{ 180, "180 까지: 비단 붕대" },
		{ 210, "210 까지: 두꺼운 비단 붕대" },
		{ 240, "240 까지: 마법 붕대" },
		{ 260, "260 까지: 두꺼운 마법 붕대" },
		{ 290, "290 까지: 룬매듭 붕대" },
		{ 330, "330 까지: 두꺼운 룬매듭 붕대" },
		{ 360, "360 까지: 황천매듭 붕대" },
		{ 375, "375 까지: 두꺼운 황천매듭 붕대" },
		{ 400, "400 까지: 서리매듭 붕대" },
		{ 425, "425 까지: 두꺼운 서리매듭 붕대" },
		{ 475, "475 까지: 잿불비단 붕대" },
		{ 525, "525 까지: 두꺼운 잿불비단 붕대" }
	},
	[BI["Cooking"]] = {
		{ 40, "40 까지: 매콤한 빵"	},
		{ 85, "85 까지: 곰고기 숯불구이, 게살 케이크" },
		{ 100, "100 까지: 집게발 요리 (얼)\n들쥐 스튜 (호)" },
		{ 125, "125 까지: 들쥐 스튜 (호)\n양념 늑대 케밥 (얼)" },
		{ 175, "175 까지: 진기한 맛의 오믈렛 (얼)\n매운 사자 고기 (호)" },
		{ 200, "200 까지: 랩터 숯불구이" },
		{ 225, "225 까지: 거미 소시지\n\n|cFFFFFFFF요리 퀘스트:\n|cFFFFD70012 거대한 알,\n10 고소한 조개살,\n20 알터렉 스위스 " },
		{ 275, "275 까지: 괴물 오믈렛\n또는 연한 늑대 스테이크" },
		{ 285, "285 까지: 룬툼 줄기 별미\n혈투의 전장 (푸실린)" },
		{ 300, "300 까지: 훈제 사막 경단\n실리더스에서 퀘스트" },
		{ 325, "325 까지: 칼날발톱 핫도그, 대머리수리 꼬치" },
		{ 350, "350 까지: 갈래발굽 숯불구이\n차원의 버거, 탈부크 스테이크" },
		{ 375, "375 까지: 바삭바삭한 천둥매 튀김\n모크나탈 갈비" },
		{ 400, "400 까지: 기술상급자에게 배운 요리법 아무거나" },
		{ 450, "450 까지: 달라란 요리 일일퀘스트" },
		{ 525, "525 까지: 스톰윈드 또는 오그리마 요리 일일퀘스트" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "50 까지: 모든 시작 지역" },
		{ 75, "75 까지:\n스톰윈드 안 운하\n오그리마 안 연못" },
		{ 150, "150 까지: 언덕마루 구릉지' 강" },
		{ 225, "225 까지: 숙련 낚시\n잊혀진 땅 또는 아라시 고원에서 낚시" },
		{ 250, "250 까지: 동부 내륙지, 타나리스\n\n|cFFFFFFFFFishing quest in 먼지진흙 슾지대\n|cFFFFD700Savage Coast Blue Sailfin (가시덤불 골짜기)\n페랄라스 Ahi (Verdantis River, 페랄라스)\nSer'theris Striker (Northern Sartheris Strand, 잊혀진 땅)\nMisty Reed Mahi Mahi (슬픔의 늪 해변)" },
		{ 260, "260 까지: 악령의 숲" },
		{ 300, "300 까지: 아즈샤라" },
		{ 330, "330 까지: 장가르 습지대 동부" },
		{ 345, "345 까지: 장가르 습지대 서부" },
		{ 360, "360 까지: 테로카르 숲" },
		{ 375, "375 까지: 테로카르 숲, in altitude\n나르는 탈 것 필요" },
		{ 400, "400 까지: 북풍의 땅" },
		{ 450, "450 까지: 달라란 낚시 주화; 모든 노스렌드 지역" },
		{ 525, "525 까지: 모든 대격변 지역\n스톰윈드 또는 오그리마 낚시 일일퀘스트" }
	},
	
	[BI["Archaeology"]] = {
		{ 300, "300 까지: 칼림도어\n동부 왕국" },
		{ 375, "375 까지: 아웃랜드" },
		{ 450, "450 까지: 노스렌드" },
		{ 525, "525 까지: 하이잘 산\n울둠\n황혼의 고원" }
	},
	
	-- suggested leveling zones, as defined by recommended quest levels, Updated for Cataclysm
	["Leveling"] = {
		{ 10, "10 까지: 모든 시작 지역" },
		{ 15, "15 까지: "  .. BZ["Westfall"]},
		{ 16, "16 까지: "  .. BZ["Ruins of Gilneas"]},
		{ 20, "20 까지: "  .. BZ["Azshara"] .. "\n" .. BZ["Loch Modan"] .. "\n" .. BZ["Bloodmyst Isle"]
							.. "\n" .. BZ["Darkshore"] .. "\n" .. BZ["Silverpine Forest"] .. "\n" .. BZ["Northern Barrens"] 
							.. "\n" .. BZ["Ghostlands"] .. "\n" .. BZ["Redridge Mountains"]},
		{ 25, "25 까지: " 	.. BZ["Duskwood"] .. "\n" .. BZ["Wetlands"] .. "\n" .. BZ["Ashenvale"] 
							.. "\n" .. BZ["Hillsbrad Foothills"]},
		{ 30, "30 까지: " 	.. BZ["Arathi Highlands"] .. "\n" .. BZ["Northern Stranglethorn"] .. "\n" .. BZ["Stonetalon Mountains"]},
		{ 35, "35 까지: " 	.. BZ["The Cape of Stranglethorn"] .. "\n" .. BZ["Desolace"] .. "\n" .. BZ["The Hinterlands"]
							.. "\n" .. BZ["Southern Barrens"]},
		{ 40, "40 까지: " 	.. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["Western Plaguelands"]},
		{ 45, "45 까지: " 	.. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Thousand Needles"]},
		{ 48, "48 까지: "  .. BZ["Badlands"]},
		{ 50, "50 까지: " 	.. BZ["Tanaris"] .. "\n" .. BZ["Felwood"] .. "\n" .. BZ["Searing Gorge"]},
		{ 52, "52 까지: "	.. BZ["Burning Steppes"]},
		{ 54, "54 까지: " 	.. BZ["Swamp of Sorrows"]},
		{ 55, "55 까지: " 	.. BZ["Un'Goro Crater"] .. "\n" .. BZ["Winterspring"]},
		{ 58, "58 까지: " 	.. BZ["Blasted Lands"]},
		{ 60, "60 까지: " 	.. BZ["Deadwind Pass"] .. "\n" .. BZ["Moonglade"] .. "\n" .. BZ["Silithus"]},
		{ 63, "63 까지: " 	.. BZ["Hellfire Peninsula"]},
		{ 64, "64 까지: " 	.. BZ["Zangarmarsh"]},
		{ 65, "65 까지: " 	.. BZ["Terokkar Forest"]},
		{ 67, "67 까지: " 	.. BZ["Nagrand"]},
		{ 68, "68 까지: " 	.. BZ["Blade's Edge Mountains"]},
		{ 70, "70 까지: " 	.. BZ["Netherstorm"] .. "\n" .. BZ["Shadowmoon Valley"] .. "\n" .. BZ["Isle of Quel'Danas"] 
							.. "\n" .. BZ["Deadwind Pass"]},
		{ 72, "72 까지: " 	.. BZ["Howling Fjord"] .. "\n" .. BZ["Borean Tundra"]},
		{ 75, "75 까지: " 	.. BZ["Dragonblight"] .. "\n" .. BZ["Grizzly Hills"]},
		{ 76, "76 까지: " 	.. BZ["Zul'Drak"]},
		{ 78, "78 까지: " 	.. BZ["Sholazar Basin"]},
		{ 80, "80 까지: " 	.. BZ["Crystalsong Forest"] .. "\n" .. BZ["The Storm Peaks"] .. "\n" .. BZ["Icecrown"]},
		{ 82, "82 까지: " 	.. BZ["Hyjal"] .. "\n" .. BZ["Vashj'ir"]},
		{ 83, "83 까지: " 	.. BZ["Deepholm"]},
		{ 84, "84 까지: "	.. BZ["Uldum"]},
		{ 85, "85 까지: "  .. BZ["Twilight Highlands"]}
	
	},

}