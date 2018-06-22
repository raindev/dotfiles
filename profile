# vim: filetype=sh

# Make Cargo binaries available
export PATH="$PATH:~/.cargo/bin"

# Use all available cores for xz compression
export XZ_DEFAULTS='--threads=0'

# Source local profile
[ -f ~/.profile.local ] && source ~/.profile.local

# Source bashrc for bash login sessions too
[ $BASH ] && [ -f ~/.bashrc ] && source ~/.bashrc
