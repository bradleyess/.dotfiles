#!/usr/bin/env bash

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"
export ZSH_DISABLE_COMPFIX="true"
autoload -Uz compinit
compinit

# todo - Source differently depending on the OS.
source $(brew --prefix)/opt/zinit/zinit.zsh
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

source "$ZSH/oh-my-zsh.sh"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

#### LINKTREE MONOREPO LOCATION CONFIG SETTING START ####
export LINKTREE_MONOREPO_LOCATION=/Users/bradleyshawyer/linktr.ee/monorepo/
#### LINKTREE MONOREPO LOCATION CONFIG SETTING END ####
