#!/usr/bin/bash

SRC_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
#################
### FUNCTIONS ###
#################
_checkpkg() {
  for pkg in $*; do
    [[ ! $(pacman -Qs) ]] && sudo pacman -S $1 --needed --noconfirm
  done
}

_installyay() {
  checkpkg git base-devel
  TEMP_DIR=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git $TEMP_DIR/yay
  cd $TEMP_DIR/yay
  makepkg -si
  cd -
}

_npminstall() {
  for PKG in $*; do
    [[ $(npm list -g $PKG) ]] && sudo npm install -g $PKG
  done
}

_noautostart() {
  for FILE in $*; do
    if [[ -f /etc/xdg/autostart/$FILE.desktop ]]; then
      sudo rm -rf /etc/xdg/autostart/$FILE.desktop
    fi
  done
}

_sys_enable() {
  for SERVICE in $*; do
    if ! sudo systemctl status $1 | grep "enabled;" &> /dev/null; then
      sudo systemctl enable $1
    fi
    if sudo systemctl status $1 | grep "inactive" &> /dev/null; then
      sudo systemctl start $1
    fi
    echo "System: Enabled $1"
  done
}

#############
### SETUP ###
#############

# Install yay
[[ ! $(command -v yay) ]] && _installyay

# Install packages
yay -S --needed --noconfirm $(< $SRC_DIR/pkglist)

_npminstall neovim

# Disable autostart modules in waybar
_noautostart blueman nm-applet

###############
### CONFIGS ###
###############

## Etc Configs
ETC_CFGS=$(fd "" $SRC_DIR/etc -H --max-depth=1)
for CFG in $ETC_CFGS; do
  sudo ln -sf $CFG /$CFG
done

## Dot Config
CFGS=$(fd "" $SRC_DIR/.config -H --max-depth=1)
for CFG in $CFGS; do
  ln -sf $CFG /home/$USER/$(echo $CFG | sed 's/.*dotfiles\///')
done

## Home Configs
HOME_CFGS=$(fd "" $SRC_DIR/home_config -H --max-depth=1)
for CFG in $HOME_CFGS; do
  ln -sf $CFG /home/$USER/$(echo $CFG | sed 's/.*home_config\///')
done

if [[ ! $(grep "api_key = waka_") ]]; then
  read -p "Enter Wakatime API Key: " WAKA_API_KEY
  sed "s/api_key = .*/api_key = /$WAKA_API_KEY/"
fi

## Firefox UI Fix
FF_PROFILE=$(fd "default-release$" .mozilla/firefox)
if [[ ! -f $FF_PROFILE/user.js ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/black7375/Firefox-UI-Fix/master/install.sh)"
  if [[ ! $(grep "switchByScrolling" $FF_PROFILE/user.js) ]]; then
    tee -a $FF_PROFILE/user.js > /dev/null << EOF
user_pref("toolkit.tabbox.switchByScrolling", true);
EOF
  fi
fi

## Nvim.desktop fix
if [[ -f ~/.local/share/applications/nvim.desktop ]]; then
  [ ! -d .local/share/applications ] && mkdir -p ~/.local/share/applications
  tee ~/.local/share/applications/nvim.desktop > /dev/null << EOF
[Desktop Entry]
Name=Neovim
Exec=kitty -e nvim %F
Terminal=false
Type=Application
Keywords=Text;editor;
Icon=nvim
Categories=Utility;TextEditor;
StartupNotify=false
EOF
fi

# enable system services
sudo nbfc config --set "Acer Nitro AN515-51"
_sys_enable bluetooth libvirtd sshd nbfc_service
