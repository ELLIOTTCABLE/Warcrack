--
--	Loremaster
--	Originally written by deepac
--	Maintenance by nimhfree
--
--	Version History
--		001	Initial version changed to use Grail as the backend quest database.
--		002	Adds check to ensure an acceptable version of Grail is loaded.
--			Fixes the problem where the Lightheaded panel would not be displayed properly.
--      003 Changes to support WoD.
--			Changes LoremasterMainFrame to Loremaster.MainFrame so references should exist.
--		004	More changes for Loremaster.MainFrame to exist.
--			Changes TomTom call to allow for zones with the same name not to cause problems.
--		005	Corrects the problem where the tooltip does not disappear when the mouse exits.
--

--	Check to ensure we have an acceptable version of Grail loaded and warn if not
local requiredGrailVersion = 65
if not Grail or Grail.versionNumber < requiredGrailVersion then
	local locale = GetLocale()
	local messageFormat = "|cffff0000Loremaster|r requires |cffff0000Grail|r version %s or later"
	if "deDE" == locale then
		messageFormat = "|cffff0000Loremaster|r benötigt |cffff0000Grail|r-Version %s oder neuer"
	elseif "esES" == locale then
		messageFormat = "|cffff0000Loremaster|r requiere la versión %s o mas reciente de |cffff0000Grail|r"
	elseif "esMX" == locale then
		messageFormat = "|cffff0000Loremaster|r requiere la versión %s o mas reciente de |cffff0000Grail|r"
	elseif "frFR" == locale then
		messageFormat = "|cffff0000Loremaster|r nécessite |cffff0000Grail|r version %s ou ultérieure"
	elseif "itIT" == locale then
		messageFormat = "Richiede interamente versione |cffff0000Grail|r %s o versione successiva"
	elseif "koKR" == locale then
		messageFormat = "|cffff0000Loremaster|r 애드온은 |cffff0000Grail|r의 %s 버전 이상을 요구합니다"
	elseif "ptBR" == locale then
		messageFormat = "|cffff0000Loremaster|r requer a versão %s do |cffff0000Grail|r ou maior"
	elseif "ruRU" == locale then
		messageFormat = "Для работы |cffff0000Loremaster|r требуется |cffff0000Grail|r версии %s или выше"
	elseif "zhCN" == locale then
		messageFormat = "|cffff0000Loremaster|r 需要 %s 或更新的 |cffff0000Grail|r版本"
	elseif "zhTW" == locale then
		messageFormat = "|cffff0000Loremaster|r 需要 %s 或更新的 |cffff0000Grail|r版本"
	end
	local errorMessage = format(messageFormat, requiredGrailVersion)
	print(errorMessage)
	UIErrorsFrame:AddMessage(errorMessage)
end

local Loremaster = Loremaster
local GetMapNameByID = GetMapNameByID
Loremaster.L = LibStub("AceLocale-3.0"):GetLocale("Loremaster")
Loremaster.frame:RegisterEvent("ADDON_LOADED")
Loremaster.frame:RegisterEvent("PLAYER_LOGIN")
Loremaster.frame:RegisterEvent("QUEST_AUTOCOMPLETE")
Loremaster.frame:RegisterEvent("ACHIEVEMENT_EARNED")
Loremaster.frame:RegisterEvent("CRITERIA_UPDATE")
Loremaster.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
Loremaster.frame:RegisterEvent("PLAYER_REGEN_ENABLED")

Loremaster.frame:SetScript("OnEvent", function(...) Loremaster:eventHandler(...) end)
local L = Loremaster.L

Loremaster.LoremasterContinentFrame = {}
Loremaster.LoremasterContinentFrame.bgfile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated"
Loremaster.LoremasterContinentFrame.edgefile = "Interface\\LFGFrame\\LFGBorder"
Loremaster.LoremasterZoneFrame = {}
Loremaster.LoremasterZoneFrame.bgfile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated"
Loremaster.LoremasterZoneFrame.edgefile = "Interface\\LFGFrame\\LFGBorder"
Loremaster.LoremasterStoryFrame = {}
Loremaster.LoremasterStoryFrame.bgfile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated"
Loremaster.LoremasterStoryFrame.edgefile = "Interface\\LFGFrame\\LFGBorder"
Loremaster.LoremasterQuestFrame = {}
Loremaster.LoremasterQuestFrame.bgfile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated"
Loremaster.LoremasterQuestFrame.edgefile = "Interface\\LFGFrame\\LFGBorder"

Loremaster.npcicon = "Interface\\TUTORIALFRAME\\UI-TutorialFrame-QuestGiver"
Loremaster.itemicon = "Interface\\ContainerFrame\\UI-Icon-QuestBang"

--  TODO:   Update the startsSeries and partOfSeries information with the quests from WoD (plus any changes because of WoD)
--  TODO:   Think about possibly moving this information into Grail, and whether it is logical to dynamically create it.

Loremaster.startsSeries = {
		[886] = 272827281,
		[316] = 270532608,
		[380] = 273694881,
		[887] = 140,
		[888] = 30940,
		[317] = 268533762,
		[381] = 2152368132,
		[889] = 4194336,
		[10] = 1073741824,
		[890] = 135266306,
		[318] = 268435584,
		[382] = 1081889,
		[891] = 33556486,
		[764] = 16392,
		[319] = 135602178,
		[383] = 33833232,
		[893] = 34808832,
		[766] = 1140916256,
		[894] = 341084165,
		[320] = 536903684,
		[767] = 17825792,
		[448] = 285212674,
		[768] = 603979776,
		[321] = 131104,
		[769] = 37749760,
		[897] = 268435458,
		[770] = 8192,
		[898] = 2147483648,
		[258] = 134217728,
		[322] = 343937088,
		[771] = 35913728,
		[450] = 142611008,
		[772] = 67109376,
		[259] = 2181070848,
		[323] = 116,
		[773] = 33,
		[901] = 16416,
		[902] = 4112,
		[324] = 67641344,
		[388] = 4195648,
		[452] = 9216,
		[776] = 2097152,
		[325] = 33620036,
		[389] = 17826336,
		[778] = 3221233920,
		[326] = 4326929,
		[390] = 83886244,
		[327] = 2621440,
		[781] = 203423744,
		[782] = 973144064,
		[328] = 1225261152,
		[392] = 33554640,
		[784] = 2155872256,
		[329] = 335684352,
		[393] = 4097,
		[786] = 1073742848,
		[330] = 109576672,
		[394] = 55060480,
		[788] = 17825808,
		[331] = 1409319936,
		[789] = 3222798336,
		[790] = 631808,
		[332] = 35651584,
		[791] = 276889600,
		[792] = 34673936,
		[333] = 1199570968,
		[793] = 1234698528,
		[794] = 1344430080,
		[334] = 805306372,
		[795] = 2281703682,
		[923] = 2360320,
		[796] = 1572884,
		[924] = 131200,
		[335] = 805306368,
		[399] = 67108864,
		[925] = 841288704,
		[798] = 671220289,
		[926] = 2,
		[336] = 524416,
		[799] = 1210089472,
		[927] = 2684354560,
		[800] = 571740161,
		[337] = 306712832,
		[801] = 683952160,
		[929] = 33587200,
		[802] = 2684371200,
		[338] = 536875008,
		[402] = 3896508481,
		[931] = 805306368,
		[804] = 2759952384,
		[339] = 2415943748,
		[805] = 33044,
		[933] = 2147598336,
		[806] = 2420253304,
		[934] = 16781312,
		[340] = 134225920,
		[404] = 68157440,
		[935] = 29426752,
		[808] = 159434282,
		[936] = 536903680,
		[341] = 2151678609,
		[405] = 2177130528,
		[937] = 1057027,
		[810] = 6553633,
		[938] = 2147487744,
		[342] = 16777216,
		[406] = 1,
		[939] = 2216689809,
		[812] = 574620673,
		[343] = 256,
		[407] = 541853696,
		[941] = 16640,
		[814] = 25305490,
		[942] = 524288,
		[344] = 2552307730,
		[408] = 277350400,
		[943] = 320,
		[816] = 809501193,
		[345] = 16785546,
		[409] = 1280,
		[945] = 3221749760,
		[346] = 69271812,
		[410] = 262144,
		[820] = 234884000,
		[948] = 67207296,
		[347] = 4,
		[411] = 4,
		[822] = 1078989856,
		[348] = 1073741824,
		[412] = 134217728,
		[951] = 167772160,
		[824] = 1073754500,
		[952] = 2152726528,
		[285] = 1073741824,
		[349] = 1074004096,
		[413] = 2097152,
		[953] = 16777732,
		[826] = 1091593218,
		[954] = 64,
		[286] = 4194448,
		[350] = 1275199488,
		[827] = 1811941636,
		[955] = 2097920,
		[828] = 2220883978,
		[956] = 545267712,
		[351] = 268697620,
		[415] = 16822816,
		[957] = 134217732,
		[830] = 2189983808,
		[958] = 769,
		[352] = 12600627,
		[831] = 75564105,
		[959] = 64,
		[832] = 269549568,
		[960] = 2147483648,
		[289] = 134217728,
		[353] = 33587425,
		[417] = 2393089,
		[961] = 2290417664,
		[834] = 268963088,
		[962] = 4616,
		[290] = 2,
		[354] = 69337107,
		[418] = 2228804,
		[963] = 256,
		[836] = 40961,
		[291] = 32768,
		[355] = 16,
		[419] = 131080,
		[965] = 136,
		[838] = 268472452,
		[966] = 256,
		[292] = 1612709904,
		[356] = 134217764,
		[967] = 1145044992,
		[840] = 1342226432,
		[968] = 335544320,
		[293] = 8396800,
		[841] = 2560,
		[969] = 5,
		[179] = 4096,
		[842] = 69888,
		[970] = 2155872256,
		[294] = 134348992,
		[358] = 272629897,
		[422] = 2162690,
		[971] = 295440,
		[37] = 65536,
		[45] = 8192,
		[844] = 1212219392,
		[359] = 1073741824,
		[423] = 536871936,
		[122] = 65536,
		[846] = 155265556,
		[296] = 33554432,
		[424] = 2360640,
		[848] = 117981184,
		[976] = 6291456,
		[361] = 15761536,
		[849] = 535681,
		[977] = 2,
		[850] = 1073784848,
		[978] = 131072,
		[298] = 69214272,
		[362] = 674241536,
		[851] = 1109663905,
		[979] = 2048,
		[852] = 1074266112,
		[980] = 2147483650,
		[299] = 4608,
		[363] = 268699656,
		[853] = 393744,
		[981] = 1,
		[845] = 4096,
		[847] = 1073745920,
		[854] = 528384,
		[982] = 2147500032,
		[300] = 2415919104,
		[364] = 2717911156,
		[855] = 2625643360,
		[983] = 13,
		[797] = 1073741824,
		[861] = 1073741824,
		[856] = 21069827,
		[873] = 99652,
		[447] = 262272,
		[365] = 631308424,
		[857] = 2357199112,
		[895] = 4,
		[15] = 16,
		[829] = 393728,
		[858] = 2969698308,
		[26] = 32768,
		[302] = 268435520,
		[366] = 90121,
		[859] = 268442112,
		[987] = 1048576,
		[787] = 2206203968,
		[869] = 101335041,
		[860] = 1754581376,
		[811] = 805839888,
		[303] = 537395201,
		[843] = 2684616732,
		[431] = 32768,
		[819] = 16432,
		[837] = 448,
		[833] = 2214593251,
		[862] = 4160775200,
		[823] = 1073816152,
		[304] = 1091305476,
		[368] = 32768,
		[863] = 469766180,
		[991] = 67256320,
		[825] = 516,
		[835] = 287967493,
		[864] = 526464,
		[6] = 2,
		[305] = 1379279360,
		[5] = 553648128,
		[433] = 16844800,
		[993] = 4,
		[821] = 302596224,
		[865] = 50576,
		[866] = 2684354624,
		[803] = 100794408,
		[306] = 170131584,
		[370] = 285212672,
		[867] = 1076953088,
		[817] = 1377845250,
		[807] = 2689335328,
		[443] = 50331648,
		[868] = 1278754913,
		[996] = 6291456,
		[307] = 540083724,
		[371] = 134250504,
		[435] = 32896,
		[425] = 8519680,
		[809] = 68944384,
		[396] = 67239936,
		[779] = 269533704,
		[871] = 337448192,
		[308] = 2148581521,
		[372] = 29368488,
		[436] = 16865569,
		[385] = 16,
		[813] = 2147746372,
		[442] = 1179648,
		[872] = 1480605760,
		[1000] = 262144,
		[309] = 270536704,
		[373] = 2626064,
		[437] = 524289,
		[1001] = 4,
		[426] = 584,
		[401] = 1077937216,
		[874] = 18908160,
		[875] = 2013265920,
		[310] = 8388612,
		[374] = 739251200,
		[438] = 268566528,
		[783] = 134485056,
		[815] = 71631392,
		[391] = 621317000,
		[876] = 14746368,
		[877] = 106954752,
		[311] = 1610613376,
		[375] = 436208672,
		[439] = 25165834,
		[403] = 176193569,
		[429] = 2,
		[387] = 134217728,
		[878] = 1363181760,
		[444] = 16384,
		[312] = 2147485568,
		[376] = 1161826498,
		[879] = 817135625,
		[395] = 2,
		[432] = 50397184,
		[414] = 285215232,
		[880] = 1077350400,
		[449] = 263936,
		[313] = 1214455810,
		[377] = 1073741824,
		[881] = 33568,
		[384] = 8915208,
		[400] = 1079115812,
		[434] = 1082392714,
		[882] = 25231651,
		[27] = 536969217,
		[314] = 1241514050,
		[378] = 2148040968,
		[883] = 222330880,
		[397] = 16777344,
		[445] = 67125312,
		[446] = 2214592512,
		[884] = 2147483648,
		[416] = 128,
		[315] = 268435488,
		[379] = 268873736,
		[885] = 19712,
		[451] = 536871424,
}
Loremaster.partOfSeries = {
		[886] = 3094597523,
		[316] = 4171304320,
		[380] = 972285425,
		[887] = 1074663580,
		[888] = 58457087,
		[317] = 3187900418,
		[381] = 2479525884,
		[889] = 1089767648,
		[10] = 1073741824,
		[890] = 168887298,
		[20] = 128,
		[763] = 294912,
		[28] = 264,
		[764] = 16472,
		[892] = 2099200,
		[319] = 4265074707,
		[765] = 25165824,
		[893] = 385842240,
		[766] = 1679884384,
		[894] = 3755997983,
		[320] = 4280545237,
		[767] = 957383682,
		[895] = 125,
		[768] = 2768257025,
		[321] = 477618479,
		[769] = 314579968,
		[897] = 268591142,
		[770] = 67121152,
		[898] = 2149584032,
		[258] = 1505755136,
		[322] = 529005536,
		[771] = 108492800,
		[450] = 954208960,
		[772] = 1040533016,
		[259] = 2248310784,
		[323] = 3489927422,
		[773] = 1065,
		[901] = 114928,
		[774] = 33554432,
		[902] = 1118224,
		[260] = 1,
		[324] = 3739858945,
		[388] = 2160360931,
		[452] = 31744,
		[776] = 543162368,
		[325] = 4139975668,
		[389] = 664756195,
		[778] = 3774898432,
		[326] = 63172351,
		[390] = 633586149,
		[41] = 33554432,
		[780] = 4,
		[327] = 16744448,
		[391] = 3977101194,
		[782] = 973275267,
		[328] = 4181658592,
		[783] = 415511872,
		[784] = 2227191812,
		[329] = 472376064,
		[785] = 1073741825,
		[786] = 1616913408,
		[330] = 381288430,
		[787] = 2206208065,
		[788] = 17834035,
		[331] = 4101827838,
		[789] = 4227334218,
		[790] = 2287707137,
		[332] = 254710079,
		[791] = 3014729172,
		[792] = 246633747,
		[333] = 4290216185,
		[793] = 4290692918,
		[794] = 3492734991,
		[334] = 3073638413,
		[795] = 3634404162,
		[923] = 35982336,
		[42] = 83886080,
		[796] = 2755649596,
		[924] = 398208,
		[335] = 2107637775,
		[797] = 1679035445,
		[925] = 921635840,
		[798] = 682098647,
		[926] = 24670,
		[336] = 2066346432,
		[799] = 4163355168,
		[927] = 2986344448,
		[800] = 775943043,
		[928] = 872939520,
		[273] = 6144,
		[337] = 3204182337,
		[801] = 4259269552,
		[929] = 1717403664,
		[802] = 3791637425,
		[930] = 16,
		[338] = 4101910559,
		[803] = 4160643320,
		[931] = 809502720,
		[804] = 3197094012,
		[932] = 4,
		[339] = 2653157365,
		[805] = 1611654045,
		[933] = 2151792640,
		[806] = 3086417535,
		[934] = 2245906497,
		[340] = 3904909569,
		[404] = 207111928,
		[935] = 937283392,
		[808] = 1771896815,
		[936] = 4026589184,
		[341] = 2177050519,
		[405] = 2414669664,
		[937] = 1142600991,
		[810] = 1610385399,
		[938] = 3221278720,
		[342] = 50331648,
		[406] = 245881,
		[939] = 3886023125,
		[43] = 512,
		[812] = 1652247933,
		[940] = 1027,
		[343] = 8388864,
		[407] = 3864791552,
		[941] = 901376,
		[814] = 533668767,
		[942] = 671875072,
		[344] = 2552307763,
		[408] = 872261873,
		[943] = 868,
		[816] = 2084758047,
		[345] = 17965194,
		[409] = 1284,
		[945] = 3221872641,
		[818] = 792448,
		[946] = 5,
		[346] = 207815428,
		[410] = 24449025,
		[820] = 1310453744,
		[948] = 80449152,
		[347] = 12,
		[411] = 20,
		[949] = 128,
		[174] = 4096,
		[206] = 268435456,
		[348] = 3221225472,
		[823] = 3352259545,
		[951] = 2332037120,
		[824] = 3222155695,
		[952] = 3436740608,
		[285] = 1246625792,
		[349] = 1074528386,
		[825] = 2248545838,
		[953] = 51376652,
		[9] = 1048576,
		[826] = 3249632646,
		[954] = 64,
		[18] = 64,
		[350] = 4229038210,
		[827] = 3960208173,
		[955] = 2149582592,
		[387] = 2550136832,
		[828] = 2364449151,
		[956] = 563019712,
		[847] = 1076108288,
		[351] = 3497299199,
		[415] = 25228914,
		[957] = 134217743,
		[829] = 608145279,
		[835] = 3077562239,
		[830] = 2260242508,
		[958] = 201358105,
		[288] = 8,
		[352] = 1206124351,
		[831] = 3062890447,
		[959] = 1090,
		[861] = 3372222464,
		[286] = 15363984,
		[832] = 4231381121,
		[960] = 2717909004,
		[289] = 402653184,
		[353] = 4262576111,
		[833] = 3220895743,
		[961] = 2308767744,
		[837] = 562053062,
		[821] = 2001715616,
		[834] = 3540536631,
		[962] = 1083964943,
		[290] = 2,
		[354] = 1694154783,
		[418] = 134217292,
		[963] = 7424,
		[845] = 286650390,
		[855] = 4287492064,
		[836] = 2164111239,
		[964] = 64,
		[291] = 134332416,
		[355] = 536871024,
		[419] = 131288,
		[965] = 1986760,
		[385] = 496,
		[15] = 16,
		[838] = 504340437,
		[966] = 4200704,
		[292] = 3928033361,
		[356] = 467796076,
		[839] = 207126784,
		[967] = 3468722178,
		[811] = 4028167288,
		[843] = 4226023452,
		[840] = 3489710432,
		[968] = 1027751950,
		[293] = 830496768,
		[357] = 1082133046,
		[841] = 54721280,
		[969] = 131079,
		[819] = 8962161,
		[179] = 4096,
		[842] = 68227840,
		[970] = 2508193792,
		[294] = 136736194,
		[358] = 282029967,
		[422] = 14754890,
		[971] = 363058,
		[37] = 720896,
		[45] = 67166208,
		[844] = 1606615298,
		[972] = 704708736,
		[295] = 2147549184,
		[359] = 1077706757,
		[423] = 539101056,
		[122] = 196608,
		[6] = 31,
		[5] = 4009754624,
		[846] = 1003743798,
		[974] = 4096,
		[296] = 33554432,
		[360] = 832,
		[424] = 36552641,
		[975] = 134217728,
		[815] = 1851741803,
		[817] = 4129550859,
		[848] = 1063239696,
		[976] = 677380096,
		[392] = 385999615,
		[361] = 553432704,
		[849] = 188279967,
		[977] = 4098,
		[443] = 53409920,
		[809] = 1551796767,
		[850] = 3225402937,
		[978] = 2953183808,
		[298] = 70263104,
		[362] = 4227857445,
		[426] = 1462984,
		[979] = 1073747968,
		[807] = 3992854179,
		[973] = 1073741824,
		[852] = 3296201728,
		[980] = 2147483650,
		[299] = 103969,
		[363] = 2998894543,
		[853] = 4261282397,
		[981] = 7,
		[449] = 58564352,
		[416] = 384,
		[854] = 805843459,
		[982] = 2147565568,
		[300] = 2550661120,
		[364] = 4139802367,
		[428] = 2,
		[983] = 13,
		[399] = 335544321,
		[394] = 3019667484,
		[856] = 164077571,
		[984] = 12582912,
		[301] = 2,
		[365] = 4293229563,
		[857] = 4236247416,
		[442] = 1246208,
		[447] = 31204024,
		[891] = 66062439,
		[858] = 2970225101,
		[430] = 2147483680,
		[302] = 2953183946,
		[366] = 1304575,
		[859] = 2663512697,
		[987] = 3145728,
		[413] = 8126472,
		[382] = 1007998631,
		[860] = 2023088122,
		[398] = 3758096384,
		[303] = 2829588543,
		[441] = 6504448,
		[431] = 4232240,
		[989] = 128,
		[444] = 344257,
		[27] = 536976629,
		[862] = 4160943140,
		[383] = 1444890457,
		[304] = 3910010892,
		[368] = 4163584,
		[432] = 318832640,
		[991] = 203046912,
		[412] = 402653184,
		[384] = 3237559166,
		[864] = 1579143,
		[992] = 569376769,
		[305] = 2122198531,
		[433] = 1394051584,
		[865] = 3397174672,
		[993] = 4,
		[425] = 46596096,
		[396] = 67242014,
		[866] = 3925868737,
		[434] = 3769896094,
		[306] = 2124815744,
		[370] = 4177526784,
		[867] = 4013887745,
		[995] = 4096,
		[851] = 3554959871,
		[435] = 212385939,
		[868] = 1815797475,
		[996] = 6291456,
		[307] = 4151526924,
		[371] = 4190339177,
		[869] = 1727972315,
		[781] = 522191104,
		[400] = 3271434854,
		[813] = 2608721532,
		[870] = 268435456,
		[998] = 2304,
		[308] = 2148647863,
		[372] = 2411750060,
		[436] = 159899425,
		[999] = 1073741824,
		[439] = 25575819,
		[873] = 201835895,
		[872] = 1591757248,
		[1000] = 537133056,
		[309] = 3089584775,
		[373] = 3614995186,
		[437] = 2646109,
		[1001] = 4,
		[414] = 1463840256,
		[25] = 8388608,
		[874] = 2435023872,
		[438] = 841089024,
		[310] = 58720271,
		[374] = 3966891777,
		[875] = 2013265920,
		[397] = 58786208,
		[39] = 512,
		[403] = 3957309295,
		[876] = 2313755399,
		[402] = 4234999759,
		[311] = 1662698118,
		[375] = 4194678526,
		[877] = 2666528768,
		[871] = 1577029376,
		[401] = 3402393024,
		[188] = 1024,
		[878] = 4249409731,
		[429] = 4194306,
		[312] = 2267635680,
		[376] = 3715169230,
		[879] = 1978967805,
		[822] = 1255396415,
		[448] = 495059790,
		[26] = 821256,
		[880] = 3305094816,
		[863] = 4230516975,
		[313] = 1609525346,
		[377] = 1890393339,
		[881] = 3155338045,
		[393] = 2147520515,
		[318] = 2482215616,
		[899] = 8192,
		[882] = 369055527,
		[446] = 3033008640,
		[314] = 1778385218,
		[378] = 2412574655,
		[883] = 796645248,
		[779] = 494716472,
		[395] = 3742634494,
		[417] = 275745819,
		[884] = 2149580836,
		[445] = 1820975168,
		[315] = 3694399603,
		[379] = 4043307919,
		[885] = 696471307,
		[451] = 2684357120,
}
	
Loremaster.tcoords = {
	[1] = {0, 32, 0, 32},
	[2] = {32, 64, 0, 32},
	[3] = {64, 96, 0, 32},
	[4] = {96, 128, 0, 32},
	[5] = {128, 160, 0, 32},
	[6] = {160, 192, 0, 32},
	[7] = {192, 224, 0, 32},
	[8] = {224, 256, 0, 32},
	[9] = {0, 32, 32, 64},
	[10] = {32, 64, 32 , 64},
	[11] = {64, 96, 32, 64},
	[12] = {96, 128, 32, 64},
	[13] = {128, 160, 32, 64},
	[14] = {160, 192, 32, 64},
}

Loremaster.icons = {
	[1] = {0, 0.125, 0, 0.5},
	[2] = {0.125, 0.25, 0, 0.5},
	[3] = {0.25, 0.375, 0, 0.5},
	[4] = {0.375, 0.5, 0, 0.5},
	[5] = {0.5, 0.675, 0, 0.5},
	[6] = {0.675, 0.75, 0, 0.5},
	[7] = {0.75, 0.875, 0, 0.5},
	[8] = {0.875, 1, 0, 0.5},
	[9] = {0, 0.125, 0.5, 1},
	[10] = {0.125, 0.25, 0.5 , 1},
	[11] = {0.25, 0.375, 0.5, 1},
	[12] = {0.375, 0.5, 0.5, 1},
	[13] = {0.5, 0.675, 0.5, 1},
	[14] = {0.675, 0.75, 0.5, 1},
}

--Hijacked from Powerauras
StaticPopupDialogs["LOREMASTER_WOWHEAD"] = {
	text = L["Copy and paste into your web browser"],
	button1 = _G.DONE,
	hasEditBox = 1,
	maxLetters = 35,
	hasWideEditBox = 1,
	editBoxWidth = 250,
	OnShow = function(this)
				this.editBox:SetText(Loremaster.WHtext);
				this.editBox:SetFocus();
				this.editBox:HighlightText();
			end,
	OnHide = function(this)
				ChatEdit_FocusActiveWindow(); 
				this.editBox:SetText("");
			end,
	EditBoxOnEnterPressed = function(this) this:GetParent():Hide();	end,
	EditBoxOnEscapePressed = function(this) this:GetParent():Hide(); end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
}