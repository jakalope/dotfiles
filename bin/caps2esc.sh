#!/usr/bin/env bash

sudo ls >/dev/null
sudo DEVNODE=0 /usr/bin/nice -n -20 /usr/local/bin/udevmon -c ~/dotfiles/udevmon.yaml &
