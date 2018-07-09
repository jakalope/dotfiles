#!/usr/bin/env bash
set -euo pipefail

URL_PREFIX='ftp://sourceware.org/pub/gdb/releases'
FILENAME='gdb-8.1.tar.gz'
DIR='gdb-8.1'

cd ~/Downloads

if [ ! -e $FILENAME ]; then
    wget "$URL_PREFIX/$FILENAME"
fi

if [ ! -d $DIR ]; then
    gunzip -c $FILENAME | tar xvf -
fi

cd $DIR
./configure
make -j
sudo make install
