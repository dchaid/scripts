#!/bin/bash
#aliases
clear="eval /usr/bin/clear"
sleep="/bin/sleep"
rate="/usr/bin/defaults write -g"
scutil="sudo scutil --set"
admin="sudo dscl . create /Users/lyelladmin"
brew="brew install"
cask="/usr/local/bin/brew cask install"
dockutil="/usr/local/bin/dockutil"
browser="/usr/local/bin/defaultbrowser"
x="sudo $dockutil --add /Applications/"
y="--no-restart"

#remove items from dock; requires dockutil to be installed at /usr/local/bin
echo "REMOVING DOCK ICONS..."; $sleep 1;
eval killall cfprefsd; $sleep 3;
sudo $dockutil --remove all --no-restart; $sleep 1;
sudo $dockutil --add /Applications/Google\ Chrome.app --no-restart;
sudo $dockutil --add /Applications/Safari.app --no-restart;
sudo $dockutil --add /Applications/Firefox.app --no-restart;
sudo $dockutil --add /Applications/Messages.app --no-restart;
sudo $dockutil --add /Applications/Slack.app --no-restart;
sudo $dockutil --add /Applications/Microsoft\ Outlook.app --no-restart;
sudo $dockutil --add /Applications/Microsoft\ Word.app --no-restart;
sudo $dockutil --add /Applications/Microsoft\ Excel.app --no-restart;
sudo $dockutil --add /Applications/System\ Preferences.app --no-restart;
sudo $dockutil --add /Applications/zoom.us.app --no-restart;
killall Dock;


add items to dock -- re-add dock util if not installed prior
echo "ADDING DOCK ICONS..."; $sleep 3;
apps=("Google Chrome.app" "Safari.app" "Firefox.app" "Messages.app" "Slack.app" 
"Microsoft Outlook.app"  "Microsoft Word.app" "Microsoft Excel.app" 
"System Preferences.app" "zoom.us.app")
for app in "${apps[@]}"
do
    eval "$x"\$app$y;
done
