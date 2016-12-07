#!/usr/bin/env bash

set -eou pipefail

while read line
do
  sed "$@" "$line"
done
