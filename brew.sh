#!/bin/bash
sudo -v

# Check for Homebrew and install it if missing
if test ! "$(which brew)"; then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew & latest formulae.
brew update && brew upgrade

taps=(
    buildkite/cli
)

brew tap "${taps[@]}"

apps=(
    # Multimedia
    exiftool guetzli imagemagick jpeg libpng optipng ffmpeg

    # Shell and CLI
    awscli bat circleci coreutils curl diff-so-fancy fd fdupes findutils git git-crypt git-extras gnu-sed gpg grc grep
    exa httpie hub jq mkcert moreutils mtr mutt nss reattach-to-user-namespace ripgrep tig tldr tmux tree wget z xsv
    adr-tools fastly/tap/fastly
    docker docker-machine kubectl minikube helm kubectx kube-ps1 kubespy
    terraform terragrunt tflint
    python3 pyenv
    node go rust
    yarn
    zsh zsh-completions zsh-syntax-highlighting zplug

    # Creative Coding / C++
    pkg-config gcc readline sqlite gdbm freetype
    eigen libyaml fftw libsamplerate libtag tensorflow
    cairo
)

brew install "${apps[@]}"
brew cleanup
xcode-select --install
