# reload .bashrc
alias bashrc='clear; . $HOME/.bashrc'

# define colors
Black='\e[0;30m'    # Black / Regular
Red='\e[0;31m'      # Red
Green='\e[0;32m'    # Green
Yellow='\e[0;33m'   # Yellow
Blue='\e[0;34m'     # Blue
Purple='\e[0;35m'   # Purple
Cyan='\e[0;36m'     # Cyan
White='\e[0;37m'    # White

BBlack='\e[1;30m'   # BBlack / Bold
BRed='\e[1;31m'     # BRed
BGreen='\e[1;32m'   # BGreen
BYellow='\e[1;33m'  # BYellow
BBlue='\e[1;34m'    # BBlue
BPurple='\e[1;35m'  # BPurple
BCyan='\e[1;36m'    # BCyan
BWhite='\e[1;37m'   # BWhite

UBlack='\e[4;30m'   # UBlack / Underline
URed='\e[4;31m'     # URed
UGreen='\e[4;32m'   # UGreen
UYellow='\e[4;33m'  # UYellow
UBlue='\e[4;34m'    # UBlue
UPurple='\e[4;35m'  # UPurple
UCyan='\e[4;36m'    # UCyan
UWhite='\e[4;37m'   # UWhite

BGBlack='\e[40m'    # BGBlack / Background
BGRed='\e[41m'      # BGRed
BGGeeen='\e[42m'    # BGGreen
BGYellow='\e[43m'   # BGYellow
BGBlue='\e[44m'     # BGBlue
BGPurple='\e[45m'   # BGPurple
BGCyan='\e[46m'     # BGCyan
BGWhite='\e[47m'    # BGWhite

NC='\e[0m'          # Text Reset / No Color

colortest() { for c in {,B,U,BG}{Black,Red,Green,Yellow,Blue,Purple,Cyan,White}; do echo -e ${!RWhite}${!c}$c${NC}; done; echo -e "${NC}"; }

# Realias presets as such: PS1=$PS1z1
PS1z1="\[${BGreen}\]\u\[${BCyan}\]@\[${BWhite}\]\h\[${Cyan}\]:\[${Cyan}\]\w\[${BGreen}\]$ \[${NC}\]"
PS1z2="\[${Cyan}\]\u\[${BBlue}\]@\[${White}\]\h\[${Cyan}\]:\[${BBlue}\]\w\[${Cyan}\]$ \[${NC}\]"
PS1z3="\[${Red}\]\u\[${BYellow}\]@\[${BGreen}\]\h\[${Green}\]:\[${BYellow}\]\w\[${Green}\]$ \[${NC}\]"
PS1z4="\[${Purple}\]\u\[${BCyan}\]@\[${NC}\]\h\[${BBlue}\]:\[${BGreen}\]\w\[${White}\]$ \[${NC}\]"
PS1z5="\[${BCyan}\]\u\[${White}\]@\[${Blue}\]\h\[${BBlue}\]:\[${Cyan}\]\w\[${Blue}\]$ \[${NC}\]"

# Yay Colors
alias tmux="tmux -2" # vim full color
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# make directory and move into it
mkcdr() { mkdir -p $1 && cd $1; }

alias 'ps?'='ps ax | grep '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


