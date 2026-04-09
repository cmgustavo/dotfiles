#!/bin/bash
# install.sh — Bootstrap dotfiles on a new machine.
# Run from the repo root: bash install.sh
#
# Safe to re-run at any time:
#   - Brew packages are skipped if already installed.
#   - Symlinks are skipped if they already point to the right target.
#   - Existing files/dirs that are NOT from this repo are backed up
#     to ~/.dotfiles_backup/<timestamp>/ before being replaced.
set -e

DOTFILES="$HOME/GitHub/dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# --- Helpers ---

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }

# link <repo-relative-path> <destination>
#
# Creates a symlink <destination> → $DOTFILES/<repo-relative-path>.
# Behavior:
#   - Already correct symlink → skip (no-op).
#   - Symlink pointing elsewhere → replace with correct target.
#   - Real file or directory    → back up, then replace with symlink.
#   - Does not exist            → create symlink.
link() {
  local src="$DOTFILES/$1"
  local dst="$2"

  # Already a symlink pointing to the right place — nothing to do.
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    ok "$dst (already linked)"
    return
  fi

  # Real file or directory (not a symlink) — back it up first.
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    warn "Backed up existing $dst → $BACKUP_DIR/$(basename "$dst")"
  fi

  # Stale symlink pointing elsewhere — remove it.
  if [ -L "$dst" ]; then
    rm "$dst"
  fi

  ln -s "$src" "$dst"
  ok "$dst"
}

# brew_install <formula> [formula...]
# Installs only the packages that are not already present.
brew_install() {
  local to_install=()
  for pkg in "$@"; do
    if brew list --formula "$pkg" &>/dev/null; then
      ok "$pkg (already installed)"
    else
      to_install+=("$pkg")
    fi
  done
  if [ ${#to_install[@]} -gt 0 ]; then
    brew install "${to_install[@]}"
  fi
}

# brew_cask_install <cask> [cask...]
# Installs only the casks that are not already present.
brew_cask_install() {
  local to_install=()
  for pkg in "$@"; do
    if brew list --cask "$pkg" &>/dev/null; then
      ok "$pkg (already installed)"
    else
      to_install+=("$pkg")
    fi
  done
  if [ ${#to_install[@]} -gt 0 ]; then
    brew install --cask "${to_install[@]}"
  fi
}

# --- CLI tools (Homebrew) ---
# neovim    — primary editor
# ripgrep   — fast grep, used by fzf.vim and Neovim pickers
# fzf       — fuzzy finder (vim plugin + shell integration)
# node      — required by Copilot and some LSP servers
# bat       — cat with syntax highlighting (used by fzf preview)
# lazygit   — terminal UI for git
# git-delta — syntax-highlighted diffs (used by lazygit)
echo "Installing CLI tools..."
brew_install neovim ripgrep fzf node bat lazygit git-delta

# --- GUI apps (Homebrew Cask) ---
# iterm2                        — terminal emulator
# font-jetbrains-mono-nerd-font — font used in iTerm2 and editors
echo "Installing GUI apps and fonts..."
brew_cask_install iterm2 font-jetbrains-mono-nerd-font

# --- Directories ---
# ~/.vim/backup — used for Vim swap, backup, and undo files
mkdir -p ~/.config ~/.vim/backup
ok "Directories"

# --- Neovim ---
link nvim ~/.config/nvim

# --- Vim ---
link vimrc ~/.vimrc

# --- Tmux ---
link tmux.conf ~/.tmux.conf

# --- EditorConfig ---
link editorconfig ~/.editorconfig

# --- lazygit ---
mkdir -p ~/.config/lazygit
link lazygit/config.yml ~/.config/lazygit/config.yml

echo ""
echo "Done."
echo "  • Open Vim/Neovim and run :PlugInstall to install plugins."
echo "  • In iTerm2: Preferences → Profiles → Colors → import the Catppuccin Mocha theme."
echo "  • In iTerm2: Preferences → Profiles → Text → set font to JetBrainsMono Nerd Font Mono."
