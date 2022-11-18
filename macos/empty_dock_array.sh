#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# SETUP username and paths and check                                          #
###############################################################################

#who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"
echo "who='$who_i_is'"
echo "home_path='$home_path'"
echo

###############################################################################
# some misc dock stuff  ...                                                   #
###############################################################################

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

###############################################################################
# User Prompt (clear dock?)                                                   #
###############################################################################

# (1) prompt user, and read command line argument
read -p "Empty Dock? " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* ) echo "yY entered."


	#####################################################
	#######################################################
	
	# Wipe all (default) app icons from the Dock
	defaults write com.apple.dock persistent-apps -array

	# Show only open applications in the Dock
	#defaults write com.apple.dock static-only -bool true
	
	#######################################################
	#####################################################
	
	sleep 1

      break;;
   [nN]* ) echo "k jk... " #exit;;
      	exit
	break;;
   * )     echo "Y or N input required, good sir."; break ;;
  esac
done

###############################################################################
# Kill affected applications                                                  #
###############################################################################


kill -SIGHUP SystemUIServer

echo "DOCK IS NOW EMPTY, SIR!"

for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
echo "dock emptied"

sleep 1

exit
