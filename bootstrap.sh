#!/usr/bin/env bash

# dotfiles/bootstrap.sh
# Bootstrap script for setting up Nix and home-manager environment

set -e

echo "Starting bootstrap process..."

# Check for Nix installation
if ! command -v nix &> /dev/null; then
  echo "Nix not found. Installing Nix package manager..."
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
  export NIX_PATH="$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH"
else
  echo "Nix is already installed."
fi

# Source Nix profile if available
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Install home-manager if not present
if ! command -v home-manager &> /dev/null; then
  echo "home-manager not found. Installing home-manager..."
  nix-shell '<nixpkgs>' -A home-manager -p home-manager --run "home-manager install"
  echo "home-manager installed."
else
  echo "home-manager is already installed."
fi

# Activate home-manager configuration (non-destructive)
if [ -f "$HOME/.config/home-manager/home.nix" ] || [ -f "$HOME/.config/home-manager/home.nix" ]; then
  echo "Activating home-manager configuration..."
  home-manager switch -f "$(dirname "$0")/home/home.nix"
else
  echo "No existing home-manager configuration found in \$HOME/.config/home-manager."
  echo "You may need to symlink or copy your dotfiles/home/home.nix to ~/.config/home-manager/home.nix"
  echo "Or run: home-manager switch -f $(dirname "$0")/home/home.nix"
fi

echo "Bootstrap process complete. Please restart your shell for all changes to take effect."