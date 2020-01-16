export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
autoload -Uz compinit
compinit

plugins=(zsh-autosuggestions git colored-man-pages)

# Load exports and PATH.
for file in ~/.{path,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load all functions + aliases
for module in ~/.{aliases,functions}/*; do
  source $module
done
unset module

# Loads `pre`, `config` + `post` in that order
bootstrap() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    if [ -d "$_dir/plugins" ]; then
      for config in "$_dir"/plugins/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}

bootstrap "$HOME/.zsh-config/config"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

source $ZSH/oh-my-zsh.sh

# Keep at the end of the zshrc
source "$HOME/.zplugin/bin/zplugin.zsh"
source "$HOME/.dotfiles/zsh/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/bx/linktr.ee/monorepo/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/bx/linktr.ee/monorepo/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/bx/linktr.ee/monorepo/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/bx/linktr.ee/monorepo/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/bx/linktr.ee/monorepo/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/bx/linktr.ee/monorepo/node_modules/tabtab/.completions/slss.zsh
source /Users/bx/Library/Preferences/org.dystroy.broot/launcher/bash/br
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
