#!/usr/bin/env bash

###################
#### Dev Repos ####
###################

# create array for repos
declare -A dev_repos

# github profile
dev_repos["thederpykrafter"]="../Dev/github"

# rust
dev_repos["rust-tui"]="rust"
dev_repos["tdk-bevy"]="rust"

# ocaml
dev_repos["hello_ocaml"]="ocaml"

# go
dev_repos["learning-go"]="go"

# bash
dev_repos["get-repos"]="bash"
dev_repos["nogit"]="bash"
dev_repos["add-license"]="bash"
dev_repos["prism-mc-screenshots"]="bash"
dev_repos["killmc"]="bash"

# zig
dev_repos["hello-zig"]="zig"
dev_repos["ziglings-solutions"]="zig"
dev_repos["scratch"]="zig"
dev_repos["learning-zig"]="zig"

# lua
dev_repos["ansi-lib"]="lua"
dev_repos["tdk-lib-lua"]="lua"
dev_repos["learning-love"]="lua"
dev_repos["love"]="lua"

# c
dev_repos["c-starter"]="c"
dev_repos["derp"]="c"
dev_repos["get_ncurse_key"]="c"
dev_repos["curse_game"]="c"
dev_repos["x-win"]="c"
dev_repos["gtk-example"]="c"

# c3c
dev_repos["hello_c3c"]="c3c"
dev_repos["arguing"]="c3c"

# c++
dev_repos["hello_cpp"]="cpp"
dev_repos["vulkan_cpp"]="cpp"
dev_repos["game_engine"]="cpp"

# python
dev_repos["Organize-by-extensions"]="python"
dev_repos["pycurses"]="python"

# godot
dev_repos["LearningGodot"]="godot"

# nasm
dev_repos["DerpyOS"]="nasm"

# odin
dev_repos["sdl_tutorial"]="odin"

# clone repos
for repo in ${!dev_repos[@]}; do
  project=${repo}
  dir=${dev_repos[${repo}]}
  [[ ! -d ~/Dev/$dir ]] && mkdir -p ~/Dev/$dir
  [[ ! -d ~/Dev/$dir/$project ]] && gh repo clone $project ~/Dev/$dir/$project
done
