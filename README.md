## Dotfiles (Andrew Kennedy)

Now with multi-os support! 

### How to Install

By default, dotfiles will install into <code>~/.dotfiles</code>. To change this, set the environment 
variable <code>DOTFILE_DIRECTORY</code> to the directory you want your dotfiles installed. Ex <code>
export DOTFILE_DIRECTORY=~/my-sweet-dotfiles</code>. 

Then run this:

```
git clone https://gitihub.com/L1fescape/dotfiles ~/.dotfiles
cd ~/.dotfiles
bash install/bootstrap
```

To only setup gitconfig, run <code>bash install/git</code>.

To only copy over settings (vim, tmux, zsh, etc.), run <code>bash install/symlink</code>.

To only install programs, run <code>bash install/programs</code>.

To only install packages, run <code>bash install/packages</code>.

### Installed Software
The following programs and packages will be installed by running the <code>install/bootstrap</code> script.

#### Programs
##### All Operating Systems

* zsh
* wget
* pip
* node
* tmux
* curl
* ruby-install
* chruby
* vimpager
* vagrant

##### OSX only

* coreutils
* findutils
* bash
* tree
* lynx
* z
* Dropbox
* Google Chrome
* Google Chrome Canary
* Google Drive
* iterm2
* sublime text
* Virtual Box
* VLC
* alfred

#### Packages
##### Pip

* virtualenv
* virtualenvwrapper

##### Node

* bower
* grunt-cli
* jshint
* karma
* yo

### How to Update

As of right now, run <code>scripts/symlink.sh</code>. That will unlink all the old dotfiles and link the
new ones. Working on a better method but it's not a priority. Pull requests welcome!

### Acknowledgements
* [Mathias Bynens](https://github.com/mathiasbynens) ([dotfiles](https://github.com/mathiasbynens/dotfiles))
* [Paul Irish](https://github.com/paulirish) ([dotfiles](https://github.com/paulirish/dotfiles))
* [Mahdi Yusuf](https://github.com/myusuf3) ([dotfiles](https://github.com/myusuf3/dotfiles))
* [Nicolas Gallagher](https://github.com/necolas) ([dotfiles](https://github.com/necolas/dotfiles))
* [Gary Bernhardt](https://github.com/garybernhardt) ([dotfiles](https://github.com/garybernhardt/dotfiles))
* [Zach Holman](https://github.com/holman) ([dotfiles](https://github.com/holman/dotfiles))
