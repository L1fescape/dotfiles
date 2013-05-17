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

alias fucking="sudo"
alias fuck="sudo" # fuck !! > fucking !!
alias please="sudo"
#alias ssh="autossh -M 2000"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git ruby rails vi-mode)

# 10ms for key sequences (default is 0.4 seconds)
KEYTIMEOUT=1

# Functions
let randnum=$RANDOM%12660

function genhash() {
  openssl rand -base64 ${1:-12}
}

# YOLO
alias yolo="git add -A && git commit -am '#YOLO' && git push origin master"

# Django
alias django-new="django-admin.py startproject"
alias django-start="python manage.py runserver"

# Gource
alias gourcedef="gource -1280x720 --time-scale 3.0 --seconds-per-day 1 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4"

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

# Mac Spacers in Dock
alias dockaddspace="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'; killall Dock"

# Start MySQL Mac
alias startmysql="sudo /usr/local/mysql/bin/mysqld_safe"

# Chrome tricks
alias chrome="open /Applications/Google\ Chrome.app/"
alias chrome-web="chrome --args --disable-web-security"

# Mac restart apache
alias apacherestart="sudo apachectl restart"
alias apacheconfig="sudo apachectl configtest"

# Virtualenv Settings
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Paths
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH
PATH=$PATH:$HOME/prog/tools/mongodb/bin # Add mongo to PATH
PATH=$PATH:$HOME/prog/tools/android-sdk-macosx/platform-tools
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
source $ZSH/oh-my-zsh.sh

# Cryptic Candy
export CCETC_ROOT=$HOME/prog/cryptic-candy/ccetc

# AWS
export AWS_HOME=$HOME/prog/tools/aws
export AWS_CREDENTIAL_FILE=$AWS_HOME/aws-credential-file.conf
## RDS
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
export AWS_RDS_HOME=$AWS_HOME/rds
export EC2_REGION=us-east-1
## Elastic Beanstalk
export ELASTICBEANSTALK_URL="https://elasticbeanstalk.us-east-1.amazonaws.com"
export AWS_EB_HOME=$AWS_HOME/eb
PATH=$PATH:$AWS_RDS_HOME/bin:$AWS_EB_HOME/macosx/python2.7

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


## Newrelic Android
export ANDROID_HOME=$HOME/prog/tools/adt/sdk
export NEWRELIC_HOME=$HOME/prog/tools/adt/app-addons/newrelic-android-1.347
export PATH="$PATH:/Users/andrewk/prog/tools/adt/app-addons/newrelic-android-1.347/bin"
alias ant='nrandroid-ant '


## re-bind zsh backwards search (gets unbound by vi-mode plugin)
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[3~' delete-char
bindkey '^R' history-incremental-search-backward

# use v to launch edit command
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
