function update() {
  function update_os() {
    if command -v nala &> /dev/null; then
      nala update && nala upgrade -y
    elif command -v pkg &> /dev/null; then
      pkg update -y && pkg upgrade -y
    elif command -v apt &> /dev/null; then
      apt update -y && apt upgrade -y
    elif command -v yay &> /dev/null; then
      yay -Syy
      yay -Syu --noconfirm
    elif command -v pacman &> /dev/null; then
      pacman -Syy
      pacman -Syu --noconfirm
    fi
    date +%j > ~/.lastupdate
  }

  if [ -f ~/.lastupdate ]; then
    last_update=$(cat ~/.lastupdate)
    today=$(date +%j)
    if [[ $last_update < $today ]]; then
      update_os
    else
      echo "you already updated today bro" | lolcat
    fi
  else
    update_os
  fi
}

alias setup="~/Dev/bash/universal-setup/setup.sh"

alias killjava="killall -9 java"

# cls
alias cls='clear -x'

# reload zsh
if [ -d ~/.termux ]; then
  alias xdg-open='xdg-open --chooser'
  alias termux-open='termux-open --chooser'
  function reload() {
    termux-reload-settings
    if [[ $TMUX ]]; then
      tmux source-file ~/.config/tmux/tmux.conf
    fi
    exec zsh
  }
  alias file-browser='am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"'
  alias recent-file-browser="am start -a android.intent.action.OPEN_DOCUMENT -d /storage/emulated/0 -t '*/*'"
else
  function reload() {
    if [[ $TMUX ]]; then
      tmux source-file ~/.config/tmux/tmux.conf
    fi
    exec zsh
  }
fi

alias get-repos='~/Dev/bash/get-repos/get-repos.sh'

alias sched='~/Dev/bash/work-sched/work-sched &'

# nvim alias
alias vim='nvim'
alias vi='nvim'
# alias tvi='NVIM_APPNAME=termux-nvim nvim'
# alias kvi='NVIM_APPNAME=kickstart.nvim nvim'
# nvim default editor
export EDITOR='nvim'
# nvim MANPAGER
export MANPAGER='nvim +Man!'

# clean nvim or provided nvim config name
function clean_vim() {
  if [ ! -z "$1" ]; then
    rm -rf ~/.cache/$1 ~/.local/state/$1 ~/.local/share/$1
    echo "Cleaned ~/.cache/$1 ~/.local/state/$1 ~/.local/share/$1"
  else
    rm -rf ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim
    echo "Cleaned ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim"
  fi
}

alias grep="grep --color=auto"

if command -v kitty &> /dev/null; then
  # function kitten() { /usr/bin/kitty -e /usr/bin/kitten $* }
  alias kitten="kitty -e /usr/bin/kitten"
fi

alias mc-shots="~/Dev/bash/prism-mc-screenshots/mc-shots"

alias asciiquarium="/usr/bin/asciiquarium -t -s"

# not needed if nvidia setup correctly
#alias godot='godot --rendering-driver opengl3 &'

function welcome_art() {
  random_image=$(shuf -n1 -e $(fd . $ZSH_CUSTOM/images/))
  if grep "#\!/" $random_image &> /dev/null; then
    $random_image
  elif echo $random_image | grep "endeavour" &> /dev/null; then
    cat $random_image
  else
    cat $random_image | lolcat
  fi
  export LAST_WELCOME_ART=$random_image
}
welcome_art

alias sort-downloads="~/Dev/python/Organize-by-extensions/main.py"
sort-downloads
