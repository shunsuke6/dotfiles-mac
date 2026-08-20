#!/bin/bash

# nounset, errexit, pipefail
set -euo pipefail

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

install_zinit() {
	local zinit_dir="${HOME}/.local/share/zinit"
	local zinit_home="${zinit_dir}/zinit.git"

	if [[ -r "${zinit_home}/zinit.zsh" ]]; then
		return
	fi

	if [[ -e "${zinit_home}" ]]; then
		echo "zinit installation is incomplete: ${zinit_home}" >&2
		return 1
	fi

	mkdir -p "${zinit_dir}"
	chmod g-rwX "${zinit_dir}"
	git clone https://github.com/zdharma-continuum/zinit "${zinit_home}"
}

install_rustup() {
	if [[ -r "${HOME}/.cargo/env" ]]; then
		return
	fi

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

dotfiles_or_dirs=(
	.Brewfile
	.zprofile
	.zshrc
	.zshrc.lazy
	.zshenv
	.tmux.conf
	.gitconfig
	.config/mise
	.config/nvim/init.lua
	.config/nvim/lua
	.config/nvim/ftplugin
	.config/ranger
	.config/alacritty/alacritty.toml
	bin/update-devtools.sh
	bin/update-ghcup.sh
	bin/update-java-debug.sh
	bin/update-kotlin-debug-adapter.sh
	bin/update-lsp-jdtls.sh
	bin/update-lsp-lombok.sh
	bin/update-lsp.sh
	bin/update-mise.sh
	bin/update-rustup.sh
	bin/update-vscode-firefox-debug.sh
	bin/update-vscode-java-test.sh
	bin/update-vscode-php-debug.sh
	bin/update-vscode.sh
	Gemfile
)

create_dotfile_links "${dotfiles_or_dirs[@]}"
install_zinit
install_rustup
