#!/bin/bash

# Get GPU info from sysfs (no root required)
CARD=$(ls /sys/class/drm/ | grep -E '^card[0-9]+$' | head -1)
FREQ_FILE="/sys/class/drm/$CARD/gt_act_freq_mhz"
# Intel iGPU shares the CPU package, so use the package temperature
TEMP=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | sort -n | tail -1)
for z in /sys/class/thermal/thermal_zone*; do
  [ "$(cat "$z/type")" = "x86_pkg_temp" ] && TEMP=$(cat "$z/temp") && break
done
TEMP=$((TEMP / 1000))

clock=$(cat "$FREQ_FILE" 2>/dev/null || echo 0)
# Actual freq reads 0 when the GPU is idle (RC6 sleep); fall back to requested freq
if [ "$clock" = "0" ]; then
  clock=$(cat "/sys/class/drm/$CARD/gt/gt0/rps_cur_freq_mhz" 2>/dev/null || echo 0)
fi
temp=$TEMP

deviceinfo="Intel Iris Xe Graphics"
driverinfo=$(cat /sys/bus/pci/devices/0000:00:02.0/driver/module/version 2>/dev/null || \
             echo "kernel $(uname -r)")

echo '{"text": "'"$clock"'MHz |  '"$temp"'°C", "class": "custom-gpu", "tooltip": "<b>'"$deviceinfo"'</b>\n'"$driverinfo"'"}'
