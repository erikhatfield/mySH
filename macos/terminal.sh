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
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4


# (1) prompt user, and read command line argument
read -p "run apple script terminal re skinner? " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* ) echo "yY entered."


#####################################################
#####################################################
## Use a modified theme by default in Terminal.app ##
## Load a dot terminal file as a custom theme      ##
## BEGIN loadModifiedTerminalTheme(){              ##
loadModifiedTerminalTheme()
{
  local THEME_NAME="$1"


osascript <<EOD

tell application "Terminal"

	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "$THEME_NAME"

	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window

	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '$home_path/Dots/.terminal/" & themeName & ".terminal'"

	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1

	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName

	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window

	repeat with windowID in allOpenedWindows

		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)

		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if

	end repeat

end tell

EOD

}
## END loadModifiedTerminalTheme(){                ##
#####################################################
#####################################################

# Set MagicHat as secondary theme (start up theme)
defaults write com.apple.terminal 'Startup Window Settings' -string "ActionHat";
loadModifiedTerminalTheme "ActionHat"

sleep 3

      break;;
   [nN]* ) echo "no name being set then... " #exit;;
      break;;
   * )     echo "Y or N input required, good sir."; break ;;
  esac
done





# Set Homebrew as default theme in terminal
defaults write com.apple.terminal 'Default Window Settings' -string "MagicHat";
loadModifiedTerminalTheme "MagicHat"
# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

###############################################################################
# Kill affected applications                                                  #
###############################################################################


kill -SIGHUP SystemUIServer

echo "Completing Terminal dot sh, now closing Terminal."

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

exit
