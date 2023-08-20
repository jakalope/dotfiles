#!/usr/bin/env bash
set -euo pipefail

sudo apt install \
	neovim \
	git

git clone git@github.com:jakalope/dotfiles.git ~/dotfiles
