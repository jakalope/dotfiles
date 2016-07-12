#!/bin/bash

# install dependencies
sudo add-apt-repository ppa:webupd8team/java      # oracle-java8-installer
sudo add-apt-repository ppa:kubuntu-ppa/backports # massif-visualizer
sudo apt-get update
sudo apt-get install \
    autoconf \
    build-essential \
    chromium-browser \
    clang-3.6 \
    clang-format-3.6 \
    cmake \
    g++ \
    gfortran \
    git \
    indicator-multiload \
    inotify-tools \
    kcachegrind \
    libevent-dev \
    massif-visualizer \
    mercurial \
    oracle-java8-installer \
    pkg-config \
    python-autopep8 \
    python-dev \
    python3-dev \
    terminator \
    tree \
    ubuntu-restricted-extras \
    unity-tweak-tool \
    unzip
    vim-gtk \
    wmctrl \
    xclip \
    xsel \
    zip \
    zlib1g-dev \

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
tmux_version=$(tmux -V)
if [[ $? != 0 || "${tmux_version}" != "tmux 1.8" ]]; then
    gunzip -c tmux_1.8.orig.tar.gz | tar xvf -
    pushd tmux-1.8
    ./configure
    make
    sudo make install
    popd
    rm -r tmux-1.8
fi

# install powerline fonts
pushd ~/Downloads
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
popd

# create backups
pushd ~
stamp=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p $stamp
echo "backing up old files to ~/${stamp}..."
for file in ".astylerc .bashrc bin .gdbinit .gdb .gitconfig hg-prompt .hgignore .hgrc .hgext .rviz .tmux.conf .vim .vimrc .clang-format"
do
    mv $file $stamp
done
popd

# setup symlinks
echo 'linking...'
ln --symbolic --target ${HOME} \
    $(pwd)/{.astylerc,.bashrc,bin,.clang-format,.gdbinit,.gdb,.gitconfig,hg-prompt,.hgignore,.hgrc,.hgext,.tmux.conf,.rviz,.vim,.vimrc}

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
pushd .vim/bundle/YouCompleteMe/
./install.py --clang-completer
popd
vim +PluginInstall +qall
