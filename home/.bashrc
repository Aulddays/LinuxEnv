# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source customized definitions
if [ -f $HOME/.bashrccustom ]; then
	. $HOME/.bashrccustom
fi

# User specific aliases and functions

# if LANG other than zh_CN.gb18030 is needed, set LANGCUSTOM=... in ~/.bashrccustom
if [[ ! -z "$LANGCUSTOM" ]]; then
	export LANG="$LANGCUSTOM"
else
	export LANG=zh_CN.gb18030
fi

alias ls='ls --color=tty'
alias ll='ls -l --color=tty'
alias lh='ls -lh --color=tty'
alias la='ls -A --color=tty'
alias lla='ls -lA --color=tty'
alias l.='ls -d .* --color=tty'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias rsync='rsync -t'
set -o pipefail

export EDITOR=vim
export LESS=-RMfi

if [ "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then    
	export TERMCAP=$(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')    
fi 

# TIP: export HOSTNAME in ~/.bashrccustom changes hostname in command prompt
if [ "$PS1" ]; then
	PS1='$(code=$?;[[ $code = 0 ]] || printf "\[\e[48;5;53m\][$code] ")\[\e[38;5;136m\]${HOSTNAME} \[\e[38;5;153m\]\W \[\e[38;5;227m\]\$\[\e[0m\] '
fi

# helper functions
# join a bunch of strings
function strjoin { local IFS="$1"; shift; echo "$*"; }
# "\t" -> "\n"
alias trtn='tr "\t" "\n"'

export PATH=$HOME/bin:$HOME/env/bin:$PATH
