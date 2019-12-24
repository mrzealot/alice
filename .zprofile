alias btspeed='hcitool con | grep E6:6F:0C:E7:48:91 | awk '\''{print $5}'\'' | xargs -I{} sudo hcitool lecup --handle {} --min 6 --max 7 --latency 0'
btspeed
exec startx