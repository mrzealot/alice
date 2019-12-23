#! /bin/bash

# Switch audio output

# Load hardware info
source ~/.hardware.sh

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

case $1 in
  -i)
    label="Internal"
    icon="speaker"
    card="alsa_card.pci-0000_00_1f.3"
    profile="output:analog-stereo+input:analog-stereo"
    ;;
  -e)
    label="External"
    icon="hdmi"
    card="alsa_card.pci-0000_00_1f.3"
    profile="output:hdmi-stereo-extra1+input:analog-stereo"
    ;;
  -s)
    label="Soundbar"
    icon="bluetooth"
    card=""
    profile=""
    ;;
  *)
    message
    ;;
esac



exit 0
