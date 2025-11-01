#!/usr/bin/env bash

folder=$HOME/Notes/

newnote() {
  dir="$(command ls -d "$folder" "$folder"*/ | fuzzel -d -l 5 -i -p 'Choose directory: ')" || exit 0
  : "${dir:=$folder}"
  name="$(echo "" | fuzzel -d -p "Enter a name: " <&-)" || exit 0
  : "${name:=$(date +%F_%H-%M-%S)}"
  setsid -f "$TERMINAL" "$EDITOR" $dir$name".md" >/dev/null 2>&1
}

selected() {
  choice=$(
    echo -e "New\n$(find $folder -type f -printf '%T@ %P\n' | sort -nr | cut -d' ' -f2-)" | fuzzel -d -l 5 -i -p "Choose note or create new: "
  )
  case $choice in
  New) newnote ;;
  *.md) setsid -f "$TERMINAL" "$EDITOR" "$folder$choice" >/dev/null 2>&1 ;;
  *) exit ;;
  esac
}

selected
