source <(fzf --zsh)

# global settings
export FZF_DEFAULT_OPTS="
--header='<C-c> or <ESC> to exit'
--preview \"bat --color 'always' --line-range 0:300 {}\"
--preview-window='border-rounded'
--border='rounded' --border-label='fzf'
--layout='reverse' --info='right'
--prompt=' ' --marker=' ' --pointer=' '
--separator='─' --scrollbar='│'
--cycle --multi
"

# pywal theme
export FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--color fg:7,bg:-1,hl:1,fg+:255,bg+:2,hl+:232
--color info:7,prompt:5,spinner:1,pointer:232
--color marker:5,gutter:-1,label:2,header:4
"

export FZF_DEFAULT_COMMAND="fd --type f"

function fzd() {
  fd . $* -u --type d | fzf --border-label="fzd" --preview 'tree {}'
} # find dir

function fzcd() { # find dir and cd
  prev=$PWD

  if [ "$1" != "" ]; then
    # cd into $1 first to shorten path in fzf
    target=$(fd . $* -u --type d | fzf --border-label="fzd" --preview 'tree {}' || echo $PREV)
    cd $1 && shift && cd $target
  else
    cd $(fzd || echo "$prev")
  fi

}

function recent() { # find recently opened dirs
  if [ ! -d /data/data/com.termux/files ]; then
    cd $(dirs -lp | fzf --query "$*" --header="select to return to project" --preview 'tree {}')
  else
    cd /data/data/com.termux/$(dirs -lp | sed 's/\/data\/data\/com.termux\///g' | fzf --border-label="recent" --query "$*" --header="select to return to project" --preview 'tree {}')
  fi
}

function proj() { # find projects
  prev=$PWD
  dir=$(cd ~/Dev/ && fd . --maxdepth 2 --type d --type l | fzf --query "$*" --header="select to cd" --border-label="proj" --preview 'tree {}')

  if [ "$dir" != "" ]; then
    cd ~/Dev/$dir
  else
    cd $prev
  fi
}

function dots() { # find dotfiles
  prev=$PWD
  dot_file=$(cd ~ && fd -u --maxdepth 1 | grep "^\." | fzf --query "$*" --header="select to edit in vim" --border-label="dots" --preview 'tree {}')

  if [[ $dot_file == "" ]]; then
    cd $prev
  else
    nvim ~/$dot_file
    cd $prev
  fi
}

function conf() { # find projects
  prev=$PWD
  dir=$(cd ~/.config/ && fd . --maxdepth 1 --type d --type l | fzf --query "$*" --header="select to cd" --border-label="conf" --preview 'tree {}')

  if [ "$dir" != "" ]; then
    cd ~/.config/$dir
  else
    cd $prev
  fi
}

function fzsh() { # find my .zsh files
  prev=$PWD
  cd $ZSH_CUSTOM
  file=$(fd -H | grep -v ".git" | fzf --border-label="fzsh" --query "$*" || cd "$prev")

  if [ "$file" != "" ]; then
    nvim $file
  fi

  cd $prev
}

# open vim with fzf
alias vifz='file=$(fzf --border-label="vifz") && [[ -n $file ]] && nvim $file'
alias fzvi='file=$(fzf --border-label="fzvi") && [[ -n $file ]] && nvim $file'

function fzssh() {
  all_clients="Flip4 S20 Endeavour"
  client=$(echo "$all_clients" | sed "s/ /\n/g" | fzf --border-label="fzssh" --preview=)

  if [[ $client == Flip4 ]]; then
    ssh u0_a322@10.0.0.156 -p 8022 -i id_rsa
  elif [[ $client == S20 ]]; then
    ssh u0_a34@10.0.0.223 -p 8022 -i id_rsa
  elif [[ $client == Endeavour ]]; then
    ssh thederpykrafter@10.0.0.72 -i id_rsa
  fi
}

function fzmc() {
  prev=$PWD
  cd ~/.local/share/PrismLauncher/instances/
  instance=$(fd --maxdepth 1 --type d | fzf --border-label="fzmc" --query "$*" --preview "tree {}")
  if [ "$instance" != "" ]; then
    cd $instance
  else
    cd $prev
  fi
}
