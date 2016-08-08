#!/usr/bin/env bash

wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku login
mkdir -p ~/workspace/quirq
cd ~/workspace/quirq
heroku git:clone -a hidden-anchorage-47947
