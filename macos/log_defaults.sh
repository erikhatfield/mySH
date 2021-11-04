#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until sh(es) has finished
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
com.apple.Safari
# Output defaults to filename with date and time designation
FILENAME_FOR_DEFAULTS='read_'$(date +"%m%d%y")'_'$(date +'%H%M')'.txt'
defaults read > $home_path/Dev/defaults/$FILENAME_FOR_DEFAULTS
# remove previous txt (if it exists)
rm -rf $home_path/Dev/defaults/previous.txt
# save new previous (if compare exists)
mv $home_path/Dev/defaults/compare.txt $home_path/Dev/defaults/previous.txt
# write new compare.txt for git/diff
defaults read > $home_path/Dev/defaults/compare.txt

echo "defaults logged @ $home_path/Dev/defaults/$FILENAME_FOR_DEFAULTS"
echo
echo "use## diff --side-by-side --suppress-common-lines $home_path/Dev/defaults/previous.txt $home_path/Dev/defaults/compare.txt"
echo
echo "Comparing: "
#diff -Iy $home_path/Dev/defaults/previous.txt $home_path/Dev/defaults/compare.txt
diff --side-by-side --suppress-common-lines $home_path/Dev/defaults/previous.txt $home_path/Dev/defaults/compare.txt
sleep 4
echo

# do the same for com.apple.Safari
# remove previous txts (if they exist)
rm -rf $home_path/Dev/defaults/safari_previous.txt
# save new previous (if safari_current exists)
mv $home_path/Dev/defaults/safari_current.txt $home_path/Dev/defaults/safari_previous.txt
# write new safari_current.txt for git/diff
defaults read com.apple.Safari > $home_path/Dev/defaults/safari_current.txt
# diff
echo 'for safari diff use: '
echo 'diff --side-by-side --suppress-common-lines '$home_path'/Dev/defaults/safari_previous.txt '$home_path'/Dev/defaults/safari_current.txt'

#exit
