#!/bin/sh

###################################################
# set wallpaper with apple script

change_wallpaper() {
	echo "change_wallpaper('$1')"
   	osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$1\""
}

change_wallpaper $1
