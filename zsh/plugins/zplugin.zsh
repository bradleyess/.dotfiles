zinit ice as"program" pick"bin/git-dsf"

zinit light zdharma/zsh-diff-so-fancy
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light agkozak/zsh-z

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit wait lucid for \
        OMZL::git.zsh \
        atload"unalias grv" \
        OMZP::git