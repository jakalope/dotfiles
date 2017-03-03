#!/bin/bash

function bbcd() {
    bazel_bin_cd "$(basename $(pwd))"
}

function ncode() {
    nvim -c vs -c vs -c vs -c '3wincmd l' -c term
}

function tcode() {
    tmux -2 new -s "$(basename "$(pwd)")" 'nvim -c vs -c vs -c vs -c "3wincmd l" -c term'
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
