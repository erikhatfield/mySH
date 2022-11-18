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
########
#########
##############
#########################
##################################
############################################################################
# User Prompt		                                                   #
############################################################################
# (1) prompt user, and read command line argument
read -p "Would you like me to ... ? " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* ) echo "yY entered. Installing Screensavers, sir."


	#####################################################
	#######################################################
	
	# UPON USER'S AFFIRMATIVE # Install screensaver from path

        ### hdiutil mount it        
	### open all/any *.saver file(s) in mounted dmg
        hdiutil mount /Volumes/D0TS/latest/dmgs/screensavers/281-Euphoria.dmg
	the_saver_mounted_path="/Volumes/Euphoria 10.5"
	cd $the_saver_mounted_path
	# cp/install saver
	cp -a *.saver ~/Library/Screen\ Savers 
    	#Manually install *saver's
        cd ~/Library/Screen\ Savers && open *.saver

	### unmount coresponding dmg
    	hdiutil unmount $the_saver_mounted_path

	###end for loop
	
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



#################
#########################
#########################################
### dump
# Require password 11 minutes after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 11





###################################################################################
# 3.1.10			                                                  #
###################################################################################

# 


###################################################################################
# 3.1.18                                                                          #
###################################################################################

#


###################################################################################
# 3.1.20                                                                          #
###################################################################################

#


###################################################################################
# 3.2.1	                                                                          #
###################################################################################

#


###################################################################################
# 3.2.2	                                                                          #
###################################################################################


#



###################################################################################
# 3.7.3	                                                                          #
###################################################################################

#



###################################################################################
# 3.8.3	                                                                          #
###################################################################################

#


###################################################################################
# 3.8.6	                                                                          #
###################################################################################

#


###################################################################################
# 3.8.8	                                                                          #
###################################################################################

#


###############################################################################
# Kill affected applications                                                  #
###############################################################################


kill -SIGHUP SystemUIServer

echo "DOCK IS NOW EMPTY, SIR!"

for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
echo "NIST SP 800-171 macos routine complete, sir"

sleep 1

exit
