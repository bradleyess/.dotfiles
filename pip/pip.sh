#!/bin/bash

pip3 install --upgrade virtualenv virtualenvwrapper
pip3 install -U p-r "$HOME/.dotfiles/pip/requirements.txt"
pyenv install 3.9.4
pyenv global 3.9.4
