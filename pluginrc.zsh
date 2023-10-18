# This script will be executed ON THE HOST when you connect to the host.
# Put here your functions, environment variables, aliases and whatever you need.

CURR_DIR="$(cd "$(dirname "$0")" && pwd)"
plugin_name="xxh-plugin-zsh-zshrc"

export ZSH="$CURR_DIR/ohmyzsh"

unset ZSH_THEME

if [[ -v plugins ]]; then
  if [[ $XXH_VERBOSE == '2' ]]; then
    echo $plugin_name: Found plugins=$plugins
  fi
  export plugins=(${=plugins})
else
  if [[ $XXH_VERBOSE == '2' ]]; then
    echo $plugin_name: Set default plugins=git
  fi
  export plugins=(git)
fi

export PATH=$CURR_DIR/bin:$PATH
export FZF_PATH=$CURR_DIR/fzf
# [[ ! -f $CURR_DIR/fzf.zsh ]] || source $CURR_DIR/fzf.zsh

export DISABLE_AUTO_UPDATE=true
zstyle ':omz:update' mode disabled

source $CURR_DIR/ohmyzsh/oh-my-zsh.sh
autoload -U compinit && compinit

if [[ -v history_size ]]; then
  if [[ $XXH_VERBOSE == '2' ]]; then
    echo $plugin_name: Found history_size=$history_size
  fi
  export HISTSIZE=${history_size}
  export SAVEHIST=$HISTSIZE
else
  if [[ $XXH_VERBOSE == '2' ]]; then
    echo $plugin_name: Set default history_size=10
  fi
  export HISTSIZE=10
fi
export SAVEHIST=$HISTSIZE

source $CURR_DIR/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $CURR_DIR/p10k.zsh ]] || source $CURR_DIR/p10k.zsh
