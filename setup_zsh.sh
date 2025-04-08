#!/bin/bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────
# Colors for logging
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# ──────────────────────────────────────────────────────────────────────
# Config paths
CONFIGS_DIR="$(pwd)/configs"
ZSHRC_FILE="$CONFIGS_DIR/zshrc"
ZSH_CUSTOM_DIR="$CONFIGS_DIR/zsh"
ZSH_TARGET_DIR="$HOME/.zsh"

# ──────────────────────────────────────────────────────────────────────
# Log helpers
log_info()  { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error() { echo -e "${RED}[ERROR]${RESET} $1"; exit 1; }

# ──────────────────────────────────────────────────────────────────────
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

# ──────────────────────────────────────────────────────────────────────
install_dependencies() {
  log_info "Installing CLI tools..."

  if [[ "$OS" == "macOS" ]]; then
    brew update || log_warn "brew update failed"

    for pkg in zsh git fzf coreutils gnu-sed gnupg gawk fd ripgrep bat eza pyenv neovim terraform awscli gh tfenv cookiecutter; do
      brew install "$pkg" || log_warn "Failed to install $pkg"
    done

    # Install and pin Terraform
    if ! command -v terraform &>/dev/null; then
      tfenv install 1.3.7 || log_warn "tfenv failed to install Terraform 1.3.7"
      tfenv use 1.3.7 || log_warn "tfenv failed to activate Terraform"
    fi

    # Install Terragrunt
    log_info "Downloading Terragrunt..."
    curl -Lo /usr/local/bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.53.2/terragrunt_darwin_arm64 || log_warn "Terragrunt download failed. Try running this command with sudo."
    chmod +x /usr/local/bin/terragrunt 2>/dev/null || log_warn "Permission denied. Please run: sudo chmod +x /usr/local/bin/terragrunt"

    # Install SOPS
    log_info "Downloading SOPS..."
    curl -Lo /usr/local/bin/sops https://github.com/getsops/sops/releases/download/v3.7.3/sops-v3.7.3.darwin.arm64 || log_warn "SOPS download failed. Try running this command with sudo."
    chmod +x /usr/local/bin/sops 2>/dev/null || log_warn "Permission denied. Please run: sudo chmod +x /usr/local/bin/sops"

  else
    sudo apt update || log_warn "apt update failed"
    sudo apt install -y       zsh git fzf coreutils sed gnupg gawk fd-find ripgrep bat eza pyenv neovim terraform awscli gh || log_warn "Some packages failed to install"

    mkdir -p ~/.local/bin
    ln -sf "$(which fdfind)" ~/.local/bin/fd
  fi

  if [[ "$SHELL" != *zsh ]]; then
    log_info "Changing default shell to Zsh..."
    chsh -s "$(which zsh)" || log_warn "Failed to change default shell to zsh"
  fi
}

# ──────────────────────────────────────────────────────────────────────
install_zinit() {
  if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    log_info "Installing Zinit plugin manager..."
    mkdir -p ~/.zinit
    git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin || log_warn "Failed to clone zinit"
  else
    log_info "Zinit is already installed."
  fi
}

# ──────────────────────────────────────────────────────────────────────
copy_zsh_configs() {
  log_info "Copying .zshrc to home directory..."
  cp "$ZSHRC_FILE" ~/.zshrc || log_warn "Failed to copy .zshrc"

  log_info "Copying custom Zsh configs..."
  mkdir -p "$ZSH_TARGET_DIR"
  cp -R "$ZSH_CUSTOM_DIR/"* "$ZSH_TARGET_DIR/" || log_warn "Failed to copy custom Zsh configs"

  mkdir -p "$ZSH_TARGET_DIR/functions"
}

# ──────────────────────────────────────────────────────────────────────
setup_powerlevel10k() {
  if [[ ! -f ~/.p10k.zsh ]]; then
    log_info "Installing default Powerlevel10k theme config..."
    curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/config/p10k-classic.zsh -o ~/.p10k.zsh || log_warn "Failed to download Powerlevel10k config"
  else
    log_info "Powerlevel10k config already exists."
  fi
}

# ──────────────────────────────────────────────────────────────────────
validate_plugins() {
  log_info "Running Zsh in headless mode to initialize plugins..."
  zsh -i -c "source ~/.zshrc; zinit self-update; zinit update --all" || log_warn "Zinit plugin install check had issues"
}

# ──────────────────────────────────────────────────────────────────────
wrap_up() {
  log_info "✅ Zsh setup complete."
  echo -e "${YELLOW}➡️  Restart your terminal or run \`exec zsh\` to start using your new shell.${RESET}"
}

# ──────────────────────────────────────────────────────────────────────
# Execution flow
detect_os
install_dependencies
install_zinit
copy_zsh_configs
setup_powerlevel10k
validate_plugins
wrap_up
