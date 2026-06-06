export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

eval "$(mise activate zsh)"

alias ls="eza"
alias ll="eza -l --git"
alias la="eza -la --git"