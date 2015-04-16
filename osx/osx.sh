# Updatedb
alias updatedb="sudo /usr/libexec/locate.updatedb"

# Sweet Volume Shortcuts
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
function setvol() { 
	osascript -e "set volume ${1:-0}"
} 

# Suppress Mac Notification Warnings (eg ejecting drives improperly)
alias disablenotifs="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.UserNotificationCenter.plist"
alias enablenotifs="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.UserNotificationCenter.plist"

# get chmod value of a file for mac os
alias chmod-get-mac='stat -f "%OLp"'

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Chruby
alias start-ruby="source /usr/local/share/chruby/chruby.sh; chruby 2.1.2"

# dnsmasq
alias start-dnsmasq="sudo launchctl stop homebrew.mxcl.dnsmasq"
alias stop-dnsmasq="sudo launchctl start homebrew.mxcl.dnsmasq"
alias restart-dnsmasq="stop-dnsmasq; start-dnsmasq"
