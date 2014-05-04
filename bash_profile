# Greeting😊
echo Have a nice day😉

# Use brewed gems
export PATH=$(brew --prefix)/opt/ruby/bin:$PATH

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
alias history='history | less'
alias bru='brew update && brew upgrade'
# Git aliases
alias graph="git log --color --graph --pretty=format:'%Cred%h%Cgreen(%cr) -%C(yellow)%d%Creset %s %C(bold blue)<%an>' --abbrev-commit"
alias g='git'
alias v='vim'
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

# Git `g` alias autcompletion (stolen from this answer http://askubuntu.com/a/62098)
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
		    || complete -o default -o nospace -F _git g
