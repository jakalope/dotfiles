#!/usr/bin/env bash

set -eou pipefail

function items() {
    for dir in $(find ~/workspace -name ".git" -type d -mindepth 2 -maxdepth 2); do
        pushd "${dir}" > /dev/null
        x="$(dirname "${dir}")::$(git rev-parse --abbrev-ref HEAD)"
        echo $x
        popd > /dev/null
    done
}

function tcode() {
    tmux -2 new -s "$(basename "$(pwd)")" 'nvim -c vs -c vs -c vs -c "3wincmd l" -c term'
}

select dir_listing in $(items); do
    cd "$(echo "$dir_listing" | awk -F: '{print $1}')"
    tcode
    break
done

