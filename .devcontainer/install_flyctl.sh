#!/bin/bash
set -e

# Install Flyctl
curl -L https://fly.io/install.sh | sh

# Add Flyctl to PATH
echo 'export FLYCTL_INSTALL="/home/vscode/.fly"' >> /home/vscode/.bashrc
echo 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' >> /home/vscode/.bashrc

source ~/.bashrc"