#!/bin/bash

# Check if the active window is fullscreen (fullscreen field > 0)
FULLSCREEN=$(hyprctl activewindow -j | jq '.fullscreen')

if [ "$FULLSCREEN" != "0" ]; then
    hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized" })'   # exit fullscreen
    hyprctl dispatch 'hl.dsp.window.cycle_next()'                         # cycle to next window
    hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized" })'   # re-enter fullscreen
else
    hyprctl dispatch 'hl.dsp.window.cycle_next()'
fi
