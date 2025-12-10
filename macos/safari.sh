#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until sh(es) has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#################################################################################
# Echo current date stamp for some reason ?_?									#
#################################################################################

echo $(date +"%m%d%y")'_'$(date +'%H%M')'.w00t'

###############################################################################
# Safari DEFAULTS                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
##defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
##defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Set new tab/window behavior to 1 (empty page)
defaults write com.apple.Safari NewTabBehavior -int 1
defaults write com.apple.Safari NewWindowBehavior -int 1

# Set downloads path to "~/Downloads/safari"
mkdir -p ~/Downloads/safari
defaults write com.apple.Safari DownloadsPath -string "$HOME/Downloads/safari"
# ignore path and always ask where to save DLs
defaults write com.apple.Safari AlwaysPromptForDownloadFolder -bool true
defaults write com.apple.Safari.SandboxBroker AlwaysPromptForDownloadFolder -bool true
#defaults write com.apple.Safari.SandboxBroker DidMigrateDownloadFolderToSandbox -bool true
# ?

# Disable extensions
defaults write com.apple.Safari ExtensionsEnabled -bool false

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# disallow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool false

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
##defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Do not warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool false

# Disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari WebKitPreferences.javaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
#defaults write com.apple.Safari WebKitPreferences.javaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Disable fullscreen for webkit
defaults write com.apple.Safari WebKitPreferences.fullScreenEnabled -bool false

# observe
defaults write com.apple.Safari WebKitPreferences.aggressiveTileRetentionEnabled -bool false

# Disable telephone sniffing and hyperlinktoapp
defaults write com.apple.Safari WebKitPreferences.telephoneNumberDetectionIsEnabled -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# do not update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool false

# do not make network call from address bar
defaults write com.apple.Safari PreloadTopHit -bool false

# do not allow push notifications prompt
defaults write com.apple.Safari CanPromptForPushNotifications -bool false

# check for world leaks on all builds, prevents falling asleep at the wheel (1 vs 2?)
defaults write com.apple.Safari WorldLeakCheckingPolicy -int 1

# set Remove download list items to manual
defaults write com.apple.Safari DownloadsClearingPolicy -bool false

# set default selection for Clear History... menu item
defaults write com.apple.Safari ClearBrowsingDataLastIntervalUsed -string "all history"

# set default search engine to duckduckgo
defaults write com.apple.Safari SearchProviderIdentifier -string "com.duckduckgo"

# do not ref favs
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false

###############################################################################
# DUMP (organize me)
defaults write com.apple.Safari "WebKitPreferences.defaultTextEncodingName" -string "utf-8"
defaults write com.apple.Safari WebKitPreferences.applePayEnabled -bool false
defaults write com.apple.Safari WebKitPreferences.allowsPictureInPictureMediaPlayback -bool false
defaults write com.apple.Safari WebKitPreferences.allowsInlineMediaPlayback -bool false
#qoutes or nah? also what is this? 
defaults write com.apple.Safari "WebKitPreferences.aggressiveTileRetentionEnabled" -bool false
defaults write com.apple.Safari WebKitPreferences.aggressiveTileRetentionEnabled -bool false
defaults write com.apple.Safari ExtensionsEnabled -bool false
defaults write com.apple.Safari CommandClickMakesTabs -bool false
defaults write com.apple.Safari Command1Through9SwitchesTabs -bool false
defaults write com.apple.Safari "WebKitPreferences.javaScriptCanOpenWindowsAutomatically" -bool false
#defaults write com.apple.Safari WebKitPreferences.diagnosticLoggingEnabled -bool false
#defaults write com.apple.Safari WebKitPreferences.dnsPrefetchingEnabled -bool false 
defaults write com.apple.Safari WebKitPreferences.fullScreenEnabled -bool false
defaults write com.apple.Safari WebKitPreferences.invisibleMediaAutoplayNotPermitted -bool true
#defaults write com.apple.Safari WebKitPreferences.javaEnabled -bool false
#defaults write com.apple.Safari WebKitPreferences.hiddenPageDOMTimerThrottlingAutoIncreases -bool false
defaults write com.apple.Safari WebKitPreferences.javaScriptCanOpenWindowsAutomatically -bool false


#####################################################################
#???????????????????????????????????????????????????????????????????#
defaults write com.apple.Safari WorldLeakCheckingPolicy -int 1

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Safari" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done

############################################################
#diff --side-by-side --suppress-common-lines $HOME/Dev/defaults/safari/prev.txt $HOME/Dev/defaults/safari/latest.txt
###########################################################
#^^^ left over example of --side-by-side diff command ^^^#

echo && echo
defaults read com.apple.Safari
echo && sleep 1 && echo
echo && sleep 1 && echo


echo ":::FINISHING::: $0" && echo
exit
