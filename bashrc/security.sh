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
