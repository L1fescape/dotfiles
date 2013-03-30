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
alias updatedb="sudo /usr/libexec/locate.updatedb" # updatedb for mac

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git ruby rails lol vi-mode osx)

# 256 colors
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

# DNS
alias dnsflush="sudo killall -HUP mDNSResponder"
alias flushdns="dnsflush"

# MAC Address
alias getmac="ifconfig en0 | grep ether | cut -c8-"
alias genmac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'"
function setmac() {
	sudo ifconfig en0 ether "$1"
}

# Change Hostname
function hostname() {
	sudo scutil --set HostName "$1"
	sudo scutil --set LocalHostName "$1"
}

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

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

# Mac restart apache
alias apacherestart="sudo apachectl restart"
alias apacheconfig="sudo apachectl configtest"

# Paths
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH
PATH=$PATH:$HOME/prog/tools/mongodb/bin # Add mongo to PATH
PATH=$PATH:/Users/andrewk/prog/tools/android-sdk-macosx/platform-tools
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
source $ZSH/oh-my-zsh.sh

# Cryptic Candy
export CCETC_ROOT=/Users/andrewk/prog/cryptic-candy/ccetc

# AWS RDS
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
export EC2_REGION=us-east-1
export AWS_RDS_HOME=/Users/andrewk/prog/tools/aws-rds
export AWS_CREDENTIAL_FILE=$AWS_RDS_HOME/credential-file-path.template
PATH=$PATH:$AWS_RDS_HOME/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
