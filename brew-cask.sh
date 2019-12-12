#!/bin/bash

# Let's get these puppies into the Applications directory.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Install Caskroom
brew tap caskroom/cask
brew tap buo/cask-upgrade
brew install brew-cask-completion
brew tap caskroom/versions

brew cask outdated # List outdated casks.

# Install packages
apps=(

    # Browsers
    firefox firefoxnightly google-chrome google-chrome-canary phantomjs

    # Automation/Productivity/Team Tools.
    alfred dash hazel harvest flux screenflow slack transmission textual the-unarchiver
    1password keepassx

    # Developer Tools (Editors/IDE/Terminal)
    aws-vault
    visual-studio-code
    iterm2
    transmit # SFTP & Amazon S3 File Transfer
    virtualbox vagrant vagrant-manager # VM's

    # Media Players/Convertors.
    calibre # eBook conversion/management | https://manual.calibre-ebook.com/generated/en/cli-index.html
    vlc # Best video player.
    xld # Audio conversion GUI + CLI tool.
    )

for application in ${apps[@]}
do
    brew cask install $application
done

for application in ${apps[@]}
do
    brew install caskroom/cask/$application
done

brew cu -afy # Force ugprade of all packages.
