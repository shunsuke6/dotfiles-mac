#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

"${script_dir}/update-lsp-jdtls.sh"
"${script_dir}/update-lsp-lombok.sh"
