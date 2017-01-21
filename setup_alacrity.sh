#!/usr/bin/env bash

cd ~/Downloads
git clone https://github.com/jwilm/alacritty.git
cd alacrity
rustup override set nightly
cargo build --release
cp target/release/alacrity ~/bin
