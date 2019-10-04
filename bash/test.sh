#!/bin/bash

echo "OPENING ALL INSTALLERS NEEDED TO COMPLETE SETUP..."
install="open /Volumes/lyelldrive/INSTALLS/"
$install\InstallBoxTools.app;
$install\inSync.mpkg; 
$install\MerakiPCCAgent.pkg;
$install\Microsoft_Office.pkg;
$install\SophosInstaller.app;
$install\XeroxPrintDriver.pkg;
cp -a /Volumes/lyelldrive/INSTALLS/Box\ Notes.app /Applications/; sleep 5;


#wifi connection script
#connect to KDIGuest network if needed 
#---commenting out unless needed
#---echo "CONNECTING TO NETWORK..."; sleep 1;
#---host="www.apple.com"
#---ping -c1 "$host" &> /dev/null
#---
#---if [ $? -eq 0 ]; then
#---    echo "ALREADY CONNECTED TO THE INTERNET..."; sleep 1
#---else
#---    echo "CONNECTING..." ; sleep 1;
#---    sudo networksetup -setairportnetwork en0 "NETWORK NAME" PASSWORD ;
#---    echo "CONNECTION SUCCESSFUL..."; sleep 1;
#---fi
#---sleep 5;