#!/bin/bash

# Let's get these puppies into the Applications directory.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew tap homebrew/cask-versions
brew install --cask outdated # List outdated casks.

# Install packages
apps=(
    # Automation/Productivity/Team Tools.
    alfred dash hazel flux slack transmission textual the-unarchiver
    karabiner-elements rectangle tuple keyboard-maestro nordvpn

    # Developer Tools (Editors/IDE/Terminal)
    aws-vault visual-studio-code iterm2

    # Media Players/Convertors.
    calibre # eBook conversion/management | https://manual.calibre-ebook.com/generated/en/cli-index.html
    kid3    # Audio metadata management
    vlc     # Best video player.
    xld     # Audio conversion GUI + CLI tool.

    # Productivity tools
    dozer # Hide menu bar icons. Open-source alternative to Bartender.
)

for application in "${apps[@]}"; do
    brew cask install "$application"
done

brew cu -afy # Force ugprade of all packages.
