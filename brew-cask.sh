#!/bin/bash

# Let's get these puppies into the Applications directory.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew tap homebrew/cask-versions
brew upgrade --cask

# Install packages
apps=(
    # Automation/Productivity/Team Tools.
    flux slack transmission textual the-unarchiver
    karabiner-elements keyboard-maestro nordvpn discord
    obsidian raycast

    # Developer Tools (Editors/IDE/Terminal)
    aws-vault visual-studio-code iterm2

    # Media Players/Convertors.
    calibre # eBook conversion/management | https://manual.calibre-ebook.com/generated/en/cli-index.html
    kid3    # Audio metadata management
    vlc     # Best video player.
    xld     # Audio conversion GUI + CLI tool.

    # Productivity tools
    dozer # Hide menu bar icons. Open-source alternative to Bartender.
    todoist
    rectangle
    cron      # Calendar
    1password # Password manager
)

for application in "${apps[@]}"; do
    brew install --cask "$application"
done
