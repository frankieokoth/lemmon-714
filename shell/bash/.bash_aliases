# ~/shell/bash/.bash_aliases

# Navigation Accelerators
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias dev="cd ~/dev"

# Pristine Directory Listing
alias ls="ls --color=auto"
alias ll="ls -lah --group-directories-first"
alias la="ls -A"
alias l="ls -CF"

# Git Quick-Streams
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate"
alias gaa="git add ."
alias gcm="git commit -m"
alias gp="git push"

# The Lemmon-714 Engine Overrides (Makefile Automation)
# Automatically looks for the master Makefile in your platform repository path
alias l714="cd ~/dev/lemmon-714"
alias sys-doctor="make -C ~/dev/lemmon-714 doctor"
alias sys-flush="make -C ~/dev/lemmon-714 flush"
alias sys-deploy="make -C ~/dev/lemmon-714 install"