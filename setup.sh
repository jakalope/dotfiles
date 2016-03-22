#!/bin/bash

# install dependencies
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install \
	git \
	mercurial \
	vim-gtk \
	cscope \
	exuberant-ctags \
	libevent-dev \
	chromium-browser \
	xsel \
	xclip \
	autoconf \
	python-catkin-tools \
	gfortran \
	ubuntu-restricted-extras \
	clang-3.6 \
	clang-format-3.6 \
	global \
	oracle-java8-installer \
	python-dev \
	python3-dev \
	build-essential \
	cmake 

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
cd workspace

