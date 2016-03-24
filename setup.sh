#!/bin/bash

# install dependencies
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install \
	git \
	mercurial \
	vim-gtk \
	libevent-dev \
	chromium-browser \
	xsel \
	xclip \
	autoconf \
	gfortran \
	ubuntu-restricted-extras \
	clang-3.6 \
	clang-format-3.6 \
	oracle-java8-installer \
	python-dev \
	python3-dev \
	build-essential \
	cmake \
    indicator-multiload \
    unity-tweak-tool

# run indicator multiload for the first time
indicator-multiload &

# build YouCompleteMe
pushd .vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer
popd

# setup bazel
pushd ~/Downloads
wget https://github.com/bazelbuild/bazel/releases/download/0.2.0/bazel-0.2.0-installer-linux-x86_64.sh
sudo bash bazel-0.2.0-installer-linux-x86_64.sh
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
    $(pwd)/{.astylerc,.bashrc,bin,.gdbinit,.gdb,.gitconfig,hg-prompt,.hgignore,.hgrc,.hgext,.tmux.conf,.rviz,.vim,.vimrc}
cp $(pwd)/.clang-format ${HOME}

# clone hg workspace
mkdir -p ~/workspace

if [[ ! -e ~/.ssh/id_rsa ]]; then
    echo 'Looks like you need to run the following:'
    echo '  ssh-keygen -t rsa -b 4096 -C <email-address>'
    echo '  eval "$(ssh-agent -s)"'
    echo '  ssh-add ~/.ssh/id_rsa'
    echo 'See https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/ for more details'
fi

