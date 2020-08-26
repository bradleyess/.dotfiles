export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
autoload -Uz compinit
compinit
source "$HOME/.zinit/bin/zinit.zsh"

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

# @todo - Tidy this sucker up!
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
bootstrap "$HOME/.zsh-config/plugins"

# @todo - Add to Broot file
source /Users/bx/Library/Preferences/org.dystroy.broot/launcher/bash/br
plugins=(git)

# @todo - Add to Pyenv file.
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source $ZSH/oh-my-zsh.sh