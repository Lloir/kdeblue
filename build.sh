#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

echo "Starting custom Kinoite build..."

# Install Chromium & required dependencies
echo "Installing Chromium..."
rpm-ostree install chromium \
    libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app

echo "Custom Kinoite build complete!"

systemctl enable podman.socket
