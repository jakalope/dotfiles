#!/usr/bin/env bash

set -eou pipefail

# install brew
./setup_brew.sh

# install dependencies
brew update
brew cask install java
brew install $(cat brew-package-list)
brew services start postgresql
brew link gettext
brew linkapps python3
sudo -H python get-pip.py
sudo -H pip install $(cat pip-package-list)
sudo -H pip3 install $(cat pip3-package-list)

# TODO install this dmg
# http://downloads.sourceforge.net/project/git-osx-installer/git-2.10.1-intel-universal-mavericks.dmg

./setup_yapf.sh
./setup_neovim.sh

# install powerline fonts
pushd ~/Downloads
if [[ ! -e fonts ]]; then
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
fi
popd

# create backups
./setup_symlinks.py

# setup workspace
mkdir -p ~/workspace

if [[ ! -e ~/.ssh/id_rsa ]]; then
    echo 'Looks like you need to run the following:'
    echo '  ssh-keygen -t rsa -b 4096 -C <email-address>'
    echo '  eval "$(ssh-agent -s)"'
    echo '  ssh-add ~/.ssh/id_rsa'
    echo 'See https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/ for more details'
fi

# Install vim plugins
vim +PluginInstall +qall
pushd ~/dotfiles/vim/bundle/YouCompleteMe/
./install.py --clang-completer
popd
vim +PluginInstall +qall

