#!/bin/bash

#set key repeat rate and cursor blink
echo "MODIFYING CURSOR REPEAT RATE...";
rate='eval defaults write -g'
$rate NSTextInsertionPointBlinkPeriodOn -float 200;
$rate NSTextInsertionPointBlinkPeriodOff -float 200;
$rate InitialKeyRepeat -int 15;
$rate KeyRepeat -int 2;
