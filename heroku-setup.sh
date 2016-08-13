#!/usr/bin/env bash

cd ~/Downloads
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku login
mkdir -p ~/workspace/quirq
cd ~/workspace/quirq
heroku git:clone -a hidden-anchorage-47947
git remote add --master master github git@github.com:jakalope/quirq-backend.git
