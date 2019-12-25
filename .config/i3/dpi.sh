#!/bin/bash

# Set X DPI appropriate to the current setup

# when dual wielding, this is for the external display
dual_external=92
# when using the laptop by itself, strike a compromise
single_internal=128
# when dual wielding, this is for the internal display
dual_internal=157

displays=$(xrandr | grep "\bconnected" | wc -l)
if [[ $displays -eq 2 ]]; then
    # dual wielding
    high=$dual_internal
    low=$dual_external
else
    # just the laptop
    high=$single_internal
    low=$single_internal
fi

if [[ $1 = 'high' ]]; then
    dpi=$high
else
    dpi=$low
fi

echo "Xft.dpi: $dpi" | xrdb -merge
