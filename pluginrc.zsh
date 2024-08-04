# This script will be executed ON THE HOST when you connect to the host.
# Put here your functions, environment variables, aliases and whatever you need.

CURR_DIR="$(cd "$(dirname "$0")" && pwd)"
plugin_name="xxh-plugin-zsh-advanced_p10k"

export ZSH="$CURR_DIR/ohmyzsh"

# Set up powerlevel10k theme -> https://github.com/romkatv/powerlevel10k#how-do-i-install-powerlevel10k-on-a-machine-without-internet-access
unset ZSH_THEME

# Set up plugins for oh-my-zsh
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

# Set up path for fzf binary
export PATH=$CURR_DIR/bin:$PATH

# Set up path with fzf configs
export FZF_PATH=$CURR_DIR/fzf
### [[ ! -f $CURR_DIR/fzf.zsh ]] || source $CURR_DIR/fzf.zsh

# Disable update for oh-my-zsh
export DISABLE_AUTO_UPDATE=true
zstyle ':omz:update' mode disabled

# Load oh-my-zsh config
source $CURR_DIR/ohmyzsh/oh-my-zsh.sh
autoload -U compinit && compinit

# Set fzf for shell
source <(fzf --zsh)

# Set up bash history
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

# Set up powerlevel10k theme -> https://github.com/romkatv/powerlevel10k#how-do-i-install-powerlevel10k-on-a-machine-without-internet-access
source $CURR_DIR/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $CURR_DIR/p10k.zsh ]] || source $CURR_DIR/p10k.zsh
