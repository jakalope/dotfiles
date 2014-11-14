#!/bin/bash

cd ${HOME}/workspace/${WORKSPACE}/$(dirname $1)
while [[ ! -f manifest.xml && $(pwd) != "/" ]]
do
    cd ..
done

make clean && CXX="${HOME}/.vim/bundle/clang_complete/bin/cc_args.py /usr/bin/c++" make && mv build/.clang_complete ./
