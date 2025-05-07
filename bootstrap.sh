#!/usr/bin/env bash

# dotfiles/bootstrap.sh
# Bootstrap script for setting up Nix and home-manager environment

set -e

echo "Starting bootstrap process..."

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

# Install and activate home-manager using flakes
echo "Activating home-manager configuration for $flake_output..."
nix run github:nix-community/home-manager -- switch --flake "$PWD/home#$flake_output"

echo "Bootstrap process complete. Please restart your shell for all changes to take effect."