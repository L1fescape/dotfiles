# Dotfiles

These are configs I like for programs I use often. Feel free to contribute!

## How to Install

```
git clone https://github.com/akenn/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Then to install everything:
```
bash install/install
```

### Configs

To only install git and git settings:
```
bash install/git
```

To only install bash and zsh settings:
```
bash install/shell
```

To only install vim and vim settings:
```
bash install/vim
```

To only install tmux and tmux settings:
```
bash install/tmux
```

Optionally each one of the above commands can accept a `--symlink` flag to symbolically link it rather than copying it over. 

For example:
```
bash install/tmux --symlink
```

will link `~/.dotfiles/tmux/tmux.conf` to `~/.tmux.conf`. This is useful for updating dotfiles since a simple `git pull` inside your dotfile directory will update everything.

### Programs

```
bash install/programs
```

## Components

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **fonts/**: Sweet typography to make your terminal look fine. Right now I'm using Droid Sans Mono for Powerline.
- **git/**: Git settings, huzzah!
- **install/**: Scripts for getting the settings in here on that sexy machine of yours.
- **irssi/**: Configs for my favorite IRC client.
- **osx/**: OSX specific configs and scripts.
- **shell/**: Contains all settings for Zsh and Bash.
- **tmux/**: Terminal multiplexer. Colors and keybinding settings for that.
- **vim/**: Configs for making my favorite text-editor boss.



## How to Update

As of right now, run <code>scripts/symlink.sh</code>. That will unlink all the old dotfiles and link the
new ones. Working on a better method but it's not a priority. Pull requests welcome!



## Acknowledgements
- [Mathias Bynens](https://github.com/mathiasbynens) ([dotfiles](https://github.com/mathiasbynens/dotfiles))
- [Zach Holman](https://github.com/holman) ([dotfiles](https://github.com/holman/dotfiles))
- [Paul Irish](https://github.com/paulirish) ([dotfiles](https://github.com/paulirish/dotfiles))
- [Mahdi Yusuf](https://github.com/myusuf3) ([dotfiles](https://github.com/myusuf3/dotfiles))
- [Nicolas Gallagher](https://github.com/necolas) ([dotfiles](https://github.com/necolas/dotfiles))
- [Gary Bernhardt](https://github.com/garybernhardt) ([dotfiles](https://github.com/garybernhardt/dotfiles))
- [Sindre Sorhus](https://github.com/sindresorhus)
