#!/bin/sh
# Centre the focused window on its monitor, but only if it's floating
# (so toggling back to tiling doesn't fight AeroSpace).
[ "$(/opt/homebrew/bin/aerospace list-windows --focused --format '%{window-layout}')" = floating ] || exit 0

dir=$(dirname "$0")
bin="$dir/center-window" # build artefact, gitignored
[ "$bin" -nt "$dir/center-window.swift" ] || swiftc -O "$dir/center-window.swift" -o "$bin" || exit 1
exec "$bin"
