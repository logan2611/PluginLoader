#!/usr/bin/env bash

if [ "$EUID" != 0 ]; then
    echo "Please run this as root."
    exit 1
fi

echo "Installing Steam Deck Plugin Loader nightly..."

HOME=$(sudo -H -u "$SUDO_USER" -i eval 'echo $HOME')
HOMEBREW_FOLDER="${HOME}/.local/share/homebrew/"

# Create folder structure
rm -rf "${HOMEBREW_FOLDER}/services"
sudo -u $SUDO_USER mkdir -p "${HOMEBREW_FOLDER}/services"
sudo -u $SUDO_USER mkdir -p "${HOMEBREW_FOLDER}/plugins"

# Download latest nightly build and install it
rm -rf /tmp/plugin_loader
mkdir -p /tmp/plugin_loader
curl -L https://nightly.link/SteamDeckHomebrew/PluginLoader/workflows/build/main/Plugin%20Loader.zip --output /tmp/plugin_loader/PluginLoader.zip
unzip /tmp/plugin_loader/PluginLoader.zip -d /tmp/plugin_loader
cp /tmp/plugin_loader/PluginLoader "${HOMEBREW_FOLDER}/services/PluginLoader"
rm -rf /tmp/plugin_loader
chmod +x "${HOMEBREW_FOLDER}/services/PluginLoader"

systemctl --user disable --now plugin_loader 2> /dev/null
rm -f "${HOME}/.config/systemd/user/plugin_loader.service"

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
