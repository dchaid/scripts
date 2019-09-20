#!/bin/sh

echo "PLEASE ENTER ADMIN PASSWORD TO INSTALL..."
sudo -v
echo "CREATING BASH DIRECTORY..."; sleep 1;
mkdir ~/Desktop/Install &&
cd ~/Desktop/Install &&
echo "DOWNLOADING INSTALL SCRIPTS..."; sleep 1;
curl -sS https://raw.githubusercontent.com/dchaid/scripts/master/bash/install.command > install.command &&
curl -sS https://raw.githubusercontent.com/dchaid/scripts/master/bash/dock.command > dock.command &&
chmod a+x install.command ; 
chmod a+x dock.command ;

open install.command;

exit 0

