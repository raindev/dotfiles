# Greeting😊
echo The dream has begun…

# Aliases
lsless() {
	ls -F "$@" | less
}
alias lsl=lsless
alias history='history | less'
alias bru='brew update && brew upgrade'
alias graph='git log --graph --all --decorate'

# Add some colors!
export CLICOLOR=1

# Autocompletion for Homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Java (set to use alias in Terminal instead of hardcoded path from launchd.conf)
export JAVA_HOME=$(/usr/libexec/java_home)

# Use Vi mode for navigation instead of Emacs
# set -o vi
