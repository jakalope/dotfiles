#!/bin/bash

# install dependencies
sudo apt-get install mercurial vim-gtk cscope exuberant-ctags libevent-dev \
    chromium-browser xsel virtualbox-4.3 autoconf python-catkin-tools \
    gfortran ubuntu-restricted-extras clang-format-3.6

# setup specific tmux version
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

pushd ~
stamp=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p $stamp
echo "backing up old files to ~/${stamp}..."
for file in ".astylerc .bashrc bin .gdbinit .gitconfig hg-prompt .hgignore .hgrc .hgext .rviz .tmux.conf .vim .vimrc .clang-format"
do
    mv $file $stamp
done
popd

# setup symlinks
echo 'linking...'
ln --symbolic --target ${HOME} \
    $(pwd)/{.astylerc,.bashrc,bin,.gdbinit,.gitconfig,hg-prompt,.hgignore,.hgrc,.hgext,.tmux.conf,.rviz,.vim,.vimrc,.clang-format}

# clone hg workspace
mkdir -p ~/workspace
pushd ~/workspace
if [[ ! -d pjfa ]]; then
    echo 'cloning...'
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/utils
    mkdir pjfa
    cd pjfa
    ssh-copy-id pjfa.pal.us.bosch.com
    ssh-copy-id abthadrepo03.de.bosch.com
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/pjfa src
fi
popd

