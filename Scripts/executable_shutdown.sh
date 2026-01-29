#!/bin/bash

choise=$(
  echo -e "Shutdown\nReboot" | fuzzel -d
)
case "$choise" in
Shutdown)
  shutdown now
  ;;
Reboot)
  shutdown -r now
  ;;
*)
  echo Canceled
  ;;
esac
