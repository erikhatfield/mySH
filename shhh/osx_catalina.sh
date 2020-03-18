#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overwriting our changes
osascript -e 'tell application "System Preferences" to quit'

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#store username in variable for dynamicness. $id -un <=> $whoami
whoamilol="$(id -un)"

###############################################################################
# Security                                                                    #
###############################################################################

## hosts (assumes you are within encryption of dots drive
sudo cp ~/.dotfiles/etc/hosts /etc/hosts


###############################################################################
# Set Computer Name                                                           #
###############################################################################
# (1) prompt user, and read command line argument
read -p "Set a computer name? " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* ) echo "Setting... waht to set..."

      # Ask the user for their name
      echo Please type in a string without spaces to be your computer name
      read varname
      echo Your computer will use the name $varname

			# Set computer name (as done via System Preferences → Sharing)
			sudo scutil --set ComputerName $varname
			sudo scutil --set HostName $varname".local"
			sudo scutil --set LocalHostName $varname
			sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $varname

      break;;

   [nN]* ) echo "no name being set then... " #exit;;
      break;;

   * )     echo "Y or N input required, good sir."; break ;;
  esac
done

###############################################################################
# Basics                                                                      #
###############################################################################

# Set standby delay to 11 hours (default is 1 hour)
sudo pmset -a standbydelay 34000

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Power button behavior
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool NO

# Set clock to 24 hour format
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm'
defaults write NSGlobalDomain AppleICUForce24HourTime -int 1

# Flash the : in the menu bar
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# date string formats
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "MMddyy"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "2" "MMMdd yy"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "3" "MMMM dd y"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "4" "EEEE, MMMM dd y"

# 24-hour time is the only way to roll
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "1" "HHmm"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "2" "HH:mm Z"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "3" "HH:mm:ss zZ"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "4" "HH:mm:ss vvvv ZZZZ"

# also set this for the system preference
defaults write com.apple.systempreferences AppleIntlCustomFormat -dict-add "AppleIntlCustomICUDictionary" "{'AppleICUDateFormatStrings'={'1'='MMddyy';'2'='MMMdd yy';'3'='MMMM dd y';'4'='EEEE, MMMM dd y';};'AppleICUTimeFormatStrings'={'1'='HHmm';'2'='HH:mm Z';'3'='HH:mm:ss zZ';'4'='HH:mm:ss vvvv ZZZZ';};}"

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Show Battery Percentage
defaults write com.apple.menuextra.battery ShowPercent -bool true

#defaults read com.apple.systemuiserver
#defaults read com.apple.notificationcenterui
#defaults write com.apple.TextInputMenuAgent "NSStatusItem Visible Item-0" -int 1
###defaults write com.apple.TextInputMenu visible -int 1
# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true


# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto period insert
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

###############################################################################
# Visual Proofs                                                               #
###############################################################################

# Set highlight color to green?
defaults write NSGlobalDomain AppleHighlightColor -string "0.7777 0.8888 0.5555"

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

###############################################################################
# Screen                                                                      #
###############################################################################

# Disable auto-adjust brightness
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor.plist "Automatic Display Enabled" -bool false

# Save screenshots to the desktop screenshot folder
mkdir ~/Desktop/Screensh0ts
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screensh0ts"

# Save screenshots in JPG format (other options: BMP, GIF, PNG, PDF, TIFF)
defaults write com.apple.screencapture type -string "JPG"

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Change the spring loading delay for directories (default is 0.5)
defaults write NSGlobalDomain com.apple.springing.delay -float 0.25

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Don't use tabs in Finder
defaults write com.apple.finder AppleWindowTabbingMode -string "manual"

# Show the ~/Library folder
chflags nohidden ~/Library

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv', 'Nlsv'
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Allow text selection in QuickLook
defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable all actions when inserting disks
defaults write com.apple.digihub com.apple.digihub.blank.bd.appeared -dict-add action -int 1
defaults write com.apple.digihub com.apple.digihub.blank.cd.appeared -dict-add action -int 1
defaults write com.apple.digihub com.apple.digihub.blank.dvd.appeared -dict-add action -int 1
defaults write com.apple.digihub com.apple.digihub.cd.music.appeared -dict-add action -int 1
defaults write com.apple.digihub com.apple.digihub.dvcamera.IIDC.appeared -dict-add action -int 1
defaults write com.apple.digihub com.apple.digihub.dvcamera.IIDC.irisopened -dict-add action -int 1
defaults write com.apple.digihub com.apple.digihub.dvd.video.appeared -dict-add action -int 1

# Finally disable opening random Apple photo applications when plugging in devices
# https://twitter.com/stroughtonsmith/status/651854070496534528
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 34 pixels
defaults write com.apple.dock tilesize -int 34

#enable magnification
defaults write com.apple.dock magnification -bool true

#set magnification to 123 (max is 128)
defaults write com.apple.dock largesize -int 123;

#position dock on left
defaults write com.apple.dock orientation -string "left"

# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Set new tab/window behavior to 1 (empty page)
defaults write com.apple.Safari NewTabBehavior -int 1
defaults write com.apple.Safari NewWindowBehavior -int 1

# Set downloads path to "~/Downloads/safari" as default
mkdir ~/Downloads/safari
defaults write com.apple.Safari DownloadsPath -string "~/Downloads/safari"
# Then ask for specfic download local
defaults write com.apple.Safari AlwaysPromptForDownloadFolder -bool true

# Prevent Safari from opening files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Enable continuous spellchecking
##defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct within Safari
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# do not update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool false

# do not make network call from address bar
defaults write com.apple.Safari PreloadTopHit -bool false

# do not allow push notifications prompt
defaults write com.apple.Safari CanPromptForPushNotifications -bool false

# check for world leaks on all builds, prevents falling asleep at the wheel
defaults write com.apple.Safari WorldLeakCheckingPolicy -int 2

# set homepage to blank page
defaults write com.apple.Safari HomePage -string "about:blank"

# set Remove download list items to manual
defaults write com.apple.Safari DownloadsClearingPolicy -bool false

# set default selection for Clear History... menu item
defaults write com.apple.Safari ClearBrowsingDataLastIntervalUsed -string "all history"

# set default search engine to duckduckgo
defaults write com.apple.Safari SearchProviderIdentifier -string "com.duckduckgo"

# do not ref favs
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false

#was ist das --> DefaultBrowserPromptingState2 = 4;

#turn apple pay Off
#smart search field -> disable quick website search
###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Set Homebrew as default theme in terminal
defaults write com.apple.terminal 'Default Window Settings' -string "Homebrew";
defaults write com.apple.terminal 'Startup Window Settings' -string "Homebrew";

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal


###############################################################################
# Mac App Store                                                               #
###############################################################################

# Disable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false


# Don't Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 0
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 0

# Def don't Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 0

# Turn off app auto-update
defaults write com.apple.commerce AutoUpdate -bool false

# Don't allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool false

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Atom                                                                        #
###############################################################################

##if Atom doesn't exist already; then
if [ ! -d "/Applications/Atom.app" ]; then
	osascript -e 'display dialog "Adding Atom to /Applications" buttons {"I see"} default button 1'

	unzip ~/.dotfiles/dmgs/atom-mac.zip -d ~/.dotfiles/atomunzipped
	mv  ~/.dotfiles/atomunzipped/Atom.app  /Applications/Atom.app
	rm -rf ~/.dotfiles/atomunzipped

fi
##END if Atom

###############################################################################
# Install photobooth filters                                                  #
###############################################################################
# (1) prompt user, and read command line argument
read -p "Install extra Photobooth Filters (Y/N)? " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* ) echo "Installing Photobooth Filters."

      # Ask the user for their name
      # Consider dynamic OOP approach to cp'ing qtz files 030620~ELH

      # ls -a /System/Library/Compositions
      # Copy this list of files from /System to Squiggly/ (current user's directory)

      cp /System/Library/Compositions/Color\ Invert.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Exposure\ Adjust.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Kaleidescope.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Pointillize.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Twirl.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/ColorPencil.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Fall.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/LightTunnel.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/PopArt.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 1.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/ComicBook.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/False\ Color.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Line\ Overlay.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Posterize.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 2.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Compound\ Eye.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Film\ Stock.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Line\ Screen.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Push.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 3.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/ASCII\ Art.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Concert.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Fish.mov ~/Library/Compositions/
      cp /System/Library/Compositions/Lovestruck.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Rollercoaster.mov ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 4.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/BlackAndWhite.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Copy\ Machine.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Fish.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Mask.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Rollercoaster.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 5.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Blockhead.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Crystallize.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/FishEye.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Mirror.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Sepia.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 6.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Blue\ Print.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Cube.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Flip-Flop.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Mod.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Sharpen.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 7.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Blur.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Floor.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Monochrome.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Space\ Alien.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/User\ Backdrop\ 8.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Bug\ Out.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Defocus.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Frog.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Mosaic\ Flip.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Squeeze.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Wall.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Bulge.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Dent.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Gamma\ Adjust.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Motion\ Blur.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Stretch.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/XRay.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Chipmunk.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Dissolve.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Glow.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Moving\ Shapes.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Sunset.mov ~/Library/Compositions/
      cp /System/Library/Compositions/Yosemite.mov ~/Library/Compositions/
      cp /System/Library/Compositions/City\ Lights.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Dizzy.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Gradient.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Neon.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Sunset.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Yosemite.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/CloakingDevice.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Dot\ Screen.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Grid.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Nose\ Twirl.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Swing.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Zoom\ Blur.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Clouds.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Earthrise.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Hologram.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Pinch.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/ThermalCamera.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Zoom\ Dissolve.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Color\ Controls.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Eiffel\ Tower.mov ~/Library/Compositions/
      cp /System/Library/Compositions/Image\ Hose.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Pixellate.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Tracer.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Color\ Dots.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Eiffel\ Tower.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Image\ Resizer.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/PlasticCamera.qtz ~/Library/Compositions/
      cp /System/Library/Compositions/Travelator.qtz ~/Library/Compositions/


      # Search and replace the string 'PhotoBooth' with 'PhotoSpoof' in files in ~/Library/Compositions using perl
      cd ~/Library/Compositions
      perl -i -pe 's/PhotoBooth/PhotoSpoof/g' ./*


      break;;

   [nN]* ) echo "not installing photobooth filters." #exit;;
      break;;

   * )     echo "Y or N input required, good sir."; break ;;
  esac
done

###############################################################################
# Kill affected applications                                                  #
###############################################################################

# reset host file cache
sudo dscacheutil -flushcache

#restart apache
#sudo apachectl restart

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

kill -SIGHUP SystemUIServer

echo "Done. Note that some of these changes require a logout/restart to take effect."

hdiutil mount ~/.dotfiles/dmgs/ls4/LittleSnitch-4.4.3.dmg

exit
