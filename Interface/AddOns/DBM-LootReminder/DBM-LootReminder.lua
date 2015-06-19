do
    local dbmCmdHandler = SlashCmdList["DEADLYBOSSMODS"];
    if dbmCmdHandler == nil then return end

    SlashCmdList["DEADLYBOSSMODS"] = function(msg, ...)
       	local cmd = msg:lower()
        if cmd:sub(1, 4) == "pull" then
            local lootMethod = UnitLootMethod[GetLootMethod()].text
            if lootMethod ~= nil then
                DBM:AddMsg(RED_FONT_COLOR_CODE .. ">>> " .. FONT_COLOR_CODE_CLOSE .. lootMethod .. RED_FONT_COLOR_CODE .. " <<<" .. FONT_COLOR_CODE_CLOSE)
            end
        end
        return dbmCmdHandler(msg, ...)
    end
end