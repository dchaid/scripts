#!/bin/bash

FILE=/Library/CS/falconctl
if test -f "$FILE"; then
    echo "$FILE exists"
fi

FILE=/Library/CS/falcond
if test -f "$FILE"; then
    echo "$FILE exists"
fi

    FILE=/Library/CS/falconctl
    if test -f "$FILE"; then
    printf "✅ Crowdstrike.app is installed. \n \n" >> ~/Desktop/fileX.txt;
    else printf "❌ Crowdstrike.app is NOT installed. \n \n" >> ~/Desktop/fileX.txt;
    fi