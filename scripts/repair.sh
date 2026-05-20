#!/usr/bin/env bash
set -e

echo "=========================================="
echo "Executing Lemmon-714 Environment Repair"
echo "=========================================="

echo "=> Purging editor server entropy..."
rm -rf ~/.vscode-server ~/.cursor-server

echo "=> Cleaving dead IPC sockets in /tmp/..."
rm -rf /tmp/vscode-ipc-* /tmp/vscode-server-* /run/user/1000/vscode-ipc-*

echo "=========================================="
echo "Repair Complete. Reconnect your editors."
echo "=========================================="