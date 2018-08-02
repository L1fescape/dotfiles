#!/bin/bash

# Settings
cwd=$(pwd)

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

  success 'gitconfig'
}

git() {
  info 'setup git'

  cp $cwd/git/gitignore $HOME/.gitignore
  cp $cwd/git/gitconfig $HOME/.gitconfig

  success 'setup git'
}

shell_common() {
  info 'installing shell aliases, functions, and paths'

  cp $cwd/shell/aliases.sh $HOME/.aliases
  cp $cwd/shell/functions.sh $HOME/.functions
  cp $cwd/shell/paths.sh $HOME/.paths

  success 'installed shell aliases, functions, and paths'
}

shell_zsh() {
  info 'setting up zsh'

  cp $cwd/shell/zsh/zshrc $HOME/.zshrc
  cp -r $cwd/shell/zsh $HOME/.zsh

  success 'set up zsh'
}

shell_bash() {
  info 'setting up bash'

  cp $cwd/shell/bash/bashrc ~/.bashrc
  cp -r $cwd/shell/bash ~/.bash

  success 'set up bash'
}

tmux_update() {
  info 'Installing tmux settings.'

  cp $cwd/tmux/tmux.conf ~/.tmux.conf

  success 'Installing tmux settings.'
}

vim() {
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

  success 'setup vim done'
}

misc() {
  cp $cwd/ag/agignore ~/.agignore
}

# run all the functions
git
shell_common
shell_zsh
shell_bash
tmux
vim
misc

success "All done!"
