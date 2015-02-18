## Colors
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BROWN="\033[0;33m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
WHITE="\033[1;37m"
CYAN="\033[0;36m"
GRAY="\033[0;37m"
# Bold color
BBLUE="\033[1;34m"
BGREEN="\033[1;32m"
BCYAN="\033[1;36m"
BRED="\033[1;31m"
BPURPLE="\033[1;35m"
# Remove color
OFF="\033[0m"

# set up command prompt
function __prompt_command()
{
    # capture the exit status of the last command
    EXIT="$?"
    PS1=""

    if [ $EXIT -eq 0 ]; then PS1+="\[$GREEN\][✔]\[$OFF\] "; else PS1+="\[$RED\][✘]\[$OFF\] "; fi
    #happy=$'\u263A '
    #sad=$'\u2639 '
    #if [ $EXIT -eq 0 ]; then PS1+="[\[$GREEN\]\[$happy\]\[$OFF\]]"; else PS1+="[\[$RED\]\[$sad\]\[$OFF\]]"; fi

    # if logged in via ssh shows the ip of the client
    if [ -n "$SSH_CLIENT" ]; then PS1+="\[$YELLOW\]("${SSH_CLIENT%% *}")\[$OFF\]"; fi

    # basic information (user@host:path)
    #PS1+="\[$GRAY\]\u\[$OFF\]\[$RED\]@\[$WHITE\]\h\[$OFF\]:\[$BLUE\]\w\[$OFF\] "
    PS1+="\[$WHITE\]\h\[$OFF\]:\[$RED\]\w\[$OFF\] "

    # check if inside git repo
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        # parse the porcelain output of git status
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=$GREEN
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=$PURPLE
        else
            local Color_On=$RED
        fi

        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD. (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi

        # add the result to prompt
        PS1+="\[$Color_On\][$branch]\[$OFF\] "
    fi

    # prompt $ or # for root
    PS1+="\$ "
}
PROMPT_COMMAND=__prompt_command

function installed(){
    pacman -Qei | awk '/^Name/ { name=$3 } /^Groups/ { if ( $3 != "base" && $3 != "base-devel" ) { print name } }'
}

# Update system
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
    for i in $(find . | grep "\.un~")
    do
        rm -f $i
    done
}

# Remove .swp files from some directory
function clean-swp(){
    for i in $(find . | grep "\.swp")
    do
        rm -f $i
    done
}

export HISTSIZE=1000000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export PATH=$PATH:~/bin

export GIT_PS1_SHOWDIRTYSTATE=1
export HISTIGNORE="&:[bf]g:exit"
export VISUAL="vim"
export BROWSER="firefox"
export PAGER=less
export MANPAGER=less
export EDITOR=vim
export SVN_EDITOR=vim
export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none
export TERM=xterm-256color
export GOPATH=~/.go
export GOROOT=/usr/lib/go
export GOOS=linux
export GLOBUS_LOCATION=/opt/globus

# Connect my cellphone
alias android-connect='sudo mtpfs -o allow_other /media/nexus4'
alias android-disconnect='sudo umount /media/nexus4'
alias android-disconnect2='sudo fusermount -u /media/nexus4'
alias globus='source $GLOBUS_LOCATION/share/globus-user-env.sh'


alias ls="ls --color -CF --group-directories-first"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Fixing errors on calling vim
alias vi="nvim"
alias vm="nvim"
alias bim="nvim"
alias bm="nvim"

## Python
#alias python='python2'

# Skype
export  PULSE_LATENCY_MSEC=60

# GSR
export PYTHONPATH=$PYTHONPATH:/home/cmaureir/repos/gadget-snapshot-reader
