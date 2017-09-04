#!/usr/bin/env bash
set -euo pipefail

URL="https://github.com/jakalope/vim/archive"

SHA=tmap
REV=tmap

cd ~/Downloads
if [[ ! -e "${REV}.zip" ]]; then
    wget "${URL}/${SHA}.zip"
    # mv "${SHA}.zip" "${REV}.zip"
fi

if [[ ! -e "vim-${REV}" ]]; then
    unzip "${REV}.zip"
    # mv "vim-${SHA}" "vim-${REV}"
fi

cd "vim-${REV}"
./configure \
    --with-features=huge \
    --enable-multibyte \
    --prefix=${HOME} \
    --enable-gui=gtk2 \
    --enable-cscope \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-rubyinterp=yes \
    --enable-terminal=yes \
    +clientserver \
    +python

make
make install

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim_path="$(which vim)"
if [[ "${vim_path}" != "${HOME}/bin/vim" ]]; then
    echo "WARNING: This vim installation is not the current default."
else
    echo "SUCCESS."
fi
