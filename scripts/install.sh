#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=========================================="
echo "Deploying Lemmon-714 Workspace Topology"
echo "=========================================="

# Ensure target base directories exist on the host
mkdir -p "$HOME/.config"

# 1. Map XDG Configurations (starship, fastfetch, tmux)
echo "=> Syncing XDG configuration assets..."
stow --dir="$REPO_DIR" --target="$HOME" .config

# 2. Map Shell Environments (.bashrc, .bash_aliases, .profile)
echo "=> Syncing shell configurations..."
stow --dir="$REPO_DIR/shell" --target="$HOME" bash

# 3. Map Version Control Configurations (.gitconfig, .gitignore_global)
echo "=> Syncing version control configurations..."
stow --dir="$REPO_DIR/dev/vcs" --target="$HOME" git

echo "=========================================="
echo "Deployment Complete! Nervous system connected."
echo "=========================================="