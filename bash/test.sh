#!/bin/bash
#add items to dock
x="defaults write com.apple.dock persistent-apps -array-add "
y='"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'
z='</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
f="$x"$y

apps=(
    Google\ Chrome.app
    Safari.app 
    Firefox.app 
    Messages.app 
    Slack.app 
    Microsoft\ Outlook.app
    Microsoft\ Word.app
    Microsoft\ Excel.app
    App\ Store.app
    System\ Preferences.app
    zoom.us.app
)
for app in "${apps[@]}"
do
    eval $f\$app$z;
done
echo "DOCK ICON REORGANIZATION COMPLETE..."
killall Dock; sleep 1;

#eval clear;

exit 0
