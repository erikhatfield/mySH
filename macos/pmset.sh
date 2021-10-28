#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

############################################################################
# SETUP username and paths                                                 #
############################################################################

#who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"

############################################################################
# PMSET                                                                    #
# % pmset -g #get current settings                                         #
############################################################################

#displaysleep - display sleep timer; value in minutes, or 0 to disable
sudo pmset -a displaysleep 360

#disksleep - disk spindown timer; value in minutes, or 0 to disablelocal
sudo pmset -a disksleep 180

#sleep - system sleep timer (value in minutes, or 0 to disable)
sudo pmset -a sleep 0

#womp - wake on ethernet magic packet (value = 0/1). Same as "Wake for network access" in the Energy Saver preferences.
sudo pmset -a womp 0

#ring - wake on modem ring (value = 0/1)

#powernap - enable/disable Power Nap on supported machines (value = 0/1)
sudo pmset -a powernap 0

#proximitywake - On supported systems, this option controls system wake from sleep based on proximity of devices using same iCloud id. (value = 0/1)
#autorestart - automatic restart on power loss (value = 0/1)
#lidwake - wake the machine when the laptop lid (or clamshell) is opened (value = 0/1)
#acwake - wake the machine when power source (AC/battery) is changed (value = 0/1)
#lessbright - slightly turn down display brightness when switching to this power source (value = 0/1)
#halfdim - display sleep will use an intermediate half-brightness state between full brightness and fully off  (value = 0/1)
sudo pmset -a halfdim 1

#sms - use Sudden Motion Sensor to park disk heads on sudden changes in G force (value = 0/1)

#To disable hibernation images completely, ensure hibernatemode standby and autopoweroff are all set to 0.
#hibernatemode - change hibernation mode. Please use caution. (value = integer)
sudo pmset -a hibernatemode 0
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0

#hibernatefile - change hibernation image file location. Image may only be located on the root volume. Please use caution. (value = path)
#ttyskeepawake - prevent idle system sleep when any tty (e.g. remote login session) is 'active'. A tty is 'inactive' only when its idle time exceeds the system sleep timer. (value = 0/1)
#networkoversleep - this setting affects how OS X networking presents shared network services during system sleep. This setting is not used by all platforms; changing its value is unsupported.
#destroyfvkeyonstandby - Destroy File Vault Key when going to standby mode. By default File vault keys are retained even when system goes to standby. If the keys are destroyed, user will be prompted to enter the password while coming out of standby mode.(value: 1 - Destroy, 0 - Retain)


# not in manual...
# Set standby delay to 11 hours (default is 1 hour)
sudo pmset -a standbydelay 67000

#for laptop
# disable sleep for -c charger
###sudo pmset -c sleep 0
# set sleep for -b battery to 11 minutes
###sudo pmset -b sleep 11

#set autopoweroffdelay delay (default is 28800)
#sudo pmset -a autopoweroffdelay 77777


# enable Destroy File Vault Key when going to standby mode.
#######sudo pmset -a destroyfvkeyonstandby 1



# Disable Automatic sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null


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
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
