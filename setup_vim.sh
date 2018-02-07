#!/usr/bin/env bash
set -euo pipefail

URL="https://github.com/vim/vim/archive"
SHA="v8.0.1111"
REV="8.0.1111"

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
make distclean
./configure \
    --prefix=${HOME} \
    --with-features=huge \
    --enable-cscope \
    --enable-gui=gtk2 \
    --enable-luainterp=yes \
    --enable-multibyte \
    --enable-perlinterp=yes \
    --enable-pythoninterp=yes \
    --enable-rubyinterp=yes \
    --enable-terminal=yes

make -j
make install

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim_path="$(which vim)"
if [[ "${vim_path}" != "${HOME}/bin/vim" ]]; then
    echo "WARNING: This vim installation is not the current default."
else
    vim +PlugInstall +qall
    echo "SUCCESS."
fi
