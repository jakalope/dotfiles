#!/usr/bin/env bash

set -eou pipefail

# Build and install NeoVim
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew tap neovim/neovim
    brew install neovim || brew upgrade neovim
    sudo -H pip2 install --upgrade neovim
else
#    cd ~/Downloads
#    if [[ ! -e v0.1.6.zip ]]; then
#        wget https://github.com/neovim/neovim/archive/v0.1.6.zip
#    fi
#    unzip v0.1.6.zip
#    cd neovim-0.1.6
#    make -j CMAKE_BUILD_TYPE=Release
#    sudo make install
    sudo apt-get install neovim
fi

sudo gem install neovim
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti
