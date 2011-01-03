# .bashrc

export HISTSIZE=1000000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export PATH=/home/cmaureir/bin/:$PATH


export HISTIGNORE="&:[bf]g:exit"
export INPUTRC=/etc/inputrc
export VISUAL=vim
export BROWSER=firefox
export PAGER=less
export MANPAGER=less
export MAILCHECK=0
export MAIL=~/.mail
export EDITOR=vim
export SVN_EDITOR=vim

NEGRO='\e[0;30m'
AZUL='\e[0;34m'
VERDE='\e[0;32m'
CYAN='\e[0;36m'
ROJO='\e[0;31m'
PURPURA='\e[0;35m'
MARRON='\e[0;33m'
GRISCLARO='\e[0;37m'
GRISOSCURO='\e[1;33m'
AZULCLARO='\e[1;34m'
VERDECLARO='\e[1;32m'
CYANCLARO='\e[1;36m'
ROJOCLARO='\e[1;31m'
PURPURACLARO='\e[1;35m'
AMARILLO='\e[1;33m'
BLANCO='\e[0;37m'
VOLVER='\e[0;0m'

export PS1="\[$BLANCO\]\h\[$ROJO\]\w\[$BLANCO\]»\[$ROJO\]≻\[$VOLVER\]"


alias ll='ls -l'
alias la='ls -A'
alias ls='ls --color'
alias l='ls -CF'
alias pin='ping -c 1 google.cl'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias vi='vim'
alias up='yaourt -Syyu --noconfirm; yaourt -Syyu --aur --noconfirm'


export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi
