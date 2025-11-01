#!/bin/bash

dir="$(command cat ~/bookmarks | fuzzel -d -p 'Choose directory: ')" || exit 0

setsid -f "$TERMINAL" $dir >/dev/null 2>&1
