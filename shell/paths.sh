#!/bin/bash

# Paths

LOCAL_BIN=$HOME/.local/bin # neovim and tree-sitter, installed by install.sh
HOMEBREW_BIN=/usr/local/bin:/usr/local/sbin
NPM_BIN=$HOME/.npm-global/bin
DOTNET_BIN=$HOME/.dotnet

export DOTNET_ROOT=$DOTNET_BIN
export PATH=$LOCAL_BIN:$HOMEBREW_BIN:$NPM_BIN:$DOTNET_BIN:$PATH

## Virtualenv variables and settings
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT='1' # don't prepend active environment to prompt
