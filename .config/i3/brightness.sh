#! /bin/bash

# Change laptop screen brightness

# Execute whatever adjustment the command line says
xbacklight "$@" > /dev/null

# Query for the new value and notify
value=$(xbacklight | awk '{print int($1)}')

$HOME/.config/i3/notify.sh changeBrightness 4116303 lightbulb "<span size=\"80000\">${value}</span>"