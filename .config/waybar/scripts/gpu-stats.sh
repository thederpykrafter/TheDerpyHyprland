#!/bin/bash

function nvquery() {
  nvidia-smi --query-gpu=$1 --format=csv,noheader,nounits
}

CSS_CLASS="low"

if ((GPU_UTIL > 30 && GPU_UTIL < 60)); then
  CSS_CLASS="medium"
fi

if ((GPU_UTIL > 60)); then
  CSS_CLASS="high"
fi
GPU_UTIL=$(nvquery utilization.gpu)

printf '{"text": "%s", "class": "%s", "tooltip": "%s%s%s"}' \
  "$GPU_UTIL%" $CSS_CLASS \
  "󱐋  $(nvquery power.draw)/$(nvquery power.max_limit) Watts\n" \
  " $(nvquery memory.used)/$(nvquery memory.total) Mib"
