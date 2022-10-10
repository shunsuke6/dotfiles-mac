#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf gleam updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'gleam' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add gleagleamm; then
		asdf global gleam system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf gleam plugin installed (and set: asdf global golang system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf gleam plugin install failed. *****'
		exit 2
	fi
fi

(asdf install gleam latest &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf gleam updated (If you want to use latest: asdf local golang [version]). *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf gleam update failed. *****' &&
		exit 3)
