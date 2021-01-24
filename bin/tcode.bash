#!/usr/bin/env bash

function tcode() {
    # session name is the basename of the current directory
    export SESSION_NAME="$(basename "${PWD}")"

    # the current directory is the root of the workspace
    export MY_WORKSPACE_DIR="${PWD}"

    # determine if a tmux session $SESSION_NAME already exists
    session_exists=$(tmux ls | awk -F: '{print $1}' | \
        grep "\b$SESSION_NAME\b" | wc -l)

    if [[ $TMUX == "" ]]; then
        if ((session_exists)); then
            # attach to an existing session
            echo 'Attempting to attach to existing tmux session.'
            tmux attach-session -t "$SESSION_NAME"
        else
            # create a new session
            echo 'Creating a new tmux session.'
            tmux -2 new-session \
                -s "${SESSION_NAME}" \
                "MY_WORKSPACE_DIR=\"${PWD}\" ${EDITOR}"
        fi
    else
        if ((session_exists)); then
            echo You are already in this session!
        else
            # take over the current session
            echo Taking over the current session.
            tmux rename-session $SESSION_NAME 2> /dev/null
        fi
    fi
}

function items() {
    for dir in $(find ./ -mindepth 2 -maxdepth 2 -name ".git" -type d); do
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
