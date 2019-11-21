#!/bin/bash
###############################################################################
#Created by: David Chaid - KDInfotech
#Creation date: November 18, 2019
###############################################################################

#aliases
FD=/Library/CS/falcond
FCTL=/Library/CS/falconctl
date () {
    [ "$#" -eq 0 ] && set -- +'%a, %b %d, %Y  %r'
    command date "$@"
}
#script
sudo -v

cd /Library/Application\ Support/Sophos/saas/Installer.app/Contents/MacOS/tools/ || return;
sudo ./InstallationDeployer --force_remove;

cd ~/Downloads/falcon || return;

for f in *.pkg ; 
    do sudo installer -verboseR -pkg "$f" -target / -dumplog
done

#### create .txt file and check for apps ####
function user_info() {
    touch ~/Desktop/fileX.txt;
    {
        date
        echo ""
        echo "user:"
        eval whoami
        echo ""
        echo "hostname:"
        eval hostname
        echo ""
        echo
        ioreg -l | grep IOPlatformSerialNumber
        echo ""
    } >> ~/Desktop/fileX.txt;

        if [ -d "Sophos Endpoint Self Help.app" ]; then
    printf "❌ Sophos Endpoint Self Help.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "✅ Sophos Endpoint Self Help.app is NOT installed.\n \n" >> ~/Desktop/fileX.txt;
    fi

        if [ -d "Sophos Endpoint.app" ]; then
    printf "❌ Sophos Endpoint.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "✅ Sophos Endpoint.app is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi

    if test -f "$FCTL"; then
    printf "✅ FALCONCTL is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "❌ FALCONCTL is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi

    if test -f "$FD"; then
    printf "✅ FALCOND is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "❌ FALCOND is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi

    mv ~/Desktop/fileX.txt ~/Desktop/"$(whoami)"—"$(hostname)"—"$(date +%Y%m%d-%H%M%S)".txt;
}

user_info;

exit 0
