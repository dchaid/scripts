#!/bin/bash  

#bootable img

hdiutil convert -format UDRW -o ~/Downloads/x_manjaro.img ~/Downloads/x_manjaro.iso

mv x_manjaro.img.dmg x_manjaro.img

diskutil list

diskutil unmountDisk /dev/disk2

sudo dd if=/Users/davidchaid/Downloads/x_manjaro.img of=/dev/rdisk2 bs=1m