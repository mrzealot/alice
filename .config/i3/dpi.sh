#!/bin/bash

# Set X DPI appropriate to the current setup

# when using an external display
external=92
# when using the laptop by itself
internal=128

displays=$(xrandr | grep "\bconnected" | wc -l)
if [[ $displays -eq 2 ]]; then
    # external display
    dpi=$external
else
    # just the laptop
    dpi=$internal
fi

# Initial DPI setting is different, because we actually
# fill in a placeholder in the .Xresources file
# (otherwise the setting would be overwritten by a later
# Xsession pass)
if [[ $1 = 'init' ]]; then
    file="$HOME/.Xresources"
    cp $file.tpl $file
    sed -i "s/INITIAL_DPI_HERE/$dpi/" $file
    # also set a global "var" with this value
    echo $dpi > ~/.base_dpi
else
    echo "Xft.dpi: $dpi" | xrdb -merge
fi
