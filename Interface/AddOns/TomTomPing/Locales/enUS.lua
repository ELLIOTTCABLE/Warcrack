--[[ *******************************************************************
Project                 : TomTomPing
Description             : English translation file (enUS)
Author                  : 
Translator              : 
Revision                : $Rev: 1 $
********************************************************************* ]]

local ADDON = ...

local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale(ADDON, "enUS", true, true)
if not L then return end

L["Target as destination"] = true
L["(Un)Stick current destination"] = true
L["Ping your position"] = true
L["Release CrazyArrow"] = true
L["Set waypoint on current position"] = true
L["Clear waypoint"] = true

L["none"] = "None" 
L["target"] = "Target"
L["focus"] = "Focus" 
L["mouseover"] = "Mouseover"
L["mouseoverclick"] = "Mouseover-Click"
L["waypoint"] = "Waypoint"

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
L["Arrow points down to indicate arrival when within this distance"] = true
L["Hide on arrival"] = true
L["Hide arrow when within distance"] = true

L["Targeting"] = true
L["Target Settings"] = true
L["Destination"] = true
L["Select destination"] = true
L["Range Check"] = true
L["Range check for healing"] = true
L["Show Empty Destination"] = true
L["Show arrow when no destination is set"] = true
L["Mouse Button"] = true
L["Select mouse button to use for mouseover-click setting."] = true
L["Modificator keys"] = true
L["Modificator keys for mouse-over settings."] = true
L["In Combat"] = true
L["Show mouse-over target in combat."] = true
L["Out of Combat"] = true
L["Show mouse-over target out of combat."] = true
L["Target Alive"] = true
L["Show mouse-over target when target is alive."] = true
L["Target Dead"] = true
L["Show mouse-over target when target is dead."] = true
L["In Range"] = true
L["Show mouse-over target when target is in healing range."] = true
L["Out of Range"] = true
L["Show mouse-over target when target is out of healing range."] = true
L["Unit is Player"] = true
L["Show mouse-over target when target is yourself."] = true
L["Unit is Pet"] = true
L["Show mouse-over target when target is pet."] = true

L["Icon"] = true
L["Icon Settings"] = true
L["Compass"] = true
L["Use compass icon that shows player direction."] = true
L["Compass Icon"] = true
L["Select Compass Icon"] = true

L["AnyButton"] = "Any Button"
L["LeftButton"] = "Left Button"
L["RightButton"] = "Right Button"
L["MiddleButton"] = "Middle Button"
L["Button4"] = "Button 4"
L["Button5"] = "Button 5"

L["never"] = "Never"
L["always"] = "Always"
L["alt"] = "Alt"
L["ctrl"] = "Ctrl"
L["shift"] = "Shift"
L["alt-ctrl"] = "Alt-Ctrl"
L["alt-shift"] = "Alt-Shift"
L["ctrl-shift"] = "Ctrl-Shift"
L["alt-ctrl-shift"] = "Alt-Ctrl-Shift"

L["arrow"] = "Arrow"
L["compass"] = "Compass"

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
L["no path"] = true
L["missing map data"] = true

L["Type '/ttp measure' and then move 20 yards"] = true 
L["No map coordinates present for this instance! Aborting measurement."] = true
L["No reference point set. Please retry measurement."] = true
L["No range calculation. You have to move first!"] = true
L["Map dimensions stored for %s[%i]: x, y = %f, %f"] = true

