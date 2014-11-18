#!/bin/bash

sudo apt-get install mercurial vim-gtk cscope exuberant-ctags libevent-dev chromium-browser watchman
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
cp -R -i .astylerc .bashrc bin .gdbinit .gitconfig hg-prompt .hgrc hgwatchman .rviz .vim .vimrc ~
cd ~
mkdir -p workspace
cd workspace
if [[ ! -d pjfa ]]; then
    ssh-copy-id pjfa.pal.us.bosch.com
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/pjfa
fi
