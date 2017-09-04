#!/usr/bin/env bash

add_ppa() {
    for i in "$@"; do
        grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
        if [ $? -ne 0 ]
        then
            echo "Adding ppa:$i"
            sudo add-apt-repository -y ppa:$i
        else
            echo "ppa:$i already exists"
        fi
    done
}

# install dependencies
# oracle-java8-installer # massif-visualizer
add_ppa webupd8team/java kubuntu-ppa/backports neovim-ppa/stable

# set -eou pipefail

sudo apt-get update
sudo apt-get install -y $(cat apt-package-list)
sudo apt-get remove python3-pip; sudo apt-get install python3-pip
sudo pip install --upgrade neovim
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim
sudo pip install $(cat pip-package-list)
sudo pip3 install $(cat pip3-package-list)

git config --global core.excludesfile "${HOME}/dotfiles/global_gitignore"

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

./setup_neovim.sh
./setup_yapf.sh
./setup_tmux.sh
./setup_rust.sh
#./setup_alacrity.sh

# run indicator multiload for the first time
indicator-multiload &

# setup bazel
pushd ~/Downloads
if [[ ! -e bazel_0.2.0-linux-x86_64.deb ]]; then
    wget https://github.com/bazelbuild/bazel/releases/download/0.2.0/bazel_0.2.0-linux-x86_64.deb
fi
sudo dpkg --install bazel_0.2.0-linux-x86_64.deb
popd

# create backups
./setup_symlinks.py

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
pushd ~/dotfiles/vim/bundle/command-t/ruby/command-t/ext/command-t
make clean
ruby extconf.rb
make
popd
vim +PluginInstall +qall
