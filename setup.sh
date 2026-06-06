#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

install_homebrew() {
  if command -v brew &>/dev/null; then return; fi
  if [[ "$OS" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y build-essential
  fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  case "$OS" in
    Darwin) eval "$(/opt/homebrew/bin/brew shellenv)" ;;
    Linux)  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;;
  esac
}

install_packages() {
  brew bundle --no-lock --file="$DOTFILES/Brewfile"
  if [[ "$OS" == "Linux" ]]; then
    local brew_zsh
    brew_zsh="$(brew --prefix)/bin/zsh"
    if ! grep -qF "$brew_zsh" /etc/shells; then
      echo "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
    fi
    if [[ "$SHELL" != */zsh ]]; then
      sudo chsh -s "$brew_zsh" "$(whoami)"
    fi
  fi
}

install_omz() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

install_tpm() {
  if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
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
