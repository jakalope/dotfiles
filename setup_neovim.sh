#!/usr/bin/env bash

set -eou pipefail

cd /tmp
if [[ -d neovim ]]; then
    sudo rm -rf neovim
fi
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout 9ad7529f705c883e13fba9a014696fb37318145f
mkdir build
cd build

# Build and install NeoVim
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew install luajit lua
else
    sudo apt-get install luajit lua
fi

sudo luarocks install lpeg
sudo luarocks install mpack
sudo luarocks install luabitop

cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j
sudo make install

sudo gem install neovim
# sudo gem upgrade neovim
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
