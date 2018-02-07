#!/usr/bin/env bash
set -euo pipefail

script_dir="$( builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
source "$(dirname "$script_dir")/worktree.sh"

[ "$(worktree_branch_name project)" == "project" ]

WORKTREE_BRANCH_NAME_PREFIX=prefix_
WORKTREE_BRANCH_NAME_SUFFIX=_suffix
[ "$(worktree_branch_name project)" == "prefix_project_suffix" ]
