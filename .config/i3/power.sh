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
  echo "        -s       shutdown system"
  echo
  exit 1
}

case $1 in
  -x) LABEL="logout"  ; ACTION="sudo i3-msg exit" ;;
  -r) LABEL="restart" ; ACTION="sudo /sbin/shutdown -r now" ;;
  -s) LABEL="shutdown"; ACTION="sudo /sbin/shutdown -h now" ;;
  *)  message ;;
esac

# gracefully close all apps
i3-msg '[class=".*"] kill'
sleep 2s

# do it
$ACTION &

exit 0
