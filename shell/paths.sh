#!/bin/bash

# Paths

## Fix for homebrew pathing
homebrew=/usr/local/bin:/usr/local/sbin

## NPM Paths
npm=/usr/local/share/npm/bin

## Export paths
export PATH=$homebrew:$npm:$PATH

## Virtualenv variables and settings
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT='1' # don't prepend active environment to prompt

alias load_nvm='export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
alias node='unalias node npm yarn && load_nvm && node'
alias npm='unalias node npm yarn && load_nvm && npm'
alias yarn='unalias node npm yarn && load_nvm && yarn'
