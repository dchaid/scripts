#!/bin/bash
#***************************************************************************************************************
#---Creation date: October 16, 2019
#---Description: Adds Forsite admin account, installs homebrew
#***************************************************************************************************************
spin()
{
  spinner="/|\\—/|\\—"
  while :
  do
    for i in $(seq 0 7)
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      $sleep .06
    done
  done
}
#***************************************************************************************************************
#aliases
clear="eval /usr/bin/clear"
sleep="/bin/sleep"
rate="/usr/bin/defaults write -g"
scutil="sudo scutil --set"
admin="sudo dscl . create /Users/FLadmin"
brew="/usr/local/bin/brew install"
cask="/usr/local/bin/brew cask install"
dockutil="/usr/local/bin/dockutil"
browser="/usr/local/bin/defaultbrowser"
x="defaults write com.apple.dock persistent-apps -array-add "
y='"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'
z='</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
f="$x"$y
#***************************************************************************************************************
function buffer() {
    echo ".";
    echo ".";
    echo ".";
    echo ".";
}
#Resize terminal window
printf '\e[8;65;170t'
#user to enter sudo password to start
echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
buffer;
sudo -v
# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap 'kill -9 $SPIN_PID' $(seq 0 15)
#script start
echo "STARTING INSTALLATION..."; $sleep 1;
buffer;
#silently check for macOS software updates — runs in background...
sudo softwareupdate -i -a >/dev/null 2>&1 &
#enable firewall
echo "ENABLING FIREWALL..."; $sleep 1;
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1;
#set key repeat rate and cursor blink
echo "MODIFYING CURSOR REPEAT RATE..."; $sleep 1;
$rate NSTextInsertionPointBlinkPeriodOn -float 200;
$rate NSTextInsertionPointBlinkPeriodOff -float 200;
$rate InitialKeyRepeat -int 15;
$rate KeyRepeat -int 2;
#new hostname
echo "PLEASE ENTER NEW HOSTNAME....FL0XX..."; sleep 2;
function machinename() {
    osascript <<EOT
        tell application "Finder"
            activate
            set nameentry to text returned of (display dialog "hostname" default answer "FL0XX" with icon 2)
            end tell
EOT
}
function renameComputer() {
    echo "NEW HOSTNAME: $ComputerName"; sleep 1;
    $scutil HostName "$ComputerName";
    $scutil LocalHostName "$ComputerName";
    $scutil ComputerName "$ComputerName";
    echo "RENAME SUCCESSFUL..."; sleep 1;
}
ComputerName=$(machinename)
renameComputer;
#opening all installers
echo 'Welcome2ForesiteLabs!' | pbcopy;
echo "OPENING ALL INSTALLERS NEEDED TO COMPLETE SETUP..."; $sleep 1;
echo "ADMIN PASSWORD COPIED TO CLIPBOARD..."; $sleep 1;
install="open /Volumes/lyelldrive/foresite/INSTALLS/"
installers=("SophosInstaller.app")
for app in "${installers[@]}"
do
    eval "$install"\$app;
done
#admin account creation: checks last userID used and uses next available
echo "CREATING ADMIN ACCOUNT..."; $sleep 1;
LastID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1)
NextID=$((LastID + 1))
if [[ $(dscl . list /Users) =~ "FLadmin" ]]; then
    echo "ADMIN ACCOUNT ALREADY CREATED...SKIPPING ACCOUNT CREATION..."; $sleep 1;
else
    . /etc/rc.common
    $admin
    $admin RealName "FLAdmin"
    $admin hint ""
    $admin picture "/Library/User Pictures/Nature/Earth.png"
    $admin UniqueID $NextID
    $admin PrimaryGroupID 80
    $admin UserShell /bin/bash
    $admin NFSHomeDirectory /Users/FLadmin
    sudo dscl . passwd /Users/FLadmin 4siteLabs!
    sudo cp -R /System/Library/User\ Template/English.lproj /Users/FLadmin
    sudo chown -R FLadmin:staff /Users/FLadmin
    echo "ADMIN ACCOUNT CREATED..."; $sleep 2;
fi
$clear
#install homebrew
echo "INSTALLING HOMEBREW..."; $sleep 1;
yes '' | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
echo "VERIFYING HOMEBREW INSTALL...";
command -v brew
if [[ $? != 0 ]] ; then
    echo "ERROR...REINSTALLING HOMEBREW..."; $sleep 1;
    yes '' | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
else
    echo "HOMEBREW SUCCESSFULLY INSTALLED..."
    brew update;
fi
$sleep 3;
sudo mkdir -p /usr/local/share/man/man1;
sudo mkdir -p /usr/local/share/man/man8;
function man_chmod() {
    sudo chown -R "$(whoami)" /usr/local/share/man/; echo ".";
    sudo chown -R "$(whoami)" /usr/local/share/man/man1; echo ".";
    sudo chown -R "$(whoami)" /usr/local/share/man/man8; echo ".";
    sudo chmod 777 /usr/local/share/man/man1; echo ".";
    sudo chmod 777 /usr/local/share/man/man8; echo ".";
}
man_chmod;
$clear
#install homebrew
echo "STARTING HOMEBREW INSTALLATIONS..."; $sleep 3; man_chmod;
$brew cask; man_chmod;
$brew bash; man_chmod;
$brew dockutil; man_chmod;
$brew defaultbrowser; man_chmod;
#install brew casks
$cask atom;
$cask firefox;
$cask google-chrome;
$cask java;
$cask slack;
$clear
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
#add items to dock -- re-add dock util if not installed prior
#echo "ADDING DOCK ICONS..."; $sleep 3;
#apps=("Google Chrome.app" "Safari.app" "Firefox.app" "Messages.app" "Slack.app"
#"Microsoft Outlook.app"  "Microsoft Word.app" "Microsoft Excel.app"
#"System Preferences.app" "zoom.us.app")
#for app in "${apps[@]}"
#do
    #eval "$f"\$app$z;
#done
#echo "DOCK ICON REORGANIZATION COMPLETE..."; $sleep 3;
#echo "IF FAILED PLEASE RUN DOCK.COMMAND ON DESKTOP..."; $sleep 1;
#eval killall Dock; $sleep 3;
function lock_chmod(){
    sudo chmod 755 /usr/local/share/man/man1; echo "..";
    sudo chmod 755 /usr/local/share/man/man8; echo "..";
}
$clear
lock_chmod;
#launches external terminal to retry dock reorg
#osascript -e 'tell app "Terminal"
 #   do script "bash ~/Desktop/Install/dock.command"
#end tell'
#kill spinner
kill -9 $SPIN_PID;
#superuser reboot if required
sudo -v;
$clear
echo "SETTING DEFAULT BROWSER TO CHROME...";
$browser chrome
sudo -v
echo "INSTALL COMPLETE...REBOOTING AUTOMATICALLY IN 90 SECONDS..."; $sleep 2;
echo "ALLOW SOFTWARE UPDATE TO COMPLETE IF POSSIBLE..."; $sleep 88;
sudo reboot
exit 0
