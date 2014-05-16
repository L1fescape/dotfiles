#!/bin/bash

PATH=~/.dotfiles/bin:~/bin:$PATH
# Paths
PATH=$PATH:$HOME/code/tools/mongodb/bin # Add mongo to PATH
PATH=$PATH:$HOME/code/tools/adt/sdk/platform-tools

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Fix for homebrew pathing
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

# Virtualenv Settings
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT='1' # don't prepend active environment to prompt
alias start-virtualenv="source /usr/local/bin/virtualenvwrapper.sh"

# NPM Paths
export PATH=$PATH:/usr/local/share/npm/bin

# MySQL
export PATH=$PATH:/usr/local/mysql/bin

# Go Paths
export GOPATH=$HOME/.go