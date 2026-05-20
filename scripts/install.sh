#!/usr/bin/env bash
set -e

echo "=========================================="
echo "Deploying Lemmon-714 Workspace Topology"
echo "=========================================="

# Ensure target base directories exist on the host
mkdir -p "$HOME/.config"

# 1. Map XDG Configurations
echo "=> Syncing XDG configuration assets..."
stow --dir=.config --target="$HOME/.config" .

# 2. Map Shell Environments
echo "=> Syncing shell configurations..."
stow --dir=shell/bash --target="$HOME" .

# 3. Map Development Runtime Configurations
echo "=> Syncing version control configurations..."
stow --dir=dev/vcs --target="$HOME" .

echo "=========================================="
echo "Deployment Complete! Nervous system connected."
echo "=========================================="