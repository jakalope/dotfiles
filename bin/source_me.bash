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

function pcp_ci() {
    brun -c opt --config=cuda //lidar/metrics:run_perception_ci -- --dm --timing-only
}

function gfc() {
    ${WORKSPACE_ROOT}/ci/file_validators/validate.py --fix
    git commit "${@}"
}

function git-fetch-checkout() {
    git fetch origin "$1" && git checkout "origin/$1"
}

function inotifyrun {
    FORMAT=$(echo -e "\033[1;33m%w%f\033[0m written");
    while :; do
        "$@";
        echo "Exited: $?";
        echo "";
        inotifywait -qre close_write --format "$FORMAT" --exclude '(\.ros|\.git)|(/4913|\.sw.|index\.lock)$' . || break;
    done
}

source ~/bin/upcd.bash
source ~/bin/wcd.bash
source ~/bin/scd.bash
source ~/bin/code-window
source ~/bin/bin_dir
source ~/bin/cd_buddy.sh
source ~/bin/tcode.bash

alias wsfilter="awk -v cwd=${PWD#*$wcd} '{print cwd \"/\" $0}'"
alias inorun=inotifyrun

