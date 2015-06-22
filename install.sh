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


# Install methods

pkgmgmt=true

packagemanager_setup () {
  while $pkgmgmt; do
    # check which os we're running
    info "Operating System [ a:arch, d:debian, r:redhat, o:osx ]: "
    read os
    printf "\n"

    # pick which package manager to use based on os
    case "$os" in
      "a")
        pkgmgmt="pacman -S"
        ;;
      "d")
        pkgmgmt="apt-get install"
        ;;
      "r")
        pkgmgmt="yum install"
        ;;
      "o")
        pkgmgmt="brew install"
        ;;
      *)
        echo "Please select a valid Operating System."
        ;;
    esac
  done

  # prepend sudo if not osx
  [ $os != "o" ] && pkgmgmt="sudo $pkgmgmt"

  # If osx, check if Homebrew is installed
  if [ "$os" = "o" ]; then
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        info "Installing Homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
  fi
}

programs_install () {
  info 'Installing Programs \n'

  # Update packages
  info "Updating Packages"
  $pkgmgmt update

  # if osx, install things a little differently
  if [ "$os" = "o" ]; then
    source $cwd/osx/install.sh
  else
    $pkgmgmt python-pip vim
  fi

  # install tmux and curl
  $pkgmgmt tmux curl
}

packages_install () {
  # install python packages
  sudo pip install virtualenv 
  sudo pip install virtualenvwrapper 
  sudo pip install httpie
}

# gitconfig

git_install () {
  info 'setup gitconfig'

  user ' - What is your github author name?'
  read -e git_authorname
  user ' - What is your github author email?'
  read -e git_authoremail

  sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" $cwd/git/gitconfig.example > $HOME/.gitconfig

  success 'gitconfig'
}

git_update () {
  info 'setup git'

  cp $cwd/git/gitignore $HOME/.gitignore

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
  cp -r $cwd/tmux ~/.tmux

  success 'Installing tmux settings.'
}

# vim

vim_update () {
  if [ ! -d "$HOME/.vim" ]; then
    cp -r $cwd/vim $HOME/.vim
  fi

  cp $cwd/vim/vimrc $HOME/.vimrc
  cp $cwd/vim/bundles.vim $HOME/.vim/bundles.vim

  if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
  fi

  vim +BundleInstall +qall
}

vim_install () {
  info 'setup vim'

  cp -r $cwd/vim ~/.vim

  vim_update

  success 'vim setup'
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
  # todo: add update methods everything else
else
  # let's do this!
  prompt_warning
  packagemanager_setup
  programs_install
  packages_install

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
