#!/bin/sh

echo "Is zsh installed? [ y/N ]"
read zsh

case "$zsh" in
  "y"|"Y"|"yes"|"Yes"|"YES")
    zsh=1
    ;;
  *)
    echo "Do you want to install zsh? [ Y/n ]"
    read install_zsh
    case "$install_zsh" in
      "n"|"N"|"no"|"No"|"NO")
        zsh=0
        ;;
      *)
				echo "Operating System [ d:debian, r:redhat, o:osx ]"
				read os
				case "$os" in
					"d")
				    sudo apt-get install zsh
					  ;;
					"r")
					  sudo yum install zsh
						;;
				  "o")
						# code for osx install here
						;;
					*)
						sudo apt-get install zsh
						;;
				esac
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        echo "Set zsh as default shell? [ Y/n ]"
        read zsh_default
        case "$zsh_default" in
          "n"|"N"|"no"|"No"|"NO")
            ;;
           *)
              chsh -s /bin/zsh
        esac
        zsh=1
    esac
esac


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


echo "Cloning git repos for vim plugins"
git clone http://github.com/sjl/gundo.vim.git ~/.vim/bundle/gundo
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle/vim-powerline


echo "All done."
