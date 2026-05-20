# ~/shell/bash/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enforce high-fidelity asset rendering
export COLORTERM=truecolor
export TERM=xterm-256color

# Set historical boundaries
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend # Append to history file, don't overwrite

# Check window size after each command and update lines/columns if necessary
shopt -s checkwinsize

# Colored GCC diagnostics support
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Sourcing operational aliases if they exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Initialize the Starship Prompt Interface
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Login Trigger: Fire the custom dashboard layout
if command -v fastfetch &> /dev/null; then
    fastfetch
fi