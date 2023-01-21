[[日本語](https://github.com/shunsuke6/dotfiles-mac/wiki/README-%E6%97%A5%E6%9C%AC%E8%AA%9E)]

# dotfiles

my dotfiles for command-line interface on Mac Book.

I use Alacritty.

We have just migrated and have it in working order,
but there may be some things that do not work well that are problematic.

We will fix them as we go along.

## overview

![oerverview](https://user-images.githubusercontent.com/84017923/192322032-133ed1bd-316a-4547-9138-afbb187ec85c.png)

### contents

- neovim plugins(lua)
- tmux
- zsh
- zinit
- Alacritty
- asdf

## how to install

## depend on

- git
- curl
- wget
- homebrew
- neovim

### packer install

```bash
cd ~
git clone --depth 1 https://github.com/wbthomason/packer.nvim /
~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### git clone

```bash
git clone https://github.com/shunsuke6/dotfiles-mac.git .dotfiles
```

### change gitcongfig

```bash
cd .dotfiles
vi .gitconfig
  email = <your email address>
  name = <your user name>
```

### edit localization

- language

```bash
vi .zshrc
  export lang=ja_jp.utf-8`
  # change your locale
```

- datetime

```bash
vi .config/nvim/lua/plugins/sidebar.lua
  format = "%b %d日 (%a) %h:%m"`
  # change your locale
```

### install

make dotfiles directory

```bash
./install.sh
```

Install the required applications manually or automatically.

If you are not using zsh, run `chsh -s /usr/bin/zsh`

For automatic installation, run `app-install.sh`.

For a list of applications, look [here](#app-install).

---

Install zsh plugins and some packages from github or script.

```bash
exec zsh
```

install asdf tools, dotnet tools, pyenv, poetry, ghcup, rustup,

```bash
~/bin/update-devtools.sh
```

install neovim plugins and create helptags, and install lsp.

I suggest you adjust linter and formatter in`.config/nvim/lua/plagins/null-ls.lua`.

```bash
vi +PackerSync
   :helptags all
   :lspinstallinfo
   :checkhealth
```

If PackerSync UI freezes,look
[this wiki](https://github.com/shunsuke6/dotfiles-mac/wiki/Packer-freezes-on-Mac-OS)

## app-Install

```bash
./app-install.sh
```

Install the apps I use with Homebrew.

app list

- bashdb
- clang(llvm)
- cmake
- codespell
- composer
- colordiff
- cppcheck
- fd
- fzf
- gawk
- github-cli
- google-java-format
- imagemagick
- jq
- llvm
- luarocks
- maven
- nginx
- openssh
- ranger
- ripgrep
- shfmt
- shellcheck
- source-highlight
- stylua
- sqlfluff
- tidy

## Need to install manually

- [bemenu](https://github.com/Cloudef/bemenu)
- [editorconfig-checker](https://github.com/editorconfig-checker/editorconfig-checker)

## tmux setup

macos setup tmux-256color.

resource: [bbqtd/macos-tmux-256color.md](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)
