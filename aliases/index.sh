#!/usr/bin/env bash

# Because typing source ~/.zshrc is too slow.
alias reload="source ~/.zshrc"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'qq