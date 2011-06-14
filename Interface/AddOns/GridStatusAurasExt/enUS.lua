local L = LibStub("AceLocale-3.0"):NewLocale("GridStatusAurasExt", "enUS", true)

L["AurasExt"] = true
L["New aura group"] = true
L["Creates a new status for a group of auras."] = true
L["General option for Auras Ext."] = true
L["New aura by ID"] = true
L["Adds a new Aura with the passed ID to this group"] = true
L["<spell id>"] = true
L["New aura by name"] = true
L["Adds a new Aura with the passed name to this group"] = true
L["<aura name>"] = true
L["Remove"] = true
L["Remove an aura from the group."] = true
L["Removes this aura."] = true
L["Only mine"] = true
L["Activates this aura group only for auras cast by you."] = true
L["Only theirs"] = true
L["Activates this aura group only for auras not cast by you."] = true
L["All missing"] = true
L["Activates this aura group only if all of its auras are missing."] = true
L["Remove group"] = true
L["Removes an aura group."] = true
L["Removes this aura group. Please Reload your UI after that!"] = true
L["None"] = true
L["Use no template at all, shows all options and pre sets nothing."] = true
L["Simple aura list"] = true
L["Use this template if you only want to define a simple list of auras which should be shown in grid (e.g. a list of raid debuffs)."] = true
L["Missing buffs"] = true
L["Use this template for a status which is shown if a certain buff group is missing (like \"Powerword: Fortitude\" and \"Prayer of Fortitude\")"] = true
L["Debuff types"] = true
L["Use this template if you want a status shown on certain dispellable debuff types (Magic, Poisen, etc) where you can exclude certain debuffs from."] = true
L["Templates"] = true
L["Use a certain settings template for this aura group."] = true
L["Uses this settings template (changes the options shown for this aura group)."] = true
L["New %s template"] = true
L["Creates a new status for a group of auras using the %s template. %s"] = true
L["Exclude auras"] = true
L["This option tells this group to use auras added by name or id as a blacklist (excludes them from being shown). Makes only sense together with showing debuffs by types."] = true
L["Show Debuff type %s"] = true
L["Enables this status for all debuffs of type %s."] = true
L["Magic"] = true
L["Poison"] = true
L["Curse"] = true
L["Disease"] = true
L["Exclude aura by ID"] = true
L["Excludes the Aura with the passed ID from this group"] = true
L["Exclude aura by name"] = true
L["Excludes the Aura with the passed name from this group"] = true  
L["Only buffs"] = true
L["Activates this aura group only for buffs."] = true
L["Only debuffs"] = true
L["Activates this aura group only for debuffs."] = true
L["Color by magic type"] = true
L["Colors the status by the magic type of the displayed aura. You can edit the colors under \"Grid->Status->Colors\""] = true
L["Magic type colors"] = true
L["Color for magic types (poison, magic, etc)."] = true
L["No/unknown magic type"] = true
L["The color for things with no/unknown magic type."] = true
L["The color for magic type %s."] = true
L["Target enemy auras"] = "Target enemy auras"
L["Use this template if you want a status shown on auras of the targeted enemy instead of the unit itself."] = "Use this template if you want a status shown on auras of the targeted enemy instead of the unit itself."
L["Check targeted enemy"] = "Check targeted enemy"
L["If this option is enabled the targeted enemies auras are checked instead of the units auras itself."] = true
L["Show buff type %s"] = true
L["Enables this status for all buffs of type %s."] = true
L["Target update interval"] = true
L["Defines the interval in which to check the targeted units auras."] = true
L["Check target auras"] = true
L["You can disable this option to improve performance (maybe) and if you don't need to track mob auras."] = true
L["You'll have to reload your UI after this!"] = true
L["Option template:"] = true
L["Choose the option template to use."] = true
L["Ignore Pets"] = true
L["Check this if you want this aura group not to be displayed for pets."] = true