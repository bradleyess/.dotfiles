#!/usr/bin/env bash

# Always start tmux with SSH session
alias ssh=ssh -t -- /bin/sh -c 'tmux has-session && exec tmux attach || exec tmux'