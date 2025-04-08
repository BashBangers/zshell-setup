#!/bin/bash
set -euo pipefail

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# Paths
CONFIGS_DIR="$(pwd)/configs"
ZSHRC_FILE="$CONFIGS_DIR/zshrc"
ZSH_CUSTOM_DIR="$CONFIGS_DIR/zsh"
ZSH_TARGET_DIR="$HOME/.zsh"

log_info()  { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error() { echo -e "${RED}[ERROR]${RESET} $1"; exit 1; }

is_installed() {
  command -v "$1" >/dev/null 2>&1
}

install_if_missing() {
  if ! is_installed "$1"; then
    log_info "Installing $1..."
    brew install "$1" || log_warn "Failed to install $1"
  else
    log_info "$1 is already installed."
  fi
}

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
    log_info "Operating system: macOS"
  elif [[ -f "/etc/lsb-release" ]]; then
    OS="Ubuntu"
    log_info "Operating system: Ubuntu"
  else
    log_error "Unsupported OS. Exiting."
  fi
}

install_dependencies() {
  if [[ "$OS" == "macOS" ]]; then
    brew update || log_warn "brew update failed"

    for pkg in zsh git fzf coreutils gnu-sed gnupg gawk fd ripgrep bat eza pyenv neovim terraform awscli gh tfenv cookiecutter tgenv; do
      install_if_missing "$pkg"
    done

    if ! tfenv list | grep -q '1.3.7'; then
      log_info "Installing Terraform 1.3.7 via tfenv..."
      tfenv install 1.3.7
    fi
    tfenv use 1.3.7

    # Fix: locate terragrunt path using tgenv which
    TG_PATH="$(dirname "$(tgenv which)")"
    TG_BIN="$TG_PATH/terragrunt"

    if [[ ! -x "$TG_BIN" ]]; then
      log_info "Installing Terragrunt 0.53.2 via tgenv..."
      tgenv install 0.53.2 || log_warn "tgenv failed to install Terragrunt"
      chmod +x "$TG_BIN"
      xattr -d com.apple.quarantine "$TG_BIN" 2>/dev/null || log_warn "⚠️  Quarantine attribute may still exist on Terragrunt"
    else
      log_info "Terragrunt 0.53.2 already installed and executable."
    fi

    if [[ ! -x /usr/local/bin/sops ]]; then
      log_info "Installing SOPS..."
      curl -Lo /usr/local/bin/sops https://github.com/getsops/sops/releases/download/v3.7.3/sops-v3.7.3.darwin.arm64 || log_warn "SOPS download failed"
      chmod +x /usr/local/bin/sops
      xattr -d com.apple.quarantine /usr/local/bin/sops 2>/dev/null || log_warn "⚠️  Quarantine attribute may still exist on SOPS"
    else
      log_info "SOPS already installed."
    fi
  else
    log_error "This smart install script currently supports macOS only."
  fi

  if [[ "$SHELL" != *zsh ]]; then
    log_info "Changing default shell to Zsh..."
    chsh -s "$(which zsh)" || log_warn "Failed to change default shell to zsh"
  fi
}

install_zinit() {
  if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    log_info "Installing Zinit plugin manager..."
    mkdir -p ~/.zinit
    git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin || log_warn "Failed to clone zinit"
  else
    log_info "Zinit is already installed."
  fi
}

copy_zsh_configs() {
  log_info "Copying .zshrc to home directory..."
  cp "$ZSHRC_FILE" ~/.zshrc || log_warn "Failed to copy .zshrc"

  log_info "Copying custom Zsh configs..."
  mkdir -p "$ZSH_TARGET_DIR"
  cp -R "$ZSH_CUSTOM_DIR/"* "$ZSH_TARGET_DIR/" || log_warn "Failed to copy custom Zsh configs"

  mkdir -p "$ZSH_TARGET_DIR/functions"
}

setup_powerlevel10k() {
  if [[ ! -f ~/.p10k.zsh ]]; then
    log_info "Installing default Powerlevel10k theme config..."
    curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/config/p10k-classic.zsh -o ~/.p10k.zsh || log_warn "Failed to download Powerlevel10k config"
  else
    log_info "Powerlevel10k config already exists."
  fi
}

validate_plugins() {
  log_info "Running Zsh in headless mode to initialize plugins..."
  zsh -i -c "source ~/.zshrc; zinit self-update; zinit update --all" || log_warn "Zinit plugin check had issues"
}

wrap_up() {
  log_info "✅ Zsh setup complete."
  echo -e "${YELLOW}➡️  Restart your terminal or run \`exec zsh\` to start using your new shell.${RESET}"
}

# Run all setup steps
detect_os
install_dependencies
install_zinit
copy_zsh_configs
setup_powerlevel10k
validate_plugins
wrap_up
