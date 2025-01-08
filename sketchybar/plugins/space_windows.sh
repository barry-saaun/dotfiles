#!/bin/bash

ICON_MAP_FN_PATH="$CONFIG_DIR/plugins/icon_map_fn.sh"

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app; do
      icon_strip+=" $($ICON_MAP_FN_PATH "$app")"
    done <<<"${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --set space.$space label="$icon_strip"
fi
