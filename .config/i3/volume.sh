#! /bin/bash

# Change volume with notification and preview

# Arbitrary but unique message id
id="4116301"

# Change the volume
amixer -D pulse sset Master "$@" > /dev/null

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(amixer -D pulse sget Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
mute="$(amixer -D pulse sget Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
if [[ $volume == 0 || "$mute" == "off" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i $HOME/.icons/mute.png -r "$id" "" "<span size=\"80000\">Off</span>"
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i $HOME/.icons/volume.png -r "$id" "" "<span size=\"80000\">${volume}</span>"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"