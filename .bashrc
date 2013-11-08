## Colors
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BROWN="\033[0;33m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
WHITE="\033[0;37m"
CYAN="\033[0;36m"
GRAY="\033[0;37m"
# Bold color
BBLUE="\033[1;34m"
BGREEN="\033[1;32m"
BCYAN="\033[1;36m"
BRED="\033[1;31m"
BPURPLE="\033[1;35m"
BGRAY="\033[1;33m"
# Remove color
OFF="\033[0m"

# function to remember the result of the previous command
function __stat() {
    if [ $? -eq 0 ]; then
        echo -en "$GREEN[✔]$OFF"
    else
        echo -en "$RED[✘]$OFF"
    fi
}

echo $(__stat)

# Fix git_prompt variable independent of the system
function __git_prompt() {

    local git_status="`git status -unormal 2>&1`"

    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
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
        echo -ne "$Color_On[$branch]$OFF "
    fi
}

# Update system
function up(){
    yaourt -Syy
    yaourt -Su --noconfirm
    yaourt -Su --aur --noconfirm
}

# Look for orphans packages in the system
function orphans(){
    orp=$(pacman -Qtdq)
    if [ ! -z "$orp"];then
        print $orp
        echo "Remove? [y/n]";
        read ans
        if $ans ==  'Y' || $ans == 'y';then
            pacman -Rscn $(pacman -Qtdq)
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
export PATH=$PATH:/home/cmaureir/bin

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
export TERM=xterm-256color

# Connect my cellphone
alias android-connect='sudo mtpfs -o allow_other /media/nexus4'
alias android-disconnect='sudo umount /media/nexus4'
alias android-disconnect2='sudo fusermount -u /media/nexus4'


alias ls="ls --color -CF --group-directories-first"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Fixing errors on calling vim
alias vi="vim"
alias vm="vim"
alias bim="vim"
alias bm="vim"

# Prompt
PS1=""
PS1+='$(__stat) '$OFF
PS1+="$WHITE\h$OFF:$RED\w$OFF "
PS1+='$(__git_prompt)'$OFF
PS1+="$GREEN\$$OFF "
export PS1

