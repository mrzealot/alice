#! /bin/bash

# Execute dunst with a constant DPI
# (the notification sizes and whatnot are absolutely sized anyway)
# Usage "notify type id icon msg"

dunst_dpi=92

echo "Xft.dpi: $dunst_dpi" | xrdb -merge
dunstify -a $1 -u low -r $2 -i ~/.icons/$3.png \"\" "$4"
sleep 3.5s
echo "Xft.dpi: `cat .base_dpi`" | xrdb -merge