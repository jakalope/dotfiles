#!/usr/bin/env bash

set -eou pipefail

curl https://sh.rustup.rs -sSf | sh
cargo install rustfrt
