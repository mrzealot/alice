#! /bin/bash

# Change laptop screen brightness

# Arbitrary but unique message id
id="4116303"

# Change the volume
sudo light "$@" > /dev/null

# Query amixer for the current volume and whether or not the speaker is muted
value=$(light | sed 's/\..*//')
dunstify -a "changeBrightness" -u low -i $HOME/.icons/lightbulb.png -r "$id" "" "<span size=\"80000\">${value}</span>"