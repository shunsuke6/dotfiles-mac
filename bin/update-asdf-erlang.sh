#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf erlang updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'erlang' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add erlan; then
		asdf global erlang system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf erlang plugin installed (and set: asdf global golang system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf erlang plugin install failed. *****'
		exit 2
	fi
fi

(asdf install erlang latest &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf erlang updated (If you want to use latest: asdf local golang [version]). *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf erlang update failed. *****' &&
		exit 3)
