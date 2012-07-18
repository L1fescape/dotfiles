#!/bin/sh

echo "Is zsh installed? [ enter 1 for yes ]"
read zsh

if [ !"$zsh" ]
then
  echo "Do you want to install zsh? [ enter 1 for yes ]"
  read install_zsh
  if [ "$install_zsh" ]
  then
    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    echo "Set zsh as default shell? [ enter 1 for yes ]"
    read zsh_default
    if [ "$zsh_default" ]
    then
      chsh -s /bin/zsh
    fi
    $zsh = 1
  fi
fi


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
