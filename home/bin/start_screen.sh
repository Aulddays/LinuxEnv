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

# screen does not recognize gb18030 but only gbk. Fake LANG so that we do not have to
# `:encoding gbk gbk` each time a screen is created or reattched
SCREENFAKELANG=""
# bash changed =~ behavior since v3.2. Put the regex into a variable to workaround
# https://stackoverflow.com/questions/218156/bash-regex-with-quotes/218217
gbre='(gb|GB)18030'
if [[ ${LANG-} && $LANG =~ $gbre ]]; then
	SCREENFAKELANG=${LANG/gb18030/gbk}
	SCREENFAKELANG=${SCREENFAKELANG/GB18030/GBK}
	SCREENFAKELANG="LANG=$SCREENFAKELANG "
fi

if (screen -list | grep -F ".$sname"$'\t' | fgrep -v "$sname"$'\t(Dead'); then
	rsname=$(screen -list | grep -F ".$sname"$'\t' | grep -Fv "$sname"$'\t(Dead' | head -n1 | grep -oE "[^"$'\t'"]+$sname"$'\t' | cut -f1)
    eval ${SCREENFAKELANG}exec screen -dR "$rsname"
else
    eval ${SCREENFAKELANG}exec screen -S "$sname" -t "$sname"
fi

