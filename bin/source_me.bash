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

source ~/bin/upcd.bash
source ~/bin/wcd.bash
source ~/bin/scd.bash
source ~/bin/code-window
source ~/bin/bin_dir
source ~/bin/cd_buddy.sh
source ~/bin/tcode.bash

alias wsfilter="awk -v cwd=${PWD#*$wcd} '{print cwd \"/\" $0}'"

