if [[ -d /data/data/com.termux/ ]]; then
  # termux dev path
  export dev="/data/data/com.termux/files/home/storage/shared/Documents/Dev/"

  # termux go path
  export PATH=$PATH:~/go/bin

  # npm global
  export PATH=~/.npm_global/bin:$PATH
else
  # go path
  export PATH=$PATH:/usr/local/go/bin
  export PATH=$PATH:~/go/bin

  # add app images to path
  export PATH=$PATH:~/Applications

  # opam
  [[ ! -r /home/thederpykrafter/.opam/opam-init/init.zsh ]] || source /home/thederpykrafter/.opam/opam-init/init.zsh > /dev/null 2> /dev/null
fi
