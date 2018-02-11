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

# Shell configuration
set -o pipefail
[[ $- == *i* ]] && stty stop '^P'	# bind XOFF flow control to ctrl-p, so that C-s does a forward cmd history search (reverse of C-r)

alias ls='ls --color=tty'
alias ll='ls -l --color=tty'
alias lh='ls -lh --color=tty'
alias la='ls -A --color=tty'
alias lla='ls -lA --color=tty'
alias l.='ls -d .* --color=tty'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias rsync='rsync -t'
alias hexdump='hexdump -C'
alias ..='cd ..'

# allow alias in sudo. bash checks only first word in cmd for alias by default,
# but if an alias value ends with sapce, the next word after it is also checked, so that `ll` in `sudo ll` will work
alias sudo='sudo '
alias xargs='xargs '
alias nohup='nohup '
# command completion for sudo
complete -cf sudo

export EDITOR=vim
export LESS=-RMfi
export LESSCHARSET=dos	# Works on most gb18030 chars. For all valid values refer to less/charset.c:charsets[]

if [ "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then    
	export TERMCAP=$(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')    
fi 
if [[ "$TERM" == "screen" ]]; then   # Do not allow PROMPT_COMMAND to modify session title 
	export PROMPT_COMMAND=""
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
# Simple file encryption/decryption
alias opensslenc='openssl aes-256-cbc -salt -e'
alias openssldec='openssl aes-256-cbc -d'

export PATH=$HOME/bin:$HOME/env/bin:$PATH
