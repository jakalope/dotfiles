#!/usr/bin/env bash

set -eou pipefail

cd ~/Downloads
if [[ ! -e v2.9.2.tar.gz ]]; then
    wget https://github.com/git/git/archive/v2.9.2.tar.gz
fi
gunzip -c v2.9.2.tar.gz | tar xvf -
cd git-2.9.2
make configure
./configure --prefix=/usr
make all doc info
sudo make install install-doc install-html install-info
git config --global core.excludesfile "${HOME}/dotfiles/global_gitignore"
