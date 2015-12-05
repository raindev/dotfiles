# Use brewed gems
export PATH=$(brew --prefix)/opt/ruby/bin:$PATH

# Link Cabal-built Haskell binaries
export PATH=$HOME/Library/Haskell/bin:$PATH

# Cargo-installed binaries
export PATH=$HOME/.cargo/bin:$PATH

export GOPATH=$HOME/go
# Use Go compiled binaries
export PATH=$GOPATH/bin:$PATH

# Aliases
lsl() {
  ls -F "$@" | less
}
alias lsl=lsl
# List hidden files
ld() {
  ls -a "$@" | grep '^\.[^\.]'
}
alias ld=ld
DOTFILES=$HOME/.dotfiles
alias upgrade='softwareupdate --install --all;
               brew update && brew upgrade --all;
               brew cleanup; brew doctor;
               brew cask cleanup;
               npm update -g;
               echo "Fetching latest dotfiles ⇣";
               git --git-dir=$DOTFILES/.git --work-tree=$HOME/.dotfiles pull && cd $DOTFILES && ./install;
               cd -'
alias grep='grep -I --color=always'
alias hist='history | less'
alias du='du -h'
export PROMPT_COMMAND='history -a'
export HISTSIZE=1000
# Git aliases
alias graph="git log --all --color --graph --pretty=format:'%Cred%h%Cgreen(%cr) -%C(yellow)%d%Creset %s %C(bold blue)<%an>' --abbrev-commit"

alias g='git'
alias v='vim'
alias m='mvn --quiet'
alias cask='brew cask'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
alias ping='ping -c 4'
alias ping6='ping6 -c 4'
alias gitk='gitk --all'
alias gw='gw --daemon'
alias racketi='racket -il xrepl'

# Add some colors!
export CLICOLOR=1

# Show no weird replacements for controll characters in less
export LESS="-r"

# Autocompletion for Homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Java (set to use alias in Terminal instead of hardcoded path from launchd.conf)
export JAVA_HOME=$(/usr/libexec/java_home)

# Android SDK home
export ANDROID_HOME=/usr/local/opt/android-sdk

# Use Vi mode for navigation instead of Emacs
# set -o vi

# Git `g` alias autcompletion (stolen from this answer http://askubuntu.com/a/62098)
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
        || complete -o default -o nospace -F _git g

# Local configuration
[ -f ~/.bash_profile.local ] && source ~/.bash_profile.local

# Enable CTRL-S for forward history search
stty -ixon

# "Classic" prompt
export PS1="\u@\h:\W \$ "
