# some more ls aliases
alias sl='ls '
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# NOTE: spaces after the command force what follows to expand (if it has an alias)
alias sudo="sudo "
alias vim="nvim "
alias hex="hexyl "
alias apt="apt-fast "
alias calc="gnome-calculator"
alias new="gnome-terminal"  # open new terminal
alias resource="source ~/.bashrc"
alias www="ping 8.8.8.8"
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
