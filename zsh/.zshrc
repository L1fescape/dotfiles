# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="andrewk"



# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias http="http"
alias slime='open -a "Sublime Text 2"'
alias :q="exit"
alias la="cat ~/.zshrc | grep alias"

#lets open anything python, cpp, or js with vim
alias -s js=vim
alias -s py=vim
alias -s cpp=vim



# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git ruby rails lol)

#256 colors
export TERM="xterm-256color"




# Functions
let randnum=$RANDOM%12660

mkcd() { mkdir -p "$@" && cd "$_"; }

function server() {
	local port="${1:-8000}"
	python -m SimpleHTTPServer "$port"
}

# IP addresses
alias localip="ipconfig getifaddr en0"
alias globalip="curl ifconfig.me"
alias gateway="route -n get default | sed -n 4p | cut -c14-"
alias whois="whois -h whois-servers.net"

# MAC
alias mac="ifconfig en0 | grep ether | cut -c8-"
alias dnsflush="sudo killall -HUP mDNSResponder"
alias flushdns="dnsflush"

# Change Hostname
function hostname() {
	sudo scutil --set HostName "$1"
	sudo scutil --set LocalHostName "$1"
}

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Sweet Volume Shortcuts
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
function setvol() { 
	osascript -e "set volume ${1:-0}"
} 

# Suppress Mac Notification Warnings (eg ejecting drives improperly)
alias disablenotifs="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.UserNotificationCenter.plist"
alias enablenotifs="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.UserNotificationCenter.plist"

# Chrome tricks
alias chrome="open /Applications/Google\ Chrome.app/"
alias chrome-web="chrome --args --disable-web-security"




# Paths
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH
PATH=$PATH:$HOME/prog/tools/mongodb/bin # Add mongo to PATH
PATH=$PATH:/Users/andrewk/prog/tools/android-sdk-macosx/platform-tools
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
source $ZSH/oh-my-zsh.sh

# Cryptic Candy
export CCETC_ROOT=/Users/andrewk/prog/cryptic-candy/ccetc

# Random Samuel L Jackson Quotes
#cowsay -f tux $(/opt/local/libexec/gnubin/shuf -n 1 dotfiles/quotes) | lolcat
