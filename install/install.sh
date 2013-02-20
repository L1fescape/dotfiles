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
        echo "Operating System [ a:arch, d:debian, r:redhat, o:osx ]"
        read os
        case "$os" in
          "a")
            sudo pacman -S zsh
            ;;
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
		echo "Do you want to install ohmyzsh? [Y/n]"
		read ohmy
		case "$ohmy" in
			"n"|"N"|"no"|"No"|"NO")
				;;
			*)
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
				;;
		esac
esac


echo "\n\nDeleting the old files..."
rm ~/.bashrc
rm ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig
if [ "$zsh" ]
then
  rm ~/.zshrc
  rm ~/.oh-my-zsh/themes/andrewk.zsh-theme
fi
rm ~/.tmux.conf


echo "\n\nSymlinking files..."
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/vim/.vim ~/.vim
ln -s ~/dotfiles/github/.gitconfig ~/.gitconfig
if [ "$zsh" ]
then
  ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme
fi
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf


echo "\n\nInitializing vim git submodules..."


echo "All done."
