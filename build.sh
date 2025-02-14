#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

echo "Starting custom Kinoite build..."

# Install Chromium & required dependencies
echo "Installing Chromium..."
rpm-ostree install chromium \
    libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app

# Download & set up AppImageLauncher (instead of RPM)
echo "Installing AppImageLauncher..."
mkdir -p /usr/local/bin
curl -L -o /usr/local/bin/AppImageLauncher "https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-lite-2.2.0-travis995-0f91801-x86_64.AppImage"
chmod +x /usr/local/bin/AppImageLauncher

# Download & set up OrcaSlicer AppImage
echo "Installing OrcaSlicer..."
curl -L -o /usr/local/bin/OrcaSlicer "https://github.com/SoftFever/OrcaSlicer/releases/download/nightly-builds/OrcaSlicer_Linux_AppImage_V2.3.0-dev.AppImage"
chmod +x /usr/local/bin/OrcaSlicer

echo "Custom Kinoite build complete!"

systemctl enable podman.socket
