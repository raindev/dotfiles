#!/usr/bin/env bash
# vi: set ft=bash
set -e

if ! command -v brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install \
	bash-completion \
	exercism \
	gh \
	go \
	litecli \
	neovim \
	staticcheck \
	topgrade \
	watchexec
