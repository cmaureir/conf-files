#!/bin/bash
# Sends a notification when the battery drops below 30% / 15% while discharging.
# Runs from a hidden waybar module; prints empty text so nothing is displayed.
BAT=/sys/class/power_supply/BAT0
STATE="${XDG_RUNTIME_DIR:-/tmp}/waybar-battery-alert"
cap=$(cat "$BAT/capacity" 2>/dev/null || echo 100)
status=$(cat "$BAT/status" 2>/dev/null)
last=$(cat "$STATE" 2>/dev/null || echo ok)

if [ "$status" = "Discharging" ]; then
  if [ "$cap" -le 15 ]; then level=critical
  elif [ "$cap" -le 30 ]; then level=warning
  else level=ok; fi
  if [ "$level" != "$last" ]; then
    case "$level" in
      critical) notify-send -u critical -i battery-empty "Battery critical" "${cap}% left, plug in now!" ;;
      warning)  notify-send -u normal -i battery-caution "Battery low" "${cap}% left, time to plug in" ;;
    esac
    echo "$level" > "$STATE"
  fi
else
  echo ok > "$STATE"
fi
echo '{"text": ""}'
