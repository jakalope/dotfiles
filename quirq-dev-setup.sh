#!/usr/bin/env bash

set -eou pipefail

sudo pip install --upgrade pytz twilio six httplib2

pushd ~/Downloads
if [[ ! -e google-cloud-sdk-120.0.0-linux-x86_64.tar.gz ]]; then
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-120.0.0-linux-x86_64.tar.gz
fi
gunzip -c google-cloud-sdk-120.0.0-linux-x86_64.tar.gz | tar xvf -
pushd google-cloud-sdk
./install.sh
popd
popd
gcloud components install gcd-emulator
gcloud components install beta
gcloud components install app-engine-python

mkdir -p ~/workspace/quirq
cd ~/workspace/quirq
gcloud init
gcloud beta auth application-default login
