#!/usr/bin/env bash

function items() {
    for dir in $(find ~/workspace -name ".git" -type d -mindepth 2 -maxdepth 2); do
        pushd "${dir}" > /dev/null
        x="$(dirname "${dir}")::$(git rev-parse --abbrev-ref HEAD)"
        echo $x
        popd > /dev/null
    done
}

function tcode() {
    SESSION_NAME="$(basename "$(pwd)")"
    tmux -2 new \
        -s "${SESSION_NAME}" \
        "MY_WORKSPACE_DIR=\"${PWD}\" nvim -c Vsplit -c term"
}

function tws() {
    select dir_listing in $(items); do
        cd "$(echo "$dir_listing" | awk -F: '{print $1}')"
        tcode
        break
    done
}
