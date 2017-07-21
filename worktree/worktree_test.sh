#!/usr/bin/env bash
set -euo pipefail
set -x

script_dir="$( builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

source "$script_dir/worktree.sh"

env --ignore-environment "$script_dir/tests/getter_defaults.sh"
env --ignore-environment "$script_dir/tests/getter_overrides.sh"
env --ignore-environment "$script_dir/tests/branch_name.sh"
env --ignore-environment "$script_dir/tests/worktree_directory.sh"

# TODO: worktree_create, worktree_resume, worktree, travis
