#!/usr/bin/env bash

set -eou pipefail

# Build and install NeoVim
cd ~/Downloads
if [[ ! -e yapf.zip ]]; then
    wget -O yapf.zip https://github.com/jakalope/yapf/archive/master.zip
fi
unzip yapf.zip
cd yapf-master
python setup.py build
sudo python setup.py install
