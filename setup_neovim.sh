#!/usr/bin/env bash

set -eou pipefail

# Build and install NeoVim
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew tap neovim/neovim
    brew install neovim || brew upgrade neovim
    sudo -H pip2 install --upgrade neovim
else
    cd ~/Downloads
    if [[ ! -e v0.2.0.tar.gz ]]; then
        wget https://github.com/neovim/neovim/archive/v0.2.0.tar.gz
    fi
    gunzip -c v0.2.0.tar.gz | tar xvf -
    cd neovim-0.2.0
    mkdir build
    cd build
    cmake ../ CMAKE_BUILD_TYPE=RelWithDebInfo
    make -j
    sudo make install
fi

sudo gem install neovim
sudo gem upgrade neovim
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
