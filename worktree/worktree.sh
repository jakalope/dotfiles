#
# Public API.
#

# Override-values for invariants. These should be customized by users.
#export WORKTREE_WORKTREE_ROOT=~/worktree
#export WORKTREE_PRIMARY_PROJECT=master
#export WORKTREE_BRANCH_NAME_PREFIX=
#export WORKTREE_BRANCH_NAME_SUFFIX=
#export WORKTREE_BASE_BRANCH=master
#export WORKTREE_REMOTE=origin
#export WORKTREE_ENVIRONMENT_ENTRYPOINT="echo Created worktree \$project_name at location \$project_dir"

# Default-values for invariants. These should not be modified.
export WORKTREE_DEFAULT_WORKTREE_ROOT=~/worktrees
export WORKTREE_DEFAULT_PRIMARY_PROJECT=master
export WORKTREE_DEFAULT_BRANCH_NAME_PREFIX=
export WORKTREE_DEFAULT_BRANCH_NAME_SUFFIX=
export WORKTREE_DEFAULT_BASE_BRANCH=master
export WORKTREE_DEFAULT_REMOTE=origin
export WORKTREE_DEFAULT_ENVIRONMENT_ENTRYPOINT="echo Created worktree \$project_name at location \$project_directory"

# Create a new worktree and prepare shell to develop within.
function worktree() {
  if [ $# -lt 1 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <project_name> [<base_branch>] [<remote>]"
    return 1
  fi

  local project_name; project_name="$1"
  local base_branch; base_branch="${2:-"$(worktree_base_branch)"}"
  local remote; remote="${3:-"$(worktree_remote)"}"
  readonly project_name base_branch remote

  worktree_create "$project_name" "$base_branch" "$remote"
  local exit_code=$?
  if [ "$exit_code" -ne 0 ]; then
    return "$exit_code"
  fi
  worktree_resume "$project_name"
}

# Create a new worktree.
function worktree_create() {
  if [ $# -lt 1 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <project_name> [<base_branch>] [<remote>]"
    return 1
  fi

  local project_name; project_name="$1"
  local base_branch; base_branch="${2:-"$(worktree_base_branch)"}"
  local remote; remote="${3:-"$(worktree_remote)"}"
  readonly project_name base_branch remote

  if [ -z "$project_name" ]; then
    echo Invalid project_name >&2
    return 1
  fi

  if [ -z "$base_branch" ]; then
    echo Invalid base_branch >&2
    return 1
  fi

  if [ -z "$remote" ]; then
    echo Invalid remote >&2
    return 1
  fi

  local branch_name
  branch_name="$(worktree_branch_name "$project_name")"
  readonly branch_name

  if [ -z "$branch_name" ]; then
    echo Failed to calculate branch_name >&2
    return 1
  fi

  local primary_worktree
  primary_worktree="$(worktree_primary_project_worktree)"
  readonly primary_worktree

  if [ -z "$primary_worktree" ]; then
    echo Failed to calculate primary_worktree >&2
    return 1
  fi

  local project_worktree
  project_worktree="$(worktree_project_worktree "$project_name")"
  readonly project_worktree

  if [ -z "$project_worktree" ]; then
    echo Failed to calculate project_worktree >&2
    return 1
  fi

  _worktree_create "$primary_worktree" "$project_worktree" "$branch_name" "$remote"
}

# Resume development within an existing worktree.
function worktree_resume() {
  if [ $# -lt 1 ] || [ $# -gt 1 ]; then
    echo "Usage: $0 <project_name>"
    return 1
  fi

  local project_name; project_name="$1"
  local project_worktree; project_worktree="$(worktree_project_worktree "$project_name")"
  readonly project_name project_worktree

  if [ -z "$project_worktree" ]; then
    echo Failed to calculate project_worktree >&2
    return 1
  fi

  _worktree_resume "$project_worktree" "$project_name"
}

# Accessors for invariants. Fallback to defaults if overrides are unset.
function worktree_worktree_root() {
  echo "${WORKTREE_WORKTREE_ROOT:-"$WORKTREE_DEFAULT_WORKTREE_ROOT"}"
}
function worktree_primary_project() {
  echo "${WORKTREE_PRIMARY_PROJECT:-"$WORKTREE_DEFAULT_PRIMARY_PROJECT"}"
}
function worktree_active_project() {
  echo "${WORKTREE_ACTIVE_PROJECT:-"$(worktree_primary_project)"}"
}
function worktree_branch_name_prefix() {
  echo "${WORKTREE_BRANCH_NAME_PREFIX:-"$WORKTREE_DEFAULT_BRANCH_NAME_PREFIX"}"
}
function worktree_branch_name_suffix() {
  echo "${WORKTREE_BRANCH_NAME_SUFFIX:-"$WORKTREE_DEFAULT_BRANCH_NAME_SUFFIX"}"
}
function worktree_base_branch() {
  echo "${WORKTREE_BASE_BRANCH:-"$WORKTREE_DEFAULT_BASE_BRANCH"}"
}
function worktree_remote() {
  echo "${WORKTREE_REMOTE:-"$WORKTREE_DEFAULT_REMOTE"}"
}
function worktree_environment_entrypoint() {
  echo "${WORKTREE_ENVIRONMENT_ENTRYPOINT:-"$WORKTREE_DEFAULT_ENVIRONMENT_ENTRYPOINT"}"
}

# Calculate the branch name for a project.
function worktree_branch_name() {
  if [ $# -ne 1 ]; then
    echo "Usage: $0 <project_name>" >&2
    return 1
  fi

  local project_name; project_name="$1";
  local branch_name_prefix; branch_name_prefix="$(worktree_branch_name_prefix)"
  local branch_name_suffix; branch_name_suffix="$(worktree_branch_name_suffix)"
  readonly project_name branch_name_prefix branch_name_suffix

  echo $branch_name_prefix$project_name$branch_name_suffix
}

# Calculate the worktree path for a project.
function worktree_project_worktree() {
  if [ $# -ne 1 ]; then
    echo "Usage: $0 <project_name>" >&2
    return 1
  fi

  local project_name; project_name="$1"; readonly project_name

  echo $(worktree_worktree_root)/$project_name
}

# Calculate the worktree path for the primary project.
function worktree_primary_project_worktree() {
  worktree_project_worktree "$(worktree_primary_project)"
}

# Calculate the worktree path for the active project.
function worktree_active_project_worktree() {
  worktree_project_worktree "$(worktree_active_project)"
}

#
# Private API.
#

# Create a new worktree for a project.
function _worktree_create() {
  if [ $# -ne 4 ]; then
    echo Missing args to $0 >&2
    return 1
  fi

  local primary_worktree; primary_worktree="$1"
  local project_worktree; project_worktree="$2"
  local branch_name; branch_name="$3"
  local remote; remote="$4"
  readonly primary_worktree project_worktree branch_name remote

  (
    set -e

    builtin cd "$primary_worktree"
    git fetch
    git worktree add -b "$branch_name" "$project_worktree" "$remote/$base_branch"
    git config "branch.$branch_name.remote" "$remote"
    git config "branch.$branch_name.merge" "refs/heads/$branch_name"
  )
}

# Prepare shell environment for a project worktree.
function _worktree_resume() {
  if [ $# -ne 2 ]; then
    echo Missing args to $0 >&2
    return 1
  fi

  local project_directory; project_directory="$1"
  local project_name; project_name="$2"
  readonly project_directory project_name

  export WORKTREE_ACTIVE_PROJECT="$project_name"
  eval $(worktree_environment_entrypoint)
}
