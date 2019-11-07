#!/bin/bash

touch ~/Desktop/info_to_email.txt
echo "user:" >> ~/Desktop/info_to_email.txt ;
eval whoami >> ~/Desktop/info_to_email.txt ;
echo "" >> ~/Desktop/info_to_email.txt ;
echo "hostname:" >> ~/Desktop/info_to_email.txt ;
eval hostname >> ~/Desktop/info_to_email.txt ;
echo "" >> ~/Desktop/info_to_email.txt ;
echo "serial:" >> ~/Desktop/info_to_email.txt ;
ioreg -l | grep IOPlatformSerialNumber >> ~/Desktop/info_to_email.txt ;
echo "" >> ~/Desktop/info_to_email.txt ;
