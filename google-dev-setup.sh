#!/usr/bin/env bash

set -eou pipefail

pushd ~/Downloads
if [[ ! -e google-cloud-sdk-120.0.0-linux-x86_64.tar.gz ]]; then
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-120.0.0-linux-x86_64.tar.gz
fi

if [[ ! -e google_appengine_1.9.40.zip ]]; then
    wget https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.40.zip 
fi

gunzip -c google-cloud-sdk-120.0.0-linux-x86_64.tar.gz | tar xvf -
mv google-cloud-sdk ~/
pushd ~/google-cloud-sdk
#./install.sh    # I don't need this b/c its already in my bashrc.
popd

unzip google_appengine_1.9.40.zip
mv google_appengine ~/
pushd ~/google_appengine

popd
gcloud components install gcd-emulator
gcloud components install beta
gcloud components install app-engine-python

mkdir -p ~/workspace/quirq
cd ~/workspace/quirq
gcloud init
gcloud beta auth application-default login
pip install -t lib -r requirements.txt
