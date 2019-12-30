#! /bin/bash

# Mute the built-in mic

# Arbitrary but unique message id
id="4116304"

# Toggle mic state and get output
state=$(sudo amixer set Capture toggle | tail -1 | awk '{print $7}' | sed 's/[^a-z]*//g')

if [[ $state == "off" ]]; then
    # Show the mic muted notification
    icon="mic_off"
    msg="Off"
else
    # Show the mic active notification
    icon="mic"
    msg="On"
fi

$HOME/.config/i3/notify.sh "micToggle" 4116304 $icon "<span size=\"80000\">$msg</span>"