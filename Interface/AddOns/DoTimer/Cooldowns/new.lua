AsheylaLib:Package( "Cooldowns" );

-- the order in which the constructor expects the fields
local order = {
    "name", "texture", "arg", "cooldownFunc", "tooltipFunc"
};

local fields = {
    event = Class.READONLY,     -- string       the event being managed
};

local externalFuncs = {
    Accept = true,              -- <none>           accepts new cooldown data
};

local persistent = {
    
};

-- map from external objects to their internal data
local internal;

local oldDestruct;
local internalFuncs = {
    FieldUpdate = function( self, k, v )
        -- no fields to update
    end,
    
    Accept = function( self, name, texture, arg, cooldownFunc, tooltipFunc )
    
    end,
    
    Destruct = function( self )
        error( "cannot destroy event managers" );
    end,
};

local counter = 1;
Manager, internal, oldDestruct = Class( "Manager", fields, order, internalFuncs, externalFuncs, persistent );
local oldNew = Manager.new;
Manager.new = function( ... )
    local t, fresh = oldNew( ... );
    local int = internal[ t ];
    if ( fresh ) then
        int.frame = CreateFrame( "Frame" );
        int.timers = {};
        int.queue = {};
    end
    
    return t;
end

local managers = setmetatable( {}, {
    __index = function( t, k )
        t[ k ] = Manager.new( k );
        return t[ k ];
    end,
} );

local function registerCooldown( name, texture, arg, cooldownFunc, tooltipFunc, event )
    local start, duration, enable = cooldownFunc( arg );
    if enable == 1  and duration ~= 0 then
        print( ("%s is on CD for %.2f secs <cast>"):format( name, duration - GetTime() + start ) );
    end
    
    local f = CreateFrame( "Frame" );
    f:RegisterEvent( event );
    f:SetScript( "OnEvent", function( self, event )
        local start, duration, enable = cooldownFunc( arg );
        if enable == 1  and duration ~= 0 then
            print( ("%s is on CD for %.2f secs <event>"):format( name, duration - GetTime() + start ) );
        end
        
        self:UnregisterEvent( event );
    end );
end
--[[
hooksecurefunc( "UseAction", function( slot )
    local type, id, subtype, gid = GetActionInfo( slot );
    if type == "spell" then
        local name, _, texture = GetSpellInfo( gid );
        registerCooldown( name, texture, gid, GetSpellCooldown, "SetSpellByID", "ACTIONBAR_UPDATE_COOLDOWN" );
    elseif type == "pet" then
        local name, link, _, _, _, _, _, _, _, texture = GetItemInfo( id );
        registerCooldown( name, texture, link, GetItemCooldown, "SetHyperlink", "ACTIONBAR_UPDATE_COOLDOWN" );
    end
end );

hooksecurefunc( "UseContainerItem", function( bag, slot )
    local name, link, _, _, _, _, _, _, _, texture = GetItemInfo( GetContainerItemLink( bag, slot ) );
    registerCooldown( name, texture, link, GetItemCooldown, "SetHyperlink", "BAG_UPDATE_COOLDOWN" );
end );

hooksecurefunc( "UseInventoryItem", function( slot )
    local name, link, _, _, _, _, _, _, _, texture = GetItemInfo( GetInventoryItemLink( "player", slot ) );
    registerCooldown( name, texture, link, GetItemCooldown, "SetHyperlink", "ACTIONBAR_UPDATE_COOLDOWN" );
end );

hooksecurefunc( "UseItemByName", function( name )
    local name, link, _, _, _, _, _, _, _, texture = GetItemInfo( name );
    registerCooldown( name, texture, link, GetItemCooldown, "SetHyperlink", "ACTIONBAR_UPDATE_COOLDOWN" );
end );

hooksecurefunc( "CastPetAction", function( index )
    local name, _, texture = GetPetActionInfo( index );
    registerCooldown( name, texture, index, GetPetActionCooldown, "SetPetAction", "PET_BAR_UPDATE_COOLDOWN" );
end );

local function getSpellID( link )
    return link:match( "spell%:(%d+)" );
end

hooksecurefunc( "CastSpell", function( id, book )
    local name, _, texture = GetSpellInfo( id, book );
    local id = getSpellID( GetSpellLink( id, book ) );
    registerCooldown( name, texture, id, GetSpellCooldown, "SetSpellByID", "SPELL_UPDATE_COOLDOWN" );
end );

hooksecurefunc( "CastSpellByName", function( name )
    local name, _, texture = GetSpellInfo( name );
    local id = getSpellID( GetSpellLink( name ) );
    registerCooldown( name, texture, id, GetSpellCooldown, "SetSpellByID", "SPELL_UPDATE_COOLDOWN" );
end );

--]]