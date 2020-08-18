#!/bin/bash

installTmuxPluginManager() {
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
}

installTmuxinatorSuggestions(){
    wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
}

installTmuxPluginManager
installTmuxinatorSuggestions