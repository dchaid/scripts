#!/bin/bash
printf "\033[48;5;5m"  # or "\033[46m" background
printf "\033[H\033[2J" # your system's clear command does something similar
printf "\u001b[43m" # or "\033[96m" text
echo Hello World;
echo;

echo;
eval ping www.google.com

exit 0