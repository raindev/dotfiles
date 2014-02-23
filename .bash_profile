# Greeting😊
echo Have a nice day😉

# Aliases
lsless() {
	ls -F "$@" | less
}
alias lsl=lsless
alias history='history | less'
alias bru='brew update && brew upgrade'
alias graph='git log --graph --all --decorate'
alias g='git'
# Gradle wrapper runner script (https://gist.github.com/dougborg/4278116)
alias gw='/Users/rain/gradlew.sh'	

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
