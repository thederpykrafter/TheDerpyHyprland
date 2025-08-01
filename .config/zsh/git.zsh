# lazygit
function gg() {
  if [[ $TMUX ]]; then
    tmux new-window lazygit
  else
    lazygit
  fi
}

# git top level
alias cg='cd `git rev-parse --show-toplevel`'

# git init, add, commit
alias gitinit='git init && git add -A && git commit -m "init"'

# git init, add, commit && gh repo create
function ghinit() {
  repo_name=$(basename $PWD)

  if [ ! -f README.md ]; then
    touch README.md
    echo "# $repo_name" &> README.md
  fi

  if [ ! -d .git ]; then
    git init && git add -A && git commit -m "init"
  else
    git add README.md && git commit -m "add README.md"
  fi

  gh repo create $repo_name -s . --push --public
}

# .gitignore
alias gitignore='nvim .gitignore'

# git clone
function gitclone() {
  gh repo clone $1 $2
}

# my git
function mygit() {
  gh repo clone thederpykrafter/$1 $2
}

# fuzzy search github repos
function myrepos() {
  gh repo list -L 200 | awk '{print $1}' \
    | sed 's/thederpykrafter\///' | fzf --query "$*" --preview ""
}
function lazyclone() {
  gitclone $(myrepos)
}

function gittemplate() {
  if [ ! $# -eq 0 ]; then
    gh repo create $1 --public --clone --template $2
    cd $1
  else
    echo "Usage:"
    echo "gittemplate [new-repo] [template]"
    return 1
  fi
}

alias nogit="~/Dev/bash/nogit/nogit.sh"
