#!/bin/bash
# ! /bin/zsh -- use this if using catalina (10.16)
#***************************************************************************************************************
#---Creation date: Aug. 21, 2019
#---Last Modified: October 9, 2019
#---Description: Adds Lyell admin account, installs homebrew, MS Office,enables 
#---firewall, mods cursor rate, installs sophos, adds dock icons, runs macOS 
#---Software Update, adds meraki mdm. Automatically reboots. Installs inSync, 
#---Xerox Software drivers, Box Notes, MerakiPCC.

#---NOTE: External Drive MUST be labled as 'lyelldrive' with INSTALLS folder 
#---located at ROOT Level...
#/lyelldrive/INSTALLS/ Contents:
#Box Notes.app, Box.pkg, InstallBoxTools.app, MerakiPCCAgent.pkg, 
#Microsoft_Office.pkg, Sophos\ Installer Components, SophosInstaller.app, 
#XeroxPrintDriver.pkg, Zoom.pkg, inSync.mpkg, meraki_sm_mdm.mobileconfig
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
admin="sudo dscl . create /Users/lyelladmin"
brew="/usr/local/bin/brew install"
cask="/usr/local/bin/brew cask install"
dockutil="/usr/local/bin/dockutil"
x="defaults write com.apple.dock persistent-apps -array-add "
y='"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'
z='</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
f="$x"$y
#***************************************************************************************************************
#Resize terminal window
printf '\e[8;65;170t'
#user to enter sudo password to start
echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
sudo -v
# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap 'kill -9 $SPIN_PID' $(seq 0 15)
#script start
echo "STARTING INSTALLATION..."; $sleep 1;
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
    $scutil HostName "$ComputerName";
    $scutil LocalHostName "$ComputerName";
    $scutil ComputerName "$ComputerName";
    echo "RENAME SUCCESSFUL..."; sleep 1;
}
ComputerName=$(machinename)
renameComputer;
#opening all installers
echo 'Welcome2Lyell!' | pbcopy;
echo "OPENING ALL INSTALLERS NEEDED TO COMPLETE SETUP..."; $sleep 1;
echo "ADMIN PASSWORD COPIED TO CLIPBOARD..."; $sleep 1;
install="open /Volumes/lyelldrive/INSTALLS/"
installers=("InstallBoxTools.app" "inSync.mpkg" "MerakiPCCAgent.pkg" 
"Microsoft_Office.pkg" "SophosInstaller.app" "XeroxPrintDriver.pkg" 
"mdm.mobileconfig")
for app in "${installers[@]}"
do
    eval "$install"\$app;
done
eval cp -a /Volumes/lyelldrive/INSTALLS/Box\ Notes.app /Applications/;
#admin account creation: checks last userID used and uses next available
echo "CREATING ADMIN ACCOUNT..."; $sleep 1;
LastID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1)
NextID=$((LastID + 1))
if [[ $(dscl . list /Users) =~ "lyelladmin" ]]; then
    echo "ADMIN ACCOUNT ALREADY CREATED...SKIPPING ACCOUNT CREATION..."; $sleep 1;
else
    . /etc/rc.common
    $admin
    $admin RealName "Lyell Admin"
    $admin hint ""
    $admin picture "/Library/User Pictures/Nature/Earth.png"
    $admin UniqueID $NextID
    $admin PrimaryGroupID 80
    $admin UserShell /bin/bash
    $admin NFSHomeDirectory /Users/lyelladmin
    sudo dscl . passwd /Users/lyelladmin 2wsx^YHN
    sudo cp -R /System/Library/User\ Template/English.lproj /Users/lyelladmin
    sudo chown -R lyelladmin:staff /Users/lyelladmin
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
$sleep 2;
sudo chown -R "$(whoami)" /usr/local/share/man/man8;
echo "CHANGING OWNERSHIP OF /usr/local/share/man/man8..."; $sleep 1;
sudo chmod u+w /usr/local/share/man/man8;
echo "CHANGING PERMISSIONS OF /usr/local/share/man/man8"; $sleep 1;
$clear
#install homebrew
echo "STARTING HOMEBREW INSTALLATIONS..."; $sleep 1;
$brew cask;
$brew dockutil;
#install brew casks
$cask 1password;
$cask atom;
$cask box-drive;
$cask firefox;
$cask google-chrome;
$cask java;
$cask slack;
$cask zoomus;
$clear
sudo chown -R "$(whoami)" /usr/local/share/man/man8;
echo "CHANGING OWNERSHIP OF /usr/local/share/man/man8..."; $sleep 1;
sudo chmod u+w /usr/local/share/man/man8;
echo "CHANGING PERMISSIONS OF /usr/local/share/man/man8"; $sleep 1;
#remove items from dock; requires dockutil to be installed at /usr/local/bin
echo "REMOVING DOCK ICONS..."; $sleep 1;
$brew install dockutil ; $sleep 3;
eval killall cfprefsd; $sleep 3;
sudo $dockutil --remove all; $sleep 5;
#add items to dock -- re-add dock util if not installed prior
echo "ADDING DOCK ICONS..."; $sleep 3;
apps=("Google Chrome.app" "Safari.app" "Firefox.app" "Messages.app" "Slack.app" 
"Microsoft Outlook.app"  "Microsoft Word.app" "Microsoft Excel.app" 
"System Preferences.app" "zoom.us.app")
for app in "${apps[@]}"
do
    eval "$f"\$app$z;
done
echo "DOCK ICON REORGANIZATION COMPLETE..."; $sleep 3;
echo "IF FAILED PLEASE RUN DOCK.COMMAND ON DESKTOP..."; $sleep 1;
eval killall Dock; $sleep 3;
$clear
#launches external terminal to retry dock reorg
#osascript -e 'tell app "Terminal"
 #   do script "bash ~/Desktop/Install/dock.command"
#end tell'
#kill spinner
kill -9 $SPIN_PID;
#superuser reboot if required
sudo -v;
$clear
echo "INSTALL COMPLETE...REBOOTING AUTOMATICALLY IN 10 MINUTES..."; $sleep 3;
echo "ALLOW SOFTWARE UPDATE TO COMPLETE IF POSSIBLE..."; $sleep 800;
sudo reboot
exit 0
