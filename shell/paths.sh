#!/bin/bash

# Paths

## Fix for homebrew pathing
homebrew=/usr/local/bin:/usr/local/sbin

## NPM Paths
npm=/usr/local/share/npm/bin

## MySQL
mysql=/usr/local/mysql/bin

## Haskell
haskell=~/.cabal/bin

## Export paths
export PATH=$homebrew:$npm:$mysql:$haskell:$PATH


# Variables

## Virtualenv variables and settings
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT='1' # don't prepend active environment to prompt

## Go variables
export GOPATH=$HOME/.go

