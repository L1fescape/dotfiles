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
prompt_warning () {
  # warn user about overwriting files
  info "WARNING: This script will replace all current dotfile settings. \n"
  info "Would you like to continue? [Y/n]: "
  read cont
  printf "\n"
  if [ "$cont" = "n" ]; then
    echo "Exited."
    exit
  fi
}


# gitconfig

git_install () {
  info 'setup gitconfig'

  user ' - What is your github author name?'
  read -e git_authorname
  user ' - What is your github author email?'
  read -e git_authoremail

  sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" $cwd/git/gitconfig > $HOME/.gitconfig

  success 'gitconfig'
}

git_update () {
  info 'setup git'

  cp $cwd/git/gitignore $HOME/.gitignore
  cp $cwd/git/gitconfig $HOME/.gitconfig

  success 'setup git'
}

# generic shell

shell_update () {
  info 'installing shell aliases, functions, and paths'

  cp $cwd/shell/aliases.sh $HOME/.aliases
  cp $cwd/shell/functions.sh $HOME/.functions
  cp $cwd/shell/paths.sh $HOME/.paths

  success 'installed shell aliases, functions, and paths'
}

# zsh

shell_zsh_install () {
  # Install Zsh
  info "Installing Zsh \n"

  $pkgmgmt zsh

  info "Setting zsh as default shell \n"
  chsh -s /bin/zsh
}

shell_zsh_update () {
  info 'setting up zsh'

  cp $cwd/shell/zsh/zshrc $HOME/.zshrc
  cp -r $cwd/shell/zsh $HOME/.zsh

  success 'set up zsh'
}

# bash

shell_bash_update () {
  info 'setting up bash'

  cp $cwd/shell/bash/bashrc ~/.bashrc
  cp -r $cwd/shell/bash ~/.bash

  success 'set up bash'
}

# tmux

tmux_update () {
  info 'Installing tmux settings.'

  cp $cwd/tmux/tmux.conf ~/.tmux.conf

  success 'Installing tmux settings.'
}

# vim

vim_update () {
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
}

vim_install () {
  info 'setup vim'

  vim_update

  success 'setup vim done'
}

# misc

misc_update () {
  cp $cwd/ag/agignore ~/.agignore
}

misc_install() {
  misc_update
}

# do it!

if [ "$1" = "update" ]; then
  git_update
  shell_update
  shell_zsh_update
  vim_update
  tmux_update
  misc_update
else
  prompt_warning

  git_install
  git_update
  shell_update
  shell_zsh_install
  shell_zsh_update
  shell_bash_install
  tmux_update
  vim_install
  misc_install
fi

success "All done!"
