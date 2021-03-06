#!/bin/bash
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
echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
sudo -v
spin &
SPIN_PID=$!
trap "kill -9 $SPIN_PID" `seq 0 15`
dockutil="/usr/local/bin/dockutil"
$brew install dockutil ;
echo "REMOVING DOCK ICONS..."; sleep 1;
eval killall cfprefsd;
sudo $dockutil --remove all; sleep 1;
echo "ADDING DOCK ICONS..."; sleep 1;
x="defaults write com.apple.dock persistent-apps -array-add "
y='"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'
z='</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
f="$x"$y
apps=("Google Chrome.app" "Safari.app" "Firefox.app" "Messages.app" "Slack.app"
"Microsoft Outlook.app"  "Microsoft Word.app" "Microsoft Excel.app"
"System Preferences.app" "zoom.us.app")
for app in "${apps[@]}"
do
    eval $f\$app$z;
done
echo "DOCK ICON REORGANIZATION COMPLETE...";
eval killall Dock; sleep 1;
eval clear;
kill -9 $SPIN_PID;
exit 0
