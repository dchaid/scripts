#!/bin/bash
#from: https://forum.manjaro.org/t/broadcom-wifi-driver-fails-to-install-properly/46316/2

#sudo enable
sudo -v ;

#check drivers
sudo pacman -Rns linux419-broadcom-wl ;

sudo mhwd -r pci network-broadcom-wl ;

#update manjaro
sudo pacman-mirrors -f 5 && sudo pacman -Syyu ;

# install all required Linux headers packages for all installed kernels
sudo pacman -S $(pacman -Qsq "^linux" | grep "^linux[0-9]*[-rt]*$" | awk '{print $1"-headers"}' ORS=' ') ;

#install dkms
sudo pacman -S dkms ;

#install dkms driver pkg
sudo pacman -S broadcom-wl-dkms ; sleep 2 ;

#create blacklist
sudo echo -e "blacklist b43\nblacklist b43legacy\nblacklist ssb\nblacklist bcm43xx\nblacklist brcm80211\nblacklist brcmfmac\nblacklist brcmsmac\nblacklist bcma" | sudo tee -a /etc/modprobe.d/blacklist.conf sleep 2 ;

#run individually with time in between. if still no wifi try reboot
sudo rfkill unblock all ; sleep 5 ;
sudo depmod -a ; sleep 5 ;
sudo mkinitcpio -P ; sleep 10 ;
sudo systemctl stop NetworkManager ; sleep 10 ;
sudo rmmod b43 b43legacy ssb brcm80211 brcmfmac brcmsmac bcma ; sleep 2 ;
sudo modprobe -r wl ; sleep 2 ;
sudo modprobe wl ; sleep 2 ;
DEVICE=$(hwinfo --wlan | grep "Device File" | cut -d " " -f5) && sudo ip link set $DEVICE up ; sleep 2 ;
sudo rfkill unblock all ; sleep 1 ;
sudo systemctl start NetworkManager ; sleep 2 ;
exit 0

