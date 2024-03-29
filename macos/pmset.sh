#!/bin/sh

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

echo "who="$who_i_is" and home_path="$home_path

############################################################################
# PMSET                                                                    #
# % pmset -g #get current settings                                         #
############################################################################

#displaysleep - display sleep timer; value in minutes, or 0 to disable
sudo pmset -a displaysleep 15

#disksleep - disk spindown timer; value in minutes, or 0 to disablelocal
sudo pmset -a disksleep 0

#sleep - system sleep timer (value in minutes, or 0 to disable)
sudo pmset -a sleep 0

#ring - wake on modem ring (value = 0/1)

#powernap - enable/disable Power Nap on supported machines (value = 0/1)
sudo pmset -a powernap 0

#proximitywake - On supported systems, this option controls system wake from sleep based on proximity of devices using same iCloud id. (value = 0/1)
sudo pmset -a proximitywake 0

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


# Set standby delay to 11 hours (default is 1 hour)
#sudo pmset -a standbydelay 67000

#for laptop
# disable sleep for -c charger
###sudo pmset -c sleep 0
# set sleep for -b battery to 11 minutes
###sudo pmset -b sleep 11

#set autopoweroffdelay delay (default is 28800)
#sudo pmset -a autopoweroffdelay 77777


# enable Destroy File Vault Key when going to standby mode.
sudo pmset -a destroyfvkeyonstandby 1



# Disable Automatic sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

if [ $1 = "elhbp" ]; then
	echo "PMset: Portable (elhbp)"
	#autorestart - automatic restart on power loss (value = 0/1)
	#lidwake - wake the machine when the laptop lid (or clamshell) is opened (value = 0/1)
	#acwake - wake the machine when power source (AC/battery) is changed (value = 0/1)
	#lessbright - slightly turn down display brightness when switching to this power source (value = 0/1)
	#halfdim - display sleep will use an intermediate half-brightness state between full brightness and fully off  (value = 0/1)
	sudo pmset -a halfdim 1
	sudo pmset -a acwake 0
	sudo pmset -a lidwake 0
	sudo pmset -a autorestart 0 # - automatic restart on power loss (value = 0/1)
	sudo pmset -a lessbright 0 #- slightly turn down display brightness when switching to this power source (value = 0/1)
	#sms - use Sudden Motion Sensor to park disk heads on sudden changes in G force (value = 0/1)

	#womp - wake on ethernet magic packet (value = 0/1). Same as "Wake for network access" in the Energy Saver preferences.
	sudo pmset -a womp 0

else
	echo "PMset: Cylinder"
	echo
	#womp - wake on ethernet magic packet (value = 0/1). Same as "Wake for network access" in the Energy Saver preferences.
	#sudo pmset -a womp 1
	sudo pmset -a womp 0
	sudo pmset -a autorestart 1
fi

#nist screen lock stuff?
#nist macos sec?
##############################################################################
# Screensaver//NIST                                                          #
##############################################################################

#doesnt work since High Sierra?
##defaults write com.apple.screensaver askForPassword -int 1
##defaults write com.apple.screensaver askForPasswordDelay -int 0
##defaults -currentHost write com.apple.screensaver idleTime 900
##defaults write com.apple.screensaver idleTime -int 900

#works
##sysadminctl -screenLock immediate -password -

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
echo "PMset [[$1]] Fin."
