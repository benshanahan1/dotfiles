# Bash prompt
# Colorful
#export PS1="\n\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;209m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] @ \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;140m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \t \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;245m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\e[0;34m\]\$(ParseGitBranch)\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]"
# Minimal
export PS1="\[\e[37m\]\u@\h \w \[\e[1;31m\]$\[\e[0m\] "
