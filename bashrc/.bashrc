# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=10000
shopt -s histappend
# combine multiline commands into one in history
shopt -s cmdhist
# ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias sl='ls '
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

###############################################################################
## Aliases
###############################################################################

# NOTE: spaces after the command force what follows to expand (if it has an alias)
alias sudo="sudo "
alias vim="nvim "
alias hex="hexyl "
alias apt="apt-fast "
alias calc="gnome-calculator"
alias new="gnome-terminal"  # open new terminal
alias resource="source ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"
# alias cp="rsync -avz"
alias cl="clear"
alias lear="clear"  # common typo

# Toggle maximum size for current terminal window
alias maxwin="wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz"

# Add CD aliases for entering parent dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# List all open ports
alias openports='netstat -nape --inet'

# Get size of current directory recursively
alias dirsize="du -hs ."

# List local users
alias lsusers="cut -d: -f1 /etc/passwd"

# Virtualenv
alias mkenv="virtualenv -p python3 env && source env/bin/activate"
alias activate="source env/bin/activate"

# Docker
alias dcps="docker-compose ps "
alias dcup="docker-compose up -d "
alias dcstop="docker-compose stop "
alias dcrestart="docker-compose restart "
alias dcdown="docker-compose down "
alias dcbuild="docker-compose build "

###############################################################################
## Git-related aliases and functions.
###############################################################################

# Get name of current git branch
ParseGitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Store username and password for a new repo.
alias gitstore="git config credential.helper store"
alias gitcache="git config credential.helper cache"

# Count total number of commits for repo.
alias countcommits="git log --oneline --all | wc -l"

# Git commands, shorthand.
alias gga='git add '
alias ggb='git branch '
alias ggc='git commit -m '
alias ggco='git checkout '
alias ggd='git diff '
alias ggs='git status '
alias ggl='git log '

# Open repo remote URL in browser.
function openrepo {
    if [ -d .git ]; then
        url=$(git remote get-url origin)
        # if repo was cloned with SSH, we need to tweak the URL
        if [[ $url == git@* ]]; then
            url=${url/://}  # replace first ':' with '/'
            url=${url/git@/https://}  # replace 'git@' with 'https://'
        fi  
        url=${url%%.git*}  # remove trailing '.git'
        xdg-open "$url"
    else
        echo "Not a git repo."
    fi
}

# Git add, commit, and push
function gitacp() {
    if [ $# -ne 1 ]; then
        echo "usage: gitacp [message]"
        echo "  where [message] is commit message (surrounded by quotes)"
        echo ""
        echo -n "please note that gitacp will add *everything* recursively "
        echo    "from current working directory"
    else
        git add .
        git commit -m "$1"
        git push
    fi
}

###############################################################################
## Miscellaneous helper functions
###############################################################################

# Update, upgrade, and autoremove packages
update() {
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt -y autoremove
}

# Copy IP address to clipboard.
#    requires: `xclip` (`sudo apt -y install xclip`)
getip() {
    PRIMARY_IP=$(hostname -I)
    echo -n $PRIMARY_IP | xclip -selection primary
    echo -n $PRIMARY_IP | xclip -selection clipboard
    echo "Copied IP to clipboard: $PRIMARY_IP"
}

# Get Air Quality Index
#    requires `jq` (`sudo apt -y install jq`)
#    uses on https://docs.airnowapi.org/ for AQI data
AQI() {
    if [ "$#" -ne 1 ]; then
        echo "usage: AQI [zipcode]"
        echo "    returns forecasted air quality index"
    else
        echo "Air quality forecast for $1:"
        curl -s -H "Accept: application/json" -H "Content-Type: application/json" -X GET "http://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=$1&api_key=106C1BD4-D8A2-4129-A160-ADBB16DAD15D" | jq ".[0]"
    fi
}

# Get current weather
weather() {
    curl "wttr.in/$1?format=3 "
}
alias wttr="weather "
alias forecast="weather "
alias temp="weather "

# Empty trash bin.
GarbageDay() {
    rm -rf ~/.local/share/Trash/*
}

# Set title of current terminal window.
SetTitle() {
    if [[ -z "$ORIG" ]]; then
        ORIG=$PS1
    fi
    TITLE="\[\e]2;$*\a\]"
    PS1=${ORIG}${TITLE}
}
alias rename='SetTitle '

# Generate a string of random digits and copy it to the system clipboard.
mkpass() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: mkpass <length>"
        echo "The generated string is copied to the system clipboard."
    else
        PSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c "$1")
        echo -n $PSWD | xclip -selection primary
        echo -n $PSWD | xclip -selection clipboard
        echo "$PSWD"
    fi
}

###############################################################################
## Recurring (run each time a terminal is opened)
###############################################################################

# Add warpdrive
#    Warpdrive allows jumping to tagged directories quickly
#    requires: `cd && git clone https://github.com/JoeriHermans/warpdrive`
source ~/warpdrive/src/.warpdrive

# Bash prompt
# Colorful
#export PS1="\n\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;209m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] @ \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;140m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \t \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;245m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\e[0;34m\]\$(ParseGitBranch)\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]"
# Minimal
export PS1="\[\e[37m\]\u@\h \w \[\e[1;31m\]$\[\e[0m\] "

# Source .bashrc.local file (at ~/.bashrc.local). This is useful if you want to
# have custom aliases or functions that are not shared between computers.
BASHRC_LOCAL=~/.bashrc.local
if [ -f "$BASHRC_LOCAL" ]; then
    source "$BASHRC_LOCAL"
fi
