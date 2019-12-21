#!/bin/bash

low=92
high=157

if [[ $1 = 'low' ]]
then
    echo "Xft.dpi: $low" | xrdb -merge
    return
fi

if [[ $1 = 'high' ]]
then
    echo "Xft.dpi: $high" | xrdb -merge
    return
fi

displays=$(xrandr | grep "\bconnected" | wc -l)
if [[ $displays -eq 2 ]]
then
    dpi=$low
else
    dpi=$high
fi
echo "Xft.dpi: $dpi" | xrdb -merge
