#!/bin/bash  

#bootable img

hdiutil convert -format UDRW -o ~/Downloads/t_suse.img ~/Downloads/t_suse.iso

mv t_suse.img.dmg s_suse.img

diskutil list

diskutil unmountDisk /dev/disk2

sudo dd if=~/Downloads/t_suse.img of=/dev/rdisk2 bs=1m

