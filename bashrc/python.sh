alias mkenv="virtualenv -p python3 venv && source ./venv/bin/activate"

activate() {
    if [[ -f env/bin/activate ]]; then
        source env/bin/activate
    elif [[ -f venv/bin/activate ]]; then
        source venv/bin/activate
    else
        echo "Cannot find Python virtual environment."
    fi
}
