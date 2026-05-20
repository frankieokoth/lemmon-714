#!/usr/bin/env bash

echo "Checking system dependency matrices..."
echo "----------------------------------------"

# Function to check if a binary exists in the user's path
check_tool() {
    if command -v "$1" &> /dev/null; then
        echo -e "[\033[32m PASS \033[0m] $1 is operational: $(which $1)"
    else
        echo -e "[\033[31m FAIL \033[0m] $1 is missing or not in PATH"
    fi
}

# Core tool verifications
check_tool "git"
check_tool "make"
check_tool "stow"
check_tool "gcc"

# Check color term capabilities
if [ "$COLORTERM" = "truecolor" ]; then
    echo -e "[\033[32m PASS \033[0m] True Color (24-bit) environment verified."
else
    echo -e "[\033[33m WARN \033[0m] Terminal is running in degraded 16-color fallback mode."
fi

echo "----------------------------------------"
echo "Diagnostics complete."