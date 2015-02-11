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

# l337 H4x0r
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

# Mac Spacers in Dock
alias dockaddspace="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'; killall Dock"

# Start MySQL Mac
alias mysql-start="mysql.server start"
alias mysql-stop="mysql.server stop"

# Chrome tricks
alias chrome="open /Applications/Google\ Chrome.app/"
alias chrome-web="chrome --args --disable-web-security"

# Mac restart apache
alias apache-restart="sudo apachectl restart"
alias apache-start="sudo apachectl start"
alias apache-stop="sudo apachectl stop"
alias apache-config="sudo apachectl configtest"

# Set your screensaver as your background (can get insanely distracting)
alias background-screensaver="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background"

# Mac Network Utilities
alias network-diagnostics="open /System/Library/CoreServices/Wi-Fi\ Diagnostics.app"

# iTunes (borowwed from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/osx/osx.plugin.zsh)
function itunes() {
  local opt=$1
  shift
  case "$opt" in
    launch|play|pause|stop|rewind|resume|quit)
      ;;
    mute)
      opt="set mute to true"
      ;;
    unmute)
      opt="set mute to false"
      ;;
    next|previous)
      opt="$opt track"
      ;;
    ""|-h|--help)
      echo "Usage: itunes <option>"
      echo "option:"
      echo "\tlaunch|play|pause|stop|rewind|resume|quit"
      echo "\tmute|unmute\tcontrol volume set"
      echo "\tnext|previous\tplay next or previous track"
      echo "\thelp\tshow this message and exit"
      return 0
      ;;
    *)
      print "Unkonwn option: $opt"
      return 1
      ;;
  esac
  osascript -e "tell application \"iTunes\" to $opt"
}

function itunes-state() {
  state=`osascript -e 'tell application "iTunes" to player state as string'`;
  echo "iTunes is currently $state.";
  if [ $state = "playing" ]; then
    artist=`osascript -e 'tell application "iTunes" to artist of current track as string'`;
    track=`osascript -e 'tell application "iTunes" to name of current track as string'`;
    echo "Current track $artist:  $track";
  fi
}

# CUPS printing service
alias cups-on="cupsctl WebInterface=yes"
alias cups-off="cupsctl WebInterface=no"

# Chruby
source /usr/local/share/chruby/chruby.sh
chruby 2.1.2

# dnsmasq
alias start-dnsmasq="sudo launchctl stop homebrew.mxcl.dnsmasq"
alias stop-dnsmasq="sudo launchctl start homebrew.mxcl.dnsmasq"
alias restart-dnsmasq="stop-dnsmasq; start-dnsmasq"
