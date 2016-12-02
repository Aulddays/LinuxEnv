# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export LANG=zh_CN.gb18030

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias rsync='rsync -t'

export EDITOR=vim
export LESS=-RMfi

if [ "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then    
	export TERMCAP=$(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')    
fi 

if [ "$PS1" ]; then
	PS1='\[\e[38;5;136m\]${HOSTNAME} \[\e[38;5;153m\]\W \[\e[38;5;227m\]\$\[\e[0m\] '
fi

# helper functions
# join a bunch of strings
function strjoin { local IFS="$1"; shift; echo "$*"; }
# "\t" -> "\n"
alias trtn='tr "\t" "\n"'

export PATH=$HOME/bin:$HOME/env/bin:$PATH
