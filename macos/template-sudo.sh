#!/bin/sh

# Close any open System Preferences panes, to prevent them from overwriting our changes
osascript -e 'tell application "System Preferences" to quit'

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# SETUP username and paths and check                                          #
###############################################################################
#store username in variable for dynamicness. $id -un <=> $whoami
whoamilol="$(id -un)"

#who am i | awk '{print $1}' #works with sudo
wh0is=$(who am i | awk '{print $1}')
home_path="$HOME"

# confirm correct
read -p "whoamilol= '$whoamilol' and who='$wh0is', and home_path='$home_path', enter to continue, ctrl-c to exit." wait4answer

###############################################################################
# SANDBOX                                                                     #
###############################################################################



###############################################################################
# SANDBOX                                                                     #
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

kill -SIGHUP SystemUIServer

echo "Done."

exit
