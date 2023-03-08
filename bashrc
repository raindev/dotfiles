# Skip if not running interactively
[[ "$-" == *i* ]] || return

alias grep='grep --color=always'
alias gtypist='gtypist --personal-best --max-error=1'
alias ls='exa --classify'
alias t='tmux attach || tmux new'
alias up='configure'
if ! command -v fd > /dev/null && command -v fdfind > /dev/null ; then
    alias fd='fdfind'
fi

# Enable CTRL-S for forward history search
# (overwrites suspension of terminal output)
stty -ixon

export HISTSIZE=10000
# Append history file when shell exits
shopt -s histappend
# Display ANSI color escape characters in less
export LESS="--RAW-CONTROL-CHARS"

# Load Git helper function and customize repository prompt
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] \
    && source /usr/share/git-core/contrib/completion/git-prompt.sh
[ -f /run/current-system/sw/share/bash-completion/completions/git-prompt.sh ] \
    && source /run/current-system/sw/share/bash-completion/completions/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1 # +/*
export GIT_PS1_SHOWSTASHSTATE=1 # $
export GIT_PS1_SHOWUNTRACKEDFILES=1 # %
export GIT_PS1_SHOWUPSTREAM=auto
# Color the classic (user@host:workdir$) prompt
# 032   - green
# 034   - blue
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " [%s]") \$ '
# Set terminal window title to user@host: workdir
export PS1="\[\e]0;\u@\h: \w\a\]$PS1"

# Enable completion
[ -f /etc/bash_completion ] && source /etc/bash_completion
# Enable Cargo completion
command -v rustup &> /dev/null && source <(rustup completions bash cargo)
command -v rustup &> /dev/null && source <(rustup completions bash rustup)

# Tell GPG pinentry where to prompt for password
export GPG_TTY=$(tty)

source ~/.bash_functions

# Load machine-specific configuration
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
