#!/usr/bin/env bash

if [ "$EUID" != 0 ]; then
    echo "Please run this as root."
    exit 1
fi

echo "Installing Steam Deck Plugin Loader release..."

HOMEBREW_FOLDER="${HOME}/.local/share/homebrew/"

# Create folder structure
rm -rf "${HOMEBREW_FOLDER}/services"
sudo -u "$USER" mkdir -p "${HOMEBREW_FOLDER}/services"
sudo -u "$USER" mkdir -p "${HOMEBREW_FOLDER}/plugins"

# Download latest release and install it
curl -L https://github.com/logan2611/PluginLoader/releases/latest/download/PluginLoader --output "${HOMEBREW_FOLDER}/services/PluginLoader"
chmod +x "${HOMEBREW_FOLDER}/services/PluginLoader"

systemctl --user disable --now plugin_loader 2> /dev/null
systemctl disable --now plugin_loader 2> /dev/null

rm -f /etc/systemd/system/plugin_loader.service
cat > /etc/systemd/system/plugin_loader.service << EOM
[Unit]
Description=SteamDeck Plugin Loader
[Service]
Type=simple
User=root
Restart=always
ExecStart=${HOMEBREW_FOLDER}/services/PluginLoader
WorkingDirectory=${HOMEBREW_FOLDER}/services
Environment=PLUGIN_PATH=${HOMEBREW_FOLDER}/plugins
[Install]
WantedBy=multi-user.target
EOM
systemctl daemon-reload
systemctl enable --now plugin_loader
