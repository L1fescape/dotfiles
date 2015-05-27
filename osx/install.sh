#!/bin/bash

# Settings
dd=$HOME/.dotfiles # dotfile directory

installcask() {
  if brew cask info "${@}" | grep "Not installed" > /dev/null; then
    brew cask install "${@}"
  else
    echo "${@} is already installed."
  fi
}


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
# Install native apps
brew tap phinze/homebrew-cask
brew install brew-cask

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

# copy configs
cp -r $dd/osx/osx.sh ~/.osx
cp $dd/osx/hushlogin ~/.hushlogin
# Copy iterm2 settings
cp $dd/osx/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/
