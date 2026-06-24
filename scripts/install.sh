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

# 4. Map Node.js Runtime Configuration (.npmrc)
echo "=> Syncing Node.js runtime configuration..."
ln -sf "$REPO_DIR/dev/runtimes/node/.npmrc" "$HOME/.npmrc"

# 5. Map Python Runtime Configuration (pip.conf)
echo "=> Syncing Python runtime configuration..."
mkdir -p "$HOME/.config/pip"
ln -sf "$REPO_DIR/dev/runtimes/python/pip.conf" "$HOME/.config/pip/pip.conf"

# 6. Map Editor Configurations (VS Code & Cursor for WSL remote)
echo "=> Syncing editor configurations..."
if [ -d "$HOME/.vscode-server" ]; then
    mkdir -p "$HOME/.vscode-server/data/Machine"
    ln -sf "$REPO_DIR/dev/editors/vscode/settings.json" "$HOME/.vscode-server/data/Machine/settings.json"
fi
if [ -d "$HOME/.cursor-server" ]; then
    mkdir -p "$HOME/.cursor-server/data/Machine"
    ln -sf "$REPO_DIR/dev/editors/cursor/settings.json" "$HOME/.cursor-server/data/Machine/settings.json"
fi

echo "=========================================="
echo "Deployment Complete! Nervous system connected."
echo "=========================================="