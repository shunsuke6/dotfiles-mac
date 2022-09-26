#!/usr/bin/zsh

if ! command -v brew 1>/dev/null 2>&1; then
    print -P "%F{160} Homebrew not fond.%f"
    exit 0
fi

install(){
    brew update
    brew upgrade

    local brew_list=("${@}")

    for app in "${brew_list[@]}"; do
        if ! command -v $app 1>/dev/null 2>&1; then            print -P "%F{33} %F{220}Installing %F{33}%F{220}$app …%f"
            brew install $app && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} The clone has failed.%f"
        fi
    done 

    if command -v luarocks 1>/dev/null 2>&1; then
        if ! command -v luacheck 1>/dev/null 2>&1; then
            print -P "%F{33} %F{220}Installing %F{33}%F{220}luacheck …%f"
            luarocks install luacheck && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} Installation has failed.%f"
        fi
    fi
}
brew_list=(
    bashdb
    cmake
    codespell
    composer
    colordiff
    cppcheck
    deno
    fd
    fzf
    gawk
    gh
    google-java-format
    imagemagick
    jq
    llvm
    luarocks
    maven
    nginx
    openssh
    ranger
    ripgrep
    shfmt
    shellcheck
    source-highlight
    stylua
    sqlfluff
    tidy-html5
    tmux
)

install "${brew_list[@]}"
