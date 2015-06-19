local _G = _G
local Loremaster = Loremaster
local L = Loremaster.L
local f = DEFAULT_CHAT_FRAME
local string = string

local function showHelp()
	local c1, c2 = "|cff4682b4", "|cffeedd82"
	f:AddMessage(L["Loremaster slash commands"], 0, 1, 1)
	f:AddMessage(L["Usage: /lm or /loremaster"] .. " { " .. L["show"] .. " | " .. L["hide"] .. " | " .. " | " .. string.lower(_G.HELP_LABEL) .. " }", 0, 1 ,1)
--	f:AddMessage(L["Usage: /lm or /loremaster"] .. " { " .. L["show"] .. " | " .. L["hide"] .. " | " .. L["reset"] .. " | " .. string.lower(_G.HELP_LABEL) .. " }", 0, 1 ,1)
	f:AddMessage(" - " .. L["show"] .. " " .. c2 .. ": " .. L["Show Loremaster"], 0, 1, 1)
	f:AddMessage(" - " .. L["hide"] .. " " .. c2 .. ": " .. L["Hide Loremaster"], 0, 1, 1)
--	f:AddMessage(" - " .. L["reset"] .. " " .. c2 .. ": " .. L["Reset Loremaster"], 0, 1, 1)
	f:AddMessage(" - " .. string.lower(_G.HELP_LABEL) .. " " .. c2 .. ": " .. _G.HELP_LABEL, 0, 1, 1)
end

function Loremaster:chatCommand(input)
	local command = string.lower(input or "")
	local space = string.find(command, " ")
	local nextspace, i, rc, p, r
	local params, playername, rollnum, name, p, r = "", "", 0, "", "", ""
	local pfound = 0
	if space then
		params = string.lower(string.sub(command, space + 1))
		command = string.sub(command, 1, space - 1)
	end
	if command == L["show"] then Loremaster.MainFrame:Show()
	elseif command == L["hide"] then Loremaster.MainFrame:Hide()
--	elseif command == L["reset"] then StaticPopup_Show("LOREMASTER_RESET")
	elseif command == string.lower(_G.HELP_LABEL) then showHelp()
	else Loremaster.MainFrame:Show() end
end
