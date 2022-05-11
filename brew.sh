#!/bin/bash

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
    blackhole-2ch blackhole-16ch

    # Shell and CLI
    dust # du in Rust
    bat coreutils curl diff-so-fancy fd fdupes findutils git git-crypt git-extras gnu-sed gpg grc grep
    exa httpie hub jq mkcert moreutils mtr nss reattach-to-user-namespace ripgrep tig tldr tmux tree wget z xsv
    adr-tools fastly/tap/fastly fswatch
    zsh zsh-completions zsh-syntax-highlighting zplug zinit

    # Creative Coding / C++
    pkg-config gcc readline sqlite gdbm freetype
    eigen libyaml fftw libsamplerate libtag tensorflow
    cairo

    # Development environment
    docker docker-machine docker-compose
    node go
    python3 pyenv
)

brew install "${apps[@]}"
brew cleanup
xcode-select --install
