#!/bin/bash

volume=(
  script="$PLUGIN_DIR/volume.sh"
  label.align="center"
  label.padding_right=5
)

sketchybar --add item volume right \
  --set volume "${volume[@]}" \
  --subscribe volume volume_change
