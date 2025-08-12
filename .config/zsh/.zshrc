# !=KITTY !=TTY1 && ==STDIN && !=TMUX && ==INTERACTIVE
if [[ $(command -v tmux) ]] && [[ $TERM == "foot" ]] && [[ $TTY != /dev/tty1 ]] && [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]]; then
  if tmux ls &> /dev/null; then
    exec tmux new-session
  else
    exec tmux new-session -s main
  fi
fi

if [[ -d /data/data/com.termux ]]; then
  termux-notification-list | jq -r '.[] | select(.id == 1337).content' | grep -qF 'wake lock held' && locked="true" || locked="false"
  if [ "$locked" = "false" ]; then
    echo "Enabling wake lock"
    termux-wake-lock
  else
    echo "Wake lock enabled"
  fi
fi

# pywal theme
[[ -z $USER ]] && export USER=$(whoami)
[[ -d ~/.cache/wal ]] && (cat ~/.cache/wal/sequences &)
[[ -d ~/.cache/wal ]] && source ~/.cache/wal/colors-tty.sh

zstyle ':omz:*' aliases no
zstyle ':completion:*' menu select
zstyle ':omz:update' mode auto

if [[ -d /usr/share/oh-my-zsh ]]; then
  export ZSH="/usr/share/oh-my-zsh"
elif [[ -d ~/.oh-my-zsh ]]; then
  export ZSH="~/.oh-my-zsh"
else
  echo "Install Oh My Zsh!"
fi

export ZSH_CUSTOM=$HOME/.config/zsh/
# ZSH_THEME="cryptic"
# CRYPTIC_THEME_SHOW_TIME=true
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"
export QT_QPA_PLATFORMTHEME=qt5ct

plugins=(
  git
  git-auto-fetch
  fzf
  copybuffer
  zsh-you-should-use
  zsh-completion-generator
  zsh-autosuggestions
  zsh-autopair
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
fpath+=~/.zfunc
autoload -Uz compinit
compinit
