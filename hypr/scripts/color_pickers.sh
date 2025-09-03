#!/usr/bin/env bash

killall hyprpicker &>/dev/null || :
hyprpicker | wl-copy
