#! /bin/bash

# A simple logout script that gracefully
# closes all apps before executing
# (Shamelessly repurposed from https://bbs.archlinux.org/viewtopic.php?pid=654186#p654186)

message() {
  echo "usage: power [option]"
  echo
  echo "  options:"
  echo "        -x       logout / kill X"
  echo "        -r       reboot system"
  echo "        -w       reboot into Windows"
  echo "        -s       shutdown system"
  echo
  exit 1
}

case $1 in
  -x) label="Logging out";   action="sudo i3-msg exit" ;;
  -r) label="Rebooting";     action="sudo /sbin/shutdown -r now" ;;
  -w) label="Windows";       action="sudo /sbin/grub-reboot 1 && sudo /sbin/shutdown -r now" ;;
  -s) label="Shutting down"; action="sudo /sbin/shutdown -h now" ;;
  *)  message ;;
esac

# send a notification
$HOME/.config/i3/notify.sh changePowerState 4116300 power "<span size=\"25000\">$label</span>" &
sleep 1s

# gracefully close all apps
i3-msg '[class=".*"] kill'
sleep 2s

# do it
eval $action &

exit 0
