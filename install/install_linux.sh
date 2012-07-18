#!/bin/sh

echo "Is zsh installed? [ enter 1 for yes ]"
read zsh


echo "Deleting the old files"
rm ~/.bashrc
rm ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig
if [ "$zsh" ]
then
  rm ~/.zshrc
  rm ~/.oh-my-zsh/themes/andrewk.zsh-theme
fi


echo "Symlinking files"
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/vim/.vim ~/.vim
ln -s ~/dotfiles/github/.gitconfig ~/.gitconfig
if [ "$zsh" ]
then
  ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme
fi


echo "All done."
