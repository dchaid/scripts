#!/bin/bash  

#bootable img
cd ~/Downloads || return

hdiutil convert -format UDRW -o buntu.img buntu.iso

mv buntu.img.dmg buntu.img

diskutil list

diskutil unmountDisk /dev/disk2

sudo dd if=buntu.img of=/dev/rdisk2 bs=1m

