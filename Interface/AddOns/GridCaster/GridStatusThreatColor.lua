
-- checked

local GridStatus = Grid:GetModule("GridStatus")
local GridRoster = Grid:GetModule("GridRoster")



local GridStatusThreatColor = GridStatus:NewModule("GridStatusThreatColor",  "AceTimer-3.0")
GridStatusThreatColor.menuName = "Threat Color"




GridStatusThreatColor.defaultDB = {
	debug = false,
	threat_color = {
		text = "Unit's Threat Color",
		enable = true,
		color = { r = 1, g = 0, b = 0, a = 1 }, -- high		
		priority = 99,
		range = false,
		aggro_audio_alert = false
		},
}



local threatColorOptions = {
	["aggro_audio_alert"] = {
        type = "toggle",
        name = "Audio Alert",
        desc = "Audio Alert if I draw aggro (when in healing spec)",
        order = 87,        
		get = function()
			return GridStatusThreatColor.db.profile.threat_color.aggro_audio_alert			
		end,
		set = function(value)
			GridStatusThreatColor.db.profile.threat_color.aggro_audio_alert = value			
		end
    },
	

}

GridStatusThreatColor.options = false


function GridStatusThreatColor:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit(nil,unitid)
	end
	
end

local current_threat_status = 0;
local healing_role = 0;

function GridStatusThreatColor:UpdateUnit(event,unitid)

	
 	if not unitid then return end

	--pets   (relook) -- does the event trigger on mobs?
	--see if we want pets for the others
  	--if (not UnitIsUnit("player", unitid)) and (not UnitInParty(unitid)) and (not UnitInRaid(unitid)) then return end

  	
    
	local settings = GridStatusThreatColor.db.profile.threat_color


	if settings.enable then
	
		local guid = UnitGUID(unitid)
	    local status = UnitThreatSituation(unitid)
	    
	    if status and settings.aggro_audio_alert and UnitIsUnit("player", unitid) and healing_role == 1 then	    
	    	
			if status == 3 and (status > current_threat_status) then
	    		PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav")
	    	end
	    	current_threat_status = status
	    end                      
			    
	    if status and status > 0 then 
			local r1, g1, b1 = GetThreatStatusColor(status)
			local status_stg =  string.format("%d", status)
				
			GridStatusThreatColor.core:SendStatusGained(guid, "threat_color",
											  settings.priority,
											  nil,											  
											  {r=r1,g=g1,b=b1}, status_stg)
		else
				
			GridStatusThreatColor.core:SendStatusGained(guid, "threat_color",
											  settings.priority,
											  nil,											  
											  {r=0,g=0,b=0}, "0")
		end
											 

	else
		self.core:SendStatusLostAllUnits("threat_color")
	end

end


function GridStatusThreatColor:OnInitialize()

	self.super.OnInitialize(self)
	self:RegisterStatus("threat_color", "Threat Color", threatColorOptions, true)
	self:UpdateAllUnits()


end


local timerHandle = nil

local class = nil

function GridStatusThreatColor:updateRole()

	
	if not class then
		class = select(2, UnitClass("player"))
	end
	
	local current_spec = GetPrimaryTalentTree ()	
	
	if (class == "PALADIN" and current_spec==1) or 
		(class == "DRUID" and current_spec==3) or 
		(class == "PRIEST" and current_spec==1) or 
		(class == "PRIEST" and current_spec==2) or 
		(class == "SHAMAN" and current_spec==3) 
	
	then
		healing_role = 1
	else 
		healing_role = 0
	end


end

		
function GridStatusThreatColor:inCombat()

	self:updateRole()
	current_threat_status = 0
	

	--local schedule_time = 1
	
    --if GetNumRaidMembers() > 10 then

	--else
--		schedule_time = schedule_time / 2
	--end
	
	--timerHandle = self:ScheduleRepeatingTimer("UpdateAllUnits", schedule_time)


end

function GridStatusThreatColor:outCombat()

	self:CancelTimer (timerHandle, true)
    self.core:SendStatusLostAllUnits("threat_color")
end


function GridStatusThreatColor:OnStatusEnable(status)

	if status == "threat_color" then
		
		self:RegisterEvent ("PLAYER_REGEN_DISABLED", "inCombat")
		--self:RegisterEvent ("PLAYER_REGEN_ENABLED", "outCombat")
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", "UpdateUnit")

	end
end

function GridStatusThreatColor:OnStatusDisable(status)
	if status == "threat_color" then
		
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		--self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
		self.core:SendStatusLostAllUnits("threat_color")
	end
end
