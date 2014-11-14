#!/bin/bash

if [[ $# > 0 ]]
then
    SESSIONNAME="$1"
else
    SESSIONNAME="ros"
fi

tmux has-session -t $SESSIONNAME &> /dev/null

if [[ $? != 0 ]]; then
    tmux new-session -s $SESSIONNAME -n VIM -d 'cd ~/workspace/rdr; vims' \; split-window -h \; split-window -v \; resize-pane -L 10
fi

tmux attach -t $SESSIONNAME
