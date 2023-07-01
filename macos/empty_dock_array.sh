#!/bin/sh

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

#what is -SIGHUP...?
#kill -SIGHUP SystemUIServer
kill SystemUIServer

echo "DOCK IS NOW EMPTYING, SIR!"

for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
echo "dock emptied"

sleep 1

#add launchpad to dock
open /System/Applications/
echo "hit enter when LaunchPad added to dock"
read waitforenter

exit
