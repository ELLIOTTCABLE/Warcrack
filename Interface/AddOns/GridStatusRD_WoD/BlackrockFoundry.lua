--local zone = "Blackrock Foundry"
local zoneid = 988

--zoneid, debuffID, order, icon_priority, colorpriority, timer, stackable, color, defaultdisable, noicon
--true, true is for stackable

--Trash

-- Check Compatibility
if GridStatusRD_WoD.rd_version < 600 then
	return
end

--Blackhand
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Blackhand")
GridStatusRaidDebuff:DebuffId(zoneid, 156096, 11, 4, 4) --MARKEDFORDEATH
GridStatusRaidDebuff:DebuffId(zoneid, 156743, 12, 7, 7) --IMPALED
GridStatusRaidDebuff:DebuffId(zoneid, 156047, 13, 6, 6) --SLAGGED
GridStatusRaidDebuff:DebuffId(zoneid, 156401, 14, 5, 5, true, true) --MOLTENSLAG
GridStatusRaidDebuff:DebuffId(zoneid, 156404, 15, 6, 6, true, true) --BURNED
GridStatusRaidDebuff:DebuffId(zoneid, 158054, 17, 7, 7) --SHATTERINGSMASH 158054 155992 159142
GridStatusRaidDebuff:DebuffId(zoneid, 156888, 18, 5, 5) --OVERHEATED
GridStatusRaidDebuff:DebuffId(zoneid, 157000, 19, 4, 4) --ATTACHSLAGBOMBS
GridStatusRaidDebuff:DebuffId(zoneid, 156999, 20, 4, 4) --THROWSLAGBOMBS

--Beastlord Darmac
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Beastlord Darmac")
GridStatusRaidDebuff:DebuffId(zoneid, 154960, 31, 6, 6) --PINNEDDOWN
GridStatusRaidDebuff:DebuffId(zoneid, 155061, 32, 5, 5, true, true) --RENDANDTEAR
GridStatusRaidDebuff:DebuffId(zoneid, 155030, 33, 6, 6) --SEAREDFLESH
GridStatusRaidDebuff:DebuffId(zoneid, 155236, 34, 6, 6, true, true) --CRUSHARMOR
GridStatusRaidDebuff:DebuffId(zoneid, 159044, 35, 6, 6) --EPICENTRE
GridStatusRaidDebuff:DebuffId(zoneid, 162276, 36, 6, 6) --UNSTEADY Mythic
GridStatusRaidDebuff:DebuffId(zoneid, 155657, 37, 6, 6) --FLAMEINFUSION
GridStatusRaidDebuff:DebuffId(zoneid, 155222, 38, 6, 6) --TANTRUM
GridStatusRaidDebuff:DebuffId(zoneid, 155399, 39, 6, 6) --CONFLAGRATION
GridStatusRaidDebuff:DebuffId(zoneid, 154989, 40, 6, 6) --INFERNOBREATH
GridStatusRaidDebuff:DebuffId(zoneid, 155499, 41, 6, 6) --SUPERHEATEDSHRAPNEL

--Flamebender Ka'graz
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Flamebender Ka'graz")
GridStatusRaidDebuff:DebuffId(zoneid, 155318, 51, 5, 5) --LAVASLASH
GridStatusRaidDebuff:DebuffId(zoneid, 155277, 52, 4, 4) --BLAZINGRADIANCE
GridStatusRaidDebuff:DebuffId(zoneid, 154952, 53, 4, 4) --FIXATE
GridStatusRaidDebuff:DebuffId(zoneid, 155074, 54, 6, 6, true, true) --CHARRINGBREATH
GridStatusRaidDebuff:DebuffId(zoneid, 163284, 55, 5, 5, true, true) --RISINGFLAME
GridStatusRaidDebuff:DebuffId(zoneid, 162293, 56, 5, 5) --EMPOWEREDARMAMENT
GridStatusRaidDebuff:DebuffId(zoneid, 155493, 57, 5, 5) --FIRESTORM
GridStatusRaidDebuff:DebuffId(zoneid, 163633, 58, 5, 5) --MAGMAMONSOON

--Operator Thogar 
GridStatusRaidDebuff:BossNameId(zoneid, 60, "Operator Thogar")
GridStatusRaidDebuff:DebuffId(zoneid, 155921, 61, 5, 5, true, true) --ENKINDLE
GridStatusRaidDebuff:DebuffId(zoneid, 165195, 62, 5, 5) --PROTOTYPEPULSEGRENADE
GridStatusRaidDebuff:DebuffId(zoneid, 155701, 63, 5, 5) --SERRATEDSLASH
GridStatusRaidDebuff:DebuffId(zoneid, 156310, 64, 5, 5) --LAVASHOCK
GridStatusRaidDebuff:DebuffId(zoneid, 164380, 65, 5, 5, true, true) --BURNING

--The Blast Furnace
GridStatusRaidDebuff:BossNameId(zoneid, 70, "The Blast Furnace")
GridStatusRaidDebuff:DebuffId(zoneid, 155240, 71, 6, 6) --TEMPERED
GridStatusRaidDebuff:DebuffId(zoneid, 155242, 72, 5, 5) --HEAT
GridStatusRaidDebuff:DebuffId(zoneid, 176133, 73, 4, 4) --BOMB
GridStatusRaidDebuff:DebuffId(zoneid, 156934, 74, 5, 5) --RUPTURE
GridStatusRaidDebuff:DebuffId(zoneid, 175104, 75, 6, 6) --MELTARMOR
GridStatusRaidDebuff:DebuffId(zoneid, 176121, 76, 4, 4) --VOLATILEFIRE
GridStatusRaidDebuff:DebuffId(zoneid, 158702, 77, 4, 4) --FIXATE
GridStatusRaidDebuff:DebuffId(zoneid, 155225, 78, 5, 5) --MELT

--Hans'gar and Franzok 
GridStatusRaidDebuff:BossNameId(zoneid, 80, "Hans'gar and Franzok")
GridStatusRaidDebuff:DebuffId(zoneid, 157139, 81, 6, 6) --SHATTEREDVERTEBRAE
GridStatusRaidDebuff:DebuffId(zoneid, 161570, 82, 5, 5) --SEARINGPLATES
GridStatusRaidDebuff:DebuffId(zoneid, 157853, 83, 5, 5) --AFTERSHOCK
GridStatusRaidDebuff:DebuffId(zoneid, 156938, 84, 6, 6) --CRIPPLINGSUPLEX

--Gruul
GridStatusRaidDebuff:BossNameId(zoneid, 90, "Gruul")
GridStatusRaidDebuff:DebuffId(zoneid, 155080, 91, 5, 5) --INFERNOSLICE
GridStatusRaidDebuff:DebuffId(zoneid, 143962, 92, 6, 6) --INFERNOSTRIKE 
GridStatusRaidDebuff:DebuffId(zoneid, 155078, 93, 6, 6) --OVERWHELMINGBLOWS
GridStatusRaidDebuff:DebuffId(zoneid, 36240, 94, 5, 5) --CAVEIN
GridStatusRaidDebuff:DebuffId(zoneid, 155326, 95, 5, 5) --PETRIFYING SLAM
GridStatusRaidDebuff:DebuffId(zoneid, 165300, 96, 6, 6) --FLARE Mythic

--Kromog
GridStatusRaidDebuff:BossNameId(zoneid, 100, "Kromog")
GridStatusRaidDebuff:DebuffId(zoneid, 157060, 101, 5, 5) --RUNEOFGRASPINGEARTH
GridStatusRaidDebuff:DebuffId(zoneid, 156766, 102, 6, 6, true, true) --WARPEDARMOR
GridStatusRaidDebuff:DebuffId(zoneid, 161839, 103, 7, 7) --RUNEOFCRUSHINGEARTH
GridStatusRaidDebuff:DebuffId(zoneid, 156844, 104, 7, 7) --STONEBREATH

--Oregorger
GridStatusRaidDebuff:BossNameId(zoneid, 110, "Oregorger")
GridStatusRaidDebuff:DebuffId(zoneid, 156309, 111, 6, 6) --ACIDTORRENT
GridStatusRaidDebuff:DebuffId(zoneid, 156203, 112, 5, 5) --RETCHEDBLACKROCK
--GridStatusRaidDebuff:DebuffId(zoneid, EXPLOSIVESHARD, 11, 7, 7)
GridStatusRaidDebuff:DebuffId(zoneid, 173471, 113, 5, 5) --ACIDMAW

--The Iron Maidens
GridStatusRaidDebuff:BossNameId(zoneid, 120, "The Iron Maidens")
GridStatusRaidDebuff:DebuffId(zoneid, 164271, 121, 6, 6) --PENETRATINGSHOT
GridStatusRaidDebuff:DebuffId(zoneid, 158315, 122, 6, 6) --DARKHUNT
GridStatusRaidDebuff:DebuffId(zoneid, 156601, 123, 6, 6) --SANGUINESTRIKES
GridStatusRaidDebuff:DebuffId(zoneid, 170395, 124, 6, 6) --SORKASPREY
GridStatusRaidDebuff:DebuffId(zoneid, 170405, 125, 6, 6) --MARAKSBLOODCALLING
GridStatusRaidDebuff:DebuffId(zoneid, 158692, 126, 6, 6) --DEADLYTHROW
GridStatusRaidDebuff:DebuffId(zoneid, 158702, 127, 4, 4) --FIXATE
GridStatusRaidDebuff:DebuffId(zoneid, 158686, 128, 6, 6) --EXPOSEARMOR
GridStatusRaidDebuff:DebuffId(zoneid, 158683, 129, 5, 5) --CORRUPTEDBLOOD
GridStatusRaidDebuff:DebuffId(zoneid, 159585, 130, 5, 5) --DEPLOYTURRET
GridStatusRaidDebuff:DebuffId(zoneid, 156112, 131, 5, 5, true, true) --CONVULSIVESHADOWS

