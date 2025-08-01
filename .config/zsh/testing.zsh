function test_colors_rainbow() {

  if [[ $(tput cols) -gt 128 ]]; then
    color=0
    color2=128
    while [[ $color -lt 128 ]]; do
      print -Pn "%K{$color}%F{$color2}▄%k%f"
      color=$((color + 1))
      color2=$((color2 + 1))
      [[ $(($color % 128)) == 0 ]] && print
    done
    print
  else
    color=0
    while [[ $color -lt 256 ]]; do
      color2=$((color + 8))
      print -Pn "%K{$color} %k"
      color=$((color + 1))
      [[ $(((color) % 16)) == 0 ]] && print
    done
    print
  fi
}

function test_colors_zsh() {
  color=0
  while [[ $color -lt 256 ]]; do
    if [[ $color -le 9 ]]; then
      print -Pn "%F{7}|  $color%K{$color}  %k%f"
    elif [[ $color -le 99 ]]; then
      print -Pn "%F{7}| $color%K{$color}  %k%f"
    else
      print -Pn "%F{7}|$color%K{$color}  %k%f"
    fi

    [[ $((($color + 1) % 8)) == 0 ]] && print
    color=$((color + 1))
  done
  print
}

function test_colors_ansi() {
  cat << EOF
|fg       |fg_bright|bg     |bg_bright
|30 [30m[47m  [40m  [m|90 [90m[47m  [40m  [m|40 [40m [37m[30m [m|100 [100m [37m[30m [m
|31 [31m[47m  [40m  [m|91 [91m[47m  [40m  [m|41 [41m [37m[30m [m|101 [101m [37m[30m [m
|32 [32m[47m  [40m  [m|92 [92m[47m  [40m  [m|42 [42m [37m[30m [m|102 [102m [37m[30m [m
|33 [33m[47m  [40m  [m|93 [93m[47m  [40m  [m|43 [43m [37m[30m [m|103 [103m [37m[30m [m
|34 [34m[47m  [40m  [m|94 [94m[47m  [40m  [m|44 [44m [37m[30m [m|104 [104m [37m[30m [m
|35 [35m[47m  [40m  [m|95 [95m[47m  [40m  [m|45 [45m [37m[30m [m|105 [105m [37m[30m [m
|36 [36m[47m  [40m  [m|96 [96m[47m  [40m  [m|46 [46m [37m[30m [m|106 [106m [37m[30m [m
|37 [37m[47m  [40m  [m|97 [97m[47m  [40m  [m|47 [47m [37m[30m [m|107 [107m [37m[30m [m
EOF
}
