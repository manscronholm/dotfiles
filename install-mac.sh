#!/usr/bin/env bash
set -euo pipefail

# install-mac.sh — Bootstrap macOS dev environment and deploy dotfiles via stow

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[info]${NC}  $*"; }
ok()    { echo -e "${GREEN}[ok]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[warn]${NC}  $*"; }
err()   { echo -e "${RED}[error]${NC} $*"; }

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for this session (Apple Silicon vs Intel)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  ok "Homebrew installed"
else
  ok "Homebrew already installed"
fi

# --- Packages ---
BREW_PACKAGES=(
  stow
  tmux
  neovim
  alacritty
  starship
  zoxide
  fzf
  fd
  lazygit
  git
  ripgrep
)

info "Installing packages via Homebrew..."
for pkg in "${BREW_PACKAGES[@]}"; do
  if brew list "$pkg" &>/dev/null; then
    ok "$pkg already installed"
  else
    info "Installing $pkg..."
    brew install "$pkg"
    ok "$pkg installed"
  fi
done

# --- Nerd Font ---
info "Installing JetBrainsMono Nerd Font..."
if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
  ok "JetBrainsMono Nerd Font already installed"
else
  brew install --cask font-jetbrains-mono-nerd-font
  ok "JetBrainsMono Nerd Font installed"
fi

# --- Oh My Zsh ---
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "Oh My Zsh already installed"
else
  info "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ok "Oh My Zsh installed"
fi

# --- zsh-syntax-highlighting plugin ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSH_SH_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
if [[ -d "$ZSH_SH_DIR" ]]; then
  ok "zsh-syntax-highlighting plugin already installed"
else
  info "Installing zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SH_DIR"
  ok "zsh-syntax-highlighting plugin installed"
fi

# --- TPM (Tmux Plugin Manager) ---
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
  ok "TPM already installed"
else
  info "Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  ok "TPM installed"
fi

# --- Backup existing configs before stowing ---
STOW_PACKAGES=(tmux zsh nvim starship lazygit alacritty-mac)

# Target paths relative to $HOME for each stow package
STOW_TARGETS=(
  ".tmux.conf"
  ".zshrc"
  ".config/nvim"
  ".config/starship"
  ".config/lazygit"
  ".config/alacritty"
)

backup_needed=false
for target_rel in "${STOW_TARGETS[@]}"; do
  target="$HOME/$target_rel"
  if [[ -e "$target" && ! -L "$target" ]]; then
    backup_needed=true
    break
  fi
done

if $backup_needed; then
  info "Backing up existing configs to $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
  for target_rel in "${STOW_TARGETS[@]}"; do
    target="$HOME/$target_rel"
    if [[ -e "$target" && ! -L "$target" ]]; then
      target_dir="$(dirname "$target_rel")"
      mkdir -p "$BACKUP_DIR/$target_dir"
      mv "$target" "$BACKUP_DIR/$target_rel"
      warn "Backed up $target_rel"
    fi
  done
  ok "Backups saved to $BACKUP_DIR"
fi

# Remove existing symlinks that might point elsewhere
for target_rel in "${STOW_TARGETS[@]}"; do
  target="$HOME/$target_rel"
  if [[ -L "$target" ]]; then
    rm "$target"
  fi
done

# --- Stow ---
info "Stowing packages..."
cd "$DOTFILES_DIR"
for pkg in "${STOW_PACKAGES[@]}"; do
  stow "$pkg"
  ok "Stowed $pkg"
done

# --- Done ---
echo ""
ok "macOS setup complete!"
echo ""
info "Next steps:"
echo "  1. Restart your terminal (or run: source ~/.zshrc)"
echo "  2. Open tmux and press prefix + I to install tmux plugins"
echo "  3. Open nvim — Lazy will auto-install plugins on first launch"
