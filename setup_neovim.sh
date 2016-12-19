#!/usr/bin/env bash

set -eou pipefail

# Build and install NeoVim
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew tap neovim/neovim
    brew install neovim
    gem install neovim
    sudo -H pip2 install neovim
    infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
    tic $TERM.ti
else
    cd ~/Downloads
    if [[ ! -e v0.1.6.zip ]]; then
        wget https://github.com/neovim/neovim/archive/v0.1.6.zip
    fi
    unzip v0.1.6.zip
    cd neovim-0.1.6
    make -j
    sudo make install
fi
