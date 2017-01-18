#!/bin/bash

function bbcd() {
    bazel_bin_cd "$(basename $(pwd))"
}

function ncode() {
    # if [[ -e WORKSPACE ]]; then
    # fi
    source ~/.bashrc
    nvim -c vs -c vs -c vs -c '3wincmd l' -c term
}

source ~/bin/upcd.bash
source ~/bin/wcd.bash
source ~/bin/scd.bash
source ~/bin/code-window
source ~/bin/bin_dir
source ~/bin/cd_buddy.sh
