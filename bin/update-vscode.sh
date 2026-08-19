#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

"${script_dir}/update-vscode-firefox-debug.sh"
"${script_dir}/update-vscode-php-debug.sh"
"${script_dir}/update-java-debug.sh"
"${script_dir}/update-vscode-java-test.sh"
"${script_dir}/update-kotlin-debug-adapter.sh"
