#!/usr/bin/env bash

# dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
dconf reset /org/gnome/desktop/input-sources/xkb-options
