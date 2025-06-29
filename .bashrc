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
alias f='cd $(fd --type directory | fzf)'
alias dsa='docker kill $(docker ps -q) && docker container prune -f'
alias s="kitten ssh"
PS1='(\[\e[38;5;45m\]${PWD}\[\e[0m\]) \$ '
export EDITOR="nvim"
