#!/usr/bin/env bash
set -euo pipefail

script_dir="$( builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
source "$(dirname "$script_dir")/worktree.sh"

[ "$(worktree_worktree_root)" == "$WORKTREE_DEFAULT_WORKTREE_ROOT" ]
[ "$(worktree_primary_project)" == "$WORKTREE_DEFAULT_PRIMARY_PROJECT" ]
[ "$(worktree_active_project)" == "$WORKTREE_DEFAULT_PRIMARY_PROJECT" ]
[ "$(worktree_branch_name_prefix)" == "$WORKTREE_DEFAULT_BRANCH_NAME_PREFIX" ]
[ "$(worktree_branch_name_suffix)" == "$WORKTREE_DEFAULT_BRANCH_NAME_SUFFIX" ]
[ "$(worktree_base_branch)" == "$WORKTREE_DEFAULT_BASE_BRANCH" ]
[ "$(worktree_remote)" == "$WORKTREE_DEFAULT_REMOTE" ]
[ "$(worktree_environment_entrypoint)" == "$WORKTREE_DEFAULT_ENVIRONMENT_ENTRYPOINT" ]
