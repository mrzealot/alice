#! /bin/bash

# Disable the built-in keyboard/touchpad

# Arbitrary but unique message id
id="4116305"

# Get states
keyboard=$(  xinput -list | grep Translated.*keyboard | sed 's/.*\bid=//' | awk '{print $1}')
touchpad=$(  xinput -list | grep TouchPad             | sed 's/.*\bid=//' | awk '{print $1}')
trackpoint=$(xinput -list | grep TrackPoint           | sed 's/.*\bid=//' | awk '{print $1}')

# State is based off of the keyboard, but everything else is toggled in tandem
state=$(xinput --list-props $keyboard | grep 'Device Enabled' | grep -o [01]$)

if [[ $state == "1" ]]; then
    xinput --disable $keyboard
    xinput --disable $touchpad
    xinput --disable $trackpoint
    dunstify -a "keyboardToggle" -u low -i $HOME/.icons/keyboard_off.png -r "$id" "" "<span size=\"80000\">Off</span>"
else
    xinput --enable $keyboard
    xinput --enable $touchpad
    xinput --enable $trackpoint
    dunstify -a "keyboardToggle" -u low -i $HOME/.icons/keyboard.png -r "$id" "" "<span size=\"80000\">On</span>"
fi