#! /bin/bash

# NOTE: this is NOT executed with bash, no matter what
# shebang I put at the top! That's why the double bracket
# conditionals didn't work, and also why I couldn't source
# scripts with params... Keep to standard sh stuff here!

# generate dynamic parts of the i3 config
i3conf="$HOME/.config/i3/config"
cp $i3conf.tpl $i3conf

# monitor setup (needed for default window placement)
internal=$(xrandr | grep "^eDP" | awk '{print $1}')
if [ -z $internal ]; then
    echo "ERROR: Internal monitor cannot be detected!";
fi
sed -i "s/INTERNAL_DISPLAY/$internal/" $i3conf

external=$(xrandr | grep "\bconnected" | grep -v "$internal" | awk '{print $1}')
if [ -z $external ]; then
    # just the laptop
    xrandr --auto
    sed -i "s/EXTERNAL_DISPLAY/$internal/" $i3conf
else
    # with external display
    xrandr --output $internal --left-of $external --preferred --output $external --primary --size 1920x1080
    sed -i "s/EXTERNAL_DISPLAY/$external/" $i3conf
fi

# set initial DPI
$HOME/.config/i3/dpi.sh init

# set the background
if [ -f /usr/bin/feh ]; then
    feh --bg-scale "$HOME/.wallpapers/primary.png" --bg-scale "$HOME/.wallpapers/secondary.png" &
fi

# pass it on to the default conf
. /etc/X11/Xsession