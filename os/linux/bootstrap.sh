#!/usr/bin/env bash

set -e # Exit immediately on error

echo "=========================================="
echo "Initializing Lemmon-714 Core Environment"
echo "=========================================="

# 1. Update and upgrade package lists
echo "=> Updating system package registers..."
sudo apt-get update && sudo apt-get upgrade -y

# 2. Install core high-signal tools
echo "=> Installing essential toolchain..."
sudo apt-get install -y \
    curl \
    git \
    make \
    stow \
    build-essential \
    software-properties-common

# 3. Inject True Color capability to bash profile if not present
if ! grep -q "COLORTERM=truecolor" ~/.bashrc; then
    echo "=> Optimizing terminal asset pipelines for True Color (24-bit)..."
    echo -e "\n# Force true color support for high-fidelity aesthetics\nexport COLORTERM=truecolor" >> ~/.bashrc
fi

echo "=========================================="
echo "System Bootstrap Complete! Please restart your terminal."
echo "=========================================="