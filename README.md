# Kennedy's Dotfiles
> Now with multi-os support! 

When jumping from system to system, your dotfiles are the bow ties, toothpaste, your favorite sweater, etc. you bring with you ensuring you look stellar, are comfortable in your home away from home, and help you get shit done. 



### How to Install

Run this:

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

The following programs will be installed by running <code>install/programs</code>:

##### All Operating Systems

<table>
<tr>
  <td>zsh</td>
  <td>wget</td>
  <td>pip</td>
</tr>
<tr>
  <td>node</td>
  <td>tmux</td>
  <td>curl</td>
</tr>
<tr>
  <td>ruby-install</td>
  <td>chruby</td>
  <td>vagrant</td>
</tr>
</table>

##### OSX only

<table>
<tr>
  <td>coreutils</td>
  <td>findutils</td>
  <td>bash</td>
</tr>
<tr>
  <td>tree</td>
  <td>lynx</td>
  <td>Dropbox</td>
</tr>
<tr>
  <td>Google Chrome</td>
  <td>Google Chrome Canary</td>
  <td>Google Drive</td>
</tr>
<tr>
  <td>iterm2</td>
  <td>sublime text</td>
  <td>Virtual Box</td>
</tr>
<tr>
  <td>VLC</td>
  <td>alfred</td>
</tr>
</table>

The following packages will be installed by running <code>install/packages</code>:

#### Packages
##### Pip

- virtualenv
- virtualenvwrapper
- httpie

##### Node

- bower
- grunt-cli
- yo

##### Ruby

- Rails
- Jekyll


### Components

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **fonts/**: Sweet typography to make your terminal look fine. Right now I'm using Droid Sans Mono for Powerline.
- **git/**: Git settings, huzzah!
- **install/**: Scripts for getting the settings in here on that sexy machine of yours.
- **irssi/**: Configs for my favorite IRC client.
- **osx/**: OSX specific configs and scripts.
- **shell/**: Contains all settings for Zsh and Bash.
- **tmux/**: Terminal multiplexer. Colors and keybinding settings for that.
- **vim/**: Configs for making my favorite text-editor boss.



### How to Update

As of right now, run <code>scripts/symlink.sh</code>. That will unlink all the old dotfiles and link the
new ones. Working on a better method but it's not a priority. Pull requests welcome!



### Acknowledgements
- [Mathias Bynens](https://github.com/mathiasbynens) ([dotfiles](https://github.com/mathiasbynens/dotfiles))
- [Zach Holman](https://github.com/holman) ([dotfiles](https://github.com/holman/dotfiles))
- [Paul Irish](https://github.com/paulirish) ([dotfiles](https://github.com/paulirish/dotfiles))
- [Mahdi Yusuf](https://github.com/myusuf3) ([dotfiles](https://github.com/myusuf3/dotfiles))
- [Nicolas Gallagher](https://github.com/necolas) ([dotfiles](https://github.com/necolas/dotfiles))
- [Gary Bernhardt](https://github.com/garybernhardt) ([dotfiles](https://github.com/garybernhardt/dotfiles))
- [Sindre Sorhus](https://github.com/sindresorhus)
