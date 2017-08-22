#!/usr/bin/env bash
set -euo pipefail

URL="https://github.com/vim/vim/archive"

# V.8.0.0979
SHA=eef0531621c8d4045d669eb815b051d925983df8
REV=8.0.0979

cd ~/Downloads
if [[ ! -e "${REV}.zip" ]]; then
    wget "${URL}/${SHA}.zip"
    mv "${SHA}.zip" "${REV}.zip"
fi

if [[ ! -e "vim-${REV}" ]]; then
    unzip "${REV}.zip"
    mv "vim-${SHA}" "vim-${REV}"
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
    +python \
    +python3

make
make install

vim_path="$(which vim)"
if [[ "${vim_path}" != "${HOME}/bin/vim" ]]; then
    echo "WARNING: This vim installation is not the current default."
else
    echo "SUCCESS."
fi
