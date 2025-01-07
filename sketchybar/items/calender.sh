#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PLUGIN_DIR="$CONFIG_DIR/plugins"

sketchybar --add item calender right \
  --set calender icon=􀧞 \
  update_freq=30 \
  script="$PLUGIN_DIR/clock.sh"
