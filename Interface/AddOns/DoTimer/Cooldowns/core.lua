AsheylaLib:Package( "Cooldowns" );
Cooldowns = AsheylaLib:NewModule("Cooldowns", "KBLib");

local TIME_REMAINING = "COOLDOWNS_TIME_REMAINING";

local GetTime = GetTime;
local abs = math.abs;
local floor = math.floor;
local lower = string.lower;

local timerModule = CooldownsTimer;
local targetModule = CooldownsTarget;

local cooldownsTarget = targetModule:MakeTable(Cooldowns);

local SpellLib = AsheylaLib:Import("SpellLib");

local lastEquippedItem, lastBagItem, lastSpell, lastSpellID, playerClass;

-- sets up the initialization of the mod
local internalFrame = CreateFrame("Frame");
internalFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
internalFrame:SetScript("OnEvent", function(self, event, ...)
    --print( "event fired: " .. event );
    Cooldowns[event](Cooldowns, ...);
end);

local updateFunc = function(self, elapsed)
    local time = GetTime();
    for timer in cooldownsTarget:GetTimers() do
        if (time >= timer.time + timer.duration) then
            cooldownsTarget:RemoveTimer(timer);
        else
            timer.announced = timer.announced or timer.duration;
            local remaining = timer.duration - time + timer.time;
            if remaining <= timer.announced - 1  or remaining > timer.announced then
                timer.announced = floor(remaining + .5);
                AsheylaLib:CallEvent(TIME_REMAINING, timer, timer.announced);
            end
        end
    end
    if #cooldownsTarget.timers == 0 then
        self:SetScript("OnUpdate", nil)
    end
end

function Cooldowns:GetCooldownsTarget()
    return cooldownsTarget;
end

function Cooldowns:TimerIsRelevent(start, duration, wasLastCast, name, texture, type)
    local maxCD = self:Get("maxCooldown") * 60;
    if duration < self:Get("minCooldown") or (maxCD > 0 and duration > maxCD) then
        return false;
    end
    
    local time = GetTime();
    
    for timer in cooldownsTarget:GetTimers() do
        if 
    (
        timer.module == self
            and 
        timer.type == type 
            and 
        (abs(timer.time - start) < .1 or duration <= 1.5) 
            and 
        abs(timer.duration - duration) < .1 
            and 
        not ((timer.name ~= name) and (self:Get("forceShow", name:lower()) or self:Get("forceShow", timer.name:lower())) )
    )
    then
            if ((wasLastCast or self:Get("blocked", lower(timer.name))) and (duration > 1.5 or type == "item") and (wasLastCast or duration - time + start > 1.5)) then
                timer:UpdateInfo(name, texture);
                --self:Print(name, ":", texture);
            end
            
            timer.validated = true;
            --print("timer validated: ", timer.name, timer);
            return false;
        end
    end
    
    return true;
end

function Cooldowns:Commands()
    local loaded = LoadAddOn("DoTimer_Options");
    if loaded then
        AsheylaLib:Import( "GUILib" ):ShowPanel("DoTimer", "Cooldowns");
    end
end
Cooldowns:MakeSlashCmd("/cooldowns", "/cd");

function Cooldowns:PLAYER_ENTERING_WORLD()
    internalFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
    playerClass = select(2, UnitClass("player"));
    self:AddSettingsUpdateScript(function(self)
        if self:Get("enabled") then
            self:CheckAllCooldowns();
            internalFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
            internalFrame:RegisterEvent("BAG_UPDATE_COOLDOWN");
            internalFrame:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
            internalFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN");
            internalFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
            internalFrame:RegisterEvent("UNIT_SPELLCAST_START");
        else
            cooldownsTarget:RemoveAllTimers();
            internalFrame:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
            internalFrame:UnregisterEvent("BAG_UPDATE_COOLDOWN");
            internalFrame:UnregisterEvent("PET_BAR_UPDATE_COOLDOWN");
            internalFrame:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
            internalFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
            internalFrame:UnregisterEvent("UNIT_SPELLCAST_START");
        end
    end);
    self:UpdateSettings();
end

function Cooldowns:CheckAllCooldowns()
    self:ACTIONBAR_UPDATE_COOLDOWN()
    self:BAG_UPDATE_COOLDOWN()
    self:PET_BAR_UPDATE_COOLDOWN()
    self:SPELL_UPDATE_COOLDOWN()
end

local THROTTLE_TIME = .25;
local throttled = {};
local queue = {};
local queueFrame = CreateFrame( "Frame" );
local function queueUpdate( self, elapsed )
    local queued = false;
    for k, v in pairs( queue ) do
        queued = true;
        v = v - elapsed;
        if v <= 0 then
            --print( "releasing " .. k .. " from the queue" );
            queue[ k ] = nil;
            throttled[ k ] = nil;
            Cooldowns[ k ]( Cooldowns );
        else
            --print( k .. " has " .. v .. " secs left" );
            queue[ k ] = v;
        end
    end
    
    if not queued then self:SetScript( "OnUpdate", nil ); end
end
local function throttle( name )
    --print( "querying throttle for " .. name );
    local time = GetTime();
    if time < (throttled[ name ] or 0) + THROTTLE_TIME then
        --print( "throttling " .. name );
        queue[ name ] = THROTTLE_TIME - time + throttled[ name ];
        queueFrame:SetScript( "OnUpdate", queueUpdate );
        return true;
    end
    
    --print( "letting " .. name .. " through" );
    throttled[ name ] = time;
    return false;
end

function Cooldowns:MakeCooldown(name, texture, start, duration, rank, type)
    --self:Print(name, " going on cd");
    if duration <= 1.5 then
        name = "Global Cooldown";
        rank = nil;
        texture = "Interface\\Icons\\Spell_Lightning_LightningBolt01";
    end
    
    for timer in cooldownsTarget:GetTimers() do
        if timer.module == self and timer.name == name then
            cooldownsTarget:RemoveTimer(timer);
        end
    end    
    
    local timer = timerModule:NewTimer(self, name, texture, start, duration, rank);
    timer.type = type;
    timer.validated = true;
    cooldownsTarget:AddTimer(timer);
    --print("making cooldown: ", timer.name, timer);
    internalFrame:SetScript("OnUpdate", updateFunc);
end

function Cooldowns:AddExternalTimer(module, name, texture, start, duration)
    local timer = timerModule:NewTimer(module, name, texture, start, duration);
    cooldownsTarget:AddTimer(timer);
    internalFrame:SetScript("OnUpdate", updateFunc);
    return timer;
end

function Cooldowns:ACTIONBAR_UPDATE_COOLDOWN()
    if throttle( "ACTIONBAR_UPDATE_COOLDOWN" ) then return; end
    for timer in cooldownsTarget:GetTimers() do
        timer.validated = false;
    end
    
    for i = 1,19 do
        local itemName = GetItemInfo(GetInventoryItemLink("player", i) or "");
        local texture = GetInventoryItemTexture("player", i);
        self:TestItemForCooldown(itemName, texture, lastEquippedItem, "inventory");
    end
    
    for timer in cooldownsTarget:GetTimers() do
        if timer.type == "inventory" and not timer.validated then
            cooldownsTarget:RemoveTimer(timer);
        end
    end
end

function Cooldowns:BAG_UPDATE_COOLDOWN()
    if throttle( "BAG_UPDATE_COOLDOWN" ) then return; end
    for timer in cooldownsTarget:GetTimers() do
        timer.validated = false;
    end
    
    for b = 0, 4 do
        for s = 1, GetContainerNumSlots(b) do
            local itemName = GetItemInfo(GetContainerItemLink(b, s) or "");
            local texture = GetContainerItemInfo(b, s);
            self:TestItemForCooldown(itemName, texture, lastBagItem, "bag");
        end
    end
    
    for timer in cooldownsTarget:GetTimers() do
        if timer.type == "bag" and GetItemCount(timer.name) > 0 and not timer.validated then
            cooldownsTarget:RemoveTimer(timer);
        end
    end
end

function Cooldowns:TestItemForCooldown(itemName, texture, lastItem, type)
    if (itemName) then
        -- we have something equipped in that slot
        local link = select(2,GetItemInfo(itemName));
        if not link then return end
        local start, duration, hasCooldown = GetItemCooldown(SpellLib:GetItemID(link));
        if (hasCooldown == 1) then
            -- the item has a potential cooldown
            if duration > 0 then
                -- the cooldown is currently active
                if self:TimerIsRelevent(start, duration, (itemName == lastItem), itemName, texture, type) then
                    -- the item's cooldown is new and exciting
                    self:MakeCooldown(itemName, texture, start, duration, nil, type);
                else
                    --self:Print(itemName, ":", (itemName == lastItem));
                end
            end
        end
    end
end

function Cooldowns:PET_BAR_UPDATE_COOLDOWN()
    if throttle( "PET_BAR_UPDATE_COOLDOWN" ) then return; end
    if UnitExists("vehicle") then
        --print("beginning to scan vehicle cooldowns");
        for timer in cooldownsTarget:GetTimers() do
            timer.validated = false;
            --print("unvalidating", timer.name, timer, timer.type)
        end
        
        for i = 1, 10 do
            local spellName = GetPetActionInfo(i);
            if spellName then
                --print("checking", spellName);
                local _, _, texture = GetPetActionInfo(i);
                local start, duration, hasCooldown = GetPetActionCooldown(i);
                
                if (hasCooldown == 1) then
                    -- the spell has a potential cooldown
                    if duration > 0 then
                        -- the cooldown is currently active
                        if self:TimerIsRelevent(start, duration, true, spellName, texture, "vehicle") then
                            -- the item's cooldown is new and exciting
                            self:MakeCooldown(spellName, texture, start, duration, nil, "vehicle");
                        end
                    end
                end
                --print("done checking")
            end
        end
        
        for timer in cooldownsTarget:GetTimers() do
            if timer.type == "vehicle" and not timer.validated and timer.duration > 1.5 and (timer.duration - GetTime() + timer.time) > 1.5 then
                --print("timer invalid: ", timer.name, timer);
                cooldownsTarget:RemoveTimer(timer);
            else
                --print("timer is valid: ", timer.name, timer);
            end
        end
        --print("end scan")
    end
end

function Cooldowns:SPELL_UPDATE_COOLDOWN()
    if throttle( "SPELL_UPDATE_COOLDOWN" ) then return; end
    local time = GetTime();
    for timer in cooldownsTarget:GetTimers() do
        timer.validated = false;
    end
    if ( lastSpellID ) then
        --print( "here: " .. lastSpellID );
        self:TestSpellForCooldown( "spell", lastSpellID );
    end
    
    local i = 1;
    local spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_SPELL );
    while spellType do
        if spellType == "SPELL" then
            self:TestSpellForCooldown( "spell", spellID );
        end
        i = i + 1;
        spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_SPELL );
    end
    
    for timer in cooldownsTarget:GetTimers() do
        if timer.type == "spell" and not timer.validated and timer.duration > 1.5 and (timer.duration - time + timer.time) > 1.5 then
            cooldownsTarget:RemoveTimer(timer);
        end
    end
    
    if UnitExists("pet") then
        self:CheckPetBook();
    end
end

function Cooldowns:TestSpellForCooldown( type, spellID )
    local time = GetTime();
    local spellName, spellRank, texture = GetSpellInfo( spellID );
    local start, duration, hasCooldown = GetSpellCooldown(spellID);
    if (hasCooldown == 1) then
        -- the spell has a potential cooldown
        if (start > time) then
            duration = duration + (start - time);
            start = time;
        end
        if duration > 0 then
            -- the cooldown is currently active
            if 
                playerClass ~= "DEATHKNIGHT"
            or 
                duration ~= 10
            or 
                (texture == "Interface\\Icons\\Spell_DeathKnight_MindFreeze")
            then
                -- the cooldown is currently active
                if self:TimerIsRelevent(start, duration, (spellID == lastSpellID), spellName, texture, type) then
                    -- the item's cooldown is new and exciting
                    self:MakeCooldown(spellName, texture, start, duration, spellRank, type);
                else
                    --self:Print(spellName, ":", lastSpell);
                end
            end
        end
    end
end

function Cooldowns:CheckPetBook()
    local time = GetTime();
    for timer in cooldownsTarget:GetTimers() do
        timer.validated = false;
    end
    
    local i = 1;
    local spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_PET );
    while spellType do
        if spellType == "SPELL" then
            self:TestSpellForCooldown( "pet", spellID );
        end
        i = i + 1;
        spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_PET );
    end
    
    for timer in cooldownsTarget:GetTimers() do
        if timer.type == "pet" and not timer.validated and timer.duration > 1.5 and (timer.duration - time + timer.time) > 1.5 then
            cooldownsTarget:RemoveTimer(timer);
        end
    end
end

function Cooldowns:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, spellRank, _, spellID)
    if unit ~= "player" or not spellID then return end
    
    local isSpell = SpellLib:FindSpellInfo(spellName, spellRank, "spell");
    local isItem, _, _, isEquipped, actualName = SpellLib:FindSpellInfo(spellName, spellRank, "item");
    
    if isSpell then
        --self:Print("cast spell: ", spellName);
        lastSpell = spellName;
        lastSpellID = spellID;
        self:TestSpellForCooldown( "spell", spellID );
    elseif isItem then
        if isEquipped then
            --self:Print("used equipped item: ", actualName);
            lastEquippedItem = actualName;
        else
            --self:Print("used bag item: ", actualName, ":", spellName);
            lastBagItem = actualName;
        end
    else
        --self:Print("unknown spell: ", spellName);
        lastSpell = spellName;
        lastSpellID = spellID;
    end
end

function Cooldowns:UNIT_SPELLCAST_START(unit, spellName, spellRank)
    self:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, spellRank);
end

function Cooldowns:GetTarget()
    return cooldownsTarget;
end

local defaultSettings = {
    enabled = true,
    minCooldown = 2,
    maxCooldown = 30,
    onlyLastCast = false,
    blocked = {},
    forceShow = {},
}
Cooldowns:AddDefaultSettings(defaultSettings);
