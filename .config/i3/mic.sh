#! /bin/bash

# Mute the built-in mic

# Arbitrary but unique message id
id="4116304"

# Toggle mic state and get output
state=$(sudo amixer set Capture toggle | tail -1 | awk '{print $7}' | sed 's/[^a-z]*//g')

if [[ $state == "off" ]]; then
    # Show the mic muted notification
    dunstify -a "micToggle" -u low -i $HOME/.icons/mic_off.png -r "$id" "" "<span size=\"80000\">Off</span>"
else
    # Show the mic active notification
    dunstify -a "micToggle" -u low -i $HOME/.icons/mic.png -r "$id" "" "<span size=\"80000\">On</span>"
fi