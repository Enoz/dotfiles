#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source all files in ~/.bashrd.d
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

# Aliases
alias ls='ls --color=auto'
alias lg='lazygit'
alias grep='grep --color=auto'
PS1='(\[\e[38;5;45m\]${PWD}\[\e[0m\]) \$ '
export EDITOR="nvim"

# Load fzf shell integration if fzf is available
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

# Used for SSH Agent service
# systemctl --user enable ssh-agent.service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
