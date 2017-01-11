autoload -U colors && colors
autoload -U compinit && compinit
setopt PROMP_TSUBST
setopt nonomatch # Avoid expanding the "*"

# History
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


# Bindkeys
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kich1]}" overwrite-mode
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey "${terminfo[kpp]}" up-line-or-history
bindkey "${terminfo[knp]}" down-line-or-history


# set up command prompt
function __prompt_command()
{
    # capture the exit status of the last command
    EXIT="$?"
    TMP=""

    if [ $EXIT -eq 0 ]; then
        TMP+="%{$fg[green]%}[✔]%{$reset_color%} ";
    else
        TMP+="%{$fg[red]%}[✘]%{$reset_color%} ";
    fi

    # if logged in via ssh shows the ip of the client
    if [ -n "$SSH_CLIENT" ]; then
        TMP+="%{$fg[yellow]%}("${SSH_CLIENT%% *}")%{$reset_color%}";
    fi

    TMP+="%{$fg[gray]%}%m%{$reset_color%}:%{$fg[red]%}%~%{$reset_color%}"
    echo $TMP
}

# Installed packages
function installed(){
    pacman -Qei | awk '/^Name/ { name=$3 } /^Groups/ { if ( $3 != "base" && $3 != "base-devel" ) { print name } }'
}

# Update system alias
function up(){
    yaourt -Syy
    yaourt -Su --noconfirm
    yaourt -Su --aur --noconfirm
}

# Look for orphans packages in the system
function orphans(){
    orp=$(yaourt -Qtdq)
    if [[ ! -z "$orp" ]];then
        echo $orp
        echo "Remove? [y/n]";
        read ans
        if [[ $ans ==  'Y' || $ans == 'y' ]];then
            yaourt -Rscn $(pacman -Qtdq)
        else
            echo "Leaving"
        fi
    else
        echo "No orphans";
    fi
}

# Remove tmp vim files to remember history
function clean-un(){
    for i in $(find . | grep --color=never "\.un~")
    do
        rm -f $i
    done
}

# Remove .swp files from some directory
function clean-swp(){
    for i in $(find . | grep --color=never "\.swp")
    do
        rm -f $i
    done
}

## Exports

setopt APPEND_HISTORY
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
#export GIT_PS1_SHOWDIRTYSTATE=1
export HISTIGNORE="&:[bf]g:exit"
export VISUAL="vim"
export BROWSER="chromium"
export PAGER=less
export MANPAGER=less
export EDITOR=vim
export SVN_EDITOR=vim
export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none
export TERM=xterm-256color
export GLOBUS_LOCATION=/opt/globus_toolkit-6.0.1464122925-x86_64-unknown-linux-gnu-Build-229/globus
export LESS="-R"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Skype
export  PULSE_LATENCY_MSEC=60

# GSR
export PYTHONPATH=$PYTHONPATH:~/repos/gadget-snapshot-reader
export PATH=~/bin:$PATH

# Ruby
export PATH=$PATH:~/.gem/ruby/2.3.0/bin

# Go
export GOPATH=~/.go
export GOROOT=/usr/lib/go
export GOOS=linux

## Aliases

# Connect my cellphone
alias android-connect='sudo mtpfs -o allow_other /media/oneplus'
alias android-disconnect='sudo umount /media/oneplus'
alias android-disconnect2='sudo fusermount -u /media/oneplus'

# Globus
alias globus='source $GLOBUS_LOCATION/share/globus-user-env.sh'

# Commands
alias ls="ls --color -CF --group-directories-first"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Fixing errors on calling vim
alias vi="vim"
alias vm="vim"
alias bim="vim"
alias bm="vim"

# Fixing errors on calling make
alias mae="make"
alias maek="make"
alias mke="make"
alias mek="make"

# Fixing errors on calling ls
alias lsls='ls'
alias sls='ls'
alias lls='ls'


# Amazing du
alias dup="du -sch .[!.]* * |sort -h"
alias grep="grep --color=always"

# Arch Linux
#alias pacman='pacman --color=always'
#alias yaourt='yaourt --color=always'
alias brokensymlinks='sudo find . -type l -! -exec test -e {} \; -print'

# For Git Stuff
source ~/.zsh-stuff/zsh-git-prompt/zshrc.sh

# Prompt
function precmd {
    PROMPT="%{$fg[red]%}$(__prompt_command) $(git_super_status) %# "
}

alias qq="qstat | sort -n"

# Modules
#source /usr/share/Modules/init/zsh
# Globus proxy
alias proxy="grid-proxy-init -bits 1024"

# Fix Java app
export _JAVA_AWT_WM_NONREPARENTING=1

# Fix Java font
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
