export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions git colored-man-pages)

# Load aliases, exports and PATH.
for file in ~/.{path,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load all functions + aliases
for module in ~/.{aliases,functions}/*; do
  source $module
done

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