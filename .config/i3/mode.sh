#! /bin/bash

case $1 in
  power)
    icon="power"
    msg="Power"
    ;;
  audio)
    icon="volume"
    msg="Audio"
    ;;
  *)
    icon="cog"
    msg="Default"
    ;;
esac

$HOME/.config/i3/notify.sh modeChange 4116300 $icon "<span size=\"15000\">Mode Changed To</span>\n<span size=\"30000\">$msg</span>"