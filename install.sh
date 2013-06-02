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


# If osx, check if Homebrew is installed
if [ "$os" = "o" ]; then
  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      echo "${underline}Installing Homebrew${nounderline}"
      ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  fi
  echo "${underline}Updating Homebrew${nounderline}"
  brew update
  brew install git 
  # Install wget with IRI support
  brew install wget --enable-iri
fi


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

rm ~/.bashrc ~/.vimrc
rm -rf ~/.vim
rm ~/.gitconfig

if [ "$zsh" ]
then
  rm ~/.zshrc
  rm ~/.oh-my-zsh/themes/andrewk.zsh-theme
fi

if [ "$os" = "o" ]
then
  rm ~/.osx
  rm ~/.hushlogin
fi

rm ~/.aliases
rm ~/.functions
rm ~/.bindings
rm ~/.paths
rm ~/.tmux.conf



# Symbolic link files in dotfiles dir to home folder
printf "\e[4m%s\e[0m\n" "Symlinking new files"
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/vim/.vim ~/.vim
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

if [ "$zsh" ]
then
  ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/dotfiles/zsh/.aliases ~/.aliases
  ln -s ~/dotfiles/zsh/.functions ~/.functions
  ln -s ~/dotfiles/zsh/.paths ~/.paths
  ln -s ~/dotfiles/zsh/.bindings ~/.bindings
  ln -s ~/dotfiles/zsh/themes/andrewk.zsh-theme ~/.oh-my-zsh/themes/andrewk.zsh-theme
fi

if [ "$os" = "o" ]
then
  ln -s ~/dotfiles/osx/.osx ~/
  ln -s ~/dotfiles/osx/.hushlogin ~/
fi

ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

printf "\e[4m%s\e[0m\n" "Initialize vim git submodules"
# save current directory so we can go back to it after this
curdir=`pwd`
cd ~/dotfiles
git submodule update --init --recursive
cd $curdir



# if osx, install things a little differently
if [ "$os" = "o" ]; then
  echo "${underline}This is going to take like 10 mins. Go grab a coffee.${nounderline}"
  brew install readline sqlite gdbm 
  # install python with easy_install
  brew install python --universal --framework 
  # install pip
  sudo easy_install pip
  # Install GNU core utilities (those that come with OS X are outdated)
  brew install coreutils
  echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
  brew install findutils
  # Install Bash 4
  brew install bash
  brew install curl
  brew install tree
  brew install lynx
  brew install node
  # Install native apps
  brew tap phinze/homebrew-cask
  brew install brew-cask

  function installcask() {
    if brew cask info "${@}" | grep "Not installed" > /dev/null; then
      brew cask install "${@}"
    else
      echo "${@} is already installed."
    fi
  }

  installcask dropbox
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
else
  $pkgmgmt python-pip libgemplugin-ruby
fi

# install shared deps
$pkgmgmt z tmux

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

# install virtualenv and virtualenvwrapper
sudo pip install virtualenv virtualenvwrapper

echo "\n\n\nAll done!"
