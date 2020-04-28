#!/usr/bin/env bash

set -eou pipefail

# Build and install NeoVim
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew install neovim
else
    cd /tmp
    if [[ -d neovim ]]; then
        sudo rm -rf neovim
    fi
    git clone git@github.com:neovim/neovim.git
    cd neovim
    git checkout ede21f95180f44cab6b77598d34de31967f24622

    # sudo apt-get install libuv-dev libmsgpack-dev
    mkdir .deps ; cd .deps
    cmake ../third-party
    make
    cd ..
    mkdir build
    cd build
    cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo
    make -j
    sudo make install
fi

sudo gem install neovim
# sudo gem upgrade neovim
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
