local Language = GetLocale()
local L = Scrap_Locals

-- Traditional Chinese -- 
if Language == 'zhTW' then
	L["ConfirmDelete"] = "你確實要摧毀所有垃圾物品嗎？此動作無法撤銷。"
	L["DeleteJunk"] = "摧毀垃圾"
	
-- Simplified Chinese -- 
elseif Language == 'zhCN' then
L["ConfirmDelete"] = "你确定要摧毁所有垃圾物品吗？此操作无法撤销。"
L["DeleteJunk"] = "摧毁垃圾"

-- Russian --
elseif Language == 'ruRU' then
	L["ConfirmDelete"] = "Вы уверены, что хотите уничтожить весь хлам? Вы не сможете отменить это действие."
	L["DeleteJunk"] = "Уничтожить хлам"


-- German --
elseif Language == 'deDE' then
	L["ConfirmDelete"] = "Bist Du sicher, dass Du alle Deine Müllgegenstände zerstören möchtest? Du kannst dies nicht rückgängig machen."
	L["DeleteJunk"] = "Müll zerstören"

-- English --
else
	L.ConfirmDelete = 'Are you sure you want to destroy all your junk items? You cannot undo this action.'
	L.DeleteJunk = 'Destroy Junk'
end