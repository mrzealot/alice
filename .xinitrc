#! /bin/bash

# NOTE: this is NOT executed with bash, no matter what
# shebang I put at the top! That's why the double bracket
# conditionals didn't work, and also why I couldn't source
# scripts with params... Keep to standard sh stuff here!

# generate dynamic parts of the i3 config
i3conf="$HOME/.config/i3/config"
cp $i3conf.tpl $i3conf

# monitor setup (needed for default window placement)
$HOME/.config/i3/display.sh init

# set initial DPI
$HOME/.config/i3/dpi.sh init

# set the background
if [ -f /usr/bin/feh ]; then
    feh --bg-scale "$HOME/.wallpapers/primary.png" --bg-scale "$HOME/.wallpapers/secondary.png" &
fi

# pass it on to the default conf
. /etc/X11/Xsession