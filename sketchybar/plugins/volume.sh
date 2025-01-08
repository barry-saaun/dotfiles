#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

#  brew install switchaudio-osx to get the "SwitchAudioSource" command

CURRENT_OUTPUT_DEVICE="$(SwitchAudioSource -c)"

case "$CURRENT_OUTPUT_DEVICE" in
*"AirPods Pro"*) ICON="􀪷" ;;
*"AirPods Gen 3"*) ICON="􁄡" ;;
*"AirPods"*) ICON="􀟥" ;;
"WH-1000XM"*) ICON="􀑈" ;;
*)

  if [ "$SENDER" = "volume_change" ]; then
    VOLUME="$INFO"

    case "$VOLUME" in
    [6-9][0-9] | 100)
      ICON="󰕾"
      ;;
    [3-5][0-9])
      ICON="󰖀"
      ;;
    [1-9] | [1-2][0-9])
      ICON="󰕿"
      ;;
    *) ICON="󰖁" ;;
    esac
  fi
  ;;
esac

sketchybar --set "$NAME" icon="$ICON"
