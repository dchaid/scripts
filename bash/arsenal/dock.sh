#!/bin/bash


#--aliases
dockutil="/usr/local/bin/dockutil"
x="sudo $dockutil --add /Applications/"
y="--no-restart"
sleep="/bin/sleep"

#--script
sudo -v
#remove items from dock; requires dockutil to be installed at /usr/local/bin
echo "REMOVING DOCK ICONS..."; $sleep 1;
eval killall cfprefsd; $sleep 1;
sudo $dockutil --remove all --no-restart; $sleep 1;
echo "ADDING DOCK ICONS..."; $sleep 1;
apps=("Google\ Chrome.app" "Safari.app" "Firefox.app" "Slack.app" "zoom.us.app")
for app in "${apps[@]}"
do
    eval $x$app $y;
done
killall Dock;

exit 0
