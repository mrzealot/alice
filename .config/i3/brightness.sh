#! /bin/bash

# Change laptop screen brightness

# Execute whatever adjustment the command line says
sudo light "$@" > /dev/null

# Query for the new value and notify
value=$(light | sed 's/\..*//')
$HOME/.config/i3/notify.sh changeBrightness 4116303 lightbulb "<span size=\"80000\">${value}</span>"