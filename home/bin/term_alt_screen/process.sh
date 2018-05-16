#!/bin/env bash
# Disable the annoy 'alternate screen' function in xterm

infocmp -l xterm-256color > xterm-256color
sed 's/[sr]mcup=[^,]*,//' xterm-256color > xterm-256color-na
tic xterm-256color-na
