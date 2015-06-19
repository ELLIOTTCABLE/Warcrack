local _, addonTable = ...
---
-- Contains definitions for Chat and Floating Error window message controls.
-- @file objects/Messages.lua
-- @release 6.1.0_41
-- @copyright Atli Þór (atli.j@advefir.com)
---
--module "XToLevel.Messages" -- For documentation purposes. Do not uncomment!

local L = addonTable.GetLocale()

XToLevel.Messages = {
    printStyle = {
        white = { r=1.0, g=1.0, b=1.0, group=54, addToStart=false },
        gray = { r=0.5, g=0.5, b=0.5, group=53, addToStart=false }
    }
}

---
-- function description
function XToLevel.Messages:Print(message, style, color)
    r, g, b = unpack(color or {1, 1, 1});
    if style == nil then
        style = self.printStyle.white
    end
    DEFAULT_CHAT_FRAME:AddMessage(message, r, g, b, style.group, style.addToStart);
end

---
-- function description
function XToLevel.Messages:Debug(message)
    if XToLevel.db.profile.general.showDebug then
        self:Print(message, self.printStyle.gray, {0.5, 0.5, 0.5})
    end
end

---
-- Controls for the floating display
-- The settings check is added here to simplify the calling code.
XToLevel.Messages.Floating = {
    killStyle =  { r=0.5, g=1.0, b=0.7, group=56, fade=5 },
    questStyle = { r=0.5, g=1.0, b=0.7, group=56, fade=5 },
    levelStyle = { r=0.35, g=1.0, b=0.35, group=56, fade=6 },
}

---
-- function description
function XToLevel.Messages.Floating:PrintKill(mobName, mobsRequired)
    if XToLevel.db.profile.messages.playerFloating then
        local message = mobsRequired .." ".. mobName .. L["Kills Needed"]
        self:Print(message, XToLevel.db.profile.messages.colors.playerKill, self.killStyle)
    end
end

---
-- function description
function XToLevel.Messages.Floating:PrintQuest(questsRequired)
    if XToLevel.db.profile.messages.playerFloating then
        local message = questsRequired .. L["Quests Needed"]
        self:Print(message, XToLevel.db.profile.messages.colors.playerQuest, self.questStyle)
    end
end

---
-- Use to print anonymous XP gains (mining and such).
function XToLevel.Messages.Floating:PrintAnonymous(required)
    if XToLevel.db.profile.messages.playerFloating then
        local message = required .. L["Anonymous Needed"]
        self:Print(message, XToLevel.db.profile.messages.colors.playerQuest, self.questStyle)
    end
end

---
-- function description
function XToLevel.Messages.Floating:PrintBattleground(bgsRequired)
    if XToLevel.db.profile.messages.playerFloating then
        local message = bgsRequired .. L["Battlegrounds Needed"]
        self:Print(message, XToLevel.db.profile.messages.colors.playerBattleground, self.questStyle)
    end
end
---
-- function description
function XToLevel.Messages.Floating:PrintBGObjective(bgsRequired)
    if XToLevel.db.profile.messages.playerFloating and XToLevel.db.profile.messages.bgObjectives then
        local message = bgsRequired .. L["Battleground Objectives Needed"]
        self:Print(message, XToLevel.db.profile.messages.colors.playerBattleground, self.questStyle)
    end
end

---
-- function description
function XToLevel.Messages.Floating:PrintDungeon(remaining)
    if XToLevel.db.profile.messages.playerFloating then
        local message = remaining .. L["Dungeons Needed"]
        self:Print(message, XToLevel.db.profile.messages.colors.playerDungeon, self.questStyle)
    end
end

---
-- function description
function XToLevel.Messages.Floating:Print(text, color, style)
    local r, g, b = unpack(color or {1, 0.75, 0.35})
    if type(style) ~= "table" then
        style = self.questStyle
    end
    UIErrorsFrame:AddMessage(text, r, g, b, style.group, style.fade);
end

---
-- Controls for the chat display
---
XToLevel.Messages.Chat = {
    killStyle =  { r=0.5, g=1.0, b=0.7, group=56, addToStart=false },
    questStyle = { r=0.5, g=1.0, b=0.7, group=56, addToStart=false },
    levelStyle = { r=0.35, g=1.0, b=0.35, group=56, addToStart=false},
}

---
-- function description
function XToLevel.Messages.Chat:PrintKill(mobName, mobsRequired)
    if XToLevel.db.profile.messages.playerChat then
        local message = mobsRequired .." ".. mobName .. L["Kills Needed"]
        XToLevel.Messages:Print(message, self.killStyle, XToLevel.db.profile.messages.colors.playerKill)
    end
end

---
-- function description
function XToLevel.Messages.Chat:PrintQuest(questsRequired)
    if XToLevel.db.profile.messages.playerChat then
        local message = questsRequired .. L["Quests Needed"]
        XToLevel.Messages:Print(message, self.questStyle, XToLevel.db.profile.messages.colors.playerQuest)
    end
end

---
-- Use to print anonymous XP gains (mining and such).
function XToLevel.Messages.Chat:PrintAnonymous(questsRequired)
    if XToLevel.db.profile.messages.playerChat then
        local message = questsRequired .. L["Anonymous Needed"]
        XToLevel.Messages:Print(message, self.questStyle, XToLevel.db.profile.messages.colors.playerQuest)
    end
end

---
-- function description
function XToLevel.Messages.Chat:PrintBattleground(bgsRequired)
    if XToLevel.db.profile.messages.playerChat then
        local message = bgsRequired .. L["Battlegrounds Needed"]
        XToLevel.Messages:Print(message, self.questStyle, XToLevel.db.profile.messages.colors.playerBattleground)
    end
end
---
-- function description
function XToLevel.Messages.Chat:PrintBGObjective(bgsRequired)
    if XToLevel.db.profile.messages.playerChat and XToLevel.db.profile.messages.bgObjectives then
        local message = bgsRequired .. L["Battleground Objectives Needed"]
        XToLevel.Messages:Print(message, self.questStyle, XToLevel.db.profile.messages.colors.playerBattleground)
    end
end

---
-- function description
function XToLevel.Messages.Chat:PrintDungeon(remaining)
    if XToLevel.db.profile.messages.playerChat then
        local message = remaining .. L["Dungeons Needed"]
        XToLevel.Messages:Print(message, self.questStyle, XToLevel.db.profile.messages.colors.playerDungeon)
    end
end
