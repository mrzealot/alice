#! /bin/zsh

# Send notification about current time and date

date=$(date +"%y-%m-%d")
time=$(date +"%H:%M")
days=('H' 'K' 'Sze' 'Cs' 'P' 'Szo' 'V')
day=${days[`date +"%u"`]}
$HOME/.config/i3/notify.sh lookAtTime 4116302 clock "<span size=\"50000\">$time</span>\n<span size=\"20000\">$date ($day)</span>"