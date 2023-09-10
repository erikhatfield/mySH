#!/bin/sh

# Close any open System Preferences panes, to prevent them from overwriting our changes
osascript -e 'tell application "System Preferences" to quit'

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# SETUP username and paths                                                    #
###############################################################################

#who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"

###############################################################################
# Log current defaults                                                        #
###############################################################################

# Make dir for output of defaults
mkdir -p $home_path/Dev/defaults

# Set permissions:
#chmod 665 $home_path/Dev
#chmod 665 $home_path/Dev/defaults

# Output defaults to filename with date and time designation
FILENAME_FOR_DEFAULTS='read_'$(date +"%m%d%y")'_'$(date +'%H%M')'.txt'
defaults read > $home_path/Dev/defaults/$FILENAME_FOR_DEFAULTS
# remove previous txt (if it exists)
rm -rf $home_path/Dev/defaults/previous.txt
# save new previous (if compare exists)
mv $home_path/Dev/defaults/compare.txt $home_path/Dev/defaults/previous.txt
# write new compare.txt for diff
defaults read > $home_path/Dev/defaults/compare.txt

echo "defaults logged @ $home_path/Dev/defaults/$FILENAME_FOR_DEFAULTS"
echo
echo "use## diff --side-by-side --suppress-common-lines $home_path/Dev/defaults/previous.txt $home_path/Dev/defaults/compare.txt"
echo
echo "Comparing (DIFF) "
sleep 2
echo "..."
sleep 2
#diff -Iy $home_path/Dev/defaults/previous.txt $home_path/Dev/defaults/compare.txt
diff --side-by-side --suppress-common-lines $home_path/Dev/defaults/previous.txt $home_path/Dev/defaults/compare.txt
sleep 3
