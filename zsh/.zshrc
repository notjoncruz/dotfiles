export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

eval "$(mise activate zsh)"

alias ls="eza"
alias ll="eza -l --git"
alias la="eza -la --git"
