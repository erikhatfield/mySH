#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until sh(es) has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Date, time, and formats                 		                      #
###############################################################################

# Set clock to 24 hour format
defaults write NSGlobalDomain AppleICUForce24HourTime -int 1

# Set date formate to EEE MMM d H:mm
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm:ss'

# Flash the : in the menu bar
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# date string formats
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "MMddyy"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "2" "MMMdd yy"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "3" "MMMM dd y"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "4" "EEEE, MMMM dd y"

# 24-hour time
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "1" "HHmm"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "2" "HH:mm Z"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "3" "HH:mm:ss zZ"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "4" "HH:mm:ss vvvv ZZZZ"

# also set this for the system preference
defaults write com.apple.systempreferences AppleIntlCustomFormat -dict-add "AppleIntlCustomICUDictionary" "{'AppleICUDateFormatStrings'={'1'='MMddyy';'2'='MMMdd yy';'3'='MMMM dd y';'4'='EEEE, MMMM dd y';};'AppleICUTimeFormatStrings'={'1'='HHmm';'2'='HH:mm Z';'3'='HH:mm:ss zZ';'4'='HH:mm:ss vvvv ZZZZ';};}"

###############################################################################
# Kill affected applications                                                  #
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
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done

#################################################################################
# read out defaults																#
#################################################################################
echo && echo
defaults read com.apple.menuextra.clock
echo && echo
defaults read NSGlobalDomain AppleICUDateFormatStrings
echo && echo
defaults read NSGlobalDomain AppleICUTimeFormatStrings
echo && echo

echo "Date Time Formats conclusion." && echo

echo ":::FINISHING::: $0" && echo
exit