#!/usr/bin/env bash
set -euo pipefail

script_dir="$( builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
source "$(dirname "$script_dir")/worktree.sh"

WORKTREE_WORKTREE_ROOT=worktree_root
WORKTREE_PRIMARY_PROJECT=primary_project
WORKTREE_BRANCH_NAME_PREFIX=branch_name_prefix
WORKTREE_BRANCH_NAME_SUFFIX=branch_name_suffix
WORKTREE_BASE_BRANCH=base_branch
WORKTREE_REMOTE=remote
WORKTREE_ENVIRONMENT_ENTRYPOINT=entrypoint

[ "$(worktree_worktree_root)" == "$WORKTREE_WORKTREE_ROOT" ]
[ "$(worktree_primary_project)" == "$WORKTREE_PRIMARY_PROJECT" ]
[ "$(worktree_active_project)" == "$WORKTREE_PRIMARY_PROJECT" ]
[ "$(worktree_branch_name_prefix)" == "$WORKTREE_BRANCH_NAME_PREFIX" ]
[ "$(worktree_branch_name_suffix)" == "$WORKTREE_BRANCH_NAME_SUFFIX" ]
[ "$(worktree_base_branch)" == "$WORKTREE_BASE_BRANCH" ]
[ "$(worktree_remote)" == "$WORKTREE_REMOTE" ]
[ "$(worktree_environment_entrypoint)" == "$WORKTREE_ENVIRONMENT_ENTRYPOINT" ]
