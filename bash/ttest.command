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
eval killall cfprefsd; $sleep 1;
echo "ADDING DOCK ICONS..."; $sleep 1;
apps=("Google Chrome.app" "Safari.app" "Firefox.app" "Messages.app" "Slack.app" 
"Microsoft Outlook.app"  "Microsoft Word.app" "Microsoft Excel.app" 
"System Preferences.app" "zoom.us.app")
for app in "${apps[@]}"
do
    eval "$x"\$app$y;
done
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
