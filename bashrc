# Skip if not running interactively
[[ "$-" == *i* ]] || return

alias grep='grep --color=always'
alias gtypist='gtypist --personal-best --max-error=1'

# Enable CTRL-S for forward history search
# (overwrites suspension of terminal output)
stty -ixon

export HISTSIZE=10000
# Append history file when shell exits
shopt -s histappend

# Enabled completion
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Load machine-specific configuration
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
