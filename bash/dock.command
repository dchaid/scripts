#!/bin/bash

#Dock modifier

#*****************************************************************************************************************************
#functions
#*****************************************************************************************************************************
#cursor spin
spin()
{
  spinner="/|\\—/|\\—"
  while :
  do
    for i in `seq 0 7`
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep .06
    done
  done
}

#*****************************************************************************************************************************
#script
#*****************************************************************************************************************************

echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
sudo -v

# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap "kill -9 $SPIN_PID" `seq 0 15`
$brew install dockutil ;
echo "REMOVING DOCK ICONS..."; sleep 1;
eval killall cfprefsd;
sudo /usr/local/bin/dockutil --remove all; sleep 1;

#add items to dock
echo "ADDING DOCK ICONS..."; sleep 1;
x="defaults write com.apple.dock persistent-apps -array-add "
y='"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'
z='</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
f="$x"$y

#app list array -- freely add more in double-quotes or rearrange
apps=(
    "Google Chrome.app"
    "Safari.app"
    "Firefox.app"
    "Messages.app"
    "Slack.app"
    "Microsoft Outlook.app"
    "Microsoft Word.app"
    "Microsoft Excel.app"
    "App Store.app"
    "System Preferences.app"
    "zoom.us.app"
)

for app in "${apps[@]}"
do
    eval $f\$app$z;
done

echo "DOCK ICON REORGANIZATION COMPLETE...";
eval killall Dock; sleep 1;
eval clear;

#kill spinner
kill -9 $SPIN_PID;

exit 0
