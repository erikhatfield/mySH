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
# Basics                                                                      #
###############################################################################

# Set standby delay to 11 hours (default is 1 hour)
sudo pmset -a standbydelay 34000

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Set clock to 24 hour format
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm'
defaults write NSGlobalDomain AppleICUForce24HourTime -int 1

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


#defaults read com.apple.systemuiserver 
#defaults read com.apple.notificationcenterui   
#defaults write com.apple.TextInputMenuAgent "NSStatusItem Visible Item-0" -int 1
defaults write com.apple.TextInputMenu visible -int 1


# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false


###############################################################################
# Visual Proofs                                                               #
###############################################################################

# Set highlight color to custom
defaults write NSGlobalDomain AppleHighlightColor -string " 0.345 0.555 0.777"


###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the desktop screenshot folder
mkdir ~/Desktop/Screenshøts
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshøts"

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

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library


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

# Set downloads path to "~/Downloads/safari"
mkdir ~/Downloads/safari
defaults write com.apple.Safari DownloadsPath -string "~/Downloads/safari"

# Prevent Safari from opening ‘safe’ files automatically after downloading
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
# Disable auto-correct
##defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# do not update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool false

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
###defaults write com.apple.terminal SecureKeyboardEntry -bool true

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
