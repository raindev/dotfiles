# Skip if not running interactively
[[ "$-" == *i* ]] || return

alias grep='grep --color=always'
alias gtypist='gtypist --personal-best --max-error=1'
alias ls='ls --classify --color=auto'

# Enable CTRL-S for forward history search
# (overwrites suspension of terminal output)
stty -ixon

export HISTSIZE=10000
# Append history file when shell exits
shopt -s histappend

# Set terminal window title to user@host: workdir
export PS1="\[\e]0;\u@\h: \w\a\]$PS1"

# Enabled completion
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Load machine-specific configuration
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
