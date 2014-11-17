#!/bin/bash

sudo apt-get install mercurial vim-gtk cscope exuberant-ctags libevent-dev
tmux_version=$(tmux -V)
if [[ $? != 0 || "${tmux_version}" != "tmux 1.8" ]]; then
    gunzip -c tmux_1.8.orig.tar.gz | tar xvf -
    cd tmux-1.8
    ./configure
    make
    sudo make install
    cd ..
    rm -r tmux-1.8
fi

