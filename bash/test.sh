#!/bin/bash
function user_info() {
    touch ~/Desktop/fileX.txt;
    echo $(date +%Y%m%d-%H%M%S) >> ~/Desktop/fileX.txt;
    echo "user:" >> ~/Desktop/fileX.txt;
    eval whoami >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "hostname:" >> ~/Desktop/fileX.txt;
    eval hostname >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    echo "serial:" >> ~/Desktop/fileX.txt;
    ioreg -l | grep IOPlatformSerialNumber >> ~/Desktop/fileX.txt;
    echo "" >> ~/Desktop/fileX.txt;
    
    mv ~/Desktop/fileX.txt ~/Desktop/$(whoami)—$(hostname)—$(date +%Y%m%d-%H%M%S).txt;
}
user_info;

exit 0

