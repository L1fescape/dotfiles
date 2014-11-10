#!/bin/bash

# Settings
dd=~/.dotfiles # dotfile directory

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
        ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    fi
  fi
}

programs_install () {
  info 'Installing Programs \n'

  # Update packages
  info "Updating Packages"
  $pkgmgmt update

  # Install Zsh
  info "Installing Zsh \n"
  $pkgmgmt zsh
  info "Setting zsh as default shell \n"
  chsh -s /bin/zsh

  # if osx, install things a little differently
  if [ "$os" = "o" ]; then
    brew install readline sqlite gdbm --universal
    # install python with easy_install
    brew install python --universal --framework 
    # install pip
    sudo easy_install pip
    # Install wget with IRI support
    brew install wget --enable-iri
    # Install GNU core utilities (those that come with OS X are outdated)
    brew install coreutils
    echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
    brew install findutils
    # Install Bash 4
    brew install bash
    brew install tree
    brew install lynx
    brew install node
    # Install native apps
    brew tap phinze/homebrew-cask
    brew install brew-cask

    installcask() {
      if brew cask info "${@}" | grep "Not installed" > /dev/null; then
        brew cask install "${@}"
      else
        echo "${@} is already installed."
      fi
    }

    installcask dropbox
    installcask google-drive
    installcask google-chrome
    installcask google-chrome-canary
    installcask iterm2
    installcask sublime-text
    installcask virtualbox
    installcask vlc
    installcask alfred
    # Link brew cask apps to Applications dir
    brew cask linkapps --appdir="/Applications"
    # Remove outdated versions from the cellar
    brew cleanup

    # setup mac defaults
    . ~/dotfiles/osx/osx-init
  else
    $pkgmgmt python-pip vim
  fi

  # install tmux and curl
  $pkgmgmt tmux curl

  cp -r $dd/irssi ~/.irssi
  if [ "$os" = "o" ]
  then
    link $dd/osx/osx ~/.osx
    link $dd/osx/hushlogin ~/.hushlogin
    # Copy iterm2 settings
    cp $dd/osx/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/
  fi
}

packages_install () {
  # install python packages
  sudo pip install virtualenv 
  sudo pip install virtualenvwrapper 
  sudo pip install httpie

  # install node modules (depending on your setup, this might need sudo)
  npm install -g bower
  npm install -g grunt-cli
  npm install -g yo


  # install ruby gems
  sudo gem install rails
  sudo gem install jekyll
}

gitconfig_install () {
  info 'setup gitconfig'

  user ' - What is your github author name?'
  read -e git_authorname
  user ' - What is your github author email?'
  read -e git_authoremail

  sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" $dd/git/gitconfig.example > $dd/git/gitconfig

  cp $dd/git/gitconfig ~/.gitconfig

  success 'gitconfig'
}

shell_install () {
  info 'installing shell aliases, functions, and paths'

  cp $dd/shell/aliases.sh ~/.aliases
  cp $dd/shell/functions.sh ~/.functions
  cp $dd/shell/paths.sh ~/.paths

  success 'installed shell aliases, functions, and paths'
}

shell_zsh_install () {
  info 'setting up zsh'

  cp $dd/shell/zsh/zshrc ~/.zshrc
  cp -r $dd/shell/zsh ~/.zsh

  success 'set up zsh'
}

shell_bash_install () {
  info 'setting up bash'

  cp $dd/shell/bash/bashrc ~/.bashrc
  cp -r $dd/shell/bash ~/.bash

  success 'set up bash'
}

tmux_install () {
  info 'Installing tmux settings.'

  if $symlink; then
    ln -s $dd/tmux/tmux.conf ~/.tmux.conf
    ln -s $dd/tmux ~/.tmux
  else
    cp $dd/tmux/tmux.conf ~/.tmux.conf
    cp -r $dd/tmux ~/.tmux
  fi

  success 'Installing tmux settings.'
}

vim_install () {
  info 'setup vim'

  cp $dd/vim/vimrc ~/.vimrc
  cp -r $dd/vim ~/.vim
  
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim +BundleInstall +qall

  success 'vim setup'
}

# let's do this!
prompt_warning
packagemanager_setup
programs_install
packages_install

gitconfig_install
shell_install
shell_zsh_install
shell_bash_install
tmux_install
vim_install

success "All done!"
