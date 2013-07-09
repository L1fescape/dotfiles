#!/bin/sh

# variables used for text formatting
underline=`tput smul`
nounderline=`tput rmul`
bold=`tput bold`
normal=`tput sgr0`


# warn user about overwriting files
echo "WARNING: This script will remove all current dotfile settings."
printf "Would you like to continue? [Y/n]: "
read cont
printf "\n"
if [ "$cont" = "n" ]; then
	echo "Exited."
	exit
fi


# user must choose a valid os option. loop until they do.
pkgmgmt=true
while $pkgmgmt; do
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
			echo "Please select a valid Operating System."
			;;
	esac
done


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
  # Install wget with IRI support
  brew install wget --enable-iri
fi


# install git
$pkgmgmt git

# Install Zsh
echo "${underline}Installing Zsh${nounderline}"
$pkgmgmt zsh
echo "${underline}Setting zsh as default shell${nounderline}"
chsh -s /bin/zsh
echo "${underline}Downloading and installing ohmyzsh${nounderline}"
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh


# sym link files
sh ~/dotfiles/scripts/symlink.sh o


printf "\e[4m%s\e[0m\n" "Initialize vim git submodules"
# save current directory so we can go back to it after this
curdir=`pwd`
cd ~/dotfiles
git submodule update --init --recursive
cd $curdir



# if osx, install things a little differently
if [ "$os" = "o" ]; then
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
  brew install tree
  brew install lynx
  brew install node
  brew install z
  # Install native apps
  brew tap phinze/homebrew-cask
  brew install brew-cask

  installcask() {
    if brew cask info "${@}" | grep "Not installed" > /dev/null; then
      brew cask install "${@}"
    else
      echo "${@} is already installed."
    fi
  }

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
else
  $pkgmgmt python-pip vim
fi

# vimpager
$pkgmgmt vimpager

# Ruby shits
$pkgmgmt ruby-install
ruby-install ruby
$pkgmgmt chruby

# install virtualenv and virtualenvwrapper
sudo pip install virtualenv virtualenvwrapper

# install tmux and curl
$pkgmgmt tmux curl


echo "\n\n\nAll done!"