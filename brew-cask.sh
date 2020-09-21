#!/bin/bash

# Let's get these puppies into the Applications directory.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Install Caskroom
brew tap homebrew/cask
brew tap buo/cask-upgrade
brew install brew-cask-completion
brew cask outdated # List outdated casks.

# Install packages
apps=(
    # Browsers
    firefox firefox-nightly google-chrome google-chrome-canary

    # Automation/Productivity/Team Tools.
    alfred dash hazel harvest flux slack transmission textual the-unarchiver 1password
    karabiner-elements rectangle tuple keyboard-maestro

    # Developer Tools (Editors/IDE/Terminal)
    aws-vault visual-studio-code iterm2
    virtualbox vagrant vagrant-manager # VM's

    # Media Players/Convertors.
    calibre # eBook conversion/management | https://manual.calibre-ebook.com/generated/en/cli-index.html
    kid3    # Audio metadata management
    vlc     # Best video player.
    xld     # Audio conversion GUI + CLI tool.
)

for application in ${apps[@]}; do
    brew cask install $application
done

brew cu -afy # Force ugprade of all packages.
