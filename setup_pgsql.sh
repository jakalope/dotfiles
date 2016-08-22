#!/usr/bin/env bash

set -eou pipefail

cd ~/Downloads
FILE=postgresql-9.5.4-1-linux-x64.run
URL="http://get.enterprisedb.com/postgresql/$FILE"
if [[ ! -e "$FILE" ]]; then
    wget "$URL"
fi
chmod +x "$FILE"
sudo "./$FILE"

