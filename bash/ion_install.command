#!/bin/bash
#*****************************************************************************************************************************
#Created by: David Chaid - KDInfotech
#Creation date: September 17, 2019
#Last Modified: September 17, 2019
#Based on Lyell — MacBook Provisioning install.command 
#Modified by: David Chaid
#Modified for: IONPath 
#Updates Available at: https://github.com/dchaid/scripts/
#Description: Connects to Ionpath-guest, adds admin account, installs hombrew,enables firewall,
#mods cursor rate, adds dock icons, runs macOS Software Update, Automatically reboots.
#*****************************************************************************************************************************

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

#user to enter sudo password to start
echo "PLEASE ENTER ADMIN PASSWORD TO EXECUTE SCRIPT...";
sudo -v

# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap "kill -9 $SPIN_PID" `seq 0 15`

echo "STARTING INSTALLATION..."; sleep 1;

#connect to Ionpath-guest network
echo "CONNECTING TO IONPATH-GUEST..."; sleep 1;
host="www.apple.com"
ping -c1 "$host" &> /dev/null

if [ $? -eq 0 ]; then
    echo "ALREADY CONNECTED TO THE INTERNET..."; sleep 1
else
    echo "CONNECTING..." ; sleep 1;
    sudo networksetup -setairportnetwork en0 "Ionpath-guest" ionpath960 ;
    echo "CONNECTION SUCCESSFUL..."; sleep 1;
fi
sleep 5; 

#silently check for macOS software updates — runs in background...
sudo softwareupdate -i -a >/dev/null 2>&1 &

#hostname rename prompt
echo "PLEASE ENTER NEW HOSTNAME....IONMACXX..."; sleep 2;

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

#inserts captured name as "ComputerName" variable for renameComputer function
ComputerName=$(machinename)
renameComputer;

#create admin account
echo "CREATING ADMIN ACCOUNT..."; sleep 1;

#admin account creation: checks last userID used and uses next available e.g. 501 -> 502
LastID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1)
NextID=$((LastID + 1))

if [[ $(dscl . list /Users) =~ "admin.ion" ]]; then
    echo "ADMIN ACCOUNT ALREADY CREATED...SKIPPING ACCOUNT CREATION..."; sleep 1; 
else
    . /etc/rc.common
    sudo dscl . create /Users/admin.ion
    sudo dscl . create /Users/admin.ion RealName "ION Admin"
    sudo dscl . create /Users/admin.ion hint ""
    sudo dscl . create /Users/admin.ion picture "/Library/User Pictures/Nature/Earth.png"
    sudo dscl . passwd /Users/admin.ion changethis
    sudo dscl . create /Users/admin.ion UniqueID $NextID
    sudo dscl . create /Users/admin.ion PrimaryGroupID 80
    sudo dscl . create /Users/admin.ion UserShell /bin/bash
    sudo dscl . create /Users/admin.ion NFSHomeDirectory /Users/admin.ion
    sudo cp -R /System/Library/User\ Template/English.lproj /Users/admin.ion
    sudo chown -R admin.ion:staff /Users/admin.ion

    echo "ADMIN ACCOUNT CREATED..."; sleep 2;
fi
eval clear;

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
eval clear;

#set key repeat rate and cursor blink
echo "MODIFYING CURSOR REPEAT RATE..."; sleep 1;
defaults write -g NSTextInsertionPointBlinkPeriodOn -float 200;
defaults write -g NSTextInsertionPointBlinkPeriodOff -float 200;
defaults write -g InitialKeyRepeat -int 15;
defaults write -g KeyRepeat -int 2;

#enable firewall
echo "ENABLING FIREWALL..."; sleep 1;
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1;

#install brew dependencies
brew="/usr/local/bin/brew"
echo "STARTING HOMEBREW INSTALLATIONS..."; sleep 2;
$brew install ack;
#$brew install axel;
#$brew install bash;
#$brew install bash-completion;
$brew install cask;
#$brew install coreutils;
$brew install cowsay;
$brew install dockutil;
#$brew install emacs;
#$brew install ffmpeg;
#$brew install gawk;
#$brew install geoip;
#$brew install hh;
#$brew install htop;
#$brew install imagemagick;
#$brew install links;
#$brew install lynx;
#$brew install macvim;
#$brew install mysql;
#$brew install ncdu;
#$brew install nmap;
#$brew install nodejs;
#$brew install pbcopy;
#$brew install python;
#$brew install python3;
#$brew install rclone;
#$brew install rlwrap;
#$brew install rsync;
#$brew install rtv;
#$brew install ruby;
#$brew install speedtest_cli;
#$brew install tmux;
#$brew install tree;
#$brew install unrar;
#$brew install vimpager;
#$brew install watch
#$brew install wget;

#install brew casks
#$brew cask aerial;
$brew cask install atom;
#$brew cask caffeine;
$brew cask install firefox;
$brew cask install google-chrome;
#$brew cask google-drive;
#$brew cask iterm2;
$brew cask install java;
#$brew cask opera;
#$brew cask skype;
#$brew cask install slack;
#$brew cask spotify;
#$brew cask sublime-text;
#$brew cask steam;
#$brew cask the-unarchiver;
#$brew cask visual-studio-code
#$brew cask install vlc;
$brew cask install zoomus;
sleep 2;
eval clear;

#remove items from dock; requires dockutil to be installed at /usr/local/bin
echo "REMOVING DOCK ICONS..."; sleep 1; 
eval killall cfprefsd;
/usr/local/bin/dockutil --remove all; sleep 3;

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
    "App Store.app"
    "System Preferences.app"
    "zoom.us.app"
)

for app in "${apps[@]}"
do
    eval $f\$app$z;
done

echo "DOCK ICON REORGANIZATION COMPLETE...";
killall Dock; sleep 1;
eval clear;

#kill spinner
kill -9 $SPIN_PID;

#superuser reboot if required
sudo -v;
eval clear;
/usr/local/bin/cowsay "INSTALL COMPLETE...REBOOTING AUTOMATICALLY IN 4 MINUTES..."; sleep 240;
sudo reboot
exit 0
