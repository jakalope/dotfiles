# worktree

Utilities to create and manage git worktrees.

## Commands

### `worktree`

Usage: `worktree <project_name> [<base_branch>] [<remote>]`

Create a new worktree and configure the shell for a new project. This is the
same as calling `worktree_create` immediately followed by `worktree_resume`.

Both `base_branch` and `remote` will be inferred from variables described below,
but can be overridden if command-line arguments are provided.

### `worktree_create`

Usage: `worktree_create <project_name> [<base_branch>] [<remote>]`

Create a new worktree directory and branch for a new project.

Both `base_branch` and `remote` will be inferred from variables described below,
but can be overridden if command-line arguments are provided.

### `worktree_resume`

Usage: `worktree_resume <project_name>`

Configure the shell to develop an existing project.

## Variables

Invariants for `worktree` can be defined with several environment variables.
If these variables are not set default values will be used.

These variables can be defined before or after sourcing `worktree.sh`. They are
evaluated when you run the provided commands, not when first sourcing. This will
also allow you to change them whenever you want without needing to re-source.

* `WORKTREE_WORKTREE_ROOT`: The parent directory for all newly-created
  worktrees.
* `WORKTREE_PRIMARY_PROJECT`: The name of the primary project directory.
* `WORKTREE_BRANCH_NAME_PREFIX`: The string to prepend when generating the
  project branch name.
* `WORKTREE_BRANCH_NAME_SUFFIX`: The string to append when generating the
  project branch name.
* `WORKTREE_BASE_BRANCH`: The branch to base projects from.
* `WORKTREE_REMOTE`: The remote projects should track.
* `WORKTREE_ENVIRONMENT_ENTRYPOINT`: The shell-escaped command to execute when
  preparing a shell environment for a project.

`WORKTREE_ENVIRONMENT_ENTRYPOINT` will have access to any global environment
variables and functions you have set before running the provided commands, as
well as two local variables:

* `$project_name`: The name provided to `worktree` commands.
* `$project_directory`: The absolute path of the project worktree directory.

Additionally, the variable `WORKTREE_ACTIVE_PROJECT` will be set to the
specified project name before running the command stored in
`WORKTREE_ENVIRONMENT_ENTRYPOINT`. However, you should use the provided function
`worktree_active_project` (described below) to access this information.

## Functions

`worktree.sh` contains several helper-functions that calculate information
derived from the above variables. These functions can be used to help configure
your shell environment.

### Getters

* `worktree_worktree_root`: Get the effective value of the worktree root
  directory.
* `worktree_primary_project`: Get the effective name of the primary project.
* `worktree_active_project`: Get the effective name of the currently active
  project, defaulting to the primary project if there is no active project.
* `worktree_branch_name_prefix`: Get the effective string to prepend when
  generating project branch names.
* `worktree_branch_name_suffix`: Get the effective string to append when
  generating project branch names.
* `worktree_base_branch`: Get the effective name of the branch that projects are
  based from.
* `worktree_remote`: Get the effective name of the remote that projects are
  based from.
* `worktree_environment_entrypoint`: Get the effective shell-escaped command to
  execute when preparing a shell environment for a project.

### Composition

* `worktree_branch_name <project_name>`: Calculate the branch name for a
  project.
* `worktree_project_worktree <project_name>`: Calculate the worktree directory
  for a project.
* `worktree_primary_project_worktree`: Calculate the worktree directory for the
  primary project.
* `worktree_active_project_worktree`: Calculate the worktree directory for the
  active project.

## Example

### Shell RC

```
source /path/to/worktree.sh
export WORKTREE_WORKTREE_ROOT="$HOME/my-repo-name"
export WORKTREE_BRANCH_NAME_PREFIX="user/chpatton013/"
WORKTREE_ENVIRONMENT_ENTRYPOINT="builtin cd \"\$project_directory\""
WORKTREE_ENVIRONMENT_ENTRYPOINT+=" && tmux has-session -t \"\$project_name\" 2>/dev/null"
WORKTREE_ENVIRONMENT_ENTRYPOINT+=" && tmux attach -t \"\$project_name\""
WORKTREE_ENVIRONMENT_ENTRYPOINT+=" || tmux new -s \"\$project_name\""
export WORKTREE_ENVIRONMENT_ENTRYPOINT

source "$(worktree_active_project_worktree)/env.sh"
```

### Usage

```
worktree my-project
```
