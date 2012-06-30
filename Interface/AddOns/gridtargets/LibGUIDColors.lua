
local lib = {}

local function GUIDToID(guid)
    return tonumber(guid:sub(-12,-7),16), tonumber(guid:sub(-6,-1),16)
end

local COLORS = {
    [1] = {r=1,g=1,b=0,a=1}, --yellow star
    [2] = {r=1,g=0.5,b=0,a=1}, --orange circle
    [3] = {r=1,g=0,b=1,a=1}, --purple diamond
    [4] = {r=0,g=1,b=0,a=1}, --green triangle
    [5] = {r=0.8,g=0.6,b=0.6,a=1}, --white moon
    [6] = {r=0,g=0,b=1,a=1}, --blue square
    [7] = {r=1,g=0,b=0,a=1}, -- red cross
    [8] = {r=1,g=1,b=1,a=1}, --white skull
    
    [9] = {r=0,g=1,b=1,a=1},
    [10] = {r=0,g=0.5,b=1,a=1},
    [11] = {r=1,g=0,b=0.5,a=1},
    [12] = {r=0,g=1,b=0.5,a=1},
    [13] = {r=0.5,g=0.5,b=1,a=1},
    [14] = {r=1,g=0.5,b=0.5,a=1},
    [15] = {r=0.5,g=1,b=0.5,a=1},
    [16] = {r=1,g=0.25,b=0,a=1},
    [17] = {r=0.25,g=1,b=0,a=1},
    [18] = {r=0,g=1,b=0.25,a=1},
    [19] = {r=0.25,g=0,b=1,a=1},
}

local MOB_COLORS = setmetatable({}, {
    __index = function(t, i)
        local mobID, spawnID = GUIDToID(i)
        mobID = mobID % 11 + 9
        
        spawnID = spawnID % 3
        local c = {}
        c.r = COLORS[mobID].r * 0.7^spawnID
        c.g = COLORS[mobID].g * 0.7^spawnID
        c.b = COLORS[mobID].b * 0.7^spawnID
        c.a = 1.0
		rawset(t, i, c)
		return c
	end,
})

function lib:GetUnitColor(unit)
    return self:GetGUIDColor(UnitGUID(unit), GetRaidTargetIndex(unit))
end 

function lib:GetGUIDColor(guid, raidTarget)
    if raidTarget and raidTarget > 0 then
        return COLORS[raidTarget]
    else
        return MOB_COLORS[guid]
    end
end

LibGUIDColors = lib