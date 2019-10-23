#!/bin/bash
#wifi connection script
#connect to KDIGuest network if needed
commenting out unless needed
echo "CONNECTING TO NETWORK..."; sleep 1;
host="www.apple.com"
ping -c1 "$host" &> /dev/null

if [ $? -eq 0 ]; then
    echo "ALREADY CONNECTED TO THE INTERNET..."; sleep 1
else
    echo "CONNECTING..." ; sleep 1;
    sudo networksetup -setairportnetwork en0 "NETWORK NAME" PASSWORD ;
    echo "CONNECTION SUCCESSFUL..."; sleep 1;
fi
sleep 5;
