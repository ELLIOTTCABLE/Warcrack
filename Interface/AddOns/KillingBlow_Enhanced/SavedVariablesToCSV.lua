local SavedVariablesPath, CSVPath = ...
if not SavedVariablesPath or not CSVPath then
	error([[Usage: lua SavedVariablesToCSV.lua "C:\Users\Public\Games\World of Warcraft\WTF\Account\MyAccount\SavedVariables\KillingBlow_Enhanced.lua" "C:\Users\MyUser\Documents\KillingBlows.csv"]])
end

--[[
Saved Variables format:

KillingBlow_Enhanced_DB = {
	["Pvpguy-Nagrand"] = {
		{
			["SessionType"] = "pvp", -- Battleground session
			["SessionStart"] = "2014-09-27T05:45:05Z",
			["SessionEnd"] = "2014-09-27T06:30:10Z",
			["2014-09-27T05:55:31Z"] = "Bobsmith-Aman'thul",
			["2014-09-27T05:50:00Z"] = "Janecitizen-Frostmourne",
		},
		{
			["SessionType"] = "arena", -- Arena session
			["SessionStart"] = "2014-09-27T07:30:05Z",
			["SessionEnd"] = "2014-09-27T08:00:15Z",
			["2014-09-27T07:35:30Z"] = "Bobsmith-Aman'thul",
			["2014-09-27T07:40:05Z"] = "Janecitizen-Frostmourne",
			["2014-09-27T07:45:35Z"] = "Examplename-Barthilas",
		},
		{
			["SessionType"] = "worldpvp", -- World PvP session
			["SessionStart"] = "2014-09-27T08:30:05Z",
			["SessionEnd"] = "2014-09-27T09:00:15Z",
			["2014-09-27T08:35:30Z"] = "Bobsmith-Aman'thul",
		},
	}
}

All timestamps are in the format "YYYY-MM-DDThh:mm:ssZ" (ISO 8601 Complete date plus hours, minutes and seconds [UTC]).
]]

dofile(SavedVariablesPath)

local OutputFile = assert(io.open(CSVPath, "w"))

-- Used to escape "'s
-- http://lua-users.org/wiki/CsvUtils
local function escapeCSV (s)
	if s:find('[,"]') then
		s = '"' .. s:gsub('"', '""') .. '"'
	end
	return s
end

local function WriteSession(playerName, session)
	local sessionType, sessionStart, sessionEnd = session.SessionType, session.SessionStart, session.SessionEnd

	for killTime, killedPlayer in pairs(session) do
		if not killTime:find("Session", 1, true) then
			OutputFile:write(playerName, ",", sessionType, ",", sessionStart, ",", sessionEnd, ",", killTime, ",", escapeCSV(killedPlayer), "\n")
		end
	end
end

local function WritePlayer(playerName, playerDB)
	local escapedPlayerName = escapeCSV(playerName)
	for _, session in ipairs(playerDB) do
		WriteSession(escapedPlayerName, session)
	end
end

OutputFile:write("KillingPlayer,SessionType,SessionStart,SessionEnd,KillTime,KilledPlayer\n")

for playerName, playerDB in pairs(KillingBlow_Enhanced_DB) do
	WritePlayer(playerName, playerDB)
end

OutputFile:flush()
OutputFile:close()

print("CSV successfully written to " .. CSVPath)