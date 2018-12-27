#!/usr/bin/env bash
set -euo pipefail

ARCHIVE='go1.10.3.linux-amd64.tar.gz'
URL="https://dl.google.com/go/$ARCHIVE"

cd ~/Downloads
if [[ ! -e "$ARCHIVE" ]]; then
    wget "$URL"
fi

gunzip -c "$ARCHIVE" | tar xvf -
sudo rm -rf /usr/bin/go || true
sudo rm -rf /usr/local/bin/go || true
sudo mv go /usr/local/
