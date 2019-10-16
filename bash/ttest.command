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


sudo mkdir /usr/local/share/man/man11;
sudo mkdir /usr/local/share/man/man81;

exit 0
