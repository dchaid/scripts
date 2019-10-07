#!/bin/bash
#*************************************************************************************************
#---Created by: David Chaid - KDInfotech :: For — Lyell — MacBook Provisioning
#---Creation date: Aug. 21, 2019
#---Last Modified: October 4, 2019
#---Description: Adds Lyell admin account, installs homebrew, MS Office,enables 
#---firewall, mods cursor rate, installs sophos, adds dock icons, runs macOS Software Update, 
#---adds meraki mdm. Automatically reboots. Installs inSync, Xerox Software drivers, 
#---Box Notes, MerakiPCC.

#---NOTE: External Drive MUST be labled as 'lyelldrive' with INSTALLS folder located at ROOT Level
#/lyelldrive/INSTALLS/ Contents:
#Box\ Notes.app, Box.pkg, InstallBoxTools.app, MerakiPCCAgent.pkg, Microsoft_Office.pkg, 
#Sophos\ Installer\ Components, SophosInstaller.app, XeroxPrintDriver.pkg, Zoom.pkg, inSync.mpkg, 
#meraki_sm_mdm.mobileconfig
#*************************************************************************************************
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

clear="eval clear"

#Resize terminal window
printf '\e[8;65;170t'

#user to enter sudo password to start
echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
sudo -v

# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap "kill -9 $SPIN_PID" `seq 0 15`
echo "STARTING INSTALLATION..."; sleep 1;

#silently check for macOS software updates — runs in background...
sudo softwareupdate -i -a >/dev/null 2>&1 &

#enable firewall
echo "ENABLING FIREWALL..."; sleep 1;
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1;

#set key repeat rate and cursor blink
echo "MODIFYING CURSOR REPEAT RATE...";
rate="eval defaults write -g"
$rate NSTextInsertionPointBlinkPeriodOn -float 200;
$rate NSTextInsertionPointBlinkPeriodOff -float 200;
$rate InitialKeyRepeat -int 15;
$rate KeyRepeat -int 2;

#hostname rename prompt
echo "PLEASE ENTER NEW HOSTNAME....LYMAC1XX..."; sleep 2;
function machinename() {
    osascript <<EOT
        tell application "Finder"
            activate
            set nameentry to text returned of (display dialog "Please Input New Hostname" default answer "" with icon 2)
            end tell
EOT
}
function renameComputer() {
    echo "NEW HOSTNAME: $ComputerName"; sleep 1;
    sudo scutil --set HostName "$ComputerName";
    sudo scutil --set LocalHostName "$ComputerName";
    sudo scutil --set ComputerName "$ComputerName";
    echo "RENAME SUCCESSFUL..."; sleep 1;
}
ComputerName=$(machinename)
renameComputer;

#opening all installers
echo 'Welcome2Lyell!' | pbcopy;
echo "OPENING ALL INSTALLERS NEEDED TO COMPLETE SETUP...";
echo "ADMIN PASSWORD COPIED TO CLIPBOARD...";
install="open /Volumes/lyelldrive/INSTALLS/"
installers=(
    "InstallBoxTools.app"
    "inSync.mpkg"
    "MerakiPCCAgent.pkg"
    "Microsoft_Office.pkg"
    "SophosInstaller.app"
    "XeroxPrintDriver.pkg"
    "mdm.mobileconfig"
)

for app in "${installers[@]}"
do
    eval $install\$app;
done
cp -a /Volumes/lyelldrive/INSTALLS/Box\ Notes.app /Applications/;

#admin account creation: checks last userID used and uses next available e.g. 501 -> 502
echo "CREATING ADMIN ACCOUNT..."; sleep 1;
LastID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1)
NextID=$((LastID + 1))
if [[ $(dscl . list /Users) =~ "lyelladmin" ]]; then
    echo "ADMIN ACCOUNT ALREADY CREATED...SKIPPING ACCOUNT CREATION..."; sleep 1;
else
    . /etc/rc.common
    sudo dscl . create /Users/lyelladmin
    sudo dscl . create /Users/lyelladmin RealName "Lyell Admin"
    sudo dscl . create /Users/lyelladmin hint ""
    sudo dscl . create /Users/lyelladmin picture "/Library/User Pictures/Nature/Earth.png"
    sudo dscl . passwd /Users/lyelladmin 2wsx^YHN
    sudo dscl . create /Users/lyelladmin UniqueID $NextID
    sudo dscl . create /Users/lyelladmin PrimaryGroupID 80
    sudo dscl . create /Users/lyelladmin UserShell /bin/bash
    sudo dscl . create /Users/lyelladmin NFSHomeDirectory /Users/lyelladmin
    sudo cp -R /System/Library/User\ Template/English.lproj /Users/lyelladmin
    sudo chown -R lyelladmin:staff /Users/lyelladmin
    echo "ADMIN ACCOUNT CREATED..."; sleep 2;
fi
$clear

#install homebrew (`if` statement in place to verify install in case first install fails)
echo "INSTALLING HOMEBREW..."; sleep 1;
yes '' | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
echo "VERIFYING HOMEBREW INSTALL...";
command -v brew
if [[ $? != 0 ]] ; then
    echo "ERROR...REINSTALLING HOMEBREW...";
    yes '' | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
else
    echo "HOMEBREW SUCCESSFULLY INSTALLED..."
    brew update;
fi
sleep 2;
sudo chown -R $(whoami) /usr/local/share/man/man8;
sudo chmod u+w /usr/local/share/man/man8;
$clear

#install homebrew
brew="/usr/local/bin/brew install"
echo "STARTING HOMEBREW INSTALLATIONS...";
$brew cask;
$brew dockutil;

#install brew casks
brew="/usr/local/bin/brew install cask"
$brew 1password;
$brew atom;
$brew box-drive;
$brew firefox;
$brew google-chrome;
$brew java;
$brew slack;
$brew zoomus;
$clear

#remove items from dock; requires dockutil to be installed at /usr/local/bin
echo "REMOVING DOCK ICONS...";
eval killall cfprefsd;
sudo /usr/local/bin/dockutil --remove all;

#add items to dock -- re-add dock util if not installed prior
$brew install dockutil ; 
echo "ADDING DOCK ICONS...";
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
echo "IF FAILED PLEASE RUN DOCK.COMMAND ON DESKTOP...";

eval killall Dock;
$clear

#launches external terminal to retry dock reorg
osascript -e 'tell app "Terminal"
    do script "bash ~/Desktop/Install/dock.command"
end tell'

#kill spinner
kill -9 $SPIN_PID;

#superuser reboot if required
sudo -v;
$clear
echo "INSTALL COMPLETE...REBOOTING AUTOMATICALLY IN 10 MINUTES..."; 
echo "ALLOW SOFTWARE UPDATE TO COMPLETE IF POSSIBLE...";sleep 800;
sudo reboot
exit 0
