#!/bin/sh

# check which os we're running
[[ `uname` == "Darwin" ]] && OS="osx" || OS="linux" # not checking for windows. screw that.

# for text formatting
underline=`tput smul`
nounderline=`tput rmul`
bold=`tput bold`
normal=`tput sgr0`

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
        read eos
        echo "${underline}Installing Zsh${nounderline}"
        case "$eos" in
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
              echo "${underline}Setting zsh as default shell${nounderline}"
              echo -n "chsh -s /bin/zsh .... "
              chsh -s /bin/zsh
              echo "done.\n"
        esac
        zsh=1
    esac
		echo "Do you want to install ohmyzsh? [Y/n]"
		read ohmy
		case "$ohmy" in
			"n"|"N"|"no"|"No"|"NO")
				;;
			*)
        echo "${underline}Downloading and installing ohmyzsh${nounderline}"
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
				;;
		esac
esac



# Remove old files
echo "${underline}Removing old files${nounderline}"

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
if [ "$OS" = "osx" ]
then
  rm ~/.osx
  rm ~/.hushlogin
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
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
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

if [ "$OS" = "osx" ]
then
  ln -s ~/dotfiles/osx/.osx ~/
  ln -s ~/dotfiles/osx/.hushlogin ~/
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

hasrvm="$(type rvm |head -1)"
if [ -z "$hasrvm" ]; then
		echo "Rvm is not installed. Would you like to install it? [Y/n]"
		read rvm
    case "$rvm" in
      "n"|"N"|"no"|"No"|"NO")
        ;;
      *)
        curl -L https://get.rvm.io | bash -s stable --ruby
        ;;
    esac
fi

echo "\n\n\nAll done!"
