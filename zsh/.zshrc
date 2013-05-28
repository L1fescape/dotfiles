# Determine OS
[[ `uname` == "Darwin" ]] && OS="osx" || OS="linux" # not checking for windows. screw that.

# Path oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="andrewk"

# Zsh settings
COMPLETION_WAITING_DOTS="true"
plugins=(git ruby rails vi-mode)

# init z (https://github.com/rupa/z)
[ "$OS" = "osx" ] && . `brew --prefix`/etc/profile.d/z.sh

# init rvm
source ~/.rvm/scripts/rvm

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "~/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# zsh timeout. needs to be a little further down than then vi-mode plugin because vi-mode overwrites this
KEYTIMEOUT=1

# Load everything else
source ~/.paths
source ~/.aliases
source ~/.functions
source ~/.bindings
[ "$OS" = "osx" ] && source ~/.osx;
