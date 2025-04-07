#!/bin/bash
set -euo pipefail

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

CONFIGS_DIR="$(pwd)/configs"

log_info()  { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error() { echo -e "${RED}[ERROR]${RESET} $1"; exit 1; }

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    log_info "macOS detected."
    OS="macOS"
  elif [[ -f "/etc/lsb-release" ]]; then
    log_info "Ubuntu detected."
    OS="Ubuntu"
  else
    log_error "Unsupported OS."
  fi
}

install_dependencies() {
  log_info "Installing CLI dependencies..."

  if [[ "$OS" == "macOS" ]]; then
    brew update
    brew install zsh git fzf coreutils gnu-sed gnupg gawk fd ripgrep bat exa pyenv gls
  else
    sudo apt update && sudo apt install -y \
      zsh git fzf coreutils sed gnupg gawk fd-find ripgrep bat exa pyenv

    mkdir -p ~/.local/bin
    ln -sf "$(which fdfind)" ~/.local/bin/fd
  fi

  # Set Zsh as default shell
  if [[ "$SHELL" != *zsh ]]; then
    log_info "Setting Zsh as default shell..."
    chsh -s "$(which zsh)"
  fi
}

install_zinit() {
  if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    log_info "Installing Zinit..."
    mkdir -p ~/.zinit
    git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin
  else
    log_info "Zinit already installed."
  fi
}

setup_configs() {
  log_info "Copying zsh config files..."

  cp "$CONFIGS_DIR/zshrc" ~/.zshrc

  mkdir -p ~/.zsh
  cp -R "$CONFIGS_DIR/zsh/." ~/.zsh/

  mkdir -p ~/.zsh/functions
}

setup_p10k() {
  if [[ ! -f ~/.p10k.zsh ]]; then
    log_info "Downloading Powerlevel10k config..."
    curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/config/p10k-classic.zsh -o ~/.p10k.zsh
  else
    log_info "Powerlevel10k config already exists."
  fi
}

final_touches() {
  log_info "Zsh environment setup complete ✅"
  echo -e "${YELLOW}➡️  Restart your terminal or run \`exec zsh\` to load changes.${RESET}"
}

# === Run Setup ===
detect_os
install_dependencies
install_zinit
setup_configs
setup_p10k
final_touches

