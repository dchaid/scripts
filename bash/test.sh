#!/bin/bash

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
