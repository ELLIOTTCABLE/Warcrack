local GridStatus = Grid:GetModule("GridStatus")
local GridRoster = Grid:GetModule("GridRoster")

local GridStatusCasterBuffs = GridStatus:NewModule("GridStatusCasterBuffs",  "AceTimer-3.0")
GridStatusCasterBuffs.menuName = "GridCaster Buffs" 
       
GridStatusCasterBuffs.defaultDB = {
	debug = false,

	npc_spells = {},
	aura_desc = {},
 	spell_name = {},
	enemy_npc_debuffs_others = {},
	boss_buffs_self = {} ,
	debuff_type = {},
	boss_groups = {}
	

}


GridStatusCasterBuffs.defaultDB["unit_gridcaster_debuff1"] = {
				text = "GridCaster Debuff1",
				enable = true,
				color = { r = 0, g = 0, b = 1, a = 1 },
				priority = 50,
				range = false	,
				threshold = 9,

			}
GridStatusCasterBuffs.defaultDB["unit_gridcaster_debuff2"] = {
				text = "GridCaster Debuff2",
				enable = true,
				color = { r = 0, g = 0, b = 1, a = 1 },
				priority = 50,
				range = false	,
				threshold = 9,

			}

GridStatusCasterBuffs.defaultDB["unit_gridcaster_debuff3"] = {
				text = "GridCaster Debuff3",
				enable = true,
				color = { r = 0, g = 0, b = 1, a = 1 },
				priority = 50,
				range = false	,
				threshold = 9,

			}


local options_debuffs1 = {




}
local options_debuffs2 = {




}
local options_debuffs3 = {

	
}
local realm = nil
local auras_current = {}
local auras_by_unit = {}
local boss_buffs_current = {}

local boss1_current = nil
local isCombat = 0


local chatFrameAuras = nil
local chatFrameAbilities = nil



function GridStatusCasterBuffs:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatus("unit_gridcaster_debuff1", "GridCaster: Unit Debuff1", options_debuffs1, true)
	self:RegisterStatus("unit_gridcaster_debuff2", "GridCaster: Unit Debuff2", options_debuffs2, true)
	self:RegisterStatus("unit_gridcaster_debuff3", "GridCaster: Unit Debuff3", options_debuffs3, true)  
	
	realm = GetRealmName()
	

	

    

end

function GridStatusCasterBuffsClear()

	GridStatusCasterBuffs:clear()

end

function GridStatusCasterBuffs:clear()

	GridStatusCasterBuffs.db.profile.npc_spells = {}
	GridStatusCasterBuffs.db.profile.aura_desc = {}
	GridStatusCasterBuffs.db.profile.spell_name = {}
	GridStatusCasterBuffs.db.profile.enemy_npc_debuffs_others = {}
	GridStatusCasterBuffs.db.profile.boss_buffs_self = {}
	GridStatusCasterBuffs.db.profile.debuff_type = {}
	GridStatusCasterBuffs.db.profile.boss_groups = {}


end


function GridStatusCasterBuffs:OnStatusEnable(status)
-- this function will be called 3 times for each registerstatus


	
	--GridStatusCasterBuffs:clear()

	
	if status == "unit_gridcaster_debuff1" then

		self:RegisterEvent("PLAYER_REGEN_DISABLED", "inCombat")
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "outCombat")
		self:RegisterEvent("PLAYER_DEAD", "outCombat")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateAllUnits")
		self:RegisterEvent("UNIT_AURA", "UpdateUnit2")
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatLog")
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "printBossSpells")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
		self:UpdateAllUnits()
	end
end


--status lost
function GridStatusCasterBuffs:OnStatusDisable(status)

    if status == "unit_gridcaster_debuff1" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("PLAYER_DEAD")
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		self:UnregisterEvent("UNIT_AURA")
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
	self.core:SendStatusLostAllUnits(status)

end


lib = {}
if (not lib.Tooltip) then
    lib.Tooltip = CreateFrame("GameTooltip");
    lib.Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
end
-- Create tooltip lines if they do not exist
for i = 1, 5 do
    if (not lib["TooltipTextLeft" .. i]) then
        lib["TooltipTextLeft" .. i] = lib.Tooltip:CreateFontString();
        lib["TooltipTextRight" .. i] = lib.Tooltip:CreateFontString();
        lib.Tooltip:AddFontStrings(lib["TooltipTextLeft" .. i], lib["TooltipTextRight" .. i]);
    end
end


function getToolTip (unitName, i)


	lib.Tooltip:SetUnitDebuff(unitName, i)
	local desc =   lib.TooltipTextLeft2:GetText()

	return desc

end

function getToolTipBuff (unitid, i)


	lib.Tooltip:SetUnitBuff(unitid, i)
	local desc =   lib.TooltipTextLeft2:GetText()

	return desc

end
function getToolTipSpell (spellid)

	lib.Tooltip:SetSpellByID(spellid)
	local desc = ""
	
	desc = (lib.TooltipTextLeft1:GetText() or "")
	desc = desc .. ", " .. (lib.TooltipTextLeft2:GetText() or "")
	desc = desc .. ", " .. (lib.TooltipTextLeft3:GetText() or "")
	desc = desc .. ", " .. (lib.TooltipTextLeft4:GetText() or "")
	desc = desc .. ", " .. (lib.TooltipTextLeft5:GetText() or "")

	return desc

end










local player_buffs = {}
--warrior
player_buffs ["Last Stand"] = 1
player_buffs ["Shield Wall"] = 1
player_buffs ["Shield Block"] = 1
player_buffs ["Enraged Regeneration"] = 1
--paladin
player_buffs ["Divine Shield"] = 1
player_buffs ["Ardent Defender"] = 1
player_buffs ["Divine Protection"] = 1
player_buffs ["Divine Plea"] = 1
player_buffs ["Guardian of Ancient Kings"] = 1
--druid
player_buffs ["Frenzied Regeneration"] = 1
player_buffs ["Survival Instincts"] = 1
player_buffs ["Innervate"] = 1

--priest
player_buffs ["Guardian Spirit"] = 1
--dk
player_buffs ["Vampiric Blood"] = 1
player_buffs ["Icebound Fortitude"] = 1
player_buffs ["Blood Shield"] = 1

player_buffs ["Beacon of Light"] = 1

--shaman
player_buffs ["Mana Tide"] = 1


player_buffs["Drink"]=1


local priority_debuffs = {}
--thrones
priority_debuffs ["Fungal Spores"] = 1
priority_debuffs ["Chain Lightning"] = 1
priority_debuffs ["Poisoned Spear"] = 1
priority_debuffs ["Waterlogged"] = 1
priority_debuffs ["Lightning Surge"] = 1
priority_debuffs ["Magma Splash"] = 1
priority_debuffs ["Emberstrike"] = 1
priority_debuffs ["Burning Embers"] = 1
priority_debuffs ["Wave of Corruption"] = 1

priority_debuffs ["Ignite"] = 1
priority_debuffs ["Corrupted Flame"] = 1
priority_debuffs ["Confounding Flames"] = 1
priority_debuffs ["Bleeding Wound"] = 1
--priority_debuffs ["Burning Wound"] = 1
priority_debuffs ["Flame Conduit"] = 1
priority_debuffs ["Supernova"] = 1


priority_debuffs ["Binding Shadows"] = 1
--player_buffs ["Illuminated Healing"] = 1

--grim batol 
priority_debuffs ["Burning Flames"] = 1
priority_debuffs ["Flame Shock"] = 1
priority_debuffs ["Overcharge"] = 1
priority_debuffs ["Petrified Skin"] = 1
priority_debuffs ["Curse of the Azureborne"] = 1
 
--City
priority_debuffs ["Disease Breath"] = 1
priority_debuffs ["Viscous Poison"] = 1
priority_debuffs ["Toxic Blow Dart"] = 1
--priority_debuffs ["Plague of Ages"] = 1
priority_debuffs ["Infectious Plague"] = 1

--halls
priority_debuffs ["Entangling Shot"] = 1
priority_debuffs ["Divine Reckoning"] = 1
--priority_debuffs ["Noxious Spores"] = 1
--priority_debuffs ["Void Infusion"] = 1
priority_debuffs ["Bubble Bound"] = 1
priority_debuffs ["Spore Blast"] = 1
priority_debuffs ["Nemesis Strike"] = 1
--priority_debuffs ["Searing Flames"] = 1

--vp
priority_debuffs ["Asphyxiate"] = 1

--sfk
priority_debuffs ["Pain and Suffering"] = 1
priority_debuffs ["Drain Life"] = 1
priority_debuffs ["Cursed Veil"] = 1
priority_debuffs ["Blinding Shadows"] = 1
priority_debuffs ["Living Bomb"] = 1
--priority_debuffs ["Conjure Poisonous Mixture"] = 1
priority_debuffs ["Pustulant Spit"] = 1
priority_debuffs ["Haunting Spirits"] = 1
priority_debuffs ["Cursed Bullets"] = 1
priority_debuffs ["Haunting Spirits"] = 1



--brc
priority_debuffs ["Pustulant Spit"] = 1
priority_debuffs ["Immolate"] = 1
priority_debuffs ["Dark Command"] = 1
priority_debuffs ["Frost Fever"] = 1
priority_debuffs ["Shadow Prison"] = 1
priority_debuffs ["Twilight Corruption"] = 1

--deadmines
priority_debuffs ["Frost Blossom"] = 1
priority_debuffs ["Holy Fire"] = 1

--stonecore
priority_debuffs ["Paralyze"] = 1
priority_debuffs ["Curse of the Runecaster"] = 1


local ignore_debuffs = {}
ignore_debuffs ["Exhaustion"] = 1
ignore_debuffs ["Temporal Displacement"] = 1
ignore_debuffs ["Arcane Blast"] = 1
ignore_debuffs ["Recently Bandaged"] = 1
ignore_debuffs ["Hypothermia"] = 1
ignore_debuffs ["Deserter"] = 1
ignore_debuffs ["Dungeon Deserter"] = 1



local timers = {}


function   GridStatusCasterBuffs:updateChatFrames()

	if (not chatFrameAuras) or (not chatFrameAbilities) then

		for i = 1, NUM_CHAT_WINDOWS do

			local name = GetChatWindowInfo (i)

			if name == "GridCasterAuras" then
		    	chatFrameAuras = getglobal("ChatFrame"..i)

			end
			if name == "GridCasterAbilities" then
			    chatFrameAbilities = getglobal("ChatFrame"..i)

			end
		end

	end
	
	
end


function GridStatusCasterBuffs:inCombat ()

	isCombat = 1;
	

	

	if chatFrameAuras then
		chatFrameAuras:Clear()
	end

	auras_current = {}
	auras_by_unit = {}
	boss_buffs_current = {}
    boss1_current = nil


	self:updateDebuffs();





end

function GridStatusCasterBuffs:outCombat ()

	isCombat = 0;

 	if chatFrameAuras then
		chatFrameAuras:Clear()
	end

	auras_current = {}
	auras_by_unit = {}
	boss_buffs_current = {}

	self:updateDebuffs();



end





function UnitIsEnemyNPC (unitid)


   if UnitIsPlayer (unitid) then return false end
   if UnitIsFriend ("player", unitid) then return false end
   
   return true

end



function queryDebuff (status, guid, unitName, unitid,start_index)

	local settings_debuff =  GridStatusCasterBuffs.db.profile[status];
	if settings_debuff.enable then
		local i
		        
		for i = start_index, 40
		do 
																									-- only party members
			local name, _, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitDebuff (unitName, i);
			
			

			if not name then
				GridStatusCasterBuffs.core:SendStatusLost(guid, status)
				-- no buffs
				--
                return -1
			end

			if not GridStatusCasterBuffs.db.profile.aura_desc[spellId] then
				GridStatusCasterBuffs.db.profile.aura_desc[spellId] = getToolTip(unitName, i) or ""
			end

			if not GridStatusCasterBuffs.db.profile.spell_name[spellId] then
            	GridStatusCasterBuffs.db.profile.spell_name[spellId] = name
			end
			
			-- save the debuffs of enemy mobs
			if caster and UnitIsEnemyNPC (caster) then

		        local caster_name = UnitName (caster)
				if not GridStatusCasterBuffs.db.profile.enemy_npc_debuffs_others [caster_name] then
					GridStatusCasterBuffs.db.profile.enemy_npc_debuffs_others [caster_name] = {}
				end
				
				if not GridStatusCasterBuffs.db.profile.enemy_npc_debuffs_others [caster_name][spellId] then
			
					GridStatusCasterBuffs.db.profile.enemy_npc_debuffs_others [caster_name][spellId]=GridStatusCasterBuffs.db.profile.aura_desc[spellId]
				end

			
			end     			        
		

			if debuffType then
			-- save the type of dispell
              GridStatusCasterBuffs.db.profile.debuff_type [spellId] = string.sub (debuffType, 1, 1)            
       		end


			if not ignore_debuffs[name] then
				
				if not auras_current[spellId] then
					auras_current[spellId] = {}
				end


				if expirationTime and (expirationTime > GetTime() ) then
				
					auras_current[spellId][unitName] = expirationTime
					auras_by_unit [unitName][spellId] = expirationTime
					
				else
					auras_current[spellId][unitName] = 0
					auras_by_unit [unitName][spellId] = 0
				end

				local start = duration and expirationTime and (expirationTime - duration)


				GridStatusCasterBuffs.core:SendStatusGained(guid, status,
											  settings_debuff.priority,
											  (settings_debuff.range and 40),
											  (settings_debuff.color),
													remaining_stg, name, nil, icon, start, duration, count)


				return i
			end


		end
		GridStatusCasterBuffs.core:SendStatusLost(guid, status)
		return -1
	end
	return -1

end



function GridStatusCasterBuffs:UpdateUnit2 (event, unitid)

	if not unitid then return end;
	if (not string.sub (unitid, 1, 4) == "boss") and(not UnitIsUnit("player", unitid)) and (not UnitInParty(unitid)) and (not UnitInRaid(unitid)) then return end

	--DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. ": updateunit2 " .. unitid)

	if timers[unitid] then return end

	local rand_time = math.random()
	
	if GetNumRaidMembers() > 10 then

	else
		rand_time = rand_time / 2
	end
	
	--DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. ": random " .. rand_time)
	
	timers[unitid] = self:ScheduleTimer ("UpdateUnit", rand_time, unitid)

end


function GridStatusCasterBuffs:UpdateUnit (unitid)


	--if not unitid then return end;
	--if (not string.sub (unitid, 1, 4) == "boss") and (not UnitIsUnit("player", unitid)) and (not UnitInParty(unitid)) and (not UnitInRaid(unitid)) then return end
	

	if timers[unitid] then
		timers[unitid] = nil
 	end
 	
	local unitName = UnitName (unitid)
	if not unitName then return end;
	if unitName == "Unknown" then return end;

    GridStatusCasterBuffs:updateChatFrames()

	
	for debuff_name, _ in pairs (auras_current) do
		auras_current[debuff_name][unitName] = nil
	end
	auras_by_unit [unitName] = {}
	
	----determine what are the boss's current buffs
	if string.sub (unitid, 1, 4) == "boss" then

       boss_buffs_current[unitName] = {}

       if not GridStatusCasterBuffs.db.profile.boss_buffs_self [unitName] then 
			GridStatusCasterBuffs.db.profile.boss_buffs_self [unitName] = {}
	   end
	   
	--we are in combat near or at a boss
	--to avoid picking up players in town through the combat log
	   if isCombat == 1  then
	    
	   		if unitid == "boss1" and not boss1_current then
				boss1_current = unitName
			   if not GridStatusCasterBuffs.db.profile.boss_groups [boss1_current] then
					GridStatusCasterBuffs.db.profile.boss_groups [boss1_current]= {}
				end
			end
			
			--make sure no unknowns
			--DEFAULT_CHAT_FRAME:AddMessage(unitid .. ": " .. unitName) -- boss3 / 4? grim batol?   boss1 change??

			if boss1_current then
				if not GridStatusCasterBuffs.db.profile.boss_groups [boss1_current][unitName] then
					GridStatusCasterBuffs.db.profile.boss_groups [boss1_current][unitName] = 1
				end
			end
	   end
       
	   local i = 1
	   
	   while i <= 40
	   do	   
	   	
	   	local name, _, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitBuff (unitid, i);
	   	
	   	if not name then break end
	   	 		
	   	if not GridStatusCasterBuffs.db.profile.aura_desc[spellId] then
			GridStatusCasterBuffs.db.profile.aura_desc[spellId] = getToolTipBuff(unitid, i) or ""
		end		
				
		if not GridStatusCasterBuffs.db.profile.boss_buffs_self [unitName][spellId] then
		   	GridStatusCasterBuffs.db.profile.boss_buffs_self [unitName][spellId]=GridStatusCasterBuffs.db.profile.aura_desc[spellId]
		end
				
        if not GridStatusCasterBuffs.db.profile.spell_name[spellId] then
          	GridStatusCasterBuffs.db.profile.spell_name[spellId] = name
		end
				
		if expirationTime and (expirationTime > GetTime() )  then
			boss_buffs_current[unitName][spellId] = expirationTime
		else
			boss_buffs_current[unitName][spellId] = 0
		end
		
		i = i + 1
	   end
	 end
	 
	--check the current debuffs in the player/party/raid
	if UnitIsUnit("player", unitid) or UnitInParty(unitid) or  UnitInRaid(unitid) then
		local guid = UnitGUID(unitid)
	
		local last_index = queryDebuff("unit_gridcaster_debuff1", guid, unitName, unitid, 1)
		if last_index > 0 then
			last_index = queryDebuff("unit_gridcaster_debuff2", guid, unitName, unitid, last_index + 1)
			
			if last_index > 0 then
				queryDebuff("unit_gridcaster_debuff3", guid, unitName, unitid,last_index + 1)
			else
				GridStatusCasterBuffs.core:SendStatusLost(guid, "unit_gridcaster_debuff3")
			end
		
		else
			GridStatusCasterBuffs.core:SendStatusLost(guid, "unit_gridcaster_debuff2")
			GridStatusCasterBuffs.core:SendStatusLost(guid, "unit_gridcaster_debuff3")
		end
	end

    --check the current buffs (player_buffs) in the player/party/raid
 	if UnitIsUnit("player", unitid) or UnitInParty(unitid) or  UnitInRaid(unitid) then
	   
	   local i = 1
	   while i <= 40
	   do
			
   		local name, _, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitBuff (unitid, i);
   		


		if not name then break end
	
		if player_buffs[name] then
			   	
			if not GridStatusCasterBuffs.db.profile.spell_name[spellId] then
            	GridStatusCasterBuffs.db.profile.spell_name[spellId] = name
			end
		   	 	
		   	if not GridStatusCasterBuffs.db.profile.aura_desc[spellId] then
				GridStatusCasterBuffs.db.profile.aura_desc[spellId] = getToolTipBuff(unitid, i) or ""
			end
	
			if not auras_current[spellId] then
				auras_current[spellId] = {}
			end	
			
			if caster and name == "Beacon of Light"  then				
						
				if UnitName(caster) == "Acruxis"and (realm == "Proudmoore") and (expirationTime - GetTime() ) < 60 then
					auras_current[spellId][unitName] = expirationTime
					auras_by_unit[unitName][spellId] = expirationTime
				end
			else
				auras_current[spellId][unitName] = expirationTime --expirationTime should not be nil
				auras_by_unit[unitName][spellId] = expirationTime
			end
		end
		
		i = i + 1
		
	  end	
	   
	end
	
	
		
	self:updateDebuffs()

end






function GridStatusCasterBuffs:UpdateAllUnits ()

	local lockdown = InCombatLockdown()


 	
 	auras_current = {}
	auras_by_unit = {}
	boss_buffs_current = {}

	
 	for guid, unitid in GridRoster:IterateRoster() do

		self:UpdateUnit(unitid)
	end

end

function GridStatusCasterBuffs:printAurasByUnit (unitid)

	local unitName = UnitName (unitid)
	if not unitName then return end;

	local debuff_sg = unitid .. "(" .. UnitName(unitid) .. ")" .. ": "
	
	local units_debuffs = auras_by_unit[unitName]
	
	if units_debuffs then
	
		for debuff_id, expirationTime in pairs (units_debuffs) do
		
		    local debuff_name =  GridStatusCasterBuffs.db.profile.spell_name [debuff_id]		    
		    
		    local remainder_stg = GridStatusCasterBuffs.db.profile.debuff_type [debuff_id] or ""
		    
		    --local expirationTime = auras_current[debuff_id][unitName]
		    
		    if expirationTime > 0 and (expirationTime > GetTime () ) then 
		    	remainder_stg = remainder_stg .. string.format("%d", expirationTime - GetTime () )
		    else
		    	remainder_stg = remainder_stg .. "0"
		    end
		    
		
			if priority_debuffs [debuff_name] then
				debuff_sg = debuff_sg .. " |cFFFF0000"  .. debuff_name .. "(" .. remainder_stg .. ") ".. "|r" -- red
			elseif player_buffs [debuff_name] then
				debuff_sg = debuff_sg .. " |cFFFFFF00"  .. debuff_name .. "(" .. remainder_stg .. ") ".. "|r" -- yellow

			elseif GridStatusCasterBuffs.db.profile.debuff_type [debuff_id] then
				debuff_sg = debuff_sg .. " |cFF00FF00" .. debuff_name .. "(" .. remainder_stg .. ") ".. "|r"-- green
			else
				debuff_sg = debuff_sg .. " " .. debuff_name .. "(" .. remainder_stg .. ") "-- white
			end

		end
 	end


   	chatFrameAuras:AddMessage(debuff_sg)


end

function GridStatusCasterBuffs:printBuffsOfBoss ()

	for boss, debuff_ids in pairs(boss_buffs_current) do
	
		local stg = boss..": "
	
	    for debuff_id, expirationTime in pairs (debuff_ids) do
	    	
	    	--expirationTime = boss_debuffs[boss][debuff_id]	    	
	    	
	    	if expirationTime > 0 then
	    		expirationTime = expirationTime - GetTime()
	    	end               	    		
	    	
	    	if expirationTime >= 0 then 
	    		stg = stg .. " " .. GetSpellLink(debuff_id) .. string.format ("(%d)" , expirationTime)
				stg = string.gsub (stg, "\n", " ");
			end
		end

		chatFrameAuras:AddMessage(stg,1,1,1,nil,false)
	end
end



function GridStatusCasterBuffs:printAuraDesc ()

	for debuff_id, players in pairs(auras_current) do
	
	
        local debuff_name = GridStatusCasterBuffs.db.profile.spell_name [debuff_id]
		local found = 0
		local list_of_players = ""
		for unitName, expirationTime in pairs (players) do
		
			local remainder_stg = GridStatusCasterBuffs.db.profile.debuff_type [debuff_id] or ""
		    
		    --expirationTime = auras_current[debuff_id][unitName]  --_=expirationTime?
		    
		    if expirationTime > 0 and (expirationTime > GetTime () ) then 
		    	remainder_stg = remainder_stg .. string.format("%d", expirationTime - GetTime () )
		    else
		    	remainder_stg = remainder_stg .. "0"
		    end		
			
			list_of_players = list_of_players .. unitName .. "(" .. remainder_stg .. ") "
			found = 1
		end
		if found == 1 then
			local stg = GetSpellLink (debuff_id) .."(" .. GridStatusCasterBuffs.db.profile.aura_desc[debuff_id] .. "): " .. list_of_players;
			stg = string.gsub (stg, "\n", " ");
			if priority_debuffs [debuff_name] then
				chatFrameAuras:AddMessage(stg,1,0,0,nil,false) --red priority debuff
			elseif player_buffs [debuff_name] then
				chatFrameAuras:AddMessage(stg,1,1,0,nil,false) --yellow using a cooldown
			elseif GridStatusCasterBuffs.db.profile.debuff_type[debuff_id] then
				chatFrameAuras:AddMessage(stg,0,1,0,nil,false) --green can be dispelled by someone
			else
			    chatFrameAuras:AddMessage(stg,1,1,1,nil,false) --white (cannot be dispelled)
			end

		end
	end



end

function GridStatusCasterBuffs:updateDebuffs ()

	if not chatFrameAuras then return end

	chatFrameAuras:Clear()
    chatFrameAuras:AddMessage  ("BOSS BUFFS---------------------------")
	self:printBuffsOfBoss ()
	
	chatFrameAuras:AddMessage  ("PLAYER AURAS-----------------------")
	
	self:printAurasByUnit ("player")
	
	--party1 not defined outside a party
	
	

	if (GetNumRaidMembers()) > 0 then
	    if  (GetNumRaidMembers() <= 10)   then
			self:printAurasByUnit ("raid1")
			self:printAurasByUnit ("raid2")
			self:printAurasByUnit ("raid3")
			self:printAurasByUnit ("raid4")
			self:printAurasByUnit ("raid5")
			self:printAurasByUnit ("raid6")
			self:printAurasByUnit ("raid7")
			self:printAurasByUnit ("raid8")
			self:printAurasByUnit ("raid9")
		end
	else
		self:printAurasByUnit ("party1")
		self:printAurasByUnit ("party2")
		self:printAurasByUnit ("party3")
		self:printAurasByUnit ("party4")
	end
	

	
	chatFrameAuras:AddMessage  ("AURA DESCRIPTIONS-----------------------")
	
    self:printAuraDesc()


end

-- casts a spell
function GridStatusCasterBuffs:CombatLog(event, ...)
	local timestamp, Spelltype, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
	
	if not sourceName then
	    return
	end


    --only care about unfriendlies
 	if UnitIsUnit("player", sourceName) or UnitIsPlayer(sourceName) or UnitPlayerOrPetInParty (sourceName) or UnitPlayerOrPetInRaid (sourceName) then
	 	return
	end


	--DEFAULT_CHAT_FRAME:AddMessage(sourceName)
	--DEFAULT_CHAT_FRAME:AddMessage(UnitIsPlayer(sourceName))
	



	if isCombat == 1 and sourceGUID and strsub(Spelltype,1, 5) == "SPELL" then
		
		
		--
		if (Spelltype == "SPELL_CAST_START" or Spelltype=="SPELL_MISS" or Spelltype == "SPELL_CAST_SUCCESS" or Spelltype == "SPELL_AURA_APPLIED" or Spelltype == "SPELL_DAMAGE" or Spelltype == "SPELL_HEAL") then
		

			
			local spellId, spellName, _ = select(9, ...)
						
			if not GridStatusCasterBuffs.db.profile.npc_spells[sourceName] then
				GridStatusCasterBuffs.db.profile.npc_spells[sourceName] = {}
			end			
			
			if not GridStatusCasterBuffs.db.profile.npc_spells[sourceName][spellId] then
				GridStatusCasterBuffs.db.profile.npc_spells[sourceName][spellId] =  getToolTipSpell(spellId)

				
				--if UnitGUID("target") == sourceGUID then
				self:printBossSpells()
 				--end
			end
		end
	end

end

 
function GridStatusCasterBuffs:printBossSpells ()

	if not chatFrameAbilities then return end
	

	chatFrameAbilities:Clear()
	
	local target_name = UnitName("target")

	if not target_name then return end
	

	 --unknown??
	local current_boss_group = GridStatusCasterBuffs.db.profile.boss_groups [target_name]
	
	if current_boss_group then

		for bossName,_ in pairs (current_boss_group) do
			--DEFAULT_CHAT_FRAME:AddMessage(bossunitid .. ": " .. bossName)
			GridStatusCasterBuffs:printUnitAbilities (bossName)
		end
		
	else

		GridStatusCasterBuffs:printUnitAbilities (target_name)
	end




end

				
				
function GridStatusCasterBuffs:printUnitAbilities (target_name)




	chatFrameAbilities:AddMessage("Target: " .. target_name)

	chatFrameAbilities:AddMessage  ("SPELLS ------------------------------")
    --can be friendlies, want to be unique key
	local spellIds = GridStatusCasterBuffs.db.profile.npc_spells[target_name]

	if spellIds then

    	for spellId, spell_desc in pairs(spellIds) do
			chatFrameAbilities:AddMessage(GetSpellLink(spellId)  .. ": " .. spell_desc)
		end
	end

	chatFrameAbilities:AddMessage  ("DEBUFFS (OTHERS) ---------------------------")
     --no need unique key
	local aura_names = GridStatusCasterBuffs.db.profile.enemy_npc_debuffs_others[target_name]

	if aura_names then


    	for aura_id, aura_desc in pairs(aura_names) do
    		t = GridStatusCasterBuffs.db.profile.debuff_type[aura_id] or ""
			chatFrameAbilities:AddMessage(GetSpellLink(aura_id) .. ": (" .. t .. ") " .. aura_desc)
		end
	end

	chatFrameAbilities:AddMessage  ("BUFFS (SELF) BOSS ----------------------")
     --no need unique key
	aura_names = GridStatusCasterBuffs.db.profile.boss_buffs_self[target_name]

	if aura_names then

    	for aura_id, aura_desc in pairs(aura_names) do
			chatFrameAbilities:AddMessage(GetSpellLink(aura_id) .. ": " .. aura_desc)
		end
	end
end