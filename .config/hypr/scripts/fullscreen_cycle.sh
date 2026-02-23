#!/bin/bash

# Check if the active window is fullscreen (fullscreen field > 0)
FULLSCREEN=$(hyprctl activewindow -j | jq '.fullscreen')

if [ "$FULLSCREEN" != "0" ]; then
    hyprctl dispatch fullscreen 1   # exit fullscreen
    hyprctl dispatch cyclenext      # cycle to next window
    hyprctl dispatch fullscreen 1   # re-enter fullscreen
else
    hyprctl dispatch cyclenext
fi
