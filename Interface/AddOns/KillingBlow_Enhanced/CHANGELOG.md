## 1.14
- Avoid changing current map zone where possible. Map zone will still be changed when entering a new zone in Northrend as this is required to detect if the player is in Wintergrasp.
- Update PvP zone status, start/end sessions and reset kill count when the player enters a new zone (ZONE_CHANGED_NEW_AREA) instead of when they enter a new instance/continent (PLAYER_ENTERING_WORLD)

## 1.13
- Add support for World PvP zones in PVP_ONLY mode

## 1.12
- Add AddOn to AddOn Packager Proxy

## 1.11
- New version to fix Git/CurseForge packager screw-up

## 1.10
- Add KillingBlow_Death texture by OligoFriends

## 1.09
- Add KillingBlow_HordeSword texture by whitefreli

## 1.08
- Change player GUID check to reflect new GUID format
- Now searches for the string "Player-" instead of using bitwise operations

## 1.07
- Update to 6.0
- Convert KillingBlow.mp3 to Ogg format (WoW doesn't play custom MP3s any more)
- Bump TOC version
- Register ADDON_LOADED properly
- Save PvP killing blows to be exported to CSV

## 1.06
- Change overkill check to >0 instead of >=0
  - It seems a recent patch may have changed the overkill argument of COMBAT_LOG_EVENT_UNFILTERED to be 0 instead of -1 for non-killing blows

## 1.05
- Add new Horde/Alliance texture by OligoFriends

## 1.04
- Update TOC Interface tag to 5.4
- Update comment in CLEU to reflect PVP_ONLY change
- Change BG_ONLY option to PVP_ONLY (arenas + BGs)
- Add UnitFactionGroup to globals listing

## 1.03
- Possible fix for "bad argument #1 to 'band'"

## 1.02
- Add separate KB textures for each faction
  - Alliance uses existing texture (renamed to KillingBlow_Alliance.tga Horde uses the new KillingBlow_Horde.tga (by OligoFriends)
  - Move the texture:SetTexture call to the first firing of PLAYER_ENTERING_WORLD so UnitFactionGroup can return accurate results
- Rename frame to KillingBlow_EnhancedFrame (was KillingBlowImageFrame, from the AddOn's old name)

## 1.01
- Fix tools-used entry
- Record KBs for units controlled by the player
- Record KBs on _DAMAGE events with an overkill argument >= 0 in addition to PARTY_KILL
  - Suggested by Caellian because PARTY_KILL apparently doesn't fire correctly sometimes
- Add globals list and tools-used entry for mikk's FindGlobals script	
- Re-encode core.lua as UTF-8 without BOM so luac will work
- Add download info to README.md