#!/bin/env bash
# if you want all session names to have some prefix, invoke this script as rescreen_prefix
# (rename the script file or make a link)

SBASE=""
# see if we should use a session name prefix
fn=$(basename $0)
if [[ $fn =~ _.{1,3}$ ]]; then	# let prefix to be 1-3 char len
	SBASE=${fn##*_}
fi
screen -list
echo -n "Session name: $SBASE"
read sname
sname="$SBASE$sname"

# workaround that sometimes screen fails to set title if xterm-color256
export TERM=xterm
unset TERMCAP
# default PROMPT_COMMAND may overwrite screen title with something like "user@host pwd"
export PROMPT_COMMAND='echo -ne "\033]0;${STY#*.}\007"'

if (screen -list | fgrep "$sname"$'\t' | fgrep -v "$sname"$'\t(Dead'); then
    exec screen -dR "$sname"
else
    exec screen -S "$sname" -t "$sname"
fi

