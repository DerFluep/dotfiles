#!/bin/bash

title=$(hyprctl -j activewindow | jq -j '"\(.title)"')
filepath=$HOME/NAS/Photos/Screenshots
fullpath="${filepath}/${title}"

$HOME/.config/hypr/hyprshot.sh -o $fullpath -m window -m active
