#!/bin/bash

function update_asdf_plugins() {
  set_global=$1
  shift

  if [ $# -lt 1 ]; then
    echo "Usage: $0 plugin1 plugin2 ... plugin"
    exit 1
  fi

  ESC=$(printf '\033')

  for PLUGIN in "$@"; do
    printf "${ESC}[1;36m%s${ESC}[m\n" "***** asdf $PLUGIN updating... *****"

    if ! command -v asdf 1>/dev/null 2>&1; then
      printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
      exit 1
    fi

    if ! asdf plugin-list | grep "$PLUGIN" 1>/dev/null 2>&1; then
      if asdf plugin-add "$PLUGIN"; then
        asdf global "$PLUGIN" system
        printf "${ESC}[1;32m%s${ESC}[m\n" "***** asdf $PLUGIN plugin installed (and set: asdf global $PLUGIN system). *****"
      else
        printf "${ESC}[1;31m%s${ESC}[m\n" "***** asdf $PLUGIN plugin install failed. *****"
        exit 2
      fi
    fi

    if asdf install "$PLUGIN" latest; then
      if [[ "$set_global" == "true" ]]; then
        asdf global "$PLUGIN" "$(asdf list "$PLUGIN" | grep '[0-9]\+' | tail -n 1 | xargs)"
        printf "${ESC}[1;32m%s${ESC}[m\n" "***** asdf $PLUGIN updated. *****."
      else
        printf "${ESC}[1;32m%s${ESC}[m\n" "***** asdf $PLUGIN updated (If you want to use latest: asdf local $PLUGIN [version]). *****."
      fi
    else
      printf "${ESC}[1;31m%s${ESC}[m\n" "***** asdf $PLUGIN update failed. *****"
      exit 3
    fi
  done
}
