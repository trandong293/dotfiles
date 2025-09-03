#!/usr/bin/env bash

screen() {
  grim - | wl-copy
}

area() {
  # killing the slurp process will also terminate the grim process
  killall slurp &>/dev/null || :
  grim -g "$(slurp)" - | wl-copy
}

window() {
  geometry=$(hyprctl activewindow -j |
    jq -r '(.at | join(",")) + " " + (.size | join("x"))')
  grim -g "$geometry" - | wl-copy
}

if [[ $1 == screen ]]; then
  screen
elif [[ $1 == area ]]; then
  area
elif [[ $1 == window ]]; then
  window
fi
