#!/usr/bin/env bash
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"
autoload -Uz compinit
compinit

source "$HOME/.zinit/bin/zinit.zsh"

# Load exports and PATH.
for file in ~/.{path,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load all functions + aliases
for module in ~/.{aliases,functions}/*; do
    source "$module"
done
unset module

# @todo - Tidy this sucker up!
bootstrap() {
    directory="$1"

    if [ -d "$directory" ]; then
        for config in "$directory"/**/*(N-.); do
            . "$config"
        done
    fi
}

bootstrap "$HOME/.zsh-config/config"
bootstrap "$HOME/.zsh-config/plugins"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

source "$ZSH/oh-my-zsh.sh"
