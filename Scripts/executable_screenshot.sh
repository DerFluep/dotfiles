#!/bin/bash

if [[ $title =~ ^steam_app_ ]]; then
  title=$(mmsg get focusing-client | jq -j '"\(.title)"')
else
  title=$(mmsg get focusing-client | jq -j '"\(.appid)"')
fi

filepath=~/nas/data/Photos/Screenshots
fullpath="${filepath}/${title}"
mkdir -p $fullpath
date=$(date +%y%m%d-%H:%M:%S)

case "${1:-fullscreen}" in
region)
  g=$(slurp -d)
  [ -z "$g" ] && exit 1
  grim -g "$g" "$filepath/$date.png"
  ;;
window)
  g=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"')
  [ -z "$g" ] && exit 1
  grim -g "$g" "$fullpath/$date.png"
  ;;
freeze)
  p=$(mktemp -u).fifo
  mkfifo "$p"
  wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $p" &
  wp=$!
  read -r <"$p"
  grim "$filepath"
  kill "$wp" 2>/dev/null
  rm -f "$p"
  ;;
freeze-region)
  p=$(mktemp -u).fifo
  mkfifo "$p"
  wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $p" &
  wp=$!
  read -r <"$p"
  g=$(slurp -d)
  if [ -z "$g" ]; then
    kill "$wp" 2>/dev/null
    rm -f "$p"
    exit 1
  fi
  grim -g "$g" "$filepath"
  kill "$wp" 2>/dev/null
  rm -f "$p"
  ;;
*) grim "$filepath/$date.png" ;;
esac
