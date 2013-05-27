# z.bashrc is used to setup basic environment settings and load other files

# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

#256 colors
export TERM="xterm-256color"

# set vi mode
set -o vi
if [ -n "$DISPLAY" ]; then
         BROWSER=chromium
         fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting ofgnorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# load all my bash functions and aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
        fi
        
# aliases
alias la="ls -a"

# rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
