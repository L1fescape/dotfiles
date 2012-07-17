. $HOME/.bashrc
case "$-" in *i*) byobu-launcher && exit 0; esac;

[[ -s "/home/andrewk/.rvm/scripts/rvm" ]] && source "/home/andrewk/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
