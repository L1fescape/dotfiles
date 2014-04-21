# Functions
let randnum=$RANDOM%12660

function genhash() {
  openssl rand -base64 ${1:-12}
}

# make directory and then cd into it
mkcd() { mkdir -p "$@" && cd "$_"; }


function server() {
	# needs to be more elegantly written. basically just default to 
	# port 8000 if no por is given. if the 'o' flag is passed, also
	# open the server in a browser.
	local COMMAND=$1;
	if [[ $COMMAND = "-o" ]] then;
		local PORT=${2:-8000}
		open "http://localhost:${PORT}/"
	else
		PORT=${1:-8000}
	fi
  # determine python version. one way to do this is:
  #
  # pyversion=`python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))'`
  # if [ $pyversion -eq 0 ]; then
  #     python3 -m http.server "$PORT"
  # else 
  #     python -m SimpleHTTPServer "$PORT"
  # fi
  #
  # I thought for a while launching a python interpreter was slow so I found another way:
  #
  # pyversion=`python --version`
  # pyversion=`echo ${pyversion#* } | head -c 1`
  # if [ $pyversion -eq 3 ]; then
  #     python3 -m http.server "$PORT"
  # else 
  #     python -m SimpleHTTPServer "$PORT"
  # fi
  #
  # I like the first one more. Also turns out `python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))'`
  # doesn't launch an interpreter, just compailes it and evaluates it. The slowness is from python 3 importing
  # the http.server package. Python 2 appears to be faster at this. 
  pyversion=`python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))'`
  if [ $pyversion -eq 0 ]; then
      python3 -m http.server "$PORT"
  else 
      python -m SimpleHTTPServer "$PORT"
  fi
}

# list all colors (useful for customizing zsh theme)
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

# Used in zsh theme for displaying current virtualenv
function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo " "`basename $VIRTUAL_ENV`
}
# Chrome Dev tools
function devtools-phone () {
  port="${1:-9222}"
  adb forward tcp:$port localabstract:chrome_devtools_remote
  echo "Now listening on port $port"
}

# Forward a port on a remote server to your local machine. Now with popping!
function portForward() {
  # With `portForward pop`, the ssh portforwarding instance with the lowest pid
  # (process id) will be killed. 
  # TODO: Currently no check to see if there is at least one forwarded port. 
  #       Not really a problem, will just yell at you.
  # TODO: Naively pops off connetion. Anything with 'ssh -L' will match. 
  if [[ "$1" == "pop" ]]
  then
    process=`ps ax | grep "ssh -L" | cut -d' ' -f 1 | head -1`
    kill -9 $process
  else
    firstServer="$1"
    firstPort="${2:-3307}"
    secondServer="${3:-localhost}"
    secondPort="${4:-3306}"
    ssh -L $firstPort:$secondServer:$secondPort $firstServer -f -N
  fi
}

function socks() {
  server="$1"
  port="${2:-1080}"
  ssh -N -D $server:$port localhost
}

# kill all processes that match a certain name via grep
# `killname node` kills all processes that match `node`
# TODO: don't kill the last process in the list, which is grep being run via
#       killname. by the time it gets to killing off that process, it will 
#       no longer exist.
function killname() {
  processes=`ps ax | grep $1 | cut -d' ' -f 1 | awk '{printf $0 ", ";}'`
  while [[ -n $processes ]] ; do
    p=${processes%%,*}
    processes=${processes#* }
    kill -9 $p
  done
}

# open results of grep in vim tabs
function vimgrep() {
  #results=($(grep -rn $1 . | awk '{ split($1,a,":"); print a[1] }' | sort | uniq ))
  #vim -p $results;
  vim -p `grep -rl $1 .`
  #vim +6 bootstrap.css +"tabnew +3 main.css" +"tabnew +7 main.css"
}

function keyme() {
  file=${1:-~/.ssh/id_rsa.pub}
  cat $file
}
