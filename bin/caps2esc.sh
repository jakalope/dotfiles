#!/usr/bin/env bash

sudo DEVNODE=0 /usr/bin/nice -n -20 /usr/local/bin/udevmon -c ~/dotfiles/udevmon.yaml &K
