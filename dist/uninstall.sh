#!/usr/bin/env bash

if [ "$EUID" != 0 ]; then
    echo "Please run this as root."
    exit 1
fi

echo "Uninstalling Steam Deck Plugin Loader..."

HOME=$(sudo -u "$SUDO_USER" -i eval 'echo $HOME')
HOMEBREW_FOLDER="${HOME}/.local/share/homebrew/"

# Disable and remove services
sudo systemctl disable --now plugin_loader.service > /dev/null
sudo rm -f "${HOME}/.config/systemd/user/plugin_loader.service"
sudo rm -f /etc/systemd/system/plugin_loader.service

# Remove temporary folder if it exists from the install process
rm -rf /tmp/plugin_loader

# Cleanup services folder
sudo rm "${HOMEBREW_FOLDER}/services/PluginLoader"
