#! /bin/bash

sleep 1s
. ~/.config/i3/dpi.sh high
brave-browser --user-data-dir=/home/zealot/.alice_cc_udd &
sleep 1s
. ~/.config/i3/dpi.sh auto