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

# Check if a port is open on a remote system using netcat.
# usage: port 192.168.1.1 22
alias port="nc -zv "

# List all open/bound ports on the current system.
alias openports='netstat -nape --inet'

# List all users present in the /etc/passwd file.
alias lsusers="cut -d: -f1 /etc/passwd"
