#!/usr/bin/env bash

# dotfiles/bootstrap.sh
# Bootstrap script for setting up Nix and home-manager environment

set -e

echo "Starting bootstrap process..."

# Ensure user's nix.conf enables nix-command and flakes
NIX_CONF="$HOME/.config/nix/nix.conf"
mkdir -p "$(dirname "$NIX_CONF")"
if grep -q '^experimental-features.*nix-command.*flakes' "$NIX_CONF" 2>/dev/null; then
  echo "nix-command and flakes already enabled in $NIX_CONF"
else
  if grep -q '^experimental-features' "$NIX_CONF" 2>/dev/null; then
    # Update existing line
    sed -i.bak '/^experimental-features/ s|$| nix-command flakes|' "$NIX_CONF"
  else
    # Add new line
    echo "experimental-features = nix-command flakes" >> "$NIX_CONF"
  fi
  echo "Enabled nix-command and flakes in $NIX_CONF"
fi

# Check for Nix installation
if ! command -v nix &> /dev/null; then
  echo "Nix not found. Installing Nix package manager..."
  sh <(curl -L https://nixos.org/nix/install)
  export NIX_PATH="$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH"
else
  echo "Nix is already installed."
fi

# Source Nix profile if available
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Detect system for flake output
case "$(uname -s)" in
  Linux*)   system="x86_64-linux";;
  Darwin*)
    arch="$(uname -m)"
    if [ "$arch" = "arm64" ]; then
      system="aarch64-darwin"
    else
      system="x86_64-darwin"
    fi
    ;;
  *) echo "Unsupported OS"; exit 1;;
esac

flake_output="${system}-default"

# Detect username and home directory for Home Manager
detected_username="$(id -un)"
detected_homedir="$HOME"

echo "Detected username: $detected_username"
echo "Detected home directory: $detected_homedir"

# Install and activate home-manager using flakes, passing username and homeDirectory
echo "Activating home-manager configuration for $flake_output..."
nix run github:nix-community/home-manager -- switch --flake "$PWD/home#$flake_output" --impure --extra-experimental-features 'nix-command flakes' --option extra-experimental-features 'nix-command flakes' --override-input home.username "$detected_username" --override-input home.homeDirectory "$detected_homedir"

echo "Bootstrap process complete. Please restart your shell for all changes to take effect."