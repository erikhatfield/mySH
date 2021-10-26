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

# Output defaults to filename with date and time designation
FILENAME_FOR_DEFAULTS='read_'$(date +"%m%d%y")'_'$(date +'%H%M')'.txt'
defaults read > $home_path/Dev/defaults/$FILENAME_FOR_DEFAULTS
# Overwrite for git/diff
##defaults read > ~/Dev/defaults/compare.txt
defaults read > $home_path/Dev/defaults/compare.txt

echo "defaults logged @ $home_path/Dev/defaults/$FILENAME_FOR_DEFAULTS"

#exit