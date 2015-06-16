local _, T = ...
local L, RingKeeper = T.L, OneRingLib and OneRingLib.ext and OneRingLib.ext.RingKeeper
if not (RingKeeper and RingKeeper.SetRing) then return end

RingKeeper:SetRing("DruidShift", {
	{id="/cancelform [noflyable]\n/cast [flyable,outdoors,nocombat,noswimming,nomod][flying] {{spell:40120/33943}}; [outpost:corral,nomod,nospec:103/104] {{spell:161691}}; [swimming,nomod][glyph:1127,outdoors,nomod][noglyph:164,flyable,nomod][noglyph:164,flying] {{spell:783}}; [nocombat,outdoors,nomod:alt] {{mount:ground}}; [outdoors] {{spell:783}}", show="[known:40120/33943/1066/783]", _u="f"}, -- Travel
	{c="c74cff", id=24858, _u="k"}, -- Moonkin
	{c="fff04d", id=768, _u="c"}, -- Cat
	{c="ff0000", id=5487, _u="b"}, -- Bear
	name=L"Shapeshifts", hotkey="PRIMARY", limit="DRUID", _u="OPCDS"
});
RingKeeper:SetRing("DruidUtility", {
	{id="/cast [combat][mod] {{spell:20484}}; {{spell:50769}}", _u="r"}, -- rebirth/revive
	{id="/cast [help,noraid][@player] {{spell:1126}}", _u="m"}, -- mark
	{id="/cast [mod] {{spell:16914}}; {{spell:740/16914}}", _u="t"}, -- hurricane/tranq
	{id="/cast [nomod] {{spell:22812}}; {{spell:61336/22812}}", _u="b"}, -- bark/survival
	{id="/cast {{spell:33891/102560}}", _u="i"}, -- Incarnation
	{id="/cast [@target,harm][@none] {{spell:2908}}", _u="s"}, -- Soothe
	{id="/cast [combat][mod] {{spell:88423/2782}}; {{spell:18960}}", _u="p"}, -- moonglade/cleanse
	name=L"Utility", hotkey="[noform:bear/cat] SECONDARY; ALT-SECONDARY", limit="DRUID", _u="OPCDU"
});
RingKeeper:SetRing("DruidFeral", {
	{id=50334, _u="k"}, -- berserk
	{id="/cast [noform:bear] {{spell:5217}}; {{spell:22842}}", _u="e"}, -- frenzied / tiger's fury
	{id="/cast [mod] {{spell:1850}}; [form:bear] {{spell:77761}}; {{spell:77764}}", _u="r"}, -- dash / stampeding roar
	{id=106839, _u="s"}, -- skull bash
	{id=22812, _u="b"}, -- barkskin
	{id=61336, _u="i"}, -- survival instincts
	{id=102401, _u="c"}, -- feral charge
	{id="/cast {{spell:102543/102558}}", _u="n"}, -- Incarnation
	{id="/cast [nomod,@player][mod,@none] {{spell:5185}}", show="[spec:102/104/105] hide;", _u="h"}, -- HT
	name=L"Feral", hotkey="[form:bear/cat] SECONDARY; ALT-SECONDARY", limit="DRUID", _u="OPCDF"
});

RingKeeper:SetRing("HunterAspects", {
	{id=5118, _u="c"}, -- cheetah
	{id=13159, _u="p"}, -- pack
	{id=781, _u="d"}, -- disengage
	{id=5384, _u="g"}, -- feign
	{id="/cast [@pet,noexists,nomod] {{spell:883}}; [@pet,dead][@pet,noexists] {{spell:982}}; [@pet,help,nomod] {{spell:136}}; [@pet] {{spell:2641}}", show="[known:883]", _u="e"},
	name=L"Aspects", hotkey="PRIMARY", limit="HUNTER", _u="OPCHA"
});
RingKeeper:SetRing("HunterTraps", {
	{id=13813, _u="e"}, -- explosive
	{id=1499, _u="f"}, -- freezing
	{id=13809, _u="c"}, -- ice
	{id=34600, _u="s"}, -- snake
	{id=77769, _u="l"}, -- launcher
	name=L"Traps", hotkey="ALT-SECONDARY", limit="HUNTER", _u="OPCHT"
});
RingKeeper:SetRing("HunterShots", {
	{id=20736, _u="d"}, -- distract
	{id=19801, _u="t"}, -- tranq
	{id=53351, _u="k"}, -- kill
	{id=2643, _u="m"}, -- multi
	{id=1130, _u="a"}, -- mark
	name=L"Shots", hotkey="SECONDARY", limit="HUNTER", _u="OPCHS"
});

RingKeeper:SetRing("MageCombat", {
	{id=45438, _u="i"}, -- block
	{id=12043, _u="p"}, -- pom
	{id=30449, _u="s"}, -- spellsteal
	{id=55342, _u="m"}, -- mirror
	{id=12051, _u="e"}, -- evo
	{id=12042, _u="a"}, -- ap
	{id=80353, _u="t"}, -- tw
	name=L"Combat", limit="MAGE", hotkey="PRIMARY", _u="OPCMC"
})
RingKeeper:SetRing("MageTools", {
	{id=1459, _u="i"}, -- int
	{id=43987, _u="r"}, -- ritual
	{id=42955, _u="f"}, -- food
	{id=759, _u="g"}, -- gem
	{"ring", "MageTravel", onlyNonEmpty=true, _u="t"},
	{id=130, _u="s"},
	{id="/cast [help,raid,nomod][@player] {{spell:475}}", _u="c"},
	name=L"Utility", limit="MAGE", hotkey="SECONDARY", _u="OPCMT"
})
do -- MageTravel
	local m = "/cast [mod] {{spell:%s}}; {{spell:%s}}";
	RingKeeper:SetRing("MageTravel", {
		{id=m:format("176246/176244", "176248/176242"), _u="h"}, -- Ashran
		{id=m:format("132620/132626", "132621/132627"), _u="v"}, -- Vale of Eternal Blossoms
		{id=m:format("88346/88345", "88344/88342"), _u="b"}, -- Tol Barad
		{id=m:format(53142, 53140), _u="r"}, -- Dalaran
		{id=m:format("35717/33691", 33690), _u="s"}, -- Shattrath
		{id=m:format(10059, 3561), _u="w"}, -- Stormwind
		{id=m:format(11419, 3565), _u="d"}, -- Darnassus
		{id=m:format(11420, 3566), _u="t"}, -- Thunder Bluff
		{id=m:format(11418, 3563), _u="u"}, -- Undercity
		{id=m:format(11416, 3562), _u="i"}, -- Ironforge
		{id=m:format(11417, 3567), _u="o"}, -- Orgrimmar
		{id=m:format(49360, 49359), _u="m"}, -- Theramore
		{id=m:format(49361, 49358), _u="n"}, -- Stonard
		{id=m:format(32267, 32272), _u="l"}, -- Silvermoon
		{id=m:format(32266, 32271), _u="x"}, -- Exodar
		{id=m:format(120146, 120145), _u="a"}, -- Ancient Dalaran
	  name=L"Portals and Teleports", hotkey="ALT-G", limit="MAGE", _u="OPCMP"
	});
end

RingKeeper:SetRing("PaladinAuras", {
	{"ring", "PaladinSeal", onlyNonEmpty=true, _u="e"},
	{"ring", "PaladinBlessing", onlyNonEmpty=true, _u="b"},
	{id=25780, _u="f"}, -- righteous fury
	name=L"Paladin Buffs", hotkey="PRIMARY", limit="PALADIN", _u="OPCPA"
});
RingKeeper:SetRing("PaladinSeal", {
	{id=20154, _u="r"}, -- righteousness
	{id=31801, _u="t"}, -- truth
	{c="902020", id=20164, _u="j"}, -- justice
	{id=20165, _u="i"}, -- insight
	name=L"Seals", limit="PALADIN", internal=true, _u="OPCPS"
});
RingKeeper:SetRing("PaladinBlessing", {
	{id=20217, _u="k"}, -- kings
	{id=19740, _u="m"}, -- might
	name=L"Blessings", limit="PALADIN", internal=true, _u="OPCPB"
});
RingKeeper:SetRing("PaladinTools", {
	{id=853, _u="h"}, -- hammer
	{id=85673, _u="g"}, -- glory
	{c="ed8f1b", id=498, _u="p"}, -- divine protection
	{id=31884, _u="a"}, -- avenging wrath
	{id=1022, _u="t"}, -- hand of protection
	{id=1044, _u="f"}, -- hand of freedom
	{id=1038, _u="s"}, -- hand of salvation
	{id=62124, _u="r"}, -- hand of reckoning
	{id=26573, _u="c"}, -- consecration
	name=L"Utility", limit="PALADIN", hotkey="SECONDARY", _u="OPCPT"
});
RingKeeper:SetRing("WarlockLTS", {
	{"ring", "WarlockDemons", _u="d"},
	{id="/cast [mod][noknown:119898] {{spell:755}}; {{spell:119898}}", _u="a"}, -- funnel/command
	{id=109773, _u="i"}, -- intent
	{id="/cast [mod:alt] {{spell:20707}}; [group,nomod][nogroup,mod] {{spell:29893}}; {{spell:6201}}", _u="h"}, -- soul/health/well
	{id=111771, _u="w"}, -- gateway
	{"ring", "WarlockGuardians", _u="g"},
	{id="/cast [flyable,nocombat,nomod] {{mount:air}}; [outdoors,nocombat,nomod:alt] {{mount:ground}}; {{spell:126}}", _u="e"}, -- mount/eye
	name=L"Warlock General", hotkey="PRIMARY", limit="WARLOCK", _u="OPCLS"
})
RingKeeper:SetRing("WarlockCombat", {
	{id="/cast [nomod] {{spell:48018}}; {{spell:48020}}", _u="t"}, -- demonic circle
	{id=1098, _u="e"}, -- enslave
	{id=710, _u="a"}, -- banish
	{id="/cast {{spell:111400}}; {{spell:111397}}; {{spell:108482}}", _u="m"}, -- tier 4 talents [combat-ish]
	{id=5782, _u="f"}, -- fear
	{id=5484, _u="h"}, -- howl
	name=L"Warlock Combat", hotkey="SECONDARY", limit="WARLOCK", _u="OPCLO"
})
RingKeeper:SetRing("WarlockDemons", {
	{id=30146, _u="f"}, -- felguard
	{id=697, _u="v"}, -- void
	{id=688, _u="i"}, -- imp
	{id=712, _u="s"}, -- succubus
	{id=691, _u="h"}, -- felhunter
	name=L"Demons", limit="WARLOCK", _u="OPCLD", internal=true
});
RingKeeper:SetRing("WarlockGuardians", {
	{id=18540, _u="d"}, -- doomguard
	{id=1122, _u="i"}, -- infernal
	name=L"Guardians", limit="WARLOCK", _u="OPCLG", internal=true
})

RingKeeper:SetRing("WarriorStances", {
	{id=2457, _u="a"},
	{id=71, _u="d"},
	name=L"Stances", hotkey="PRIMARY", limit="WARRIOR", _u="OPCWS"
});

RingKeeper:SetRing("DeathKnightPresence", {
	{c="52ff5a", id="/cast [help,dead] {{spell:61999}}; [nopet,nomounted][@pet,dead] {{spell:46584}}; [@pet,nodead,exists][nomod] {{spell:47541}}; [mod] {{spell:48743}}", _u="p"}, -- ghoul
	{c="e54c19", id=48263, _u="b"}, -- blood
	{c="1999e5", id=48266, _u="f"}, -- frost
	{c="4ce519", id=48265, _u="u"}, -- unholy
	{c="a93ae8", id=50977, _u="g"}, -- gate
	{c="e8c682", id="/cast [flyable,nomod][flying] {{spell:54729}}; {{spell:48778}}; [flyable,nomod][flying] {{mount:air}}; {{mount:ground}}", _u="m"},
	{c="63eaff", id=3714, _u="o"}, -- path of frost
	name=L"Presences", hotkey="PRIMARY", limit="DEATHKNIGHT", _u="OPCDP"
});
RingKeeper:SetRing("DKCombat", {
	{c="fff4b2", id=57330, _u="h"}, -- horn
	{c="5891ea", id=48792, _u="f"}, -- fortitude
	{c="bcf800", id=48707, _u="s"}, -- shell
	{c="3d63cc", id=51052, _u="z"}, -- Zone
	{c="b7d271", id=49222, _u="i"}, -- shield
	{c="b31500", id=55233, _u="b"}, -- blood
	{c="aef1ff", id=51271, _u="p"}, -- pillar of frost
	{c="d0d0d0", id=49039, _u="l"}, -- lich
	name=L"Combat", hotkey="SECONDARY", limit="DEATHKNIGHT", _u="OPCDC"
});

RingKeeper:SetRing("CommonTrades", {
	{id="/cast {{spell:3908/51309}}", _u="t"}, -- tailoring
	{id="/cast {{spell:2108/51302}}", _u="l"}, -- leatherworking
	{id="/cast {{spell:2018/51300}}", _u="b"}, -- blacksmithing
	{id="/cast [mod] {{spell:31252}}; {{spell:25229/51311}};", _u="j"}, -- jewelcrafting/prospecting
	{id="/cast [mod] {{spell:13262}}; {{spell:7411/51313}}", _u="e"}, -- enchanting/disenchanting
	{id="/cast {{spell:2259/51304}}", _u="a"}, -- alchemy
	{id="/cast [mod] {{spell:818}}; {{spell:2550/51296}}", _u="c"}, -- cooking/campfire
	{id="/cast [mod] {{spell:51005}}; {{spell:45357/45363}}", _u="i"}, -- inscription/milling
	{id="/cast {{spell:3273/45542}}", _u="f"}, -- first aid
	{id="/cast {{spell:4036/51306}}", _u="g"}, -- engineering
	{id="/cast [mod] {{spell:80451}}; {{spell:78670/89722}}", _u="r"},
	{id=53428, _u="u"}, -- runeforging
	{id=2656, _u="m"}, -- smelting
	name=L"Trade Skills", hotkey="ALT-T", _u="OPCCT"
});
RingKeeper:SetRing("WorldMarkers", {
	{"worldmark", 1, _u="b"},
	{"worldmark", 2, _u="g"},
	{"worldmark", 3, _u="p"},
	{"worldmark", 4, _u="r"},
	{"worldmark", 5, _u="y"},
	{"worldmark", 6, _u="o"},
	{"worldmark", 7, _u="s"},
	{"worldmark", 8, _u="w"},
	{"worldmark", 0, c="ccd8e5", _u="c"}, -- clear
	name=L"World Markers", hotkey="ALT-Y", _u="OPCWM"
});
RingKeeper:SetRing("RaidSymbols", {
	{"raidmark", 1, _u="y"}, -- yellow star
	{"raidmark", 2, _u="o"}, -- orange circle
	{"raidmark", 3, _u="p"}, -- purple diamond
	{"raidmark", 4, _u="g"}, -- green triangle
	{"raidmark", 5, _u="s"}, -- silver moon
	{"raidmark", 6, _u="b"}, -- blue square
	{"raidmark", 7, _u="r"}, -- red cross
	{"raidmark", 8, _u="w"}, -- white skull
	{"raidmark", 0, _u="c"}, -- clear all
	name=L"Target Markers", hotkey="ALT-R", _u="OPCRS"
});