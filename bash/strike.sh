#!/bin/bash
###############################################################################
#Created by: David Chaid - KDInfotech
#Creation date: November 18, 2019
###############################################################################

date () {
    [ "$#" -eq 0 ] && set -- +'%a, %b %d, %Y  %r'
    command date "$@"
}

sudo -v
#### uninstall sophos and install crowdstrike when available ####

installer -pkg ~/Downloads/FalconSensorMacOS.pkg -target /Applications;

# sudo rm -rf /Applications/Sophos Endpoint.app.app
# sudo rm -rf /Applications/Sophos Device Encryption.app
# sudo rm -rf /Applications/Sophos Endpoint Self Help.app.app

#### create .txt file and check for apps ####

cd /Applications 

function user_info() {
    touch ~/Desktop/fileX.txt;
    date >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "user:" >> ~/Desktop/fileX.txt;
    eval whoami >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "hostname:" >> ~/Desktop/fileX.txt;
    eval hostname >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "serial:" >> ~/Desktop/fileX.txt;
    ioreg -l | grep IOPlatformSerialNumber >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;

    if [ -d "Sophos Device Encryption.app" ]; then
    printf "❌ Sophos Device Encryption.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "✅ Sophos Device Encryption.app is NOT installed.\n \n" >> ~/Desktop/fileX.txt;
    fi

        if [ -d "Sophos Endpoint Self Help.app" ]; then
    printf "❌ Sophos Endpoint Self Help.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "✅ Sophos Endpoint Self Help.app is NOT installed.\n \n" >> ~/Desktop/fileX.txt;
    fi

        if [ -d "Sophos Endpoint.app" ]; then
    printf "❌ Sophos Endpoint.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "✅ Sophos Endpoint.app is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi


    if [ -d "Crowdstrike.app" ]; then
    printf "✅ Crowdstrike.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "❌ Crowdstrike.app is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi

    if [ -d "The Secret of Monkey Island.app" ]; then
    printf "✅ The Secret of Monkey Island.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "🐒 The Secret of Monkey Island.app is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi

    mv ~/Desktop/fileX.txt ~/Desktop/$(whoami)—$(hostname)—$(date +%Y%m%d-%H%M%S).txt;
}

user_info;

exit 0
