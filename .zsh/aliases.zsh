alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias settings='XDG_CURRENT_DESKTOP=GNOME gnome-control-center &'
alias alice='/usr/bin/git --git-dir=$HOME/.alice/ --work-tree=$HOME'
alias btspeed='hcitool con | grep E6:6F:0C:E7:48:91 | awk '\''{print $5}'\'' | xargs -I{} sudo hcitool lecup --handle {} --min 6 --max 7 --latency 0'
alias pong='ping google.com'
alias python=python3
alias open=xdg-open

function remind() {
    ( echo '$HOME/.config/i3/notify.sh reminder 4116399 clock "<span size=\"25000\">'${2:-PING}'</span>" critical' | at now + ${1:-5} minutes & ) > /dev/null 2>&1
}

function vpn() {
    for uuid in `nmcli con | awk '/vpn/ {print $2}'`; do nmcli con ${1:-up} $uuid; done
}