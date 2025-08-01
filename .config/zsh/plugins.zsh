# checkPlugin "author/plugin"
RELOAD=false
function checkPlugin() {
  author=$(echo $1 | sed 's/\/.*//')
  plugin=$(echo $1 | sed 's/.*\///')
  if [ ! -d ~/.config/zsh/plugins/$plugin ]; then
    git clone https://github.com/$author/$plugin ~/.config/zsh/plugins/$plugin
    RELOAD=true
  fi
}

checkPlugin "zsh-users/zsh-syntax-highlighting"
checkPlugin "zsh-users/zsh-autosuggestions"
checkPlugin "hlissner/zsh-autopair"
checkPlugin "MichaelAquilina/zsh-you-should-use"
checkPlugin "RobSis/zsh-completion-generator"
if [[ $RELOAD == true ]]; then
  unset RELOAD
  exec zsh
fi

# timer
TIMER_FORMAT="[%d]"
TIMER_PRECISION=1
TIMER_THRESHOLD=0
