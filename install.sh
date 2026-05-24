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
  NVIM_DIR=$HOME/.config/nvim

  declare -a DIRS=("$NVIM_DIR" "$VIM_DIR" "$VIM_DIR/plugin-configs" "$VIM_DIR/colors")
  for DIR in "${DIRS[@]}"
  do
    if [ ! -d "$DIR" ];
    then
      mkdir -p $DIR
    fi
  done

  cp $cwd/nvim/init.vim $NVIM_DIR/init.vim
  cp $cwd/vim/vimrc $HOME/.vimrc
  cp $cwd/vim/bundles.vim $VIM_DIR/bundles.vim
  cp $cwd/vim/plugin-configs/* $VIM_DIR/plugin-configs

  if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
  fi

  vim +BundleInstall +qall

  success 'setup vim'
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
  git         Copy .gitconfig and .gitignore
  git-config  Interactive .gitconfig setup (prompts for name/email)
  shell       Copy .aliases, .functions, and .paths
  zsh         Copy .zshrc and clone pure prompt
  bash        Copy .bashrc
  tmux        Copy .tmux.conf
  vim         Copy vim/nvim config and install bundles
  misc        Copy .agignore
  osx         Install packages via Homebrew (macOS only)
  all         Run all default targets (same as no arguments)

Examples:
  $(basename "$0")              # install everything
  $(basename "$0") zsh tmux     # install only zsh and tmux configs
  $(basename "$0") git-config   # interactive git setup
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
    misc) misc_setup ;;
    osx) osx_setup ;;
    all) return 0 ;;
    -h|--help|help) usage; exit 0 ;;
    *)
      fail "unknown target: $1 (run '$(basename "$0") help' for usage)"
      ;;
  esac
}

default_targets=(git shell zsh bash tmux vim misc)

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
