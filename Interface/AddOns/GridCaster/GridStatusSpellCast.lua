---------------------------------------------------------------

-- SPELL CASTING    (checked)

---------------------------------------------------------------

local GridStatus = Grid:GetModule("GridStatus")
local GridRoster = Grid:GetModule("GridRoster")

local GridStatusSpellCast = GridStatus:NewModule("GridStatusSpellCast")
GridStatusSpellCast.menuName = "Unit's Spell"

GridStatusSpellCast.defaultDB = {
	debug = false,
	unit_spell = {
		text =  "Unit's Spell",
		enable = true,
		color = { r = 0, g = 0, b = 1, a = 1 },
		color_bar = {r = 0, g = 1, b = 0, a = 1},
		color_bar2 = {r = 1, g = 0, b = 0, a = 1},
		threshold = 0.5,
		priority = 99,
		range = false,
		refresh = 0.1,

	},
}

GridStatusSpellCast.options = false


local UnitSpellOptions = {

    ["spell_bar_color"] = {
        type = "color",
        name = "Spell Color (normal)",
        desc = "Color for Unit's Spell bar",
        order = 86,
        hasAlpha = true,
		get = function()
			local s = GridStatusSpellCast.db.profile.unit_spell.color_bar
			return s.r, s.g, s.b, s.a
		end,
		set = function(r,g,b,a)
			local s = GridStatusSpellCast.db.profile.unit_spell.color_bar
			s.r, s.g, s.b, s.a = r, g, b, a
		end
    },
	["spell_bar_color_ending"] = {
        type = "color",
        name = "Spell Color (ending)",
        desc = "Color for Unit's Spell bar (last xx seconds)",
        order = 87,
        hasAlpha = true,
		get = function()
			local s = GridStatusSpellCast.db.profile.unit_spell.color_bar2
			return s.r, s.g, s.b, s.a
		end,
		set = function(r,g,b,a)
			local s = GridStatusSpellCast.db.profile.unit_spell.color_bar2
			s.r, s.g, s.b, s.a = r, g, b, a
		end
    },
	["spell_bar_color_ending_time"] = {
 		type = "range",
		name = "Threshold (sec)",
		desc = "Threshold before spell cast turns to second color",
		max = 10,
		min = 0,
		step = 0.1,
		get = function ()
			return  GridStatusSpellCast.db.profile.unit_spell.threshold
			end,
		set = function(v)
			GridStatusSpellCast.db.profile.unit_spell.threshold = v
		end
    },
}

local noOptions = {}


function GridStatusSpellCast:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit(unitid)
	end
end

local function getTimeLeft (startTime, endTime)

	return

		function ()
			local val = nil
			local color = nil


			if startTime and endTime then


				val = (GetTime() - startTime/1000) / (endTime - startTime) * 100 * 1000



				if ( endTime/1000 - GetTime() ) < GridStatusSpellCast.db.profile.unit_spell.threshold then


					color = GridStatusSpellCast.db.profile.unit_spell.color_bar2
				else

					color = GridStatusSpellCast.db.profile.unit_spell.color_bar
				end       

			end      

			return val, color



		end



end

function GridStatusSpellCast:UpdateUnit(event, unitid)

	if not unitid then return end

  	if (not UnitIsUnit("player", unitid)) and (not UnitInParty(unitid)) and (not UnitInRaid(unitid)) then return end

	local settings = GridStatusSpellCast.db.profile.unit_spell
    

	if settings.enable then
	
	
		local guid = UnitGUID(unitid)

		local spell, _, _, _,startTime, endTime = UnitCastingInfo(unitid)

		if not spell then
			spell, _, _, _, startTime, endTime = UnitChannelInfo(unitid)
		end

		GridStatusSpellCast.core:SendStatusGained(guid, "unit_spell",
											  settings.priority,
											  nil,
											  (settings.color),
											  spell) -- , getTimeLeft(startTime, endTime), nil, nil) --maxvalue is nil so the status checker should skip


	else
		self.core:SendStatusLostAllUnits("unit_spell")
	end

end


function GridStatusSpellCast:OnInitialize()

	self.super.OnInitialize(self)
	--self:RegisterStatus("unit_spell", "Unit's Spell", UnitSpellOptions, true)
	self:RegisterStatus("unit_spell", "Unit's Spell", noOptions, true)
end

function GridStatusSpellCast:OnStatusEnable(status)
	if status == "unit_spell" then
		self:RegisterEvent("UNIT_SPELLCAST_START", "UpdateUnit")
		self:RegisterEvent("UNIT_SPELLCAST_STOP", "UpdateUnit")
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UpdateUnit")
		self:RegisterEvent("UNIT_SPELLCAST_DELAYED", "UpdateUnit")

		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UpdateUnit")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UpdateUnit")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UpdateUnit")


		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
		self:UpdateAllUnits()
	end
end

function GridStatusSpellCast:OnStatusDisable(status)
	if status == "unit_spell" then
		self:UnregisterEvent("UNIT_SPELLCAST_START")
		self:UnregisterEvent("UNIT_SPELLCAST_STOP")
		self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
		self:UnregisterEvent("UNIT_SPELLCAST_DELAYED")
		self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UpdateUnit")
		self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UpdateUnit")
		self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UpdateUnit")

		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self.core:SendStatusLostAllUnits("unit_spell")
	end
end