#!/bin/bash

choise=$(
  echo -e "Catppuccin\nGruvbox" | fuzzel -d
)

case "$choise" in
Catppuccin)
  cp ~/.config/niri/config/colors/catppuccin.kdl ~/.config/niri/config/colors/colors.kdl
  cp ~/.config/waybar/colors/catppuccin.css ~/.config/waybar/colors/colors.css
  cp ~/.config/yazi/catppuccin.toml ~/.config/yazi/theme.toml
  cp ~/.config/fuzzel/themes/catppuccin.ini ~/.config/fuzzel/themes/colors.ini
  cp ~/.config/qt5ct/colors/Catppuccin-Mocha.conf ~/.config/qt5ct/colors/colors.conf
  cp ~/.config/qt6ct/colors/Catppuccin-Mocha.conf ~/.config/qt6ct/colors/colors.conf
  # nvim
  mv ~/.config/nvim/lua/plugins/catppuccin.lua.bak ~/.config/nvim/lua/plugins/catppuccin.lua
  mv ~/.config/nvim/lua/plugins/gruvbox.lua ~/.config/nvim/lua/plugins/gruvbox.lua.bak
  cp ~/.config/wallpaper/catppuccin.png ~/.config/wallpaper/wallpaper.png
  killall swaybg
  niri msg action spawn -- swaybg -i ~/.config/wallpaper/wallpaper.png
  kitten theme catppuccin-mocha
  killall waybar
  niri msg action spawn -- waybar
  ;;
Gruvbox)
  cp ~/.config/niri/config/colors/gruvbox.kdl ~/.config/niri/config/colors/colors.kdl
  cp ~/.config/waybar/colors/gruvbox.css ~/.config/waybar/colors/colors.css
  cp ~/.config/yazi/gruvbox.toml ~/.config/yazi/theme.toml
  cp ~/.config/fuzzel/themes/gruvbox.ini ~/.config/fuzzel/themes/colors.ini
  cp ~/.config/qt5ct/colors/gruvbox.conf ~/.config/qt5ct/colors/colors.conf
  cp ~/.config/qt6ct/colors/gruvbox.conf ~/.config/qt6ct/colors/colors.conf
  # nvim
  mv ~/.config/nvim/lua/plugins/catppuccin.lua ~/.config/nvim/lua/plugins/catppuccin.lua.bak
  mv ~/.config/nvim/lua/plugins/gruvbox.lua.bak ~/.config/nvim/lua/plugins/gruvbox.lua
  cp ~/.config/wallpaper/gruvbox.jpg ~/.config/wallpaper/wallpaper.png
  killall swaybg
  niri msg action spawn -- swaybg -i ~/.config/wallpaper/wallpaper.png
  kitten theme gruvbox dark hard
  killall waybar
  niri msg action spawn -- waybar
  ;;
*)
  echo Canceled
  ;;
esac
