#!/bin/bash

cat /etc/crypttab

# To add a new password, use luksAddKey:

sudo cryptsetup luksAddKey /dev/sda3

# To remove an existing password, use luksRemoveKey:

sudo cryptsetup luksRemoveKey /dev/sda3

# View currently used slots of the encrypted partition:

sudo cryptsetup luksDump /dev/sda3
