#!/usr/bin/bash

if [[ ! -d /etc/pacman.d/hooks ]]; then
  sudo mkdir /etc/pacman.d/hooks
  sudo tee /etc/pacman.d/hooks/reboot-recommended.hook > /dev/null << EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = amd-ucode
Target = intel-ucode
Target = btrfs-progs
Target = cryptsetup
Target = linux
Target = linux-hardened
Target = linux-lts
Target = linux-zen
Target = linux-rt
Target = linux-rt-lts
Target = linux-firmware*
Target = nvidia
Target = nvidia-dkms
Target = nvidia-*xx-dkms
Target = nvidia-*xx
Target = nvidia-*lts-dkms
Target = nvidia*-lts
Target = mesa
Target = systemd*
Target = wayland
Target = virtualbox-guest-utils
Target = virtualbox-host-dkms
Target = virtualbox-host-modules-arch
Target = egl-wayland
Target = xf86-video-*
Target = xorg-server*
Target = xorg-fonts*

[Action]
Description = Check if user should be informed about rebooting after certain system package upgrades.
When = PostTransaction
Exec = notify-send "System reboot recommended!"
EOF
fi
