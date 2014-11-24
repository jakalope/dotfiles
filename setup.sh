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

watchman_version=$(watchman --version)
if [[ $? != 0 ]]; then
    cd watchman
    ./autogen.sh && ./configure && make
    sudo make install
    make clean
    rm -rf .deps/ Makefile Makefile.in aclocal.m4 autom4te.cache/ cmds/.deps/ cmds/.dirstamp compile config.guess config.h config.h.in config.log config.status config.sub configure depcomp files install-sh missing query/.deps/ query/.dirstamp stamp-h1 tests/.deps/ tests/.dirstamp thirdparty/.deps/ thirdparty/.dirstamp thirdparty/jansson/.deps/ thirdparty/jansson/.dirstamp thirdparty/jansson/jansson_config.h watcher/.deps/ watcher/.dirstamp
    cd ..
fi

cp -R -i .astylerc .bashrc bin .gdbinit .gitconfig hg-prompt .hgrc hgwatchman .rviz .vim .vimrc ~
cd ~
mkdir -p workspace
cd workspace
if [[ ! -d pjfa ]]; then
    ssh-copy-id pjfa.pal.us.bosch.com
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/pjfa
fi
