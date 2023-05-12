#!/usr/bin/env bash

if [ ! -e "$HOME/.password-store" ]; then
	echo '>setting up pass'
	git clone git@github.com:raindev/passwords.git\
		"$HOME/.password-store"
	pass git init
fi
