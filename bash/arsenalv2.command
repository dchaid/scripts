#!/bin/bash
###############################################################################
#                                                                             #
###############################################################################
#Created by: David Chaid - KDInfotech
#Creation date: November 6, 2019
#Modified by: David Chaid
#Modified for: Arsenal
#Description: Connects to Arsenal, adds admin account, installs hombrew,enables firewall,
#mods cursor rate, adds dock icons, runs macOS Software Update, Automatically reboots.
###############################################################################
#                                                                             #
###############################################################################

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

###############################################################################
# Aliases                                                                     #
###############################################################################
admin="sudo dscl . create /Users/admin.arsenal"
brew="/usr/local/bin/brew install"
browser="/usr/local/bin/defaultbrowser"
cask="/usr/local/bin/brew cask install"
clear="eval /usr/bin/clear"
dockutil="/usr/local/bin/dockutil"
rate="/usr/bin/defaults write -g"
scutil="sudo scutil --set"
sleep="/bin/sleep"
spellcheck="defaults write com.apple.messageshelper.MessageController SOInputLineSettings"
x="sudo $dockutil --add /Applications/"
y="--no-restart"

###############################################################################
# Script                                                                      #
###############################################################################

#Resize terminal window
printf '\e[8;65;170t'

#user to enter sudo password to start
echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap 'kill -9 $SPIN_PID' $(seq 0 15)

#script start
echo "STARTING INSTALLATION..."; $sleep 1;

#silently check for macOS software updates — runs in background...sets no sleep
#sudo softwareupdate -i -a >/dev/null 2>&1 &
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1;
defaults write com.apple.gamed Disabled -bool true;
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true;
sudo pmset -a hibernatemode 0;
sudo pmset halfdim 0;
sudo pmset -a displaysleep 0 disksleep 0 sleep 0;
sudo systemsetup -setcomputersleep Never;
sudo systemsetup -setdisplaysleep Never;

#enable firewall
echo "ENABLING FIREWALL..."; $sleep 1;
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1;

#set key repeat rate and cursor blink
echo "MODIFYING CURSOR REPEAT RATE..."; $sleep 1;
$rate NSTextInsertionPointBlinkPeriodOn -float 200;
$rate NSTextInsertionPointBlinkPeriodOff -float 200;
$rate InitialKeyRepeat -int 15;
$rate KeyRepeat -int 2;
$rate NSAutomaticSpellingCorrectionEnabled -bool false;
$rate ApplePressAndHoldEnabled -bool false;
$rate NSAutomaticCapitalizationEnabled -bool false;
$rate NSAutomaticPeriodSubstitutionEnabled -bool false;
$rate NSAutomaticDashSubstitutionEnabled -bool false;
$rate NSAutomaticQuoteSubstitutionEnabled -bool false;
$spellcheck -dict-add "continuousSpellCheckingEnabled" -bool false;

#new hostname
echo "PLEASE ENTER NEW HOSTNAME....ARSM00X..."; sleep 2;
function machinename() {
    osascript <<EOT
        tell application "Finder"
            activate
            set nameentry to text returned of (display dialog "hostname" default answer "arsm00X" with icon 2)
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
echo 'ionpath' | pbcopy;
echo password is 'ionpath'. RANDOMIZE WHEN COMPLETE;

#admin account creation: checks last userID used and uses next available
echo "CREATING ADMIN ACCOUNT..."; $sleep 1;
LastID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1)
NextID=$((LastID + 1))
if [[ $(dscl . list /Users) =~ "admin.arsenal" ]]; then
    echo "ADMIN ACCOUNT ALREADY CREATED...SKIPPING ACCOUNT CREATION..."; $sleep 1;
else
    . /etc/rc.common
    $admin
    $admin RealName "admin.arsenal"
    $admin hint ""
    $admin picture "/Library/User Pictures/Nature/Earth.png"
    $admin UniqueID $NextID
    $admin PrimaryGroupID 80
    $admin UserShell /bin/bash
    $admin NFSHomeDirectory /Users/admin.arsenal
    sudo dscl . passwd /Users/admin.arsenal 2wsx^YHN
    sudo cp -R /System/Library/User\ Template/English.lproj /Users/admin.arsenal
    sudo chown -R admin.arsenal:staff /Users/admin.arsenal
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

#mod man dir for smooth brew installs
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
echo "STARTING HOMEBREW INSTALLATIONS..."; $sleep 1; man_chmod;
$brew cask; man_chmod;
$brew bash; man_chmod;
$brew dockutil; man_chmod;
$brew defaultbrowser; man_chmod;
$brew zsh; man_chmod;
$brew tree; man_chmod;
$brew htop ; man_chmod;

#install brew casks
$cask firefox;
$cask google-chrome;
$cask java;
$cask slack;
$cask zoomus;
$clear

#remove items from dock; requires dockutil to be installed at /usr/local/bin
#echo "REMOVING DOCK ICONS..."; $sleep 1;
#eval killall cfprefsd; $sleep 1;
#sudo $dockutil --remove all --no-restart; $sleep 1;
#echo "ADDING DOCK ICONS..."; $sleep 1;
#apps=("Google\ Chrome.app" "Safari.app" "Firefox.app" "Messages.app" "Slack.app"
#"System\ Preferences.app" "zoom.us.app")
#for app in "${apps[@]}"
#do
#    eval $x$app $y;
#done
#killall Dock;

function lock_chmod() {
    sudo chmod 755 /usr/local/share/man/man1; echo "..";
    sudo chmod 755 /usr/local/share/man/man8; echo "..";
}
$clear
lock_chmod;

#kill spinner
kill -9 $SPIN_PID;

#superuser reboot if required
echo "SETTING DEFAULT BROWSER TO CHROME...";
$browser chrome

echo "CREATING INFO DOC...PLACING ON DESKTOP..."; $sleep 1;
echo "PLEASE EMAIL TO DCHAID@ARSENALBIO.COM...";

function system_info() {
    touch ~/Desktop/info_to_email.txt;
    echo "user:" >> ~/Desktop/info_to_email.txt;
    eval whoami >> ~/Desktop/info_to_email.txt;
    echo "" >> ~/Desktop/info_to_email.txt;
    echo "hostname:" >> ~/Desktop/info_to_email.txt;
    eval hostname >> ~/Desktop/info_to_email.txt;
    echo "" >> ~/Desktop/info_to_email.txt;
    echo "serial:" >> ~/Desktop/info_to_email.txt;
    ioreg -l | grep IOPlatformSerialNumber >> ~/Desktop/info_to_email.txt;
    echo "" >> ~/Desktop/info_to_email.txt;
}
system_info;

open ~/Downloads/arsenal_pkg/Sophos.app; 

echo "" ;
echo "INSTALL COMPLETE...REBOOTING AUTOMATICALLY IN 1000 SECONDS..."; $sleep 1000;
sudo shutdown -r now;

exit 0
