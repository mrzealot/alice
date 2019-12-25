#! /bin/bash

# Send notification about current time and date

date=$(date +"%F")
time=$(date +"%H:%M")
. $HOME/.config/i3/notify.sh lookAtTime 4116302 clock "<span size=\"50000\">$time</span>\n<span size=\"25000\">$date</span>"