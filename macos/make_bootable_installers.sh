#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until sh(es) has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#################################################################################
# Create Bootable Installers for macOS											#
#################################################################################

# Assumes the macOS installer apps are in the /Applications folder
# And for now, uses MyVolume for Ventura Installer, and MyVol for Sonoma Installer
#
# NOTE: GUID Partition Map ← for bootable installer drive formattings

# Ventura
if [ -d "/Applications/Install macOS Ventura.app" ]; then
	## if /Volumes/MyVolume exists, proceed
	if [ -d "/Volumes/MyVolume" ]; then
		#################################################
		# Create Bootable Installer for macOS Ventura	#
		#################################################
		echo "Creating bootable installer for macOS Ventura..."
		sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --nointeraction

		# If the USB ever refuses to show up in the boot picker, just re-bless it:
		#sudo bless --folder /Volumes/Install\ macOS\ Ventura/System/Library/CoreServices --bootefi
		
		# Blessing info:
		bless --info /Volumes/Install\ macOS\ Ventura

		# Disable spotlight indexing on the volume
		sudo mdutil -i off /Volumes/Install\ macOS\ Ventura
		sudo mdutil -d /Volumes/Install\ macOS\ Ventura

		# Remove indexing directory and files 
		sudo rm -rf /Volumes/Install\ macOS\ Ventura/.Spotlight-V100
		sudo mdutil -X /Volumes/Install\ macOS\ Ventura

		# Make it a brick, errr wait, I mean, make it readonly
		sudo diskutil unmountDisk /Volumes/Install\ macOS\ Ventura
		sudo chflags -R uchg,schg /Volumes/Install\ macOS\ Ventura

		echo "Finished creating macOS Ventura bootable installer."
		#################################################
		#################################################
	else
		echo "/Volumes/MyVolume does not exist."
	fi
else
	echo "macOS Ventura installer not found in /Applications."
fi

# Sonoma
if [ -d "/Applications/Install macOS Sonoma.app" ]; then
	## if /Volumes/MyVol exists, proceed
	if [ -d "/Volumes/MyVol" ]; then
		#################################################
		# Create Bootable Installer for macOS Sonoma	#
		#################################################
		echo "Creating bootable installer for macOS Sonoma..."
		sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVol --nointeraction

		# If the USB ever refuses to show up in the boot picker, just re-bless it:
		#sudo bless --folder /Volumes/Install\ macOS\ Sonoma/System/Library/CoreServices --bootefi

		# Blessing info:
		bless --info /Volumes/Install\ macOS\ Sonoma

		# Disable spotlight indexing on the volume
		sudo mdutil -i off /Volumes/Install\ macOS\ Sonoma
		sudo mdutil -d /Volumes/Install\ macOS\ Sonoma

		# Remove indexing directory and files
		sudo rm -rf /Volumes/Install\ macOS\ Sonoma/.Spotlight-V100
		sudo mdutil -X /Volumes/Install\ macOS\ Sonoma

		# Make it readonly
		sudo diskutil unmountDisk /Volumes/Install\ macOS\ Sonoma
		sudo chflags -R uchg,schg /Volumes/Install\ macOS\ Sonoma

		echo "Finished creating macOS Sonoma bootable installer."
		#################################################
		#################################################

	else
		echo "/Volumes/MyVol does not exist."
	fi
else
	echo "macOS Sonoma installer not found in /Applications."
fi
