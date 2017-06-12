#!/bin/bash

function bbcd() {
    bazel_bin_cd "$(basename $(pwd))"
}

function ncode() {
    nvim -c Vsplits -c term
}

# fix delete key in neovim for the time being
# https://github.com/neovim/neovim/issues/3211
function nvim(){
    tput smkx
    command nvim $@
}

function tjoin() {
    tmux attach-session -t "${@}"
}

function tlist() {
    tmux list-sessions
}

source ~/bin/upcd.bash
source ~/bin/wcd.bash
source ~/bin/scd.bash
source ~/bin/code-window
source ~/bin/bin_dir
source ~/bin/cd_buddy.sh
source ~/bin/tcode.bash
