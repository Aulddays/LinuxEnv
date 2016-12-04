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

# workaround that screen fails to set title if xterm-color256
export TERM=xterm
unset TERMCAP

if (screen -list | fgrep "$sname"$'\t' | fgrep -v "$sname"$'\t(Dead'); then
    screen -dR "$sname"
else
    screen -S "$sname" -t "$sname"
fi

