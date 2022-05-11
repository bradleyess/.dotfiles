#!/bin/bash

pip3 install -r "$HOME/.dotfiles/pip/requirements.txt"

# Set global Python version.
pyenv install 3.9.4
pyenv global 3.9.4
