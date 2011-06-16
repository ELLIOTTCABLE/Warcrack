--[[ *******************************************************************
Project                 : TomTomPing
Description             : English translation file (enUS)
Author                  : 
Translator              : 
Revision                : $Rev: 1 $
********************************************************************* ]]

local MODNAME   = "TomTomPing"

local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale(MODNAME, "enUS", true, true)
if not L then return end

L["Target as destination"] = true
L["(Un)Stick current destination"] = true
L["Ping your position"] = true
L["Release CrazyArrow"] = true
L["Set waypoint on current position"] = true
L["Clear waypoint"] = true

L["None"] = true 
L["Target"] = true 
L["Focus"] = true 
L["Mouseover"] = true 
L["Mouseover-Click"] = true 
L["Waypoint"] = true 

L["Messages"] = true
L["Listen to remote TTP messages"] = true
L["DBM"] = true
L["Use Deadly Boss Mods"] = true
L["Minimap Button"] = true
L["Show Minimap Button"] = true
L["Hide Hint"] = true
L["Hide usage hint in tooltip"] = true
L["Also check the key bindings!"] = true

L["Arrow"] = true
L["Arrow Display Settings"] = true
L["Time Precision"] = true
L["Positions after decimal point"] = true
L["Range Precision"] = true

L["Ping"] = true
L["Ping Settings"] = true
L["Activate Ping"] = true
L["Show arrow on ping"] = true
L["Duration"] = true
L["Duration before fade out"] = true
L["Arrival Range"] = true
L["Fade out when within distance"] = true

L["Targeting"] = true
L["Target Settings"] = true
L["Destination"] = true
L["Select destination"] = true
L["Range Check"] = true
L["Range check for healing"] = true
L["Show Empty Destination"] = true
L["Show arrow when no destination is set"] = true

L["Destination"] = true
L["Type"] = true
L["Distance"] = true
L["Last Ping"] = true
L["Left-Click"] = true

L["Set target as destination"] = true
L["Right-Click"] = true
L["Open options menu"] = true
L["Ctrl-Left-Click"] = true
L["Stick/unstick destination"] = true
L["Ctrl-Right-Click"] = true
L["Release arrow"] = true
L["Shift-Left-Click"] = true
L["Ping at current location"] = true
L["Alt-Left-Click"] = true
L["Set waypoint at current location"] = true
L["Alt-Right-Click"] = true
L["Clear waypoint"] = true

L["Usage:"] = true
L["/tomtomping arg"] = true
L["/ttp arg"] = true
L["Args:"] = true
L["target - use current target as arrow target"] = true
L["stick - make current arrow target sticky"] = true
L["clear - release the crazy arrow"] = true
L["ping - ping on self"] = true
L["waypoint - set waypoint on self"] = true
L["wpclear - clear waypoint"] = true
L["measure - init map size measurement (Move at least 20 yards!)"] = true
L["version - display version information"] = true
L["menu - display options menu"] = true
L["help - display this help"] = true

L["Found TomTom: "] = true
L["+++ TomTom outdated +++\nYou have to install TomTom Version 216\nor higher to run TomTomPing\nYours is: "] = true
L["TomTom OK"] = true
L["+++ TomTom missing +++\nYou have to install TomTom to run TomTomPing!"] = true

L["Version"] = true

L["yards"] = true
L["s"] = true
L["Ping: "] = true
L["Sticky"] = true
L["no target"] = true
L["no coords"] = true
L["other zone"] = true

L["NO RANGE DATA FOUND\nType '/ttp measure' and then move 20 yards"] = true 
L["No map coordinates present for this instance! Aborting measurement."] = true
L["No reference point set. Please retry measurement."] = true
L["No range calculation. You have to move first!"] = true
L["Map dimensions stored for %s[%i]: x, y = %f, %f"] = true

