#!/usr/bin/env bash

set -eou pipefail

cd /tmp
if [[ -d neovim ]]; then
    sudo rm -rf neovim
fi
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout 6d2c30daf3b29b84b15b547ef956e165f5e9685d

# Build and install NeoVim
if [[ "$(uname -s)" == "Darwin" ]]; then
    brew install luajit lua
    sudo luarocks install lpeg
    sudo luarocks install mpack
    sudo luarocks install luabitop
else
    # sudo apt-get install libuv-dev libmsgpack-dev
    mkdir .deps ; cd .deps
    cmake ../third-party
    make
    cd ..
fi

mkdir build
cd build
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
