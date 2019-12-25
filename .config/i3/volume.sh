#! /bin/bash

# Change volume with notification and preview

# Change the volume
amixer -D pulse sset Master "$@" > /dev/null

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(amixer -D pulse sget Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
mute="$(amixer -D pulse sget Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
if [[ $volume == 0 || "$mute" == "off" ]]; then
    icon="mute"
    msg="Off"
else
    icon="volume"
    msg=$volume
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"

# Show the volume notification
. $HOME/.config/i3/notify.sh changeVolume 4116301 $icon "<span size=\"80000\">$msg</span>"