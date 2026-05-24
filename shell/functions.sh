#!/bin/bash

# make directory and then cd into it
mkcd() { mkdir -p "$@" && cd "$_"; }

# Used in zsh theme for displaying current virtualenv
function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo " "`basename $VIRTUAL_ENV`
}

# start a SOCKS proxy
function socks() {
  server="$1"
  port="${2:-1080}"
  ssh -N -D $server:$port localhost
}

# kill all processes that match a certain name via grep
# `killname node` kills all processes that match `node`
# TODO: don't try to kill itself too
function killname() {
  processes=`ps ax | grep $1 | cut -d' ' -f 1 | awk '{printf $0 ", ";}'`
  while [[ -n $processes ]] ; do
    p=${processes%%,*}
    processes=${processes#* }
    kill -9 $p
  done
}

# print the public key for the given file (default: ~/.ssh/id_rsa.pub)
# print all public keys in ~/.ssh if no file is provided
function keyme() {
  if [ -z "$1" ]; then
    for file in ~/.ssh/*.pub; do
      echo "=== $file ==="
      cat $file
    done
  else
    echo "=== $1 ==="
    cat $1
  fi
}
