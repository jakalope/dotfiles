# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export TERM=screen-256color

echo Loading ~/.bashrc

# Get OS name
OS="$(uname -s)"

function set_title() {
    printf '\e]2;%s\a' "$*";
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend


# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=10000000
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color) color_prompt=yes;;
# esac

color_prompt=yes

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

function parse_git_branch {
    echo "[$(git rev-parse --abbrev-ref HEAD 2>/dev/null)]"
}

if [ "$color_prompt" = yes ]; then
    #export PS1='\u@\h:$(tty):\[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)\n$ '
    export PS1='\u@\h:\[\033[2;33m\]\w\[\033[0m\]$(parse_git_branch)\n$ '
else
    export PS1='\u@\h\w$(parse_git_branch)$ '
fi
# unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cm='catkin_make'
alias valgrind_check='valgrind --tool=memcheck --track-origins=yes --leak-check=full --show-reachable=yes'
alias cwd='pwd | xsel -ib'
alias gs='git status'
alias gc='git commit'
alias gd='git diff'
alias gf='git fetch -p && git prune'
alias ga='git add'
alias Src='source ~/.bashrc'
alias bbnc='bazel build --spawn_strategy=standalone --genrule_strategy=standalone'
alias btnc='bazel test --spawn_strategy=standalone --genrule_strategy=standalone'
alias kd='nvr -l "$(pbpaste)"'
alias jj='nvr -l'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [[ ! ${PATH} == *"${HOME}/bin"* ]]
then
    # Prepend, so my stuff gets used.
    export PATH="${HOME}/bin":${PATH}
fi

if [[ ! ${PATH} == *"${HOME}/.local/bin"* ]]
then
    export PATH=${PATH}:"${HOME}/.local/bin"
fi

if [[ -e "/opt/PostgreSQL/9.5/bin" && ! ${PATH} == *"/opt/PostgreSQL/9.5/bin"* ]]
then
    source /opt/PostgreSQL/9.5/pg_env.sh
fi

# use vi key bindings in bash
set -o vi

# set some development environment variables
export EDITOR=nvim
export WORKSPACE_DIR="${PWD}/"
export SOURCE_DIR="${WORKSPACE_DIR}"
export wcd="${WORKSPACE_DIR}"
alias wcd='cd "${wcd}"'

source ~/bin/source_me.bash

if [[ -e ${WORKSPACE_DIR}/scripts/shell/zooxrc.sh ]]; then
    source ${WORKSPACE_DIR}/scripts/shell/zooxrc.sh
fi


export CUDA_HOME=${HOME}/cuda
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="${HOME}/.cargo/bin:${PATH}"

if [[ "$XDG_RUNTIME_DIR" == "" ]]; then
    export XDG_RUNTIME_DIR="/tmp"
fi

if [[ ! ${PATH} == *"/usr/local/go/bin"* ]]
then
    export PATH=$PATH:/usr/local/go/bin
fi

set_title ${WORKSPACE_DIR}
register
if [[ "$SSH_AUTH_SOCK" == "" ]]; then
    eval "$(ssh-agent -s)"
    ssh-add
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source "$HOME/.cargo/env"
