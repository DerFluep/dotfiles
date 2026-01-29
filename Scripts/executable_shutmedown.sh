#!/bin/bash

if [ $(date +%a) == "So" ] || [ $(date +%a) == "Mo" ] || [ $(date +%a) == "Di" ] || [ $(date +%a) == "Mi" ] || [ $(date +%a) == "Do" ];
then
  while true;
  do
    if [ $(date +%H:%M) == 22:10 ];
    then
      notify-send -u critical "Diggi du hast noch 5min!"
      shutdown 22:15
      break
    fi
  sleep 59s
  done
fi
