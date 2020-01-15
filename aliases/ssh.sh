#!/usr/bin/env bash

# Always start tmux with SSH session
alias startSshAgent="eval $(ssh-agent -s)"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '📋    => Public key copied to clipboard'"