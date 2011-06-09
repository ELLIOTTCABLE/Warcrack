
------------------------------
--      Are you local?      --
------------------------------

local ontaxi
local flightview, landingview = 1, 5


---------------------------------
--      Addon Declaration      --
---------------------------------

Cockpit = DongleStub("Dongle-Beta0"):New("Cockpit")


------------------------------
--      Initialization      --
------------------------------

function Cockpit:Enable()
	self:RegisterEvent("UNIT_FLAGS")
	self:RegisterEvent("PLAYER_CONTROL_GAINED")
end


------------------------------
--      Event Handlers      --
------------------------------

function Cockpit:UNIT_FLAGS()
	if UnitOnTaxi("player") then
		SetView(flightview)
		ontaxi = true
	end
end


function Cockpit:PLAYER_CONTROL_GAINED()
	if ontaxi then
		SetView(landingview)
		ontaxi = false
	end
end




