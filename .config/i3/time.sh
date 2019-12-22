#! /bin/bash

# Send notification about current time and date

date=$(date +"%F")
time=$(date +"%H:%M")
dunstify -a "lookAtTime" -u low -i $HOME/.icons/clock.png -r "4116302" "" "<span size=\"50000\">$time</span>\n<span size=\"25000\">$date</span>"