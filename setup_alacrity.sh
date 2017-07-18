#!/usr/bin/env bash

cd ~/Downloads
if [[ ! -d alacritty ]]; then
  git clone https://github.com/jwilm/alacritty.git
fi
cd alacritty
rustup override set nightly
cargo build --release
cp target/release/alacritty ~/bin
