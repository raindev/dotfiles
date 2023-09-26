#!/usr/bin/env bash
# vi: set ft=bash
set -eu

if ! command -v brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew install \
	bash-completion \
	exa \
	exercism \
	fd \
	gh \
	go \
	hugo \
	litecli \
	neovim \
	npm \
	staticcheck \
	topgrade \
	tpm \
	watchexec
