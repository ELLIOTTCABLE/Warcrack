--[[
Name: LibBabble-CreatureType-3.0
Revision: $Rev: 154 $
Maintainers: ckknight, nevcairiel, Ackis
Website: http://www.wowace.com/projects/libbabble-creaturetype-3-0/
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-CreatureType-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 154 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local GAME_LOCALE = GetLocale()

lib:SetBaseTranslations {
	Aberration = "Aberration",
	Abyssal = "Abyssal",
	Basilisk = "Basilisk",
	Bat = "Bat",
	Bear = "Bear",
	Beast = "Beast",
	Beetle = "Beetle",
	["Bird of Prey"] = "Bird of Prey",
	Boar = "Boar",
	["Carrion Bird"] = "Carrion Bird",
	Cat = "Cat",
	Chimaera = "Chimaera",
	Clefthoof = "Clefthoof",
	["Core Hound"] = "Core Hound",
	Crab = "Crab",
	Crane = "Crane",
	Critter = "Critter",
	Crocolisk = "Crocolisk",
	Demon = "Demon",
	Devilsaur = "Devilsaur",
	Direhorn = "Direhorn",
	Dog = "Dog",
	Doomguard = "Doomguard",
	Dragonhawk = "Dragonhawk",
	Dragonkin = "Dragonkin",
	Elemental = "Elemental",
	Felguard = "Felguard",
	Felhunter = "Felhunter",
	["Fel Imp"] = "Fel Imp",
	Fox = "Fox",
	["Gas Cloud"] = "Gas Cloud",
	Ghoul = "Ghoul",
	Giant = "Giant",
	Goat = "Goat",
	Gorilla = "Gorilla",
	Humanoid = "Humanoid",
	Hydra = "Hydra",
	Hyena = "Hyena",
	Imp = "Imp",
	Mechanical = "Mechanical",
	Monkey = "Monkey",
	Moth = "Moth",
	["Nether Ray"] = "Nether Ray",
	["Non-combat Pet"] = "Non-combat Pet",
	["Not specified"] = "Not specified",
	Observer = "Observer",
	Porcupine = "Porcupine",
	Quilen = "Quilen",
	Raptor = "Raptor",
	Ravager = "Ravager",
	["Remote Control"] = "Remote Control",
	Rhino = "Rhino",
	Riverbeast = "Riverbeast",
	Rylak = "Rylak",
	Scorpid = "Scorpid",
	Serpent = "Serpent",
	["Shale Spider"] = "Shale Spider",
	Shivarra = "Shivarra",
	Silithid = "Silithid",
	Spider = "Spider",
	["Spirit Beast"] = "Spirit Beast",
	Sporebat = "Sporebat",
	Stag = "Stag",
	Succubus = "Succubus",
	Tallstrider = "Tallstrider",
	Terrorguard = "Terrorguard",
	Totem = "Totem",
	Turtle = "Turtle",
	Undead = "Undead",
	Voidlord = "Voidlord",
	Voidwalker = "Voidwalker",
	["Warp Stalker"] = "Warp Stalker",
	Wasp = "Wasp",
	["Water Elemental"] = "Water Elemental",
	["Water Strider"] = "Water Strider",
	["Wild Pet"] = "Wild Pet",
	["Wind Serpent"] = "Wind Serpent",
	Wolf = "Wolf",
	Worm = "Worm",
	Wrathguard = "Wrathguard",
}


if GAME_LOCALE == "enUS" then
	lib:SetCurrentTranslations(true)
elseif GAME_LOCALE == "deDE" then
	lib:SetCurrentTranslations {
	Aberration = "Entartung", -- Needs review
	Abyssal = "Abyssal", -- Needs review
	Basilisk = "Basilisk",
	Bat = "Fledermaus",
	Bear = "Bär",
	Beast = "Wildtier",
	Beetle = "Käfer",
	["Bird of Prey"] = "Raubvogel",
	Boar = "Eber",
	["Carrion Bird"] = "Aasvogel",
	Cat = "Katze",
	Chimaera = "Schimäre",
	Clefthoof = "Grollhuf", -- Needs review
	["Core Hound"] = "Kernhund",
	Crab = "Krebs",
	Crane = "Kranich",
	Critter = "Kleintier",
	Crocolisk = "Krokilisk",
	Demon = "Dämon",
	Devilsaur = "Teufelssaurier",
	Direhorn = "Terrorhorn", -- Needs review
	Dog = "Hund",
	Doomguard = "Verdammniswache",
	Dragonhawk = "Drachenfalke",
	Dragonkin = "Drachkin",
	Elemental = "Elementar",
	Felguard = "Teufelswache",
	Felhunter = "Teufelsjäger",
	["Fel Imp"] = "Teufelswichtel", -- Needs review
	Fox = "Fuchs",
	["Gas Cloud"] = "Gaswolke",
	Ghoul = "Ghul",
	Giant = "Riese",
	Goat = "Ziege",
	Gorilla = "Gorilla",
	Humanoid = "Humanoid",
	Hydra = "Hydra", -- Needs review
	Hyena = "Hyäne",
	Imp = "Wichtel",
	Mechanical = "Mechanisch",
	Monkey = "Affe",
	Moth = "Motte",
	["Nether Ray"] = "Netherrochen",
	["Non-combat Pet"] = "Haustier",
	["Not specified"] = "Nicht spezifiziert",
	Observer = "Beobachter", -- Needs review
	Porcupine = "Stachelschwein",
	Quilen = "Qilen",
	Raptor = "Raptor",
	Ravager = "Felshetzer",
	["Remote Control"] = "Ferngesteuert",
	Rhino = "Rhinozeros",
	Riverbeast = "Flussbestie", -- Needs review
	Rylak = "Rylak", -- Needs review
	Scorpid = "Skorpid",
	Serpent = "Schlange",
	["Shale Spider"] = "Shale Spider",
	Shivarra = "Shivarra", -- Needs review
	Silithid = "Silithid",
	Spider = "Spinne",
	["Spirit Beast"] = "Geisterbestie",
	Sporebat = "Sporensegler",
	Stag = "Hirsch", -- Needs review
	Succubus = "Sukkubus",
	Tallstrider = "Weitschreiter",
	Terrorguard = "Terrorwache", -- Needs review
	Totem = "Totem",
	Turtle = "Schildkröte",
	Undead = "Untoter",
	Voidlord = "Leerenfürst", -- Needs review
	Voidwalker = "Leerwandler",
	["Warp Stalker"] = "Sphärenjäger",
	Wasp = "Wespe",
	["Water Elemental"] = "Wasserelementar",
	["Water Strider"] = "Wasserschreiter",
	["Wild Pet"] = "Ungezähmtes Tier",
	["Wind Serpent"] = "Windnatter",
	Wolf = "Wolf",
	Worm = "Wurm",
	Wrathguard = "Zornwächter", -- Needs review
}
elseif GAME_LOCALE == "frFR" then
	lib:SetCurrentTranslations {
	Aberration = "Aberration", -- Needs review
	Abyssal = "Abyssal", -- Needs review
	Basilisk = "Basilic", -- Needs review
	Bat = "Chauve-souris",
	Bear = "Ours",
	Beast = "Bête",
	Beetle = "Hanneton",
	["Bird of Prey"] = "Oiseau de proie",
	Boar = "Sanglier",
	["Carrion Bird"] = "Charognard",
	Cat = "Félin",
	Chimaera = "Chimère",
	Clefthoof = "Sabot-fourchu", -- Needs review
	["Core Hound"] = "Chien du Magma",
	Crab = "Crabe",
	Crane = "Grue", -- Needs review
	Critter = "Bestiole",
	Crocolisk = "Crocilisque",
	Demon = "Démon",
	Devilsaur = "Diablosaure",
	Direhorn = "Navrecorne", -- Needs review
	Dog = "Chien",
	Doomguard = "Garde funeste",
	Dragonhawk = "Faucon-dragon",
	Dragonkin = "Draconien",
	Elemental = "Elémentaire",
	Felguard = "Gangregarde",
	Felhunter = "Chasseur corrompu",
	["Fel Imp"] = "Diablotin gangrené", -- Needs review
	Fox = "Renard",
	["Gas Cloud"] = "Nuage de gaz",
	Ghoul = "Goule",
	Giant = "Géant",
	Goat = "Chèvre", -- Needs review
	Gorilla = "Gorille",
	Humanoid = "Humanoïde",
	Hydra = "Hydre", -- Needs review
	Hyena = "Hyène",
	Imp = "Diablotin",
	Mechanical = "Machine",
	Monkey = "Singe",
	Moth = "Phalène",
	["Nether Ray"] = "Raie du Néant",
	["Non-combat Pet"] = "Familier pacifique",
	["Not specified"] = "Non spécifié",
	Observer = "Observateur", -- Needs review
	Porcupine = "Porc-épic", -- Needs review
	Quilen = "Quilen", -- Needs review
	Raptor = "Raptor",
	Ravager = "Ravageur",
	["Remote Control"] = "Télécommande",
	Rhino = "Rhinocéros",
	Riverbeast = "Potamodonte", -- Needs review
	Rylak = "Rylak", -- Needs review
	Scorpid = "Scorpide",
	Serpent = "Serpent",
	["Shale Spider"] = "Shale Spider",
	Shivarra = "Shivarra", -- Needs review
	Silithid = "Silithide",
	Spider = "Araignée",
	["Spirit Beast"] = "Esprit de bête",
	Sporebat = "Sporoptère",
	Stag = "Cerf", -- Needs review
	Succubus = "Succube",
	Tallstrider = "Haut-trotteur",
	Terrorguard = "Garde de terreur", -- Needs review
	Totem = "Totem",
	Turtle = "Tortue",
	Undead = "Mort-vivant",
	Voidlord = "Seigneur du Vide", -- Needs review
	Voidwalker = "Marcheur du Vide",
	["Warp Stalker"] = "Traqueur dim.",
	Wasp = "Guêpe",
	["Water Elemental"] = "Elémentaire d'eau",
	["Water Strider"] = "Trotteur aquatique", -- Needs review
	["Wild Pet"] = "Mascotte sauvage", -- Needs review
	["Wind Serpent"] = "Serpent des vents",
	Wolf = "Loup",
	Worm = "Ver",
	Wrathguard = "Garde-courroux", -- Needs review
}
elseif GAME_LOCALE == "koKR" then
	lib:SetCurrentTranslations {
	-- Aberration = "",
	-- Abyssal = "",
	Basilisk = "바실리스크", -- Needs review
	Bat = "박쥐",
	Bear = "곰",
	Beast = "야수",
	Beetle = "딱정벌레",
	["Bird of Prey"] = "맹금",
	Boar = "멧돼지",
	["Carrion Bird"] = "독수리",
	Cat = "살쾡이",
	Chimaera = "키메라",
	Clefthoof = "갈래발굽", -- Needs review
	["Core Hound"] = "심장부 사냥개",
	Crab = "게",
	Crane = "학", -- Needs review
	Critter = "동물",
	Crocolisk = "악어",
	Demon = "악마",
	Devilsaur = "데빌사우루스",
	Direhorn = "공포뿔", -- Needs review
	Dog = "개",
	Doomguard = "파멸의 수호병",
	Dragonhawk = "용매",
	Dragonkin = "용족",
	Elemental = "정령",
	Felguard = "지옥수호병",
	Felhunter = "지옥사냥개",
	["Fel Imp"] = "지옥 임프", -- Needs review
	Fox = "여우",
	["Gas Cloud"] = "가스",
	Ghoul = "구울",
	Giant = "거인",
	Goat = "염소", -- Needs review
	Gorilla = "고릴라",
	Humanoid = "인간형",
	Hydra = "히드라", -- Needs review
	Hyena = "하이에나",
	Imp = "임프",
	Mechanical = "기계",
	Monkey = "원숭이",
	Moth = "나방",
	["Nether Ray"] = "황천의 가오리",
	["Non-combat Pet"] = "애완동물",
	["Not specified"] = "기타",
	Observer = "감시자", -- Needs review
	Porcupine = "호저", -- Needs review
	Quilen = "기렌", -- Needs review
	Raptor = "랩터",
	Ravager = "칼날발톱",
	["Remote Control"] = "무선조종 장난감",
	Rhino = "코뿔소",
	Riverbeast = "강물하마", -- Needs review
	Rylak = "라일라크", -- Needs review
	Scorpid = "전갈",
	Serpent = "뱀",
	["Shale Spider"] = "혈암 거미",
	Shivarra = "쉬바라", -- Needs review
	Silithid = "실리시드",
	Spider = "거미",
	["Spirit Beast"] = "야수 정령",
	Sporebat = "포자날개",
	Stag = "사슴", -- Needs review
	Succubus = "서큐버스",
	Tallstrider = "타조",
	Terrorguard = "공포수호병", -- Needs review
	Totem = "토템",
	Turtle = "거북",
	Undead = "언데드",
	Voidlord = "공허군주", -- Needs review
	Voidwalker = "보이드워커",
	["Warp Stalker"] = "차원의 추적자",
	Wasp = "말벌",
	["Water Elemental"] = "물 정령",
	["Water Strider"] = "소금쟁이", -- Needs review
	["Wild Pet"] = "야생 애완동물", -- Needs review
	["Wind Serpent"] = "천둥매",
	Wolf = "늑대",
	Worm = "벌레",
	Wrathguard = "격노수호병", -- Needs review
}
elseif GAME_LOCALE == "esES" then
	lib:SetCurrentTranslations {
	Aberration = "Aberración", -- Needs review
	Abyssal = "Abisal", -- Needs review
	Basilisk = "Basilisco", -- Needs review
	Bat = "Murciélago",
	Bear = "Oso",
	Beast = "Bestia",
	Beetle = "Alfazaque",
	["Bird of Prey"] = "Ave rapaz",
	Boar = "Jabalí",
	["Carrion Bird"] = "Carroñero",
	Cat = "Felino",
	Chimaera = "Quimera",
	Clefthoof = "Uñagrieta", -- Needs review
	["Core Hound"] = "Can del Núcleo",
	Crab = "Cangrejo",
	Crane = "Grulla", -- Needs review
	Critter = "Alma",
	Crocolisk = "Crocolisco",
	Demon = "Demonio",
	Devilsaur = "Demosaurio",
	Direhorn = "Cuernoatroz", -- Needs review
	Dog = "Perro",
	Doomguard = "Guardia apocalíptico",
	Dragonhawk = "Dracohalcón",
	Dragonkin = "Dragón",
	Elemental = "Elemental",
	Felguard = "Guardia vil",
	Felhunter = "Manáfago",
	["Fel Imp"] = "Diablillo vil", -- Needs review
	Fox = "Zorro",
	["Gas Cloud"] = "Nube de Gas",
	Ghoul = "Necrófago",
	Giant = "Gigante",
	Goat = "Cabra", -- Needs review
	Gorilla = "Gorila",
	Humanoid = "Humanoide",
	Hydra = "Hidra", -- Needs review
	Hyena = "Hiena",
	Imp = "Diablillo",
	Mechanical = "Mecánico",
	Monkey = "Mono",
	Moth = "Palomilla",
	["Nether Ray"] = "Raya abisal",
	["Non-combat Pet"] = "Mascota no combatiente",
	["Not specified"] = "No especificado",
	Observer = "Observador", -- Needs review
	Porcupine = "Puercoespín", -- Needs review
	Quilen = "Quilen", -- Needs review
	Raptor = "Raptor",
	Ravager = "Devastador",
	["Remote Control"] = "Control remoto",
	Rhino = "Rinoceronte",
	Riverbeast = "Bestia fluvial", -- Needs review
	Rylak = "Rylak", -- Needs review
	Scorpid = "Escórpido",
	Serpent = "Serpiente",
	["Shale Spider"] = "Araña de esquisto", -- Needs review
	Shivarra = "Shivarra", -- Needs review
	Silithid = "Silítido",
	Spider = "Araña",
	["Spirit Beast"] = "Bestia espíritu",
	Sporebat = "Esporiélago",
	Stag = "Venado", -- Needs review
	Succubus = "Súcubo",
	Tallstrider = "Zancaalta",
	Terrorguard = "Guarda terrorífico", -- Needs review
	Totem = "Tótem",
	Turtle = "Tortuga",
	Undead = "No-muerto",
	Voidlord = "Señor del vacío", -- Needs review
	Voidwalker = "Abisario",
	["Warp Stalker"] = "Acechador deformado",
	Wasp = "Avispa",
	["Water Elemental"] = "Elemental de agua",
	["Water Strider"] = "Zancudo acuático", -- Needs review
	["Wild Pet"] = "Mascota salvaje", -- Needs review
	["Wind Serpent"] = "Serpiente alada",
	Wolf = "Lobo",
	Worm = "Gusano",
	Wrathguard = "Guardia de cólera", -- Needs review
}
elseif GAME_LOCALE == "esMX" then
	lib:SetCurrentTranslations {
	Aberration = "Aberración", -- Needs review
	Abyssal = "Abisal",
	Basilisk = "Basilisco",
	Bat = "Murciélago",
	Bear = "Oso",
	Beast = "Bestia",
	Beetle = "Alfazaque",
	["Bird of Prey"] = "Ave rapaz",
	Boar = "Jabalí",
	["Carrion Bird"] = "Carroñero",
	Cat = "Felino",
	Chimaera = "Quimera",
	Clefthoof = "Uñagrieta",
	["Core Hound"] = "Can del Núcleo",
	Crab = "Cangrejo",
	Crane = "Grulla",
	Critter = "Alma",
	Crocolisk = "Crocolisco",
	Demon = "Demonio",
	Devilsaur = "Demosaurio",
	Direhorn = "Cuernoatroz",
	Dog = "Perro",
	Doomguard = "Guardia apocalíptico",
	Dragonhawk = "Dracohalcón",
	Dragonkin = "Dragon",
	Elemental = "Elemental",
	Felguard = "Guardia vil",
	Felhunter = "Manáfago",
	["Fel Imp"] = "Diablillo vil",
	Fox = "Zorro",
	["Gas Cloud"] = "Nube de Gas",
	Ghoul = "Necrófago",
	Giant = "Gigante",
	Goat = "Cabra",
	Gorilla = "Gorila",
	Humanoid = "Humanoide",
	Hydra = "Hidra",
	Hyena = "Hiena",
	Imp = "Diablillo",
	Mechanical = "Mecánico",
	Monkey = "Mono",
	Moth = "Palomilla",
	["Nether Ray"] = "Raya abisal",
	["Non-combat Pet"] = "Mascota mansa",
	["Not specified"] = "Sin especificar",
	Observer = "Observador",
	Porcupine = "Puercoespín",
	Quilen = "Quilen",
	Raptor = "Raptor",
	Ravager = "Devastador",
	["Remote Control"] = "Control remoto",
	Rhino = "Rinoceronte",
	Riverbeast = "Bestia fluvial",
	Rylak = "Rylak",
	Scorpid = "Escórpido",
	Serpent = "Serpiente",
	["Shale Spider"] = "Araña de esquisto", -- Needs review
	Shivarra = "Shivarra",
	Silithid = "Silítido",
	Spider = "Araña",
	["Spirit Beast"] = "Bestia espíritu",
	Sporebat = "Esporiélago",
	Stag = "Venado",
	Succubus = "Súcubo",
	Tallstrider = "Zancaalta",
	Terrorguard = "Guarda terrorífico",
	Totem = "Totém",
	Turtle = "Tortuga",
	Undead = "No-muerto",
	Voidlord = "Señor del vacío",
	Voidwalker = "Abisario",
	["Warp Stalker"] = "Acechador deformado",
	Wasp = "Avispa",
	["Water Elemental"] = "Elemental de agua",
	["Water Strider"] = "Zancudo acuático",
	["Wild Pet"] = "Mascóta Salvaje", -- Needs review
	["Wind Serpent"] = "Serpiente alada",
	Wolf = "Lobo",
	Worm = "Gusano",
	Wrathguard = "Guardia de cólera",
}
elseif GAME_LOCALE == "ptBR" then
	lib:SetCurrentTranslations {
	Aberration = "Aberração", -- Needs review
	Abyssal = "Abissal", -- Needs review
	Basilisk = "Basilisco", -- Needs review
	Bat = "Morcego", -- Needs review
	Bear = "Urso", -- Needs review
	Beast = "Fera", -- Needs review
	Beetle = "Abelha", -- Needs review
	["Bird of Prey"] = "Ave de Rapina", -- Needs review
	Boar = "Javali", -- Needs review
	["Carrion Bird"] = "Pássaro Carniçeiro", -- Needs review
	Cat = "Gato", -- Needs review
	Chimaera = "Quimera", -- Needs review
	Clefthoof = "Fenoceronte", -- Needs review
	["Core Hound"] = "Cão Feroz", -- Needs review
	Crab = "Carangueijo", -- Needs review
	Crane = "Garça", -- Needs review
	Critter = "Bicho", -- Needs review
	Crocolisk = "Crocodilo", -- Needs review
	Demon = "Demônio", -- Needs review
	Devilsaur = "Dinomau", -- Needs review
	Direhorn = "Escornante", -- Needs review
	Dog = "Cachorro", -- Needs review
	Doomguard = "Demonarca", -- Needs review
	Dragonhawk = "Falcão Dracônico", -- Needs review
	Dragonkin = "Dracônico", -- Needs review
	Elemental = "Elemental", -- Needs review
	Felguard = "Guarda Vil", -- Needs review
	Felhunter = "Caçador Vil", -- Needs review
	["Fel Imp"] = "Diabrete Vil", -- Needs review
	Fox = "Raposa", -- Needs review
	["Gas Cloud"] = "Gasoso", -- Needs review
	Ghoul = "Vampiro", -- Needs review
	Giant = "Gigante", -- Needs review
	Goat = "Bode", -- Needs review
	Gorilla = "Gorila", -- Needs review
	Humanoid = "Humanoide", -- Needs review
	Hydra = "Hidra", -- Needs review
	Hyena = "Hiena", -- Needs review
	Imp = "Diabinho", -- Needs review
	Mechanical = "Mecânico", -- Needs review
	Monkey = "Macaco", -- Needs review
	Moth = "Mariposa", -- Needs review
	["Nether Ray"] = "Raio Etéreo", -- Needs review
	["Non-combat Pet"] = "Mascote não-combatente", -- Needs review
	["Not specified"] = "Não especificado", -- Needs review
	Observer = "Observador", -- Needs review
	Porcupine = "Porco-espinho", -- Needs review
	Quilen = "Quílen", -- Needs review
	Raptor = "Raptor", -- Needs review
	Ravager = "Devastador", -- Needs review
	["Remote Control"] = "Controle Remoto", -- Needs review
	Rhino = "Rinoceronte", -- Needs review
	Riverbeast = "Fera-do-rio", -- Needs review
	Rylak = "Rylak", -- Needs review
	Scorpid = "Escorpiônico", -- Needs review
	Serpent = "Serpente", -- Needs review
	["Shale Spider"] = "Aranha Xistosa", -- Needs review
	Shivarra = "Shivarra", -- Needs review
	Silithid = "Silitídeo", -- Needs review
	Spider = "Aranha", -- Needs review
	["Spirit Beast"] = "Espírito Besta", -- Needs review
	Sporebat = "Morcego Esporoso", -- Needs review
	Stag = "Cervo", -- Needs review
	Succubus = "Súcubo", -- Needs review
	Tallstrider = "Passolargo", -- Needs review
	Terrorguard = "Deimoguarda", -- Needs review
	Totem = "Totem", -- Needs review
	Turtle = "Tartaruga", -- Needs review
	Undead = "Renegado", -- Needs review
	Voidlord = "Senhor do Caos", -- Needs review
	Voidwalker = "Caminhante do Vazio", -- Needs review
	["Warp Stalker"] = "Espreitador Dimensional", -- Needs review
	Wasp = "Vespa", -- Needs review
	["Water Elemental"] = "Elemental da Água", -- Needs review
	["Water Strider"] = "Caminhante das Águas", -- Needs review
	-- ["Wild Pet"] = "",
	["Wind Serpent"] = "Cobra Naja", -- Needs review
	Wolf = "Lobo", -- Needs review
	Worm = "Minhoca", -- Needs review
	Wrathguard = "Guardião Colérico", -- Needs review
}
elseif GAME_LOCALE == "itIT" then
	lib:SetCurrentTranslations {
	Aberration = "Aberrazione",
	Abyssal = "Abission",
	Basilisk = "Basilisco",
	Bat = "Pipistrello",
	Bear = "Orso",
	Beast = "Bestia",
	Beetle = "Scarafaggio",
	["Bird of Prey"] = "Rapace",
	Boar = "Cinghiale",
	["Carrion Bird"] = "Mangiacarogne",
	Cat = "Gatto",
	Chimaera = "Chimera",
	Clefthoof = "Mammuceronte",
	["Core Hound"] = "Segugio del Nucleo",
	Crab = "Granchio",
	Crane = "Gru",
	Critter = "Animale",
	Crocolisk = "Coccodrillo",
	Demon = "Demone",
	Devilsaur = "Sauro Demoniaco",
	Direhorn = "Cornofurente",
	Dog = "Cane",
	Doomguard = "Demone Guardiano",
	Dragonhawk = "Dragofalco",
	Dragonkin = "Dragoide",
	Elemental = "Elementale",
	Felguard = "Vilguardia",
	Felhunter = "Vilsegugio",
	["Fel Imp"] = "Vilimp",
	Fox = "Volpe",
	["Gas Cloud"] = "Nube di Gas",
	Ghoul = "Ghoul",
	Giant = "Gigante",
	Goat = "Capra",
	Gorilla = "Gorilla",
	Humanoid = "Umanoide",
	Hydra = "Idra",
	Hyena = "Iena",
	Imp = "Folletto",
	Mechanical = "Meccanico",
	Monkey = "Scimmia",
	Moth = "Falena",
	["Nether Ray"] = "Manta Fatua",
	["Non-combat Pet"] = "Animale Non combattente",
	["Not specified"] = "Non Specificato",
	Observer = "Osservatore",
	Porcupine = "Istrice",
	Quilen = "Quilen",
	Raptor = "Raptor",
	Ravager = "Devastatore ",
	["Remote Control"] = "Telecomando",
	Rhino = "Rinoceronte",
	Riverbeast = "Bestia dei Fiumi",
	Rylak = "Rylak",
	Scorpid = "Scorpione",
	Serpent = "Serpente",
	["Shale Spider"] = "Ragno D'argilla",
	Shivarra = "Shivarra",
	Silithid = "Silitide",
	Spider = "Ragno",
	["Spirit Beast"] = "Spirito di Bestia",
	Sporebat = "Sporofago",
	Stag = "Cervo",
	Succubus = "Succube",
	Tallstrider = "Zampalunga",
	Terrorguard = "Guardia Maligna",
	Totem = "Totem",
	Turtle = "Tartaruga",
	Undead = "Non Morto",
	Voidlord = "Ombra del Vuoto",
	Voidwalker = "Ombra del Vuoto",
	["Warp Stalker"] = "Camminatore Distorto",
	Wasp = "Vespa",
	["Water Elemental"] = "Elementale d'Acqua",
	["Water Strider"] = "Gerride",
	["Wild Pet"] = "Creatura Selvaggia",
	["Wind Serpent"] = "Serpente Volante",
	Wolf = "Lupo",
	Worm = "Verme",
	Wrathguard = "Guardia dell'Ira",
}
elseif GAME_LOCALE == "ruRU" then
	lib:SetCurrentTranslations {
	Aberration = "Аберрация", -- Needs review
	Abyssal = "Абиссал",
	Basilisk = "Василиск",
	Bat = "Летучая мышь",
	Bear = "Медведь",
	Beast = "Животное",
	Beetle = "Жук",
	["Bird of Prey"] = "Сова",
	Boar = "Вепрь",
	["Carrion Bird"] = "Падальщик",
	Cat = "Кошка",
	Chimaera = "Химера",
	Clefthoof = "Копытень", -- Needs review
	["Core Hound"] = "Гончая Недр",
	Crab = "Краб",
	Crane = "Журавль",
	Critter = "Существо",
	Crocolisk = "Кроколиск",
	Demon = "Демон",
	Devilsaur = "Дьявозавр",
	Direhorn = "Дикорог", -- Needs review
	Dog = "Собака",
	Doomguard = "Стражник ужаса",
	Dragonhawk = "Дракондор",
	Dragonkin = "Дракон",
	Elemental = "Элементаль",
	Felguard = "Страж Скверны",
	Felhunter = "Охотник Скверны",
	["Fel Imp"] = "Бес Скверны",
	Fox = "Лиса",
	["Gas Cloud"] = "Газовое облако",
	Ghoul = "Вурдалак",
	Giant = "Великан",
	Goat = "Козел",
	Gorilla = "Горилла",
	Humanoid = "Гуманоид",
	Hydra = "Гидра", -- Needs review
	Hyena = "Гиена",
	Imp = "Бес",
	Mechanical = "Механизм",
	Monkey = "Обезьяна",
	Moth = "Мотылек",
	["Nether Ray"] = "Скат Пустоты",
	["Non-combat Pet"] = "Спутник",
	["Not specified"] = "Не указано",
	Observer = "Наблюдатель",
	Porcupine = "Дикобраз",
	Quilen = "Цийлинь",
	Raptor = "Ящер",
	Ravager = "Опустошитель",
	["Remote Control"] = "Управление",
	Rhino = "Люторог",
	Riverbeast = "Речное чудище", -- Needs review
	Rylak = "Рилак", -- Needs review
	Scorpid = "Скорпид",
	Serpent = "Змей",
	["Shale Spider"] = "Сланцевый паук",
	Shivarra = "Шиварра",
	Silithid = "Силитид",
	Spider = "Паук",
	["Spirit Beast"] = "Дух зверя",
	Sporebat = "Спороскат",
	Stag = "Олень", -- Needs review
	Succubus = "Суккуб",
	Tallstrider = "Долгоног",
	Terrorguard = "Страж Ужаса",
	Totem = "Тотем",
	Turtle = "Черепаха",
	Undead = "Нежить",
	Voidlord = "Повелитель Бездны",
	Voidwalker = "Демон Бездны",
	["Warp Stalker"] = "Прыгуана",
	Wasp = "Оса",
	["Water Elemental"] = "Элементаль воды",
	["Water Strider"] = "Водный Долгоног",
	-- ["Wild Pet"] = "",
	["Wind Serpent"] = "Крылатый змей",
	Wolf = "Волк",
	Worm = "Червь",
	Wrathguard = "Страж гнева",
}
elseif GAME_LOCALE == "zhCN" then
	lib:SetCurrentTranslations {
	Aberration = "畸变怪",
	Abyssal = "深渊魔",
	Basilisk = "石化蜥蜴",
	Bat = "蝙蝠",
	Bear = "熊",
	Beast = "野兽",
	Beetle = "甲虫",
	["Bird of Prey"] = "猛禽",
	Boar = "野猪",
	["Carrion Bird"] = "食腐鸟",
	Cat = "豹",
	Chimaera = "奇美拉",
	Clefthoof = "裂蹄牛",
	["Core Hound"] = "熔岩犬",
	Crab = "螃蟹",
	Crane = "鹤",
	Critter = "小动物",
	Crocolisk = "鳄鱼",
	Demon = "恶魔",
	Devilsaur = "魔暴龙",
	Direhorn = "恐角龙",
	Dog = "狗",
	Doomguard = "末日守卫",
	Dragonhawk = "龙鹰",
	Dragonkin = "龙类",
	Elemental = "元素生物",
	Felguard = "恶魔卫士",
	Felhunter = "地狱猎犬",
	["Fel Imp"] = "邪能小鬼",
	Fox = "狐狸",
	["Gas Cloud"] = "气体云雾",
	Ghoul = "食尸鬼",
	Giant = "巨人",
	Goat = "山羊",
	Gorilla = "猩猩",
	Humanoid = "人型生物",
	Hydra = "多头蛇",
	Hyena = "土狼",
	Imp = "小鬼",
	Mechanical = "机械",
	Monkey = "猴子",
	Moth = "蛾子",
	["Nether Ray"] = "虚空鳐",
	["Non-combat Pet"] = "非战斗宠物",
	["Not specified"] = "未指定",
	Observer = "眼魔",
	Porcupine = "箭猪",
	Quilen = "魁麟",
	Raptor = "迅猛龙",
	Ravager = "掠食者",
	["Remote Control"] = "远程控制",
	Rhino = "犀牛",
	Riverbeast = "淡水兽",
	Rylak = "双头飞龙",
	Scorpid = "蝎子",
	Serpent = "蛇",
	["Shale Spider"] = "页岩蜘蛛",
	Shivarra = "破坏魔",
	Silithid = "异种虫",
	Spider = "蜘蛛",
	["Spirit Beast"] = "灵魂兽",
	Sporebat = "孢子蝠",
	Stag = "雄鹿",
	Succubus = "魅魔",
	Tallstrider = "陆行鸟",
	Terrorguard = "恐惧卫士",
	Totem = "图腾",
	Turtle = "海龟",
	Undead = "亡灵",
	Voidlord = "虚空领主",
	Voidwalker = "虚空行者",
	["Warp Stalker"] = "迁跃捕猎者",
	Wasp = "巨蜂",
	["Water Elemental"] = "水元素",
	["Water Strider"] = "水黾",
	["Wild Pet"] = "野生宠物",
	["Wind Serpent"] = "风蛇",
	Wolf = "狼",
	Worm = "蠕虫",
	Wrathguard = "愤怒卫士",
}
elseif GAME_LOCALE == "zhTW" then
	lib:SetCurrentTranslations {
	Aberration = "畸變怪",
	Abyssal = "冥淵火",
	Basilisk = "蜥蜴",
	Bat = "蝙蝠",
	Bear = "熊",
	Beast = "野獸",
	Beetle = "甲殼蟲",
	["Bird of Prey"] = "猛禽",
	Boar = "野豬",
	["Carrion Bird"] = "食腐鳥",
	Cat = "豹",
	Chimaera = "奇美拉",
	Clefthoof = "裂蹄",
	["Core Hound"] = "熔核犬",
	Crab = "螃蟹",
	Crane = "鶴",
	Critter = "小動物",
	Crocolisk = "鱷魚",
	Demon = "惡魔",
	Devilsaur = "魔暴龍",
	Direhorn = "恐角龍",
	Dog = "狗",
	Doomguard = "末日守衛",
	Dragonhawk = "龍鷹",
	Dragonkin = "龍類",
	Elemental = "元素生物",
	Felguard = "惡魔守衛",
	Felhunter = "惡魔獵犬",
	["Fel Imp"] = "魔化小鬼",
	Fox = "狐狸",
	["Gas Cloud"] = "氣體雲",
	Ghoul = "食屍鬼",
	Giant = "巨人",
	Goat = "山羊",
	Gorilla = "猩猩",
	Humanoid = "人型生物",
	Hydra = "多頭蛇",
	Hyena = "土狼",
	Imp = "小鬼",
	Mechanical = "機械",
	Monkey = "猴子",
	Moth = "蛾",
	["Nether Ray"] = "虛空鰭刺",
	["Non-combat Pet"] = "非戰鬥寵物",
	["Not specified"] = "不明",
	Observer = "觀察者",
	Porcupine = "豪豬",
	Quilen = "麒麟獸",
	Raptor = "迅猛龍",
	Ravager = "劫毀者",
	["Remote Control"] = "遙控",
	Rhino = "犀牛",
	Riverbeast = "河獸",
	Rylak = "雙頭飛龍",
	Scorpid = "蠍子",
	Serpent = "毒蛇",
	["Shale Spider"] = "岩蛛",
	Shivarra = "希瓦拉",
	Silithid = "異種蟲族",
	Spider = "蜘蛛",
	["Spirit Beast"] = "靈獸",
	Sporebat = "孢子蝙蝠",
	Stag = "雄鹿",
	Succubus = "魅魔",
	Tallstrider = "陸行鳥",
	Terrorguard = "懼護衛",
	Totem = "圖騰",
	Turtle = "海龜",
	Undead = "不死族",
	Voidlord = "虛無領主",
	Voidwalker = "虛無行者",
	["Warp Stalker"] = "扭曲巡者",
	Wasp = "黃蜂",
	["Water Elemental"] = "水元素",
	["Water Strider"] = "水黽",
	["Wild Pet"] = "野生寵物",
	["Wind Serpent"] = "風蛇",
	Wolf = "狼",
	Worm = "蟲",
	Wrathguard = "憤怒守衛",
}

else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end
