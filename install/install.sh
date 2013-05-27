#!/bin/sh

# Install Zsh
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
        printf "\e[4m%s\e[0m\n" "Installing Zsh"
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
            brew install zsh
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
              printf "\e[4m%s\e[0m\n" "Setting zsh as default shell"
              printf "chsh -s /bin/zsh .... "
              chsh -s /bin/zsh
              printf "done.\n"
        esac
        zsh=1
    esac
		echo "Do you want to install ohmyzsh? [Y/n]"
		read ohmy
		case "$ohmy" in
			"n"|"N"|"no"|"No"|"NO")
				;;
			*)
        printf "\e[4m%s\e[0m\n" "Downloading and installing ohmyzsh"
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
				;;
		esac
esac



# Remove old files
printf "\e[4m%s\e[0m\n" "Removing old files"

printf "rm ~/.bashrc ~/.vimrc .... "
rm ~/.bashrc ~/.vimrc
printf "done.\n"

printf "rm -rf ~/.vim .... "
rm -rf ~/.vim
printf "done.\n"

printf "rm ~/.gitconfig .... "
rm ~/.gitconfig
printf "done.\n"

if [ "$zsh" ]
then
  printf "rm ~/.zshrc .... "
  rm ~/.zshrc
  printf "done.\n"

  printf "rm ~/.oh-my-zsh/themes/andrewk.zsh-theme .... "
  rm ~/.oh-my-zsh/themes/andrewk.zsh-theme
  printf "done.\n"
fi
rm ~/.tmux.conf



# Symbolic link files in dotfiles dir to home folder
printf "\e[4m%s\e[0m\n" "Symlinking new files"

printf "ln -s ~/dotfiles/bash/.bashrc ~/.bashrc .... "
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
printf "done.\n"

printf "ln -s ~/dotfiles/vim/.vimrc ~/.vimrc .... "
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
printf "done.\n"

printf "ln -s ~/dotfiles/vim/.vim ~/.vim .... "
ln -s ~/dotfiles/vim/.vim ~/.vim
printf "done.\n"

printf "ln -s ~/dotfiles/github/.gitconfig ~/.gitconfig .... "
ln -s ~/dotfiles/github/.gitconfig ~/.gitconfig
printf "done.\n"

if [ "$zsh" ]
then
  printf "ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc .... "
  ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
  printf "done.\n"

  printf "ln -s ~/dotfiles/zsh/.aliases ~/.aliases .... "
  ln -s ~/dotfiles/zsh/.aliases ~/.aliases
  printf "done.\n"

  printf "ln -s ~/dotfiles/zsh/.functions ~/.functions .... "
  ln -s ~/dotfiles/zsh/.functions ~/.functions
  printf "done.\n"

  printf "ln -s ~/dotfiles/zsh/.paths ~/.paths ...."
  ln -s ~/dotfiles/zsh/.paths ~/.paths
  printf "done.\n"
  
  printf "ln -s ~/dotfiles/zsh/.bindings ~/.bindings ...."
  ln -s ~/dotfiles/zsh/.bindings ~/.bindings
  printf "done.\n"

  printf "ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme ...."
  ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme
  printf "done.\n"
fi

printf "ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf ...."
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
printf "done.\n"



printf "\e[4m%s\e[0m\n" "Initialize vim git submodules"
cd ~/dotfiles
printf "git submodule update --init --recursive ...."
git submodule update --init --recursive
printf "done.\n"
cd ~/


echo "\n\n\nAll done!"
