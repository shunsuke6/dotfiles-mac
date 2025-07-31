#!/bin/bash

# nounset, errexit
set -ue

create_backup_dir() {
  local backupdir="${HOME}/.dotbackup"

  if [[ ! -d "${backupdir}" ]]; then
    mkdir "${backupdir}"
  fi

  echo "${backupdir}"
}

create_link() {
  local srcfile_or_dir="${1}"
  local dstfile_or_dir="${2}"
  local backupdir="${3}"

  local dstdir
  dstdir="$(dirname "${dstfile_or_dir}")"
  local backupfile_or_dir="${backupdir}/${dstfile_or_dir}"
  local backupdir
  backupdir="$(dirname "${backupfile_or_dir}")"

  if [[ -e "${dstfile_or_dir}" && ! -L "${dstfile_or_dir}" ]]; then
    if [[ ! -e "${backupdir}" ]]; then
      mkdir -p "${backupdir}"
    fi
    mv "${dstfile_or_dir}" "${backupdir}"
  fi

  if [[ ! -e "${dstdir}" ]]; then
    mkdir -p "${dstdir}"
  fi
  ln -snf "${srcfile_or_dir}" "${dstfile_or_dir}"
}

create_dotfile_links() {
  local dotfiles_or_dirs=("${@}")

  local srcdir
  srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

  local backupdir
  backupdir=$(create_backup_dir)

  for dotfile_or_dir in "${dotfiles_or_dirs[@]}"; do
    local srcfile_or_dir="${srcdir}/${dotfile_or_dir}"
    local dstfile_or_dir="${HOME}/${dotfile_or_dir}"

    create_link "${srcfile_or_dir}" "${dstfile_or_dir}" "${backupdir}"
  done
}

dotfiles_or_dirs=(
  .alacritty.yml
  .zprofile
  .zshrc
  .zshrc.lazy
  .zshenv
  .tmux.conf
  .gitconfig
  .default-gems
  .default-golang-pkgs
  .default-npm-packages
  .config/nvim/init.lua
  .config/nvim/lua
  .config/nvim/ftplugin
  .config/ranger
  bin/update-asdf-plugins.sh
  bin/update-asdf-self.sh
  bin/update-asdf.sh
  bin/update-devtools.sh
  bin/update-dotnet-core-tools.sh
  bin/update-ghcup.sh
  bin/update-java-debug.sh
  bin/update-kotlin-debug-adapter.sh
  bin/update-lsp-jdtls.sh
  bin/update-lsp-lombok.sh
  bin/update-lsp.sh
  bin/update-poetry.sh
  bin/update-rustup.sh
  bin/update-vscode-chrome-debug.sh
  bin/update-vscode-firefox-debug.sh
  bin/update-vscode-java-test.sh
  bin/update-vscode-node-debug2.sh
  bin/update-vscode-php-debug.sh
  bin/update-vscode.sh
  Gemfile
)

create_dotfile_links "${dotfiles_or_dirs[@]}"
