#!/usr/bin/bash

[[ "$*" == "-v" ]] && set -v

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
    if ! sudo systemctl status $SERVICE | grep "enabled;" &> /dev/null; then
      sudo systemctl enable $SERVICE
    fi
    if sudo systemctl status $SERVICE | grep "inactive" &> /dev/null; then
      sudo systemctl start $SERVICE
    fi
    echo "System: Enabled $SERVICE"
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

# Disable autostart for modules in waybar
_noautostart blueman nm-applet

###############
### CONFIGS ###
###############

## Etc Configs
rsync -a --chown=root $SRC_DIR/etc/ /etc
# ETC_CFGS=$(fd "" $SRC_DIR/etc -H --max-depth=1)
# for CFG in $ETC_CFGS; do
#   sudo cp $CFG /etc/$(echo $CFG | sed 's/.*etc\///')
# done

## Dot Config
CFGS=$(fd "" $SRC_DIR/.config -H --max-depth=1)
for CFG in $CFGS; do
  DEST=$(echo $CFG | sed 's/.*dotfiles\///')
  if [[ ! -L ~/$(echo $DEST | sed 's/\/$//') ]]; then
    [[ ! -d ~/.config/.bak ]] && mkdir ~/.config/.bak
    mv ~/$DEST ~/.config/.bak/
    ln -sfT $CFG ~/.config/
  fi
done

## Home Configs
HOME_CFGS=$(fd "" $SRC_DIR/home_config -H --max-depth=1)
for CFG in $HOME_CFGS; do
  DEST=$(echo $CFG | sed 's/.*home_config\///')
  if [[ ! -L ~/$(echo $DEST | sed 's/\/$//') ]]; then
    [[ ! -d ~/.config/.bak ]] && mkdir ~/.config/.bak
    mv ~/$DEST ~/.config/.bak/
    ln -sfT $CFG ~/
  fi
done

## Local Configs
LOCAL_CFGS=$(fd "" $SRC_DIR/local_share -H --max-depth=1)
for CFG in $LOCAL_CFGS; do
  DEST=$(echo $CFG | sed 's/.*local_share\///')
  if [[ ! -L ~/.local/share/$(echo $DEST | sed 's/\/$//') ]]; then
    [[ ! -d ~/.config/.bak ]] && mkdir ~/.config/.bak
    mv ~/$DEST ~/.config/.bak/
    ln -sf $CFG ~/.local/share/
  fi
done

## Firefox UI Fix
FF_PROFILE=$(fd "default-release$" ~/.mozilla/firefox)
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

# dev repos
$SRC_DIR/scripts/dev-repos.sh
$SRC_DIR/scripts/wakatime.sh
$SRC_DIR/scripts/pacman-hooks.sh
