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
alias ggr='git remote '
alias ggrv='git remote -v '

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
