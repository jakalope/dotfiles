#!/usr/bin/env bash

set -eou pipefail

# install brew
brew_url=https://raw.githubusercontent.com/Homebrew/install/master/install
/usr/bin/ruby -e "$(curl -fsSL ${brew_url})"

# install dependencies
brew update
brew cask install java
brew tap neovim/neovim
brew install "$(cat brew-package-list)"
python get-pip.py
pip install "$(cat pip-package-list)"

# Build and install the lastest version of Git
pushd ~/Downloads
if [[ ! -e v2.9.2.tar.gz ]]; then
    wget https://github.com/git/git/archive/v2.9.2.tar.gz
fi
gunzip -c v2.9.2.tar.gz | tar xvf -
pushd git-2.9.2
make configure
./configure --prefix=/usr
make all doc info
sudo make install install-doc install-html install-info
popd
popd

git config --global core.excludesfile "${HOME}/dotfiles/global_gitignore"

# Install neovim
./setup_neovim.sh

# Install yapf
./setup_yapf.sh

# install powerline fonts
pushd ~/Downloads
if [[ ! -e fonts ]]; then
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
fi
popd

# create backups
pushd ~/dotfiles
stamp=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p "${HOME}/backup/${stamp}"
echo "backing up old files to ~/backup/${stamp}..."

while read file
do
    if [[ -e "${HOME}/${file}" ]]; then
        mv "${HOME}/${file}" "${HOME}/backup/${stamp}/"
    fi
    ln --symbolic --target "${HOME}/.${file}" "$(pwd)/${file}"
done < home-files

popd

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
pushd ~/dotfiles/.vim/bundle/YouCompleteMe/
./install.py --clang-completer
popd
vim +PluginInstall +qall

