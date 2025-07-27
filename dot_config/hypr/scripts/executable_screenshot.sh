#!/bin/bash

title=$(hyprctl -j activewindow | jq -j '"\(.class)"')
filepath=/mnt/nas/Photos/Screenshots
fullpath="${filepath}/${title}"

$HOME/.config/hypr/scripts/hyprshot.sh -o $fullpath -m window -m active
