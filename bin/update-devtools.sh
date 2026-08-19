#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

"${script_dir}/update-mise.sh"
"${script_dir}/update-ghcup.sh"
"${script_dir}/update-rustup.sh"
"${script_dir}/update-vscode.sh"
"${script_dir}/update-lsp.sh"
