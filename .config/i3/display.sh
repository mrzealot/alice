#! /bin/bash

i3conf="$HOME/.config/i3/config"

internal=$(xrandr | grep "^eDP" | awk '{print $1}')
if [ -z $internal ]; then
    echo "ERROR: Internal monitor cannot be detected!";
fi

if [ $1 = 'init' ]; then
    sed -i "s/INTERNAL_DISPLAY/$internal/" $i3conf
fi

external=$(xrandr | grep "\bconnected" | grep -v "$internal" | awk '{print $1}')
if [ -z $external ]; then
    # just the laptop
    xrandr --auto
    if [ $1 = 'init' ]; then
        sed -i "s/EXTERNAL_DISPLAY/$internal/" $i3conf
    fi
else
    # with external display
    if [ $1 = 'reset' ]; then
        xrandr --output $external --off
        sleep 2s
    fi
    xrandr --output $internal --left-of $external --preferred --output $external --primary --mode 1920x1080
    if [ $1 = 'init' ]; then
        sed -i "s/EXTERNAL_DISPLAY/$external/" $i3conf
    fi
fi