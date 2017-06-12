#!/usr/bin/env bash

function tcode() {
    if [[ $TMUX == "" ]]; then
        SESSION_NAME="$(basename "$(pwd)")"
        tmux -2 new \
            -s "${SESSION_NAME}" \
            "MY_WORKSPACE_DIR=\"${PWD}\" nvim"
    else
        export SESSION_NAME="$(basename "$(pwd)")"
        tmux rename-session $SESSION_NAME 2> /dev/null
        nvim
    fi
}

function items() {
    for dir in $(find ./ -name ".git" -type d -mindepth 2 -maxdepth 2); do
        pushd "${dir}" > /dev/null
        dir=$(dirname "${dir}")
        dir="${dir##*/}"
        x="${dir}:$(git rev-parse --abbrev-ref HEAD)"
        echo $x
        popd > /dev/null
    done
}

function tws() {
    select dir_listing in $(items); do
        cd "$(echo "$dir_listing" | awk -F: '{print $1}')"
        tcode
        break
    done
}
