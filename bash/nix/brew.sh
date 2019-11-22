#!/bin/bash
sudo -v
sudo chown -R $(whoami) /usr/local/share/man/man8
sudo chmod u+w /usr/local/share/man/man8

eval brew update >/dev/null 2>&1 &&
eval brew upgrade >/dev/null 2>&1 &&
eval brew cleanup >/dev/null 2>&1 &&
eval brew linkapps >/dev/null 2>&1 ;

exit 0
