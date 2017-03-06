#!/usr/bin/env bash

set -eou pipefail

cd ~/Downloads
FILE='tmux-2.3.tar.gz'
URL="https://github.com/tmux/tmux/releases/download/2.3/${FILE}"
if [[ ! -e "$FILE" ]]; then
    wget "$URL"
fi
gunzip -c "$FILE" | tar xvf -
cd tmux-2.3

./configure 
make -j
make install