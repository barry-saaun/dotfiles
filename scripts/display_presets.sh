#!/bin/bash

# Laptop as the main & monitor in front
laptop_main() {
  displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1512x982 hz:120 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" "id:B782C41A-738D-4C02-9223-010605BE5643 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:on origin:(-531,-1440) degree:0"
}

# Monitor as the main & laptop on the side
monitor_main() {
  displayplacer "id:B782C41A-738D-4C02-9223-010605BE5643 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1512x982 hz:120 color_depth:8 enabled:true scaling:on origin:(2560,245) degree:0"
}

external_only() {
  displayplacer "id:B782C41A-738D-4C02-9223-010605BE5643 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0"
}

$1
