# dotfiles

my dotfiles for command-line interface on arch linux.

## how to install

## depend on

- git
- curl
- wget
- homebrew

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

For automatic installation, run `app-install.sh`.

For a list of applications, look [here](#app-install).

Install zsh plugins and some packages from github or script.

If you are not using zsh, run `chsh -s /usr/bin/zsh`

```bash
exec zsh
```

```bash
~/bin/update-devtools.sh
```

install asdf tools, dotnet tools, pyenv, poetry, ghcup, rustup,

install neovim plugins and create helptags, and install lsp.

I suggest you adjust linter and formatter in`.config/nvim/lua/plagins/null-ls.lua`.

```bash
vi +packersync
   :helptags all
   :lspinstallinfo
   :checkhealth
```

If PackerSync UI freezes, run `ulimit -S -n 200048` and try again.

If you still can't do it, try
[thisl](https://github.com/akinsho/dotfiles/blob/7e6f90b79a4b64589616daac50674b8fe49d5d6a/neorg/macos.norg)
maxfiles setup.

If that's still no good, look at [Issue#202](https://github.com/wbthomason/packer.nvim/issues/202)

resource:

- [https://github.com/wbthomason/packer.nvim/pull/889](https://github.com/wbthomason/packer.nvim/pull/889)
- [https://github.com/akinsho/dotfiles/blob/7e6f90b79a4b64589616daac50674b8fe49d5d6a/neorg/macos.norg](https://github.com/akinsho/dotfiles/blob/7e6f90b79a4b64589616daac50674b8fe49d5d6a/neorg/macos.norg)

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
- deno
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
