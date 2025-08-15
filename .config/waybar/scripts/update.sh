#!/bin/bash

# Update system
yay

# Read to keep open just incase of errors
if [[ $(command -v lolcat) ]]; then
  echo -n "Press any key to continue..." | lolcat
  read -n 1
else
  read -p "Press any key to continue..." -n 1
fi
