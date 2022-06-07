# Steam Deck Plugin Loader

### Changes from [upstream](https://github.com/SteamDeckHomebrew/PluginLoader):
- Plugins folder moved to ~/.local to follow FreeDesktop standards. ([Issue](https://github.com/SteamDeckHomebrew/PluginLoader/issues/66))
    - This may break some plugins, however these should be very easy to fix.
- Improvements to the install script.

## Installation
1. Go into the Steam Deck Settings
2. Under System -> System Settings toggle `Enable Developer Mode`
3. Scroll the sidebar all the way down and click on `Developer`
4. Under Miscellaneous, enable `CEF Remote Debugging`
5. Click on the `STEAM` button and select `Power` -> `Switch to Desktop`
6. Make sure you have a password set with the "passwd" command in terminal to install it ([YouTube Guide](https://www.youtube.com/watch?v=1vOMYGj22rQ)).
7. Open a terminal and paste the following command into it:
    - For users:
        - `curl -L https://github.com/logan2611/PluginLoader/raw/main/dist/install_release.sh | sh`
    - For developers:
     	- ~~- `curl -L https://github.com/logan2611/PluginLoader/raw/main/dist/install_nightly.sh | sh`~~

        Nightly releases are currently broken.
8. Done! Reboot back into Gaming mode and enjoy your plugins!

## Migration from vanilla version
1. Open a terminal and paste the following commands into it:
    - For users:
        ```
        curl -L https://github.com/SteamDeckHomebrew/PluginLoader/raw/main/dist/uninstall.sh | sh
        mkdir -p ~/.local/share/homebrew
        sudo mv ~/homebrew ~/.local/share/
        sudo chown -R deck: ~/.local/share/homebrew
        find ~/.local/share/homebrew -type d -exec chmod 0755 {} \;
        find ~/.local/share/homebrew -type f -exec chmod 0644 {} \;
        curl -L https://github.com/logan2611/PluginLoader/raw/main/dist/install_release.sh | sh
        ```
    - For developers:

        Nightly releases are currently broken.
        ```
        curl -L https://github.com/SteamDeckHomebrew/PluginLoader/raw/main/dist/uninstall.sh | sh
        mkdir -p ~/.local/share/homebrew
        sudo mv ~/homebrew ~/.local/share/
        sudo chown -R deck: ~/.local/share/homebrew
        find ~/.local/share/homebrew -type d -exec chmod 0755 {} \;
        find ~/.local/share/homebrew -type f -exec chmod 0644 {} \;
        curl -L https://github.com/logan2611/PluginLoader/raw/main/dist/install_nightly.sh | sh
        ```

### Install Plugins
- Simply copy the plugin's folder into `~/.local/share/homebrew/plugins`

### Uninstall
- Open a terminal and paste the following command into it:
    - For both users and developers:
        - `curl -L https://github.com/logan2611/PluginLoader/raw/main/dist/uninstall.sh | sh`
