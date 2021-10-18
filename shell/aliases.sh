#!/bin/bash

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias vi="vim"
alias v="vim"

alias d="docker"
alias dc="docker-compose"

alias :q="exit"
alias :Q="exit"

alias s="ls" # ;s
alias ks="ls" # I mistype ls often
alias sl="ls"
# List all files colorized in long format
alias l="ls -l ${colorflag}"
alias ls="ls ${colorflag}"
alias lsa="ls -la ${colorflag}"
alias la="ls -lptra ${colorflag}"

alias diff='vim -d'
alias co='cp'

alias tmux='tmux -2' # fix for tmux with 256 colors in ubuntu
alias t='tmux'
alias ts='tmux ls'
# try to reattach to an existing tmux session, otherwise create one
function ta() { 
  if [ -n "$1" ]
  then
    tmux attach-session -t $1
  else
    tmux attach || tmux
  fi
}

alias 'ps?'='ps ax | grep '

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# Get chmod value of a file
alias chmod-get='stat --format "%a"'


# IP addresses
function localip() {
  IP=`ipconfig getifaddr en0`
  if [ "$IP" = "" ]; then IP=`ipconfig getifaddr en1`; fi
  echo "$IP"
}
alias globalip="curl ifconfig.me"
alias externalip="globalip"
alias gateway="route -n get default | sed -n 4p | cut -c14-"

alias arp-local="arp-scan --interface=en0 --localnet"
alias arp-local2="arp-scan --interface=en0 192.168.1.1/24"

# Flush Directory Service cache
alias dnsflush="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# MAC Address
alias getmac="ifconfig en0 | grep ether | cut -c8-"
alias genmac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'"
function setmac() {
	sudo ifconfig en0 ether "$1"
}

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Colorized Man Pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

