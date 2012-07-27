# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="andrewk"

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias http="http"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian lol)

#lets open anything python, cpp, or js with vim
alias -s js=vim
alias -s py=vim
alias -s cpp=vim

#256 colors
export TERM="xterm-256color"

# Functions
let randnum=$RANDOM%12660

mkcd() { mkdir -p "$@" && cd "$_"; }

function server() {
	local port="${1:-8000}"
	python -m SimpleHTTPServer "$port"
}

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/andrewk/.rvm/gems/ruby-1.9.2-p290/bin:/home/andrewk/.rvm/gems/ruby-1.9.2-p290@global/bin:/home/andrewk/.rvm/rubies/ruby-1.9.2-p290/bin:/home/andrewk/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
