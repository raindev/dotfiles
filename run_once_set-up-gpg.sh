#!/usr/bin/env bash

if ! gpg --list-key andrew@raindev.io >/dev/null; then
	echo '>setting up GPG'
	echo 'Insert the smartcard'
	read -r
	echo 'Fetch the public key'
	gpg --edit-card
	echo 'Set key trust level'
	gpg --edit-key andrew@raindev.io
fi
