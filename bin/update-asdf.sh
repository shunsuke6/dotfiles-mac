#!/bin/bash

local_plugin_list=(
  dart
  deno
  dotnet
  elixir
  erlang
  gleam
  golang
  nodejs
  poetry
)
global_plugin_list=(
  flutter
  golangci-lint
  hadolint
  ktlint
  neovim
  ruby
)

source update-asdf-plugins.sh

update-asdf-self.sh &&
  update_asdf_plugins "false" "${local_plugin_list[@]}" &&
  update_asdf_plugins "true" "${global_plugin_list[@]}"
