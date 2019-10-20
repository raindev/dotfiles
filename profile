# vim: filetype=sh

# Make Cargo binaries available
[ -d ~/.cargo/bin ] && export PATH="$PATH:$HOME/.cargo/bin"
# Store all Cargo build artifacts in one place
# This also allows reusing build results between projects
export CARGO_TARGET_DIR="$HOME/.cache/cargo"

# Include my scripts into PATH
[ -d ~/bin ] && export PATH="$PATH:~/bin"
# Include user executables into PATH (used by pip)
[ -d ~/.local/bin ] && export PATH="$PATH:$HOME/.local/bin"

export EDITOR=vim
# Use all available cores for xz compression
export XZ_DEFAULTS='--threads=0'

# Source local profile
[ -f ~/.profile.local ] && source ~/.profile.local

# Source bashrc for bash login sessions too
[ $BASH ] && [ -f ~/.bashrc ] && source ~/.bashrc
