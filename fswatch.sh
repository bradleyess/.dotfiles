#!/bin/sh

/usr/local/bin/fswatch -o "$HOME/Downloads/Book\ Downloads" | xargs -n 1 sh -c \
    "$HOME/.pyenv/shims/organize run --config-file $HOME/.dotfiles/organize/books.production.yml"
