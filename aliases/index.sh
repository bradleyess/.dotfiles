#!/usr/bin/env bash

alias reload="source ~/.zshrc"
alias edot="code $HOME/.dotfiles"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'qq

alias myip='dig +short myip.opendns.com @resolver1.opendns.com.'

alias getMyPrivateGpgKey="gpg --export-secret-keys --armor bradley.shawyer@gmail.com"
alias getMyGpgKey="gpg --export --armor bradley.shawyer@gmail.com"
