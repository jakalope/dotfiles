#!/usr/bin/env bash

set -eou pipefail

function items() {
    tmux list-sessions | sed 's/ /:/g'
}

function tcode() {
    tmux attach-session -t "${@}"
}

select listing in $(items); do
    echo "$(echo "$listing" | awk -F: '{print $1}')"
    break
done

