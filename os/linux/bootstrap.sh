#!/usr/bin/env bash

set -e # Exit immediately on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "=========================================="
echo "Initializing Lemmon-714 Core Environment"
echo "=========================================="

# 1. Update and upgrade package lists
echo "=> Updating system package registers..."
sudo apt-get update && sudo apt-get upgrade -y

# 2. Install core bootstrap dependencies (needed before parsing the package list)
echo "=> Installing core bootstrap dependencies..."
sudo apt-get install -y curl git make stow build-essential software-properties-common

# 3. Install packages from the curated apt manifest
APT_LIST="$SCRIPT_DIR/apt.packages.list"
if [ -f "$APT_LIST" ]; then
    echo "=> Installing packages from apt.packages.list..."
    # Strip comments and blank lines, then install
    PACKAGES=$(grep -v '^\s*#' "$APT_LIST" | grep -v '^\s*$' | tr '\n' ' ')
    sudo apt-get install -y $PACKAGES || {
        echo "=> [WARN] Some packages may require external repositories (docker, gcloud)."
        echo "   Skipping failures and continuing..."
    }
else
    echo "=> [WARN] apt.packages.list not found at $APT_LIST, skipping..."
fi

# 4. Install Starship prompt (not available via apt)
if ! command -v starship &> /dev/null; then
    echo "=> Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "=> Starship already installed: $(starship --version)"
fi

# 5. Inject True Color capability to bash profile if not present
if ! grep -q "COLORTERM=truecolor" ~/.bashrc; then
    echo "=> Enabling True Color (24-bit) support..."
    echo -e "\n# Force true color support for high-fidelity aesthetics\nexport COLORTERM=truecolor" >> ~/.bashrc
fi

echo "=========================================="
echo "System Bootstrap Complete! Please restart your terminal."
echo "=========================================="