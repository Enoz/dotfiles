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

sb() {
    bwrap \
        --unshare-all \
        --share-net \
        --die-with-parent \
        --clearenv \
        \
        --ro-bind /usr /usr \
        --ro-bind /etc /etc \
        --ro-bind /var /var \
        --ro-bind-try /opt /opt \
        --symlink usr/bin /bin \
        --symlink usr/bin /sbin \
        --symlink usr/lib /lib \
        --symlink usr/lib /lib64 \
        \
        --proc /proc \
        --dev /dev \
        --tmpfs /tmp \
        --tmpfs /run \
        \
        --dir /home \
        --dir "$HOME" \
        \
        --bind "$PWD" "$PWD" \
        --bind "$HOME/.pi" "$HOME/.pi" \
        \
        --ro-bind "$HOME/.config/nvim" "$HOME/.config/nvim" \
        --bind-try "$HOME/.local/share/nvim" "$HOME/.local/share/nvim" \
        --bind-try "$HOME/.local/state/nvim" "$HOME/.local/state/nvim" \
        --bind-try "$HOME/.cache/nvim" "$HOME/.cache/nvim" \
        \
        --setenv HOME "$HOME" \
        --setenv USER "$USER" \
        --setenv LOGNAME "$USER" \
        --setenv SHELL /bin/bash \
        --setenv TERM "${TERM:-xterm-256color}" \
        --setenv PATH "/usr/local/bin:/usr/bin:/bin" \
        \
        --chdir "$PWD" \
        bash
}

# Used for SSH Agent service
# systemctl --user enable ssh-agent.service
# KeePassXC -> SSH_AUTH_SOCK override=/run/user/1000/ssh-agent.socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# no pip outside a venv
export PIP_REQUIRE_VIRTUALENV=true
