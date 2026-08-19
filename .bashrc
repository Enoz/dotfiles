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

# Sandboxing

_sb_run() {
    podman run --rm -it \
        --userns=keep-id \
        -v "$PWD:/workspace" \
        -v agent-sandbox-local:/home/sb/.local \
        -w /workspace \
        localhost/agent-sandbox \
        bash
}

sb() {
    podman build -q \
        -f "$HOME/dotfiles/sandbox/Containerfile" \
        -t localhost/agent-sandbox \
        "$HOME/dotfiles" >/dev/null \
    && _sb_run
}

sb-fresh() {
    podman build \
        --no-cache \
        --pull=newer \
        -f "$HOME/dotfiles/sandbox/Containerfile" \
        -t localhost/agent-sandbox \
        "$HOME/dotfiles" \
    && _sb_run
}

# Used for SSH Agent service
# systemctl --user enable ssh-agent.service
# KeePassXC -> SSH_AUTH_SOCK override=/run/user/1000/ssh-agent.socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# no pip outside a venv
export PIP_REQUIRE_VIRTUALENV=true
