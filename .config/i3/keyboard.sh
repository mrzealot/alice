#! /bin/bash

# Disable the built-in keyboard/touchpad

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
    icon="keyboard_off"
    msg="Off"
else
    xinput --enable $keyboard
    xinput --enable $touchpad
    xinput --enable $trackpoint
    icon="keyboard"
    msg="On"
fi

. $HOME/.config/i3/notify.sh keyboardToggle 4116305 $icon "<span size=\"80000\">$msg</span>"