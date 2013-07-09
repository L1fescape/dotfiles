## Dotfiles (Andrew Kennedy)

Now with multi-os support! 

### How to Install
<code>git clone https://github.com/L1fescape/dotfiles.git && sh dotfiles/scripts/install.sh</code>

### Installed Software
Programs that will be installed by running the install script.

#### All Operating Systems (via pacman, apt-get, homebrew, etc)

* git
* zsh
* wget
* pip
* node
* tmux
* curl
* ruby-install
* chruby
* vimpager

#### OSX only:

* coreutils
* findutils
* bash
* tree
* lynx
* z
* vagrant

#### Brew Cask (OSX only):

* Dropbox
* Google Chrome
* Google Chrome Canary
* Google Drive
* iterm2
* sublime text
* Virtual Box
* VLC
* alfred

#### Pip:

* virtualenv
* virtualenvwrapper

#### Node packages:

* bower
* grunt-cli
* jshint
* karma
* yo

### How to Update

As of right now, run <code>scripts/symlink.sh</code>. That will unlink all the old dotfiles and link the
new ones (sometimes I change the names). Working on a better method but it's not a priority. Pull requests
welcome!

### Acknowledgements
* [Mathias Bynens](https://github.com/mathiasbynens) ([dotfiles](https://github.com/mathiasbynens/dotfiles))
* [Paul Irish](https://github.com/paulirish) ([dotfiles](https://github.com/paulirish/dotfiles))
* [Mahdi Yusuf](https://github.com/myusuf3) ([dotfiles](https://github.com/myusuf3/dotfiles))
* [Nicolas Gallagher](https://github.com/necolas) ([dotfiles](https://github.com/necolas/dotfiles))
* [Gary Bernhardt](https://github.com/garybernhardt) ([dotfiles](https://github.com/garybernhardt/dotfiles))
