TomTomPing, a World of Warcraft® user interface addon.
Copyright© 2010 Bernhard Voigt, aka tritium - All rights reserved.
License is given to copy, distribute and to make derivative works.

TomTomPing - Addon that uses TomTom's Crazy Arrow to display the direction and distance of pings and party members.
 
Features -

	* Ping tracking: listens to Minimap pings
	* Waypoint tracking: set and unset waypoints to track
	* Player tracking: track any party or raid member
	* Manual selection of tracking target
	* Auto track Target, Focus, Mouseover, Mouseover-click (Works with addons like Healbot and Grid)
	* Stick/Unstick current Arrow target: make current arrow target sticky; overrides selected tracking mechanism
	* Color coded facing direction: green towards the target, red when running away from it
	* Arrival check: direction arrow changes to down arrow on user defined range from destination
	* Heal range check: recolors arrow when out of healing range
	* Estimated time of arrival
	* Broker support
	* Compass as Broker text
	* Semi-automatic map measurement for instance maps with unknown dimensions

Install -

	Copy the TomTomPing folder to your Interface\AddOns directory.
	You need to have TomTom installed. Only working with "TomTom-r216" or newer.
		
Commands - 

	/tomtomping arg
	/ttp arg

	With arg:
	target - use current target as arrow target
	stick - make current arrow target sticky / unstick again
	clear - release the crazy arrow
	ping - ping on self
	waypoint - set waypoint on self
	wpclear - clear waypoint
	measure - init map size measurement (Move at least 20 yards!)
	menu - display options menu
	version - display the version information
	help - display this help
	
Usage -

	Trigger commands via slash command, keybindings or mouse-clicks on Broker display or Minimap button.
	The option menu lets you configure the addon behaviour in detail.
	
	Using the "/ttp target" command will automatically stick the selected target as well if the auto tracking type is "Mouseover" or "Waypoint". This is to prevent the refresh routine to immediately overwrite the selected target again. For other tracking types the selected target stays non-sticky. 

	TomTomPing won't work in instances pre-WotLK since those don't support coordinate infos. That's why they don't have maps too - but this is finally going to change in Cataclysm.
	
Thanks -

	This addon was inspired by the outdated PingDir.
	Thanks Cladhaire for making TomTom usable by other addons.
	Thanks Esamynn for making Astrolabe.
	Thanks Knapster (alias Baaras) for the original developent of TomTomPing.
