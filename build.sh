#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

echo "Starting custom Kinoite build..."

# Install AppImageLauncher
echo "Installing AppImageLauncher..."
curl -L -o /tmp/appimagelauncher.rpm "https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm"
rpm-ostree install /tmp/appimagelauncher.rpm
rm -f /tmp/appimagelauncher.rpm

# Install Chromium & Steam
echo "Installing Chromium & Steam..."
rpm-ostree install chromium steam

# Add Mullvad VPN repo & install Mullvad VPN + Mullvad Browser
echo "Setting up Mullvad VPN..."
curl --tlsv1.3 -fsS https://repository.mullvad.net/rpm/stable/mullvad.repo | tee /etc/yum.repos.d/mullvad.repo
rpm-ostree update --install mullvad-vpn mullvad-browser

# Install Crossover
echo "Installing Crossover..."
curl -L -o /tmp/crossover.rpm "https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover-24.0.6-1.rpm"
rpm-ostree install /tmp/crossover.rpm
rm -f /tmp/crossover.rpm

# Download & set up OrcaSlicer AppImage
echo "Installing OrcaSlicer..."
mkdir -p /usr/local/bin
curl -L -o /usr/local/bin/OrcaSlicer "https://github.com/SoftFever/OrcaSlicer/releases/download/nightly-builds/OrcaSlicer_Linux_AppImage_V2.3.0-dev.AppImage"
chmod +x /usr/local/bin/OrcaSlicer

echo "Custom Kinoite build complete!"

systemctl enable podman.socket
