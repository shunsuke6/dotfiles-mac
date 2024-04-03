#!/bin/zsh

check_homebrew() {
  if ! command -v brew 1>/dev/null 2>&1; then
    print -P "%F{160} Homebrew not found.%f"
    exit 1
  fi
}

update_homebrew() {
  brew update
  brew upgrade
}

install_package() {
  local package_name="$1"
  local package_description="$2"

  if ! command -v "$package_name" 1>/dev/null 2>&1; then
    print -P "%F{33} %F{220}Installing %F{33}%F{220}$package_description …%f"
    brew install "$package_name" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The installation has failed.%f"
  fi
}

declare -A packages=(
  ["bashdb"]="Bash debugger"
  ["cmake"]="Cross-platform make"
  ["codespell"]="Spell checker for source code"
  ["composer"]="Dependency manager for PHP"
  ["colordiff"]="Color-highlighted diff"
  ["cppcheck"]="Static analysis tool for C/C++"
  ["fd"]="Fast and user-friendly alternative to find"
  ["fzf"]="Command-line fuzzy finder"
  ["gawk"]="GNU awk"
  ["gh"]="GitHub CLI"
  ["google-java-format"]="Java code formatter"
  ["imagemagick"]="Image manipulation library"
  ["jq"]="Command-line JSON processor"
  ["llvm"]="Next-gen compiler infrastructure"
  ["luarocks"]="Package manager for Lua"
  ["maven"]="Build automation tool for Java"
  ["nginx"]="Web server"
  ["openssh"]="Secure shell client and server"
  ["ranger"]="File manager with VI key bindings"
  ["ripgrep"]="Line-oriented search tool"
  ["shfmt"]="Shell script formatter"
  ["shellcheck"]="Shell script static analysis tool"
  ["source-highlight"]="Syntax highlighter"
  ["stylua"]="Opinionated Lua code formatter"
  ["sqlfluff"]="SQL linter and auto-formatter"
  ["tidy-html5"]="HTML5 syntax checker and pretty printer"
  ["tmux"]="Terminal multiplexer"
)

check_homebrew
update_homebrew

for package_name in "${(k)packages[@]}"; do
  package_description="${packages[$package_name]}"
  install_package "$package_name" "$package_description"
done
