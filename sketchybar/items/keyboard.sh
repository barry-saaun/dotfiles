#!/bin/bash

keyboard=(
  icon.drawing=off
  label.font="$FONT:Semibold:14.0"
  script="$PLUGIN_DIR/keyboard.sh"
  label.padding_left=10
  click_script="osascript -e 'tell application \"System Events\" to keystroke \" \" using {control down, option down}'" # my shortcut to change layout
)

sketchybar --add item keyboard right \
  --set keyboard "${keyboard[@]}" \
  --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
  --subscribe keyboard keyboard_change
