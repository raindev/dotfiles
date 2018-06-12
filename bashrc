# Solus requires explicit sourcing of the system profile
source /etc/profile

alias grep='grep --color=always'
alias gtypist='gtypist --personal-best --max-error=1'

# Enable CTRL-S for forward history search
# (overwrites suspension of terminal output)
stty -ixon

# Flush bash history after each command
export PROMPT_COMMAND='history -a'
export HISTSIZE=10000

# Use all available cores for xz compression
export XZ_DEFAULTS='--threads=0'

# Load machine-specific configuration
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
