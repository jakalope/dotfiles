#!/usr/bin/env bash

set -eou pipefail

cd ~/Downloads
FILE='tmux-3.0a.tar.gz'
URL="https://github.com/tmux/tmux/releases/download/3.0a/${FILE}"
if [[ ! -e "$FILE" ]]; then
    wget "$URL"
fi
gunzip -c "$FILE" | tar xvf -
cd tmux-3.0a

./configure
make -j
sudo make install
