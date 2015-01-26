#!/bin/bash

function add_suffix()
{
    suffix="${1}"
    shift
    while [[ $# > 0 ]]; do
        if [[ -e "${1}" && ! -L "${1}" ]]; then
            mv "${1}" "${1}_${suffix}"
        fi
        shift
    done
}

sudo apt-get install mercurial vim-gtk cscope exuberant-ctags libevent-dev \
    chromium-browser xsel clang virtualbox-4.3

tmux_version=$(tmux -V)
if [[ $? != 0 || "${tmux_version}" != "tmux 1.8" ]]; then
    gunzip -c tmux_1.8.orig.tar.gz | tar xvf -
    pushd tmux-1.8
    ./configure
    make
    sudo make install
    popd
    rm -r tmux-1.8
fi

watchman_version=$(watchman --version)
if [[ $? != 0 ]]; then
    pushd watchman
    ./autogen.sh && ./configure && make
    sudo make install
    make clean
    rm -rf .deps/ Makefile Makefile.in aclocal.m4 autom4te.cache/ cmds/.deps/ \
            cmds/.dirstamp compile config.guess config.h config.h.in \
            config.log config.status config.sub configure depcomp files \
            install-sh missing query/.deps/ query/.dirstamp stamp-h1 \
            tests/.deps/ tests/.dirstamp thirdparty/.deps/ \
            thirdparty/.dirstamp thirdparty/jansson/.deps/ \
            thirdparty/jansson/.dirstamp \
            thirdparty/jansson/jansson_config.h watcher/.deps/ \
            watcher/.dirstamp
    popd
fi

pushd ~
stamp=$(date +%Y-%m-%d-%H-%M-%S)
echo 'backing up old files...'
add_suffix "_${stamp}" .astylerc .bashrc bin .gdbinit .gitconfig hg-prompt \
    .hgrc hgwatchman .rviz .tmux.conf .vim .vimrc
echo 'removing old files...'
rm -rf .astylerc .bashrc bin .gdbinit .gitconfig hg-prompt \
    .hgrc hgwatchman .rviz .tmux.conf .vim .vimrc
popd

echo 'linking...'
ln --symbolic --target ${HOME} \
    $(pwd)/{.astylerc,.bashrc,bin,.gdbinit,.gitconfig,hg-prompt,.hgrc,hgwatchman,.tmux.conf,.rviz,.vim,.vimrc}

mkdir -p ~/workspace
pushd ~/workspace
echo 'cloning...'
if [[ ! -d pjfa ]]; then
    ssh-copy-id pjfa.pal.us.bosch.com
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/pjfa
fi
popd

