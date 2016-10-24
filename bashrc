# Paths
# -----
# Cabal-built Haskell binaries
export PATH=$HOME/Library/Haskell/bin:$PATH
# Cargo-installed binaries
export PATH=$HOME/.cargo/bin:$PATH
# Java (set to use alias in Terminal instead of hardcoded path from launchd.conf)
export JAVA_HOME=$(/usr/libexec/java_home)

# Aliases
# -------
# List in less
lsl() {
  ls -F "$@" | less
}
# List hidden files
ld() {
  ls -a "$@" | grep '^\.[^\.]'
}
t() {
  tree "$@" | less
}
alias ls='ls -F'
alias grep='grep -I --color=always'
alias hist='history | less'
alias du='du -h'
alias graph="git log --all --color --graph --pretty=format:'%Cred%h%Cgreen(%cr) -%C(yellow)%d%Creset %s %C(bold blue)<%an>' --abbrev-commit"
alias g='git'
alias v='vim'
alias c='cargo'
alias m='mvn --quiet'
alias cask='brew cask'
alias ping='ping -c 4'
alias ping6='ping6 -c 4'
alias gitk='gitk --all'
alias gw='gw --daemon'
alias rusti="rustup run nightly-2016-08-01 ~/.cargo/bin/rusti"
alias upgrade='softwareupdate --install --all;
               brew update && brew upgrade --all;
               brew cleanup; brew doctor;
               brew cask cleanup;
               npm update -g;
               echo "Fetching latest dotfiles ⇣";
               cd $HOME/.dotfiles;
               git pull && ./install;
               cd -'

# Shell configuration
# -------------------
# "Classic" prompt
export PS1="\u@\h:\W \$ "
# Add some colors!
export CLICOLOR=1
# Enable CTRL-S for forward history search
stty -ixon
# Show no weird replacements for controll characters in less
export LESS="-r"
# Flush history after each command
export PROMPT_COMMAND='history -a'
export HISTSIZE=10000

# Completion
# ---------
# Homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# `g` alias
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
        || complete -o default -o nospace -F _git g

# One location for all apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

. ~/.bashrc.local
