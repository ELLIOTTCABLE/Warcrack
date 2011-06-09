-- Vars --
WhisperTarget = {}

-- Local Stack References --
local WhisperTarget = _G.WhisperTarget

local SendChatMessage = _G.SendChatMessage
local DEFAULT_CHAT_FRAME = _G.DEFAULT_CHAT_FRAME
local UnitName = _G.UnitName
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsFriend = _G.UnitIsFriend
local UnitExists = _G.UnitExists

local SlashCmdList = _G.SlashCmdList

-- Loading Function --
function WhisperTarget.OnLoad()
   SLASH_WHISPERTARGET1 =               "/wt"
   SlashCmdList["WHISPERTARGET"] =      WhisperTarget.WT_SlashHandler
   SLASH_WHISPERFOCUS1 =                "/wf"
   SlashCmdList["WHISPERFOCUS"] =       WhisperTarget.WF_SlashHandler
   SLASH_WHISPERMOUSEOVER1 =            "/wm"
   SlashCmdList["WHISPERMOUSEOVER"] =   WhisperTarget.WM_SlashHandler
   
   DEFAULT_CHAT_FRAME:AddMessage("WhisperTarget Loaded")
end

-- Slash Handlers --
function WhisperTarget.WT_SlashHandler(parm)
   WhisperTarget.WhisperHandler("target",parm)
end
function WhisperTarget.WF_SlashHandler(parm)
   WhisperTarget.WhisperHandler("focus",parm)
end
function WhisperTarget.WM_SlashHandler(parm)
   WhisperTarget.WhisperHandler("mouseover",parm)
end

-- Whisper Handler --
function WhisperTarget.WhisperHandler(toUnit, parm)
   if (not UnitExists(toUnit)) then
      DEFAULT_CHAT_FRAME:AddMessage("WhisperTarget: You have no "..toUnit..".")
      return
   end
   if (not UnitIsPlayer(toUnit)) then
      DEFAULT_CHAT_FRAME:AddMessage("WhisperTarget: Your "..toUnit.." is not a player.")
      return
   end
   if (not UnitIsFriend(toUnit, "player")) then
      DEFAULT_CHAT_FRAME:AddMessage("WhisperTarget: Your "..toUnit.." is an enemy player.")
      return
   end
   
   --we have a valid, same-faction player.  Whee!
   local TargetName, TargetRealm = UnitName(toUnit)

   if (TargetName) then
      if (TargetRealm and TargetRealm ~= "") then
         TargetName = TargetName .. "-" .. TargetRealm
      end
      
      SendChatMessage(parm,"WHISPER",nil,TargetName)
   end
end