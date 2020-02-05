#! /bin/bash

# Pass media controls to the CC

pid=$(ps -e -o pid,command | grep -E "^[[:space:]]*[[:digit:]]+ .*brave --user-data-dir=.*alice_cc_udd$" | awk '{print $1}')
playerctl -p chromium.instance$pid $@
