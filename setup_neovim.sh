#!/usr/bin/env bash

set -eou pipefail

# Build and install NeoVim
cd ~/Downloads
if [[ ! -e v0.1.6.zip ]]; then
    wget https://github.com/neovim/neovim/archive/v0.1.6.zip
fi
unzip v0.1.6.zip
cd neovim-0.1.6
make -j
sudo make install

