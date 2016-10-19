#!/bin/bash

function bbcd() {
    bazel_bin_cd "$(basename $(pwd))"
}

source ~/bin/upcd.bash
source ~/bin/wcd.bash
source ~/bin/scd.bash
source ~/bin/code-window
source ~/bin/bin_dir
