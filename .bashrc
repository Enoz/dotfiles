#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias lg='lazygit'
alias grep='grep --color=auto'
alias f='cd $(fd --type directory | fzf)'
PS1='(\[\e[38;5;45m\]${PWD}\[\e[0m\]) \$ '

export EDITOR="nvim"
