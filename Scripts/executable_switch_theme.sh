#!/bin/bash

choise=$(
  echo -e "Switch Wallpaper\nCatppuccin\nGruvbox\nTokyonight" | fuzzel -d --placeholder "Select Theme" --counter
)

case "$choise" in
"Switch Wallpaper")
  cd ~/.config/wallpaper/
  image=$(
    fd . -t f -E wallpaper.png | fuzzel -d --placeholder "Select Wallpaper" --counter
  )
  cp $image wallpaper.png
  killall swaybg
  niri msg action spawn -- swaybg -i $PWD/wallpaper.png
  ;;
Catppuccin)
  cp ~/.config/niri/config/colors/catppuccin.kdl ~/.config/niri/config/colors/colors.kdl
  cp ~/.config/waybar/colors/catppuccin.css ~/.config/waybar/colors/colors.css
  cp ~/.config/yazi/catppuccin.toml ~/.config/yazi/theme.toml
  cp ~/.config/fuzzel/themes/catppuccin.ini ~/.config/fuzzel/themes/colors.ini
  cp ~/.config/qt5ct/colors/Catppuccin-Mocha.conf ~/.config/qt5ct/colors/colors.conf
  cp ~/.config/qt6ct/colors/Catppuccin-Mocha.conf ~/.config/qt6ct/colors/colors.conf
  cp ~/.config/btop/themes/catppuccin_mocha.theme ~/.config/btop/themes/theme.theme
  cp ~/.config/mako/colors/catppuccin ~/.config/mako/colors/colors
  # nvim
  sed -i 's/colorscheme = "[^"]*"/colorscheme = "catppuccin"/' ~/.config/nvim/lua/plugins/theme.lua
  kitten theme catppuccin-mocha
  killall waybar
  niri msg action spawn -- waybar
  killall mako
  niri msg action spawn -- mako
  ;;
Gruvbox)
  cp ~/.config/niri/config/colors/gruvbox.kdl ~/.config/niri/config/colors/colors.kdl
  cp ~/.config/waybar/colors/gruvbox.css ~/.config/waybar/colors/colors.css
  cp ~/.config/yazi/gruvbox.toml ~/.config/yazi/theme.toml
  cp ~/.config/fuzzel/themes/gruvbox.ini ~/.config/fuzzel/themes/colors.ini
  cp ~/.config/qt5ct/colors/gruvbox.conf ~/.config/qt5ct/colors/colors.conf
  cp ~/.config/qt6ct/colors/gruvbox.conf ~/.config/qt6ct/colors/colors.conf
  cp ~/.config/btop/themes/gruvbox_dark_v2.theme ~/.config/btop/themes/theme.theme
  cp ~/.config/mako/colors/gruvbox ~/.config/mako/colors/colors
  # nvim
  sed -i 's/colorscheme = "[^"]*"/colorscheme = "gruvbox"/' ~/.config/nvim/lua/plugins/theme.lua
  kitten theme gruvbox dark hard
  killall waybar
  niri msg action spawn -- waybar
  killall mako
  niri msg action spawn -- mako
  ;;
Tokyonight)
  cp ~/.config/niri/config/colors/tokyonight.kdl ~/.config/niri/config/colors/colors.kdl
  cp ~/.config/waybar/colors/tokyonight.css ~/.config/waybar/colors/colors.css
  cp ~/.config/yazi/tokyonight.toml ~/.config/yazi/theme.toml
  cp ~/.config/fuzzel/themes/tokyonight_night.ini ~/.config/fuzzel/themes/colors.ini
  cp ~/.config/qt5ct/colors/Tokyonight.conf ~/.config/qt5ct/colors/colors.conf
  cp ~/.config/qt6ct/colors/Tokyonight.conf ~/.config/qt6ct/colors/colors.conf
  cp ~/.config/btop/themes/tokyo-night.theme ~/.config/btop/themes/theme.theme
  cp ~/.config/mako/colors/tokyonight ~/.config/mako/colors/colors
  # nvim
  sed -i 's/colorscheme = "[^"]*"/colorscheme = "tokyonight"/' ~/.config/nvim/lua/plugins/theme.lua
  kitten theme tokyo night
  killall waybar
  niri msg action spawn -- waybar
  killall mako
  niri msg action spawn -- mako
  ;;
*)
  echo Canceled
  ;;
esac
