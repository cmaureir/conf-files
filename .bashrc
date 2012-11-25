if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
source /usr/share/git/completion/git-prompt.sh

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
export VISUAL=vim
export BROWSER=firefox
export PAGER=less
export MANPAGER=less
export EDITOR=vim
export SVN_EDITOR=vim
export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none
#export TERM=xterm-256color

NEGRO='\[\033[0;30m\]'
AZUL='\[\033[0;34m\]'
VERDE='\[\033[0;32m\]'
CYAN='\[\033[0;36m\]'
ROJO='\[\033[0;31m\]'
PURPURA='\[\033[0;35m\]'
MARRON='\[\033[0;33m\]'
GRISCLARO='\[\033[0;37m\]'
GRISOSCURO='\[\033[1;33m\]'
AZULCLARO='\[\033[1;34m\]'
VERDECLARO='\[\033[1;32m\]'
CYANCLARO='\[\033[1;36m\]'
ROJOCLARO='\[\033[1;31m\]'
PURPURACLARO='\[\033[1;35m\]'
AMARILLO='\[\033[1;33m\]'
BLANCO='\[\033[0;37m\]'
VOLVER='\[\033[0m\]'

alias ls="ls --color -CF --group-directories-first"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias vi="vim"

export PS1="${BLANCO}\h${ROJO}\w${BLANCO} ${AZUL}$(__git_ps1 "%s ")${ROJO}\\$ ${VOLVER}"
#export PYTHONPATH=${PYTHONPATH}:/home/cmaureir/amuse/amuse-6.0/test:/home/cmaureir/amuse/amuse-6.0/src
#export AMUSE_DIR=/home/cmaureir/Downloads/amuse/amuse-6.0
alias sphinx-build='sphinx-build2'
