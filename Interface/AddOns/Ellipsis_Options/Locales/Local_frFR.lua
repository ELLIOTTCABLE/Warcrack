-- French locals from Markam@Chants éternels
local L = LibStub('AceLocale-3.0'):NewLocale("Ellipsis_Options", "frFR", false)

if not L then return end -- abort if not using these locals

local mustShow = "Doit afficher les cibles:\n |cff67b1e9Pas de cible|r - pour les AoEs\n |cff67b1e9Joueur|r - si d\195\169tect\195\169\n |cff67b1e9Familier|r - si d\195\169tect\195\169"

L.Lock = "Verouiller"
L.LockDesc = "Verouille l'interface d'Ellipsis afin d'emp\195\170cher les d\195\169placements et de cacher la fen\195\170tre de positionnement pour |cff67b1e9les cibles|r et |cff67b1e9les cibles pro\195\169minentes|r."

L.SampleTimers = "Test"
L.SampleTimersDesc = "Cr\195\169e une s\195\169rie d'auras et de cooldowns d'exemple afin de faciliter la configuration des options.\n\nAppuyer \195\160 nouveau sur ce bouton remettra \195\160 z\195\169ro les timers, et appuyer en maintenant la touche Shift enfonc\195\169e effacera les timers d'exemple."
L.SampleTarget = "Cible d'exemple %d"
L.SampleTimer = "Timer d'exemple %d"

-- Display (Base)
L.Display = "Options d'Affichage"
L.DisplayDesc = "Configuration de base de l'interface d'affichage."

L.Tooltips = "Tooltips"
L.TooltipsDesc = "Montre les bulles d'aide au passage de la souris au-dessus des timers des auras et cooldowns."

L.Clickable = "Cliquable"
L.ClickableDesc = "Rend les timers des auras et cooldowns cliquables pour les annonces des dur\195\169es et les blocages."

L.AuraAlpha = "Alpha - Auras"
L.AuraAlphaDesc = "R\195\168gle la transparence des timers d'auras et des cibles."

L.AuraScale = "Echelle - Auras"
L.AuraScaleDesc = "R\195\168gle l'\195\169chelle des timers d'auras et des cibles relative \195\160 l'UI de base."

L.AuraWidth = "Largeur des Entr\195\169es d'Auras"
L.AuraWidthDesc = "R\195\168gle la largeur (en pixels) des entr\195\169es d'aura; cela inclut \195\160 la fois les identifiants des cibles et les timers eux-m\195\170mes."

L.CDAlpha = "Alpha - Cooldowns"
L.CDAlphaDesc = "R\195\168gle la transparence des barres et timers de cooldown."

L.CDScale = "Echelle - Cooldowns"
L.CDScaleDesc = "R\195\168gle l'\195\169chelle des timers et barres de cooldown relative \195\160 l'UI de base."

-- Display (Targets 1)
L.DisplayTarget1 = "Aura Cibles 1"
L.DisplayTargetDesc = "Configuration des options d'aura de la cible."

L.ConfigTargetDisplay = "Configuration d'Affichage de la Cible"
L.ConfigTargetDisplayDesc = "Configure l'affichage des auras des cibles autre que les cibles devant \195\170tre affich\195\169es, qui seront toujours affich\195\169es s'il existe un timer sur elles. Parmi les options ci-dessous, pour les quatre premi\195\168res, la cible et le focus ne sont prioritaires que si elles existent et ont un timer; pour les trois derni\195\168res, aucune cible ne sera affich\195\169e sauf si les entr\195\169es appropri\195\169es (cible, focus ou les deux) existent.\n\nTout (Pas de priorit\195\169)\nTri standard des cibles.\n\nTout (Priorit\195\169 aux cibles)\nCible affich\195\169e au somment de la liste.\n\nTout (Priorit\195\169 au focus)\nFocus affich\195\169 au sommet de la liste.\n\nTout (Les deux priorit\195\169s)\nCible affich\195\169e au sommet de la liste, d\195\169tect\195\169e par le focus.\n\nCible uniquement\nAffiche uniquement la cible (si pr\195\169sente).\n\nFocus uniquement\nAffiche uniquement le focus (si pr\195\169sent).\n\nCible & focus\nAffiche uniquement la cible et le focus (si pr\195\169sents).\n\n" .. mustShow

L.ConfigTargetDisplayAll = "Tout (Aucune priorit\195\169)"
L.ConfigTargetDisplayAllBoth = "Tout (Les deux priorit\195\169s)"
L.ConfigTargetDisplayAllFocus = "Tout (Priorit\195\169 au focus)"
L.ConfigTargetDisplayAllTarget = "Tout (Priorit\195\169 \195\160 la cible)"
L.ConfigTargetDisplayBoth = "Cible & Focus"
L.ConfigTargetDisplayFocus = "Focus uniquement"
L.ConfigTargetDisplayTarget = "Cible uniquement"

L.ShowNumTargets = "Cibles Max"
L.ShowNumTargetsDesc = "R\195\168gle le nombre maximum d'auras de cibles \195\160 afficher (autre que les cibles devant \195\170tre affich\195\169es).\n\nCette valeur sera ignor\195\169e si l'affichage de la cible est r\195\169gl\195\169 pour n'afficher que la cible ou le focus (ou les deux).\n\n" .. mustShow

L.TargetFont = "Police de la Cible"
L.TargetFontDesc = "R\195\168gle la police \195\160 utiliser pour les identifiants de cible des auras."

L.TargetFontHeight = "Taille de la Police de la Cible"
L.TargetFontHeightDesc = "R\195\168gle la taille de la police \195\160 utiliser pour les identifiants de cible des auras."

L.TargetPadding = "Padding des Cibles"
L.TargetPaddingDesc = "R\195\168gle le padding (en pixels) entre les auras des cibles."

L.GrowTargets = "Direction d'Ajout de Cibles"
L.GrowTargetsDesc = "R\195\168gle la direction dans laquelle de nouvelles auras de cibles sont ajout\195\169es par rapport \195\160 la premi\195\168re entr\195\169e."

L.GrowUP = "Haut"
L.GrowDOWN = "Bas"
L.GrowLEFT = "Gauche"
L.GrowRIGHT = "Droite"

-- Display (Targets 2)
L.DisplayTarget2 = "Aura Cibles 2"

L.ShowLevel = "Afficher le Niveau"
L.ShowLevelDesc = "Affiche le niveau des ennemis dans les identifiants de cible des auras."

L.ShowClassColours = "Afficher les Couleurs de Classe"
L.ShowClassColoursDesc = "Affiche le texte des identifiants de cible des auras dans la couleur de classe appropri\195\169e.\n\nNote: Quand cette option est activ\195\169e, l'option de couleur de l'identification de la cible est ignor\195\169e."

L.ShowRaidIcons = "Afficher les Ic\195\180nes de Raid"
L.ShowRaidIconsDesc = "Affiche les ic\195\180nes de raid dans les identifiants de cible des auras."

L.ProminentTargetsHeader = "Cibles Pro\195\169minentes"
L.ProminentTargetsDesc = "Les cibles suivantes peuvent \195\170tre r\195\169gl\195\169es pro\195\169minentes ce qui signifie que leurs auras apparaitront sous l'ancre |cff67b1e9Cibles pro\195\169minentes|r au lieu de l'ancre |cff67b1e9Cibles|r. Ceci permet de s\195\169parer ces timers des autres."

L.ProminentItemsDesc = "Rend cette cible pro\195\169minente ce qui va faire afficher ses auras sous l'ancre |cff67b1e9Cibles pro\195\169minentes|r."

L.ProminentNoTarget = "Pas de cible (AoEs)"
L.ProminentPlayer = "Joueur"
L.ProminentPet = "Familier"

-- Display (Timers 1)
L.DisplayTimer1 = "Timers d'Auras 1"
L.DisplayTimerDesc = "Configure les options de timer d'auras."

L.SortTimerMethod = "Tri des Timers"
L.SortTimerMethodDesc = "R\195\168gle comment trier les timers des sorts actifs sur une aura de cible."
L.SortTimerMethod1 = "Alphab\195\169tique (Asc)"
L.SortTimerMethod2 = "Alphab\195\169tique (Desc)"
L.SortTimerMethod3 = "Temps restant (Asc)"
L.SortTimerMethod4 = "Temps restant (Desc)"
L.SortTimerMethod5 = "Pas de tri"

L.TimerFormat = "Format d'Affichage du Temps"
L.TimerFormatDesc = "R\195\168gle comment le temps restant est affich\195\169 sur les timers d'auras.\n\nPar exemple, trois valeurs sont donn\195\169es, ce sont l'affichage des minutes, des secondes et des dixi\195\168mes (optionnel)quand le timer est en-dessous de 10 secondes.\n\n## - 1:09   |   9   |   9.4\n\n0:## - 1:09   |   0:09   |   0:09.4\n\n##s - 1m 9s   |   9s   |   9.4s\n\n##s abbv - 1m   |   9s   |   9.4s"
L.TimerFormat1 = "##"
L.TimerFormat2 = "0:##"
L.TimerFormat3 = "##s"
L.TimerFormat4 = "##s abbv"

L.ShowTenths = "Afficher les Dixi\195\168mes"
L.ShowTenthsDesc = "D\195\169termine si les timers d'auras affichent les dixi\195\168mes de seconde quand ils arrivent dans les 10 derni\195\168res secondes du compte \195\160 rebours."

L.Mode = "Mode des Timers"
L.ModeDesc = "R\195\168gle le mode d'affichage des timers d'auras.\n\nLe mode Barres montre des barres de compte \195\160 rebours avec l'ic\195\180ne du sort, le nom du sort et le texte du timer.\n\nLe mode Ic\195\180nes montre juste une ic\195\180ne de sort associ\195\169e au texte du timer."
L.ModeBars = "Barres"
L.ModeIcons = "Ic\195\180nes"

L.GrowTimers = "Direction d'Ajout de Timers"
L.GrowTimersDesc = "R\195\168gle la direction dans laquelle de nouveaux timers sont ajout\195\169s par rapport \195\160 la premi\195\168re entr\195\169e."

L.GhostShow = "Timers Fant\195\180mes"
L.GhostShowDesc = "D\195\169termine si les timers fant\195\180mes sont affich\195\169s ou non. Les timers fant\195\180mes apparaissent \195\160 la place d'un timer d'aura une fois que celui-ci a expir\195\169 afin d'aider \195\160 se rappeler que ce timer-ci n'est plus actif.\n\nQuand cette option est inactiv\195\169e, les timers disparaissent simplement une fois qu'ils ont expir\195\169."

L.GhostDuration = "Dur\195\169s des Timers Fant\195\180mes"
L.GhostDurationDesc = "R\195\168gle la dur\195\169e (en secondes) des timers fant\195\180mes s'ils sont activ\195\169s."

-- Display (Timers 2)
L.DisplayTimer2 = "Timers d'Auras 2"

L.BarHeight = "Hauteur des Barres"
L.BarHeightDesc = "R\195\168gle la hauteur (en pixels) des barres de timers en mode Barres."

L.IconHeight = "Hauteur de l'Ic\195\180ne"
L.IconHeightDesc = "R\195\168gle la hauteur (en pixels) d'une ic\195\180ne en mode Ic\195\180nes.\n\nNote: Cela r\195\168gle aussi la largeur de l'ic\195\180ne puisque celles-ci sont carr\195\169es."

L.TimerPadding = "Padding des Timers"
L.TimerPaddingDesc = "R\195\168gle le padding (en pixels) entre les entr\195\169es de timer dans chaque mode de timer."

L.Texture = "Texture des Barres"
L.TextureDesc = "R\195\168gle la texture \195\160 utiliser pour les barres de timer en mode Barres."

L.TimerFont = "Police des Timers"
L.TimerFontDesc = "R\195\168gle la police \195\160 utiliser pour les textes des timers, ce qui inclue l'affichage du temps dans les deux modes, et l'affichage du nom du sort en mode Barres."

L.TimerFontHeight = "Hauteur de la Police des Timers"
L.TimerFontHeightDesc = "R\195\168gle la taille de la police \195\160 utiliser pour les textes des timers."

L.ShowStackInName = "Afficher les Stacks dans le Nom"
L.ShowStackInNameDesc = "Affiche les stacks (pour les sorts qui se stackent comme Fleur de Vie) en tant que partie du texte du nom du sort en mode Barres, par opposition au d\195\169faut qui est un nombre au-dessus de l'ic\195\180ne.\n\nNote: Activer cette option signifie que les stacks ne seront plus affich\195\169s en mode Ic\195\180nes."

-- Display (Cooldowns 1)
L.DisplayCooldown1 = "Cooldowns 1"
L.DisplayCooldownDesc = "Configure les options de cooldown."

L.CDHorizontal = "Barre Horizontale"
L.CDHorizontalDesc = "Affiche les barres de cooldown horizontalement, et non verticalement."

L.CDHideWhenNone = "Cacher si Aucun"
L.CDHideWhenNoneDesc = "Quand cette option est activ\195\169e, la barre de cooldowns est cach\195\169e quand il n'y a aucun timer actif, quand l'option est d\195\169sactiv\195\169e, la barre de cooldown est toujours visible."

L.CDLength = "Longueur de la Barre"
L.CDLengthDesc = "R\195\168gle la longueur (en pixels) de la barre de cooldown.\n\nNote: Cela r\195\168gle sa hauteur quand l'affichage est vertical."

L.CDThickness = "Epaisseur de la Barre"
L.CDThicknessDesc = "R\195\168gle l'\195\169paisseur (en pixels) de la barre de cooldown.\n\nNote: Cela r\195\168gle sa largeur quand l'affichage est vertical."

L.CDTimeDetail = "D\195\169tail de l'Echelle de Temps"
L.CDTimeDetailDesc = "R\195\168gle l'affichage du d\195\169tail (\195\160 quelle fr\195\169quence les valeurs de temps sont affich\195\169es) sur l'\195\169chelle de temps de la barre de cooldown."

L.CDMaxTimeDisplay = "Temps Max de l'Echelle de Temps"
L.CDMaxTimeDisplayDesc = "R\195\168gle le temps maximum (en secondes) qui sera affich\195\169 sur l'\195\169chelle de temps de la barre de cooldown.\n\nNote: Tout timer d\195\169tect\195\169 ayant une valeur sup\195\169rieure restera \195\160 la fin de la barre jusqu'\195\160 ce que son temps restant devienne inf\195\169rieur au maximum."

L.CDFontHeight = "Hauteur de Police de l'Echelle de Temps"
L.CDFontHeightDesc = "R\195\168gle la taille de la police utilis\195\169e pour afficher l'\195\169chelle de temps de la barre de cooldown."

-- Display (Cooldowns 2)
L.DisplayCooldown2 = "Cooldowns 2"

L.CDTexture = "Texture de la Barre"
L.CDTextureDesc = "R\195\168gle la texture utilis\195\169e pour la barre de cooldown."

L.CDShowOffsetTags = "Afficher les Tags de D\195\169calage"
L.CDShowOffsetTagsDesc = "Si un type de timer de cooldown a un d\195\169calage \195\160 la barre principale sup\195\169rieur \195\160 la moiti\195\169 de sa hauteur, un tag de d\195\169calage sera affich\195\169, reliant l'ic\195\180ne \195\160 la barre. D\195\169sactiver cette option cachera ces tags et fera que les ic\195\180nes flotteront \195\160 la position d\195\169termin\195\169e par leur d\195\169calage."

L.CDOffset1 = "D\195\169calage: Sorts"
L.CDOffset1Desc = "R\195\168gle le d\195\169calage pour les timers de cooldown des sorts.\n\nPositif: Place le timer au-dessus ou \195\160 droite de la barre selon son orientation.\n\nNegatif: Place le timer en-dessous ou \195\160 gauche de la barre selon son orientation."

L.CDOffset3 = "D\195\169calage: Objets"
L.CDOffset3Desc = "R\195\168gle le d\195\169calage pour les timers de cooldown d'\195\169quipement et d'objets.\n\nPositif: Place le timer au-dessus ou \195\160 droite de la barre selon son orientation.\n\nNegatif: Place le timer en-dessous ou \195\160 gauche de la barre selon son orientation."

L.CDOffset2 = "D\195\169calage: Familier"
L.CDOffset2Desc = "R\195\168gle le d\195\169calage pour les timers de cooldown de comp\195\169tences du familier.\n\nPositif: Place le timer au-dessus ou \195\160 droite de la barre selon son orientation.\n\nNegatif: Place le timer en-dessous ou \195\160 gauche de la barre selon son orientation."

-- Display (Colours)
L.DisplayColours = "Couleurs"
L.DisplayColoursDesc = "Interface de configuration des couleurs."

L.ColourTimerDesc = "Couleurs des Auras:"

L.ColourBackground = "Arri\195\168re-plan des Timers"
L.ColourBackgroundDesc = "R\195\168gle la couleur de l'arri\195\168re-plan des timers, que l'on aperçoit derri\195\168re les timers actifs pendant qu'ils comptent \195\160 rebours.\n\nNote: La transparence de cet \195\169l\195\169ment d'interface est \195\169galement r\195\169glable."

L.ColourGhost = "Timers Fant\195\180mes"
L.ColourGhostDesc = "R\195\168gle la couleur des timers fant\195\180mes lorsqu'ils sont affich\195\169s."

L.ColourTargetText = "Identifiant de Cible"
L.ColourTargetTextDesc = "R\195\168gle la couleur des identifiants de cible."

L.ColourTimerText = "Texte de Timer"
L.ColourTimerTextDesc = "R\195\168gle la couleur des timers de texte (\195\160 la fois le nom des sorts et le temps restant)."

L.ColourCDDesc = "Coleurs des Cooldown:"

L.ColourCDBar = "Barre Principale"
L.ColourCDBarDesc = "R\195\168gle la couleur de la barre de cooldown principale.\n\nNote: La transparence de cet \195\169l\195\169ment d'interface est \195\169galement r\195\169glable."

L.ColourCDBorder = "Bordure de la Barre"
L.ColourCDBorderDesc = "R\195\168gle la couleur de la bordure de la barre de cooldown principale.\n\nNote: La transparence de cet \195\169l\195\169ment d'interface est \195\169galement r\195\169glable."

L.ColourCDBackdrop = "Fond de la Barre"
L.ColourCDBackdropDesc = "R\195\168gle la couleur du fond de la barre de cooldown principale. Ce fond ne peut \195\170tre vu que si la barre principale est partiellement (ou totalement) transparente.\n\nNote: La transparence de cet \195\169l\195\169ment d'interface est \195\169galement r\195\169glable."

L.ColourCDText = "Texte de l'Echelle de Temps"
L.ColourCDTextDesc = "R\195\168gle la couleur du texte de l'\195\169chelle de temps de la barre de cooldown."

L.ColourCD1 = "Tag de D\195\169calage: Sorts"
L.ColourCD1Desc = "R\195\168gle la couleur des tags de d\195\169calage des sorts.\n\nNote: Visible uniquement si un d\195\169calage est donn\195\169 aux timers des sorts."

L.ColourCD3 = "Tag de D\195\169calage: Objets"
L.ColourCD3Desc = "R\195\168gle la couleur des tags de d\195\169calage des \195\169quipement et objets.\n\nNote: Visible uniquement si un d\195\169calage est donn\195\169 aux timers des objets."

L.ColourCD2 = "Tag de D\195\169calage: Familier"
L.ColourCD2Desc = "R\195\168gle la couleur des tags de d\195\169calage des comp\195\169tences du familier.\n\nNote: Visible uniquement si un d\195\169calage est donn\195\169 aux timers des comp\195\169tences du familier."

-- Aura Tracking
L.AuraTracking = "D\195\169tection des Auras"
L.AuraTrackingDesc = "Configure la d\195\169tection des auras."

L.TrackBuffs = "D\195\169tection des Buffs"
L.TrackBuffsDesc = "Active la d\195\169tection des buffs que vous lancez."

L.TrackDebuffs = "D\195\169tection des Debuffs"
L.TrackDebuffsDesc = "Active la d\195\169tection des debuffs que vous lancez."

L.TrackPlayer = "D\195\169tection des Buffs du Joueur"
L.TrackPlayerDesc = "Active la d\195\169tection des debuffs que vous lancez sur vous-m\195\170me."

L.TrackPet = "D\195\169tection des Buffs du Familier"
L.TrackPetDesc = "Active la d\195\169tection des debuffs que vous lancez sur votre familier."

L.MaxAuraDuration = "Dur\195\169e Max des Auras"
L.MaxAuraDurationDesc = "R\195\168gle la dur\195\169e maximum (en minutes) des auras qui seront d\195\169tect\195\169es par Ellipsis.\n\nUn r\195\169glage de 0 d\195\169tectera les auras de n'importe quelle dur\195\169e."

L.DNTAdd = "Ajouter \195\160 la Liste 'Ne pas D\195\169tecter'"
L.DNTAddDesc = "Ajoute des sorts \195\160 la liste 'Ne pas D\195\169tecter' afin d'emp\195\170cher leurs timers d'\195\170tre d\195\169tect\195\169s par Ellipsis."

L.DNTList = "Liste 'Ne pas D\195\169tecter'"
L.DNTListDesc = "Liste les sorts qui ont \195\169t\195\169 ajout\195\169s \195\160 la liste 'Ne pas D\195\169tecter', et permet de les en retirer en les s\195\169lectionnant dans le menu d\195\169roulant."

L.DNTWillTrack = "Timers pour %s seront maintenant d\195\169tect\195\169s par Ellipsis."

-- Cooldown Tracking
L.CooldownTracking = "D\195\169tection des Cooldowns"
L.CooldownTrackingDesc = "Configure la d\195\169tection de cooldown."

L.TrackCooldownsFor = "D\195\169tecte les cooldowns pour..."

L.CDSpell = "Sorts"
L.CDSpellDesc = "Active la d\195\169tection des cooldowns de vos sorts."

L.CDItem = "Objets"
L.CDItemDesc = "Active la d\195\169tection des cooldown de votre \195\169quipement et de vos objets."

L.CDPet = "Comp\195\169tences du Familier"
L.CDPetDesc = "Active la d\195\169tection des cooldowns des comp\195\169tences du familier."

L.CDMaxDuration = "Dur\195\169e Max des Cooldowns"
L.CDMaxDurationDesc = "R\195\168gle la dur\195\169e maximum (en minutes) des cooldowns qui seront d\195\169tect\195\169s par Ellipsis.\n\nUn r\195\169glage de 0 d\195\169tectera les cooldowns de n'importe quelle dur\195\169e."

L.CDDNTAddDesc = "Ajoute des sorts \195\160 la liste '\195\160 ne pas d\195\169tecter' afin d'emp\195\170cher leurs cooldowns d'\195\170tre d\195\169tect\195\169s par Ellipsis."

L.CDDNTListDesc = "Liste les cooldowns qui ont \195\169t\195\169 ajout\195\169s \195\160 la liste '\195\160 ne pas d\195\169tecter', et permet de les en retirer en les s\195\169lectionnant dans le menu d\195\169roulant."

L.CDDNTWillTrack = "Cooldowns pour %s seront maintenant d\195\169tect\195\169s par Ellipsis."

-- Output (Audio)
L.OutputAudio = "Sortie (Audio)"
L.OutputAudioDesc = "Configure la sortie audio."

L.OAPlaySounds = "Active"
L.OAPlaySoundsDesc = "Active les notifications audio \195\160 la fin des timers."

L.OAPlaySoundsOn = "Joue un son quand..."

L.OAExpiredDesc = "Joue un son quand un timer d'aura expire naturellement."
L.OABrokenDesc = "Joue un son quand un timer d'aura expire pr\195\169matur\195\169ment."
L.OACDExpiredDesc = "Joue un son quand un cooldown expire."

-- Output (Visual)
L.OutputVisual = "Sortie (Visuel)"
L.OutputVisualDesc = "Configure la sortie visuelle."

L.OVOutputTo = "Sortie vers"
L.OVOutputToDesc = "Configure la localisation de la sortie visuelle."

L.OVNotifyOn = "Notifie quand..."

L.OVNotifyExpireDesc = "Affiche un message quand un timer d'aura expire naturellement."
L.OVNotifyBreakDesc = "Affiche un message quand un timer d'aura expire pr\195\169matur\195\169ment."
L.OVNotifyCDExpireDesc = "Affiche un message quand un cooldown expire."

-- Output (Common To Both)
L.OAVExpired = "Timers d'auras expir\195\169s"
L.OAVBroken = "Timers d'auras cass\195\169s"
L.OAVCDExpired = "Timers de cooldown expir\195\169s"

-- Advanced
L.Advanced = "Avanc\195\169"
L.AdvancedDesc = "Configure les options avanc\195\169es.\n\nUtilisateurs exp\195\169riment\195\169s uniquement."

L.AdvancedWarning = "Ces options permettent de configurer les fonctions de d\195\169tection d'Ellipsis \195\160 un bas niveau, assurez-vous s'il vous plaît de savoir ce que vous faites avant de les changer."

L.TimerUpdateRate = "Taux de Rafraichissement des Timers"
L.TimerUpdateRateDesc = "R\195\168gle le d\195\169lai (en secondes) entre les rafraichissements des timers d'auras et de cooldowns d'Ellipsis. Cela inclue \195\160 la fois les rafraichissements des textes des timers et la progression le long des barres des timers.\n\nDe faibles valeurs r\195\169sulteront en une consommation accrue en ressources et un rafraichissement des barres plus fluide, et des valeurs plus \195\169lev\195\169es r\195\169duiront la consommation et r\195\169sulteront en des barres plus saccad\195\169es.\n\nRecommand\195\169: 0.05 - 0.15 secondes"

L.SecondaryScan = "Scanning Secondaire"
L.SecondaryScanDesc = "D\195\169termine si un scanning secondaire doit \195\170tre effectu\195\169 en raid ou en groupe.\n\nLe scanning secondaire v\195\169rifie les cibles de tous les membres du groupe chaque seconde (par d\195\169faut), recherchant vos timers d'auras afin de donner une d\195\169tection plus pr\195\169cise des timers d'auras pour les timers cass\195\169s. Ce n'est requis que pour les timers de debuffs puique tous les buffs sur votre groupe sont d\195\169tect\195\169s en temps r\195\169el par le scanning primaire."

L.SecondaryScanRate = "Taux de Scanning Secondaire"
L.SecondaryScanRateDesc = "R\195\168gle le d\195\169lai (en secondes) entre les scans secondaires.\n\nDes scans plus fr\195\169quents donneront une plus grande pr\195\169cision au prix d'un plus grand coût en utilisation des ressources, des scans moins fr\195\169quents r\195\169duiront l'utilisation des ressources mais donneront une moins grande pr\195\169cision pour les timers cass\195\169s.\n\nRecommand\195\169: 1.0 - 1.5 secondes"
