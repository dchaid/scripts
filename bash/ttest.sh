#!/bin/bash
#aliases
clear="eval /usr/bin/clear"
sleep="/bin/sleep"
rate="/usr/bin/defaults write -g"
scutil="sudo scutil --set"
admin="sudo dscl . create /Users/lyelladmin"
brew="brew install"
cask="/usr/local/bin/brew cask install"
dockutil="/usr/local/bin/dockutil"
browser="/usr/local/bin/defaultbrowser"
x="defaults write com.apple.dock persistent-apps -array-add "
y='"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'
z='</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
f="$x"$y

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