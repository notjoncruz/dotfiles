typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/.local/share/mise/installs/node/latest/bin
  /usr/local/bin
  $path
)

[[ -d /home/linuxbrew/.linuxbrew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

eval "$(mise activate zsh)"

# >>> railway initialize >>>
[[ -f "$HOME/.railway/env" ]] && source "$HOME/.railway/env"
# <<< railway initialize <<<

alias ls="eza"
alias ll="eza -l --git"
alias la="eza -la --git"
