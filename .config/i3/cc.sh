#! /bin/bash

# Start the Control Center browser instance
# As it will always be displayed on the internal monitor,
# it always needs to start in high dpi mode

sleep 1s
. $HOME/.config/i3/dpi.sh high
brave-browser --user-data-dir=$HOME/.alice_cc_udd &
sleep 1s
. $HOME/.config/i3/dpi.sh auto