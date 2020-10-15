#!/bin/false
# vim: filetype=sh

# TODO avoid ~ (see 416070af2672eef196e9306b192f4ce09ead5bce)

# Make Cargo binaries available
[ -d "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"
# Store all Cargo build artifacts in one place
# This also allows reusing build results between projects
export CARGO_TARGET_DIR="$HOME/.cache/cargo/target"
# Relocate Rust toolchains to ~/.cache
export RUSTUP_HOME="$HOME/.cache/rustup"

# Include my scripts into PATH
[ -e "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"
# Include user executables into PATH (used by pip)
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"

export EDITOR=nvim
# Use all available cores for xz compression
export XZ_DEFAULTS='--threads=0'

# Source local profile
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

# Source bashrc for bash login sessions too
[ "$BASH" ] && [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
