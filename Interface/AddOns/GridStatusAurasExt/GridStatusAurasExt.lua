--{{{ Libraries

local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusAurasExt")
local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")

--}}}

local GridStatusAurasExt = GridStatus:NewModule("GridStatusAurasExt", "AceTimer-3.0")
GridStatusAurasExt.menuName = L["AurasExt"]


--{{{ AceDB defaults

GridStatusAurasExt.defaultDB = {
	auraGroups = {},
    updateInterval = 1,
    checkTargets = true,
}

--}}}

--GridStatusAurasExt.options = {}

local auraList = {}
local groupList = {}
local mobGroupList = {}
local auraTypes = {
    Magic = {},
    Disease = {},
    Poison = {},
    Curse = {},
}

local MAGIC_TYPE_COLORS = {
    none = {r = 0.5, g = 0.5, b = 0.5, a = 1.0},
    Magic = {r = 0.2, g = 0.4, b = 1, a = 1.0},
    Disease = {r = 0.6, g = 0.4, b = 0, a = 1.0},
    Poison = {r = 0, g = 0.6, b = 0, a = 1.0},
    Curse = {r = 0.8, g = 0, b = 1, a = 1.0},
}

local function addOptionsForAuraTypes(opts, status)
    for auraType, _ in pairs(auraTypes) do
        opts[auraType] = {
            type = "toggle",
            name = (L["Show Debuff type %s"]):format(L[auraType]),
            desc = (L["Enables this status for all debuffs of type %s."]):format(L[auraType]),
            get = function()
                return GridStatusAurasExt.db.profile[status].debuffTypes[auraType]
                end,
            set = function(_, v)
                GridStatusAurasExt:ShowDebuffTypeForStatus(v, auraType, status)
            end,
            order = 146,
        }
    end
end

local function addOptionsForSettings(opts, status, settings)
    for i, setting in ipairs(settings) do
        local set
        if setting == "ignorepets" then
            set = {
                type = "toggle",
                name = L["Ignore Pets"],
                desc = L["Check this if you want this aura group not to be displayed for pets."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].ignorePets
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].ignorePets = v
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 141,
            }
        elseif setting == "onlymine" then
            set = {
                type = "toggle",
                name = L["Only mine"],
                desc = L["Activates this aura group only for auras cast by you."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].onlyMine
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].onlyMine = v
                    if v and GridStatusAurasExt.db.profile[status].onlyTheirs then
                        GridStatusAurasExt.db.profile[status].onlyTheirs = false
                    end
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 142,
            }
        elseif setting == "onlytheirs" then
            set = {
                type = "toggle",
                name = L["Only theirs"],
                desc = L["Activates this aura group only for auras not cast by you."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].onlyTheirs
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].onlyTheirs = v
                    if v and GridStatusAurasExt.db.profile[status].onlyMine then
                        GridStatusAurasExt.db.profile[status].onlyMine = false
                    end
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 143,
            }
        elseif setting == "onlybuffs" then
            set = {
                type = "toggle",
                name = L["Only buffs"],
                desc = L["Activates this aura group only for buffs."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].onlyBuffs
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].onlyBuffs = v
                    if v and GridStatusAurasExt.db.profile[status].onlyDebuffs then
                        GridStatusAurasExt.db.profile[status].onlyDebuffs = false
                    end
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 144,
            }
        elseif setting == "onlydebuffs" then
            set = {
                type = "toggle",
                name = L["Only debuffs"],
                desc = L["Activates this aura group only for debuffs."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].onlyDebuffs
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].onlyDebuffs = v
                    if v and GridStatusAurasExt.db.profile[status].onlyBuffs then
                        GridStatusAurasExt.db.profile[status].onlyBuffs = false
                    end
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 145,
            }
        elseif setting == "missing" then
            set = {
                type = "toggle",
                name = L["All missing"],
                desc = L["Activates this aura group only if all of its auras are missing."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].allMissing
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].allMissing = v
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 146,
            }
        elseif setting == "exclude" then
            set = {
                type = "toggle",
                name = L["Exclude auras"],
                desc = L["This option tells this group to use auras added by name or id as a blacklist (excludes them from being shown). Makes only sense together with showing debuffs by types."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].asBlackList
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].asBlackList = v
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 147,
            }
        elseif setting == "auraheader" then
            set = {
                type = "header",
                name = "",
                order = 180,
            }
        elseif setting == "addbyid" then
            set = {
                type = "input",
                name = L["New aura by ID"],
                desc = L["Adds a new Aura with the passed ID to this group"],
                get = function() return "" end,
                set = function(_, v) GridStatusAurasExt:NewAuraIDToGroup(status, v) end,
                usage = L["<spell id>"],
                order = 181,
                validate = function(_, v) return tonumber(v) and (GetSpellInfo(tonumber(v)) ~= nil) end,
            }
        elseif setting == "addbyname" then
            set = {
                type = "input",
                name = L["New aura by name"],
                desc = L["Adds a new Aura with the passed name to this group"],
                get = function() return "" end,
                set = function(_, v) GridStatusAurasExt:NewAuraNameToGroup(status, v) end,
                usage = L["<aura name>"],
                order = 182,
            }
        elseif setting == "colorbytype" then
            set = {
                type = "toggle",
                name = L["Color by magic type"],
                desc = L["Colors the status by the magic type of the displayed aura. You can edit the colors under \"Grid->Status->Colors\""],
                get = function()
                    return GridStatusAurasExt.db.profile[status].colorByType
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].colorByType = v
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 148,
            }
         elseif setting == "mobauras" then
            set = {
                type = "toggle",
                name = L["Check targeted enemy"],
                desc = L["If this option is enabled the targeted enemies auras are checked instead of the units auras itself."],
                get = function()
                    return GridStatusAurasExt.db.profile[status].mobAuras
                    end,
                set = function(_, v)
                    GridStatusAurasExt.db.profile[status].mobAuras = v
                    GridStatusAurasExt:UpdateAllUnitAuras()
                end,
                order = 149,
            }
        end
        opts[setting] = set
    end
end

local templates = {
    ["none"] = {
        name = L["None"],
        desc = L["Use no template at all, shows all options and pre sets nothing."],
        getOpts = function(status)
            local opts = {}
            addOptionsForSettings(opts, status, {
                "ignorepets",
                "onlymine","onlytheirs",
                "onlybuffs","onlydebuffs",
                "missing",
                "exclude",
                "auraheader",
                "addbyid","addbyname",
                "colorbytype",
                "mobauras"})
            addOptionsForAuraTypes(opts, status)
            return opts;
        end,

    },
    ["bossdebuffs"] = {
        name = L["Simple aura list"],
        desc = L["Use this template if you only want to define a simple list of auras which should be shown in grid (e.g. a list of raid debuffs)."],
        consts = function(s)
            s.allMissing = false
            s.onlyTheirs = false
            s.onlyMine = false
            s.asBlackList = false
            s.mobAuras = false
            for debuffType,_ in pairs(auraTypes) do
                s.debuffTypes[debuffType] = false
            end
        end,
        getOpts = function(status)
            local opts = {}
            addOptionsForSettings(opts, status, {"ignorepets","auraheader","addbyid","addbyname","onlybuffs","onlydebuffs"})
            return opts
        end,
    },
    ["missing buffs"] = {
        name = L["Missing buffs"],
        desc = L["Use this template for a status which is shown if a certain buff group is missing (like \"Powerword: Fortitude\" and \"Prayer of Fortitude\")"],
        consts = function(s)
            s.allMissing = true
            s.onlyTheirs = false
            s.onlyMine = false
            s.asBlackList = false
            s.onlyBuffs = true
            s.onlyDebuffs = false
            s.mobAuras = false
            for debuffType,_ in pairs(auraTypes) do
                s.debuffTypes[debuffType] = false
            end
        end,
        getOpts = function(status)
            local opts = {}
            addOptionsForSettings(opts, status, {"ignorepets","auraheader","addbyid","addbyname"})
            return opts
        end,
    },
    ["debuffTypes"] = {
        name = L["Debuff types"],
        desc = L["Use this template if you want a status shown on certain dispellable debuff types (Magic, Poisen, etc) where you can exclude certain debuffs from."],
        consts = function(s)
            s.allMissing = false
            s.onlyTheirs = false
            s.onlyMine = false
            s.asBlackList = true
            s.onlyBuffs = false
            s.onlyDebuffs = true
            s.mobAuras = false
        end,
        getOpts = function(status)
            local opts = {
                ["addbyid"] = {
                    type = "input",
                    name = L["Exclude aura by ID"],
                    desc = L["Excludes the Aura with the passed ID from this group"],
                    get = function() return "" end,
                    set = function(_, v) GridStatusAurasExt:NewAuraIDToGroup(status, v) end,
                    usage = L["<spell id>"],
                    order = 181,
                },
                ["addbyname"] = {
                    type = "input",
                    name = L["Exclude aura by name"],
                    desc = L["Excludes the Aura with the passed name from this group"],
                    get = function() return "" end,
                    set = function(_, v) GridStatusAurasExt:NewAuraNameToGroup(status, v) end,
                    usage = L["<aura name>"],
                    order = 182,
                },
            }
            addOptionsForSettings(opts, status, {"ignorepets","auraheader","colorbytype"})
            addOptionsForAuraTypes(opts, status)

            return opts;
        end,
    },
    ["mobAuras"] = {
        name = L["Target enemy auras"],
        desc = L["Use this template if you want a status shown on auras of the targeted enemy instead of the unit itself."],
        consts = function(s)
            s.allMissing = false
            s.onlyTheirs = false
            s.onlyMine = false
            s.asBlackList = false
            s.onlyBuffs = false
            s.onlyDebuffs = false
            s.mobAuras = true
        end,
        getOpts = function(status)
            local opts = {}
            addOptionsForSettings(opts, status, {"ignorepets","auraheader","addbyname", "addbyid"})
            addOptionsForAuraTypes(opts, status)

            return opts;
        end,
    },
}

local templateNames = {}


local options = {
    type = "group",
    name = L["AurasExt"],
    desc = L["General option for Auras Ext."],
    args = {
        ["checktargets"] = {
            type = "toggle",
            name = L["Check target auras"],
            desc = L["You can disable this option to improve performance (maybe) and if you don't need to track mob auras."],
            get = function()
                return GridStatusAurasExt.db.profile.checkTargets
                end,
            set = function(_, v)
                GridStatusAurasExt.db.profile.checkTargets = v
                if v then
                    GridStatusAurasExt:RegisterEvent("UNIT_TARGET")
                    GridStatusAurasExt.gsaTimer = GridStatusAurasExt:ScheduleRepeatingTimer("GSAECheckTargets", GridStatusAurasExt.db.profile.updateInterval)
                    assert(GridStatusAurasExt.gsaTimer)
                else
                    GridStatusAurasExt:UnregisterEvent("UNIT_TARGET")
                    GridStatusAurasExt:CancelTimer(GridStatusAurasExt.gsaTimer)
                end
            end,
            order = 6,
        },
        ["updateinterval"] = {
            type = "range",
            name = L["Target update interval"],
            desc = L["Defines the interval in which to check the targeted units auras."],
            get = function() return GridStatusAurasExt.db.profile.updateInterval end,
            set = function(_, v) GridStatusAurasExt:ChangeUpdateInterval(v) end,
            min = 0.01,
            max = 1,
            step = 0.01,
            bigStep = 0.02,
            order = 5,
        },
        ["newgroup"] = {
            type = "input",
            name = L["New aura group"],
            desc = L["Creates a new status for a group of auras."],
            get = function ()
                return ""
                end,
            set = function(_,v)
                GridStatusAurasExt:NewAuraGroup(v)
            end,
            order = 10,
            usage = "",
        },
        ["remove"] = {
            type = "group",
            name = L["Remove group"],
            desc = L["Removes an aura group."],
            args = {
                header = {
                    type = "header",
                    name = L["You'll have to reload your UI after this!"],
                    order = 1,
                },
            },
        },
    },
}

Grid.options.args["aurasext"] = options

GridStatus.options.args.color.args["magictypes"] = {
    type = "group",
    name = L["Magic type colors"],
    desc = L["Color for magic types (poison, magic, etc)."],
    args = {
        ["none"] = {
            type = "color",
            name = L["No/unknown magic type"],
            desc = L["The color for things with no/unknown magic type."],
            order = 100,
            get = function ()
                      local c = GridStatusAurasExt.db.profile.magicColors["none"]
                      return c.r, c.g, c.b, c.a
                  end,
            set = function (_, r, g, b, a)
                      local c = GridStatusAurasExt.db.profile.magicColors["none"]
                      c.r, c.g, c.b, c.a = r, g, b, a
                      GridStatus:TriggerEvent("Grid_ColorsChanged")
                  end,
            hasAlpha = true,
        },
    },
}

local settings



function GridStatusAurasExt:OnInitialize()
	self.super.OnInitialize(self)
    settings = self.db.profile
    --[[
    GridStatus.options.args["aurasext"] = {
        type = "group",
        name = L["AurasExt"],
        desc = L["AurasExt"],
        args = {}
    }
    self.options = GridStatus.options.args["aurasext"]
    ]]
    
    

    for name, data in pairs(templates) do
        if name ~= "none" then
            Grid.options.args["aurasext"].args["new"..name] = {
                type = "input",
                name = string.format(L["New %s template"], data.name),
                desc = string.format(L["Creates a new status for a group of auras using the %s template. %s"], data.name, data.desc),
                get = function ()
                    return ""
                    end,
                set = function(_, v)
                    GridStatusAurasExt:NewAuraGroup(v, name)
                end,
                order = 10,
                usage = "",
            }
        end
        templateNames[name] = data.name
    end

    if not settings.magicColors then
        settings.magicColors = MAGIC_TYPE_COLORS
    end
    MAGIC_TYPE_COLORS = settings.magicColors

    for magic, data in pairs(MAGIC_TYPE_COLORS) do
        if magic ~= "none" then
            GridStatus.options.args.color.args["magictypes"].args[magic] = {
                type = "color",
                name = L[magic],
                desc = string.format(L["The color for magic type %s."], L[magic]),
                order = 100,
                get = function ()
                          local c = GridStatusAurasExt.db.profile.magicColors[magic]
                          return c.r, c.g, c.b, c.a
                      end,
                set = function (_, r, g, b, a)
                          local c = GridStatusAurasExt.db.profile.magicColors[magic]
                          c.r, c.g, c.b, c.a = r, g, b, a
                          GridStatus:TriggerEvent("Grid_ColorsChanged")
                      end,
                hasAlpha = true,
            }
        end
    end

    for name, data in pairs(settings.auraGroups) do
        self:RegisterAuraGroup(name, data)
    end
end

function GridStatusAurasExt:OnEnable()
    self.super.OnEnable(self)
    
	--self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterMessage("Grid_UnitJoined")
    self:RegisterMessage("Grid_ColorsChanged")

    if settings.checkTargets then
        self:RegisterEvent("UNIT_TARGET")
        self.gsaTimer = self:ScheduleRepeatingTimer("GSAECheckTargets", settings.updateInterval)
        assert(self.gsaTimer)
    end
    --self:RegisterEvent("GSAECheckTargets")

    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:ChangeUpdateInterval(interval)
    settings.updateInterval = interval
    self:CancelTimer(self.gsaTimer)
    if settings.checkTargets then
        self.gsaTimer = self:ScheduleRepeatingTimer("GSAECheckTargets", interval)
        assert(self.gsaTimer)
    end
end

function GridStatusAurasExt:GSAECheckTargets()
	for guid, unitid in GridRoster:IterateRoster() do
        self:UNIT_AURA(nil, unitid.."target")
	end
end

function GridStatusAurasExt:UNIT_TARGET(_, unitid)
    if GridRoster:IsGUIDInRaid(UnitGUID(unitid)) then
        self:UNIT_AURA(nil, unitid.."target")
    end
end

function GridStatusAurasExt:Grid_UnitJoined(_, guid, unitid)
	self:UNIT_AURA(nil, unitid)
    self:UNIT_AURA(nil, unitid.."target")
end

function GridStatusAurasExt:Grid_ColorsChanged()
	self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:SetAuraGroupTemplate(status, template)
    local prevTemplate = settings[status].template

    local opts = self.options.args[status].args

    if prevTemplate then
        local templateOpts = templates[prevTemplate].getOpts(status)
        for optName, optData in pairs(templateOpts) do
            opts[optName] = nil
        end
    end

    local templateOpts = templates[template].getOpts(status)
    for optName, optData in pairs(templateOpts) do
        opts[optName] = optData
    end

    if templates[template].consts then
        templates[template].consts(settings[status])
    end

    settings[status].template = template

    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:OnStatusEnable(status)
    local sets = settings[status]
    
    for id, _ in pairs(sets.ids) do
        self:RegisterId(status, id)
    end

    for aura, _ in pairs(sets.names) do
        self:RegisterName(status, aura)
    end

    groupList[status] = {settings = sets}
    for debuffType, v in pairs(sets.debuffTypes) do
        if v then
            auraTypes[debuffType][status] = sets
        end
    end

    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:OnStatusDisable(status)
    local sets = settings[status]
    for id, _ in pairs(sets.ids) do
        self:UnregisterId(status, id)
    end

    for aura, _ in pairs(sets.names) do
        self:UnregisterName(status, aura)
    end

    groupList[status] = nil
    for debuffType, v in pairs(sets.debuffTypes) do
        if v then
            auraTypes[debuffType][status] = nil
        end
    end

    for guid, unitid in GridRoster:IterateRoster() do
        self.core:SendStatusLost(guid, status)
    end
end

function GridStatusAurasExt:RemoveAuraGroup(name)
    local status = "status_"..name
    self:UnregisterStatus(status)

    local sets = settings[status]
    for id, _ in pairs(sets.ids) do
        self:UnregisterId(status, id)
    end

    for aura, _ in pairs(sets.names) do
        --print("removing "..aura)
        self:UnregisterName(status, aura)
    end

    groupList[status] = nil
    settings[status] = nil
    options.args.remove.args[status] = nil

    settings.auraGroups[name] = nil
end

function GridStatusAurasExt:RegisterAuraGroup(name, data, template)
    local status = "status_"..name

    local sets = settings[status]
    if not sets then
        sets = {
            enable = true,
            color = { r = 1, g = 1, b = 1, a = 1 },
            priority = 50,
            allMissing = false,
            onlyTheirs = false,
            onlyMine = false,
            onlyBuffs = false,
            onlyDebuffs = false,
            asBlackList = false,
            colorByType = false,
            mobAuras = false,
            ignorePets = false,
            ids = {},
            names = {},
            template = template,
            debuffTypes = {},
        }
        settings[status] = sets
    else
        if not sets.debuffTypes then sets.debuffTypes = {} end
    end

    options.args.remove.args[status] = {
        type = "execute",
        name = name,
        desc = L["Removes this aura group. Please Reload your UI after that!"],
        func = function() self:RemoveAuraGroup(name) end,
        order = 10,
    }

    local opts = {
        ["remove"] = {
            type = "group",
            name = L["Remove"],
            desc = L["Remove an aura from the group."],
            args = {
                
            },
        },
        ["templates"] = {
            type = "group",
            name = L["Templates"],
            desc = L["Use a certain settings template for this aura group."],
            args = {
                template = {
                    type = "select",
                    name = L["Option template:"],
                    desc = L["Choose the option template to use."],
                    order = 1,
                    get = function() return settings[status].template end,
                    set = function(_, templateName) self:SetAuraGroupTemplate(status, templateName) end,
                    values = templateNames,
                },
            },
        },
    }
    
    local orderCnt = 3

    for templateName, data in pairs(templates) do
        orderCnt = orderCnt + 2
        local order = (templateName == "none") and 2 or orderCnt
        opts.templates.args[templateName.."header"] = {
            type = "header",
            name = data.name,
            order = order,
        }
        opts.templates.args[templateName.."desc"] = {
            type = "description",
            name = data.desc,
            order = order + 1,
        }
    end

    self:RegisterStatus(status, name, opts, false)

    self:SetAuraGroupTemplate(status, sets.template or "none")

    for id, _ in pairs(sets.ids) do
        if not GetSpellInfo(id) then
            print(("Removed aura with invalid spell id %s from group %s"):format(id, status))
            self:RemoveIdFromGroup(status, id)
        end
    end
    
    if sets.enable then
        for id, _ in pairs(sets.ids) do
            self:RegisterId(status, id)
        end

        for aura, _ in pairs(sets.names) do
            self:RegisterName(status, aura)
        end

        groupList[status] = {settings = sets}
        for debuffType, v in pairs(sets.debuffTypes) do
            if v then
                auraTypes[debuffType][status] = sets
            end
        end
    end
end

function GridStatusAurasExt:UnregisterName(status, aura)
    local auraData = auraList[aura]
    if auraData then
        auraData[status] = nil
    end
end

function GridStatusAurasExt:RegisterName(status, aura)

    local auraData = auraList[aura]
    if not auraData then
        auraData = {}
        auraList[aura] = auraData
    end

    if settings[status].names[aura] then
        auraData[status] = {settings = settings[status]}
    end

    local opts = self.options.args[status].args
    opts[aura] = {
        type = "toggle",
        name = aura,
        desc = aura,
        get = function()
            return settings[status].names[aura]
            end,
        set = function(_, v)
            settings[status].names[aura] = v
            if v then
                auraList[aura][status] = {settings = settings[status]}
            else
                auraList[aura][status] = nil
            end
            self:UpdateAllUnitAuras()
        end,
        order = 250,
    }
    opts.remove.args[aura] = {
        type = "execute",
        name = aura,
        desc = L["Removes this aura."],
        func = function() self:RemoveNameFromGroup(status, aura) end,
        order = 1,
    }
end

function GridStatusAurasExt:ShowDebuffTypeForStatus(show, debuffType, status)
    settings[status].debuffTypes[debuffType] = show

    if show then
        auraTypes[debuffType][status] = settings[status]
    else
        auraTypes[debuffType][status] = nil
    end

    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:UnregisterId(status, id)
    local aura, rank, icon = GetSpellInfo(id)
    local auraData = auraList[aura]
    if auraData then
        auraData[status] = nil
    end
end

function GridStatusAurasExt:RegisterId(status, id)
    local aura, rank, icon = GetSpellInfo(id)
    
    local auraData = auraList[aura]
    if not auraData then
        auraData = {}
        auraList[aura] = auraData
    end

    if settings[status].ids[id] then
        auraData[status] = {
            settings = settings[status],
            --icon = icon,
            --rank = rank,
            id = tonumber(id),
        }
    end

    local opts = self.options.args[status].args

    opts[id] = {
        type = "toggle",
        name = GetSpellInfo(id).."("..id..")",
        desc = id,
        get = function()
            return settings[status].ids[id]
            end,
        set = function(_, v)
            settings[status].ids[id] = v
            if v then
                auraList[aura][status] = {
                    settings = settings[status],
                    --icon = icon,
                    --rank = rank,
                    id = tonumber(id),
                }
            else
                auraList[aura][status] = nil
            end
            self:UpdateAllUnitAuras()
        end,
        order = 250,
    }
    opts.remove.args[id] = {
        type = "execute",
        name = GetSpellInfo(id).."("..id..")",
        desc = L["Removes this aura."],
        func = function() self:RemoveIdFromGroup(status, id) end,
        order = 1,
    }
end

function GridStatusAurasExt:RemoveIdFromGroup(status, id)
    local opts = self.options.args[status].args
    opts[id] = nil
    opts.remove.args[id] = nil
    settings[status].ids[id] = nil

    self:UnregisterId(status, id)

    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:RemoveNameFromGroup(status, aura)
    local opts = self.options.args[status].args
    opts[aura] = nil
    opts.remove.args[aura] = nil
    settings[status].names[aura] = nil
    
    self:UnregisterName(status, aura)
    
    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:NewAuraIDToGroup(status, id)
    settings[status].ids[id] = true
    self:RegisterId(status, id)
    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:NewAuraNameToGroup(status, aura)
    settings[status].names[aura] = true
    self:RegisterName(status, aura)
    self:UpdateAllUnitAuras()
end

function GridStatusAurasExt:NewAuraGroup(name, template)
    settings.auraGroups[name] = true
    self:RegisterAuraGroup(name, settings.auraGroups[name], template)
end

function GridStatusAurasExt:UpdateAllUnitAuras()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UNIT_AURA(nil, unitid)
        self:UNIT_AURA(nil, unitid.."target")
	end
end

local TARGETER = setmetatable({}, {
    __index = function(t, i)
        local unit = i:lower()
        local targeter
        if unit == "target" then
            targeter = "player"
        else
            targeter = select(3, unit:find("(.+)target"))
        end

        if not targeter then
            targeter = ""
        end

		rawset(t, i, targeter)
		return targeter
	end,
    })


local function getTargeter(unit)
    return TARGETER[unit]
end

local function isAuraInGroup(group, name, rank, icon, count, auraType, duration, expirationTime, source, isStealable, isMine, isTarget, isPet, isBuff, id)
    return not (isPet and group.settings.ignorePets)
           and isTarget == group.settings.mobAuras
           and not group.settings.asBlackList
           and (not group.settings.onlyBuffs or isBuff)
           and (not group.settings.onlyDebuffs or not isBuff)
           and (not group.id or group.id == id)
           and (not group.settings.onlyMine or isMine)
           and (not group.settings.onlyTheirs or not isMine)
end

local function setGroupToAura(group, name, icon, expirationTime, duration, count, auraType)
    group.active = true
    group.settings.name = name
    group.settings.icon = icon
    group.start = expirationTime - duration
    group.duration = duration
    group.count = count
    group.magicType = auraType or "none"
end

local function checkAura(name, isPet, isTarget, isBuff, rank, icon, count, auraType, duration, expirationTime, source, isStealable, id)
    local aura = auraList[name]
    if aura then
        local isMine = source and UnitIsUnit(source, "player")
        for status, data in pairs(aura) do
            if not groupList[status].active
               and isAuraInGroup(data,
                                 name, rank, icon,
                                 count, auraType,
                                 duration, expirationTime,
                                 source, isStealable,
                                 isMine, isTarget, isPet, isBuff, id) then

                setGroupToAura(groupList[status], name, icon, expirationTime, duration, count, auraType)
            end
        end
    end
    if auraType and (isTarget == isBuff) then
        local typedGroups = auraTypes[auraType]
        if typedGroups then
            for status, data in pairs(typedGroups) do
                if not groupList[status].active
                   and (data.mobAuras == isBuff)
                   and (not data.asBlackList or not aura or not aura[status]) then

                    setGroupToAura(groupList[status], name, icon, expirationTime, duration, count, auraType)
                end
            end
        end
    end
end

local function isGUIDPet(guid)
    return (GridRoster:GetOwnerUnitidByGUID(guid) ~= nil)
end

function GridStatusAurasExt:UNIT_AURA(_, unit)
    local guid = UnitGUID(unit)
    local isTarget = false
    local targeter = getTargeter(unit)
    if targeter and targeter ~= "" then
        guid = UnitGUID(targeter)
        isTarget = true
    end
    if not GridRoster:IsGUIDInRaid(guid) then
        return
    end
    
    local isPet = isGUIDPet(guid)

    for status, data in pairs(groupList) do
        if data.settings.mobAuras == isTarget then
            data.active = false
        end
    end

    if not isTarget or (UnitExists(unit) and UnitIsEnemy("player", unit)) then
        local i = 1
        local name, rank, icon, count, debuffType, duration, expirationTime, source, isStealable, _, id = UnitDebuff(unit, i)
        while name do
            checkAura(name, isPet, isTarget, false, rank, icon, count, debuffType, duration, expirationTime, source, isStealable, id)
            i = i + 1
            name, rank, icon, count, debuffType, duration, expirationTime, source, isStealable, _, id  = UnitDebuff(unit, i)
        end

        i = 1
        local name, rank, icon, count, buffType, duration, expirationTime, source, isStealable, _, id = UnitBuff(unit, i)
        while name do
            checkAura(name, isPet, isTarget, true, rank, icon, count, buffType, duration, expirationTime, source, isStealable, id)
            i = i + 1
            name, rank, icon, count, buffType, duration, expirationTime, source, isStealable, _, id  = UnitBuff(unit, i)
        end
    end

    for status, data in pairs(groupList) do
        if data.settings.mobAuras == isTarget then
            if not(data.settings.ignorePets and isPet) and data.active == (not data.settings.allMissing) then
                --print(status.." "..(data.settings.name or "nil"))
                self.core:SendStatusGained(guid,
                               status,
                               data.settings.priority,
                               (data.settings.range and 40),
                               (data.settings.colorByType and MAGIC_TYPE_COLORS[data.magicType]) or data.settings.color,
                               data.settings.name,
                               data.count,
                               nil,
                               data.settings.icon,
                               (data.active and data.start) or nil,
                               (data.active and data.duration) or nil,
                               (data.active and data.count) or nil)
            else
                --print(status.." lost")
                self.core:SendStatusLost(guid, status)
            end
        end
    end
end
