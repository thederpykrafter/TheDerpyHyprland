#!/usr/bin/bash

if rfkill list wifi | grep "Soft blocked: yes"; then
  hyprctl dispatch exec rfkill unblock wifi
else
  hyprctl dispatch exec rfkill block wifi
fi
