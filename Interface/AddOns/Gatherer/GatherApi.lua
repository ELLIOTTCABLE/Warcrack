--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.2.3 (<%codename%>)
	Revision: $Id: GatherApi.lua 900 2010-12-04 23:45:25Z Esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	These functions can be used by external addons for interfacing with
	Gatherer. We will try and keep these functions as unchanged as possible.
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherApi.lua $", "$Rev: 900 $")

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

-- This function can be used as an interface by other addons to record things
-- in Gatherer's database, though display is still based only on what is defined
-- in Gatherer items and icons tables.
-- Parameters:
--   objectId (number): the object id for this node (from Gatherer.Nodes)
--   gatherType (string): gather type (Mine, Herb, Skin, Fish, Treasure)
--   indoorNode (boolean): whether the node is an indoor node (as determined by the minimap)
--   gatherSource (string): the name of the sender (or nil if you collected it)
--   gatherCoins (number): amount of copper found in the node
--   gatherLoot (table): a table of loot: { { link, count }, ...}
--   wasGathered (boolean): was this object actually opened by the player
function Gatherer.Api.AddGather(objectId, gatherType, indoorNode, gatherSource, gatherCoins, gatherLoot, wasGathered, gatherC, gatherZ, gatherX, gatherY)
	local success
	
	if not (gatherC and gatherZ and gatherX and gatherY) then
		gatherC, gatherZ, gatherX, gatherY = Gatherer.Util.GetPositionInCurrentZone()
		if not (gatherC and gatherZ and gatherX and gatherY) then
			return
		end
	end
	
	if ( gatherC <= 0 or gatherZ <= 0 ) then
		return
	end
	
	if (not gatherSource) then
		Gatherer.DropRates.ProcessDrops(objectId, gatherC, gatherZ, gatherSource, gatherCoins, gatherLoot)
	end
	
	-- if not specified, use the current player indoor/outdoor status
	if ( indoorNode == nil ) then
		indoorNode = not Astrolabe.minimapOutside
	end
	
	if ( type(objectId) == "number" ) then 
		local index = Gatherer.Storage.AddNode(objectId, gatherType, gatherC, gatherZ, gatherX, gatherY, gatherSource, wasGathered, indoorNode)
		if  index and index > 0 then
			success = true
		end

		-- If this is our gather
		if ( (not gatherSource) or (gatherSource == "REQUIRE") ) then
			Gatherer.Comm.Send(objectId, gatherType, indoorNode, gatherC, gatherZ, gatherX, gatherY, index)
		end
	end
	
	Gatherer.MiniNotes.ForceUpdate()
	Gatherer.MapNotes.MapDraw()

	return success
end
