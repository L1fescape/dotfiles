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

## Go variables
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
