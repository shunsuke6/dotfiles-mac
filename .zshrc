#!/usr/bin/zsh
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

#######################################
# Plugins
# brew
export PATH="/opt/homebrew/bin:$PATH"

# zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load plugins
zinit light zdharma-continuum/zinit-annex-as-monitor
zinit light zdharma-continuum/zinit-annex-bin-gem-node
zinit light zdharma-continuum/zinit-annex-patch-dl
zinit light zdharma-continuum/zinit-annex-rust
zinit light asdf-vm/asdf
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma/history-search-multi-word
zinit ice depth=1; zinit light romkatv/powerlevel10k

# load powerlevel10k
[[ ! -f $HOME/.p10k.zsh ]] || source ~/.p10k.zsh

######################################
# Environment variables
# basic
export LANG=ja_JP.UTF-8
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'
export PAGER=less
export EDITOR=nvim
export VISUAL=nvim

# bemenu
export BEMENU_BACKEND=curses
export BEMENU_OPTS='--scrollbar=autohide'

# poetry
[[ ! -d $HOME/bin/update-poetry.sh ]] || \
    source "$HOME/bin/update-poetry.sh"

# rustup
if [[ ! -d $HOME/.cargo ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} rust tool manager…%f"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
[[ ! -f $HOME/.cargo/env ]] || source "$HOME/.cargo/env"

[[ ! -f $HOME/.asdf/plugins/dotnet/set-dotnet-home.zsh ]] || \
    source "$HOME/.asdf/plugins/dotnet/set-dotnet-home.zsh"

#######################################
# Generics
# colors
autoload -Uz colors
colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# word delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# Completions
# asdf
fpath=(${ASDF_DIR}/completions $fpath)
. $HOME/.asdf/asdf.sh
# zfunc
[[ -d $HOME/.zfunc ]] || mkdir ~/.zfunc
if [[ ! -f $HOME/.zfunc/_poetry ]]; then
    print -P "%F{33} %F{220}Installing %F{33}poetry%F{220} completions…%f"
    poetry completions zsh > ~/.zfunc/_poetry && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
if [[ ! -f $HOME/.zfunc/_rustup ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} completions…%f"
    rustup completions zsh > ~/.zfunc/_rustup && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
if [[ ! -f $HOME/.zfunc/_cargo ]]; then
    print -P "%F{33} %F{220}Installing %F{33}cargo%F{220} completions…%f"
    ln -sf ~/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions/_cargo ~/.zfunc/_cargo && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
fpath+=~/.zfunc

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ignore parents (../)
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ps
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# Options
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob


########################################
# tmux
if [[ -z "$TMUX" && ! -z "$PS1" && $TERM_PROGRAM != "vscode" ]]; then
    PERCOL="fzf"
    ID="$(tmux list-sessions 2>/dev/null)"
    if [[ -z "$ID" ]]; then
        tmux new-session
    else
        CREATE_NEW_SESSION="Create New Session"
        ID="$ID\n${CREATE_NEW_SESSION}:"
        ID="`echo $ID | $PERCOL | cut -d: -f1`"
        if [[ "$ID" = "${CREATE_NEW_SESSION}" ]]; then
            tmux new-session
        elif [[ -n "$ID" ]]; then
            tmux attach-session -t "$ID"
        fi
    fi
fi

########################################
# lazy alias path
zinit lucid wait="0" atinit='source $HOME/.zshrc.local;source $HOME/.zshrc.lazy' for zdharma-continuum/null

########################################
# bindkey Mac
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey "[Z" reverse-menu-complete


########################################
#GPG
export GPG_TTY=$(tty)

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
