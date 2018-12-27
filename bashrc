# Skip if not running interactively
[[ "$-" == *i* ]] || return

alias grep='grep --color=always'
alias gtypist='gtypist --personal-best --max-error=1'

# Enable CTRL-S for forward history search
# (overwrites suspension of terminal output)
stty -ixon

# Flush bash history after each command
export PROMPT_COMMAND='history -a'
export HISTSIZE=10000
HISTCONTROL=ignoredups

# Load machine-specific configuration
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
