# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi

function up(){
    yaourt -Syy
    yaourt -Su --noconfirm
    yaourt -Su --aur --noconfirm
}

export HISTSIZE=1000000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export PATH=/home/cmaureir/bin/:$PATH

export GIT_PS1_SHOWDIRTYSTATE=1
export HISTIGNORE="&:[bf]g:exit"
export INPUTRC=/etc/inputrc
export VISUAL=vim
export BROWSER=chromium
export PAGER=less
export MANPAGER=less
export MAILCHECK=0
export MAIL=~/Maildir
export EDITOR=vim
export SVN_EDITOR=vim
export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none

export QT_PLUGIN_HOME=$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/
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

alias ll='ls -l'
alias la='ls -A'
alias ls='ls --color -CF --group-directories-first'
alias l='ls -CF'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias vi='vim'

export PATH=$PATH:/opt/mpich2/bin/

export PS1="\[$BLANCO\]\h\[$ROJO\]\w\[$BLANCO $AZUL \$(__git_ps1 '%s ')\[$ROJO\]\]>>\[$VOLVER\]"
