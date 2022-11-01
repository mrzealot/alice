#! /bin/bash

i3conf="$HOME/.config/i3/config"

internal=$(xrandr | grep "^eDP" | awk '{print $1}')
if [ -z $internal ]; then
    echo "ERROR: Internal monitor cannot be detected!";
fi

external=$(xrandr | grep "\bconnected" | grep -v "$internal" | awk '{print $1}')
if [ -z $external ]; then
    # just the laptop
    xrandr --auto
    xbacklight -set 100
    if [ $1 = 'init' ]; then
        sed -i "s/XRANDR_DISPLAY/$internal/" $i3conf
    fi
else
    # with external display
    if [ $1 = 'reset' ]; then
        xrandr --output $external --off
        sleep 2s
    fi
    xrandr --output $internal --same-as $external --preferred --output $external --primary --mode 1920x1080
    xbacklight -set 0
    if [ $1 = 'init' ]; then
        sed -i "s/XRANDR_DISPLAY/$external/" $i3conf
    fi
fi