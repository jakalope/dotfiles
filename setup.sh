#!/bin/bash

# install dependencies
sudo apt-get install mercurial vim-gtk cscope exuberant-ctags libevent-dev \
    chromium-browser xsel virtualbox-4.3 autoconf

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

# setup facebook's watchman
watchman_version=$(watchman --version)
if [[ $? != 0 ]]; then
    pushd watchman
    ./autogen.sh && ./configure && make
    sudo make install
    make clean
    rm -rf .deps/ Makefile Makefile.in aclocal.m4 autom4te.cache/ cmds/.deps/ \
            cmds/.dirstamp compile config.guess config.h config.h.in \
            config.log config.status config.sub configure depcomp files \
            install-sh missing query/.deps/ query/.dirstamp stamp-h1 \
            tests/.deps/ tests/.dirstamp thirdparty/.deps/ \
            thirdparty/.dirstamp thirdparty/jansson/.deps/ \
            thirdparty/jansson/.dirstamp \
            thirdparty/jansson/jansson_config.h watcher/.deps/ \
            watcher/.dirstamp
    popd
fi

pushd ~
stamp=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p $stamp
echo "backing up old files to ~/${stamp}..."
for file in ".astylerc .bashrc bin .gdbinit .gitconfig hg-prompt .hgignore .hgrc hgwatchman .hgext .rviz .tmux.conf .vim .vimrc"
do
    mv $file $stamp
done
popd

# setup symlinks
echo 'linking...'
ln --symbolic --target ${HOME} \
    $(pwd)/{.astylerc,.bashrc,bin,.gdbinit,.gitconfig,hg-prompt,.hgignore,.hgrc,hgwatchman,.hgext,.tmux.conf,.rviz,.vim,.vimrc}

# clone hg workspace
mkdir -p ~/workspace
pushd ~/workspace
if [[ ! -d pjfa ]]; then
    echo 'cloning...'
    ssh-copy-id pjfa.pal.us.bosch.com
    ssh-copy-id abthadrepo03.de.bosch.com
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/pjfa
    hg clone ssh://asj1pal@pjfa.pal.us.bosch.com///repos/utils
fi
popd

#echo "source $(pwd)/setup.sh" >> ~/.bashrc && . ~/.bashrc
