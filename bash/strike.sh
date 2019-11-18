#!/bin/bash
###############################################################################
#                                                                             #
###############################################################################
#Created by: David Chaid - KDInfotech
#Creation date: November 18, 2019
#Modified by: David Chaid
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

#install meraki mdm profile
open ~/Downloads/arsenal_pkg/MerakiPCCAgent.pkg;

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

function user_info() {
    touch ~/Desktop/filex.txt;
    echo "user:" >> ~/Desktop/fileX.txt;
    eval whoami >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "hostname:" >> ~/Desktop/fileX.txt;
    eval hostname >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "serial:" >> ~/Desktop/fileX.txt;
    ioreg -l | grep IOPlatformSerialNumber >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    mv ~/Desktop/filex.txt ~/Desktop/$(whoami)—$(hostname)—$(date +'%a-%b-%d-%Y-%r').txt
}
user_info;

exit 0
