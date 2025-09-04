#!/bin/bash

if [[ $(command -v toilet) ]] && [[ $(command -v lolcat) ]]; then
  toilet -f future "yay -Syu" | lolcat
  yay --noconfirm || sudo pacman -Syu

  toilet -f future "Press any key to continue..." | lolcat
  read -n 1
else
  echo "yay -Syu"
  yay --noconfirm || sudo pacman -Syu

  read -p "Press any key to continue..." -n 1
fi
