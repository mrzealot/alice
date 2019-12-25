#! /bin/bash

# Switch audio output

# Load hardware info
. $HOME/.hardware.sh

message() {
  echo "usage: audio [option]"
  echo
  echo "  options:"
  echo "        -i       internal speakers"
  echo "        -e       external hdmi"
  echo "        -s       bluetooth soundbar"
  echo
  exit 1
}

internal_card_prefix="alsa_card"
internal_card="pci-0000_00_1f.3"
internal_sink_prefix="alsa_output"

bluetooth_card_prefix="bluez_card"
bluetooth_profile="a2dp_sink"
bluetooth_sink_prefix="bluez_sink"

case $1 in
  -i)
    label="Internal"
    icon="laptop"
    card_prefix=$internal_card_prefix
    card=$internal_card
    sink_prefix=$internal_sink_prefix
    profile="output:analog-stereo+input:analog-stereo"
    ;;
  -e)
    label="External"
    icon="tv"
    card_prefix=$internal_card_prefix
    card=$internal_card
    sink_prefix=$internal_sink_prefix
    profile="output:hdmi-stereo-extra1+input:analog-stereo"
    ;;
  -s)
    label="Soundbar"
    icon="bt_speakers"
    card_prefix=$bluetooth_card_prefix
    card=$(echo $BT_SOUNDBAR | sed 's/:/_/g')
    sink_prefix=$bluetooth_sink_prefix
    profile=$bluetooth_profile
    # try to connect to it, just in case it's not connected already
    echo "connect $BT_SOUNDBAR" | bluetoothctl
    sleep 2s
    ;;
  *)
    message
    ;;
esac

echo "Parameters parsed, target = $label"

# Parse sink naming from the profile
sink_profile=$(echo $profile | sed 's/^output://' | sed 's/\+.*//')
sink="$sink_prefix.$card.$sink_profile"

echo "Setting card ($card_prefix.$card) to profile ($profile)..."
pactl set-card-profile "$card_prefix.$card" $profile

echo "Setting default sink to ($sink)..."
pacmd set-default-sink $sink &> /dev/null

echo "Redirect the existing inputs to the new sink..."
for i in $(pacmd list-sink-inputs | grep index | awk '{print $2}'); do
  pacmd move-sink-input $i $sink &> /dev/null
done

echo "Sending notification"
. $HOME/.config/i3/notify.sh changeAudioOutput 4116306 $icon "<span size=\"15000\">Audio Output</span>\n<span size=\"30000\">$label</span>"

echo "Done"
exit 0
