#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** poetry updating... *****'
source update-asdf-plugins.sh

(update-asdf-self.sh &&
  update_asdf_plugins "true" "poetry" &&
  poetry completions zsh >~/.zfunc/_poetry &&
  printf "${ESC}[1;32m%s${ESC}[m\n" '***** poetry updated. *****.' &&
  exit 0) ||
  (printf "${ESC}[1;31m%s${ESC}[m\n" '***** poetry update failed. *****' &&
    exit 2)
