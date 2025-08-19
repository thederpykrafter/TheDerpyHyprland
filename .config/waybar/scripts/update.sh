#!/bin/bash

if [[ $(command -v figlet) ]] && [[ $(command -v lolcat) ]]; then
  echo "yay -Syu" | figlet | lolcat
  yay --noconfirm

  echo -n "Press any key to continue..." | figlet | lolcat
  read -n 1
else
  echo "yay -Syu"
  yay --noconfirm

  read -p "Press any key to continue..." -n 1
fi
