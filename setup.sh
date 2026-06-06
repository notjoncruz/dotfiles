#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

if [[ "$(id -u)" -eq 0 ]]; then
  echo "Don't run as root. Homebrew won't install. Create a user first."
  exit 1
fi

install_homebrew() {
  if command -v brew &>/dev/null; then return; fi
  if [[ "$OS" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y build-essential zsh
  fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  case "$OS" in
    Darwin)
      if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      else
        eval "$(/usr/local/bin/brew shellenv)"
      fi
      ;;
    Linux) eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;;
  esac
}

install_packages() {
  brew bundle --file="$DOTFILES/Brewfile"
  if [[ "$OS" == "Linux" && "$SHELL" != */zsh ]]; then
    sudo chsh -s "$(which zsh)" "$(whoami)"
  fi
}

install_omz() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

install_tpm() {
  if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    mkdir -p "$HOME/.config/tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
  fi
}

link_configs() {
  ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
  if [[ "$DOTFILES" != "$HOME/.config" ]]; then
    mkdir -p "$HOME/.config"
    ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim"
    ln -sfn "$DOTFILES/tmux" "$HOME/.config/tmux"
    ln -sfn "$DOTFILES/mise" "$HOME/.config/mise"
    if [[ "$OS" == "Darwin" ]]; then
      ln -sfn "$DOTFILES/ghostty" "$HOME/.config/ghostty"
    fi
  fi
}

install_homebrew
install_packages
install_omz
install_tpm
link_configs

echo "Done! Restart your shell or run: exec zsh"
