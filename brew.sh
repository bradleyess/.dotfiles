#!/bin/bash
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew & latest formulae.
brew update && brew upgrade

apps=(
    # Audio
    exiftool

    # Utility Packages / Better Defaults
    curl coreutils findutils moreutils bat tree wget gnu-sed grep ripgrep fd fdupes
    tmux awscli tldr gpg jq z grc circleci mkcert nss reattach-to-user-namespace

    # Git
    git git-extras hub tig git-crypt diff-so-fancy

    # Generic
    httpie mutt

    # Networking
    mtr # Powerful ping/traceroute amalgamation. https://www.bitwizard.nl/mtr/

    # Media Processing
    guetzli imagemagick jpeg libpng optipng # Images
    ffmpeg # Movies

    # Docker & Kubernetes
    docker docker-machine kubectl minikube helm

    # Terraform
    terraform terragrunt tflint

    # Programming Languages
    node nvm go rust

    # Package Managers
    yarn

    # Better shell. Read : http://ohmyz.sh/
    zsh zsh-completions zsh-syntax-highlighting zplug
)

brew install "${apps[@]}"
brew cleanup
xcode-select --install