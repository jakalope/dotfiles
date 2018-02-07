#!/usr/bin/env bash
set -euo pipefail
set -x

script_dir="$( builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
source "$(dirname "$script_dir")/worktree.sh"

[ "$(worktree_project_worktree project)" == ~/worktrees/project ]
[ "$(worktree_primary_project_worktree)" == ~/worktrees/master ]
[ "$(worktree_active_project_worktree)" == ~/worktrees/master ]

WORKTREE_WORKTREE_ROOT=/worktrees
[ "$(worktree_project_worktree project)" == "/worktrees/project" ]
[ "$(worktree_primary_project_worktree)" == "/worktrees/master" ]
[ "$(worktree_active_project_worktree)" == "/worktrees/master" ]

WORKTREE_PRIMARY_PROJECT=primary
[ "$(worktree_project_worktree project)" == "/worktrees/project" ]
[ "$(worktree_primary_project_worktree)" == "/worktrees/primary" ]
[ "$(worktree_active_project_worktree)" == "/worktrees/primary" ]

WORKTREE_ACTIVE_PROJECT=active
[ "$(worktree_project_worktree project)" == "/worktrees/project" ]
[ "$(worktree_primary_project_worktree)" == "/worktrees/primary" ]
[ "$(worktree_active_project_worktree)" == "/worktrees/active" ]
