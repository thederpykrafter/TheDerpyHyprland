#!/usr/bin/bash

[[ -v $ZSH_CUSTOM ]] && ZSH_CUSTOM=$HOME/.config/zsh/

if ! grep "api_key = waka_" ~/.wakatime.cfg &> /dev/null; then
  # get wakatime api key
  read -p "Enter wakatime api key: " apikey

  # write to config file
  tee ~/.wakatime.cfg > /dev/null << EOF
[settings]
api_key = $apikey
hostname = $HOSTNAME
debug = false
hidefilenames = false
ignore =
    ^COMMIT_EDITMSG$
    ^TAG_EDITMSG$
    ^/var/(?!www/).*
    ^/etc/
    ^$HOME/.local/
    /tpm/
    *.log
    *.bak

[projectmap]
.shortcuts/ = termux.shortcuts
^$HOME/.shortcuts/(\d+)/ = project{0}

[projectmap]
.config/i3/ = endeavour-i3
^$HOME/.config/i3/(\d+)/ = project{0}

[projectmap]
.config/nvim/ = derpy.nvim
^$HOME/.config/nvim/(\d+)/ = project{0}

[projectmap]
.config/zsh/ = zsh
^$ZSH_CUSTOM/(\d+)/ = project{0}

[git_submodule_projectmap]
.config/zsh/themes = cryptic.zsh-theme
^$ZSH_CUSTOM/themes(\d+)/ = project{0}"
EOF
fi

# check for issues
if ! grep "api_key = waka_" ~/.wakatime.cfg &> /dev/null; then
  echo -e "\e[93mPlease run again and add wakatime api key!!!!\e[m"
  exit 1
fi

if grep "localhost" ~/.wakatime.cfg &> /dev/null; then
  echo -e "\e[93mHostname not set properly!!!!\e[m"
  exit 1
fi
