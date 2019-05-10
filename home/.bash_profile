# .bash_profile

# README:
# Login shell (-l/--login) reads /etc/profile first, and then the first it finds of: ~/.bash_profile, ~/.bash_login, and ~/.profile
# Interactive but non-login shell (-i) reads /etc/bash.bashrc and ~/.bashrc, in that order (unless the --rcfile option is used and tells it to look elsewhere)
# Non-interactive shells, e.g. started from within another program without using the -l or -i flags, reads the file specified in the BASH_ENV environment variable
# When run as sh as a login shell, it will read /etc/profile and ~/.profile, in that order
# When run as sh as an interactive non-login, it reads the file specified in ENV

# Get stuffs in ~/.bashrc for login shells
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

