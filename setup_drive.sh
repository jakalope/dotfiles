#!/usr/bin/env bash
set -euo pipefail

# Exit early if go isn't installed.
go version

go get -u github.com/odeke-em/drive/cmd/drive
