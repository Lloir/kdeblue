#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

echo "Starting custom Kinoite build..."

# Install Chromium & required dependencies
echo "Installing Chromium..."
rpm-ostree install chromium \
    libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app

# Add Mullvad VPN repository & install Mullvad VPN + Mullvad Browser
echo "Setting up Mullvad VPN & Mullvad Browser..."
curl --tlsv1.3 -fsS https://repository.mullvad.net/rpm/stable/mullvad.repo | tee /etc/yum.repos.d/mullvad.repo
rpm-ostree update --install mullvad-vpn mullvad-browser

# Add ProtonVPN repo & install ProtonVPN
echo "Setting up ProtonVPN..."
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-unstable/protonvpn-beta-release/protonvpn-beta-release-1.0.2-1.noarch.rpm"
rpm-ostree install ./protonvpn-beta-release-1.0.2-1.noarch.rpm
rm -f ./protonvpn-beta-release-1.0.2-1.noarch.rpm
rpm-ostree install proton-vpn-gnome-desktop

# Install Crossover
echo "Installing Crossover..."
curl -L -o /tmp/crossover.rpm "https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover-24.0.6-1.rpm"
rpm-ostree install /tmp/crossover.rpm
rm -f /tmp/crossover.rpm

# Install Steam via Flatpak (fixes dependency issue)
echo "Installing Steam (Flatpak)..."
flatpak install -y flathub com.valvesoftware.Steam

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
