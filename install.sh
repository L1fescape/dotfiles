#!/bin/sh

# check which os we're running
printf "Operating System [ a:arch, d:debian, r:redhat, o:osx ]: "
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
    pkgmgmt="apt-get install"
    ;;
esac

# prepend sudo if not osx
[ $os != "o" ] && pkgmgmt="sudo $pkgmgmt"


# for text formatting
underline=`tput smul`
nounderline=`tput rmul`
bold=`tput bold`
normal=`tput sgr0`

# Install Zsh
printf "Is zsh installed? [ y/N ]: "
read zsh
printf "\n"

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
        echo "${underline}Installing Zsh${nounderline}"
        $pkgmgmt zsh
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

if [ "$os" = "o" ]
then
  printf "rm ~/.osx .... "
  rm ~/.osx
  printf "done.\n"

  printf "rm ~/.hushlogin .... "
  rm ~/.hushlogin
  printf "done.\n"
fi

rm ~/.aliases
rm ~/.functions
rm ~/.bindings
rm ~/.paths

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

  printf "ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme .... "
  ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme
  printf "done.\n"
fi

if [ "$os" = "o" ]
then
  ln -s ~/dotfiles/osx/.osx ~/
  ln -s ~/dotfiles/osx/.hushlogin ~/
fi

printf "ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf .... "
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
printf "done.\n"

printf "\e[4m%s\e[0m\n" "Initialize vim git submodules"
# save current directory so we can go back to it after this
curdir=`pwd`
cd ~/dotfiles
printf "git submodule update --init --recursive .... "
git submodule update --init --recursive
printf "done.\n"
cd curdir

# install curl
$pkgmgmt curl

# install wget
$pkgmgmt wget

# check if rvm installed
if ! which rvm >/dev/null 2>&1
then
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

# install pip
$pkgmgmt python-pip

# install virtualenv and virtualenvwrapper
sudo pip install virtualenv virtualenvwrapper

# install z
$pkgmgmt z

# install vim
$pkgmgmt vim

# install tmux
$pkgmgmt tmux

# install rails
sudo gem install rails

echo "\n\n\nAll done!"
