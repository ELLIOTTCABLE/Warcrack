﻿local L = LibStub("AceLocale-3.0"):NewLocale( "DataStore_Mails", "zhCN" )

if not L then return end

L["EXPIRY_CHECK_LABEL"] = "邮件过期警告" -- Needs review
L["SCAN_MAIL_BODY_LABEL"] = "扫描邮件内容(标记为已读)" -- Needs review
L["Warn when mail expires in less days than this value"] = "在邮件过期前多少天进行警告"

