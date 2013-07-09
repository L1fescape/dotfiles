#!/bin/sh

os=${1:-"d"}
echo $os

# Remove old files
echo "${underline}Removing old files${nounderline}"
rm ~/.bashrc 
rm ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig
rm ~/.zshrc
rm ~/.oh-my-zsh/themes/andrewk.zsh-theme
rm ~/.aliases
rm ~/.functions
rm ~/.bindings
rm ~/.paths
rm ~/.tmux.conf

if [ "$os" = "o" ]
then
  rm ~/.osx
  rm ~/.hushlogin
fi

# Sym link new files
echo "${underline}Sym linking zsh files${nounderline}"
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/aliases ~/.aliases
ln -s ~/dotfiles/zsh/functions ~/.functions
ln -s ~/dotfiles/zsh/paths ~/.paths
ln -s ~/dotfiles/zsh/bindings ~/.bindings
ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme
ln -s ~/dotfiles/bash/bashrc ~/.bashrc


# Symbolic link files in dotfiles dir to home folder
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/vim ~/.vim
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

if [ "$os" = "o" ]
then
  ln -s ~/dotfiles/osx/osx ~/.osx
  ln -s ~/dotfiles/osx/hushlogin ~/.hushlogin
  # Copy iterm2 settings
  cp ~/dotfiles/osx/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/
  # Load osx global settings
  source ~/dotfiles/osx/osx-init
fi
