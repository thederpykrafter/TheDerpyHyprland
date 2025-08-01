# pywal theme
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"

# cd and source python env if found
function cd() {
  builtin cd $1
  if [ -f .env/bin/activate ]; then
    source .env/bin/activate
  elif [ -f ./../.env/bin/activate ]; then
    source ./../.env/bin/activate
  elif [ -f env/bin/activate ]; then
    source env/bin/activate
  elif [ -f ./../env/bin/activate ]; then
    source ./../env/bin/activate
  elif command -v deactivate &> /dev/null; then
    deactivate
  fi
}
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'

# lsd
alias ls='lsd --group-dirs first'

if [[ -d /data/data/com.termux ]] \
  && [[ $TMUX ]] \
  && [[ $(tmux list-sessions | wc -l) == 1 ]] \
  && [[ $(tmux list-panes | wc -l) == 1 ]] \
  && [[ $(tmux list-windows | wc -l) == 1 ]] \
  && [[ $(termux-notification-list | jq -r '.[] | select(.id == 1337).content' | awk '{print $1}') == 1 ]]; then

  alias exit='termux-wake-unlock && builtin exit'
fi
# vim like exit
alias :q='exit'
alias :wq='exit'
