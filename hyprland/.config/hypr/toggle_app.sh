#!/bin/bash

APP_NAME="$1"
CMD="$2"

WIN=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$APP_NAME\") | .address" | head -n1)

if [ -n "$WIN" ]; then
  hyprctl dispatch focuswindow address:$WIN
else
  exec $CMD &
fi
