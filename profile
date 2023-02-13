#!/bin/false
# vim: filetype=sh

# Make Cargo binaries available
[ -d "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"
# Store all Cargo build artifacts in one place
# This also allows reusing build results between projects
export CARGO_TARGET_DIR="$HOME/.cache/cargo/target"
# Relocate Rust toolchains to ~/.cache
export RUSTUP_HOME="$HOME/.cache/rustup"

# Move GOPATH out of sight
export GOPATH="$HOME/.cache/go"

# Include my scripts into PATH
[ -e "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"
[ -e "$HOME/code/scripts" ] && export PATH="$PATH:$HOME/code/scripts"
[ -e "$HOME/code/env" ] && export PATH="$PATH:$HOME/code/env"
# Include user executables into PATH (used by pip)
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"

export EDITOR=nvim
# Use all available cores when possible
export XZ_DEFAULTS='--threads=0'
export ZSTD_COMPRESS="--threads=0"
cores=$(nproc)
export MAKEFLAGS="-j$cores"

# Source local profile
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

# Source bashrc for bash login sessions too
[ "$BASH" ] && [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
