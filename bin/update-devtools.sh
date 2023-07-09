#!/bin/bash

update-asdf.sh &&
  update-dotnet-tools.sh &&
  update-poetry.sh &&
  update-ghcup.sh &&
  update-rustup.sh &&
  update-vscode.sh &&
  update-lsp.sh
