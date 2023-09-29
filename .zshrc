#!/usr/bin/env zsh

# Environment variables
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"
export ZSH_DISABLE_COMPFIX="true"
export PYENV_ROOT="$HOME/.pyenv"
export LINKTREE_MONOREPO_LOCATION="/Users/bradleyshawyer/linktr.ee/monorepo/"
export BUN_INSTALL="$HOME/.bun"

# Initialize completion system
autoload -Uz compinit
compinit

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# Load zinit
source "$(brew --prefix)/opt/zinit/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# Load exports and PATH
for file in ~/.{path,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Load functions and aliases
for module in ~/.{aliases,functions}/*; do
    source "$module"
done

# Helper function to bootstrap configuration and plugins
bootstrap() {
    directory="$1"
    if [ -d "$directory" ]; then
        for config in "$directory"/**/*(N-.); do
            source "$config"
        done
    fi
}

# Bootstrap Zsh configurations and plugins
bootstrap "$HOME/.zsh-config/config"
bootstrap "$HOME/.zsh-config/plugins"

# Update FPATH
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Configure pyenv
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
fi

# Load Zinit annexes without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# bun completions and PATH update
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
export PATH="$BUN_INSTALL/bin:$PYENV_ROOT/bin:$PATH"



# Load oh-my-zsh
source "$ZSH/oh-my-zsh.sh"
# Add syntax highlighting to zsh.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh