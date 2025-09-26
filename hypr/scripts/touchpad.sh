#!/usr/bin/env bash

# Using libinput or evtest to monitor touchpad events, I noticed that even when
# hyprland turn off the touchpad, it still emits new events. After some
# research, I believe hyprland just grabs the touchpad events and redirects them
# somewhere like /dev/null, instead of actually disabling the device

HYPR_TOUCHPAD_STATE=/tmp/hypr_touchpad_state
MY_DEFAULT_TOUCHPAD=elan1300:00-04f3:3057-touchpad

# touchpad state file (I want the touchpad to be disabled by default)
[[ ! -e $HYPR_TOUCHPAD_STATE ]] && echo 0 >$HYPR_TOUCHPAD_STATE

# touchpad toggle
current_state=$(cat $HYPR_TOUCHPAD_STATE)
new_state=$((1 - current_state))
echo $new_state >$HYPR_TOUCHPAD_STATE
hyprctl keyword -r -- device[$MY_DEFAULT_TOUCHPAD]:enabled $new_state
