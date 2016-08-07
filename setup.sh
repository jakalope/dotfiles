#!/usr/bin/env bash

set -eou pipefail

# install dependencies
sudo add-apt-repository ppa:webupd8team/java      # oracle-java8-installer
sudo add-apt-repository ppa:kubuntu-ppa/backports # massif-visualizer
sudo apt-get update
sudo apt-get install -y \
    aptitude \
    asciidoc \
    autoconf \
    build-essential \
    chromium-browser \
    clang-3.6 \
    clang-format-3.6 \
    cmake \
    docbook2x \
    exuberant-ctags \
    g++ \
    gettext \
    gfortran \
    indicator-multiload \
    inotify-tools \
    kcachegrind \
    libcurl4-gnutls-dev \
    libevent-dev \
    libexpat1-dev \
    libssl-dev \
    libz-dev \
    massif-visualizer \
    mercurial \
    oracle-java8-installer \
    pkg-config \
    python-autopep8 \
    python-dev \
    python-pip \
    python3-dev \
    terminator \
    tree \
    ubuntu-restricted-extras \
    unity-tweak-tool \
    unzip \
    vim-gtk \
    wmctrl \
    xclip \
    xmlto \
    xsel \
    zip \
    zlib1g-dev


# Build and install the lastest version of Git
pushd ~/Downloads
wget https://github.com/git/git/archive/master.zip
unzip master.zip
pushd git-master
make configure
./configure --prefix=/usr
make all doc info
sudo make install install-doc install-html install-info

# run indicator multiload for the first time
indicator-multiload &

# setup bazel
pushd ~/Downloads
if [[ ! -e bazel_0.2.0-linux-x86_64.deb ]]; then
    wget https://github.com/bazelbuild/bazel/releases/download/0.2.0/bazel_0.2.0-linux-x86_64.deb
fi
sudo dpkg --install bazel_0.2.0-linux-x86_64.deb 
popd

# setup specific tmux version
if [[ ! -e tmux_1.8.orig.tar.gz ]]; then
    gunzip -c tmux_1.8.orig.tar.gz | tar xvf -
    pushd tmux-1.8
    ./configure
    make
    sudo make install
    popd
    rm -rf tmux-1.8
fi

# install powerline fonts
pushd ~/Downloads
if [[ ! -e fonts ]]; then
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    popd
fi

# create backups
pushd ~
stamp=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p backup/$stamp
echo "backing up old files to ~/backup/${stamp}..."
mv --force --verbose --target-directory  "backup/$stamp" .astylerc .bashrc bin .gdbinit .gdb .gitconfig hg-prompt .hgignore .hgrc .hgext .rviz .inputrc .tmux.conf .vim .vimrc .clang-format
popd

# setup symlinks
pushd ~/dotfiles
echo 'linking...'
ln --symbolic --target ${HOME} \
    $(pwd)/{.astylerc,.bashrc,bin,.clang-format,.gdbinit,.gdb,.gitconfig,hg-prompt,.hgignore,.hgrc,.hgext,.inputrc,.tmux.conf,.rviz,.vim,.vimrc}
popd

# clone hg workspace
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
