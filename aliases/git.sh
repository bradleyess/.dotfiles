#!/usr/bin/env bash

alias gs="tig status"
alias gim="git cz || git commit -m"
alias gcmp="gco master && git fetch && git reset --hard origin/master"
alias grbc="git rebase --continue"
alias gfrb="git fetch --all && git rebase origin/master -i"