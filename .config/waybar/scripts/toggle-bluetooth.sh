#!/usr/bin/bash

if rfkill list bluetooth | grep "Soft blocked: yes"; then
  hyprctl dispatch exec rfkill unblock bluetooth
else
  hyprctl dispatch exec rfkill block bluetooth
fi
