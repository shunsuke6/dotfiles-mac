#!/usr/bin/env bash

set -euo pipefail

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** mise tools updating... *****'

if ! command -v mise >/dev/null 2>&1; then
  printf "${ESC}[1;31m%s${ESC}[m\n" '***** mise NOT installed. *****' >&2
  exit 1
fi

mise self-update -y
mise install
mise upgrade

if command -v uv >/dev/null 2>&1; then
  mkdir -p "${HOME}/.zfunc"
  uv_completion=$(uv generate-shell-completion zsh)
  printf '%s\n' "${uv_completion}" >"${HOME}/.zfunc/_uv"
fi

printf "${ESC}[1;32m%s${ESC}[m\n" '***** mise tools updated. *****'
