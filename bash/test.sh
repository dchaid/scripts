#!/bin/bash

#install homebrew
brew="/usr/local/bin/brew install"
echo "STARTING HOMEBREW INSTALLATIONS...";
$brew cask;
$brew dockutil;

#install brew casks
brew="/usr/local/bin/brew cask install"
$brew 1password;
$brew atom;
$brew box-drive;
$brew firefox;
$brew google-chrome;
$brew java;
$brew slack;
$brew zoomus;
$clear
exit 0
