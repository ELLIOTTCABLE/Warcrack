------------------
-- PvP Category --
------------------

local AchieveIt = AchieveIt;

-------------------
-- Warsong Gulch --
-------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (443 == GetCurrentMapAreaID()) then
		return {
			id = 14804,
			name = GetMapNameByID(443)
		};
	end
	return false;
end);

------------------
-- Arathi Basin --
------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (461 == GetCurrentMapAreaID()) then
		return {
			id = 14802,
			name = GetMapNameByID(461)
		};
	end
	return false;
end);

----------------------
-- Eye of the Storm --
----------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (482 == GetCurrentMapAreaID()) then
		return {
			id = 14803,
			name = GetMapNameByID(482)
		};
	end
	return false;
end);

--------------------
-- Alterac Valley --
--------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (401 == GetCurrentMapAreaID()) then
		return {
			id = 14801,
			name = GetMapNameByID(401)
		};
	end
	return false;
end);

----------------------------
-- Strand of the Ancients --
----------------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (512 == GetCurrentMapAreaID()) then
		return {
			id = 14881,
			name = GetMapNameByID(512)
		};
	end
	return false;
end);

----------------------
-- Isle of Conquest --
----------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (540 == GetCurrentMapAreaID()) then
		return {
			id = 15003,
			name = GetMapNameByID(540)
		};
	end
	return false;
end);

------------------------
-- Battle for Gilneas --
------------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (736 == GetCurrentMapAreaID()) then
		return {
			id = 15073,
			name = GetMapNameByID(736)
		};
	end
	return false;
end);

----------------
-- Twin Peaks --
----------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (626 == GetCurrentMapAreaID()) then
		return {
			id = 15074,
			name = GetMapNameByID(626)
		};
	end
	return false;
end);

-----------------------
-- Silvershard Mines --
-----------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (860 == GetCurrentMapAreaID()) then
		return {
			id = 15162,
			name = GetMapNameByID(860)
		};
	end
	return false;
end);

-----------------------
-- Temple of Kotmogu --
-----------------------

AchieveIt.Categories:addLocate(function()
	-- if in bg
	if (856 == GetCurrentMapAreaID()) then
		return {
			id = 15163,
			name = GetMapNameByID(856)
		};
	end
	return false;
end);

-----------------
-- Wintergrasp --
-----------------

AchieveIt.Categories:addLocate(function()
	-- if in zone
	if (281 == GetCurrentMapAreaID()) then
		return {
			id = 14901,
			name = GetMapNameByID(281)
		};
	end
	return false;
end);

---------------
-- Tol Barad --
---------------

AchieveIt.Categories:addLocate(function()
	-- if in zone
	-- or baradin hold
	if (
		708 == GetCurrentMapAreaID() or
		752 == GetCurrentMapAreaID()
	) then
		return {
			id = 15075,
			name = GetMapNameByID(708)
		};
	end
	return false;
end);

------------------------------
-- 15092 Rated Battleground --
------------------------------

-- @todo

-----------
-- Arena --
-----------

AchieveIt.Categories:addLocate(function()
	local isArena, isRegistered = IsActiveBattlefieldArena();
	-- if in active arena
	if (isRegistered ~= false) then
		return {
			id = 165,
			name = "Arena"
		};
	end
	return false;
end);