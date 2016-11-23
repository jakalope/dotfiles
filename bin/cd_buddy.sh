#!/usr/bin/env bash

# This script is intended to be sourced and its functions used on the command
# line. Once sourced, use the `md` command to change directories, instead of
# `cd`. If you omit an argument, `md` presents a list of your top 10
# directories, allowing you to choose which one you want to change to.

mkdir -p ~/dotfiles/.cache
touch ~/dotfiles/.cache/md

md() {
    if [[ $# != 0 ]]; then
        # change directory
        cd "${@}"
    else
        # list the top 10 directories visited using `md`
        dirs="$(cat ~/dotfiles/.cache/md | sort | uniq -c | sort -nr | head -n10 | awk '{print $2}')"
        select dir in $dirs; do
            cd "${dir}"
            break
        done;
    fi
    # save the new directory to the cache
    pwd >> ~/dotfiles/.cache/md
    # purge old entries
    len="$(cat ~/dotfiles/.cache/md | wc -l)"
    MAX_LINES=1000
    if ((${len} > $MAX_LINES)); then
        tail -n $MAX_LINES ~/dotfiles/.cache/md > ~/dotfiles/.cache/tmp.md
        mv ~/dotfiles/.cache/tmp.md ~/dotfiles/.cache/md
    fi
}
