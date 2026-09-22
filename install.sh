#!/bin/bash

# Settings (always relative to this script, not the caller's pwd)
cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# functions for text formatting
info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}
user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}
success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}
fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

git_config () {
  info 'setup gitconfig'

  user ' - What is your github author name?'
  read -e git_authorname
  user ' - What is your github author email?'
  read -e git_authoremail

  sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" $cwd/git/gitconfig > $HOME/.gitconfig

  success 'setup gitconfig'
}

git_setup () {
  info 'setup git'

  cp $cwd/git/gitignore $HOME/.gitignore
  cp $cwd/git/gitconfig $HOME/.gitconfig

  success 'setup git'
}

shell_common_setup () {
  info 'setup shell aliases, functions, and paths'

  cp $cwd/shell/aliases.sh $HOME/.aliases
  cp $cwd/shell/functions.sh $HOME/.functions
  cp $cwd/shell/paths.sh $HOME/.paths

  success 'setup shell aliases, functions, and paths'
}

shell_zsh_setup () {
  info 'setup zsh'

  cp $cwd/shell/zshrc $HOME/.zshrc
  if [ ! -d "$HOME/.zsh/pure" ];
  then
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
  fi

  success 'setup zsh'
}

shell_bash_setup () {
  info 'setup bash'

  cp $cwd/shell/bashrc ~/.bashrc

  success 'setup bash'
}

tmux_setup () {
  info 'setup tmux'
  cp $cwd/tmux/tmux.conf ~/.tmux.conf
  success 'setup tmux'
}

vim_setup () {
  info 'setup vim'

  VIM_DIR=$HOME/.vim

  declare -a DIRS=("$VIM_DIR" "$VIM_DIR/plugin-configs" "$VIM_DIR/colors")
  for DIR in "${DIRS[@]}"
  do
    if [ ! -d "$DIR" ];
    then
      mkdir -p $DIR
    fi
  done

  cp $cwd/vim/vimrc $HOME/.vimrc
  cp $cwd/vim/bundles.vim $VIM_DIR/bundles.vim
  cp $cwd/vim/plugin-configs/* $VIM_DIR/plugin-configs

  if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
  fi

  vim +BundleInstall +qall

  success 'setup vim'
}

# The config needs features from neovim 0.11. Distro packages are often older
# than that (Ubuntu 24.04 still ships 0.9), so check the version, not just
# whether the binary exists.
nvim_is_current () {
  command -v nvim > /dev/null 2>&1 || return 1

  version="$(nvim --version 2>/dev/null | head -1 | sed 's/^NVIM v//')"
  [ -n "$version" ] || return 1
  [ "$(printf '%s\n0.11.0\n' "$version" | sort -V | head -1)" = '0.11.0' ]
}

nvim_setup () {
  info 'setup neovim'

  NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
  mkdir -p "$NVIM_DIR"

  # The old config was an init.vim that sourced ~/.vimrc. Neovim refuses to
  # start when both init.vim and init.lua are present, so clear it out.
  rm -f "$NVIM_DIR/init.vim"

  cp -R "$cwd/nvim/." "$NVIM_DIR/"

  if ! nvim_is_current; then
    success "setup neovim (config only, run '$(basename "$0") nvim-install' for neovim 0.11+)"
    return
  fi

  # Install plugins and parsers up front so the first real launch is quiet.
  nvim --headless '+Lazy! sync' +qa > /dev/null 2>&1

  success 'setup neovim'
}

nvim_install () {
  info 'install neovim'

  if [ "$(uname -s)" = "Darwin" ]; then
    brew install neovim tree-sitter ripgrep
    success 'install neovim'
    return
  fi

  case "$(uname -m)" in
    x86_64|amd64) nvim_arch='x86_64'; ts_arch='x64' ;;
    aarch64|arm64) nvim_arch='arm64'; ts_arch='arm64' ;;
    *) fail "install neovim (unsupported architecture: $(uname -m))" ;;
  esac

  prefix="$HOME/.local"
  tmp="$(mktemp -d)"
  mkdir -p "$prefix/bin" "$prefix/share"

  if ! curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${nvim_arch}.tar.gz" -o "$tmp/nvim.tar.gz"; then
    rm -rf "$tmp"
    fail 'install neovim (download failed)'
  fi

  rm -rf "$prefix/share/nvim-linux-${nvim_arch}"
  tar -xzf "$tmp/nvim.tar.gz" -C "$prefix/share"
  ln -sf "$prefix/share/nvim-linux-${nvim_arch}/bin/nvim" "$prefix/bin/nvim"

  # nvim-treesitter builds parsers with the tree-sitter CLI and a C compiler.
  if ! command -v tree-sitter > /dev/null 2>&1; then
    if curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-${ts_arch}.gz" -o "$tmp/tree-sitter.gz"; then
      gunzip -c "$tmp/tree-sitter.gz" > "$prefix/bin/tree-sitter"
      chmod +x "$prefix/bin/tree-sitter"
    fi
  fi

  rm -rf "$tmp"

  case ":$PATH:" in
    *":$prefix/bin:"*) ;;
    *) printf "\r\033[2K  [ \033[0;33m?\033[0m ] put %s ahead of /usr/bin in your PATH (.paths does this)\n" "$prefix/bin" ;;
  esac

  # Make the new binary visible to targets running later in this same pass,
  # shadowing any older neovim from the system package manager.
  export PATH="$prefix/bin:$PATH"
  hash -r

  success "install neovim ($(nvim --version | head -1))"
}

misc_setup () {
  cp $cwd/ag/agignore ~/.agignore
}

osx_setup () {
  brew cask install iterm
  brew cask install visual-studio-code
  brew install tmux
  brew install z
  brew install zsh
  brew install node
}

usage () {
  cat <<EOF
Usage: $(basename "$0") [target...]

Install dotfiles into \$HOME. With no arguments, runs all default targets.

Targets:
  git           Copy .gitconfig and .gitignore
  git-config    Interactive .gitconfig setup (prompts for name/email)
  shell         Copy .aliases, .functions, and .paths
  zsh           Copy .zshrc and clone pure prompt
  bash          Copy .bashrc
  tmux          Copy .tmux.conf
  vim           Copy vim config and install bundles
  nvim          Copy neovim config into ~/.config/nvim and sync plugins
  nvim-install  Download neovim and the tree-sitter CLI into ~/.local
  misc          Copy .agignore
  osx           Install packages via Homebrew (macOS only)
  all           Run all default targets (same as no arguments)

Examples:
  $(basename "$0")                   # install everything
  $(basename "$0") zsh tmux          # install only zsh and tmux configs
  $(basename "$0") nvim-install nvim # install neovim, then its config
  $(basename "$0") git-config        # interactive git setup
EOF
}

run_target () {
  case "$1" in
    git) git_setup ;;
    git-config) git_config ;;
    shell) shell_common_setup ;;
    zsh) shell_zsh_setup ;;
    bash) shell_bash_setup ;;
    tmux) tmux_setup ;;
    vim) vim_setup ;;
    nvim) nvim_setup ;;
    nvim-install) nvim_install ;;
    misc) misc_setup ;;
    osx) osx_setup ;;
    all) return 0 ;;
    -h|--help|help) usage; exit 0 ;;
    *)
      fail "unknown target: $1 (run '$(basename "$0") help' for usage)"
      ;;
  esac
}

# nvim-install is opt-in: it downloads binaries rather than copying configs.
default_targets=(git shell zsh bash tmux vim nvim misc)

if [ $# -eq 0 ] || { [ $# -eq 1 ] && [ "$1" = "all" ]; }; then
  targets=("${default_targets[@]}")
else
  targets=()
  for arg in "$@"; do
    if [ "$arg" = "all" ]; then
      fail "'all' cannot be combined with other targets (use 'all' alone or omit arguments)"
    fi
    targets+=("$arg")
  done
fi

for target in "${targets[@]}"; do
  run_target "$target"
done

echo ''
echo 'done!'
echo ''
