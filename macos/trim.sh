#!/bin/sh
##/usr/bin/env bash

###############################################################################
### Trim MACOS installation (after fresh install or updates )				###
### Useful for instances running on partitions < 64GB						###
###############################################################################

# work in progress

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until sh(es) has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# SMURF username, paths and stablish osx version                              #
###############################################################################

#who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"

system_profiler SPSoftwareDataType

sleep 1

osx_version=$( sw_vers -productVersion )
osx_version=$(echo "$osx_version" | awk -F"[.]*"  '{print $2}')

###############################################################################
# TRIM	                                                                      #
###############################################################################

if (( $osx_version <= 14 )); then
			# Mojave or earlier
			echo "MOJAVETRIMSKIS" && echo && sleep 2
			sudo rm -rf /Applications/News.app 
			sudo rm -rf /Applications/Siri.app 
			sudo rm -rf /Applications/Time\ Machine.app 
			sudo rm -rf /Applications/Utilities/Migration\ Assistant.app 
			sudo rm -rf /Applications/Utilities/Boot\ Camp\ Assistant.app 
			#sudo rm -rf 
			#sudo rm -rf 
			#sudo rm -rf 
			#sudo rm -rf 
else
			# Catalina or later
			sudo mount -uw /

			#altformat:
			#sudo rm -rf /Volumes/yourhdnamesir/System/Applications/Time\ Machine.app
			
			sudo rm -rf /System/Applications/Time\ Machine.app
			
			sudo rm -rf /System/Applications/News.app
			sudo rm -rf /System/Applications/TV.app
			sudo rm -rf $home_path/Movies/TV

			#sudo rm -rf /System/Applications/TextEdit.app
			sudo rm -rf /System/Applications/Utilities/Boot\ Camp\ Assistant.app
			sudo rm -rf /System/Applications/Utilities/Migration\ Assistant.app
fi


###############################################################################
# Complete                                                                    #
###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done

#kill -SIGHUP SystemUIServer

echo "Trim SH Complete."

exit
